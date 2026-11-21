//go:build e2e

package trial_of_the_crusader_test

import (
	"encoding/binary"
	"fmt"
	"math"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	npcChampionDeathKnight = uint32(34461)

	spellChampionDeathGrip = uint32(66017)
	spellMisery            = uint32(33198)
	spellDivineShield      = uint32(642)
	spellSpellReflection   = uint32(23920)

	missImmune  = uint8(7)
	missImmune2 = uint8(8)
	missReflect = uint8(11)

	// MoveSplineFlag values as AC writes them into SMSG_MONSTER_MOVE.
	splineParabolic  = uint32(0x00000800)
	splineFlying     = uint32(0x00002000)
	splineCatmullrom = uint32(0x00040000)
	splineAnimation  = uint32(0x00200000)
)

// spellGoOutcome reads the caster guid, spell id, hit guids and miss reasons from a 3.3.5
// SMSG_SPELL_GO. A reflected miss carries one more byte, the reflected spell's own result.
func spellGoOutcome(data []byte) (caster uint64, spell uint32, hits []uint64, misses map[uint64]uint8, ok bool) {
	caster, spell, hits, ok = spellGoHits(data)
	if !ok {
		return 0, 0, nil, nil, false
	}
	_, off := readPackedGUID(data, 0)
	_, off = readPackedGUID(data, off)
	off += 1 + 12 + 1 + 8*len(hits) // cast count, spell id/flags/timestamp, hit count, hits
	if off >= len(data) {
		return 0, 0, nil, nil, false
	}
	count := int(data[off])
	off++
	misses = map[uint64]uint8{}
	for i := 0; i < count; i++ {
		if off+9 > len(data) {
			return 0, 0, nil, nil, false
		}
		guid, reason := binary.LittleEndian.Uint64(data[off:]), data[off+8]
		off += 9
		if reason == missReflect {
			off++
		}
		misses[guid] = reason
	}
	return caster, spell, hits, misses, true
}

// parabolicDest reads the mover and destination of a parabolic (jump) SMSG_MONSTER_MOVE; ok is false
// for any other spline.
func parabolicDest(data []byte) (mover uint64, dest [3]float32, ok bool) {
	mover, off := readPackedGUID(data, 0)
	off += 1 + 12 + 4 // MOVEMENTFLAG2_UNK7 toggle, start position, spline id
	if off >= len(data) {
		return 0, dest, false
	}
	switch data[off] {
	case 1: // stop
		return 0, dest, false
	case 2: // facing spot
		off += 12
	case 3: // facing target
		off += 8
	case 4: // facing angle
		off += 4
	}
	off++
	if off+4 > len(data) {
		return 0, dest, false
	}
	flags := binary.LittleEndian.Uint32(data[off:])
	off += 4
	if flags&splineParabolic == 0 {
		return 0, dest, false
	}
	if flags&splineAnimation != 0 {
		off += 5
	}
	off += 4 + 8 // duration, vertical acceleration and effect start time
	if off+4 > len(data) {
		return 0, dest, false
	}
	points := int(binary.LittleEndian.Uint32(data[off:]))
	off += 4
	if points > 0 && flags&(splineFlying|splineCatmullrom) != 0 {
		off += 12 * (points - 1) // the last full point is the destination
	}
	if points == 0 || off+12 > len(data) {
		return 0, dest, false
	}
	for i := range dest {
		dest[i] = math.Float32frombits(binary.LittleEndian.Uint32(data[off+4*i:]))
	}
	return mover, dest, true
}

func dist2d(x1, y1, x2, y2 float32) float32 {
	dx, dy := float64(x1-x2), float64(y1-y2)
	return float32(math.Sqrt(dx*dx + dy*dy))
}

// The Faction Champions Death Knight's Death Grip (66017) pulls its target only when the grip hits:
// on a hit the Death Knight casts the player Death Grip effect (49560) on the target, which jumps to
// a point in front of him. An immune target is not pulled, and a reflected grip makes the reflecting
// player grip the Death Knight instead.
//
// Drive: a temp Death Knight in the arena casts Death Grip through `.cast back` at a warrior bot 20
// yards away. Champions are passive and only attack once the encounter starts them, which needs
// Barrett's gossip, so a temp one never runs his own Death Grip event; its unit flags are cleared as
// the encounter start clears them. One case per bot state, each deterministic: Misery (+3% chance to
// be hit by spells, covering the 1% miss of a champion that counts as three levels above its target),
// Divine Shield, and Spell Reflection (100% reflect). 49560 and the jump spells carry no spell visual,
// so AC sends no SMSG_SPELL_GO for them; the jump shows only as a parabolic SMSG_MONSTER_MOVE.
// Oracle: the 66017 SMSG_SPELL_GO outcome on the bot, then which unit, if any, starts a parabolic
// spline and where it lands.
func TestToC_ChampionDeathGripPullsOnlyOnHit(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances"},
		Runtime:  "med",
		Category: "instances/northrend/trial_of_the_crusader",
	})

	const (
		gripWindow = 8 * time.Second
		jumpWindow = 3 * time.Second
		// The grip lands its target a few yards in front of the gripper.
		landReach = float32(8)
	)

	// Death Knight on the arena centre, bot 20 yards north of him.
	dkSpot := [3]float32{centerX, centerY, centerZ}
	botSpot := [3]float32{centerX, centerY + 20, centerZ}

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DkGrip", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})

	type gripCast struct {
		hit    bool
		reason uint8
		missed bool
	}
	var mu sync.Mutex
	var dk uint64
	var grip *gripCast
	jumps := map[uint64][3]float32{}
	unhook := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		switch opcode {
		case client.SmsgSpellGo:
			caster, spell, hits, misses, ok := spellGoOutcome(data)
			if !ok || spell != spellChampionDeathGrip {
				return
			}
			mu.Lock()
			defer mu.Unlock()
			if caster != dk || grip != nil {
				return
			}
			g := &gripCast{}
			for _, h := range hits {
				g.hit = g.hit || h == bot.GUID
			}
			g.reason, g.missed = misses[bot.GUID]
			grip = g
		case client.SmsgMonsterMove:
			mover, dest, ok := parabolicDest(data)
			if !ok {
				return
			}
			mu.Lock()
			defer mu.Unlock()
			if _, seen := jumps[mover]; !seen {
				jumps[mover] = dest
			}
		}
	})
	t.Cleanup(unhook)

	jumpOf := func(guid uint64, window time.Duration) ([3]float32, bool) {
		deadline := time.Now().Add(window)
		for {
			mu.Lock()
			dest, seen := jumps[guid]
			mu.Unlock()
			if seen || !time.Now().Before(deadline) {
				return dest, seen
			}
			time.Sleep(50 * time.Millisecond)
		}
	}

	for _, c := range []struct {
		name string
		aura uint32
	}{
		{"hit", spellMisery},
		{"divine shield", spellDivineShield},
		{"spell reflection", spellSpellReflection},
	} {
		t.Run(c.name, func(t *testing.T) {
			// Stay GM through the raid enter (.go xyz onto a raid map is ignored after .gm off).
			bot.GM(t, ".gm on")
			bot.Teleport(t, dkSpot[0], dkSpot[1], dkSpot[2], mapTrialOfTheCrusader)
			if _, _, _, m := bot.Pos(); m != mapTrialOfTheCrusader {
				e2eharness.Preconditionf(t, "bot not in Trial of the Crusader after tele map=%d", m)
			}
			knight := spawnTemp(t, bot, npcChampionDeathKnight)
			// Champions spawn non-attackable until the encounter starts; a reflected grip needs the
			// bot to be able to cast on the Death Knight.
			if err := bot.World.SetTarget(knight); err != nil {
				e2eharness.HarnessFailf(t, "SetTarget Death Knight: %v", err)
			}
			bot.GM(t, fmt.Sprintf(".debug setvalue %d 0", unitFieldFlags))
			var flags uint32 = math.MaxUint32
			for deadline := time.Now().Add(5 * time.Second); flags != 0 && time.Now().Before(deadline); time.Sleep(sampleEvery) {
				if o := bot.World.GetObject(knight); o != nil {
					flags = o.Value(unitFieldFlags)
				}
			}
			if flags != 0 {
				e2eharness.Preconditionf(t, "Death Knight 0x%X still has unit flags 0x%X; it must be attackable like once the encounter starts", knight, flags)
			}
			bot.Teleport(t, botSpot[0], botSpot[1], botSpot[2], mapTrialOfTheCrusader)
			t.Cleanup(func() { bot.CombatStop(t) })

			bot.ApplyAura(t, c.aura)
			t.Cleanup(func() {
				_ = bot.World.SetTarget(bot.GUID)
				bot.GM(t, fmt.Sprintf(".unaura %d", c.aura))
			})

			mu.Lock()
			dk, grip = knight, nil
			jumps = map[uint64][3]float32{}
			mu.Unlock()

			bot.CombatReady(t)
			if err := bot.World.SetTarget(knight); err != nil {
				e2eharness.HarnessFailf(t, "SetTarget Death Knight: %v", err)
			}
			bot.GM(t, fmt.Sprintf(".cast back %d", spellChampionDeathGrip))

			var got *gripCast
			for deadline := time.Now().Add(gripWindow); got == nil && time.Now().Before(deadline); time.Sleep(50 * time.Millisecond) {
				mu.Lock()
				got = grip
				mu.Unlock()
			}
			if got == nil {
				e2eharness.Preconditionf(t, "Death Knight 0x%X cast no Death Grip (%d) at the bot 20 yards away within %s", knight, spellChampionDeathGrip, gripWindow)
			}

			switch c.aura {
			case spellMisery:
				if !got.hit {
					e2eharness.Preconditionf(t, "Death Grip did not hit the bot (miss reason %d); the hit case needs a hit", got.reason)
				}
				dest, jumped := jumpOf(bot.GUID, jumpWindow)
				if !jumped {
					e2eharness.Assertf(t, "Death Grip hit the bot, but the bot started no jump within %s", jumpWindow)
				}
				o := bot.World.GetObject(knight)
				if o == nil {
					e2eharness.HarnessFailf(t, "Death Knight 0x%X left the object cache", knight)
				}
				if d := dist2d(dest[0], dest[1], o.PosX, o.PosY); d > landReach {
					e2eharness.Assertf(t, "the gripped bot jumps to (%.1f, %.1f), %.1f yards from the Death Knight; want within %.0f", dest[0], dest[1], d, landReach)
				}
				t.Logf("Death Grip hit the bot, which jumped to (%.1f, %.1f) by the Death Knight", dest[0], dest[1])
			case spellDivineShield:
				if !got.missed || (got.reason != missImmune && got.reason != missImmune2) {
					e2eharness.Preconditionf(t, "Death Grip on the Divine Shielded bot was not an immune miss (hit=%t reason=%d)", got.hit, got.reason)
				}
				if dest, jumped := jumpOf(bot.GUID, jumpWindow); jumped {
					e2eharness.Assertf(t, "the bot was immune to Death Grip but still jumped to (%.1f, %.1f)", dest[0], dest[1])
				}
				if dest, jumped := jumpOf(knight, 0); jumped {
					e2eharness.Assertf(t, "the bot was immune to Death Grip but the Death Knight jumped to (%.1f, %.1f)", dest[0], dest[1])
				}
				t.Logf("Death Grip missed the immune bot (reason %d) and nobody jumped within %s", got.reason, jumpWindow)
			case spellSpellReflection:
				if !got.missed || got.reason != missReflect {
					e2eharness.Preconditionf(t, "Death Grip on the bot under Spell Reflection was not reflected (hit=%t reason=%d)", got.hit, got.reason)
				}
				dest, jumped := jumpOf(knight, jumpWindow)
				if !jumped {
					e2eharness.Assertf(t, "the bot reflected Death Grip, but the Death Knight started no jump within %s", jumpWindow)
				}
				if d := dist2d(dest[0], dest[1], botSpot[0], botSpot[1]); d > landReach {
					e2eharness.Assertf(t, "the Death Knight jumps to (%.1f, %.1f), %.1f yards from the reflecting bot; want within %.0f", dest[0], dest[1], d, landReach)
				}
				if dest, jumped := jumpOf(bot.GUID, 0); jumped {
					e2eharness.Assertf(t, "the bot reflected Death Grip but was still pulled to (%.1f, %.1f)", dest[0], dest[1])
				}
				t.Logf("the bot reflected Death Grip and the Death Knight jumped to (%.1f, %.1f) in front of it", dest[0], dest[1])
			}
		})
	}

	t.Logf("PASS champion Death Grip pulls the bot only on a hit, pulls nobody off an immune bot, and pulls the Death Knight on a reflect")
}
