//go:build e2e

package trial_of_the_crusader_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	npcEydis = uint32(34496)
	npcFjola = uint32(34497)

	spellTwinEmpathyDark  = uint32(66132)
	spellTwinEmpathyLight = uint32(66133)
	spellLightTwinPact    = uint32(65876)
)

// spawnTemp summons a temp creature at the bot and returns the new living unit, deleted on cleanup.
// Encounter intros need Barrett's gossip, which the harness cannot send, so the instance never
// summons the bosses itself.
func spawnTemp(t *testing.T, bot *e2eharness.ScenarioBot, entry uint32) uint64 {
	t.Helper()

	known := map[uint64]struct{}{}
	for _, u := range bot.UnitsByEntry(0, entry) {
		known[u.GUID] = struct{}{}
	}

	e2eharness.SpawnNPC(t, bot.World, entry)
	var guid uint64
	for deadline := time.Now().Add(20 * time.Second); guid == 0 && time.Now().Before(deadline); time.Sleep(sampleEvery) {
		for _, u := range bot.UnitsByEntry(0, entry) {
			if _, old := known[u.GUID]; !old && u.Health > 0 {
				guid = u.GUID
				break
			}
		}
	}
	if guid == 0 {
		e2eharness.Preconditionf(t, "no new living %d after .npc add temp", entry)
	}
	t.Cleanup(func() {
		if hp, _ := bot.UnitHP(guid); hp == 0 {
			return
		}
		if err := bot.World.SetTarget(guid); err == nil {
			bot.GM(t, ".npc delete")
		}
	})
	return guid
}

// waitTwinHealth waits until both twins report a health other than the given previous values and
// the two agree, then returns them. Shared damage and Twin's Pact land on both in the same tick.
func waitTwinHealth(bot *e2eharness.ScenarioBot, fjola, eydis uint64, prevF, prevE uint32, timeout time.Duration) (hpF, hpE uint32) {
	for deadline := time.Now().Add(timeout); time.Now().Before(deadline); time.Sleep(50 * time.Millisecond) {
		hpF, _ = bot.UnitHP(fjola)
		hpE, _ = bot.UnitHP(eydis)
		if hpF != prevF && hpE != prevE && hpF == hpE {
			return hpF, hpE
		}
	}
	return hpF, hpE
}

// Fjola Lightbane and Eydis Darkbane share one health pool. Once both are summoned each carries her
// sister's Twin Empathy, which copies every point of damage she takes to the sister. Twin's Pact
// heals the caster and her sister, which needs a conditions row for its nearby-entry effect.
//
// Drive: temp twins are pulled with `.damage`, which ignores their NON_ATTACKABLE flag; each is
// then hit for a quarter of her health, and Fjola is made to cast Twin's Pact through `.cast self`.
// Oracle: Eydis carries 66132 and Fjola 66133 before the pull, the pull and a hit on either twin
// take the same health off both, and the Pact heals both by the same amount.
func TestToC_TwinValkyrShareHealth(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances"},
		Runtime:  "med",
		Category: "instances/northrend/trial_of_the_crusader",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "TwnVlk", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})

	// Stay GM through the raid enter (.go xyz onto a raid map is ignored after .gm off).
	bot.Teleport(t, centerX, centerY, centerZ, mapTrialOfTheCrusader)
	if _, _, _, m := bot.Pos(); m != mapTrialOfTheCrusader {
		e2eharness.Preconditionf(t, "bot not in Trial of the Crusader after tele map=%d", m)
	}
	bot.WaitUnit(t, npcTirion, 20*time.Second)

	fjola := spawnTemp(t, bot, npcFjola)
	eydis := spawnTemp(t, bot, npcEydis)
	t.Logf("Fjola guid=0x%X Eydis guid=0x%X", fjola, eydis)

	hpF, maxF := bot.UnitHP(fjola)
	hpE, maxE := bot.UnitHP(eydis)
	if hpF != maxF || hpE != maxE || maxF != maxE {
		e2eharness.Preconditionf(t, "twins must start full on one pool: Fjola %d/%d, Eydis %d/%d", hpF, maxF, hpE, maxE)
	}

	for _, c := range []struct {
		name  string
		guid  uint64
		spell uint32
	}{
		{"Eydis", eydis, spellTwinEmpathyDark},
		{"Fjola", fjola, spellTwinEmpathyLight},
	} {
		for deadline := time.Now().Add(5 * time.Second); !bot.UnitHasAura(c.guid, c.spell) && time.Now().Before(deadline); {
			time.Sleep(sampleEvery)
		}
		if !bot.UnitHasAura(c.guid, c.spell) {
			e2eharness.Assertf(t, "%s 0x%X has no Twin Empathy (%d) from her sister before the pull", c.name, c.guid, c.spell)
		}
	}
	t.Logf("each twin carries her sister's Twin Empathy before the pull")

	// Out of GM mode so the twins engage the bot; god keeps it up through the fight. The pull hit
	// lands before either twin engages, so only an aura applied at spawn shares it.
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true})
	bot.Damage(t, fjola, 1)
	bot.WaitUnitCombat(t, fjola, 10*time.Second)
	bot.WaitUnitCombat(t, eydis, 10*time.Second)

	hpF, _ = bot.UnitHP(fjola)
	hpE, _ = bot.UnitHP(eydis)
	if hpF != hpE {
		e2eharness.Assertf(t, "the 1-point pull left the twins apart: Fjola %d, Eydis %d", hpF, hpE)
	}

	hit := maxF / 4
	for _, c := range []struct {
		name string
		guid uint64
	}{
		{"Fjola", fjola},
		{"Eydis", eydis},
	} {
		bot.Damage(t, c.guid, hit)
		newF, newE := waitTwinHealth(bot, fjola, eydis, hpF, hpE, 3*time.Second)
		if newF != newE || hpF-newF != hit || hpE-newE != hit {
			e2eharness.Assertf(t, "hitting %s for %d moved Fjola %d->%d and Eydis %d->%d; both must lose exactly %d",
				c.name, hit, hpF, newF, hpE, newE, hit)
		}
		t.Logf("hitting %s for %d took both twins to %d", c.name, hit, newF)
		hpF, hpE = newF, newE
	}

	// Not `triggered`: the command's debug trigger mask skips spell effects, so the heal would
	// never land. The Pact is a 15s cast.
	if err := bot.World.SetTarget(fjola); err != nil {
		e2eharness.HarnessFailf(t, "SetTarget Fjola before .cast self: %v", err)
	}
	bot.GM(t, fmt.Sprintf(".cast self %d", spellLightTwinPact))
	newF, newE := waitTwinHealth(bot, fjola, eydis, hpF, hpE, 20*time.Second)
	if newF <= hpF || newE <= hpE || newF != newE || newF-hpF != newE-hpE {
		e2eharness.Assertf(t, "Twin's Pact (%d) from Fjola moved Fjola %d->%d and Eydis %d->%d; it must heal both by the same amount",
			spellLightTwinPact, hpF, newF, hpE, newE)
	}
	t.Logf("Twin's Pact healed both twins by %d to %d", newF-hpF, newF)

	// Killing them runs their death cleanup, which despawns the orbs Fjola summons once engaged.
	bot.DamageKill(t, []uint64{fjola, eydis}, 0, 15*time.Second)
	t.Logf("PASS the twins share one health pool through Twin Empathy, and Twin's Pact heals both")
}
