//go:build e2e

package aura_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Spells driving the scenario. Aura Mastery (31821) is a Holy talent, not taught
// by `.learn all my class`, so it is learned explicitly below.
const (
	spellConcentrationAura = uint32(19746)
	spellAuraMastery       = uint32(31821)
	spellAuraMasteryImmune = uint32(64364) // immunity Aura Mastery casts over Concentration Aura
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/25765
//
// Two grouped paladins both running Concentration Aura: each paladin's aura must
// apply to the group independently (per-caster). Before the server-side stacking
// fix, the second paladin's same-rank aura was suppressed by the first's, so that
// paladin's Aura Mastery never reached anyone.
//
// Oracle: palB (activated second) turns on Aura Mastery. Its immunity aura 64364
// only lands on targets carrying palB's own Concentration Aura (19746 cast by
// palB, see spell_pal_aura_mastery_immune::CheckAreaTarget). palA gaining 64364
// therefore proves palB's Concentration Aura reached palA instead of being
// suppressed — on an unfixed core palA never gets 64364.
func TestAC_25765_PaladinAuraMasteryPerCasterInGroup(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "issue", "multi_bot"},
		Runtime:  "med",
		Issue:    25765,
		Category: "spells/aura",
	})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "AuraGrp",
		Bots: []e2eharness.BotSpec{
			{Role: "palA", Race: e2eharness.RaceHuman, Class: e2eharness.ClassPaladin, Level: 80, LearnAllClass: true},
			{Role: "palB", Race: e2eharness.RaceHuman, Class: e2eharness.ClassPaladin, Level: 80, LearnAllClass: true},
		},
	})
	palA := e2eharness.ByRole(t, bots, "palA")
	palB := e2eharness.ByRole(t, bots, "palB")

	pad := e2eharness.PackagePad(t)
	e2eharness.FormPartyAtPad(t, pad, palA, palB)
	defer e2eharness.DisbandParty(t, palA, palB)

	if !palA.InGroup() || !palB.InGroup() {
		e2eharness.Preconditionf(t, "paladins not grouped palA=%v palB=%v", palA.InGroup(), palB.InGroup())
	}

	// palA activates Concentration Aura first. Its aura reaches palB, which is the
	// pre-fix state that used to suppress palB's own same-rank aura.
	palA.Learn(t, spellConcentrationAura)
	palA.CastMust(t, spellConcentrationAura, 0, 10*time.Second)
	palB.WaitUnitAura(t, palB.GUID, spellConcentrationAura, 8*time.Second)

	// palB activates its own Concentration Aura while palA's is already on the party.
	palB.Learn(t, spellConcentrationAura)
	palB.CastMust(t, spellConcentrationAura, 0, 10*time.Second)
	if !palB.HasAura(spellConcentrationAura) {
		e2eharness.Preconditionf(t, "palB lost Concentration Aura %d", spellConcentrationAura)
	}

	// palB turns on Aura Mastery. Require it to be usable before judging the oracle.
	palB.Learn(t, spellAuraMastery)
	if res := palB.Cast(t, spellAuraMastery, 0, 10*time.Second); !res.Success {
		e2eharness.Preconditionf(t, "Aura Mastery %d cast failed (reason=%s)", spellAuraMastery,
			e2eharness.SpellFailReasonName(res.FailReason))
	}
	if !waitForSelfAura(palB, spellAuraMastery, 8*time.Second) {
		e2eharness.Preconditionf(t, "Aura Mastery %d not applied on palB after successful cast", spellAuraMastery)
	}

	if !waitForSelfAura(palA, spellAuraMasteryImmune, 8*time.Second) {
		e2eharness.ConfirmedBugf(t, 25765,
			"palA never gained Aura Mastery Immune %d from palB — palB's Concentration Aura %d was not applied to palA (two paladins, same aura)",
			spellAuraMasteryImmune, spellConcentrationAura)
	}
	t.Logf("PASS AC#25765 palB's Concentration Aura reached palA; Aura Mastery immunity %d applied per-caster",
		spellAuraMasteryImmune)
}

// waitForSelfAura polls the bot's own aura cache until spellID is present or the
// timeout elapses. Harness provides WaitUnitAura (fatal) and WaitAuraGone (gone),
// neither of which fits a soft presence wait feeding a severity helper.
func waitForSelfAura(bot *e2eharness.ScenarioBot, spellID uint32, timeout time.Duration) bool {
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if bot.HasAura(spellID) {
			return true
		}
		time.Sleep(50 * time.Millisecond)
	}
	return false
}
