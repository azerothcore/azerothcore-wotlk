//go:build e2e

package channel_test

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

type acidSpell struct {
	parent, damage uint32
	issue          int
	period         time.Duration
	tauntRedirect  bool
}

// These are deterministic spell regressions, not tests of boss timers or random
// target selection. A cleanup-owned boar supplies a native threat AI with no spells.
// Only the parent channel is forced; its aura, periodic casts and cone selection
// all run normally. No creature templates or spell data are changed by the tests.
// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/19917
func TestAC_19917_AcidSprayChannel(t *testing.T) {
	runAcidChannel(t, acidSpell{38153, 38163, 19917, 800 * time.Millisecond, true})
}

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/19921
// 38971 is shared by Underbog Colossus and Coprous. Their different AI target
// selectors are outside this fixture; neither should inherit 38153's taunt opt-in.
func TestAC_19921_AcidGeyserChannel(t *testing.T) {
	runAcidChannel(t, acidSpell{38971, 38973, 19921, time.Second, false})
}

func runAcidChannel(t *testing.T, spell acidSpell) {
	meta.Begin(t, meta.TestMeta{
		Tags:    []string{"med", "spells", "issue", "multi_bot"},
		Runtime: "med", Category: "spells/channel", Issue: spell.issue,
	})
	t.Run("MovingTargetAndNextChannel", func(t *testing.T) {
		f := newAcidFixture(t, spell, false)
		f.start(t, f.aim)
		f.expectDamage(t, f.mark, spell.period+200*time.Millisecond, f.aim.GUID, f.probe.GUID)

		// Walk the chord from east to north at normal run speed. The probe stays
		// east, so a cone frozen in its initial direction cannot pass this test.
		f.moveAimNorth(t)
		mark := f.logs.mark()
		f.expectDamage(t, mark, spell.period+200*time.Millisecond, f.aim.GUID)
		f.waitChannelEnd(t)
		f.expectDamage(t, f.logs.mark(), 2*spell.period)
		f.wait(t, 3*time.Second, "normal threat target restored", func() bool {
			return f.probe.UnitTarget(f.caster) == f.tank.GUID
		})

		// A later channel must capture its own target rather than reuse the old
		// aura's cached GUID. The tank is on the opposite side of the caster.
		f.start(t, f.tank)
		f.expectDamage(t, f.mark, spell.period+200*time.Millisecond, f.tank.GUID)
	})
	t.Run("TauntAndNaturalExpiry", func(t *testing.T) {
		// The east-side probe pulls here. The west-side warrior is not the
		// current threat victim, so its Taunt is not the no-effect case.
		f := newAcidFixture(t, spell, true)
		f.start(t, f.aim)
		f.expectDamage(t, f.mark, spell.period+200*time.Millisecond, f.aim.GUID, f.probe.GUID)
		f.tank.CastMust(t, e2eharness.SpellTaunt, f.caster, 3*time.Second)
		f.tank.WaitUnitAura(t, f.caster, e2eharness.SpellTaunt, time.Second)
		f.prepare(t, time.Second, "observer sees the applied Taunt", func() bool {
			return f.probe.UnitHasAura(f.caster, e2eharness.SpellTaunt)
		})
		f.probe.FlushWorld(t)
		mark := f.logs.mark()
		if spell.tauntRedirect {
			f.expectDamage(t, mark, spell.period+200*time.Millisecond, f.tank.GUID)
		} else {
			f.expectDamage(t, mark, spell.period+200*time.Millisecond, f.aim.GUID, f.probe.GUID)
		}
		if obj := f.probe.World.GetObject(f.caster); obj == nil ||
			obj.GUIDField(client.UnitFieldChannelObject) != f.aim.GUID {
			e2eharness.Assertf(t, "Taunt overwrote the channel's original target GUID")
		}
		f.wait(t, 4*time.Second, "Taunt expires naturally", func() bool {
			return !f.probe.UnitHasAura(f.caster, e2eharness.SpellTaunt)
		})
		// Threat now belongs to the taunter, but the still-running channel must
		// aim at its original target again (or keep it for Acid Geyser).
		f.expectDamage(t, f.logs.mark(), spell.period+200*time.Millisecond, f.aim.GUID, f.probe.GUID)
		f.waitChannelEnd(t)
		f.wait(t, 3*time.Second, "post-channel victim is the taunter", func() bool {
			return f.probe.UnitTarget(f.caster) == f.tank.GUID
		})
	})
	t.Run("DeadTargetStopsDamage", func(t *testing.T) {
		f := newAcidFixture(t, spell, false)
		f.start(t, f.aim)
		f.expectDamage(t, f.mark, spell.period+200*time.Millisecond, f.aim.GUID, f.probe.GUID)
		// No CombatStop/GM toggle: death itself must invalidate the target.
		selectAcidTarget(t, f.aim, f.aim.GUID)
		f.aim.GM(t, ".die")
		f.aim.FlushWorld(t)
		f.prepare(t, 2*time.Second, "observer sees channel target dead", func() bool {
			obj := f.probe.World.GetObject(f.aim.GUID)
			return obj != nil && obj.MaxHealth() > 0 && obj.Health() == 0
		})
		f.probe.FlushWorld(t)
		// The probe is still in the last cone, and the tank remains alive on
		// threat. Neither continued stale ticks nor fallback-to-tank ticks pass.
		f.expectDamage(t, f.logs.mark(), 3*spell.period)
	})
}

type acidFixture struct {
	spell            acidSpell
	tank, aim, probe *e2eharness.ScenarioBot
	caster           uint64
	x, y, z          float32
	logs             *acidDamageLog
	mark             int
}

func newAcidFixture(t *testing.T, spell acidSpell, probePulls bool) *acidFixture {
	t.Helper()
	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "AcidCh", Count: 3, Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80,
	})
	f := &acidFixture{spell: spell, tank: bots[0], aim: bots[1], probe: bots[2], logs: &acidDamageLog{}}
	pad := e2eharness.PackagePad(t)
	e2eharness.TeleportAllPad(t, bots, pad)
	f.x, f.y, f.z = pad.X, pad.Y, pad.Z
	f.caster = f.tank.Spawn(t, 3098, 10*time.Second) // Mottled Boar, no competing AI spells
	selectAcidTarget(t, f.tank, f.caster)
	// Only this cleanup-owned spawn is changed. Equal levels avoid level-based
	// resistance; faction 14 makes all three players valid hostile recipients.
	f.tank.GM(t, ".npc set level 80")
	f.tank.GM(t, ".npc set faction temp 14")
	// 42716 is a permanent root only, not a stun. This prevents chase from
	// changing the cone geometry and covers rotation while rooted as well.
	f.tank.GM(t, ".aura 42716")
	f.tank.WaitUnitAura(t, f.caster, 42716, 5*time.Second)
	f.tank.Teleport(t, pad.X-18, pad.Y, pad.Z, pad.Map)
	f.aim.Teleport(t, pad.X+18, pad.Y, pad.Z, pad.Map)
	f.probe.Teleport(t, pad.X+24, pad.Y, pad.Z, pad.Map)
	for _, bot := range bots {
		selectAcidTarget(t, bot, bot.GUID)
		bot.GM(t, ".modify hp 500000")
		bot.GM(t, ".cheat god off")
		bot.FlushWorld(t)
		f.prepare(t, 3*time.Second, "fixture health applied", func() bool {
			hp, max := bot.UnitHP(bot.GUID)
			return max == 500000 && hp > 0
		})
	}
	f.tank.Learn(t, e2eharness.SpellDefensiveStance)
	f.tank.Learn(t, e2eharness.SpellTaunt)
	f.tank.CastMust(t, e2eharness.SpellDefensiveStance, 0, 5*time.Second)
	for _, bot := range bots {
		e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{})
	}
	f.prepare(t, 5*time.Second, "all clients see the rooted caster", func() bool {
		return f.tank.World.GetObject(f.caster) != nil && f.aim.World.GetObject(f.caster) != nil &&
			f.probe.World.GetObject(f.caster) != nil && f.probe.UnitHasAura(f.caster, 42716)
	})
	puller := f.tank
	if probePulls {
		puller = f.probe
	}
	puller.Damage(t, f.caster, 1000)
	puller.WaitUnitTarget(t, f.caster, puller.GUID, 5*time.Second)
	puller.WaitUnitCombat(t, f.caster, 5*time.Second)
	f.prepare(t, 5*time.Second, "caster idle before controlled channel", func() bool {
		return f.probe.World.UnitChannelSpell(f.caster) == 0
	})
	// The stationary observer receives every nearby damage packet. Filter both
	// caster and damage spell so unrelated combat cannot satisfy checks.
	cancel := f.probe.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != 0x0250 { // SMSG_SPELLNONMELEEDAMAGELOG
			return
		}
		target, caster, id, damage, ok := parseAcidDamage(data)
		if ok && caster == f.caster && id == spell.damage {
			f.logs.mu.Lock()
			f.logs.hits = append(f.logs.hits, acidHit{target, damage})
			f.logs.mu.Unlock()
		}
	})
	t.Cleanup(cancel)
	t.Logf("acid parent=%d damage=%d caster=%X tank=%X target=%X probe=%X",
		spell.parent, spell.damage, f.caster, f.tank.GUID, f.aim.GUID, f.probe.GUID)
	return f
}

func selectAcidTarget(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64) {
	t.Helper()
	if err := bot.World.SetTarget(guid); err != nil {
		e2eharness.HarnessFailf(t, "select acid fixture target: %v", err)
	}
}

func (f *acidFixture) start(t *testing.T, target *e2eharness.ScenarioBot) {
	t.Helper()
	selectAcidTarget(t, target, f.caster)
	f.mark = f.logs.mark()
	// Not triggered: the debug triggered mask skips effects and spell focus.
	target.GM(t, fmt.Sprintf(".cast back %d", f.spell.parent))
	f.prepare(t, 3*time.Second, "parent channel starts on the intended target", func() bool {
		obj := f.probe.World.GetObject(f.caster)
		return obj != nil && obj.Value(client.UnitChannelSpell) == f.spell.parent &&
			obj.GUIDField(client.UnitFieldChannelObject) == target.GUID
	})
}

func (f *acidFixture) waitChannelEnd(t *testing.T) {
	t.Helper()
	f.wait(t, 10*time.Second, "channel and its periodic aura finish", func() bool {
		obj := f.probe.World.GetObject(f.caster)
		return obj != nil && obj.Value(client.UnitChannelSpell) == 0 &&
			!f.probe.UnitHasAura(f.caster, f.spell.parent)
	})
	f.probe.FlushWorld(t)
}

func (f *acidFixture) moveAimNorth(t *testing.T) {
	t.Helper()
	const duration = 4 * time.Second // 25.46 yd at < 7 yd/s
	start := time.Now()
	orientation := float32(3 * math.Pi / 4)
	if err := f.aim.World.MoveForwardAt(f.x+18, f.y, f.z, orientation); err != nil {
		e2eharness.HarnessFailf(t, "start target movement: %v", err)
	}
	ticker := time.NewTicker(50 * time.Millisecond)
	defer ticker.Stop()
	for now := range ticker.C {
		fraction := math.Min(1, float64(now.Sub(start))/float64(duration))
		x, y := f.x+18*(1-float32(fraction)), f.y+18*float32(fraction)
		if err := f.aim.World.SendMovementHeartbeatAt(x, y, f.z, orientation); err != nil {
			e2eharness.HarnessFailf(t, "move channel target: %v", err)
		}
		if fraction == 1 {
			break
		}
	}
	if err := f.aim.World.MoveStopAt(f.x, f.y+18, f.z, orientation); err != nil {
		e2eharness.HarnessFailf(t, "stop channel target: %v", err)
	}
	f.aim.FlushWorld(t)
	f.prepare(t, time.Second, "observer sees the target north of the caster", func() bool {
		obj := f.probe.World.GetObject(f.aim.GUID)
		return obj != nil && e2eharness.Distance3D(obj.PosX, obj.PosY, obj.PosZ, f.x, f.y+18, f.z) < 1
	})
	f.probe.FlushWorld(t)
}

func (f *acidFixture) wait(t *testing.T, timeout time.Duration, what string, ready func() bool) {
	t.Helper()
	if !waitAcidCondition(timeout, ready) {
		e2eharness.Assertf(t, "acid %d: timed out waiting for %s", f.spell.parent, what)
	}
}

func (f *acidFixture) prepare(t *testing.T, timeout time.Duration, what string, ready func() bool) {
	t.Helper()
	if !waitAcidCondition(timeout, ready) {
		e2eharness.Preconditionf(t, "acid %d: timed out waiting for %s", f.spell.parent, what)
	}
}

func waitAcidCondition(timeout time.Duration, ready func() bool) bool {
	deadline := time.NewTimer(timeout)
	defer deadline.Stop()
	ticker := time.NewTicker(25 * time.Millisecond)
	defer ticker.Stop()
	for !ready() {
		select {
		case <-ticker.C:
		case <-deadline.C:
			return false
		}
	}
	return true
}

// Check the whole bounded window, including forbidden recipients. A positive
// check requires real damage, not merely a visual target or an absorbed hit.
// Windows exceed one native periodic interval; both cone spells ALWAYS_HIT.
func (f *acidFixture) expectDamage(t *testing.T, mark int, window time.Duration, want ...uint64) {
	t.Helper()
	allowed := make(map[uint64]bool, len(want))
	for _, guid := range want {
		allowed[guid] = false
	}
	deadline := time.NewTimer(window)
	defer deadline.Stop()
	ticker := time.NewTicker(25 * time.Millisecond)
	defer ticker.Stop()
	check := func() {
		obj := f.probe.World.GetObject(f.caster)
		if obj == nil || obj.MaxHealth() == 0 || obj.Health() == 0 ||
			!f.probe.UnitInCombat(f.caster) || !f.probe.UnitHasAura(f.caster, 42716) ||
			e2eharness.Distance3D(obj.PosX, obj.PosY, obj.PosZ, f.x, f.y, f.z) > 1 {
			e2eharness.Preconditionf(t, "acid fixture died, evaded, lost its root or moved during observation")
		}
		for _, hit := range f.logs.since(mark) {
			if _, ok := allowed[hit.target]; !ok {
				e2eharness.ConfirmedBugf(t, f.spell.issue, "spell %d hit forbidden target %X (damage %d)",
					f.spell.damage, hit.target, hit.damage)
			}
			if hit.damage > 0 {
				allowed[hit.target] = true
			}
		}
	}
	for {
		select {
		case <-ticker.C:
			check()
		case <-deadline.C:
			check()
			for guid, hit := range allowed {
				if !hit {
					e2eharness.ConfirmedBugf(t, f.spell.issue, "spell %d did not damage expected target %X in %s",
						f.spell.damage, guid, window)
				}
			}
			t.Logf("PASS spell=%d recipients=%X window=%s", f.spell.damage, want, window)
			return
		}
	}
}

type acidHit struct {
	target uint64
	damage uint32
}

type acidDamageLog struct {
	mu   sync.Mutex
	hits []acidHit
}

func (l *acidDamageLog) mark() int {
	l.mu.Lock()
	defer l.mu.Unlock()
	return len(l.hits)
}

func (l *acidDamageLog) since(mark int) []acidHit {
	l.mu.Lock()
	defer l.mu.Unlock()
	return append([]acidHit(nil), l.hits[mark:]...)
}

// Unit::SendSpellNonMeleeDamageLog: packed target, packed caster, spell, damage.
func parseAcidDamage(data []byte) (target, caster uint64, spell, damage uint32, ok bool) {
	offset := 0
	readGUID := func() (uint64, bool) {
		if offset >= len(data) {
			return 0, false
		}
		mask := data[offset]
		offset++
		var guid uint64
		for bit := uint(0); bit < 8; bit++ {
			if mask&(1<<bit) == 0 {
				continue
			}
			if offset >= len(data) {
				return 0, false
			}
			guid |= uint64(data[offset]) << (8 * bit)
			offset++
		}
		return guid, true
	}
	if target, ok = readGUID(); !ok {
		return
	}
	if caster, ok = readGUID(); !ok {
		return
	}
	if len(data)-offset < 8 {
		ok = false
		return
	}
	spell = binary.LittleEndian.Uint32(data[offset:])
	damage = binary.LittleEndian.Uint32(data[offset+4:])
	return
}
