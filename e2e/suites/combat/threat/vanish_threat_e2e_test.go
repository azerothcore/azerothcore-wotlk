//go:build e2e

package threat_test

import (
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Follow-up to https://github.com/azerothcore/azerothcore-wotlk/pull/28301 (issue #28289).
//
// In a dungeon, Vanish's SPELL_EFFECT_SANCTUARY zeroes the rogue on every threat list instead of
// stopping combat. The mob kept the rogue as its victim until its 1s threat tick, so it went on
// hitting the vanished rogue for up to a second before turning to the next player.
//
// The rogue stands inside the mob's combat reach, where stealth is always detected: the rogue's
// threat entry stays online at zero, so only a reselect can move the mob off it. (A rogue the mob
// cannot see goes offline, and GetCurrentVictim() already reselects for that.)
//
// Drive: in a Stockade instance, the rogue spawns a Crimson Templar at its feet and takes the top of
// its threat with `.damage`, the second bot adds a little threat, then the rogue casts Vanish. Each
// trial waits a different offset after the pull, spread across the 1s tick period.
// Oracle: the mob's UNIT_FIELD_TARGET leaves the rogue for the second bot within switchWindow of
// the Vanish SMSG_SPELL_GO, in every trial.
func TestThreat_VanishInDungeonDropsAggroWithoutTick(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "combat", "multi_bot", "instance"},
		Runtime:  "med",
		Category: "combat/threat",
	})

	const (
		spellVanish  = uint32(26889) // rank 3; effect 2 is SPELL_EFFECT_SANCTUARY
		spellVanishA = uint32(26888) // its stealth aura
		spellStealth = uint32(1784)  // cast by the Vanish script
		mapStockade  = uint32(34)
		// Crimson Templar's combat reach: inside it the mob detects stealth whatever the levels.
		detectReach = float32(3.0)
		// The tick-bound core switches 0-1s after the cast; a fixed core within one map update.
		switchWindow = 250 * time.Millisecond
		trials       = 5
		// Trial i casts pullSettle + i*tickStagger after the pull, one point per 200ms of the 1s tick.
		pullSettle  = 1000 * time.Millisecond
		tickStagger = 200 * time.Millisecond
	)
	// Stockade interior, the same spot as instances/bind_reset.
	stockade := e2eharness.Position3{X: 54.23, Y: 0.28, Z: -18.34, Map: mapStockade}

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "ThrVan",
		Bots: []e2eharness.BotSpec{
			{Role: "rogue", Race: e2eharness.RaceHuman, Class: e2eharness.ClassRogue, Level: 80, LearnAllClass: true},
			{Role: "mate", Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarrior, Level: 80},
		},
	})
	rogue := e2eharness.ByRole(t, bots, "rogue")
	mate := e2eharness.ByRole(t, bots, "mate")

	// Grouped so the summon lands the mate in the rogue's copy of the dungeon.
	e2eharness.FormParty(t, rogue, mate)
	rogue.Teleport(t, stockade.X, stockade.Y, stockade.Z, stockade.Map)
	if _, _, _, m := rogue.Pos(); m != mapStockade {
		e2eharness.Preconditionf(t, "rogue not in the Stockade (map %d, got %d)", mapStockade, m)
	}
	before := mate.World.TeleportSeq()
	rogue.GM(t, ".summon "+mate.Name)
	if err := mate.World.WaitForTeleportAfter(before, 15*time.Second); err != nil {
		e2eharness.Preconditionf(t, "mate .summon into the Stockade: %v", err)
	}
	if _, _, _, m := mate.Pos(); m != mapStockade {
		e2eharness.Preconditionf(t, "mate not in the Stockade after .summon (map %d)", m)
	}
	rogue.GM(t, ".cheat cooldown on")

	var (
		mu  sync.Mutex
		gos []time.Time
	)
	cancel := rogue.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgSpellGo {
			return
		}
		at := time.Now()
		caster, spellID, _, ok := spellGoHits(data)
		if !ok || caster != rogue.GUID || spellID != spellVanish {
			return
		}
		mu.Lock()
		gos = append(gos, at)
		mu.Unlock()
	})
	defer cancel()
	lastGo := func() (time.Time, int) {
		mu.Lock()
		defer mu.Unlock()
		if len(gos) == 0 {
			return time.Time{}, 0
		}
		return gos[len(gos)-1], len(gos)
	}

	var slow []time.Duration
	for i := 0; i < trials; i++ {
		offset := pullSettle + time.Duration(i)*tickStagger

		// Out of stealth from the previous trial, and the mate unseen while the mob spawns, so the
		// mob's proximity aggro can only land on the rogue it spawns on.
		for _, s := range []uint32{spellVanishA, spellStealth} {
			if rogue.HasAura(s) {
				rogue.CancelAura(t, s)
			}
		}
		mate.GM(t, ".gm on")
		mate.FlushWorld(t)
		// Spawn deletes the previous trial's mob, which ends both bots' combat with it.
		mob := rogue.Spawn(t, pullHostile, 15*time.Second)
		// Crimson Templar spawns immune to players; its SmartAI clears that 5s later, out of combat.
		// Until then `.damage` starts no combat, and the mob would only proximity-pull whoever is near.
		attackable := func() bool {
			o := rogue.World.GetObject(mob)
			return o != nil && o.Value(client.UnitFieldFlags)&client.UnitFlagImmuneToPC == 0
		}
		for wait := time.Now().Add(10 * time.Second); !attackable() && time.Now().Before(wait); {
			time.Sleep(50 * time.Millisecond)
		}
		if !attackable() {
			e2eharness.Preconditionf(t, "trial %d: mob 0x%X still immune to players 10s after spawning", i, mob)
		}
		rogue.CombatReadyFull(t)
		rogue.Damage(t, mob, 200)
		rogue.WaitUnitTarget(t, mob, rogue.GUID, 10*time.Second)
		mate.CombatReady(t)
		if mate.World.GetObject(mob) == nil {
			mate.WaitUnit(t, pullHostile, 15*time.Second)
		}
		mate.Damage(t, mob, 1)

		time.Sleep(offset)
		if got := e2eharness.UnitTargetGUID(rogue.World, mob); got != rogue.GUID {
			e2eharness.Preconditionf(t, "trial %d: mob 0x%X targets 0x%X, not the rogue 0x%X, before Vanish",
				i, mob, got, rogue.GUID)
		}
		obj := rogue.World.GetObject(mob)
		if obj == nil {
			e2eharness.Preconditionf(t, "trial %d: mob 0x%X left the rogue's object cache", i, mob)
		}
		rx, ry, rz, _ := rogue.Pos()
		mx, my, mz := obj.InterpolatedPosition()
		if d := e2eharness.Distance3D(rx, ry, rz, mx, my, mz); d >= detectReach {
			e2eharness.Preconditionf(t, "trial %d: rogue %.1fyd from the mob, outside its %.0fyd combat reach",
				i, d, detectReach)
		}
		if !mate.UnitInCombat(mate.GUID) {
			e2eharness.Preconditionf(t, "trial %d: mate 0x%X not in combat after .damage", i, mate.GUID)
		}

		_, n0 := lastGo()
		rogue.CastMust(t, spellVanish, 0, 10*time.Second)
		vanished, n := lastGo()
		for wait := time.Now().Add(time.Second); n == n0 && time.Now().Before(wait); vanished, n = lastGo() {
			time.Sleep(2 * time.Millisecond)
		}
		if n == n0 {
			e2eharness.HarnessFailf(t, "trial %d: Vanish SMSG_SPELL_GO not captured by the hook", i)
		}

		deadline := vanished.Add(3 * time.Second)
		for e2eharness.UnitTargetGUID(rogue.World, mob) != mate.GUID && time.Now().Before(deadline) {
			time.Sleep(2 * time.Millisecond)
		}
		if got := e2eharness.UnitTargetGUID(rogue.World, mob); got != mate.GUID {
			e2eharness.Assertf(t, "trial %d: mob 0x%X targets 0x%X 3s after Vanish, not the mate 0x%X",
				i, mob, got, mate.GUID)
		}
		delay := time.Since(vanished)
		t.Logf("trial %d: Vanish %s after the pull, mob turned to the mate %s after SMSG_SPELL_GO", i, offset,
			delay.Round(time.Millisecond))
		if delay > switchWindow {
			slow = append(slow, delay.Round(time.Millisecond))
		}
	}

	if len(slow) > 0 {
		e2eharness.Assertf(t, "%d of %d Vanishes took longer than %s to turn the mob off the rogue: %v",
			len(slow), trials, switchWindow, slow)
	}
	t.Logf("PASS every Vanish turned the mob from the rogue 0x%X to the mate 0x%X within %s", rogue.GUID,
		mate.GUID, switchWindow)
}
