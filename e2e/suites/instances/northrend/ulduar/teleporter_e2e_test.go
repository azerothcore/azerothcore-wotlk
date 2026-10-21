//go:build e2e

package ulduar_test

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	goUlduarTeleporter = uint32(194569)

	cmsgGossipSelectOption = uint16(0x17C)
	smsgGossipMessage      = uint16(0x17D)

	// The Base Camp option shows once Flame Leviathan is past NOT_STARTED (conditions, gossip menu 10389).
	teleBaseCampOption = "Teleport to the Expedition Base Camp."
	teleEncounterFL    = 0
	teleStateDone      = 3
)

// Expedition Base Camp Teleport (64014) lands here (spell_target_position).
var teleBaseCampDest = e2eharness.Position3{X: -706.122, Y: -92.602, Z: 430.27, Map: e2eharness.MapUlduar}

// gossipOption is one item of an SMSG_GOSSIP_MESSAGE.
type gossipOption struct {
	index uint32
	text  string
}

// decodeGossipMessage reads the menu id and options of an SMSG_GOSSIP_MESSAGE sent for sender.
func decodeGossipMessage(data []byte, sender uint64) (menuID uint32, options []gossipOption, ok bool) {
	if len(data) < 20 || binary.LittleEndian.Uint64(data) != sender {
		return 0, nil, false
	}
	menuID = binary.LittleEndian.Uint32(data[8:])
	count := binary.LittleEndian.Uint32(data[16:])
	rest := data[20:]
	cstring := func() (string, bool) {
		end := bytes.IndexByte(rest, 0)
		if end < 0 {
			return "", false
		}
		s := string(rest[:end])
		rest = rest[end+1:]
		return s, true
	}
	for i := uint32(0); i < count; i++ {
		// index u32, icon u8, coded u8, box money u32, text, box text
		if len(rest) < 10 {
			return 0, nil, false
		}
		index := binary.LittleEndian.Uint32(rest)
		rest = rest[10:]
		text, okText := cstring()
		_, okBox := cstring()
		if !okText || !okBox {
			return 0, nil, false
		}
		options = append(options, gossipOption{index: index, text: text})
	}
	return menuID, options, true
}

// openGossip uses a gossip GameObject and returns the menu it answers with.
func openGossip(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64) (uint32, []gossipOption) {
	t.Helper()
	var (
		mu      sync.Mutex
		menuID  uint32
		options []gossipOption
		once    sync.Once
	)
	done := make(chan struct{})
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != smsgGossipMessage {
			return
		}
		id, opts, ok := decodeGossipMessage(data, guid)
		if !ok {
			return
		}
		mu.Lock()
		menuID, options = id, opts
		mu.Unlock()
		once.Do(func() { close(done) })
	})
	defer cancel()

	bot.GameObjectUse(t, guid)
	select {
	case <-done:
	case <-time.After(10 * time.Second):
		e2eharness.Preconditionf(t, "no SMSG_GOSSIP_MESSAGE from teleporter 0x%X", guid)
	}
	mu.Lock()
	defer mu.Unlock()
	return menuID, options
}

// Since PR #26152 (https://github.com/azerothcore/azerothcore-wotlk/pull/26152) the Ulduar
// Teleporter casts its teleport spell itself instead of through a summoned trigger creature.
// A GameObject has no collision height, so line of sight to the player was measured from the
// teleporter's floor position, and where that ray crosses the WMO floor the spell failed with
// SPELL_FAILED_LINE_OF_SIGHT: the gossip opened but picking a destination did nothing.
//
// Oracle: choosing the Expedition Base Camp from each teleporter players reported moves the
// player to 64014's spell_target_position.
func TestUlduar_TeleporterGossipTeleportsPlayer(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "instances", "spells"},
		Runtime:  "short",
		Category: "instances/northrend/ulduar",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "UldTele", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80,
	})

	// Stay GM through the raid enter (.go xyz onto 603 is ignored after .gm off).
	bot.Teleport(t, teleBaseCampDest.X, teleBaseCampDest.Y, teleBaseCampDest.Z, teleBaseCampDest.Map)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "not in Ulduar after tele map=%d", m)
	}
	// A game master is invisible to the teleporter, so its spell could never target one.
	bot.GM(t, ".gm off")
	bot.FlushWorld(t)

	for _, tele := range []struct {
		name    string
		spawnID uint32
		x, y, z float32
	}{
		{"PrisonOfYoggSaron", 34923, 1854.82, -11.5608, 334.175},
		{"ShatteredWalkway", 34219, 1859.65, -24.9121, 448.811},
		{"Antechamber", 34935, 1498.05, -24.3509, 420.966},
	} {
		t.Run(tele.name, func(t *testing.T) {
			bot.Teleport(t, tele.x, tele.y, tele.z+0.5, e2eharness.MapUlduar)

			var guid uint64
			for deadline := time.Now().Add(10 * time.Second); guid == 0; {
				guid = bot.World.FindGameObjectByEntry(goUlduarTeleporter, 5)
				if guid == 0 && time.Now().After(deadline) {
					e2eharness.Preconditionf(t, "teleporter spawn %d not in the object cache", tele.spawnID)
				}
				time.Sleep(100 * time.Millisecond)
			}
			if bot.UnitInCombat(bot.World.CharGUID()) {
				e2eharness.Preconditionf(t, "bot in combat at teleporter spawn %d, the teleport spells refuse it", tele.spawnID)
			}

			// Flame Leviathan falls back to NOT_STARTED once nobody is near him, so set him DONE here.
			bot.GM(t, fmt.Sprintf(".instance setbossstate %d %d", teleEncounterFL, teleStateDone))
			bot.FlushWorld(t)

			menuID, options := openGossip(t, bot, guid)
			var option *gossipOption
			for i := range options {
				if options[i].text == teleBaseCampOption {
					option = &options[i]
				}
			}
			if option == nil {
				e2eharness.Preconditionf(t, "teleporter spawn %d menu %d offers no Base Camp option: %+v",
					tele.spawnID, menuID, options)
			}
			t.Logf("teleporter spawn %d guid=0x%X menu=%d option=%d", tele.spawnID, guid, menuID, option.index)

			req := make([]byte, 16)
			binary.LittleEndian.PutUint64(req, guid)
			binary.LittleEndian.PutUint32(req[8:], menuID)
			binary.LittleEndian.PutUint32(req[12:], option.index)
			before := bot.World.TeleportSeq()
			if err := bot.World.SendPacketRaw(cmsgGossipSelectOption, req); err != nil {
				e2eharness.HarnessFailf(t, "sending CMSG_GOSSIP_SELECT_OPTION: %v", err)
			}
			if err := bot.World.WaitForTeleportAfter(before, 10*time.Second); err != nil {
				e2eharness.Assertf(t, "teleporter spawn %d: picking the Base Camp did not teleport the player: %v",
					tele.spawnID, err)
			}

			x, y, z, m := bot.Pos()
			dist := e2eharness.Distance3D(x, y, z, teleBaseCampDest.X, teleBaseCampDest.Y, teleBaseCampDest.Z)
			if m != teleBaseCampDest.Map || dist > 5 {
				e2eharness.Assertf(t, "teleporter spawn %d: landed at (%.1f, %.1f, %.1f) map %d, %.1fy from the Base Camp",
					tele.spawnID, x, y, z, m, dist)
			}
			t.Logf("PASS teleporter spawn %d sent the player to the Base Camp (%.1fy off)", tele.spawnID, dist)
		})
	}
}
