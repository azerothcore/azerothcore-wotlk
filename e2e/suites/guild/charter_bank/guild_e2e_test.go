//go:build e2e

package charter_bank_test

import (
	"database/sql"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// GUILD-01: charter buy + full turn-in via harness CreateGuildViaCharter (SetupGuildLeader).
func TestGuild_CharterBuy(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "guild"}, Runtime: "med", Category: "guild/charter_bank"})

	leader, setup, charDB := e2eharness.SetupGuildLeader(t, "GldBuy")
	if leader == nil || leader.GUID == 0 {
		e2eharness.Preconditionf(t, "guild leader setup failed")
	}
	if setup.GuildName == "" {
		e2eharness.Assertf(t, "SetupGuildLeader returned empty guild name (charter turn-in incomplete)")
	}
	if setup.PetitionGUID == 0 && setup.ItemLow == 0 {
		e2eharness.Assertf(t, "SetupGuildLeader missing petition identity (charter buy incomplete)")
	}
	// guild_member insert is async (CharacterDatabase worker) after TURN_IN OK.
	guid := leader.GUID & 0xffffffff
	var guildID uint32
	deadline := time.Now().Add(10 * time.Second)
	var err error
	for time.Now().Before(deadline) {
		err = charDB.QueryRow(`SELECT guildid FROM guild_member WHERE guid=?`, guid).Scan(&guildID)
		if err == nil && guildID != 0 {
			break
		}
		err = charDB.QueryRow(`SELECT guildid FROM guild WHERE leaderguid=?`, guid).Scan(&guildID)
		if err == nil && guildID != 0 {
			break
		}
		time.Sleep(50 * time.Millisecond)
	}
	if guildID == 0 {
		if err != nil && err != sql.ErrNoRows {
			e2eharness.Assertf(t, "leader not in guild_member/guild after charter turn-in: err=%v guid=%d", err, guid)
		} else {
			e2eharness.Assertf(t, "leader not in guild_member/guild after charter turn-in (no row) guid=%d", guid)
		}
	}
	t.Logf("PASS charter buy+turn-in guild=%q id=%d leader=%d petition=0x%X",
		setup.GuildName, guildID, leader.GUID, setup.PetitionGUID)
}

// GUILD-03: multi-bot login for charter signs precondition.
func TestGuild_MultiBotLogin(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "guild", "multi_bot"}, Runtime: "med", Category: "guild/charter_bank"})

	idents := e2eharness.MakeBotIdents("GldSign", 3)
	auth, char := e2eharness.OpenTestDBs(t)
	e2eharness.EnsureBotAccounts(t, auth, idents)
	_ = char
	sessions := e2eharness.LoginAllianceBots(t, idents)
	if len(sessions) != 3 {
		e2eharness.Preconditionf(t, "want 3 sessions, got %d", len(sessions))
	}
	t.Logf("PASS multi-bot guild login n=%d", len(sessions))
}

// GUILD-04: ModMoney for charter cost.
func TestGuild_MoneyForCharter(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "guild"}, Runtime: "short", Category: "guild/charter_bank"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "GldMny", Level: 20})
	want := uint32(e2eharness.GuildCharterCostCopper + 1_000_000)
	bot.ModMoney(t, want)
	bot.AssertMoneyAtLeast(t, want)
	t.Logf("PASS money for charter cost=%d", e2eharness.GuildCharterCostCopper)
}
