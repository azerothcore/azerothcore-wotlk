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

// Spells driving the scenario. Burning Determination rank 2 procs at 100%, so one landed
// interrupt is enough to judge it.
const (
	spellBurningDeterminationR2   = uint32(54749)
	spellBurningDeterminationBuff = uint32(54748)
	spellKick                     = uint32(1766)
	spellFrostbolt                = uint32(42842) // rank 16, 3s cast, interruptible

	spellMissReflect           = uint8(11) // SPELL_MISS_REFLECT carries one more byte in SMSG_SPELL_GO
	spellFailedInterrupted     = uint8(40) // SPELL_FAILED_INTERRUPTED
	burningDeterminationWindow = 1500 * time.Millisecond
	burningDeterminationKicks  = 6
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/26213
//
// Burning Determination (54747 / 54749) reads "When Interrupted or Silenced". It procced on any
// spell carrying an interrupt or silence mechanic, so a Kick at a mage casting nothing still gave
// the immunity buff 54748.
//
// Oracle: a Kick that SMSG_SPELL_GO lists as a hit on an idle mage must not give 54748 within
// 1.5s; on an unfixed core it does at once (CONFIRMED BUG). Control: a Kick that interrupts the
// mage's Frostbolt (SMSG_SPELL_FAILURE INTERRUPTED to the mage) gives 54748, so a talent that
// never procs cannot pass. A dodged or parried Kick is retried.
func TestAC_26213_BurningDeterminationNeedsInterruptedCast(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "issue", "multi_bot"},
		Runtime:  "med",
		Issue:    26213,
		Category: "spells/aura",
	})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "BurnDet",
		Bots: []e2eharness.BotSpec{
			{Role: "mage", Race: e2eharness.RaceHuman, Class: e2eharness.ClassMage, Level: 80, LearnAllClass: true},
			{Role: "rogue", Race: e2eharness.RaceOrc, Class: e2eharness.ClassRogue, Level: 80, LearnAllClass: true},
		},
	})
	mage := e2eharness.ByRole(t, bots, "mage")
	rogue := e2eharness.ByRole(t, bots, "rogue")

	pad := e2eharness.PackagePad(t)
	mage.TeleportPad(t, pad)
	rogue.Teleport(t, pad.X+2, pad.Y, pad.Z, pad.Map)

	// The talent is learned explicitly; the spell list is what shows it, since its passive aura
	// gets no visible client slot.
	mage.Learn(t, spellBurningDeterminationR2)
	if !mage.World.KnowsSpell(spellBurningDeterminationR2) {
		e2eharness.Preconditionf(t, "mage does not know Burning Determination %d after .learn", spellBurningDeterminationR2)
	}
	mage.Learn(t, spellFrostbolt)
	rogue.Learn(t, spellKick)

	for _, b := range bots {
		b.CombatStop(t)
		b.GM(t, ".cheat god on")
		b.GM(t, ".cheat power on")
	}
	// Kick has a 10s cooldown and a dodged try is retried at once.
	rogue.GM(t, ".cheat cooldown on")
	// A rogue on its starting weapon skill misses a level 80 target too often.
	rogue.GM(t, ".maxskill")

	// .gm off + PvP flag on both, then make each side see the other as hostile before any cast.
	e2eharness.EnableHostilePvP(t, mage, rogue)
	mage.FlushWorld(t)
	rogue.FlushWorld(t)
	mage.WaitUnitGUID(t, rogue.GUID, 10*time.Second)
	rogue.WaitUnitGUID(t, mage.GUID, 10*time.Second)
	mage.WaitUnitPvP(t, rogue.GUID, 5*time.Second)
	rogue.WaitUnitPvP(t, mage.GUID, 5*time.Second)

	kicks := watchKicks(rogue, mage.GUID)
	t.Cleanup(kicks.cancel)
	starts := watchSpellStarts(mage, spellFrostbolt)
	t.Cleanup(starts.cancel)

	clearBuff := func(t *testing.T) {
		t.Helper()
		if err := mage.World.SetTarget(mage.GUID); err != nil {
			e2eharness.Preconditionf(t, "select mage: %v", err)
		}
		mage.GM(t, fmt.Sprintf(".unaura %d", spellBurningDeterminationBuff))
		if !mage.TryWaitAuraGone(t, spellBurningDeterminationBuff, 3*time.Second) {
			e2eharness.Preconditionf(t, "mage still has Burning Determination %d after .unaura", spellBurningDeterminationBuff)
		}
	}

	t.Run("IdleMage", func(t *testing.T) {
		clearBuff(t)
		for attempt := 1; attempt <= burningDeterminationKicks; attempt++ {
			if !kickLanded(t, rogue, mage, kicks, attempt) {
				continue
			}
			if waitForSelfAura(mage, spellBurningDeterminationBuff, burningDeterminationWindow) {
				e2eharness.ConfirmedBugf(t, 26213,
					"Kick at a mage casting nothing gave Burning Determination %d; nothing was interrupted",
					spellBurningDeterminationBuff)
			}
			t.Logf("PASS AC#26213 Kick at an idle mage gave no Burning Determination within %s",
				burningDeterminationWindow)
			return
		}
		e2eharness.Preconditionf(t, "no Kick landed on the idle mage in %d attempts", burningDeterminationKicks)
	})

	t.Run("CastingMage", func(t *testing.T) {
		clearBuff(t)
		for attempt := 1; attempt <= burningDeterminationKicks; attempt++ {
			mage.ArmSpellWaiter()
			starts.reset()
			mage.Face(t, rogue.GUID)
			if err := mage.World.SetTarget(rogue.GUID); err != nil {
				e2eharness.Preconditionf(t, "mage select rogue: %v", err)
			}
			if err := mage.World.CastSpell(spellFrostbolt, rogue.GUID); err != nil {
				e2eharness.HarnessFailf(t, "send Frostbolt: %v", err)
			}
			if !starts.wait(2 * time.Second) {
				res, _ := mage.WaitSpellID(spellFrostbolt, 100*time.Millisecond)
				e2eharness.Preconditionf(t, "mage never started casting Frostbolt %d (last result success=%v reason=%s)",
					spellFrostbolt, res.Success, e2eharness.SpellFailReasonName(res.FailReason))
			}

			landed := kickLanded(t, rogue, mage, kicks, attempt)
			res, err := mage.WaitSpellID(spellFrostbolt, 5*time.Second)
			if err != nil {
				e2eharness.HarnessFailf(t, "attempt %d: no cast result for Frostbolt: %v", attempt, err)
			}
			if !landed {
				continue
			}
			if res.Success || res.FailReason != spellFailedInterrupted {
				e2eharness.Preconditionf(t, "Kick landed but Frostbolt was not interrupted (success=%v reason=%s)",
					res.Success, e2eharness.SpellFailReasonName(res.FailReason))
			}
			if !waitForSelfAura(mage, spellBurningDeterminationBuff, burningDeterminationWindow) {
				e2eharness.Assertf(t, "Kick interrupted the mage's Frostbolt but gave no Burning Determination %d within %s",
					spellBurningDeterminationBuff, burningDeterminationWindow)
			}
			t.Logf("PASS Kick interrupting Frostbolt gave Burning Determination %d", spellBurningDeterminationBuff)
			return
		}
		e2eharness.Preconditionf(t, "no Kick landed on the casting mage in %d attempts", burningDeterminationKicks)
	})

	mage.AssertWorldAlive(t)
}

// kickLanded makes the rogue Kick the mage and reports whether SMSG_SPELL_GO lists the mage as
// hit. A dodge, parry or miss returns false so the caller can retry; an immune miss is a
// precondition failure, since the buff was cleared before each case.
func kickLanded(t *testing.T, rogue, mage *e2eharness.ScenarioBot, kicks *kickWatch, attempt int) bool {
	t.Helper()
	kicks.reset()
	rogue.Face(t, mage.GUID)
	res, err := rogue.TryCast(t, spellKick, mage.GUID, 2*time.Second)
	if err != nil {
		e2eharness.HarnessFailf(t, "attempt %d: Kick produced no cast result: %v", attempt, err)
	}
	if !res.Success {
		t.Logf("attempt %d: Kick failed to cast (%s)", attempt, e2eharness.SpellFailReasonName(res.FailReason))
		return false
	}
	seen, hit, miss := kicks.wait(time.Second)
	if !seen {
		e2eharness.HarnessFailf(t, "attempt %d: Kick succeeded but no SMSG_SPELL_GO for it arrived", attempt)
	}
	if hit {
		return true
	}
	if miss == 7 || miss == 8 {
		e2eharness.Preconditionf(t, "attempt %d: mage immune to Kick (miss=%d)", attempt, miss)
	}
	t.Logf("attempt %d: Kick did not land on the mage (miss=%d)", attempt, miss)
	return false
}

// kickWatch records the outcome of the rogue's last Kick on the mage, read from SMSG_SPELL_GO.
// The harness parses SPELL_GO for its cast waiters but exposes neither the hit nor the miss list.
type kickWatch struct {
	mu     sync.Mutex
	seen   bool
	hit    bool
	miss   uint8
	cancel func()
}

func watchKicks(rogue *e2eharness.ScenarioBot, mageGUID uint64) *kickWatch {
	kw := &kickWatch{}
	kw.cancel = rogue.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgSpellGo {
			return
		}
		caster, spellID, hits, misses, ok := parseSpellGo(data)
		if !ok || caster != rogue.GUID || spellID != spellKick {
			return
		}
		kw.mu.Lock()
		defer kw.mu.Unlock()
		kw.seen = true
		kw.hit = false
		for _, g := range hits {
			if g == mageGUID {
				kw.hit = true
			}
		}
		kw.miss = misses[mageGUID]
	})
	return kw
}

func (kw *kickWatch) reset() {
	kw.mu.Lock()
	kw.seen, kw.hit, kw.miss = false, false, 0
	kw.mu.Unlock()
}

func (kw *kickWatch) wait(timeout time.Duration) (seen, hit bool, miss uint8) {
	deadline := time.Now().Add(timeout)
	for {
		kw.mu.Lock()
		seen, hit, miss = kw.seen, kw.hit, kw.miss
		kw.mu.Unlock()
		if seen || time.Now().After(deadline) {
			return
		}
		time.Sleep(20 * time.Millisecond)
	}
}

// spellStartWatch flags an SMSG_SPELL_START of one spell from the bot itself, so the Kick goes
// out only once the cast is in progress.
type spellStartWatch struct {
	mu      sync.Mutex
	started bool
	cancel  func()
}

func watchSpellStarts(bot *e2eharness.ScenarioBot, spellID uint32) *spellStartWatch {
	sw := &spellStartWatch{}
	sw.cancel = bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgSpellStart {
			return
		}
		reader := bytes.NewReader(data)
		caster, id, ok := readCastHeader(reader)
		if !ok || caster != bot.GUID || id != spellID {
			return
		}
		sw.mu.Lock()
		sw.started = true
		sw.mu.Unlock()
	})
	return sw
}

func (sw *spellStartWatch) reset() {
	sw.mu.Lock()
	sw.started = false
	sw.mu.Unlock()
}

func (sw *spellStartWatch) wait(timeout time.Duration) bool {
	deadline := time.Now().Add(timeout)
	for {
		sw.mu.Lock()
		started := sw.started
		sw.mu.Unlock()
		if started || time.Now().After(deadline) {
			return started
		}
		time.Sleep(20 * time.Millisecond)
	}
}

// readCastHeader reads the header SMSG_SPELL_START and SMSG_SPELL_GO share: cast-item packed
// GUID, caster packed GUID, cast count, spell id.
func readCastHeader(reader *bytes.Reader) (caster uint64, spellID uint32, ok bool) {
	if _, ok = readPackedGUID(reader); !ok {
		return 0, 0, false
	}
	if caster, ok = readPackedGUID(reader); !ok {
		return 0, 0, false
	}
	if _, err := reader.ReadByte(); err != nil {
		return 0, 0, false
	}
	if err := binary.Read(reader, binary.LittleEndian, &spellID); err != nil {
		return 0, 0, false
	}
	return caster, spellID, true
}

// parseSpellGo reads an SMSG_SPELL_GO as Spell::SendSpellGo writes it: the cast header, cast
// flags, timestamp, then the hit GUID list and the miss list of GUID plus miss condition.
func parseSpellGo(data []byte) (caster uint64, spellID uint32, hits []uint64, misses map[uint64]uint8, ok bool) {
	reader := bytes.NewReader(data)
	if caster, spellID, ok = readCastHeader(reader); !ok {
		return 0, 0, nil, nil, false
	}
	var flagsAndTime [2]uint32
	if err := binary.Read(reader, binary.LittleEndian, &flagsAndTime); err != nil {
		return 0, 0, nil, nil, false
	}
	hitCount, err := reader.ReadByte()
	if err != nil {
		return 0, 0, nil, nil, false
	}
	for i := 0; i < int(hitCount); i++ {
		var guid uint64
		if err := binary.Read(reader, binary.LittleEndian, &guid); err != nil {
			return 0, 0, nil, nil, false
		}
		hits = append(hits, guid)
	}
	missCount, err := reader.ReadByte()
	if err != nil {
		return 0, 0, nil, nil, false
	}
	misses = make(map[uint64]uint8, missCount)
	for i := 0; i < int(missCount); i++ {
		var guid uint64
		if err := binary.Read(reader, binary.LittleEndian, &guid); err != nil {
			return 0, 0, nil, nil, false
		}
		cond, err := reader.ReadByte()
		if err != nil {
			return 0, 0, nil, nil, false
		}
		if cond == spellMissReflect {
			if _, err := reader.ReadByte(); err != nil {
				return 0, 0, nil, nil, false
			}
		}
		misses[guid] = cond
	}
	return caster, spellID, hits, misses, true
}
