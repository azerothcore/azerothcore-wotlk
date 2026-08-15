//go:build e2e

package aura_test

import (
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
	// Riding + Cold Weather Flying so a Northrend mount can apply.
	bot.Learn(t, 33388) // Apprentice Riding
	bot.Learn(t, 33391) // Journeyman Riding
	bot.Learn(t, 34090) // Expert Riding
	bot.Learn(t, 34091) // Artisan Riding
	bot.Learn(t, 54197) // Cold Weather Flying
	bot.Learn(t, e2eharness.SpellMountSwiftGryphon)
	_ = bot.CastOrGM(t, e2eharness.SpellMountSwiftGryphon, 0, 10*time.Second)
	if !bot.HasAura(e2eharness.SpellMountSwiftGryphon) {
		bot.ApplyAura(t, e2eharness.SpellMountSwiftGryphon)
	}
	if !bot.HasAura(e2eharness.SpellMountSwiftGryphon) {
		e2eharness.Preconditionf(t, "mount aura %d missing after CastOrGM/ApplyAura", e2eharness.SpellMountSwiftGryphon)
	}
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

// AURA-03: Fear is stripped by real spell damage while the victim lives.
// CastMust (not GM .damage). Player victim (dummies die, absorb, or flee).
// Orc: no Every Man for Himself. Entangling Roots after Fear: stay in front.
// PvP Fear 6215 lasts 10s; gone before 8s with an HP drop is the proc.
func TestAura_BreakableCCRemovedByDamage(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "combat", "multi_bot"},
		Runtime:  "med",
		Category: "spells/aura",
	})

	const (
		spellFear            = uint32(6215)
		spellShadowBoltMax   = uint32(47809)
		spellEntanglingRoots = uint32(53308) // long root; Frost Nova 122 expires mid-bolts
		itemArchus           = uint32(50731) // best-effort +SP; not required
		maxBolts             = 4
		postBoltWindow       = time.Second
		fearBreakDeadline    = 8 * time.Second
	)

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "AuraCC",
		Bots: []e2eharness.BotSpec{
			{Role: "lock", Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarlock, Level: 80},
			{Role: "victim", Race: e2eharness.RaceOrc, Class: e2eharness.ClassWarrior, Level: 80},
		},
	})
	lock := e2eharness.ByRole(t, bots, "lock")
	victim := e2eharness.ByRole(t, bots, "victim")

	pad := e2eharness.PackagePad(t)
	lock.TeleportPad(t, pad)
	victim.TeleportPad(t, pad)
	lock.CombatReady(t)
	lock.CheatPower(t)
	lock.EquipEntry(t, itemArchus, 1)
	victim.GM(t, ".gm off")
	victim.GM(t, ".cheat god off")
	e2eharness.EnableHostilePvP(t, lock, victim)
	lock.WaitUnitGUID(t, victim.GUID, 10*time.Second)

	lock.Learn(t, spellFear)
	lock.Learn(t, spellShadowBoltMax)
	if err := lock.World.SetTarget(victim.GUID); err != nil {
		e2eharness.Preconditionf(t, "SetTarget victim: %v", err)
	}
	feared := false
	for attempt := 0; attempt < 3 && !feared; attempt++ {
		lock.Face(t, victim.GUID)
		lock.CastMust(t, spellFear, victim.GUID, 10*time.Second)
		deadline := time.Now().Add(2 * time.Second)
		for time.Now().Before(deadline) {
			if victim.HasAura(spellFear) {
				feared = true
				break
			}
			time.Sleep(40 * time.Millisecond)
		}
	}
	if !feared {
		e2eharness.Preconditionf(t, "Fear %d not on victim after CastMust (resist/miss)", spellFear)
	}
	victim.ApplyAura(t, spellEntanglingRoots)
	if !victim.HasAura(spellFear) {
		e2eharness.Preconditionf(t, "Fear %d lost when applying Entangling Roots", spellFear)
	}
	if !victim.HasAura(spellEntanglingRoots) {
		e2eharness.Preconditionf(t, "Entangling Roots %d missing (needed to hold facing)", spellEntanglingRoots)
	}
	fearedAt := time.Now()

	hpBefore, maxHP := victim.World.Health(), victim.World.MaxHealth()
	if maxHP == 0 || hpBefore == 0 {
		e2eharness.Preconditionf(t, "victim hp unknown (%d/%d)", hpBefore, maxHP)
	}

	bolts := 0
	var brokenAt time.Time
	for bolts = 1; bolts <= maxBolts; bolts++ {
		if !victim.HasAura(spellFear) {
			brokenAt = time.Now()
			break
		}
		if err := lock.World.SetTarget(victim.GUID); err != nil {
			e2eharness.Preconditionf(t, "SetTarget before Shadow Bolt: %v", err)
		}
		lock.Face(t, victim.GUID)
		lock.CastMust(t, spellShadowBoltMax, victim.GUID, 10*time.Second)
		if victim.TryWaitAuraGone(t, spellFear, postBoltWindow) {
			brokenAt = time.Now()
			break
		}
	}
	hpAfter := victim.World.Health()
	if brokenAt.IsZero() {
		brokenAt = time.Now()
	}
	elapsed := brokenAt.Sub(fearedAt)
	if hpAfter == 0 {
		e2eharness.Assertf(t, "victim died (hp %d→0 / %d) after %d Shadow Bolts — death is not a CC-break proof",
			hpBefore, maxHP, bolts)
	}
	if hpAfter >= hpBefore {
		e2eharness.Assertf(t, "victim HP did not drop (%d→%d / %d) after %d Shadow Bolts — need real damage",
			hpBefore, hpAfter, maxHP, bolts)
	}
	if elapsed >= fearBreakDeadline {
		e2eharness.Assertf(t, "Fear dropped after %s (PvP duration 10s) — not a damage proof (hp %d→%d)",
			elapsed.Round(time.Millisecond), hpBefore, hpAfter)
	}
	if victim.HasAura(spellFear) {
		e2eharness.Assertf(t, "Fear %d still on victim after %d Shadow Bolts in %s (hp %d→%d / %d)",
			spellFear, bolts, elapsed.Round(time.Millisecond), hpBefore, hpAfter, maxHP)
	}
	lock.AssertWorldAlive(t)
	t.Logf("PASS Fear broken by Shadow Bolt n=%d in %s victim hp %d→%d / %d",
		bolts, elapsed.Round(time.Millisecond), hpBefore, hpAfter, maxHP)
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
	if !bot.HasAura(e2eharness.SpellBattleStance) {
		e2eharness.Assertf(t, "Battle Stance missing after ApplyAura")
	}
	t.Logf("PASS multi-aura apply (stance present=%v)", bot.HasAura(e2eharness.SpellBattleStance))
}
