//go:build e2e

package effects_test

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"io"
	"math"
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

	spellGordunniMoundChest uint32 = 11756
	spellGordunniMoundJunk  uint32 = 19394

	smsgSpellLogExecute         uint16 = 0x24C
	spellEffectSummonObjectWild uint32 = 76

	// Widest gap between the trap firing and the summoned mound reaching the cache.
	moundWindow = 10 * time.Second

	// Each trip spawns a fresh trap. Spreading the trips around a ring keeps every trap >20yd
	// from the previous one, so WaitGameObject cannot pick up a trap an earlier trip used.
	tripRingRadius float32 = 70

	// spell_gordunni_trap rolls chest or junk 50/50, so one trip proves nothing about
	// the roll. Twenty leave a 2*(1/2)^20 chance, about 0.0002%, of missing either face on
	// a fixed core; the loop exits as soon as both have been seen, which takes 3 trips on
	// average, so the extra headroom costs nothing in the normal case.
	maxTrips = 20
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
// The mound is identified by the GUID the summon spell's SMSG_SPELLLOGEXECUTE names, not
// by searching around the bot: on the pad's steep slopes the mound lands several yards
// below the bot, and a radius search either misses it or finds an older mound instead.
//
// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/27632
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
	summons := watchMoundSummons(t, bot)

	var sawChest, sawJunk, trips int
	for trip := 1; trip <= maxTrips && (sawChest == 0 || sawJunk == 0); trip++ {
		trips = trip
		angle := 2 * math.Pi * float64(trip) / float64(maxTrips)
		// .go xyz without a z lands on max(ground, water level). From the pad itself the
		// mound would drop ~105yd to the terrain below, out of the bot's sight.
		e2eharness.MustGMTeleport(t, bot.World, fmt.Sprintf(".go xyz %.3f %.3f",
			pad.X+tripRingRadius*float32(math.Cos(angle)),
			pad.Y+tripRingRadius*float32(math.Sin(angle))))

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

		var mound uint64
		select {
		case mound = <-summons:
		case <-time.After(moundWindow):
			e2eharness.Assertf(t, "trip %d/%d: the Gordunni Trap (%d) led to no mound summon (%d or %d) "+
				"within %s of CMSG_GAMEOBJ_USE; 19395 never reached spell_gordunni_trap, or the summon "+
				"spell it picked was not cast",
				trip, maxTrips, gordunniTrap, spellGordunniMoundChest, spellGordunniMoundJunk, moundWindow)
		}
		// The summon only counts once the mound is actually in the world for the player.
		for deadline := time.Now().Add(moundWindow); bot.World.GetObject(mound) == nil; {
			if time.Now().After(deadline) {
				e2eharness.Assertf(t, "trip %d/%d: mound 0x%X was summoned but never reached the client within %s",
					trip, maxTrips, mound, moundWindow)
			}
			time.Sleep(50 * time.Millisecond)
		}

		switch entry := uint32((mound >> 24) & 0xFFFFFF); entry {
		case gordunniMoundChest:
			sawChest++
			t.Logf("trip %d/%d: chest mound (%d) guid=0x%X", trip, maxTrips, gordunniMoundChest, mound)
		case gordunniMoundJunk:
			sawJunk++
			t.Logf("trip %d/%d: junk mound (%d) guid=0x%X", trip, maxTrips, gordunniMoundJunk, mound)
		default:
			e2eharness.Assertf(t, "trip %d/%d: the mound summon created gameobject %d (guid 0x%X), "+
				"neither mound (%d, %d)", trip, maxTrips, entry, mound, gordunniMoundChest, gordunniMoundJunk)
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

// watchMoundSummons reports the GUID of every mound the bot's own summon spells create.
func watchMoundSummons(t *testing.T, bot *e2eharness.ScenarioBot) <-chan uint64 {
	summons := make(chan uint64, maxTrips)
	player := bot.World.CharGUID()
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != smsgSpellLogExecute {
			return
		}
		if guid, ok := summonedMound(data, player); ok {
			select {
			case summons <- guid:
			default:
			}
		}
	})
	t.Cleanup(cancel)
	return summons
}

// summonedMound reads an SMSG_SPELLLOGEXECUTE as Spell::SendLogExecute writes it: the caster's
// packed GUID, the spell id, the effect count, then per effect its id, its target count and,
// for a summon, the packed GUID of each object it created. Only the first effect is read, which
// is the summon on both mound spells.
func summonedMound(data []byte, caster uint64) (uint64, bool) {
	r := bytes.NewReader(data)
	if guid, err := readPackedGUID(r); err != nil || guid != caster {
		return 0, false
	}
	var log struct{ Spell, Effects, Effect, Targets uint32 }
	if binary.Read(r, binary.LittleEndian, &log) != nil {
		return 0, false
	}
	if log.Spell != spellGordunniMoundChest && log.Spell != spellGordunniMoundJunk {
		return 0, false
	}
	if log.Effects == 0 || log.Effect != spellEffectSummonObjectWild || log.Targets == 0 {
		return 0, false
	}
	guid, err := readPackedGUID(r)
	return guid, err == nil
}

func readPackedGUID(r io.ByteReader) (uint64, error) {
	mask, err := r.ReadByte()
	if err != nil {
		return 0, err
	}
	var guid uint64
	for bit := 0; bit < 8; bit++ {
		if mask&(1<<uint(bit)) == 0 {
			continue
		}
		b, err := r.ReadByte()
		if err != nil {
			return 0, err
		}
		guid |= uint64(b) << (8 * uint(bit))
	}
	return guid, nil
}
