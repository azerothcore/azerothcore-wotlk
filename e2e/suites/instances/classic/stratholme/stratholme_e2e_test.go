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
	npcTimmyTheCruel = uint32(10808)

	stratholmeMap = uint32(329)
	triggerRadius = float32(55)
)

var timmyTriggerEntries = []uint32{10418, 10419, 10420, 10424}

func waitForTimmyTriggerSet(t *testing.T, bot *e2eharness.ScenarioBot, timeout time.Duration) []uint64 {
	t.Helper()

	want := map[uint32]int{
		10418: 8,
		10419: 3,
		10420: 2,
		10424: 2,
	}
	deadline := time.Now().Add(timeout)
	var got map[uint32]int
	for time.Now().Before(deadline) {
		got = e2eharness.CountLivingByEntry(bot.World, triggerRadius, timmyTriggerEntries...)
		complete := true
		for entry, count := range want {
			if got[entry] != count {
				complete = false
				break
			}
		}
		if complete {
			return e2eharness.LivingByEntries(bot.World, triggerRadius, timmyTriggerEntries...)
		}
		time.Sleep(100 * time.Millisecond)
	}

	e2eharness.Preconditionf(t, "Timmy trigger group did not load completely within %s: got=%v want=%v", timeout, got, want)
	return nil
}

func assertTimmyAbsentWhileAlive(t *testing.T, bot *e2eharness.ScenarioBot, survivor uint64, window time.Duration) {
	t.Helper()

	deadline := time.Now().Add(window)
	for time.Now().Before(deadline) {
		if health, _ := bot.UnitHP(survivor); health == 0 {
			e2eharness.Preconditionf(t, "final Scarlet trigger 0x%X died before the gating oracle completed", survivor)
		}
		if timmy := bot.FindUnit(npcTimmyTheCruel, 100); timmy != 0 {
			e2eharness.ConfirmedBugf(t, 26363, "Timmy spawned as 0x%X while Scarlet trigger 0x%X was still alive", timmy, survivor)
		}
		time.Sleep(100 * time.Millisecond)
	}
}

func waitForTimmy(t *testing.T, bot *e2eharness.ScenarioBot, timeout time.Duration) uint64 {
	t.Helper()

	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if timmy := bot.FindUnit(npcTimmyTheCruel, 100); timmy != 0 {
			return timmy
		}
		time.Sleep(100 * time.Millisecond)
	}

	e2eharness.ConfirmedBugf(t, 26363, "Timmy did not spawn within %s after the final Scarlet trigger died", timeout)
	return 0
}

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/26363
// Timmy must remain hidden until every configured Scarlet in Crusaders' Square
// is dead, then spawn on the next instance-script check.
func TestAC_26363_TimmySpawnsAfterSquareCleared(t *testing.T) {
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

	// Center of the 15 spawn-group members in Crusaders' Square. The 55-yard
	// observation radius excludes other Scarlet spawns with the same entries.
	bot.Teleport(t, 3660, -3180, 127, stratholmeMap)
	triggers := waitForTimmyTriggerSet(t, bot, 20*time.Second)
	if len(triggers) != 15 {
		e2eharness.Preconditionf(t, "loaded Timmy trigger group has %d members, want 15", len(triggers))
	}
	if timmy := bot.FindUnit(npcTimmyTheCruel, 100); timmy != 0 {
		e2eharness.ConfirmedBugf(t, 26363, "Timmy was already present as 0x%X before the Scarlet trigger group was cleared", timmy)
	}

	// Leave one configured Scarlet alive for three complete one-second instance
	// checks. Timmy must not spawn from a partially cleared group.
	survivor := triggers[len(triggers)-1]
	bot.DamageKill(t, triggers[:len(triggers)-1], 10_000_000, 20*time.Second)
	assertTimmyAbsentWhileAlive(t, bot, survivor, 3*time.Second)

	bot.DamageKill(t, []uint64{survivor}, 10_000_000, 10*time.Second)
	timmy := waitForTimmy(t, bot, 15*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS AC#26363 Timmy spawned as 0x%X only after all 15 Scarlet triggers died", timmy)
}
