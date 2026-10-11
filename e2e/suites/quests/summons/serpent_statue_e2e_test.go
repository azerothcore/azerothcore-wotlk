//go:build e2e

package summons_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	serpentStatue     uint32 = 177673 // GO, type BUTTON, Ranazjar Isle
	serpentStatueGUID        = 12609  // its single gameobject.guid spawn
	nagaBeam          uint32 = 177705 // GO summoned by the statue, cosmetic
	lordKragaru       uint32 = 12369  // drops Book of the Ancients (15803)

	statueX  float32 = 252.513
	statueY  float32 = 2963.7
	statueZ  float32 = 1.64204
	kalimdor uint32  = 1

	// The statue summons the beam, then Lord Kragaru 3500ms later.
	summonWindow = 10 * time.Second

	// Long enough for the gameobject to tick once and drop the finished action list.
	settleBetweenActivations = 500 * time.Millisecond

	// One activation is not a regression test: the bug this guards against was
	// probabilistic (measured 4/16 on unfixed data), so a single success proves
	// nothing. Six consecutive successes put a regression under ~2%.
	activations = 6
)

// Quest 6027 "Book of the Ancients" hands out a Gem of the Serpent to place on the
// Serpent Statue on Ranazjar Isle. That must summon Lord Kragaru, who carries the
// book; without him the quest cannot be completed.
//
// The summon used to hang off the Naga Beam, a gameobject the statue summons for
// four seconds. SMART_ACTION_SUMMON_GO's despawn parameter is in whole seconds and
// lands in GameObject::SetRespawnTime, which adds it to the second-granular
// GameTime clock, so the beam's real lifetime was anywhere in (3.0s, 4.0s] and it
// was frequently deleted before its own 3500ms summon timer fired.
//
// Both halves are asserted: the beam is the visual the player reports seeing, so
// separating "beam appeared" from "Kragaru appeared" tells a failing run which of
// the two scripts broke.
func TestQuest6027_SerpentStatueSummonsKragaru(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "quests", "serial"},
		Runtime:  "med",
		Category: "quests/summons",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "Serp"})
	e2eharness.TeleportGo(t, bot.World, statueX, statueY+6, statueZ, kalimdor)

	statue := bot.WaitGameObject(t, serpentStatue, 15*time.Second)

	// Any use leaves the statue in GO_ACTIVATED for button.autoCloseTime (60s), and
	// UseDoorOrButton is a no-op until it resets — so a previous run, or a player who
	// just clicked it, would make the real click below silently do nothing.
	// .gobject activate forces GO_READY and re-uses it with a 10s autoclose instead,
	// which bounds the wait to that rather than a minute.
	e2eharness.MustGM(t, bot.World, fmt.Sprintf(".gobject activate %d", serpentStatueGUID))
	time.Sleep(12 * time.Second)

	// Every successful summon is a new ObjectGuid. Counting distinct guids rather
	// than "is a Kragaru nearby" keeps earlier summons from satisfying later
	// activations — on unfixed data that would mask exactly the failures we hunt.
	seen := map[uint64]bool{}
	for _, u := range bot.World.GetNearbyUnits(100) {
		if u.Entry == lordKragaru {
			seen[u.GUID] = true
		}
	}

	for i := 1; i <= activations; i++ {
		prevBeam := bot.World.FindGameObjectByEntry(nagaBeam, 0)

		if i == 1 {
			// The player path: CMSG_GAMEOBJ_USE reaches GameObject::Use, which for a
			// BUTTON calls UseDoorOrButton -- the same call the gem's OpenLock effect
			// makes through Spell::SendLoot. Only the first activation can afford it:
			// it leaves the full 60s autoclose behind.
			bot.GameObjectUse(t, statue)
		} else {
			// Same UseDoorOrButton call, reached past that autoclose.
			e2eharness.MustGM(t, bot.World, fmt.Sprintf(".gobject activate %d", serpentStatueGUID))
		}

		beam, summoned := uint64(0), uint64(0)
		deadline := time.Now().Add(summonWindow)
		for time.Now().Before(deadline) {
			// Require a beam this activation did not inherit. Its lifetime overlaps the
			// next activation, so matching on entry alone would let the previous one
			// stand in and hide an intermittent break of the summon-GO row.
			if beam == 0 {
				if g := bot.World.FindGameObjectByEntry(nagaBeam, 0); g != 0 && g != prevBeam {
					beam = g
				}
			}
			for _, u := range bot.World.GetNearbyUnits(100) {
				if u.Entry == lordKragaru && !seen[u.GUID] {
					seen[u.GUID] = true
					summoned = u.GUID
				}
			}
			if summoned != 0 {
				break
			}
			time.Sleep(50 * time.Millisecond)
		}

		if beam == 0 {
			e2eharness.Assertf(t, "activation %d/%d: Serpent Statue (%d) did not summon the Naga Beam (%d); "+
				"the statue's own script is broken, before any Kragaru summon can run",
				i, activations, serpentStatue, nagaBeam)
		}
		if summoned == 0 {
			e2eharness.Assertf(t, "activation %d/%d: Serpent Statue (%d) did not summon Lord Kragaru (%d) within %s; "+
				"without him the Book of the Ancients (15803) never drops and quest 6027 cannot be completed",
				i, activations, serpentStatue, lordKragaru, summonWindow)
		}
		t.Logf("activation %d/%d: beam 0x%X lit, Lord Kragaru summoned guid=0x%X",
			i, activations, beam, summoned)

		// SetScript9 refuses a new action list while one is still registered
		// (allowOverride = 0), and the finished list is only dropped on the
		// gameobject's next update tick. Re-activating inside that tick would be
		// ignored — a beam, since that hangs off the link, but no Kragaru. A player
		// cannot reach this: the 60s autoclose forbids back-to-back use, and only a
		// GM force-reset gets here. Give the statue its tick.
		time.Sleep(settleBetweenActivations)
	}
}
