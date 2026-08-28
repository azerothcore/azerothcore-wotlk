//go:build e2e

package ulduar_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Salvaged Demolisher shared pyrite pool (issues 27313 / 27331).
// The demolisher (33109) is the pool; its mechanic seat (33167) mirrors it
// (npc_salvaged_demolisher_turret). Costed seat abilities charge the parent via
// their own SPELL_EFFECT_POWER_BURN on TARGET_UNIT_VEHICLE (Speed Boost 62471).
const (
	npcSalvagedDemolisher = uint32(33109)
	npcDemolisherMechSeat = uint32(33167)
	spellDemoAutoRepair   = uint32(62705)
	spellDemoSpeedBoost   = uint32(62471)
	demolisherMaxPyrite   = uint32(50)
	speedBoostPyriteCost  = uint32(25)

	// UNIT_FIELD_POWER1 + POWER_ENERGY: same update-field index server- and client-side.
	fieldEnergy    = uint16(client.UnitFieldPower1 + 3)
	fieldMaxEnergy = uint16(client.UnitFieldMaxPower1 + 3)
)

// Formation Grounds demolisher pad (between the VEHICLE_POS_START demolisher spawns).
const (
	demoPadX = float32(-748.0)
	demoPadY = float32(-205.0)
	demoPadZ = float32(431.5)
)

// msgSetRaidDifficulty switches the solo bot to 25-man normal BEFORE entering, so
// these tests use their own fresh instance (unsaved solo players share one
// instance per map+difficulty; a 10-man may be polluted by manual testing).
const msgSetRaidDifficulty = uint16(0x4EB)

func setRaidDifficulty25(t *testing.T, bot *e2eharness.ScenarioBot) {
	t.Helper()
	if err := bot.World.SendPacketRaw(msgSetRaidDifficulty, []byte{1, 0, 0, 0}); err != nil {
		e2eharness.Preconditionf(t, "MSG_SET_RAID_DIFFICULTY send: %v", err)
	}
}

func unitEnergy(bot *e2eharness.ScenarioBot, guid uint64) (cur, max uint32) {
	obj := bot.World.GetObject(guid)
	if obj == nil {
		return 0, 0
	}
	return obj.Value(fieldEnergy), obj.Value(fieldMaxEnergy)
}

// waitUnitEnergy polls the object cache until the unit's pyrite equals want.
func waitUnitEnergy(bot *e2eharness.ScenarioBot, guid uint64, want uint32, timeout time.Duration) bool {
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if cur, _ := unitEnergy(bot, guid); cur == want {
			return true
		}
		time.Sleep(100 * time.Millisecond)
	}
	return false
}

// setUnitEnergy drives the selected-unit GM path: select guid, set its pyrite, wait
// for the cache to reflect it (Preconditionf on failure - the drive, not the oracle).
func setUnitEnergy(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64, value uint32) {
	t.Helper()
	if err := bot.World.SetTarget(guid); err != nil {
		e2eharness.Preconditionf(t, "SetTarget 0x%X: %v", guid, err)
	}
	bot.FlushWorld(t)
	bot.GM(t, fmt.Sprintf(".debug setvalue %d %d", fieldEnergy, value))
	if !waitUnitEnergy(bot, guid, value, 10*time.Second) {
		cur, _ := unitEnergy(bot, guid)
		e2eharness.Preconditionf(t, "unit 0x%X pyrite=%d after .debug setvalue %d (GM drive failed)", guid, cur, value)
	}
}

// pairSeatByDrain pairs the discoverable mechanic seat with its parent demolisher.
// Seats ride the vehicle and carry no usable world position or owner link in the
// client cache, so the pairing is driven: drain each demolisher and see which one
// the seat mirrors. Returns with the paired demolisher drained to 0. Doubles as
// the mirror oracle - a seat that follows no demolisher is the 27313 bug.
func pairSeatByDrain(t *testing.T, bot *e2eharness.ScenarioBot) (seat, demo uint64) {
	t.Helper()
	seat = bot.WaitUnit(t, npcDemolisherMechSeat, 30*time.Second)
	demos := bot.UnitsByEntry(120, npcSalvagedDemolisher)
	if len(demos) == 0 {
		e2eharness.Preconditionf(t, "no demolishers in cache")
	}
	// A just-(re)activated instance serves stale zeros briefly; wait for the seat
	// to surface its true (mirrored full) value so the drain probes below act on
	// live data. Soft: on an unfixed core the seat reads 0 forever, and the drain
	// loop still classifies that correctly.
	waitUnitEnergy(bot, seat, demolisherMaxPyrite, 30*time.Second)
	for _, d := range demos {
		setUnitEnergy(t, bot, d.GUID, 0)
		if waitUnitEnergy(bot, seat, 0, 3*time.Second) {
			t.Logf("seat 0x%X mirrors demolisher 0x%X", seat, d.GUID)
			return seat, d.GUID
		}
		setUnitEnergy(t, bot, d.GUID, demolisherMaxPyrite)
	}
	e2eharness.ConfirmedBugf(t, 27313, "seat 0x%X does not mirror any of %d demolishers' pyrite", seat, len(demos))
	return 0, 0
}

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27331
// Freshly spawned Salvaged Demolishers (instance load summons them) must have a
// full pyrite pool on both the demolisher and its mechanic seat.
func TestAC_27331_DemolisherSpawnsFullPyrite(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances", "issue"},
		Runtime:  "med",
		Issue:    27331,
		Category: "instances/northrend/ulduar",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "DemPyr", Level: 80})

	// Entering the map spawns the vehicles; 25-man normal keeps the instance
	// away from manual 10-man sessions (TestAC_27313 restores what it drains).
	setRaidDifficulty25(t, bot)
	bot.Teleport(t, demoPadX, demoPadY, demoPadZ, e2eharness.MapUlduar)
	seat := bot.WaitUnit(t, npcDemolisherMechSeat, 30*time.Second)

	demos := bot.UnitsByEntry(120, npcSalvagedDemolisher)
	if len(demos) != 5 {
		e2eharness.Preconditionf(t, "%d demolishers in cache, want the 5 of a 25-man (difficulty switch failed?)", len(demos))
	}
	// All seats run the same mirror AI; the discoverable one joins the census.
	units := append(demos, e2eharness.UnitSnap{GUID: seat, Entry: npcDemolisherMechSeat})

	// A just-(re)activated instance can serve the spawn-time 0 in the create block
	// and deliver the real value only on a later update, so wait for every unit to
	// read full before judging. Sound as a waiter: nothing on an unfixed core ever
	// writes pyrite to these units (33109/33167 lack UNIT_FLAG2_REGENERATE_POWER),
	// so they read 0 forever there.
	deadline := time.Now().Add(60 * time.Second)
	for time.Now().Before(deadline) {
		allFull := true
		for _, u := range units {
			if cur, _ := unitEnergy(bot, u.GUID); cur != demolisherMaxPyrite {
				allFull = false
				break
			}
		}
		if allFull {
			break
		}
		time.Sleep(250 * time.Millisecond)
	}

	// On an unfixed core every vehicle spawns empty; a mix of full and non-full
	// means another session mutated this shared instance and the spawn state is
	// no longer judgeable (unsaved solo players share one instance per difficulty).
	full, empty := 0, 0
	for _, u := range units {
		cur, max := unitEnergy(bot, u.GUID)
		if max != demolisherMaxPyrite {
			e2eharness.Preconditionf(t, "entry %d 0x%X max pyrite=%d want %d (power type not energy? ScriptName SQL applied?)",
				u.Entry, u.GUID, max, demolisherMaxPyrite)
		}
		switch cur {
		case max:
			full++
		case 0:
			empty++
		}
		t.Logf("entry %d 0x%X pyrite %d/%d", u.Entry, u.GUID, cur, max)
	}
	if empty == len(units) {
		e2eharness.ConfirmedBugf(t, 27331, "all %d demolishers and the seat spawned with 0 pyrite, want full", len(demos))
	}
	if full != len(units) {
		e2eharness.Preconditionf(t, "mixed pyrite (%d full, %d empty of %d) - concurrently mutated shared instance, spawn state not judgeable",
			full, empty, len(units))
	}
	t.Logf("PASS AC#27331 %d demolishers + seat 0x%X spawned with full pyrite", len(demos), seat)
}

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27313
// The demolisher and its mechanic seat share one pyrite pool: the seat mirrors the
// parent (drain and repair-refuel both propagate), and the gunner's Speed Boost
// takes exactly 25 from the shared pool (its power burn hits the parent; a cost
// forwarded on top would drain the pool to 0).
func TestAC_27313_DemolisherRepairSharedPyrite(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances", "issue"},
		Runtime:  "med",
		Issue:    27313,
		Category: "instances/northrend/ulduar",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "DemRep", Level: 80})

	setRaidDifficulty25(t, bot)
	bot.Teleport(t, demoPadX, demoPadY, demoPadZ, e2eharness.MapUlduar)

	// Mirror oracle: the seat follows its parent's drain (leaves the pair drained).
	seat, demo := pairSeatByDrain(t, bot)

	// Restore full state on exit (best effort) so a reused instance stays judgeable.
	t.Cleanup(func() {
		if !bot.Alive() {
			return
		}
		if err := bot.World.SetTarget(demo); err != nil {
			return
		}
		bot.FlushWorld(t)
		bot.GM(t, fmt.Sprintf(".debug setvalue %d %d", fieldEnergy, demolisherMaxPyrite))
		bot.GM(t, ".unaura 62705") // repair lockout aura
	})

	// Repair event: cast Auto-repair from the demolisher on itself, non-triggered
	// (the GM "triggered" keyword is TRIGGERED_FULL_DEBUG_MASK, which includes
	// TRIGGERED_IGNORE_EFFECTS - no energize). The station's trap geometry is not
	// the oracle; the energize only ever hits the main vehicle, so the seat must
	// be refueled by the mirror. Clear a leftover 62705 lockout aura first: the
	// spell script filters targets that still have it.
	if err := bot.World.SetTarget(demo); err != nil {
		e2eharness.Preconditionf(t, "SetTarget demolisher: %v", err)
	}
	bot.FlushWorld(t)
	bot.GM(t, ".unaura 62705")
	bot.GM(t, fmt.Sprintf(".cast self %d", spellDemoAutoRepair))
	if !waitUnitEnergy(bot, demo, demolisherMaxPyrite, 15*time.Second) {
		cur, _ := unitEnergy(bot, demo)
		e2eharness.Preconditionf(t, "demolisher pyrite=%d after Auto-repair, energize did not land (drive failed)", cur)
	}
	if !waitUnitEnergy(bot, seat, demolisherMaxPyrite, 10*time.Second) {
		cur, _ := unitEnergy(bot, seat)
		e2eharness.ConfirmedBugf(t, 27313, "repair refueled the demolisher (50) but the seat shows %d", cur)
	}
	t.Logf("repair leg: parent and seat both refueled to %d", demolisherMaxPyrite)

	// Gunner spend parity: Speed Boost from the seat must take exactly 25 from the
	// shared pool - the seat pays the 25 cost, its power burn takes 25 from the
	// parent, and the mirror keeps both at the same value. A core that forwards
	// the cost on top loses 50 from the pool instead of 25. Non-triggered so cost
	// and effects run; the spell has no DBC cooldown.
	if err := bot.World.SetTarget(seat); err != nil {
		e2eharness.Preconditionf(t, "SetTarget seat: %v", err)
	}
	bot.FlushWorld(t)
	bot.GM(t, fmt.Sprintf(".cast self %d", spellDemoSpeedBoost))
	want := demolisherMaxPyrite - speedBoostPyriteCost
	deadline := time.Now().Add(10 * time.Second)
	for time.Now().Before(deadline) {
		if cur, _ := unitEnergy(bot, demo); cur != demolisherMaxPyrite {
			break
		}
		time.Sleep(100 * time.Millisecond)
	}
	demoCur, _ := unitEnergy(bot, demo)
	if demoCur == demolisherMaxPyrite {
		e2eharness.Preconditionf(t, "demolisher pyrite unchanged after Speed Boost (cast failed?)")
	}
	if demoCur != want {
		e2eharness.ConfirmedBugf(t, 27313, "Speed Boost took %d pyrite from the pool (parent at %d), want exactly %d",
			demolisherMaxPyrite-demoCur, demoCur, speedBoostPyriteCost)
	}
	if !waitUnitEnergy(bot, seat, want, 10*time.Second) {
		cur, _ := unitEnergy(bot, seat)
		e2eharness.ConfirmedBugf(t, 27313, "seat pyrite=%d after Speed Boost, want %d (mirror of parent)", cur, want)
	}
	t.Logf("PASS AC#27313 shared pool: drain mirrored, repair refueled both, Speed Boost cost exactly %d", speedBoostPyriteCost)
}
