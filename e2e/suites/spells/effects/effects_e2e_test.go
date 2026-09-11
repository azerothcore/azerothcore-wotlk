//go:build e2e

package effects_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// OPEN(e2e): re-enable when AC#26774 is fixed
// https://github.com/azerothcore/azerothcore-wotlk/issues/26774
// Must assert client item-use / dummy rank (not CastOrGM + any 2673).
/*
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
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.AddItem(t, e2eharness.ItemTargetDummy, 1)
	bot.Learn(t, e2eharness.SpellSummonTargetDummy)
	_ = bot.CastOrGM(t, e2eharness.SpellSummonTargetDummy, 0, 10*time.Second)
	u := bot.WaitUnit(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	if u == 0 {
		e2eharness.Preconditionf(t, "target dummy not observed")
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS target dummy summon guid=0x%X", u)
}
*/

// FX-02: Charge effect moves player (warrior).
// WotLK Charge rank 3 (11578): Battle Stance, 8–25 yd, out of combat.
func TestEffects_ChargeEffect(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells", "combat"}, Runtime: "short", Category: "spells/effects"})

	const spellChargeRank3 = uint32(11578)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "FxChg",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	// PackagePad is isolation only — mountain pads return SPELL_FAILED_NOPATH (56).
	// Northshire open strip (map 0) is flat and mmaps-friendly for Charge.
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	const (
		chargeX   float32 = -8904.0
		chargeY   float32 = -128.0
		chargeZ   float32 = 81.0
		chargeMap uint32  = 0
	)
	bot.Teleport(t, chargeX, chargeY, chargeZ, chargeMap)
	bot.CombatStop(t)
	bot.CombatReadyFull(t)
	bot.CombatStop(t)
	bot.FlushWorld(t)
	bot.Learn(t, e2eharness.SpellBattleStance)
	bot.Learn(t, spellChargeRank3)
	bot.CastMust(t, e2eharness.SpellBattleStance, 0, 10*time.Second)
	deadline := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadline) {
		if bot.HasAura(e2eharness.SpellBattleStance) {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if !bot.HasAura(e2eharness.SpellBattleStance) {
		e2eharness.Preconditionf(t, "Battle Stance missing before Charge")
	}
	// 31146 is long-lived (2673 KillSelfs at 15s — Charge setup exceeds that).
	dummy := bot.Spawn(t, e2eharness.CreatureHeroicTrainingDummy, 15*time.Second)
	// 8–25 yd charge range on flat ground.
	bot.Teleport(t, chargeX+12, chargeY, chargeZ, chargeMap)
	x0, y0, z0, _ := bot.Pos()
	_ = bot.World.SetTarget(dummy)
	bot.Face(t, dummy)
	bot.CastMust(t, spellChargeRank3, dummy, 10*time.Second)
	// Snapshot is the step-back point; Charge must close toward the dummy.
	deadline = time.Now().Add(2 * time.Second)
	var moved float32
	for time.Now().Before(deadline) {
		x1, y1, z1, _ := bot.Pos()
		moved = e2eharness.Distance3D(x0, y0, z0, x1, y1, z1)
		if moved >= 1.0 {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if moved < 1.0 {
		e2eharness.Assertf(t, "Charge SPELL_GO ok but player did not leave step-back (moved=%.1f)", moved)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS charge effect moved=%.1fy", moved)
}

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/26997
// Sweeping Strikes + Execute on a ≤20% target with a second living ≤20% target
// nearby must not crash (CheckProc stored a raw Unit* that HandleProc deref'd).
// Training dummies absorb damage (npc_training_dummy::DamageTaken = 0) so they
// never enter Execute's 20% HealthState. Player-vs-player in Northshire fails
// SPELL_FAILED_BAD_TARGETS (sanctuary / PvP flag race). Use two hostile mobs.
func TestAC_26997_SweepingStrikesExecuteNoCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "issue", "multi_bot", "serial"},
		Runtime:  "med",
		Issue:    26997,
		Category: "spells/effects",
	})

	const (
		spellExecuteMax = uint32(47471) // WotLK Execute rank 9
		// High-HP test dummies with empty ScriptName (they take damage). L1-L6
		// world mobs die to a L80 autoattack during DamageToFraction.
		unkillableDummy80      = uint32(32171)
		unkillableDummy80Armor = uint32(32847) // different entry — Spawn despawns nearby same-entry
	)

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "SwpEx",
		Bots: []e2eharness.BotSpec{
			{Role: "arms", Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
			{Role: "probe", Level: 10},
		},
	})
	arms := e2eharness.ByRole(t, bots, "arms")
	probe := e2eharness.ByRole(t, bots, "probe")

	// Northshire strip — flat, melee range for Sweeping Strikes extra attack.
	const (
		x, y, z float32 = -8904.0, -128.0, 81.0
		m       uint32  = 0
	)
	arms.Teleport(t, x, y, z, m)
	probe.Teleport(t, x-8, y, z, m)

	arms.CombatReadyFull(t)
	arms.Learn(t, e2eharness.SpellBattleStance)
	arms.Learn(t, e2eharness.SpellSweepingStrikes)
	arms.Learn(t, spellExecuteMax)
	arms.CastMust(t, e2eharness.SpellBattleStance, 0, 10*time.Second)
	deadline := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadline) {
		if arms.HasAura(e2eharness.SpellBattleStance) {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if !arms.HasAura(e2eharness.SpellBattleStance) {
		e2eharness.Preconditionf(t, "Battle Stance missing before Execute")
	}

	c1 := arms.Spawn(t, unkillableDummy80, 15*time.Second)
	c2 := arms.Spawn(t, unkillableDummy80Armor, 15*time.Second)
	arms.CombatStop(t)
	if c1 == 0 || c2 == 0 {
		e2eharness.Preconditionf(t, "failed to spawn Execute targets c1=0x%X c2=0x%X", c1, c2)
	}
	arms.DamageToFraction(t, c1, 0.19, 20*time.Second)
	arms.DamageToFraction(t, c2, 0.19, 20*time.Second)
	for _, v := range []struct {
		name string
		g    uint64
	}{{"c1", c1}, {"c2", c2}} {
		hp, maxHP := arms.UnitHP(v.g)
		if maxHP == 0 || hp == 0 || float64(hp)/float64(maxHP) > 0.2 {
			e2eharness.Preconditionf(t, "%s not in execute range (hp=%d/%d guid=0x%X)", v.name, hp, maxHP, v.g)
		}
	}

	arms.CastMust(t, e2eharness.SpellSweepingStrikes, 0, 10*time.Second)
	if !arms.HasAura(e2eharness.SpellSweepingStrikes) {
		e2eharness.Preconditionf(t, "Sweeping Strikes aura %d missing", e2eharness.SpellSweepingStrikes)
	}
	_ = arms.World.SetTarget(c1)
	arms.Face(t, c1)
	res, err := arms.TryCast(t, spellExecuteMax, c1, 15*time.Second)
	if err != nil {
		e2eharness.ProbeWorldAlive(t, probe, 26997)
		e2eharness.HarnessFailf(t, "AC#26997: no Execute cast result: %v", err)
	}
	e2eharness.ProbeWorldAlive(t, probe, 26997)
	if !res.Success {
		e2eharness.Assertf(t, "Execute failed reason=%s", e2eharness.SpellFailReasonName(res.FailReason))
	}
	t.Logf("PASS AC#26997 Sweeping Strikes Execute world alive (c1=0x%X c2=0x%X)", c1, c2)
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
	bot.TeleportPad(t, e2eharness.PackagePad(t))
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
	bot.AddItemWait(t, e2eharness.ItemCorpseDust, 3)
	bot.AssertInventoryAtLeast(t, e2eharness.ItemCorpseDust, 3)
	t.Logf("PASS create-item seed path count>=3")
}
