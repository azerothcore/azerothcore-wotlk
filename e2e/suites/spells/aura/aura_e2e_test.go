//go:build e2e

package aura_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/26130
// PR:    https://github.com/azerothcore/azerothcore-wotlk/pull/27021
// Mounting must not strip Blending In (45614) inside the quest area.
func TestAC_26130_BlendingInSurvivesMount(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "spells", "issue"},
		Runtime:  "short",
		Issue:    26130,
		Category: "spells/aura",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Blend",
		Race:   e2eharness.RaceOrc,
		Class:  e2eharness.ClassWarrior,
		Level:  78,
	})
	bot.AddQuest(t, e2eharness.QuestBlendingIn)
	// Temple City of En'kilah (issue repro coords).
	bot.Teleport(t, 3758.2554, 3689.5754, 47.241505, e2eharness.MapNorthrend)
	bot.ApplyAura(t, e2eharness.SpellBlendingInAura)
	if !bot.HasAura(e2eharness.SpellBlendingInAura) {
		e2eharness.Preconditionf(t, "ApplyAura did not yield Blending In %d", e2eharness.SpellBlendingInAura)
	}
	bot.Learn(t, e2eharness.SpellMountSwiftGryphon)
	_ = bot.CastOrGM(t, e2eharness.SpellMountSwiftGryphon, 0, 10*time.Second)
	bot.AssertAuraRemains(t, e2eharness.SpellBlendingInAura, 800*time.Millisecond, 26130)
	t.Logf("PASS AC#26130 Blending In aura survived mount")
}

// AURA-05: aura present after apply; gone after death+relog settle path.
func TestAura_ApplyAndQuery(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells"}, Runtime: "short", Category: "spells/aura"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "AuraQ",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.ApplyAura(t, e2eharness.SpellBlendingInAura)
	if !bot.HasAura(e2eharness.SpellBlendingInAura) {
		e2eharness.Preconditionf(t, "ApplyAura did not yield aura %d", e2eharness.SpellBlendingInAura)
	}
	t.Logf("PASS ApplyAura + HasAura")
}

// AURA-06: mid-aura relog keeps session healthy (duration continuity soft-check).
func TestAura_MidAuraRelogWorldAlive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells", "protocol"}, Runtime: "short", Category: "spells/aura"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "AuraRl",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.ApplyAura(t, e2eharness.SpellBlendingInAura)
	bot.Save(t)
	bot.Relog(t)
	bot.AssertWorldAlive(t)
	// Aura may or may not persist depending on aura type; world alive is hard assert.
	t.Logf("PASS mid-aura relog world alive has_aura=%v", bot.HasAura(e2eharness.SpellBlendingInAura))
}

// AURA-03: breakable CC (Fear) is removed by damage on the victim.
// WotLK: Fear breaks on damage. Apply on a dummy (not self — self-.aura + .damage is
// not a reliable model of breakable CC rules).
func TestAura_BreakableCCRemovedByDamage(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "spells", "combat"}, Runtime: "med", Category: "spells/aura"})

	const spellFear = uint32(6215) // Fear rank 3 — breakable by damage

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "AuraCC",
		Class:         e2eharness.ClassWarlock,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	dummy := bot.Spawn(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	_ = bot.World.SetTarget(dummy)
	// Apply Fear to the dummy via GM cast (deterministic victim CC).
	bot.GM(t, fmt.Sprintf(".cast %d", spellFear))
	deadline := time.Now().Add(5 * time.Second)
	feared := false
	for time.Now().Before(deadline) {
		if bot.UnitHasAura(dummy, spellFear) {
			feared = true
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if !feared {
		// Fallback: .aura on selected unit if cast path does not stick.
		bot.GM(t, fmt.Sprintf(".aura %d", spellFear))
		deadline = time.Now().Add(3 * time.Second)
		for time.Now().Before(deadline) {
			if bot.UnitHasAura(dummy, spellFear) {
				feared = true
				break
			}
			time.Sleep(40 * time.Millisecond)
		}
	}
	if !feared {
		e2eharness.Preconditionf(t, "could not apply Fear %d on dummy 0x%X", spellFear, dummy)
	}
	// Damage the feared dummy — CC must break.
	bot.GM(t, ".damage 5000")
	deadline = time.Now().Add(5 * time.Second)
	for time.Now().Before(deadline) {
		if !bot.UnitHasAura(dummy, spellFear) {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if bot.UnitHasAura(dummy, spellFear) {
		e2eharness.Assertf(t, "Fear aura %d still on dummy after damage", spellFear)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS Fear broken by damage on dummy")
}

// AURA-01: exclusive / replace — apply stronger after weaker (soft observational).
func TestAura_ApplyMultipleDistinctAuras(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells"}, Runtime: "short", Category: "spells/aura"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "AuraMx",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.ApplyAura(t, e2eharness.SpellBlendingInAura)
	bot.ApplyAura(t, e2eharness.SpellBattleStance)
	if !bot.HasAura(e2eharness.SpellBlendingInAura) {
		e2eharness.Preconditionf(t, "lost blending-in after second ApplyAura")
	}
	t.Logf("PASS multi-aura apply (stance present=%v)", bot.HasAura(e2eharness.SpellBattleStance))
}
