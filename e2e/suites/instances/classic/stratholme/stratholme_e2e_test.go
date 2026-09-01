//go:build e2e

package stratholme_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	npcTimmyTheCruel   = uint32(10808)
	npcCrimsonInitiate = uint32(10420)

	stratholmeMap        = uint32(329)
	triggerRadius        = float32(55)
	activationCheckEvery = 10 * time.Second
)

var timmyActivationEntries = []uint32{10418, 10419, 10420, 10424}

func waitForTimmyActivationSet(t *testing.T, bot *e2eharness.ScenarioBot, timeout time.Duration) []uint64 {
	t.Helper()

	want := map[uint32]int{
		10418: 8,
		10419: 3,
		10420: 2,
		10424: 2,
	}
	ticker := time.NewTicker(100 * time.Millisecond)
	defer ticker.Stop()
	timer := time.NewTimer(timeout)
	defer timer.Stop()

	var got map[uint32]int
	for {
		got = e2eharness.CountLivingByEntry(bot.World, triggerRadius, timmyActivationEntries...)
		complete := true
		for entry, count := range want {
			if got[entry] != count {
				complete = false
				break
			}
		}
		if complete {
			return e2eharness.LivingByEntries(bot.World, triggerRadius, timmyActivationEntries...)
		}

		select {
		case <-ticker.C:
		case <-timer.C:
			e2eharness.Preconditionf(t, "Timmy activation area did not load completely within %s: got=%v want=%v", timeout, got, want)
			return nil
		}
	}
}

func assertTimmyAbsentWhileAlive(t *testing.T, bot *e2eharness.ScenarioBot, survivor uint64, window time.Duration) {
	t.Helper()

	ticker := time.NewTicker(100 * time.Millisecond)
	defer ticker.Stop()
	timer := time.NewTimer(window)
	defer timer.Stop()

	for {
		if health, _ := bot.UnitHP(survivor); health == 0 {
			e2eharness.Preconditionf(t, "final relevant Scarlet 0x%X died before the gating oracle completed", survivor)
		}
		if timmy := bot.FindUnit(npcTimmyTheCruel, 100); timmy != 0 {
			e2eharness.ConfirmedBugf(t, 26363, "Timmy emerged as 0x%X while relevant Scarlet 0x%X was still alive", timmy, survivor)
		}

		select {
		case <-ticker.C:
		case <-timer.C:
			return
		}
	}
}

func waitForTimmy(t *testing.T, bot *e2eharness.ScenarioBot, timeout time.Duration) uint64 {
	t.Helper()

	ticker := time.NewTicker(100 * time.Millisecond)
	defer ticker.Stop()
	timer := time.NewTimer(timeout)
	defer timer.Stop()

	for {
		if timmy := bot.FindUnit(npcTimmyTheCruel, 100); timmy != 0 {
			return timmy
		}

		select {
		case <-ticker.C:
		case <-timer.C:
			e2eharness.ConfirmedBugf(t, 26363, "Timmy did not emerge within %s after the final Scarlet trigger died", timeout)
			return 0
		}
	}
}

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/26363
// Timmy must remain hidden while any relevant Scarlet in Crusaders' Square is
// alive, then emerge on the next SmartAI activation check.
func TestAC_26363_TimmyEmergesAfterSquareCleared(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances", "issue", "serial"},
		Runtime:  "med",
		Issue:    26363,
		Category: "instances/classic/stratholme",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Timmy",
		Level:  80,
	})

	// Center of the 15 relevant Scarlet spawns in Crusaders' Square. The 55-yard
	// observation radius excludes other Scarlet spawns with the same entries.
	bot.Teleport(t, 3660, -3180, 127, stratholmeMap)
	triggers := waitForTimmyActivationSet(t, bot, 20*time.Second)
	if len(triggers) != 15 {
		e2eharness.Preconditionf(t, "loaded Timmy activation area has %d relevant Scarlets, want 15", len(triggers))
	}
	bot.CombatReady(t)
	if timmy := bot.FindUnit(npcTimmyTheCruel, 100); timmy != 0 {
		e2eharness.ConfirmedBugf(t, 26363, "Timmy was already present as 0x%X before the Scarlet activation area was cleared", timmy)
	}

	// The previous implementation omitted Crimson Initiates from its conditions.
	// Leave one Initiate alive through a complete activation interval so the test
	// deterministically guards that regression instead of choosing any survivor.
	initiates := e2eharness.LivingByEntries(bot.World, triggerRadius, npcCrimsonInitiate)
	if len(initiates) != 2 {
		e2eharness.Preconditionf(t, "loaded Timmy activation area has %d Crimson Initiates, want 2", len(initiates))
	}
	survivor := initiates[0]
	victims := make([]uint64, 0, len(triggers)-1)
	for _, guid := range triggers {
		if guid != survivor {
			victims = append(victims, guid)
		}
	}
	bot.DamageKill(t, victims, 10_000_000, 20*time.Second)
	assertTimmyAbsentWhileAlive(t, bot, survivor, activationCheckEvery+2*time.Second)

	bot.DamageKill(t, []uint64{survivor}, 10_000_000, 10*time.Second)
	timmy := waitForTimmy(t, bot, 15*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS AC#26363 Timmy emerged as 0x%X only after all 15 relevant Scarlets died", timmy)
}
