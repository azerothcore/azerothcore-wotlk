//go:build e2e

package ulduar_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Issue: https://github.com/chromiecraft/chromiecraft/issues/10228
// Earlier upstream report of the same symptom: https://github.com/azerothcore/azerothcore-wotlk/issues/26759
//
// Algalon is a temp summon with CREATURE_FLAG_EXTRA_HARD_RESET: a wipe despawns him and the map
// re-summons him 20s later (Map::ScheduleCreatureRespawn). The instance script used to keep a
// resummon of its own and summon him outright from OnPlayerEnter, so a player who ran back into
// Ulduar inside that window found a second Algalon standing in the first one's spot.
//
// Oracle: after a wipe, with the player re-entering the raid inside the respawn window, exactly
// one Algalon comes back, and it stays one past the 30s point where the reload fallback fires.
// The one that comes back replays the arrival: it summons the Azeroth planet, drops the immunity
// flag and ends up resting where the first arrival did.
//
// One bot is enough: the wipe is the bot's own death after Algalon has turned aggressive, not a
// fight that has to be held up.
func TestUlduar_AlgalonWipeRespawnsOnce(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances"},
		Runtime:  "long",
		Category: "instances/northrend/ulduar",
	})

	const (
		npcAlgalon = uint32(32871)
		// The planet Algalon summons during his arrival roleplay.
		npcAzeroth = uint32(34246)

		goPlanetarium10 = uint32(194628)
		goPlanetarium25 = uint32(194752)
		itemKey10       = uint32(45797)
		itemKey25       = uint32(45798)

		// Planetarium console, where Brann spawns and the summon roleplay starts.
		consoleX, consoleY, consoleZ = float32(1646.2), float32(-174.7), float32(427.3)
		// Off AlgalonLandPos, where he sets down.
		landX, landY, landZ = float32(1632.668), float32(-308.5), float32(417.321)

		// Brann's walk plus Algalon's descent before EVENT_INTRO_FINISH drops SetImmuneToPC.
		introWindow = 4 * time.Minute
		// 26s intro delay on a first pull before EVENT_INTRO_TIMER_DONE clears NOT_SELECTABLE,
		// the point from which UpdateVictim runs and a wipe can evade him.
		pullWindow  = 90 * time.Second
		evadeWindow = 30 * time.Second
		// DespawnOnEvade's respawn delay is 20s; the re-entry has to land inside it.
		respawnDelay  = 20 * time.Second
		respawnWindow = 45 * time.Second
		// OnPlayerEnter's reload fallback fires 30s after the re-entry; watch past it.
		fallbackWindow = 45 * time.Second
		// EVENT_INTRO_SUMMON fires 7s into the arrival.
		azerothWindow = 20 * time.Second
		// The re-arrival descends at 3s and is done at 5s; a create after that is plain.
		settledAfter = 15 * time.Second
		sampleEvery  = 200 * time.Millisecond
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "AlgRsp", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})

	// Stay GM through the raid enter (.go xyz onto 603 is ignored after .gm off).
	bot.Teleport(t, consoleX, consoleY, consoleZ, e2eharness.MapUlduar)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "bot not in Ulduar after console pad tele map=%d", m)
	}

	// The console is a locked goober with one key entry per raid size, and which one spawned
	// depends on the difficulty this instance came up at. Carry both.
	bot.AddItem(t, itemKey10, 1)
	bot.AddItem(t, itemKey25, 1)

	console := e2eharness.TryNearbyGameObjectByEntry(t, bot.World, goPlanetarium10, 15*time.Second)
	if console == 0 {
		console = e2eharness.TryNearbyGameObjectByEntry(t, bot.World, goPlanetarium25, 15*time.Second)
	}
	if console == 0 {
		e2eharness.Preconditionf(t, "no Celestial Planetarium Access console (%d/%d) at the pad", goPlanetarium10, goPlanetarium25)
	}
	bot.GameObjectUse(t, console)

	// Brann walks the intro from the console end of the room; wait it out on the platform
	// Algalon lands on. Instance grids are always loaded, so the roleplay runs regardless.
	bot.Teleport(t, landX, landY, landZ, e2eharness.MapUlduar)
	first := bot.WaitUnit(t, npcAlgalon, introWindow)
	t.Logf("Algalon summoned guid=0x%X", first)

	flags := func(guid uint64) (uint32, bool) {
		o := bot.World.GetObject(guid)
		if o == nil {
			return 0, false
		}
		return o.Value(client.UnitFieldFlags), true
	}
	// Returns once the flag is clear; a creature that leaves the cache is reported as a
	// precondition, since a stale flag and a despawn would otherwise read the same.
	waitFlagClear := func(guid uint64, flag uint32, timeout time.Duration, what string) bool {
		deadline := time.Now().Add(timeout)
		for time.Now().Before(deadline) {
			f, ok := flags(guid)
			if !ok {
				e2eharness.Preconditionf(t, "Algalon 0x%X vanished while waiting for %s", guid, what)
			}
			if f&flag == 0 {
				return true
			}
			time.Sleep(sampleEvery)
		}
		return false
	}

	// Pulling him mid-roleplay is not the same fight: JustEngagedWith calls events.Reset(),
	// which drops the pending EVENT_INTRO_FINISH that clears SetImmuneToPC. Wait for the flag.
	if !waitFlagClear(first, client.UnitFlagImmuneToPC, introWindow, "the arrival roleplay to finish") {
		e2eharness.Preconditionf(t, "Algalon 0x%X still UNIT_FLAG_IMMUNE_TO_PC after %s; intro roleplay never finished", first, introWindow)
	}
	firstRest := bot.World.GetObject(first)
	if firstRest == nil {
		e2eharness.Preconditionf(t, "Algalon 0x%X left the cache right after his arrival", first)
	}
	restX, restY, restZ := firstRest.PosX, firstRest.PosY, firstRest.PosZ
	t.Logf("intro roleplay done, Algalon attackable, resting at (%.1f, %.1f, %.1f)", restX, restY, restZ)

	// Drop GM so he fights back, with god on: an ungeared bot dies to his first swings and
	// he would evade before the hand-over below is observed. DieMust drops god for the wipe.
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true})
	bot.Engage(t, first, 60*time.Second)
	if !waitFlagClear(first, client.UnitFlagNotSelectable, pullWindow, "the engage roleplay to hand over to combat") {
		e2eharness.Preconditionf(t, "Algalon 0x%X still NOT_SELECTABLE %s after the pull; the engage roleplay never handed over to combat", first, pullWindow)
	}
	t.Logf("Algalon in combat and aggressive, wiping")

	// The wipe: with nobody alive within 120y his evade fails the encounter, and the hard-reset
	// despawn removes this creature outright.
	bot.DieMust(t, 25*time.Second)
	evadeDeadline := time.Now().Add(evadeWindow)
	for bot.World.GetObject(first) != nil && time.Now().Before(evadeDeadline) {
		time.Sleep(sampleEvery)
	}
	if bot.World.GetObject(first) != nil {
		e2eharness.Preconditionf(t, "Algalon 0x%X still present %s after the wipe: no evade despawn", first, evadeWindow)
	}
	evadeAt := time.Now()
	t.Logf("Algalon 0x%X despawned on the wipe at %s", first, evadeAt.Format(time.StampMilli))

	// Run back inside the respawn window: leave the raid and come back through the map
	// transfer, which is what fires OnPlayerEnter. GM mode again for the .go onto 603.
	bot.GM(t, ".revive")
	bot.WaitAlive(t, 10*time.Second)
	bot.GM(t, ".gm on")
	bot.FlushWorld(t)
	bot.TeleNamed(t, "dalaran")
	if _, _, _, m := bot.Pos(); m == e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "bot still in Ulduar after the tele out")
	}
	bot.Teleport(t, landX, landY, landZ, e2eharness.MapUlduar)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "bot not back in Ulduar map=%d", m)
	}
	reenterAt := time.Now()
	if reenterAt.Sub(evadeAt) >= respawnDelay {
		e2eharness.Preconditionf(t, "re-entered the raid %s after the evade, outside the %s respawn window the race needs",
			reenterAt.Sub(evadeAt).Round(time.Millisecond), respawnDelay)
	}
	t.Logf("re-entered Ulduar %s after the evade", reenterAt.Sub(evadeAt).Round(time.Millisecond))

	// The respawn's create packet carries his flight spline, and the harness reads no values out
	// of such a create (entry and health come back 0) and later loses track of the object, so the
	// living-unit helpers cannot see him until a plain create arrives. Until the relog below, count
	// by the entry packed in the GUID and only ever fail on a second one: a fallback summon is a
	// plain create and always shows up.
	algalons := func() []uint64 {
		var out []uint64
		for _, u := range bot.NearbyUnits(300) {
			if uint32((u.GUID>>24)&0xFFFFFF) == npcAlgalon {
				out = append(out, u.GUID)
			}
		}
		return out
	}
	failOnSecond := func(seen []uint64, since time.Time, what string) {
		if len(seen) > 1 {
			e2eharness.Assertf(t, "%d Algalons %s after %s (guids %v): the re-entry summoned one next to the respawn",
				len(seen), time.Since(since).Round(time.Millisecond), what, seen)
		}
	}

	// Exactly one Algalon comes back.
	var respawn uint64
	respawnDeadline := evadeAt.Add(respawnWindow)
	for time.Now().Before(respawnDeadline) {
		seen := algalons()
		failOnSecond(seen, evadeAt, "the wipe")
		if len(seen) == 1 {
			respawn = seen[0]
			break
		}
		time.Sleep(sampleEvery)
	}
	if respawn == 0 {
		e2eharness.Assertf(t, "no Algalon came back within %s of the wipe", respawnWindow)
	}
	if respawn == first {
		e2eharness.Assertf(t, "Algalon 0x%X came back with the guid of the despawned creature", respawn)
	}
	backAt := time.Now()
	t.Logf("Algalon back as 0x%X %s after the wipe", respawn, backAt.Sub(evadeAt).Round(time.Millisecond))

	// The arrival roleplay summons the planet 7s in; a bare summon at his home position never does.
	azeroth := bot.WaitUnit(t, npcAzeroth, azerothWindow)
	t.Logf("arrival replayed: Azeroth 0x%X summoned", azeroth)

	// Keep watching for a second one until his last arrival movement (the descent at 10s) is over,
	// then relog for a plain, readable create of him.
	for time.Now().Before(backAt.Add(settledAfter)) {
		failOnSecond(algalons(), reenterAt, "the re-entry")
		time.Sleep(sampleEvery)
	}
	bot.Relog(t)
	if landed := bot.WaitUnit(t, npcAlgalon, 30*time.Second); landed != respawn {
		e2eharness.Assertf(t, "Algalon after the relog is 0x%X, not the respawn 0x%X", landed, respawn)
	}

	// Still exactly one past the fallback the re-entry scheduled.
	holdDeadline := reenterAt.Add(fallbackWindow)
	for time.Now().Before(holdDeadline) {
		living := e2eharness.LivingByEntries(bot.World, 300, npcAlgalon)
		if seen := algalons(); len(seen) != 1 || len(living) != 1 {
			e2eharness.Assertf(t, "%d Algalons (%d living) %s after the re-entry (guids %v), want exactly the respawn 0x%X",
				len(seen), len(living), time.Since(reenterAt).Round(time.Millisecond), seen, respawn)
		}
		time.Sleep(sampleEvery)
	}
	t.Logf("still one Algalon %s after the re-entry", fallbackWindow)

	// The arrival finishes: he becomes attackable and rests where the first arrival did.
	if !waitFlagClear(respawn, client.UnitFlagImmuneToPC, introWindow, "the replayed arrival to finish") {
		e2eharness.Assertf(t, "respawned Algalon 0x%X never dropped UNIT_FLAG_IMMUNE_TO_PC within %s", respawn, introWindow)
	}
	o := bot.World.GetObject(respawn)
	if o == nil {
		e2eharness.Assertf(t, "respawned Algalon 0x%X gone after finishing the arrival", respawn)
	}
	if d := e2eharness.Distance3D(o.PosX, o.PosY, o.PosZ, restX, restY, restZ); d > 3 {
		e2eharness.Assertf(t, "respawned Algalon 0x%X finished the arrival at (%.1f, %.1f, %.1f), %.1fy from where the first arrival ended (%.1f, %.1f, %.1f)",
			respawn, o.PosX, o.PosY, o.PosZ, d, restX, restY, restZ)
	}
	t.Logf("PASS one Algalon (0x%X) back after the wipe, arrival replayed and resting at (%.1f, %.1f, %.1f)", respawn, o.PosX, o.PosY, o.PosZ)
}
