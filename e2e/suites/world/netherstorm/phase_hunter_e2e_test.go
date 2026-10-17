//go:build e2e

package netherstorm_test

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

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/18785
//
// Phase Hunter (18879) Mana Burn must only pick a target that uses mana. Its SmartAI row was keyed
// to SMART_EVENT_HAS_AURA with timer values as params, so the cast never happened at all.
//
// Drive: a warrior and a mage each put themselves on the hunter's threat list with `.damage 1` and
// leave it alive, so the random-target pick has one mana user and one rage user to choose from.
// Oracle: SMSG_SPELL_GO for Mana Burn from the hunter, with the mage as its only hit target, inside
// the row's first-cast window (8-16s after the pull). A Mana Burn that lands on the warrior fails.
func TestAC_18785_PhaseHunterManaBurnTargetsManaUser(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "issue", "world"},
		Runtime:  "short",
		Category: "world/netherstorm",
		Issue:    18785,
	})

	const (
		npcPhaseHunter = uint32(18879)
		spellManaBurn  = uint32(37176)
		// First cast is 8-16s after the pull; Mana Burn is instant. The rest is slack for slow ticks.
		manaBurnWindow = 25 * time.Second
	)

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "PhHunt",
		Bots: []e2eharness.BotSpec{
			{Role: "warrior", Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarrior, Level: 70},
			{Role: "mage", Race: e2eharness.RaceHuman, Class: e2eharness.ClassMage, Level: 70},
		},
	})
	warrior := e2eharness.ByRole(t, bots, "warrior")
	mage := e2eharness.ByRole(t, bots, "mage")

	pad := e2eharness.PackagePad(t)
	e2eharness.TeleportAllPad(t, bots, pad)
	hunter := warrior.Spawn(t, npcPhaseHunter, 15*time.Second)
	if mage.World.GetObject(hunter) == nil {
		mage.WaitUnit(t, npcPhaseHunter, 15*time.Second)
	}
	t.Logf("Phase Hunter guid=0x%X warrior=0x%X mage=0x%X", hunter, warrior.GUID, mage.GUID)

	var (
		mu     sync.Mutex
		casts  int
		target uint64
		wrong  []uint64
	)
	cancel := mage.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgSpellGo {
			return
		}
		caster, spellID, targets, ok := spellGoCasterAndTargets(data)
		if !ok || caster != hunter || spellID != spellManaBurn {
			return
		}
		mu.Lock()
		defer mu.Unlock()
		casts++
		for _, g := range targets {
			if g == mage.GUID {
				target = g
			} else {
				wrong = append(wrong, g)
			}
		}
	})
	defer cancel()

	for _, b := range bots {
		b.CombatReady(t)
	}
	warrior.Damage(t, hunter, 1)
	mage.Damage(t, hunter, 1)
	warrior.WaitUnitCombat(t, hunter, 10*time.Second)
	pulled := time.Now()

	for deadline := pulled.Add(manaBurnWindow); time.Now().Before(deadline); {
		mu.Lock()
		done := casts > 0
		mu.Unlock()
		if done {
			break
		}
		if hp, _ := mage.UnitHP(hunter); hp == 0 {
			e2eharness.Preconditionf(t, "Phase Hunter died before Mana Burn was due")
		}
		time.Sleep(100 * time.Millisecond)
	}

	mu.Lock()
	defer mu.Unlock()
	if casts == 0 {
		e2eharness.ConfirmedBugf(t, 18785, "Phase Hunter never cast Mana Burn (%d) within %s of the pull", spellManaBurn, manaBurnWindow)
	}
	if len(wrong) > 0 {
		e2eharness.Assertf(t, "Mana Burn hit 0x%X; only the mage 0x%X uses mana", wrong[0], mage.GUID)
	}
	if target != mage.GUID {
		e2eharness.Assertf(t, "Mana Burn went out but did not target the mage 0x%X", mage.GUID)
	}
	t.Logf("PASS Phase Hunter cast Mana Burn on the mage %s after the pull", time.Since(pulled).Round(100*time.Millisecond))
}

// spellGoCasterAndTargets reads an SMSG_SPELL_GO: packed caster item-or-unit GUID, packed caster
// unit GUID, cast count, spell id, cast flags, timestamp, the hit GUID list, then the miss list of
// GUID plus miss condition. A resisted Mana Burn still names the unit it picked, so misses count.
func spellGoCasterAndTargets(data []byte) (caster uint64, spellID uint32, targets []uint64, ok bool) {
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
		targets = append(targets, binary.LittleEndian.Uint64(data[off:]))
		off += 8
	}
	if off >= len(data) {
		return 0, 0, nil, false
	}
	missCount := int(data[off])
	off++
	for i := 0; i < missCount; i++ {
		if off+9 > len(data) {
			return 0, 0, nil, false
		}
		targets = append(targets, binary.LittleEndian.Uint64(data[off:]))
		cond := data[off+8]
		off += 9
		if cond == 11 { // SPELL_MISS_REFLECT carries the reflect result
			off++
		}
	}
	return caster, spellID, targets, true
}
