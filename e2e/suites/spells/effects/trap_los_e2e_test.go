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
	// Attackable, never dies, no AI and no mechanic immunity.
	trapLOSDummy uint32 = 32171
	// The trap GameObject casts the trap's spell itself, so the hunter's hit rating does
	// not apply and a level 80 victim resists 4% of the time. Ten levels below the caster
	// puts the hit chance at the cap, so a resist can never pose as the bug.
	trapLOSDummyLevel = 70

	// Living creatures this close to a spot are killed first: the trap fires on the
	// nearest attackable unit, which must be the dummy.
	trapLOSClearRadius float32 = 30

	creatureViper         uint32 = 19921
	creatureVenomousSnake uint32 = 19833
)

// trapToTrip is one hunter trap at the rank a level 80 hunter has, and how its effect
// shows on the victim.
type trapToTrip struct {
	name       string
	spell      uint32 // places gameObject at the hunter's feet
	gameObject uint32 // type 1 trap: despawns once it has cast
	landed     func(observer *e2eharness.ScenarioBot, victim uint64) bool
}

func victimHasAura(spellID uint32) func(*e2eharness.ScenarioBot, uint64) bool {
	return func(observer *e2eharness.ScenarioBot, victim uint64) bool {
		return observer.UnitHasAura(victim, spellID)
	}
}

// Freezing Trap comes first at every spot: its freeze breaks on damage, and the other
// traps leave burning ground and snakes behind.
var trapsToTrip = []trapToTrip{
	{"Freezing", 14311, 164877, victimHasAura(14309)},   // Freezing Trap Effect
	{"Frost", 13809, 164639, victimHasAura(67035)},      // the slow cast on the victim
	{"Immolation", 49056, 189319, victimHasAura(49054)}, // Immolation Trap DoT
	{"Explosive", 49067, 189322, victimHasAura(49065)},  // Explosive Trap Effect burn
	{"Snake", 34600, 183957, func(observer *e2eharness.ScenarioBot, _ uint64) bool {
		return len(observer.UnitsByEntry(10, creatureViper, creatureVenomousSnake)) > 0
	}},
}

// Since PR #26152 (https://github.com/azerothcore/azerothcore-wotlk/pull/26152) a trap's
// spell is cast by the trap GameObject. A GameObject has no collision height, so
// Spell::CheckCast measured line of sight from the trap's floor position to the victim's
// feet. Outdoors that ray only meets terrain, which line of sight ignores; where it
// crosses WMO floor geometry, as it does at some spots in dungeons, the trap fired and
// despawned while its spell failed with SPELL_FAILED_LINE_OF_SIGHT.
//
// Oracle: every hunter trap, tripped by a creature standing on it, affects that creature
// on outdoor terrain, on a WMO floor in the open world, and at spread-out spots of the
// dungeons where hunters reported traps doing nothing (Utgarde Keep and Utgarde Pinnacle).
func TestTrap_EveryTrapAffectsItsVictimOnAnyFloor(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "spells", "multi_bot"},
		Runtime:  "long",
		Category: "spells/effects",
	})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "TrapLos",
		Bots: []e2eharness.BotSpec{
			{Role: "hunter", Race: e2eharness.RaceDwarf, Class: e2eharness.ClassHunter, Level: 80, LearnAllClass: true},
			// Stays in GM mode, which traps ignore, to clear the spot, spawn the dummy and
			// watch it.
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
	// Grouped so both bots land in the same dungeon instances.
	e2eharness.FormPartyAtPad(t, pad, hunter, placer)

	for _, trap := range trapsToTrip {
		hunter.Learn(t, trap.spell)
		if !hunter.World.KnowsSpell(trap.spell) {
			e2eharness.Preconditionf(t, "hunter does not know %s Trap %d", trap.name, trap.spell)
		}
	}
	// Full: traps cost mana, and fifty-five of them outlast a level 80 mana pool.
	hunter.CombatReadyFull(t)

	at := func(x, y, z float32, mapID uint32) func(*testing.T, *e2eharness.ScenarioBot) {
		return func(t *testing.T, b *e2eharness.ScenarioBot) { b.Teleport(t, x, y, z, mapID) }
	}
	const (
		mapUtgardeKeep     uint32 = 574
		mapUtgardePinnacle uint32 = 575
	)
	// The dungeon spots are creature spawn points, so they sit on the real floor, picked
	// as far apart from each other as the instance allows.
	for _, spot := range []struct {
		name  string
		place func(*testing.T, *e2eharness.ScenarioBot)
	}{
		{"OutdoorTerrain", func(t *testing.T, b *e2eharness.ScenarioBot) { b.TeleportPad(t, pad) }},
		{"IronforgeWMOFloor", func(t *testing.T, b *e2eharness.ScenarioBot) { b.TeleNamed(t, "Ironforge") }},
		{"Deadmines", func(t *testing.T, b *e2eharness.ScenarioBot) { b.TeleNamed(t, "Deadmines") }},
		{"UtgardeKeep1", at(121.96, 76.88, 109.23, mapUtgardeKeep)},
		{"UtgardeKeep2", at(392.44, 229.01, 30.78, mapUtgardeKeep)},
		{"UtgardeKeep3", at(281.56, -150.47, 190.48, mapUtgardeKeep)},
		{"UtgardeKeep4", at(146.57, 284.10, 42.95, mapUtgardeKeep)},
		{"UtgardePinnacle1", at(463.84, -465.14, 104.70, mapUtgardePinnacle)},
		{"UtgardePinnacle2", at(308.32, -239.73, 104.73, mapUtgardePinnacle)},
		{"UtgardePinnacle3", at(254.69, -466.19, 104.71, mapUtgardePinnacle)},
		{"UtgardePinnacle4", at(541.58, -290.40, 119.78, mapUtgardePinnacle)},
	} {
		t.Run(spot.name, func(t *testing.T) {
			spot.place(t, hunter)
			spot.place(t, placer)
			clearSpot(t, placer)

			for _, trap := range trapsToTrip {
				t.Run(trap.name, func(t *testing.T) {
					tripTrap(t, hunter, placer, trap)
				})
			}
		})
	}
}

// tripTrap spawns a dummy under the hunter, has the hunter lay trap on it and asserts the
// trap's effect reached the dummy.
func tripTrap(t *testing.T, hunter, placer *e2eharness.ScenarioBot, trap trapToTrip) {
	t.Helper()
	dummy := placer.Spawn(t, trapLOSDummy, 15*time.Second)
	if dummy == 0 {
		e2eharness.Preconditionf(t, "failed to spawn dummy %d", trapLOSDummy)
	}
	_ = placer.World.SetTarget(dummy)
	placer.GM(t, fmt.Sprintf(".npc set level %d", trapLOSDummyLevel))
	placer.FlushWorld(t)

	hunter.GM(t, ".cooldown")
	hunter.CastMust(t, trap.spell, 0, 10*time.Second)
	trapGO := waitTrapGO(placer, trap.gameObject, true, 5*time.Second)
	if trapGO == 0 {
		e2eharness.Preconditionf(t, "%s Trap GO %d never appeared", trap.name, trap.gameObject)
	}

	deadline := time.Now().Add(6 * time.Second)
	for time.Now().Before(deadline) {
		if trap.landed(placer, dummy) {
			t.Logf("PASS %s Trap affected dummy 0x%X", trap.name, dummy)
			return
		}
		time.Sleep(40 * time.Millisecond)
	}
	// The trap despawns once it has cast; one still standing never triggered.
	if waitTrapGO(placer, trap.gameObject, false, 2*time.Second) != 0 {
		e2eharness.Preconditionf(t, "%s Trap 0x%X never triggered on dummy 0x%X", trap.name, trapGO, dummy)
	}
	e2eharness.Assertf(t, "%s Trap 0x%X fired and despawned but its effect never reached dummy 0x%X",
		trap.name, trapGO, dummy)
}

// clearSpot kills every living creature spawned within trapLOSClearRadius of the bot, so
// the dummy is the only thing a trap there can fire on. Dungeon instances are private to
// the test's group, so nothing outside the test sees it.
func clearSpot(t *testing.T, bot *e2eharness.ScenarioBot) {
	t.Helper()
	x, y, _, mapID := bot.Pos()
	rows, err := bot.WorldDB.Query(
		`SELECT DISTINCT id FROM creature WHERE map = ? AND POW(position_x - ?, 2) + POW(position_y - ?, 2) < ?`,
		mapID, x, y, trapLOSClearRadius*trapLOSClearRadius)
	if err != nil {
		e2eharness.HarnessFailf(t, "query creatures near %.1f, %.1f: %v", x, y, err)
	}
	var entries []uint32
	for rows.Next() {
		var entry uint32
		if err := rows.Scan(&entry); err != nil {
			_ = rows.Close()
			e2eharness.HarnessFailf(t, "scan creature entry: %v", err)
		}
		entries = append(entries, entry)
	}
	_ = rows.Close()
	if len(entries) == 0 {
		return
	}
	// The object cache fills in over the first moments after a teleport.
	var nearby []e2eharness.UnitSnap
	deadline := time.Now().Add(5 * time.Second)
	for len(nearby) == 0 && time.Now().Before(deadline) {
		time.Sleep(100 * time.Millisecond)
		nearby = bot.UnitsByEntry(trapLOSClearRadius+10, entries...)
	}
	killed := 0
	for _, u := range nearby {
		if u.Health == 0 || u.Entry == trapLOSDummy {
			continue
		}
		_ = bot.World.SetTarget(u.GUID)
		bot.GM(t, ".die")
		killed++
	}
	bot.FlushWorld(t)
	t.Logf("cleared %d creatures around %.1f, %.1f (map %d)", killed, x, y, mapID)
}

// waitTrapGO waits for a trap GameObject to be present (want=true, returns its GUID) or
// gone (want=false, returns 0 once gone) in bot's object cache.
func waitTrapGO(bot *e2eharness.ScenarioBot, entry uint32, want bool, timeout time.Duration) uint64 {
	deadline := time.Now().Add(timeout)
	for {
		g := bot.World.FindGameObjectByEntry(entry, 10)
		if (g != 0) == want || !time.Now().Before(deadline) {
			return g
		}
		time.Sleep(40 * time.Millisecond)
	}
}
