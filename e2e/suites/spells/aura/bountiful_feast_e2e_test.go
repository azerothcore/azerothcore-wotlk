//go:build e2e

package aura_test

import (
	"math"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Issue: https://github.com/chromiecraft/chromiecraft/issues/10416
//
// Eating from a Bountiful Feast (GO 195303) casts 66477, whose script applies Food and Drink and the
// hidden Refreshment (66622). Refreshment ticks once after 10s into Well Fed (66623), which brings its
// hidden Well Fed (DND) (66624) through spell_linked_spell. With both in the exclusive Well Fed
// spell_group, 66624 removed 66623 as soon as the link applied it, leaving only the hidden aura.
//
// Drive: a bot casts the feast spell (66476) at a spot in front of it, then uses the table it puts down.
// Oracle: Well Fed (66623) shows up on the bot once Refreshment ticks and is still there a few seconds
// later, while Food (65422) is still running.

const (
	feastSpellPlace = uint32(66476)
	feastGameObject = uint32(195303)
	feastSpellEat   = uint32(66477)
	// GAMEOBJECT_FIELD_CREATED_BY (OBJECT_END + 0x0000, two words).
	feastFieldCreatedBy = uint16(0x0006)
	feastAuraFood       = uint32(65422)
	feastAuraWellFed    = uint32(66623)
	feastAuraWellFedDN  = uint32(66624)
)

func TestAura_BountifulFeastGrantsWellFed(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "spells", "aura", "holiday"},
		Runtime:  "short",
		Category: "spells/aura",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Feast",
		Race:   e2eharness.RaceHuman,
		Class:  e2eharness.ClassWarrior,
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.Learn(t, feastSpellPlace)

	// A placed feast outlives its owner's logout for its full 3 minutes and only its owner's party may eat
	// from it, so a table left by an earlier run on this pad would be picked instead of this bot's own.
	// Nearby objects reach the cache only after the teleport is acknowledged, so look for a few seconds.
	if leftover := e2eharness.TryNearbyGameObjectByEntry(t, bot.World, feastGameObject, 3*time.Second); leftover != 0 {
		t.Logf("waiting for an earlier run's feast 0x%X to despawn", leftover)
		deadline := time.Now().Add(190 * time.Second)
		for bot.World.FindGameObjectByEntry(feastGameObject, 40) != 0 {
			if time.Now().After(deadline) {
				e2eharness.Preconditionf(t, "feast 0x%X near the pad never despawned", leftover)
			}
			time.Sleep(time.Second)
		}
	}

	x, y, z, o, _ := bot.World.Position()
	tx := x + 3*float32(math.Cos(float64(o)))
	ty := y + 3*float32(math.Sin(float64(o)))
	if res := bot.CastAtPosition(t, feastSpellPlace, tx, ty, z, 10*time.Second); !res.Success {
		e2eharness.Preconditionf(t, "cast %d failed: %s", feastSpellPlace, e2eharness.SpellFailReasonName(res.FailReason))
	}

	feast := bot.WaitGameObject(t, feastGameObject, 10*time.Second)
	if obj := bot.World.GetObject(feast); obj == nil ||
		uint64(obj.Value(feastFieldCreatedBy))|uint64(obj.Value(feastFieldCreatedBy+1))<<32 != bot.GUID {
		e2eharness.Preconditionf(t, "feast 0x%X was not placed by bot 0x%X", feast, bot.GUID)
	}

	bot.Session.ArmSpellWaiter()
	bot.GameObjectUse(t, feast)
	if res, err := bot.Session.WaitSpellID(feastSpellEat, 5*time.Second); err != nil || !res.Success {
		e2eharness.Preconditionf(t, "eating from feast 0x%X: cast %d result=%+v err=%v", feast, feastSpellEat, res, err)
	}
	if !waitAura(bot, feastAuraFood, 5*time.Second) {
		e2eharness.Preconditionf(t, "no Food (%d) after using feast 0x%X (auras=%v)", feastAuraFood, feast,
			bot.World.SelfAuras())
	}
	eatStart := time.Now()

	// Refreshment ticks once at 10s; give the tick a few world updates of slack.
	if !waitAura(bot, feastAuraWellFed, 14*time.Second) {
		e2eharness.Assertf(t, "no Well Fed (%d) %s after eating started (food=%v auras=%v)", feastAuraWellFed,
			time.Since(eatStart).Round(time.Millisecond), bot.HasAura(feastAuraFood), bot.World.SelfAuras())
	}
	t.Logf("Well Fed (%d) after %s; Well Fed (DND) (%d) present=%v", feastAuraWellFed,
		time.Since(eatStart).Round(time.Millisecond), feastAuraWellFedDN, bot.HasAura(feastAuraWellFedDN))

	time.Sleep(3 * time.Second)
	if !bot.HasAura(feastAuraWellFed) {
		e2eharness.Assertf(t, "Well Fed (%d) gone 3s after it was applied (auras=%v)", feastAuraWellFed,
			bot.World.SelfAuras())
	}
	t.Logf("PASS Bountiful Feast grants Well Fed (%d) and it stays", feastAuraWellFed)
}

func waitAura(bot *e2eharness.ScenarioBot, spellID uint32, timeout time.Duration) bool {
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if bot.HasAura(spellID) {
			return true
		}
		time.Sleep(40 * time.Millisecond)
	}
	return false
}
