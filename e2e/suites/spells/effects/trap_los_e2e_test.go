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
// shows: an aura on the victim, or creatures summoned next to it.
type trapToTrip struct {
	name       string
	spell      uint32 // places gameObject at the hunter's feet
	gameObject uint32 // type 1 trap: despawns once it has cast
	aura       uint32
	summons    []uint32
}

// Freezing Trap comes first at every spot: its freeze breaks on damage, and the other
// traps leave burning ground and snakes behind.
var trapsToTrip = []trapToTrip{
	{"Freezing", 14311, 164877, 14309, nil},   // Freezing Trap Effect
	{"Frost", 13809, 164639, 67035, nil},      // the slow cast on the victim
	{"Immolation", 49056, 189319, 49054, nil}, // Immolation Trap DoT
	{"Explosive", 49067, 189322, 49065, nil},  // Explosive Trap Effect burn
	{"Snake", 34600, 183957, 0, []uint32{creatureViper, creatureVenomousSnake}},
}

// Hunter traps share the 1.5s global cooldown, which `.cooldown` does not reset.
const trapGlobalCooldown = 1500 * time.Millisecond

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
	var lastCast time.Time
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
			// The placer clears the spot before the hunter arrives. Creatures standing on the
			// spot (the Tunneling Ghouls at UtgardeKeep4) attack a hunter who lands among them
			// within a second, and once they do the placer may not see them before the trap
			// fires on one of them.
			spot.place(t, placer)
			spawned := clearSpot(t, placer)
			spot.place(t, hunter)

			for _, trap := range trapsToTrip {
				t.Run(trap.name, func(t *testing.T) {
					// A creature of the spot that came into sight late is killed before it can
					// walk onto the trap.
					killLiving(t, placer, spawned, map[uint64]struct{}{})
					tripTrap(t, hunter, placer, trap, &lastCast)
				})
			}
		})
	}
}

// tripTrap spawns a dummy under the hunter, has the hunter lay trap on it and asserts the
// trap's effect reached the dummy. lastCast is when the hunter last laid a trap.
func tripTrap(t *testing.T, hunter, placer *e2eharness.ScenarioBot, trap trapToTrip, lastCast *time.Time) {
	t.Helper()
	dummy := placer.Spawn(t, trapLOSDummy, 15*time.Second)
	if dummy == 0 {
		e2eharness.Preconditionf(t, "failed to spawn dummy %d", trapLOSDummy)
	}
	_ = placer.World.SetTarget(dummy)
	placer.GM(t, fmt.Sprintf(".npc set level %d", trapLOSDummyLevel))
	placer.FlushWorld(t)

	// Snakes outlive the subtest that summoned them and can still be around at the next
	// spot, so only a snake that was not already in sight counts.
	staleSummons := map[uint64]struct{}{}
	if len(trap.summons) > 0 {
		for _, u := range placer.UnitsByEntry(100, trap.summons...) {
			staleSummons[u.GUID] = struct{}{}
		}
	}
	landed := func() bool {
		if trap.aura != 0 {
			return placer.UnitHasAura(dummy, trap.aura)
		}
		for _, u := range placer.UnitsByEntry(10, trap.summons...) {
			if _, stale := staleSummons[u.GUID]; !stale {
				return true
			}
		}
		return false
	}

	hunter.GM(t, ".cooldown")
	time.Sleep(time.Until(lastCast.Add(trapGlobalCooldown)))
	hunter.CastMust(t, trap.spell, 0, 10*time.Second)
	*lastCast = time.Now()

	// Laid out of combat, the trap is armed at once and can fire and despawn before the
	// placer ever sees it, so its effect is checked first.
	deadline := time.Now().Add(6 * time.Second)
	for time.Now().Before(deadline) {
		if landed() {
			t.Logf("PASS %s Trap affected dummy 0x%X", trap.name, dummy)
			return
		}
		time.Sleep(40 * time.Millisecond)
	}
	// The trap despawns once it has cast; one still standing never triggered.
	if trapGO := waitTrapGO(placer, trap.gameObject, false, 2*time.Second); trapGO != 0 {
		e2eharness.Preconditionf(t, "%s Trap 0x%X never triggered on dummy 0x%X", trap.name, trapGO, dummy)
	}
	// The effect can land while the trap despawns.
	if landed() {
		t.Logf("PASS %s Trap affected dummy 0x%X", trap.name, dummy)
		return
	}
	e2eharness.Assertf(t, "%s Trap %d fired and despawned but its effect never reached dummy 0x%X",
		trap.name, trap.gameObject, dummy)
}

// clearSpot kills every living creature spawned within trapLOSClearRadius of the bot, so
// the dummy is the only thing a trap there can fire on, and returns their entries. Dungeon
// instances are private to the test's group, so nothing outside the test sees it.
func clearSpot(t *testing.T, bot *e2eharness.ScenarioBot) []uint32 {
	t.Helper()
	x, y, _, mapID := bot.Pos()
	rows, err := bot.WorldDB.Query(
		`SELECT id, COUNT(*) FROM creature WHERE map = ? AND spawnMask & 1 AND phaseMask & 1
			AND POW(position_x - ?, 2) + POW(position_y - ?, 2) < ? GROUP BY id`,
		mapID, x, y, trapLOSClearRadius*trapLOSClearRadius)
	if err != nil {
		e2eharness.HarnessFailf(t, "query creatures near %.1f, %.1f: %v", x, y, err)
	}
	var entries []uint32
	spawns := 0
	for rows.Next() {
		var entry uint32
		var count int
		if err := rows.Scan(&entry, &count); err != nil {
			_ = rows.Close()
			e2eharness.HarnessFailf(t, "scan creature entry: %v", err)
		}
		entries = append(entries, entry)
		spawns += count
	}
	_ = rows.Close()
	if len(entries) == 0 {
		return nil
	}
	// The object cache fills in over the first moments after a teleport, one creature at a
	// time and slower on a loaded host, so keep sweeping until as many have been killed as
	// are spawned here: one left alive can attack the hunter and stand on the trap, which
	// then fires on it rather than the dummy.
	killed := map[uint64]struct{}{}
	for deadline := time.Now().Add(10 * time.Second); len(killed) < spawns && time.Now().Before(deadline); {
		killLiving(t, bot, entries, killed)
		time.Sleep(100 * time.Millisecond)
	}
	bot.FlushWorld(t)
	t.Logf("cleared %d of %d creatures spawned around %.1f, %.1f (map %d)", len(killed), spawns, x, y, mapID)
	return entries
}

// killLiving kills the living creatures of entries in bot's sight that are not in killed,
// and adds them to it.
func killLiving(t *testing.T, bot *e2eharness.ScenarioBot, entries []uint32, killed map[uint64]struct{}) {
	t.Helper()
	if len(entries) == 0 {
		return
	}
	for _, u := range bot.UnitsByEntry(trapLOSClearRadius+10, entries...) {
		if _, done := killed[u.GUID]; done || u.Health == 0 || u.Entry == trapLOSDummy {
			continue
		}
		_ = bot.World.SetTarget(u.GUID)
		bot.GM(t, ".die")
		killed[u.GUID] = struct{}{}
	}
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
