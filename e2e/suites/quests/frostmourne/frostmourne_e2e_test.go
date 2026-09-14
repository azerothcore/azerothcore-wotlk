//go:build e2e

package frostmourne_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/25760
//
// Quest 12478 "Frostmourne Cavern": Zelig's Scrying Orb (item 37933, spell 49817,
// spell_q12478_frostmourne_cavern) summons Prince Arthas (27455). His SmartAI
// actionlist 2745500 reveals him, summons Muradin (27480) and plays the vision;
// Muradin's list 2748000 ends by taking quest credit and leaving the cavern.
//
// The dialogue itself is monster say, which this harness cannot observe, so the
// line ordering and the removal of the duplicated line are not asserted here — see
// the gap noted in e2e/README.md. What this covers is the half with a
// protocol-visible oracle, and it is the half a single manual playthrough is worst
// at checking:
//
//   - the vision starts at all, and Arthas summons Muradin;
//   - Muradin leaves the cavern under his own movement instead of vanishing where
//     he was knocked down, which is what the reworked ending added;
//   - quest 12478 reaches COMPLETE, guarding the credit cast (spell 49829) that
//     moved six and a half seconds later and now sits shortly before his despawn;
//   - neither actor is leaked afterwards. Both are TEMPSUMMON_MANUAL_DESPAWN, so
//     their only despawn is the last step of a long timed chain.
func TestAC_25760_FrostmourneCavernVisionCompletes(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "quests", "ai", "issue", "serial"},
		Runtime:  "med",
		Issue:    25760,
		Category: "quests/frostmourne",
	})

	const (
		questFrostmourneCavern = uint32(12478)
		spellScryingOrb        = uint32(49817)
		npcArthas              = uint32(27455)
		npcMuradin             = uint32(27480)
		mapNorthrend           = uint32(571)
	)
	const (
		// Arthas's summon position, hardcoded in spell_q12478_frostmourne_cavern, so the
		// bot stands exactly where he materialises and distances below start there.
		orbX, orbY, orbZ = float32(4821.3), float32(-580.14), float32(163.541)
		// Muradin is knocked down beside the dais; his exit ends ~56 yd away,
		// mostly south with a westward drift.
		// "Still loaded but no longer beside us" is what distinguishes leaving
		// from despawning on the spot.
		nearRadius = float32(30)
		farRadius  = float32(250)
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "Frost", Level: 80})
	bot.AddQuest(t, questFrostmourneCavern)
	bot.Teleport(t, orbX, orbY, orbZ, mapNorthrend)

	// Leftovers from an earlier run would satisfy the presence checks below.
	bot.DespawnNearbyEntry(t, npcArthas, farRadius)
	bot.DespawnNearbyEntry(t, npcMuradin, farRadius)

	// The orb's effect is SPELL_EFFECT_SEND_EVENT; casting it via GM avoids
	// needing a real item-use packet.
	bot.GM(t, fmt.Sprintf(".cast %d", spellScryingOrb))

	arthas := bot.WaitUnit(t, npcArthas, 30*time.Second)
	if arthas == 0 {
		e2eharness.Preconditionf(t, "orb spell %d summoned no Arthas %d", spellScryingOrb, npcArthas)
	}
	muradin := bot.WaitUnit(t, npcMuradin, 30*time.Second)
	if muradin == 0 {
		e2eharness.Assertf(t, "Arthas %d never summoned Muradin %d", npcArthas, npcMuradin)
	}
	t.Logf("vision started arthas=0x%X muradin=0x%X", arthas, muradin)

	// Muradin is knocked down at ~86s, back on his feet at ~99s, speaks at ~104s
	// and ~107s, then takes credit and runs out at ~112s, despawning at ~120s.
	// He is only loaded-but-distant for about four seconds of that, so poll well
	// inside the window: the loop body is two in-memory object-cache lookups and
	// is not rate limited.
	var (
		leftTheCavern bool
		muradinGone   bool
	)
	deadline := time.Now().Add(160 * time.Second)
	for time.Now().Before(deadline) {
		near := bot.FindUnit(npcMuradin, nearRadius)
		far := bot.FindUnit(npcMuradin, farRadius)
		if far != 0 && near == 0 {
			leftTheCavern = true
		}
		if far == 0 && leftTheCavern {
			muradinGone = true
			break
		}
		time.Sleep(400 * time.Millisecond)
	}

	if !leftTheCavern {
		e2eharness.Assertf(t,
			"Muradin %d never moved away before despawning - the ending should walk him out of the cavern",
			npcMuradin)
	}
	if !muradinGone {
		e2eharness.Assertf(t,
			"Muradin %d still loaded after the vision - TEMPSUMMON_MANUAL_DESPAWN summon was leaked",
			npcMuradin)
	}

	if bot.FindUnit(npcArthas, farRadius) != 0 {
		e2eharness.Assertf(t, "Arthas %d still loaded after the vision", npcArthas)
	}

	st, ok := bot.QuestStatusAfterSave(t, questFrostmourneCavern)
	if !ok {
		e2eharness.Assertf(t, "quest %d not in the character's log after the vision", questFrostmourneCavern)
	}
	if st != e2eharness.QuestStatusComplete {
		e2eharness.Assertf(t,
			"quest %d status %d, want %d COMPLETE - the credit cast did not land",
			questFrostmourneCavern, st, e2eharness.QuestStatusComplete)
	}

	bot.AssertWorldAlive(t)
	t.Logf("PASS vision completed, Muradin left and despawned, quest %d COMPLETE", questFrostmourneCavern)
}
