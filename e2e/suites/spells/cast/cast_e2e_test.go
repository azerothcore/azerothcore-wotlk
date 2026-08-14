//go:build e2e

package cast_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// CAST-01: live cast pipeline — Charge succeeds on spawned dummy after CombatReady.
// WotLK Charge (rank 3 = 11578): Requires Battle Stance, 8–25 yd, out of combat.
func TestCast_ChargeSucceedsOnDummy(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells", "combat"}, Runtime: "short", Category: "spells/cast"})

	const spellChargeRank3 = uint32(11578)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "CastOk",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	// PackagePad only for isolation. Charge needs pathable flat ground
	// (PackagePad mountain pads return SPELL_FAILED_NOPATH=56).
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	// Northshire open strip (map 0) — short, flat, mmaps-friendly.
	const (
		chargeX   float32 = -8904.0
		chargeY   float32 = -128.0
		chargeZ   float32 = 81.0
		chargeMap uint32  = 0
	)
	bot.Teleport(t, chargeX, chargeY, chargeZ, chargeMap)
	bot.CombatStop(t)
	bot.CombatReadyFull(t) // gm off + god + power
	bot.CombatStop(t)
	bot.Learn(t, e2eharness.SpellBattleStance)
	bot.Learn(t, spellChargeRank3)
	// Client Battle Stance so form is real (not CastOrGM fake-success).
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
	// Charge range is 8–25y; spawn is on the player — step back ~12y on flat ground.
	bot.Teleport(t, chargeX+12, chargeY, chargeZ, chargeMap)
	_ = bot.World.SetTarget(dummy)
	bot.Face(t, dummy)
	bot.CastMust(t, spellChargeRank3, dummy, 10*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS Charge succeeded on dummy")
}

// CAST-02: out-of-range / fail path does not crash.
func TestCast_FailPathNoCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells"}, Runtime: "short", Category: "spells/cast"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "CastFl",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	// Cast Charge with no target / invalid target GUID.
	res, err := bot.TryCast(t, e2eharness.SpellCharge, 0, 5*time.Second)
	_ = res
	_ = err
	bot.AssertWorldAlive(t)
	t.Logf("PASS cast fail path no crash")
}

// TODO(e2e): re-enable when AC#27061 is fixed
// https://github.com/azerothcore/azerothcore-wotlk/issues/27061
// Must CastMust Raise Dead and assert a ghoul; world-alive alone is greenwash.
/*
func TestCast_RaiseDeadNearCorpseNoCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "issue", "serial"},
		Runtime:  "med",
		Issue:    27061,
		Category: "spells/cast",
	})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "CastRD",
		Bots: []e2eharness.BotSpec{
			{Role: "dk", Race: e2eharness.RaceHuman, Class: e2eharness.ClassDeathKnight, Level: 80, LearnAllClass: true},
			{Role: "corpse", Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarrior, Level: 80},
		},
	})
	dk := e2eharness.ByRole(t, bots, "dk")
	corpse := e2eharness.ByRole(t, bots, "corpse")
	e2eharness.TeleportAllPad(t, bots, e2eharness.PackagePad(t))
	corpse.DieMust(t, 20*time.Second)
	dk.Learn(t, e2eharness.SpellRaiseDead)
	dk.AddItem(t, e2eharness.ItemCorpseDust, 5)
	dk.CombatReady(t)
	_, _ = dk.TryCast(t, e2eharness.SpellRaiseDead, 0, 10*time.Second)
	dk.CleanupOwnedSummons(t)
	e2eharness.ProbeWorldAlive(t, dk, 27061)
	t.Logf("PASS Raise Dead near corpse did not crash world")
}
*/

// CAST-04: client CastMust battle stance on self — aura must apply (no CastOrGM GM-fake).
func TestCast_BattleStanceSelf(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells"}, Runtime: "short", Category: "spells/cast"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "CastBS",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.Learn(t, e2eharness.SpellBattleStance)
	// Client cast path only — CastMust fatals if SPELL_GO/success missing.
	bot.CastMust(t, e2eharness.SpellBattleStance, 0, 10*time.Second)
	deadline := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadline) {
		if bot.HasAura(e2eharness.SpellBattleStance) {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if !bot.HasAura(e2eharness.SpellBattleStance) {
		e2eharness.Assertf(t, "battle stance aura %d missing after successful cast", e2eharness.SpellBattleStance)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS battle stance self-cast + aura")
}

// CAST-05: CastAtPosition ground AoE does not crash.
func TestCast_GroundAoENoCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells"}, Runtime: "short", Category: "spells/cast"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "CastAoE",
		Class:         e2eharness.ClassWarlock,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	x, y, z, _ := bot.Pos()
	_ = bot.CastAtPosition(t, e2eharness.SpellRainOfFire, x, y, z, 10*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS ground AoE cast path")
}
