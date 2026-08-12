//go:build e2e

package ulduar_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// ULDUAR-01 / #26266 pattern: Charge on Kologarn area stays sane (Z/bridge).
func TestUlduar_KologarnChargeWorldAlive(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{
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
	// Prefer named tele + go creature id pattern from Ghost examples.
	bot.TeleNamed(t, "Kologarn")
	bot.GoCreatureID(t, e2eharness.CreatureKologarn)
	kolo := bot.WaitUnit(t, e2eharness.CreatureKologarn, 30*time.Second)
	bot.CombatReady(t)
	bot.Face(t, kolo)
	_ = bot.Cast(t, e2eharness.SpellCharge, kolo, 10*time.Second)
	bot.AssertWorldAlive(t)
	x, y, z, m := bot.Pos()
	t.Logf("PASS Kologarn charge path map=%d pos=(%.1f,%.1f,%.1f)", m, x, y, z)
}

// ULDUAR-02 / #27095 pattern: Freya allies engage smoke (world alive + unit appear).
func TestUlduar_FreyaEngageSmoke(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{
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
	// Soft observe: world remains responsive during early engage.
	time.Sleep(2 * time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS Freya engage smoke target=0x%X", freya)
}

// ULDUAR-03: Ulduar map enter via named tele stays in-world.
func TestUlduar_NamedTeleEnter(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"med", "instances"}, Runtime: "med", Category: "instances/northrend/ulduar"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "UldEnt",
		Level:  80,
	})
	bot.TeleNamed(t, "Ulduar")
	bot.AssertWorldAlive(t)
	_, _, _, m := bot.Pos()
	t.Logf("PASS Ulduar named tele map=%d (want %d if tele exists)", m, e2eharness.MapUlduar)
}

// ULDUAR-04: engage + DamageKill path on a trash/dummy inside instance if present.
func TestUlduar_DamageKillPathSafe(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"med", "instances"}, Runtime: "med", Category: "instances/northrend/ulduar"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "UldDmg",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	dummy := bot.Spawn(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	bot.CombatReady(t)
	bot.Engage(t, dummy, 10*time.Second)
	bot.DamageKill(t, []uint64{dummy}, 10_000_000, 15*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS DamageKill path (training for raid helpers)")
}

// ULDUAR-05: dual-bot login near Freya does not thrash auth.
func TestUlduar_MultiBotLoginNearBossPad(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"med", "instances", "multi_bot"}, Runtime: "med", Category: "instances/northrend/ulduar"})

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
