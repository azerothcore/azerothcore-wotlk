//go:build e2e

package trial_of_the_crusader_test

import (
	"bytes"
	"encoding/binary"
	"strconv"
	"strings"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/28443
// Follow-up of https://github.com/azerothcore/azerothcore-wotlk/issues/28349, fixed by
// https://github.com/azerothcore/azerothcore-wotlk/pull/28390 (conditions on gossip menu 10704).
//
// A Call of the Crusade of either raid size unlocks the Trial of the Grand Crusader on both
// heroic sizes: Barrett Ramsey must offer "I have completed the Trial of the Crusader." to a
// player who cleared the 10 player Trial while that player is in the 25 player heroic instance
// (and the other way around), and the option must lead to the menu that starts the encounter.
// The old conditions ANDed each achievement with the heroic spawn mask of the same size, so the
// option was only offered on the size the player had cleared (issues 28349 / 28443).
//
// Without a Call of the Crusade the option must stay hidden on both sizes and only the refusal
// line may be offered.

const (
	// Gossip menus of Barrett Ramsey (creature 35909, gossip_menu_option/gossip_menu rows).
	togcMenuComplete   = uint32(10704) // "I have completed..." / "I have not completed..." / retry
	togcMenuPrepared   = uint32(10706) // "Yes. We are prepared for the challenges ahead of us."
	togcMenuBeginFirst = uint32(10600) // "Bring forth the first challenge!"

	togcMap = uint32(649) // Trial of the Crusader / Trial of the Grand Crusader

	// Barrett Ramsey: the heroic instance uses 35909, the normal one uses 34816.
	togcBarrettHeroic = uint32(35909)
	togcBarrettNormal = uint32(34816)
	togcGormok        = uint32(34796)

	togcAchievementCall10 = uint32(3917) // Call of the Crusade (10 player)
	togcAchievementCall25 = uint32(3916) // Call of the Crusade (25 player)

	// Locs[LOC_BARRETT] in trial_of_the_crusader.h and the arena centre.
	togcBarrettX, togcBarrettY, togcBarrettZ = float32(559.15), float32(90.56), float32(395.27)
	togcArenaX, togcArenaY, togcArenaZ       = float32(563.8), float32(140.0), float32(394.6)

	// RAID_DIFFICULTY_* from src/server/shared/DataStores/DBCEnums.h.
	togcDifficulty10Heroic = uint32(2)
	togcDifficulty25Heroic = uint32(3)
)

// Opcodes from src/server/game/Server/Protocol/Opcodes.h. The harness has no gossip helper and
// no raid difficulty setter, so this test drives both with raw packets.
const (
	opCMSGGossipHello      = uint16(0x17B)
	opCMSGGossipSelect     = uint16(0x17C)
	opSMSGGossipMessage    = uint16(0x17D)
	opSMSGGossipComplete   = uint16(0x17E)
	opMSGSETRAIDDIFFICULTY = uint16(0x4EB)
)

const (
	togcCompleteText = "I have completed the Trial of the Crusader."
	// Once the start option is picked Barrett leaves and the intro runs: Gormok is summoned
	// about 36s later, which is the last step of "the encounter can be started".
	togcGormokTimeout = 90 * time.Second
	togcMenuTimeout   = 10 * time.Second
)

func TestAC_28443_ToGCStartUnlockedByEitherCallOfTheCrusade(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags: []string{"med", "issue"}, Runtime: "med",
		Issue: 28443, Category: "instances/trial_of_the_crusader",
	})

	// The whole condition matrix of gossip menu 10704: both heroic sizes, with neither, with the
	// 10 player and with the 25 player Call of the Crusade. The cross-size pairs are the
	// regression this issue is about; the same-size pairs and the two without an achievement are
	// the guards against over-correcting the conditions.
	cases := []struct {
		name        string
		achievement uint32
		difficulty  uint32
	}{
		{"no_achievement_10man_heroic", 0, togcDifficulty10Heroic},
		{"no_achievement_25man_heroic", 0, togcDifficulty25Heroic},
		{"call10_10man_heroic", togcAchievementCall10, togcDifficulty10Heroic},
		{"call10_25man_heroic", togcAchievementCall10, togcDifficulty25Heroic},
		{"call25_10man_heroic", togcAchievementCall25, togcDifficulty10Heroic},
		{"call25_25man_heroic", togcAchievementCall25, togcDifficulty25Heroic},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			runToGCUnlock(t, tc.achievement, tc.difficulty)
		})
	}
}

// runToGCUnlock grants achievement (when non-zero), enters the heroic Trial of the Grand Crusader
// of the given raid size and drives Barrett Ramsey's gossip: with a Call of the Crusade it follows
// the option chain through the "bring forth the first challenge" menu and waits for the pull.
func runToGCUnlock(t *testing.T, achievement, raidDifficulty uint32) {
	t.Helper()

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Togc", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})
	if achievement != 0 {
		grantAchievement(t, bot, achievement)
	}
	setRaidDifficulty(t, bot, raidDifficulty)
	barrett := enterToGC(t, bot)

	menu := togcOpenGossip(t, bot, barrett)
	t.Logf("achievement=%d raidDifficulty=%d barrett=%d -> menu %d with %d option(s)",
		achievement, raidDifficulty, barrett, menu.MenuID, len(menu.Options))
	for _, option := range menu.Options {
		t.Logf("  option %d: %q", option.ID, option.Text)
	}
	if menu.MenuID != togcMenuComplete {
		e2eharness.Preconditionf(t, "Barrett opened menu %d, want %d", menu.MenuID, togcMenuComplete)
	}

	completed := menu.option(0, togcCompleteText)
	if achievement == 0 {
		if completed != nil {
			e2eharness.Assertf(t, "Barrett offers %q without Call of the Crusade", togcCompleteText)
		}
		if menu.option(1, "I have not completed") == nil {
			e2eharness.Assertf(t, "Barrett does not offer the refusal line without Call of the Crusade")
		}
		t.Log("PASS: no Call of the Crusade -> only the refusal line, encounter cannot be started")
		return
	}
	if completed == nil {
		e2eharness.ConfirmedBugf(t, 28443,
			"Call of the Crusade %d does not unlock the Trial of the Grand Crusader on raid"+
				" difficulty %d: %q missing from menu %d",
			achievement, raidDifficulty, togcCompleteText, menu.MenuID)
	}
	// 10704/0 -> 10706 ("We are prepared") -> 10600 ("Bring forth the first challenge") -> start.
	prepared := togcSelectOption(t, bot, barrett, togcMenuComplete, 0)
	if prepared == nil || prepared.MenuID != togcMenuPrepared {
		e2eharness.ConfirmedBugf(t, 28443, "%q did not lead to menu %d (got %s)",
			togcCompleteText, togcMenuPrepared, description(prepared))
	}
	begin := togcSelectOption(t, bot, barrett, togcMenuPrepared, 0)
	if begin == nil || begin.MenuID != togcMenuBeginFirst {
		e2eharness.ConfirmedBugf(t, 28443, "menu %d did not lead to menu %d (got %s)",
			togcMenuPrepared, togcMenuBeginFirst, description(begin))
	}
	if after := togcSelectOption(t, bot, barrett, togcMenuBeginFirst, 0); after != nil && after.MenuID != 0 {
		e2eharness.ConfirmedBugf(t, 28443, "starting the encounter reopened menu %d", after.MenuID)
	}

	// The instance script starts its intro once Barrett's SmartAI reports the gossip; Northrend
	// Beasts' first boss shows up as proof on the player path.
	gormok := waitToGCUnit(t, bot, togcGormok, togcGormokTimeout)
	if gormok == 0 {
		e2eharness.ConfirmedBugf(t, 28443,
			"Call of the Crusade %d passed the gossip gates on raid difficulty %d but the encounter never started",
			achievement, raidDifficulty)
	}
	t.Logf("PASS: Call of the Crusade %d starts the Trial of the Grand Crusader on raid difficulty %d (Gormok 0x%X)",
		achievement, raidDifficulty, gormok)
}

// grantAchievement gives the bot a Call of the Crusade. AchievementMgr::CompletedAchievement
// refuses to run in GM mode, so GM is dropped for the command and restored afterwards.
func grantAchievement(t *testing.T, bot *e2eharness.ScenarioBot, achievement uint32) {
	t.Helper()
	bot.GM(t, ".gm off")
	bot.FlushWorld(t)
	bot.GM(t, ".achievement add "+strconv.FormatUint(uint64(achievement), 10))
	bot.FlushWorld(t)
	bot.GM(t, ".gm on")
	bot.FlushWorld(t)
	bot.Save(t)

	deadline := time.Now().Add(10 * time.Second)
	var count int
	for {
		if err := bot.CharDB.QueryRow(
			`SELECT COUNT(*) FROM character_achievement WHERE guid=? AND achievement=?`,
			bot.GUID, achievement).Scan(&count); err != nil {
			e2eharness.HarnessFailf(t, "read character_achievement: %v", err)
		}
		if count > 0 {
			break
		}
		if time.Now().After(deadline) {
			e2eharness.Preconditionf(t, ".achievement add %d did not grant the achievement", achievement)
		}
		time.Sleep(200 * time.Millisecond)
	}
	t.Logf("granted achievement %d", achievement)
}

// setRaidDifficulty sends MSG_SET_RAID_DIFFICULTY; a solo player outside of a dungeon gets it
// applied directly (WorldSession::HandleSetRaidDifficultyOpcode).
func setRaidDifficulty(t *testing.T, bot *e2eharness.ScenarioBot, mode uint32) {
	t.Helper()
	payload := make([]byte, 4)
	binary.LittleEndian.PutUint32(payload, mode)
	if err := bot.World.SendPacketRaw(opMSGSETRAIDDIFFICULTY, payload); err != nil {
		e2eharness.HarnessFailf(t, "send MSG_SET_RAID_DIFFICULTY(%d): %v", mode, err)
	}
	bot.FlushWorld(t)
}

// enterToGC teleports the bot into the Trial of the Grand Crusader of the difficulty set before
// the teleport, and returns the GUID of the heroic Barrett Ramsey. Barrett is summoned by the
// instance script when a fresh instance has no living non-GM player.
func enterToGC(t *testing.T, bot *e2eharness.ScenarioBot) uint64 {
	t.Helper()
	// .go xyz only creates the instance at the difficulty already selected for the player.
	bot.Teleport(t, togcArenaX, togcArenaY, togcArenaZ, togcMap)
	if _, _, _, mapID := bot.Pos(); mapID != togcMap {
		e2eharness.Preconditionf(t, "not in map %d after teleport (map %d)", togcMap, mapID)
	}
	if normal := bot.FindUnit(togcBarrettNormal, 200); normal != 0 {
		e2eharness.Preconditionf(t, "landed in a non-heroic Trial of the Crusader (normal Barrett 0x%X)", normal)
	}
	barrett := waitToGCUnit(t, bot, togcBarrettHeroic, 30*time.Second)
	if barrett == 0 {
		e2eharness.Preconditionf(t, "heroic Barrett Ramsey was never summoned")
	}

	// He walks towards the arena; step next to him so the gossip is in interaction range.
	bot.Teleport(t, togcBarrettX, togcBarrettY, togcBarrettZ, togcMap)
	if again := waitToGCUnit(t, bot, togcBarrettHeroic, 10*time.Second); again == 0 {
		e2eharness.Preconditionf(t, "heroic Barrett Ramsey 0x%X lost after the second teleport", barrett)
	}
	return barrett
}

// ==== gossip plumbing (no harness helper exists) ================================================

type togcGossipOption struct {
	ID   uint32
	Text string
}

type togcGossipMenu struct {
	MenuID  uint32
	TitleID uint32
	Options []togcGossipOption
}

func (m togcGossipMenu) String() string {
	parts := make([]string, 0, len(m.Options))
	for _, option := range m.Options {
		parts = append(parts, strconv.FormatUint(uint64(option.ID), 10)+"="+option.Text)
	}
	return "menu " + strconv.FormatUint(uint64(m.MenuID), 10) + " [" + strings.Join(parts, ", ") + "]"
}

// option returns the option with the given id when its text has the given prefix.
func (m togcGossipMenu) option(id uint32, textPrefix string) *togcGossipOption {
	for i := range m.Options {
		if m.Options[i].ID == id && strings.HasPrefix(m.Options[i].Text, textPrefix) {
			return &m.Options[i]
		}
	}
	return nil
}

func description(m *togcGossipMenu) string {
	if m == nil {
		return "no gossip menu"
	}
	return m.String()
}

// togcOpenGossip sends CMSG_GOSSIP_HELLO and parses the SMSG_GOSSIP_MESSAGE reply.
func togcOpenGossip(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64) togcGossipMenu {
	t.Helper()
	menus := make(chan togcGossipMenu, 4)
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != opSMSGGossipMessage {
			return
		}
		menu, ok := parseToGCGossip(data)
		if !ok {
			return
		}
		select {
		case menus <- menu:
		default:
		}
	})
	defer cancel()

	payload := make([]byte, 8)
	binary.LittleEndian.PutUint64(payload, guid)
	if err := bot.World.SendPacketRaw(opCMSGGossipHello, payload); err != nil {
		e2eharness.HarnessFailf(t, "send CMSG_GOSSIP_HELLO: %v", err)
	}
	select {
	case menu := <-menus:
		return menu
	case <-time.After(togcMenuTimeout):
		e2eharness.HarnessFailf(t, "no SMSG_GOSSIP_MESSAGE from 0x%X within %s", guid, togcMenuTimeout)
	}
	return togcGossipMenu{}
}

// togcSelectOption sends CMSG_GOSSIP_SELECT_OPTION and returns the menu the server answers with,
// or nil when it only sends SMSG_GOSSIP_COMPLETE (no menu is opened by the choice).
func togcSelectOption(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64, menuID, optionID uint32) *togcGossipMenu {
	t.Helper()
	menus := make(chan togcGossipMenu, 4)
	closed := make(chan struct{}, 1)
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		switch opcode {
		case opSMSGGossipMessage:
			if menu, ok := parseToGCGossip(data); ok {
				select {
				case menus <- menu:
				default:
				}
			}
		case opSMSGGossipComplete:
			select {
			case closed <- struct{}{}:
			default:
			}
		}
	})
	defer cancel()

	payload := make([]byte, 16)
	binary.LittleEndian.PutUint64(payload[0:], guid)
	binary.LittleEndian.PutUint32(payload[8:], menuID)
	binary.LittleEndian.PutUint32(payload[12:], optionID)
	if err := bot.World.SendPacketRaw(opCMSGGossipSelect, payload); err != nil {
		e2eharness.HarnessFailf(t, "send CMSG_GOSSIP_SELECT_OPTION(%d/%d): %v", menuID, optionID, err)
	}
	select {
	case menu := <-menus:
		return &menu
	case <-closed:
		return nil
	case <-time.After(togcMenuTimeout):
		t.Logf("no gossip answer to option %d of menu %d within %s", optionID, menuID, togcMenuTimeout)
		return nil
	}
}

// parseToGCGossip reads SMSG_GOSSIP_MESSAGE as PlayerMenu::SendGossipMenu writes it
// (src/server/game/Entities/Creature/GossipDef.cpp): guid, menu id, title text, option count,
// then per option: id, icon, coded flag, box money, text, box text.
func parseToGCGossip(data []byte) (togcGossipMenu, bool) {
	reader := bytes.NewReader(data)
	var menu togcGossipMenu
	var guid uint64
	var count uint32
	if binary.Read(reader, binary.LittleEndian, &guid) != nil ||
		binary.Read(reader, binary.LittleEndian, &menu.MenuID) != nil ||
		binary.Read(reader, binary.LittleEndian, &menu.TitleID) != nil ||
		binary.Read(reader, binary.LittleEndian, &count) != nil {
		return menu, false
	}
	for i := uint32(0); i < count; i++ {
		var option togcGossipOption
		var icon, coded uint8
		var money uint32
		if binary.Read(reader, binary.LittleEndian, &option.ID) != nil ||
			binary.Read(reader, binary.LittleEndian, &icon) != nil ||
			binary.Read(reader, binary.LittleEndian, &coded) != nil ||
			binary.Read(reader, binary.LittleEndian, &money) != nil {
			return menu, false
		}
		text, err := readToGCString(reader)
		if err != nil {
			return menu, false
		}
		if _, err := readToGCString(reader); err != nil { // box text
			return menu, false
		}
		option.Text = text
		menu.Options = append(menu.Options, option)
	}
	return menu, true
}

// waitToGCUnit polls the client object cache for a living unit of the given entry, first within
// gossip range and then anywhere tracked (a summoned unit can be outside that range).
func waitToGCUnit(t *testing.T, bot *e2eharness.ScenarioBot, entry uint32, timeout time.Duration) uint64 {
	t.Helper()
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if guid := bot.FindUnit(entry, 40); guid != 0 {
			return guid
		}
		if guid := bot.FindUnit(entry, 0); guid != 0 {
			return guid
		}
		time.Sleep(50 * time.Millisecond)
	}
	return 0
}

func readToGCString(reader *bytes.Reader) (string, error) {
	var out []byte
	for {
		c, err := reader.ReadByte()
		if err != nil {
			return string(out), err
		}
		if c == 0 {
			return string(out), nil
		}
		out = append(out, c)
	}
}
