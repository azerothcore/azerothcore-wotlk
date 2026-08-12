//go:build e2e

package ulduar_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// Kologarn creature spawn (map 603) is at the bridge; Charge needs ~8–25y standoff.
// Named tele "Kologarn"/"BossKologarn" is ~1770; spawn is ~1797 — place mid-range.
var (
	posKologarnSpawn = e2eharness.Position3{
		X: 1797.15, Y: -24.4027, Z: 448.741, Map: e2eharness.MapUlduar,
	}
	// ~15y west of spawn along +X axis (still on bridge Z).
	posKologarnChargePad = e2eharness.Position3{
		X: 1782.15, Y: -24.4027, Z: 448.741, Map: e2eharness.MapUlduar,
	}
)

// ULDUAR-01 / #26266 pattern: Charge on Kologarn area stays sane (Z/bridge).
// Cast fatals on timeout — use TryCast. Charge needs Battle Stance + range.
func TestUlduar_KologarnChargeWorldAlive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances", "issue"},
		Runtime:  "long",
		Issue:    26266,
		Category: "instances/northrend/ulduar",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "UldKol",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	// Enter Ulduar, then stand off at charge range (not spawn/melee).
	bot.TeleNamed(t, "Kologarn")
	bot.Teleport(t, posKologarnChargePad.X, posKologarnChargePad.Y, posKologarnChargePad.Z, posKologarnChargePad.Map)
	kolo := bot.WaitUnit(t, e2eharness.CreatureKologarn, 30*time.Second)
	// Explicit ranks — learn-all can lag; Charge is rank-sensitive.
	bot.Learn(t, e2eharness.SpellBattleStance)
	bot.Learn(t, e2eharness.SpellCharge)
	bot.CombatReadyFull(t)
	// Stance is a self-aura; GM cast is more reliable under boss aggro than client cast.
	bot.CastSelfGM(t, e2eharness.SpellBattleStance)

	preX, preY, preZ, preM := bot.Pos()
	dist := bot.DistFrom(posKologarnSpawn.X, posKologarnSpawn.Y, posKologarnSpawn.Z)
	t.Logf("pre-charge dist_to_spawn=%.1f pos=(%.1f,%.1f,%.1f) kolo=0x%X", dist, preX, preY, preZ, kolo)
	bot.Face(t, kolo)
	res, err := bot.TryCast(t, e2eharness.SpellCharge, kolo, 12*time.Second)
	if err != nil {
		// No cast-result packet can be hang-class (#26266 pathing); still judge Z + world.
		t.Logf("Charge cast result timeout: %v", err)
	} else if !res.Success {
		t.Logf("Charge fail reason=%s (%d)", e2eharness.SpellFailReasonName(res.FailReason), res.FailReason)
	} else {
		t.Logf("Charge SPELL_GO ok")
	}

	// Poll briefly for movement settle (not a fixed multi-second sleep).
	deadline := time.Now().Add(1500 * time.Millisecond)
	for time.Now().Before(deadline) {
		x, y, z, _ := bot.Pos()
		if e2eharness.Distance3D(preX, preY, preZ, x, y, z) > 1.0 {
			break
		}
		time.Sleep(50 * time.Millisecond)
	}

	x, y, z, m := bot.Pos()
	// Floor-fall oracle: landing far below bridge Z is the #26266 failure mode.
	if z < preZ-20 {
		e2eharness.ConfirmedBugf(t, 26266,
			"Charge landed below bridge: z=%.1f preZ=%.1f pos=(%.1f,%.1f) map=%d (pre map=%d)",
			z, preZ, x, y, m, preM)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS Kologarn charge path map=%d pos=(%.1f,%.1f,%.1f) dz=%.1f ok=%v err=%v",
		m, x, y, z, z-preZ, err == nil && res.Success, err)
}

// ULDUAR-02 / #27095 pattern: Freya allies engage smoke (world alive + unit appear).
func TestUlduar_FreyaEngageSmoke(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances", "issue"},
		Runtime:  "long",
		Issue:    27095,
		Category: "instances/northrend/ulduar",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "UldFry",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleNamed(t, "Freya")
	// Freya entry 32906 used in Ghost examples / constants area.
	const creatureFreya = 32906
	freya := bot.WaitUnit(t, creatureFreya, 45*time.Second)
	bot.CombatReady(t)
	bot.Engage(t, freya, 20*time.Second)
	// Observe early engage via combat flag (Engage already waited for enter-combat).
	bot.WaitUnitCombat(t, freya, 5*time.Second)
	if !bot.UnitInCombat(freya) {
		t.Logf("NOTE freya not in combat after engage window")
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS Freya engage smoke target=0x%X combat=%v", freya, bot.UnitInCombat(freya))
}

// ULDUAR-03: Ulduar map enter via named tele stays in-world.
func TestUlduar_NamedTeleEnter(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instances"}, Runtime: "med", Category: "instances/northrend/ulduar"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "UldEnt",
		Level:  80,
	})
	bot.TeleNamed(t, "Ulduar")
	bot.AssertWorldAlive(t)
	_, _, _, m := bot.Pos()
	t.Logf("PASS Ulduar named tele map=%d (want %d if tele exists)", m, e2eharness.MapUlduar)
}

// ULDUAR-04: engage + DamageKill path on a trash/dummy (raid helper training).
// L1 Target Dummy (2673) is oneshot by L80 before combat flag — use HeroicTrainingDummy.
func TestUlduar_DamageKillPathSafe(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instances"}, Runtime: "med", Category: "instances/northrend/ulduar"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "UldDmg",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	dummy := bot.Spawn(t, e2eharness.CreatureHeroicTrainingDummy, 15*time.Second)
	bot.CombatReady(t)
	bot.Engage(t, dummy, 20*time.Second)
	bot.DamageKill(t, []uint64{dummy}, 50_000_000, 20*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS DamageKill path (training for raid helpers)")
}

// ULDUAR-05: dual-bot login near Freya does not thrash auth.
func TestUlduar_MultiBotLoginNearBossPad(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instances", "multi_bot"}, Runtime: "med", Category: "instances/northrend/ulduar"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "UldDuo",
		Count:  2,
		Level:  80,
	})
	for _, b := range bots {
		b.TeleNamed(t, "Freya")
	}
	bots[0].AssertWorldAlive(t)
	t.Logf("PASS multi-bot Freya pad login n=%d", len(bots))
}
