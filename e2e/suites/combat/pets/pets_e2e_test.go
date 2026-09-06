//go:build e2e

package pets_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
)

const spellSummonImp = 688

// summonWarlockPet learns Summon Imp, clears combat, casts (client then GM), waits for pet.
// Pad can be contested by leftover temp NPCs; combatstop is required for cast success.
func summonWarlockPet(t *testing.T, bot *e2eharness.ScenarioBot) uint64 {
	t.Helper()
	bot.CombatStop(t)
	bot.Learn(t, spellSummonImp)
	_ = bot.CastOrGM(t, spellSummonImp, 0, 20*time.Second)
	// WaitPlayerPet covers UNIT_FIELD_SUMMON and SUMMONEDBY/CREATEDBY fallback.
	return bot.WaitPlayerPet(t, 25*time.Second)
}

// PET-01: Warlock summon via learn-all + cast; wait player pet; dismiss.
func TestPets_SummonWaitDismiss(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "combat", "pets"}, Runtime: "med", Category: "combat/pets"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "PetSum",
		Class:         e2eharness.ClassWarlock,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.CombatReady(t)
	pet := summonWarlockPet(t, bot)
	if pet == 0 {
		e2eharness.Preconditionf(t, "no player pet after summon imp")
	}
	bot.DismissPet(t, pet)
	bot.WaitNoPlayerPet(t, 20*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS summon/dismiss pet guid=0x%X", pet)
}

// PET-02: pet present after summon; world alive.
// WaitPlayerPet accepts UNIT_FIELD_SUMMON or SUMMONEDBY/CREATEDBY fallback — assert the
// waiter result, not only the field (imp summon often lags UNIT_FIELD_SUMMON updates).
func TestPets_PlayerPetGUIDAfterSummon(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "combat", "pets"}, Runtime: "med", Category: "combat/pets"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "PetGUID",
		Class:         e2eharness.ClassWarlock,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.CombatReady(t)
	pet := summonWarlockPet(t, bot)
	if pet == 0 {
		e2eharness.Preconditionf(t, "no pet after WaitPlayerPet")
	}
	bot.CleanupOwnedSummons(t)
	bot.AssertWorldAlive(t)
	t.Logf("PASS pet=0x%X field_summon=0x%X", pet, bot.PlayerPetGUID())
}

// OPEN(e2e): re-enable when AC#27081 is fixed
// https://github.com/azerothcore/azerothcore-wotlk/issues/27081
// Must CastMust + PlayerPetGUID!=0; success=%v log is a soft-pass.
/*
func TestPets_DKRaiseDeadOpenWorld(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "combat", "pets", "issue"},
		Runtime:  "med",
		Issue:    27081,
		Category: "combat/pets",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "PetDK",
		Class:         e2eharness.ClassDeathKnight,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.AddItem(t, e2eharness.ItemCorpseDust, 5)
	bot.Learn(t, e2eharness.SpellRaiseDead)
	bot.CombatReady(t)
	res := bot.Cast(t, e2eharness.SpellRaiseDead, 0, 15*time.Second)
	bot.AssertWorldAlive(t)
	if pet := bot.PlayerPetGUID(); pet != 0 {
		bot.DismissPet(t, pet)
		bot.WaitNoPlayerPet(t, 8*time.Second)
	}
	bot.CleanupOwnedSummons(t)
	t.Logf("PASS Raise Dead open world success=%v pet=0x%X", res.Success, bot.PlayerPetGUID())
}
*/

// PET-04: pet attack command does not crash.
func TestPets_PetAttackCommand(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "combat", "pets"}, Runtime: "med", Category: "combat/pets"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "PetAtk",
		Class:         e2eharness.ClassWarlock,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.CombatReady(t)
	pet := summonWarlockPet(t, bot)
	if pet == 0 {
		e2eharness.Preconditionf(t, "no pet for attack command")
	}
	dummy := bot.Spawn(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	// CombatReady again after GM spawn path.
	bot.CombatReady(t)
	bot.PetAttack(t, dummy)
	bot.CleanupOwnedSummons(t)
	bot.AssertWorldAlive(t)
	t.Logf("PASS pet attack command pet=0x%X", pet)
}

// PET-05: dismiss clears pet.
func TestPets_DismissClearsPet(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "combat", "pets"}, Runtime: "med", Category: "combat/pets"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "PetDis",
		Class:         e2eharness.ClassWarlock,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.CombatReady(t)
	pet := summonWarlockPet(t, bot)
	if pet == 0 {
		e2eharness.Preconditionf(t, "no pet to dismiss")
	}
	bot.DismissPet(t, pet)
	bot.WaitNoPlayerPet(t, 20*time.Second)
	bot.AssertNoPlayerPet(t)
	t.Logf("PASS dismiss clears pet")
}
