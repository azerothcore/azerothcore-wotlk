//go:build e2e

package charter_bank_test

import (
	"testing"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// GUILD-01: charter buy + full turn-in via harness CreateGuildViaCharter (SetupGuildLeader).
func TestGuild_CharterBuy(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "guild"}, Runtime: "med", Category: "guild/charter_bank"})

	leader, setup, charDB := e2eharness.SetupGuildLeader(t, "GldBuy")
	_ = charDB
	if leader == nil || leader.GUID == 0 {
		e2eharness.Preconditionf(t, "guild leader setup failed")
	}
	if setup.GuildName == "" {
		e2eharness.Assertf(t, "SetupGuildLeader returned empty guild name (charter turn-in incomplete)")
	}
	if setup.PetitionGUID == 0 && setup.ItemLow == 0 {
		e2eharness.Assertf(t, "SetupGuildLeader missing petition identity (charter buy incomplete)")
	}
	// Live guild membership after turn-in.
	var guildID uint32
	err := charDB.QueryRow(`SELECT guildid FROM guild_member WHERE guid=?`, leader.GUID).Scan(&guildID)
	if err != nil || guildID == 0 {
		e2eharness.Assertf(t, "leader not in guild_member after charter turn-in: err=%v guildid=%d", err, guildID)
	}
	t.Logf("PASS charter buy+turn-in guild=%q id=%d leader=%d petition=0x%X",
		setup.GuildName, guildID, leader.GUID, setup.PetitionGUID)
}

// GUILD-02: unique guild name helper.
func TestGuild_UniqueGuildName(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "guild"}, Runtime: "short", Category: "guild/charter_bank"})
	n1 := e2eharness.UniqueGuildName("AcE2E")
	n2 := e2eharness.UniqueGuildName("AcE2E")
	if n1 == "" || n2 == "" {
		e2eharness.Assertf(t, "UniqueGuildName empty n1=%q n2=%q", n1, n2)
	}
	if n1 == n2 {
		e2eharness.Assertf(t, "UniqueGuildName collision n1=%q n2=%q", n1, n2)
	}
	t.Logf("PASS unique guild names %q / %q", n1, n2)
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
	bot.ModMoney(t, e2eharness.GuildCharterCostCopper+1_000_000)
	bot.AssertWorldAlive(t)
	t.Logf("PASS money for charter cost=%d", e2eharness.GuildCharterCostCopper)
}

// GUILD-05: CleanupGuild state helper exists (no-op safe).
func TestGuild_CleanupGuildState(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "guild"}, Runtime: "short", Category: "guild/charter_bank"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "GldCln", Level: 20})
	e2eharness.CleanupSessionsGuildState(t, bot.CharDB, []*e2eharness.Session{bot.Session})
	bot.AssertWorldAlive(t)
	t.Logf("PASS cleanup guild state helper")
}
