//go:build e2e

package threat_test

import (
	"encoding/binary"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/28289
//
// A mob only re-picked its victim on the ThreatManager's 1s update tick, so a tank's Thunder Clap
// on a mob another player had pulled took a random 0-1s to turn it. Incite and the other talents
// in the report only made it noticeable; the delay was the same without them.
//
// Drive: the dps bot pulls a Crimson Templar with `.damage 1`, then the warrior Thunder Claps it from
// melee range. Each trial waits a different offset after the pull, spread across the 1s tick period,
// so a cast that happens to land just before a tick cannot pass the test on its own.
// Oracle: the mob's UNIT_FIELD_TARGET turns to the warrior within switchWindow of the Thunder Clap
// SMSG_SPELL_GO, in every trial.
func TestAC_28289_ThunderClapPullsAggroWithoutTick(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "combat", "multi_bot", "issue"},
		Runtime:  "med",
		Category: "combat/threat",
		Issue:    28289,
	})

	const (
		spellThunderClap  = uint32(47502) // rank 9, 8yd around the caster
		spellBattleStance = uint32(e2eharness.SpellBattleStance)
		// The tick-bound core switches 0-1s after the cast; a fixed core within one map update.
		switchWindow = 250 * time.Millisecond
		trials       = 5
		// Trial i casts pullSettle + i*tickStagger after the pull, one point per 200ms of the 1s tick.
		pullSettle  = 1000 * time.Millisecond
		tickStagger = 200 * time.Millisecond
		// A miss leaves the warrior without threat; only then is the trial cast again.
		castsPerTrial = 3
	)

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "Thr289",
		Bots: []e2eharness.BotSpec{
			// LearnAllClass also learns Incite, the talent in the report.
			{Role: "tank", Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
			{Role: "dps", Class: e2eharness.ClassWarrior, Level: 80},
		},
	})
	tank := e2eharness.ByRole(t, bots, "tank")
	dps := e2eharness.ByRole(t, bots, "dps")

	pad := e2eharness.PackagePad(t)
	e2eharness.TeleportAllPad(t, bots, pad)
	tank.CombatReadyFull(t)
	tank.GM(t, ".cheat cooldown on")
	tank.CastMust(t, spellBattleStance, 0, 10*time.Second)

	var (
		mu  sync.Mutex
		gos []thunderClapGo
	)
	cancel := tank.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgSpellGo {
			return
		}
		at := time.Now()
		caster, spellID, hits, ok := spellGoHits(data)
		if !ok || caster != tank.GUID || spellID != spellThunderClap {
			return
		}
		mu.Lock()
		gos = append(gos, thunderClapGo{at: at, hits: hits})
		mu.Unlock()
	})
	defer cancel()
	lastGo := func() (thunderClapGo, int) {
		mu.Lock()
		defer mu.Unlock()
		if len(gos) == 0 {
			return thunderClapGo{}, 0
		}
		return gos[len(gos)-1], len(gos)
	}

	var slow []time.Duration
	for i := 0; i < trials; i++ {
		offset := pullSettle + time.Duration(i)*tickStagger
		var delay time.Duration
		landed := false
		for attempt := 0; attempt < castsPerTrial && !landed; attempt++ {
			// The tank spawns the mob (Spawn puts it in GM mode, so the mob cannot aggro it first);
			// Spawn also deletes the previous trial's mob, which ends the tank's combat with it.
			mob := tank.Spawn(t, pullHostile, 15*time.Second)
			tank.CombatReadyFull(t)
			if dps.World.GetObject(mob) == nil {
				dps.WaitUnit(t, pullHostile, 15*time.Second)
			}
			dps.CombatReady(t)
			dps.Damage(t, mob, 1)
			dps.WaitUnitTarget(t, mob, dps.GUID, 10*time.Second)

			time.Sleep(offset)
			// the oracle reads the tank's object cache, so the tank must see the pull too before the clap
			for wait := time.Now().Add(2 * time.Second); e2eharness.UnitTargetGUID(tank.World, mob) != dps.GUID &&
				time.Now().Before(wait); {
				time.Sleep(10 * time.Millisecond)
			}
			if got := e2eharness.UnitTargetGUID(tank.World, mob); got != dps.GUID {
				e2eharness.Preconditionf(t, "trial %d: before the clap the tank sees mob 0x%X "+
					"(cached %v, in combat %v) targeting 0x%X and the dps sees it targeting 0x%X, not the dps 0x%X",
					i, mob, tank.World.GetObject(mob) != nil, tank.UnitInCombat(mob), got,
					e2eharness.UnitTargetGUID(dps.World, mob), dps.GUID)
			}

			_, before := lastGo()
			tank.CastMust(t, spellThunderClap, 0, 10*time.Second)
			// the cast waiter and this hook see the same packet; give the hook a moment if it runs second
			clap, n := lastGo()
			for wait := time.Now().Add(time.Second); n == before && time.Now().Before(wait); clap, n = lastGo() {
				time.Sleep(2 * time.Millisecond)
			}
			if n == before {
				e2eharness.HarnessFailf(t, "trial %d: Thunder Clap SMSG_SPELL_GO not captured by the hook", i)
			}
			if !containsGUID(clap.hits, mob) {
				t.Logf("trial %d attempt %d: Thunder Clap missed mob 0x%X (hits %v), casting again", i, attempt, mob,
					clap.hits)
				continue
			}

			deadline := clap.at.Add(3 * time.Second)
			for e2eharness.UnitTargetGUID(tank.World, mob) != tank.GUID && time.Now().Before(deadline) {
				time.Sleep(2 * time.Millisecond)
			}
			if e2eharness.UnitTargetGUID(tank.World, mob) != tank.GUID {
				e2eharness.ConfirmedBugf(t, 28289,
					"trial %d: mob 0x%X never turned to the tank 0x%X within 3s of Thunder Clap", i, mob, tank.GUID)
			}
			delay = time.Since(clap.at)
			landed = true
		}
		if !landed {
			e2eharness.Preconditionf(t, "trial %d: Thunder Clap missed the mob %d times in a row", i, castsPerTrial)
		}
		t.Logf("trial %d: cast %s after the pull, mob turned to the tank %s after SMSG_SPELL_GO", i, offset,
			delay.Round(time.Millisecond))
		if delay > switchWindow {
			slow = append(slow, delay.Round(time.Millisecond))
		}
	}

	if len(slow) > 0 {
		e2eharness.ConfirmedBugf(t, 28289, "%d of %d Thunder Claps took longer than %s to turn the mob: %v",
			len(slow), trials, switchWindow, slow)
	}
	t.Logf("PASS every Thunder Clap turned the mob to the tank 0x%X within %s", tank.GUID, switchWindow)
}

type thunderClapGo struct {
	at   time.Time
	hits []uint64
}

func containsGUID(list []uint64, guid uint64) bool {
	for _, g := range list {
		if g == guid {
			return true
		}
	}
	return false
}

// spellGoHits reads an SMSG_SPELL_GO: packed caster item-or-unit GUID, packed caster unit GUID,
// cast count, spell id, cast flags, timestamp, then the hit GUID list (misses are left out).
func spellGoHits(data []byte) (caster uint64, spellID uint32, hits []uint64, ok bool) {
	off := 0
	for i := 0; i < 2; i++ {
		if off >= len(data) {
			return 0, 0, nil, false
		}
		mask := data[off]
		off++
		var guid uint64
		for bit := 0; bit < 8; bit++ {
			if mask&(1<<uint(bit)) == 0 {
				continue
			}
			if off >= len(data) {
				return 0, 0, nil, false
			}
			guid |= uint64(data[off]) << (8 * uint(bit))
			off++
		}
		caster = guid
	}
	off++ // cast count
	if off+13 > len(data) {
		return 0, 0, nil, false
	}
	spellID = binary.LittleEndian.Uint32(data[off:])
	off += 4 + 4 + 4 // spell id, cast flags, timestamp
	hitCount := int(data[off])
	off++
	if off+8*hitCount > len(data) {
		return 0, 0, nil, false
	}
	for i := 0; i < hitCount; i++ {
		hits = append(hits, binary.LittleEndian.Uint64(data[off:]))
		off += 8
	}
	return caster, spellID, hits, true
}
