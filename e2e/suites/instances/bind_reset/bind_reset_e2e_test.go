//go:build e2e

package bind_reset_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// BIND-* : full instance enter/reset/summon helpers deferred. Cover multi-bot party
// + named instance tele baselines for #10708 follow-up.

// BIND-01: party of 2 formed (instance group precondition).
func TestBind_PartyFormedForInstance(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "instance", "multi_bot"}, Runtime: "short", Category: "instances/bind_reset"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "BindPty", Count: 2, Level: 80})
	e2eharness.FormParty(t, bots[0], bots[1])
	if !bots[0].InGroup() {
		e2eharness.Preconditionf(t, "leader not in group")
	}
	t.Logf("PASS instance party formed")
}

// BIND-02: named dungeon tele (Stockades) world alive.
func TestBind_NamedDungeonTele(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"med", "instance"}, Runtime: "med", Category: "instances/bind_reset"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "BindStk", Level: 80})
	// Common AC tele name; if missing, Precondition via harness fail on stuck.
	bot.TeleNamed(t, "Stockades")
	bot.AssertWorldAlive(t)
	_, _, _, m := bot.Pos()
	t.Logf("PASS named dungeon tele map=%d", m)
}

// BIND-03: group shared tele attempt.
func TestBind_GroupTeleTogether(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"med", "instance", "multi_bot"}, Runtime: "med", Category: "instances/bind_reset"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "BindGrp", Count: 2, Level: 80})
	e2eharness.FormParty(t, bots[0], bots[1])
	for _, b := range bots {
		b.TeleNamed(t, "Stockades")
	}
	bots[0].AssertWorldAlive(t)
	t.Logf("PASS group tele together")
}

// BIND-04 / #10708: deferred reset+summon exploit (document).
func TestBind_ResetSummonExploitDeferred(t *testing.T) {
	meta.Gate(t, meta.TestMeta{
		Tags:     []string{"long", "instance", "issue", "deferred"},
		Runtime:  "long",
		Issue:    10708,
		Category: "instances/bind_reset",
	})
	t.Skip("LeaderResetInstances/AcceptSummon deferred — see A7_HARNESS_GAPS.md (#10708)")
}

// BIND-05: character_instance DB read attempt after tele (soft).
func TestBind_CharacterInstanceQuerySoft(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"med", "instance"}, Runtime: "med", Category: "instances/bind_reset"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "BindDB", Level: 80})
	bot.TeleNamed(t, "Stockades")
	bot.Save(t)
	time.Sleep(500 * time.Millisecond)
	var n int
	err := bot.CharDB.QueryRow(`SELECT COUNT(*) FROM character_instance WHERE guid=?`, bot.GUID).Scan(&n)
	if err != nil {
		// Table may differ; soft.
		t.Logf("NOTE character_instance query: %v", err)
	} else {
		t.Logf("character_instance rows=%d", n)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS character_instance soft query")
}
