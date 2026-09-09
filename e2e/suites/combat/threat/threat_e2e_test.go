//go:build e2e

package threat_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// pullDummy is a high-HP training dummy for kill/engage-without-target oracles.
// L1 Target Dummy (2673) oneshots under L80 autoattack before combat is observed.
const pullDummy = e2eharness.CreatureHeroicTrainingDummy

// pullHostile is a real combat AI NPC (Crimson Templar). Training dummies never set
// UNIT_FIELD_TARGET, so target/taunt oracles must use a creature with a threat table.
const pullHostile = e2eharness.CreatureGroupLootFixture // 15209

// THREAT-01: engage hostile → unit in combat + targets player.
func TestThreat_EngageSetsTarget(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/threat"})

	// L50 vs L60 templar: low player damage (no oneshot), god keeps player alive.
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "ThrEng",
		Class:         e2eharness.ClassWarrior,
		Level:         50,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	mob := bot.Spawn(t, pullHostile, 15*time.Second)
	bot.CombatReady(t)
	bot.Engage(t, mob, 15*time.Second)
	bot.WaitUnitCombat(t, mob, 15*time.Second)
	// Product oracle: real AI must target the attacker after pull.
	bot.WaitUnitTarget(t, mob, bot.GUID, 15*time.Second)
	bot.AssertUnitTarget(t, mob, bot.GUID)
	t.Logf("PASS engage combat target=0x%X player=0x%X", bot.UnitTarget(mob), bot.GUID)
}

// THREAT-02: two bots; Taunt switches UNIT_FIELD_TARGET to the tank.
//
// WotLK 3.3.5a (wowhead/evowow spell 355): Taunt is instant, 30 yd, **Requires Defensive Stance**
// (stance form 2 / spell 71) — NOT Battle Stance (2457). Casting Taunt in Battle Stance
// correctly returns SPELL_FAILED_ONLY_SHAPESHIFT (94). Correct tank flow:
//
//	Defensive Stance → DPS pulls so mob is not already on tank → Taunt.
func TestThreat_TauntSwitchesTarget(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "combat", "multi_bot"}, Runtime: "med", Category: "combat/threat"})

	// L80 so Taunt (physical) does not miss a scaled L80 mob (L12 vs L80 miss is near-certain).
	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "ThrTnt",
		Bots: []e2eharness.BotSpec{
			{Role: "tank", Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
			{Role: "dps", Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
		},
	})
	tank := e2eharness.ByRole(t, bots, "tank")
	dps := e2eharness.ByRole(t, bots, "dps")
	pad := e2eharness.PackagePad(t)
	e2eharness.TeleportAll(t, bots, pad.X, pad.Y, pad.Z, pad.Map)
	for _, b := range bots {
		b.GM(t, ".combatstop")
		b.GM(t, ".cheat god on")
		b.GM(t, ".cheat power on")
	}
	// Real threat AI (not training dummy). Crimson Templar L60 works for engage+taunt at L80.
	tank.DespawnNearbyEntry(t, pullHostile, 80)
	mob := tank.Spawn(t, pullHostile, 15*time.Second)
	tx, ty, tz, tm := tank.Pos()
	dps.Teleport(t, tx+1, ty, tz, tm)
	if dps.World.GetObject(mob) == nil {
		seen := dps.WaitUnit(t, pullHostile, 15*time.Second)
		if seen != 0 {
			mob = seen
		}
	}
	dps.CombatReady(t)
	tank.CombatReady(t)
	tank.GM(t, ".cheat power on")
	tank.FlushWorld(t)

	// Explicit learn — Defensive Stance / Taunt come from the L10 warrior quest, not only learn-all.
	tank.Learn(t, e2eharness.SpellDefensiveStance)
	tank.Learn(t, e2eharness.SpellTaunt)

	// WotLK: Taunt Forms = Defensive Stance only (spell 71).
	tank.CastMust(t, e2eharness.SpellDefensiveStance, 0, 10*time.Second)
	stanceDeadline := time.Now().Add(5 * time.Second)
	for time.Now().Before(stanceDeadline) {
		if tank.HasAura(e2eharness.SpellDefensiveStance) {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if !tank.HasAura(e2eharness.SpellDefensiveStance) {
		e2eharness.Preconditionf(t, "tank missing Defensive Stance aura before Taunt")
	}

	// Soft pull: mob must be attacking DPS first (tooltip: no effect if already on you).
	_ = dps.World.SetTarget(mob)
	dps.GM(t, ".damage 1")
	dps.WaitUnitTarget(t, mob, dps.GUID, 10*time.Second)

	tank.Face(t, mob)
	_ = tank.World.SetTarget(mob)
	// Product path: client Taunt in Defensive Stance retargets the mob to the tank.
	tank.CastMust(t, e2eharness.SpellTaunt, mob, 10*time.Second)
	tank.WaitUnitTarget(t, mob, tank.GUID, 10*time.Second)
	tank.AssertUnitTarget(t, mob, tank.GUID)
	tank.AssertWorldAlive(t)
	t.Logf("PASS taunt switched target to tank=0x%X", tank.GUID)
}

// THREAT-03: kill target clears combat eventually.
func TestThreat_KillClearsCombat(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/threat"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "ThrKill",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	dummy := bot.Spawn(t, pullDummy, 15*time.Second)
	bot.CombatReady(t)
	bot.Engage(t, dummy, 15*time.Second)
	// Large chunks; Heroic dummy has huge HP pool.
	bot.DamageKill(t, []uint64{dummy}, 50_000_000, 30*time.Second)
	bot.WaitUnitDead(t, dummy, 15*time.Second)
	// 31146 training dummies can leave the player flagged; the unit itself must drop combat.
	deadline := time.Now().Add(8 * time.Second)
	for time.Now().Before(deadline) {
		if !bot.UnitInCombat(dummy) {
			break
		}
		time.Sleep(50 * time.Millisecond)
	}
	if bot.UnitInCombat(dummy) {
		e2eharness.Assertf(t, "dummy 0x%X still UNIT_FLAG_IN_COMBAT after death", dummy)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS kill dummy dead combat=%v", bot.UnitInCombat(dummy))
}

// THREAT-04: multi-bot form party then pull (setup for threat tables).
func TestThreat_PartyPullSetup(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "multi_bot"}, Runtime: "short", Category: "combat/threat"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "ThrPty", Count: 2, Level: 80, LearnAllClass: true})
	pad := e2eharness.PackagePad(t)
	e2eharness.TeleportAll(t, bots, pad.X, pad.Y, pad.Z, pad.Map)
	for _, b := range bots {
		b.GM(t, ".combatstop")
		b.GM(t, ".cheat god on")
	}
	bots[0].DespawnNearbyEntry(t, pullDummy, 80)
	e2eharness.FormParty(t, bots[0], bots[1])
	dummy := bots[0].Spawn(t, pullDummy, 15*time.Second)
	bots[0].CombatReady(t)
	bots[0].Engage(t, dummy, 15*time.Second)
	if !bots[0].InGroup() || !bots[1].InGroup() {
		e2eharness.Assertf(t, "party gone after pull in0=%v in1=%v", bots[0].InGroup(), bots[1].InGroup())
	}
	if !bots[0].UnitInCombat(dummy) && e2eharness.UnitTargetGUID(bots[0].World, dummy) != bots[0].GUID {
		e2eharness.Assertf(t, "dummy 0x%X not in combat and not targeting leader after party pull", dummy)
	}
	t.Logf("PASS party pull setup dummy=0x%X combat=%v", dummy, bots[0].UnitInCombat(dummy))
}

// THREAT-05: WaitUnitTarget helper after engage on a real threat AI.
func TestThreat_WaitUnitTargetHelper(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/threat"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "ThrWait",
		Class:         e2eharness.ClassWarrior,
		Level:         50,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	mob := bot.Spawn(t, pullHostile, 15*time.Second)
	bot.CombatReady(t)
	bot.Engage(t, mob, 15*time.Second)
	bot.WaitUnitTarget(t, mob, bot.GUID, 15*time.Second)
	bot.AssertUnitTarget(t, mob, bot.GUID)
	bot.AssertWorldAlive(t)
	t.Logf("PASS WaitUnitTarget target=0x%X", bot.UnitTarget(mob))
}
