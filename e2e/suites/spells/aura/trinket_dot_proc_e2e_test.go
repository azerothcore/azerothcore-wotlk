//go:build e2e

package aura_test

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27820
//
// Flare of the Heavens, Sundial of the Exiled and Pendulum of Telluric Currents proc from "your harmful
// spells". Their spell_proc rows only accepted hits that deal damage, so applying a DoT, whose hit deals
// none, never procced them. Accepting no-damage hits must not let helpful spells in: Sundial's DBC proc
// flags also hold done positive magic spells.
//
// Drive: a level 80 warlock with one trinket equipped first casts Fel Armor, a positive magic spell that
// neither damages nor heals, on itself dotProcHelpfulTries times. It then casts Corruption on a Heroic
// Training Dummy and strips it from the dummy before its first 3s tick, so only the application can proc
// (Pendulum also procs from periodic damage), until the trinket procs or the tries run out.
// `.cheat cooldown` lifts the GCD and the trinkets' 45s proc cooldown, `.cheat power` the mana cost.
// Oracle: SMSG_SPELL_GO from the warlock for the trinket's triggered spell: none from Fel Armor, then one
// from a Corruption application with no Corruption tick seen.

const (
	dotProcSpellCorruption = uint32(47813)
	dotProcSpellFelArmor   = uint32(47893)
	dotProcOpPeriodicLog   = uint16(0x024E)
	// About 8% per try (10% proc chance, 17% spell miss on the L83 dummy): 150 misses in a row is ~2e-6.
	dotProcMaxTries = 150
	// A self-buff can't miss: 80 casts without a proc at 10% is ~2e-4 if helpful spells did proc.
	dotProcHelpfulTries = 80
)

type dotProcTrinket struct {
	name    string
	item    uint32
	trigger uint32
}

var dotProcTrinkets = []dotProcTrinket{
	{"FlareOfTheHeavens", 45518, 64713},
	{"SundialOfTheExiled", 40682, 60064},
	{"PendulumOfTelluricCurrents", 37264, 60483},
}

// dotProcLog counts the warlock's casts of each trinket trigger and its Corruption ticks.
type dotProcLog struct {
	mu    sync.Mutex
	casts map[uint32]int
	ticks int
}

func (l *dotProcLog) counts(spellID uint32) (casts, ticks int) {
	l.mu.Lock()
	defer l.mu.Unlock()
	return l.casts[spellID], l.ticks
}

func watchDotProcs(t *testing.T, bot *e2eharness.ScenarioBot) *dotProcLog {
	t.Helper()
	l := &dotProcLog{casts: map[uint32]int{}}
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		r := bytes.NewReader(data)
		switch opcode {
		case client.SmsgSpellGo:
			if _, ok := readPackedGUID(r); !ok { // cast item or caster
				return
			}
			caster, ok := readPackedGUID(r)
			var castCount uint8
			var spellID uint32
			if !ok || caster != bot.GUID || binary.Read(r, binary.LittleEndian, &castCount) != nil ||
				binary.Read(r, binary.LittleEndian, &spellID) != nil {
				return
			}
			l.mu.Lock()
			l.casts[spellID]++
			l.mu.Unlock()
		case dotProcOpPeriodicLog:
			if _, ok := readPackedGUID(r); !ok { // target
				return
			}
			caster, ok := readPackedGUID(r)
			var spellID uint32
			if ok && caster == bot.GUID && binary.Read(r, binary.LittleEndian, &spellID) == nil &&
				spellID == dotProcSpellCorruption {
				l.mu.Lock()
				l.ticks++
				l.mu.Unlock()
			}
		}
	})
	t.Cleanup(cancel)
	return l
}

func TestAC_27820_HarmfulSpellTrinketsProcOnDotApply(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "aura", "proc", "items", "issue"},
		Runtime:  "med",
		Category: "spells/aura",
		Issue:    27820,
	})

	// Subtests close the harness's cached world DB after the first one; spawns need their own.
	db, err := e2eharness.OpenWorldDB()
	if err != nil {
		e2eharness.Preconditionf(t, "world DB: %v", err)
	}
	t.Cleanup(func() { _ = db.Close() })

	lock := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DotPrc",
		Race:   e2eharness.RaceHuman,
		Class:  e2eharness.ClassWarlock,
		Level:  80,
	})
	lock.WorldDB = db
	lock.TeleportPad(t, e2eharness.PackagePad(t))
	lock.Learn(t, dotProcSpellCorruption)
	lock.Learn(t, dotProcSpellFelArmor)
	log := watchDotProcs(t, lock)

	dummy := lock.Spawn(t, e2eharness.CreatureHeroicTrainingDummy, 15*time.Second)
	lock.CombatReadyFull(t)
	lock.GM(t, ".cheat cooldown on")
	lock.GM(t, ".cheat power on")
	lock.Face(t, dummy)

	for _, trinket := range dotProcTrinkets {
		t.Run(trinket.name, func(t *testing.T) {
			// Trinkets can't be equipped in combat, and the previous trinket's Corruptions engaged the dummy.
			lock.CombatStop(t)
			lock.FlushWorld(t)
			bag, bagSlot := lock.AddItemWait(t, trinket.item, 1)
			if err := lock.World.AutoEquipItem(bag, bagSlot); err != nil {
				e2eharness.HarnessFailf(t, "auto-equip item %d from %d/%d: %v", trinket.item, bag, bagSlot, err)
			}
			slot := lock.WaitEquipped(t, trinket.item, 10*time.Second)
			t.Cleanup(func() {
				lock.GM(t, fmt.Sprintf(".additem %d -1", trinket.item))
				for deadline := time.Now().Add(5 * time.Second); time.Now().Before(deadline); {
					if _, equipped := lock.EquippedSlot(trinket.item); !equipped {
						return
					}
					time.Sleep(100 * time.Millisecond)
				}
				e2eharness.HarnessFailf(t, "item %d still equipped after .additem -1", trinket.item)
			})
			t.Logf("item %d equipped in slot %d", trinket.item, slot)

			helpful0, _ := log.counts(trinket.trigger)
			for range dotProcHelpfulTries {
				lock.CastMust(t, dotProcSpellFelArmor, lock.GUID, 5*time.Second)
			}
			time.Sleep(300 * time.Millisecond)
			if helpful, _ := log.counts(trinket.trigger); helpful != helpful0 {
				e2eharness.Assertf(t, "item %d cast %d %d times from %d Fel Armor casts; it procs from harmful "+
					"spells only", trinket.item, trinket.trigger, helpful-helpful0, dotProcHelpfulTries)
			}
			t.Logf("no %d from %d Fel Armor casts", trinket.trigger, dotProcHelpfulTries)

			casts0, ticks0 := log.counts(trinket.trigger)
			tries := 0
			for tries < dotProcMaxTries {
				tries++
				lock.CastMust(t, dotProcSpellCorruption, dummy, 5*time.Second)
				time.Sleep(300 * time.Millisecond)
				_ = lock.World.SetTarget(dummy)
				lock.GM(t, fmt.Sprintf(".unaura %d", dotProcSpellCorruption))
				if casts, _ := log.counts(trinket.trigger); casts > casts0 {
					break
				}
			}
			time.Sleep(300 * time.Millisecond)
			casts, ticks := log.counts(trinket.trigger)
			casts, ticks = casts-casts0, ticks-ticks0
			t.Logf("%d Corruption casts: %d casts of %d, %d Corruption ticks", tries, casts, trinket.trigger, ticks)
			if ticks != 0 {
				e2eharness.Preconditionf(t, "Corruption ticked %d times on dummy 0x%X; it must be stripped before its "+
					"first tick", ticks, dummy)
			}
			if casts == 0 {
				e2eharness.ConfirmedBugf(t, 27820, "item %d never cast %d in %d Corruption applications",
					trinket.item, trinket.trigger, dotProcMaxTries)
			}
			t.Logf("PASS item %d procs %d from a Corruption application", trinket.item, trinket.trigger)
		})
	}
}
