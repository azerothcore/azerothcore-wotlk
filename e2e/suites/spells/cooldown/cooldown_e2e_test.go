//go:build e2e

package cooldown_test

import (
	"database/sql"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	spellHeroism    = uint32(32182) // own 5 min recovery, no category
	spellExhaustion = uint32(57723) // Heroism's caster debuff, blocks a recast on its own
	spellEarthShock = uint32(49231) // category 19, 6s category recovery, shaman family
	spellFrostShock = uint32(49236) // category 19, shaman family
	spellFireBlast  = uint32(42873) // category 19, mage family

	failNotReady = uint8(67) // SPELL_FAILED_NOT_READY

	// The global cooldown never exceeds 1.5s; waiting it out keeps a NOT_READY reply down to the
	// spell's own or category cooldown.
	gcdWait = 1600 * time.Millisecond
	// Earth Shock's category recovery; the category checks must land before it ends.
	shockCategoryRecovery = 6 * time.Second
)

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/28578
// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/28429
// A spell cooldown is saved with its end time and still blocks the spell after a relog,
// through the SpellHistory save and load path that replaced the uint32 cooldown storage.
func TestCooldown_SurvivesRelog(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells"}, Runtime: "short", Issue: 28429, Category: "spells/cooldown"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "CdRelog",
		Race:          e2eharness.RaceDraenei,
		Class:         e2eharness.ClassShaman,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.CheatPower(t)
	bot.FlushWorld(t)

	castAt := time.Now()
	bot.CastMust(t, spellHeroism, 0, 10*time.Second)
	_ = bot.World.SetTarget(bot.GUID)
	bot.GM(t, ".unaura 57723")

	// The logout save writes the cooldown; the next login loads it back
	bot.Relog(t)
	bot.CheatPower(t)
	bot.FlushWorld(t)

	// The table stores whole seconds; the cast lands within a second of castAt
	end := waitSavedCooldownEnd(t, bot.CharDB, bot.GUID, spellHeroism, 20*time.Second)
	drift := end.Sub(castAt.Add(5 * time.Minute))
	if drift < -2*time.Second || drift > 2*time.Second {
		e2eharness.Assertf(t, "saved Heroism cooldown ends %s off the cast time + 5 min", drift)
	}
	t.Logf("saved Heroism cooldown ends %s, %s off the cast time + 5 min", end.Format(time.TimeOnly), drift)
	if bot.HasAura(spellExhaustion) {
		e2eharness.Preconditionf(t, "Exhaustion still on the shaman after relog, a recast would fail on it")
	}

	res := bot.Cast(t, spellHeroism, 0, 10*time.Second)
	if res.Success || res.FailReason != failNotReady {
		e2eharness.Assertf(t, "Heroism after relog: success=%v reason=%s, want NOT_READY from the loaded cooldown",
			res.Success, e2eharness.SpellFailReasonName(res.FailReason))
	}
	t.Logf("PASS Heroism stays on cooldown after relog (reason=%s)", e2eharness.SpellFailReasonName(res.FailReason))
}

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/28578
// A category cooldown blocks the other spells of the category in the same spell family only:
// Earth Shock holds Frost Shock, not Fire Blast, though all three share category 19. Fire Blast
// starting its own category 19 cooldown must not lift the shaman's block either, and Frost Shock
// is castable again once Earth Shock's category recovery ends.
func TestCooldown_CategoryBlocksOwnSpellFamilyOnly(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells"}, Runtime: "short", Category: "spells/cooldown"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "CdCat",
		Race:          e2eharness.RaceDraenei,
		Class:         e2eharness.ClassShaman,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.Learn(t, spellFireBlast)
	bot.CombatReadyFull(t)

	dummy := bot.Spawn(t, e2eharness.CreatureHeroicTrainingDummy, 15*time.Second)
	bot.Face(t, dummy)

	bot.CastMust(t, spellEarthShock, dummy, 10*time.Second)
	shockAt := time.Now()
	time.Sleep(gcdWait)

	res := bot.Cast(t, spellFrostShock, dummy, 10*time.Second)
	if res.Success || res.FailReason != failNotReady {
		e2eharness.Assertf(t, "Frost Shock after Earth Shock: success=%v reason=%s, want NOT_READY from category 19",
			res.Success, e2eharness.SpellFailReasonName(res.FailReason))
	}

	bot.CastMust(t, spellFireBlast, dummy, 10*time.Second)
	time.Sleep(gcdWait)

	res = bot.Cast(t, spellFrostShock, dummy, 10*time.Second)
	if time.Since(shockAt) >= shockCategoryRecovery {
		e2eharness.Preconditionf(t, "category checks took %s, past Earth Shock's category recovery", time.Since(shockAt).Round(time.Millisecond))
	}
	if res.Success || res.FailReason != failNotReady {
		e2eharness.Assertf(t, "Frost Shock after Fire Blast: success=%v reason=%s, want NOT_READY, Earth Shock's block still running",
			res.Success, e2eharness.SpellFailReasonName(res.FailReason))
	}

	time.Sleep(time.Until(shockAt.Add(shockCategoryRecovery + 500*time.Millisecond)))
	bot.CastMust(t, spellFrostShock, dummy, 10*time.Second)
	t.Logf("PASS category 19 blocked Frost Shock, not Fire Blast, and released it after %s", shockCategoryRecovery)
}

// waitSavedCooldownEnd polls the characters DB until the logout save stored the spell's cooldown.
func waitSavedCooldownEnd(t *testing.T, db *sql.DB, guid uint64, spellID uint32, timeout time.Duration) time.Time {
	t.Helper()
	var end int64
	var err error
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		err = db.QueryRow(`SELECT time FROM character_spell_cooldown WHERE guid = ? AND spell = ?`, uint32(guid), spellID).Scan(&end)
		if err == nil {
			return time.Unix(end, 0)
		}
		time.Sleep(250 * time.Millisecond)
	}
	e2eharness.Preconditionf(t, "no character_spell_cooldown row for spell %d after logout: %v", spellID, err)
	return time.Time{}
}
