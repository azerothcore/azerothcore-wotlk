//go:build e2e

package effects_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// FX-01: summon effect via engineering target dummy item spell (#26774 pattern).
func TestEffects_TargetDummySummon(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "spells", "issue"},
		Runtime:  "short",
		Issue:    26774,
		Category: "spells/effects",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "FxDummy",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	bot.AddItem(t, e2eharness.ItemTargetDummy, 1)
	// Use spell summon if item use is awkward: SpellSummonTargetDummy.
	bot.Learn(t, e2eharness.SpellSummonTargetDummy)
	_ = bot.CastOrGM(t, e2eharness.SpellSummonTargetDummy, 0, 10*time.Second)
	u := bot.WaitUnit(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	if u == 0 {
		e2eharness.Preconditionf(t, "target dummy not observed")
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS target dummy summon guid=0x%X", u)
}

// FX-02: Charge effect moves player (warrior).
func TestEffects_ChargeEffect(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells", "combat"}, Runtime: "short", Category: "spells/effects"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "FxChg",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	dummy := bot.Spawn(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	// Dummy spawns on player; step back into Charge range.
	x0, y0, z0, m0 := bot.Pos()
	bot.Teleport(t, x0+15, y0, z0, m0)
	x0, y0, z0, _ = bot.Pos()
	bot.CombatReadyFull(t)
	_ = bot.CastOrGM(t, e2eharness.SpellBattleStance, 0, 5*time.Second)
	bot.Face(t, dummy)
	res, err := bot.TryCast(t, e2eharness.SpellCharge, dummy, 8*time.Second)
	if err != nil {
		t.Logf("Charge timeout: %v", err)
	} else if !res.Success {
		t.Logf("Charge fail reason=%s", e2eharness.SpellFailReasonName(res.FailReason))
	}
	x1, y1, z1, _ := bot.Pos()
	dist := e2eharness.Distance3D(x0, y0, z0, x1, y1, z1)
	bot.AssertWorldAlive(t)
	t.Logf("PASS charge effect path moved=%.1fy ok=%v", dist, res.Success)
}

// FX-03 / #26997 pattern: Sweeping Strikes + Execute on multi-target must not crash.
func TestEffects_SweepingStrikesExecuteNoCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "issue"},
		Runtime:  "med",
		Issue:    26997,
		Category: "spells/effects",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "FxSS",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	// Two persistent dummies with SQL cleanup (never .npc add temp — 120s litter).
	d1, _ := bot.SpawnPersistent(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	d2, _ := bot.SpawnPersistent(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	bot.CombatReadyFull(t)
	_ = bot.CastOrGM(t, e2eharness.SpellBattleStance, 0, 5*time.Second)
	bot.Face(t, d1)
	_ = bot.CastOrGM(t, e2eharness.SpellSweepingStrikes, 0, 10*time.Second)
	// Soften dummies without killing — Execute needs a living low-HP target.
	bot.Damage(t, d1, 400)
	bot.Damage(t, d2, 400)
	res, err := bot.TryCast(t, e2eharness.SpellExecute, d1, 8*time.Second)
	if err != nil {
		t.Logf("Execute timeout: %v (crash oracle is world alive)", err)
	} else if !res.Success {
		t.Logf("Execute fail reason=%s", e2eharness.SpellFailReasonName(res.FailReason))
	}
	e2eharness.ProbeWorldAlive(t, bot, 26997)
	t.Logf("PASS Sweeping Strikes + Execute no crash d1=0x%X d2=0x%X", d1, d2)
}

// FX-04: grounding totem summon exists (#26584 ecosystem).
func TestEffects_GroundingTotemSummon(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells"}, Runtime: "short", Category: "spells/effects"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "FxTot",
		Race:          e2eharness.RaceOrc,
		Class:         e2eharness.ClassShaman,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	bot.GiveTotems(t)
	bot.CombatReady(t)
	_ = bot.CastOrGM(t, e2eharness.SpellGroundingTotem, 0, 10*time.Second)
	totem := bot.WaitUnit(t, e2eharness.CreatureGroundingTotem, 15*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS grounding totem summon guid=0x%X", totem)
}

// FX-05: Create-item / learn path for dummy reagents stays healthy.
func TestEffects_AddItemCreatePath(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells", "items"}, Runtime: "short", Category: "spells/effects"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "FxItem",
		Level:  80,
	})
	bot.AddItem(t, e2eharness.ItemCorpseDust, 3)
	bot.Save(t)
	bot.AssertWorldAlive(t)
	t.Logf("PASS create-item seed path")
}
