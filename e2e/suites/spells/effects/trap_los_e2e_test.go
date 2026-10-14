//go:build e2e

package effects_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	spellFreezingTrapR3  uint32 = 14311  // places GO 164877
	goFreezingTrapR3     uint32 = 164877 // type 1 trap: despawns once it has cast
	spellFreezingTrapFx3 uint32 = 14309  // the freeze the trap casts on its victim

	// Attackable, never dies, no AI and no mechanic immunity.
	trapLOSDummy uint32 = 32171
	// The trap GameObject casts the freeze itself, so the hunter's hit rating does not
	// apply and a level 80 victim resists 4% of the time. Ten levels below the caster
	// puts the hit chance at the cap, so a resist can never pose as the bug.
	trapLOSDummyLevel = 70
)

// Since the trap GameObject casts its own spells (PR #26152), the freeze it casts on
// its victim goes through Spell::CheckEffectTarget's line of sight check with the
// GameObject as caster. The GameObject case there was only recognised through the old
// summoned world trigger, so the check now runs from the trap's own position, level
// with the floor, and also tests dynamic GameObject models. Outdoors the ray only meets
// terrain, which line of sight ignores; on a WMO floor (dungeons, Ironforge) it meets the
// floor itself and the freeze is dropped without any message.
//
// Oracle: a Freezing Trap tripped by a creature standing on it freezes that creature,
// outdoors, on a WMO floor in the open world, and inside an instance.
func TestTrap_FreezingTrapFreezesOnAnyFloor(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "multi_bot"},
		Runtime:  "med",
		Category: "spells/effects",
	})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "TrapLos",
		Bots: []e2eharness.BotSpec{
			{Role: "hunter", Race: e2eharness.RaceDwarf, Class: e2eharness.ClassHunter, Level: 80, LearnAllClass: true},
			// Stays in GM mode, which traps ignore, to spawn the dummy and watch it.
			{Role: "placer", Race: e2eharness.RaceDwarf, Level: 80},
		},
	})
	hunter := e2eharness.ByRole(t, bots, "hunter")
	placer := e2eharness.ByRole(t, bots, "placer")

	// Spawn opens the world DB lazily and ties its Close to the calling subtest; opening it
	// here keeps spawn cleanup working in every subtest, not only the first.
	worldDB, err := e2eharness.OpenWorldDB()
	if err != nil {
		e2eharness.HarnessFailf(t, "open world DB: %v", err)
	}
	t.Cleanup(func() { _ = worldDB.Close() })
	placer.WorldDB = worldDB

	pad := e2eharness.PackagePad(t)
	// Grouped so both bots land in the same Deadmines instance.
	e2eharness.FormPartyAtPad(t, pad, hunter, placer)

	hunter.Learn(t, spellFreezingTrapR3)
	if !hunter.World.KnowsSpell(spellFreezingTrapR3) {
		e2eharness.Preconditionf(t, "hunter does not know Freezing Trap %d", spellFreezingTrapR3)
	}
	hunter.CombatReady(t)

	for _, tc := range []struct {
		name  string
		place func(t *testing.T, b *e2eharness.ScenarioBot)
	}{
		{"OutdoorTerrain", func(t *testing.T, b *e2eharness.ScenarioBot) { b.TeleportPad(t, pad) }},
		{"IronforgeWMOFloor", func(t *testing.T, b *e2eharness.ScenarioBot) { b.TeleNamed(t, "Ironforge") }},
		{"DeadminesInstance", func(t *testing.T, b *e2eharness.ScenarioBot) { b.TeleNamed(t, "Deadmines") }},
	} {
		t.Run(tc.name, func(t *testing.T) {
			tc.place(t, hunter)
			tc.place(t, placer)

			dummy := placer.Spawn(t, trapLOSDummy, 15*time.Second)
			if dummy == 0 {
				e2eharness.Preconditionf(t, "failed to spawn dummy %d", trapLOSDummy)
			}
			_ = placer.World.SetTarget(dummy)
			placer.GM(t, fmt.Sprintf(".npc set level %d", trapLOSDummyLevel))
			placer.FlushWorld(t)

			hunter.GM(t, ".cooldown")
			hunter.CastMust(t, spellFreezingTrapR3, 0, 10*time.Second)
			trap := waitTrapGO(placer, true, 5*time.Second)
			if trap == 0 {
				e2eharness.Preconditionf(t, "Freezing Trap GO %d never appeared", goFreezingTrapR3)
			}

			if waitUnitAuraFor(placer, dummy, spellFreezingTrapFx3, 6*time.Second) {
				t.Logf("PASS %s: Freezing Trap froze dummy 0x%X", tc.name, dummy)
				return
			}
			// The trap despawns once it has cast; one still standing never triggered.
			if waitTrapGO(placer, false, 2*time.Second) != 0 {
				e2eharness.Preconditionf(t, "%s: trap 0x%X never triggered on dummy 0x%X", tc.name, trap, dummy)
			}
			e2eharness.Assertf(t, "%s: trap 0x%X fired and despawned but dummy 0x%X never got freeze %d",
				tc.name, trap, dummy, spellFreezingTrapFx3)
		})
	}
}

// waitTrapGO waits for the hunter's trap to be present (want=true, returns its GUID) or
// gone (want=false, returns 0 once gone) in bot's object cache.
func waitTrapGO(bot *e2eharness.ScenarioBot, want bool, timeout time.Duration) uint64 {
	deadline := time.Now().Add(timeout)
	for {
		g := bot.World.FindGameObjectByEntry(goFreezingTrapR3, 10)
		if (g != 0) == want || !time.Now().Before(deadline) {
			return g
		}
		time.Sleep(40 * time.Millisecond)
	}
}

func waitUnitAuraFor(bot *e2eharness.ScenarioBot, guid uint64, spellID uint32, timeout time.Duration) bool {
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if bot.UnitHasAura(guid, spellID) {
			return true
		}
		time.Sleep(40 * time.Millisecond)
	}
	return false
}
