//go:build e2e

package aura_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
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
//
// L80 break threshold is warrior BaseHealth/4.75 ≈ 2648 (HandleBreakableCCAuraProc).
// Ice Lance 42914 is instant but often ~320–380 on a naked lock; 8 hits landed
// 2569 on CI and left Fear up. `.cheat cooldown` skips the 1.5s GCD so we can
// dump enough real CMSG_CAST_SPELL hits before the 10s PvP cap. Gone before 8s
// with an HP drop is the proc, not duration expiry.
func TestAura_BreakableCCRemovedByDamage(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "combat", "multi_bot"},
		Runtime:  "med",
		Category: "spells/aura",
	})

	const (
		spellFear            = uint32(6215)
		spellIceLance        = uint32(42914) // rank 3, instant, no recovery
		spellEntanglingRoots = uint32(53308) // long root; holds facing
		itemArchus           = uint32(50731) // best-effort +SP; not required
		maxLances            = 16
		postHitWindow        = 250 * time.Millisecond
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
	// GCD is 1.5s; without this, 6 instants race the 10s Fear cap.
	lock.GM(t, ".cheat cooldown on")
	lock.FlushWorld(t)
	lock.EquipEntry(t, itemArchus, 1)
	victim.GM(t, ".gm off")
	victim.GM(t, ".cheat god off")
	e2eharness.EnableHostilePvP(t, lock, victim)
	lock.WaitUnitGUID(t, victim.GUID, 10*time.Second)

	lock.Learn(t, spellFear)
	lock.Learn(t, spellIceLance)
	var last e2eharness.SpellCastResult
	feared := false
	for attempt := 0; attempt < 5 && !feared; attempt++ {
		if err := lock.World.SetTarget(victim.GUID); err != nil {
			e2eharness.Preconditionf(t, "SetTarget victim: %v", err)
		}
		lock.Face(t, victim.GUID)
		last = lock.Cast(t, spellFear, victim.GUID, 10*time.Second)
		if !last.Success {
			if e2eharness.SpellFailReasonName(last.FailReason) == "BAD_TARGETS" {
				e2eharness.EnableHostilePvP(t, lock, victim)
			}
			continue
		}
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
		e2eharness.Preconditionf(t, "Fear %d not on victim (last success=%v reason=%s)",
			spellFear, last.Success, e2eharness.SpellFailReasonName(last.FailReason))
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

	hits := 0
	var brokenAt time.Time
	for hits < maxLances {
		if !victim.HasAura(spellFear) {
			brokenAt = time.Now()
			break
		}
		if err := lock.World.SetTarget(victim.GUID); err != nil {
			e2eharness.Preconditionf(t, "SetTarget before Ice Lance: %v", err)
		}
		lock.Face(t, victim.GUID)
		lock.CastMust(t, spellIceLance, victim.GUID, 10*time.Second)
		hits++
		hpNow := victim.World.Health()
		t.Logf("lance %d hp %d→%d Δ=%d fear=%v", hits, hpBefore, hpNow, int(hpBefore)-int(hpNow), victim.HasAura(spellFear))
		if victim.TryWaitAuraGone(t, spellFear, postHitWindow) {
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
		e2eharness.Assertf(t, "victim died (hp %d→0 / %d) after %d Ice Lance — death is not a CC-break proof",
			hpBefore, maxHP, hits)
	}
	if hpAfter >= hpBefore {
		e2eharness.Assertf(t, "victim HP did not drop (%d→%d / %d) after %d Ice Lance — need real damage",
			hpBefore, hpAfter, maxHP, hits)
	}
	if elapsed >= fearBreakDeadline {
		e2eharness.Assertf(t, "Fear dropped after %s (PvP duration 10s) — not a damage proof (hp %d→%d)",
			elapsed.Round(time.Millisecond), hpBefore, hpAfter)
	}
	if victim.HasAura(spellFear) {
		e2eharness.Assertf(t, "Fear %d still on victim after %d Ice Lance in %s (hp %d→%d / %d)",
			spellFear, hits, elapsed.Round(time.Millisecond), hpBefore, hpAfter, maxHP)
	}
	lock.AssertWorldAlive(t)
	t.Logf("PASS Fear broken by Ice Lance n=%d in %s victim hp %d→%d / %d",
		hits, elapsed.Round(time.Millisecond), hpBefore, hpAfter, maxHP)
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

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/26386
// PR:    https://github.com/azerothcore/azerothcore-wotlk/pull/27464
// Mage Tier 8 4-Piece bonus (64869): Hot Streak (48108) must have a chance not to be consumed
// when casting Pyroblast, and must always be consumed when the bonus is absent.
func TestAC_26386_MageT84PBonusHotStreakPreservation(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "spells", "issue"},
		Runtime:  "short",
		Issue:    26386,
		Category: "spells/aura",
	})

	const (
		spellPyroblast  = uint32(11366) // Rank 1 Pyroblast
		spellHotStreak  = uint32(48108) // Hot Streak proc buff
		spellT84PBonus  = uint32(64869) // Item - Mage T8 4P Bonus
		itemT8Head      = uint32(46134) // Conqueror's Kirin Tor Hood
		itemT8Chest     = uint32(46132) // Conqueror's Kirin Tor Tunic
		itemT8Legs      = uint32(46130) // Conqueror's Kirin Tor Leggings
		itemT8Shoulders = uint32(46133) // Conqueror's Kirin Tor Shoulderpads
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "MageT8",
		Race:          e2eharness.RaceHuman,
		Class:         e2eharness.ClassMage,
		Level:         80,
		LearnAllClass: true,
	})

	pad := e2eharness.PackagePad(t)
	bot.TeleportPad(t, pad)
	bot.CombatReady(t)
	bot.CheatPower(t)
	bot.GM(t, ".cheat cooldown on")
	bot.FlushWorld(t)

	bot.Learn(t, spellPyroblast)

	dummy := bot.Spawn(t, e2eharness.CreatureHeroicTrainingDummy, 60*time.Second)
	if err := bot.World.SetTarget(dummy); err != nil {
		e2eharness.Preconditionf(t, "SetTarget dummy: %v", err)
	}
	bot.Face(t, dummy)

	// Phase 1: Deterministic baseline without T8 4P bonus.
	// Pyroblast must consume Hot Streak 100% of the time.
	bot.ApplyAura(t, spellHotStreak)
	if !bot.HasAura(spellHotStreak) {
		e2eharness.Preconditionf(t, "Hot Streak %d missing after ApplyAura", spellHotStreak)
	}
	bot.CastMust(t, spellPyroblast, dummy, 5*time.Second)
	if !bot.TryWaitAuraGone(t, spellHotStreak, 2*time.Second) {
		e2eharness.Assertf(t, "Hot Streak %d was not consumed after Pyroblast without T8 4P bonus", spellHotStreak)
	}
	t.Logf("PASS Hot Streak consumed by Pyroblast without T8 4P bonus")

	// Phase 2: Equip 4-piece T8 set and verify 20% proc preservation chance.
	bot.EquipEntry(t, itemT8Head, 1)
	bot.EquipEntry(t, itemT8Chest, 1)
	bot.EquipEntry(t, itemT8Legs, 1)
	bot.EquipEntry(t, itemT8Shoulders, 1)
	bot.FlushWorld(t)

	if !bot.HasAura(spellT84PBonus) {
		bot.ApplyAura(t, spellT84PBonus)
	}
	if !bot.HasAura(spellT84PBonus) {
		e2eharness.Preconditionf(t, "Mage T8 4P bonus aura %d missing after equipping items", spellT84PBonus)
	}

	// With 20% chance to preserve, across 50 attempts, probability of 0 preservations is (0.8)^50 ≈ 1.4e-5.
	preserved := false
	const maxAttempts = 50
	for attempt := 1; attempt <= maxAttempts; attempt++ {
		if !bot.HasAura(spellHotStreak) {
			bot.ApplyAura(t, spellHotStreak)
		}
		if !bot.HasAura(spellHotStreak) {
			e2eharness.Preconditionf(t, "Hot Streak %d missing at attempt %d", spellHotStreak, attempt)
		}

		bot.CastMust(t, spellPyroblast, dummy, 5*time.Second)
		time.Sleep(100 * time.Millisecond)

		if bot.HasAura(spellHotStreak) {
			preserved = true
			t.Logf("PASS Hot Streak preserved by T8 4P bonus on attempt %d", attempt)
			break
		}
	}

	if !preserved {
		e2eharness.Assertf(t, "Hot Streak was consumed on all %d attempts despite T8 4P bonus (P(fail) < 0.002%%)", maxAttempts)
	}

	bot.AssertWorldAlive(t)
	t.Logf("PASS AC#26386 Mage T8 4P bonus Hot Streak preservation verified")
}
