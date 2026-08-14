//go:build e2e

package ulduar_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// TODO(e2e): re-enable when AC#26266 is fixed — Charge near Kologarn must not drop below bridge Z.
// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/26266
// Placement: charge pad ~15y west of Kologarn spawn (1797.15,-24.4,448.7) at (1782.15,-24.4,448.7).
/*
func TestUlduar_KologarnChargeWorldAlive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances", "issue"},
		Runtime:  "long",
		Issue:    26266,
		Category: "instances/northrend/ulduar",
	})
	posCharge := e2eharness.Position3{X: 1782.15, Y: -24.4027, Z: 448.741, Map: e2eharness.MapUlduar}
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "UldKol", Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})
	bot.TeleNamed(t, "Kologarn")
	bot.Teleport(t, posCharge.X, posCharge.Y, posCharge.Z, posCharge.Map)
	kolo := bot.WaitUnit(t, e2eharness.CreatureKologarn, 30*time.Second)
	bot.Learn(t, e2eharness.SpellBattleStance)
	bot.Learn(t, e2eharness.SpellCharge)
	bot.CombatReadyFull(t)
	bot.CastSelfGM(t, e2eharness.SpellBattleStance)
	preX, preY, preZ, _ := bot.Pos()
	bot.Face(t, kolo)
	res, err := bot.TryCast(t, e2eharness.SpellCharge, kolo, 12*time.Second)
	if err != nil {
		e2eharness.Assertf(t, "Charge cast result timeout: %v", err)
	} else if res == nil || !res.Success {
		e2eharness.Assertf(t, "Charge fail reason=%s", e2eharness.SpellFailReasonName(res.FailReason))
	}
	deadline := time.Now().Add(1500 * time.Millisecond)
	for time.Now().Before(deadline) {
		x, y, z, _ := bot.Pos()
		if e2eharness.Distance3D(preX, preY, preZ, x, y, z) > 1.0 {
			break
		}
		time.Sleep(50 * time.Millisecond)
	}
	x, y, z, m := bot.Pos()
	if z < preZ-20 {
		e2eharness.Assertf(t, "Charge landed below bridge: z=%.1f preZ=%.1f pos=(%.1f,%.1f) map=%d", z, preZ, x, y, m)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS Kologarn charge path map=%d pos=(%.1f,%.1f,%.1f)", m, x, y, z)
}
*/

// TODO(e2e): re-enable when AC#27095 is fixed
// https://github.com/azerothcore/azerothcore-wotlk/issues/27095
// Must assert Freya allies spawn (not only Freya UNIT_FLAG_IN_COMBAT).
/*
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
	const creatureFreya = 32906
	freya := bot.WaitUnit(t, creatureFreya, 45*time.Second)
	bot.CombatReady(t)
	bot.Engage(t, freya, 20*time.Second)
	bot.WaitUnitCombat(t, freya, 10*time.Second)
	if !bot.UnitInCombat(freya) {
		e2eharness.Assertf(t, "Freya not in combat after Engage (guid=0x%X)", freya)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS Freya engage target=0x%X combat=%v", freya, bot.UnitInCombat(freya))
}
*/

// ULDUAR-03: Ulduar map enter via named tele stays in-world.
func TestUlduar_NamedTeleEnter(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instances"}, Runtime: "med", Category: "instances/northrend/ulduar"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "UldEnt",
		Level:  80,
	})
	// Stock game_tele "Ulduar" is Storm Peaks entrance (map 571), not raid 603.
	bot.TeleNamed(t, "Ulduar")
	bot.AssertWorldAlive(t)
	_, _, _, m := bot.Pos()
	if m != e2eharness.MapNorthrend {
		e2eharness.Assertf(t, "TeleNamed Ulduar map=%d want Northrend %d", m, e2eharness.MapNorthrend)
	}
	t.Logf("PASS Ulduar named tele map=%d (Storm Peaks entrance)", m)
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
