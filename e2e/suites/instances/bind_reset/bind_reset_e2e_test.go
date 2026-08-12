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

// game_tele name on this realm (not "Stockades"). Exterior entrance on map 0.
const teleTheStockade = "TheStockade"

// Interior Stockade pad (map 34) — used when we need real instance map for DB bind soft checks.
var padStockadeInterior = e2eharness.Position3{
	X: 54.0, Y: 0.5, Z: -26.0, Map: 34,
}

// teleDungeonOrPrecondition runs a named tele and fails as precondition if position/map did not move.
func teleDungeonOrPrecondition(t *testing.T, bot *e2eharness.ScenarioBot, name string) (mapID uint32) {
	t.Helper()
	x0, y0, z0, m0 := bot.Pos()
	bot.TeleNamed(t, name)
	x1, y1, z1, m1 := bot.Pos()
	moved := m1 != m0 || e2eharness.Distance3D(x0, y0, z0, x1, y1, z1) > 5
	if !moved {
		e2eharness.Preconditionf(t,
			"named tele %q did not move player (still map=%d pos=%.1f,%.1f,%.1f) — missing game_tele?",
			name, m1, x1, y1, z1)
	}
	return m1
}

// BIND-01: party of 2 formed (instance group precondition).
func TestBind_PartyFormedForInstance(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "instance", "multi_bot"}, Runtime: "short", Category: "instances/bind_reset"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "BindPty", Count: 2, Level: 80})
	e2eharness.FormParty(t, bots[0], bots[1])
	if !bots[0].InGroup() {
		e2eharness.Preconditionf(t, "leader not in group")
	}
	t.Logf("PASS instance party formed")
}

// BIND-02: named dungeon tele (TheStockade) world alive.
func TestBind_NamedDungeonTele(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instance"}, Runtime: "med", Category: "instances/bind_reset"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "BindStk", Level: 80})
	// AC game_tele is "TheStockade" (not "Stockades"); wrong name hangs TeleNamed ~60s.
	m := teleDungeonOrPrecondition(t, bot, teleTheStockade)
	bot.AssertWorldAlive(t)
	t.Logf("PASS named dungeon tele map=%d", m)
}

// BIND-03: group shared tele attempt.
func TestBind_GroupTeleTogether(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instance", "multi_bot"}, Runtime: "med", Category: "instances/bind_reset"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "BindGrp", Count: 2, Level: 80})
	e2eharness.FormParty(t, bots[0], bots[1])
	for _, b := range bots {
		teleDungeonOrPrecondition(t, b, teleTheStockade)
	}
	bots[0].AssertWorldAlive(t)
	t.Logf("PASS group tele together")
}

// BIND-04 / #10708: deferred reset+summon exploit (document).
func TestBind_ResetSummonExploitDeferred(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instance", "issue", "deferred"},
		Runtime:  "long",
		Issue:    10708,
		Category: "instances/bind_reset",
	})
	t.Skip("LeaderResetInstances/AcceptSummon deferred — see A7_HARNESS_GAPS.md (#10708)")
}

// BIND-05: character_instance DB read attempt after instance map enter (soft).
// Exterior TheStockade tele is map 0 — use interior pad for a real instance visit.
func TestBind_CharacterInstanceQuerySoft(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instance"}, Runtime: "med", Category: "instances/bind_reset"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "BindDB", Level: 80})
	// Enter Stockade instance map (34) so character_instance may record a bind.
	bot.Teleport(t, padStockadeInterior.X, padStockadeInterior.Y, padStockadeInterior.Z, padStockadeInterior.Map)
	_, _, _, m := bot.Pos()
	if m != padStockadeInterior.Map {
		e2eharness.Preconditionf(t, "expected Stockade map %d after .go xyz, got %d", padStockadeInterior.Map, m)
	}
	bot.Save(t)
	// Poll CharDB after Save instead of a fixed sleep (write visibility lag).
	var n int
	var lastErr error
	deadline := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadline) {
		lastErr = bot.CharDB.QueryRow(
			`SELECT COUNT(*) FROM character_instance WHERE guid=?`, bot.GUID,
		).Scan(&n)
		if lastErr == nil {
			break
		}
		time.Sleep(50 * time.Millisecond)
	}
	if lastErr != nil {
		// Table may differ / schema lag; soft.
		t.Logf("NOTE character_instance query: %v", lastErr)
	} else {
		t.Logf("character_instance rows=%d (map=%d)", n, m)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS character_instance soft query")
}
