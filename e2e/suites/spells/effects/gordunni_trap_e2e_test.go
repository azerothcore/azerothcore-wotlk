//go:build e2e

package effects_test

import (
	"fmt"
	"math"
	"math/rand"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	gordunniTrap       uint32 = 144050 // GO, type TRAP, casts 19395 on whoever disturbs it
	gordunniMoundChest uint32 = 144064 // summoned by 11756, holds the Gordunni Cobalt
	gordunniMoundJunk  uint32 = 177681 // summoned by 19394, holds the junk loot

	// Widest gap between the trap firing and the summoned mound reaching the cache.
	moundWindow = 10 * time.Second

	// Trips are spread around a ring, so every trip is >20yd from every other while none
	// of them wanders far from the isolation pad. That separation is what keeps the radius
	// below matching only the mound this trip produced: summoned mounds are never
	// despawned (EffectSummonObjectWild leaves m_spawnedByDefault set, so the 120s
	// duration expires into a permanent object) and would otherwise satisfy every later
	// trip.
	tripRingRadius float32 = 40

	// The mound lands at TARGET_DEST_CASTER_FRONT, ~3yd ahead of the bot -- but snapped
	// to the ground, which is why the bot is placed on the terrain below the pad rather
	// than on the pad itself: from the pad it would drop ~105yd and fall out of range.
	moundSearchRadius float32 = 8

	// Half-width of the per-run displacement of the ring centre.
	ringJitter = 150

	// spell_gordunni_trap rolls chest or junk 50/50, so one trip proves nothing about
	// the roll. Twelve leave a ~0.05% chance of missing either face on a fixed core;
	// the loop exits as soon as both have been seen, which takes 3 trips on average.
	maxTrips = 12
)

// The Gordunni Trap casts 19395 on the player who disturbs it, and spell_gordunni_trap
// turns that into one of the two mound summon spells: 11756 (chest) or 19394 (junk).
//
// The script used to summon GO 144064 directly, so the junk mound never appeared at all
// and the only loot a trap could ever yield was the chest's. Seeing 177681 come out of a
// trap is therefore impossible on the old script and is the oracle here; the chest is
// asserted alongside it so a roll stuck on one face fails rather than passing on half
// the behaviour.
//
// Upstream: https://github.com/TrinityCore/TrinityCore/commit/9d6c4e3d931875008cd9ca15754b3edb1aef2a01
func TestEffects_GordunniTrapRollsBothMounds(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "spells", "serial"},
		Runtime:  "short",
		Category: "spells/effects",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "Gord"})
	pad := e2eharness.PackagePad(t)
	bot.TeleportPad(t, pad)

	// Mounds from earlier runs are still standing exactly where those runs put them, and
	// would let this one pass without the trap producing anything. Offsetting the ring
	// per run keeps every trip on ground no previous run has used.
	rng := rand.New(rand.NewSource(time.Now().UnixNano()))
	centreX := pad.X + float32(rng.Intn(2*ringJitter)-ringJitter)
	centreY := pad.Y + float32(rng.Intn(2*ringJitter)-ringJitter)
	seen := map[uint64]bool{}

	var sawChest, sawJunk, trips int
	for trip := 1; trip <= maxTrips && (sawChest == 0 || sawJunk == 0); trip++ {
		trips = trip
		angle := 2 * math.Pi * float64(trip) / float64(maxTrips)
		// .go xyz without a z lands on max(ground, water level), so the bot and the
		// mound it summons end up at the same height.
		e2eharness.MustGMTeleport(t, bot.World, fmt.Sprintf(".go xyz %.3f %.3f",
			centreX+tripRingRadius*float32(math.Cos(angle)),
			centreY+tripRingRadius*float32(math.Sin(angle))))

		if spawn := bot.SpawnGameObject(t, gordunniTrap); spawn == 0 {
			e2eharness.Preconditionf(t, "trip %d/%d: no spawn id resolved for the Gordunni Trap (%d); "+
				"without it the trap cannot be cleaned up and the run would litter the pad",
				trip, maxTrips, gordunniTrap)
		}

		// SpawnGameObject leaves the bot in GM mode. 19395 is a negative spell cast at
		// the player, so SpellInfo::CheckTarget answers SPELL_FAILED_BM_OR_INVISGOD
		// while the bot is GM-invisible and the trap fires into nothing.
		e2eharness.MustGM(t, bot.World, ".gm off")
		bot.FlushWorld(t)

		trap := bot.WaitGameObject(t, gordunniTrap, 15*time.Second)
		bot.GameObjectUse(t, trap)

		// A guid this run has already credited cannot stand in for a fresh summon.
		chest, junk := uint64(0), uint64(0)
		deadline := time.Now().Add(moundWindow)
		for time.Now().Before(deadline) {
			if g := bot.World.FindGameObjectByEntry(gordunniMoundChest, moundSearchRadius); g != 0 && !seen[g] {
				chest = g
			}
			if g := bot.World.FindGameObjectByEntry(gordunniMoundJunk, moundSearchRadius); g != 0 && !seen[g] {
				junk = g
			}
			if chest != 0 || junk != 0 {
				break
			}
			time.Sleep(50 * time.Millisecond)
		}
		seen[chest], seen[junk] = true, true

		switch {
		case chest != 0:
			sawChest++
			t.Logf("trip %d/%d: chest mound (%d) guid=0x%X", trip, maxTrips, gordunniMoundChest, chest)
		case junk != 0:
			sawJunk++
			t.Logf("trip %d/%d: junk mound (%d) guid=0x%X", trip, maxTrips, gordunniMoundJunk, junk)
		default:
			e2eharness.Assertf(t, "trip %d/%d: the Gordunni Trap (%d) produced neither mound (%d, %d) "+
				"within %s of CMSG_GAMEOBJ_USE; 19395 never reached spell_gordunni_trap, or the summon "+
				"spell it picked did not resolve",
				trip, maxTrips, gordunniTrap, gordunniMoundChest, gordunniMoundJunk, moundWindow)
		}
	}

	if sawJunk == 0 {
		e2eharness.Assertf(t, "the junk mound (%d) never appeared in %d trips (chest %d times); "+
			"spell_gordunni_trap is summoning the chest gameobject directly instead of casting "+
			"11756 or 19394, so half the trap's loot is unreachable",
			gordunniMoundJunk, trips, sawChest)
	}
	if sawChest == 0 {
		e2eharness.Assertf(t, "the chest mound (%d) never appeared in %d trips (junk %d times); "+
			"11756 is not being cast or its summon is not resolving",
			gordunniMoundChest, trips, sawJunk)
	}
	t.Logf("PASS both mounds rolled out of the trap: chest %d, junk %d", sawChest, sawJunk)
}
