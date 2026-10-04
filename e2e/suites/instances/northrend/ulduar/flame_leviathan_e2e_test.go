//go:build e2e

package ulduar_test

import (
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

// Flame Leviathan's Flame Vents (62396) is a 10s self-channel that no interrupt could stop. His
// creature immunity set carried the INTERRUPT mechanic, which TC's set for him does not, and the
// channel has no interrupt flags in the client data while the core's interrupt effect requires
// them. The boss script hid both behind a special case that force-cancelled the channel when the
// Siege Engine's Electroshock hit, so vehicle drivers worked and Kick or Counterspell never did.
// Reported as https://github.com/chromiecraft/chromiecraft/issues/10194
//
// Drive: the encounter state is set to SPECIAL so a temp Flame Leviathan spawns attackable at his
// home position, `.cast self` starts Flame Vents on him and a rogue Kicks it.
// Oracle: UNIT_CHANNEL_SPELL on the boss drops to 0 right after a Kick that SMSG_SPELL_GO lists as
// a hit. A control channel left alone must still be running several seconds in, so a boss whose
// channel dies on its own cannot pass. Kick can be dodged or parried, which SMSG_SPELL_GO reports
// in its miss list; those restart the channel for the next try, while an IMMUNE miss fails at once.
func TestUlduar_FlameVentsInterruptedByKick(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances"},
		Runtime:  "med",
		Category: "instances/northrend/ulduar",
	})

	const (
		npcFlameLeviathan = uint32(33113)
		spellFlameVents   = uint32(62396)
		spellKick         = uint32(1766)

		// ulduar.h BOSS_LEVIATHAN and InstanceScript.h SPECIAL. The boss script only drops
		// UNIT_FLAG_NON_ATTACKABLE and parks him at his home position in that state.
		encounterLeviathan = 0
		stateSpecial       = 4

		// 10y west of the boss home position (322.39, -14.5, 409.8), inside his 15y combat reach
		// and in front of him (he faces west).
		padX, padY, padZ = float32(312.0), float32(-14.5), float32(409.8)
		// Same arena floor, 80y west of him: outside his aggro range for the relog below.
		farX = float32(240.0)

		channelWindow = 4 * time.Second
		// A channel left alone must survive this long; the interrupt is judged well inside it.
		controlWindow  = 4 * time.Second
		interruptGrace = 1500 * time.Millisecond
		sampleEvery    = 20 * time.Millisecond
		kickAttempts   = 6
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "FLVent", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassRogue, Level: 80, LearnAllClass: true,
	})

	// Stay GM through the raid enter (.go xyz onto 603 is ignored after .gm off).
	bot.Teleport(t, padX, padY, padZ, e2eharness.MapUlduar)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "not in Ulduar after tele map=%d", m)
	}

	bot.GM(t, fmt.Sprintf(".instance setbossstate %d %d", encounterLeviathan, stateSpecial))
	bot.FlushWorld(t)

	// The real Flame Leviathan spawn sits 100y east of here, so pick the summon by novelty.
	known := map[uint64]struct{}{}
	for _, u := range bot.UnitsByEntry(0, npcFlameLeviathan) {
		known[u.GUID] = struct{}{}
	}
	e2eharness.SpawnNPC(t, bot.World, npcFlameLeviathan)
	// The summon relocates to his home position with a spline still active, and the harness drops
	// a vehicle create that carries one. Logging back in gets a clean create of the idle boss.
	// The login happens out of his aggro range: he is attackable now, GM mode is not restored
	// on login here, and a `.modify hp` does not survive a relog either.
	bot.Teleport(t, farX, padY, padZ, e2eharness.MapUlduar)
	bot.Relog(t)
	bot.GM(t, ".gm on")
	// Spawning the boss on top of the bot leaves the character dead by the time it logs back in
	// (CORPSE_RECLAIM_DELAY on login); bring it back before the fight.
	bot.GM(t, ".revive")
	bot.FlushWorld(t)
	for deadline := time.Now().Add(5 * time.Second); ; {
		if hp, _ := bot.UnitHP(bot.World.CharGUID()); hp > 0 {
			break
		}
		if time.Now().After(deadline) {
			e2eharness.Preconditionf(t, "bot still dead after .revive (UNIT_FIELD_HEALTH=0)")
		}
		time.Sleep(100 * time.Millisecond)
	}
	fresh := bot.WaitNewUnits(t, known, []uint32{npcFlameLeviathan}, 30*time.Second)
	if len(fresh) == 0 {
		e2eharness.Preconditionf(t, "no new Flame Leviathan after .npc add temp")
	}
	boss := fresh[0].GUID
	t.Logf("Flame Leviathan guid=0x%X", boss)
	t.Cleanup(func() {
		if err := bot.World.SetTarget(boss); err == nil {
			bot.GM(t, ".npc delete")
		}
	})

	// God on before the pad teleport: teleporting onto the boss floor otherwise kills the bot,
	// and it then fights from inside Flame Vents' 50y damage AoE. .cheat god makes DealDamage
	// skip it and survives `.gm off`, which leaves it able to cast Kick.
	bot.GM(t, ".cheat god on")
	// A fresh level-80 character still carries its starting weapon skills, and an unarmed bot
	// misses a level-83 boss with Kick most of the time.
	bot.GM(t, ".maxskill")
	bot.Teleport(t, padX, padY, padZ, e2eharness.MapUlduar)

	// Only now drop GM: a game master cannot Kick anything.
	bot.GM(t, ".gm off")
	bot.GM(t, ".combatstop")
	bot.FlushWorld(t)
	if err := bot.World.SetTarget(bot.World.CharGUID()); err != nil {
		e2eharness.Preconditionf(t, "select self: %v", err)
	}

	channel := func() uint32 { return bot.World.UnitChannelSpell(boss) }
	waitChannel := func(want uint32, timeout time.Duration) bool {
		deadline := time.Now().Add(timeout)
		for time.Now().Before(deadline) {
			if channel() == want {
				return true
			}
			time.Sleep(sampleEvery)
		}
		return false
	}
	// `.cast self` makes the *selected* unit cast on itself; the boss channels Flame Vents.
	startVents := func(what string) {
		t.Helper()
		if !waitChannel(0, 12*time.Second) {
			e2eharness.Preconditionf(t, "previous channel %d still running before the %s channel", channel(), what)
		}
		if err := bot.World.SetTarget(boss); err != nil {
			e2eharness.Preconditionf(t, "select boss: %v", err)
		}
		bot.GM(t, fmt.Sprintf(".cast self %d", spellFlameVents))
		if !waitChannel(spellFlameVents, channelWindow) {
			e2eharness.Preconditionf(t, "Flame Leviathan never channeled Flame Vents within %s (%s channel, UNIT_CHANNEL_SPELL=%d)",
				channelWindow, what, channel())
		}
	}

	// Control: a channel nobody touches must still be running when the interrupt would be judged.
	startVents("control")
	time.Sleep(controlWindow)
	if cur := channel(); cur != spellFlameVents {
		e2eharness.Preconditionf(t, "Flame Vents ended on its own inside %s (UNIT_CHANNEL_SPELL=%d); the interrupt oracle would be vacuous",
			controlWindow, cur)
	}
	t.Logf("control: Flame Vents still channeling after %s", controlWindow)

	// The Kick's SMSG_SPELL_GO says whether it landed. A dodged or parried Kick leaves the channel
	// running for a reason that has nothing to do with interrupts.
	var (
		mu       sync.Mutex
		kickSeen bool
		kickHit  bool
		kickMiss uint8
	)
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgSpellGo {
			return
		}
		id, hits, misses, ok := spellGoTargets(data)
		if !ok || id != spellKick {
			return
		}
		mu.Lock()
		defer mu.Unlock()
		kickSeen = true
		kickHit = false
		for _, g := range hits {
			if g == boss {
				kickHit = true
			}
		}
		kickMiss = misses[boss]
	})
	defer cancel()
	kickResult := func(timeout time.Duration) (seen, hit bool, miss uint8) {
		deadline := time.Now().Add(timeout)
		for time.Now().Before(deadline) {
			mu.Lock()
			seen, hit, miss = kickSeen, kickHit, kickMiss
			mu.Unlock()
			if seen {
				return
			}
			time.Sleep(sampleEvery)
		}
		return
	}

	interrupted := false
	for attempt := 1; attempt <= kickAttempts && !interrupted; attempt++ {
		startVents(fmt.Sprintf("attempt %d", attempt))
		mu.Lock()
		kickSeen, kickHit, kickMiss = false, false, 0
		mu.Unlock()

		var lastFail string
		kicked := false
		// Kick has a 10s cooldown that a dodged try on the previous channel may still be running.
		for deadline := time.Now().Add(3 * time.Second); time.Now().Before(deadline); {
			bot.Face(t, boss)
			res, err := bot.TryCast(t, spellKick, boss, 500*time.Millisecond)
			if err != nil {
				lastFail = err.Error()
			} else if res.Success {
				kicked = true
				break
			} else {
				lastFail = e2eharness.SpellFailReasonName(res.FailReason)
				time.Sleep(200 * time.Millisecond)
			}
		}
		if !kicked {
			t.Logf("attempt %d: Kick never went out (%s, casterFlags=0x%X)", attempt, lastFail, casterFlags(bot))
			continue
		}
		seen, hit, miss := kickResult(time.Second)
		if !seen {
			e2eharness.HarnessFailf(t, "attempt %d: Kick succeeded but no SMSG_SPELL_GO for it arrived", attempt)
		}
		if !hit {
			if miss == 7 || miss == 8 {
				e2eharness.Assertf(t, "Flame Leviathan is immune to Kick (%s); his immunities must not include the INTERRUPT mechanic",
					spellMissName(miss))
			}
			t.Logf("attempt %d: Kick did not land on the boss (%s)", attempt, spellMissName(miss))
			continue
		}
		if waitChannel(0, interruptGrace) {
			interrupted = true
			break
		}
		e2eharness.Assertf(t, "Kick landed on Flame Leviathan (SMSG_SPELL_GO hit) but Flame Vents kept channeling %s later (UNIT_CHANNEL_SPELL=%d)",
			interruptGrace, channel())
	}
	if !interrupted {
		e2eharness.Preconditionf(t, "no Kick landed on Flame Leviathan in %d attempts", kickAttempts)
	}
	t.Logf("PASS Kick interrupted Flame Leviathan's Flame Vents channel")
}

var spellMissNames = map[uint8]string{
	1: "MISS", 2: "RESIST", 3: "DODGE", 4: "PARRY", 5: "BLOCK", 6: "EVADE",
	7: "IMMUNE", 8: "IMMUNE2", 9: "DEFLECT", 10: "ABSORB", 11: "REFLECT",
}

func spellMissName(miss uint8) string {
	if name, ok := spellMissNames[miss]; ok {
		return name
	}
	return fmt.Sprintf("miss=%d", miss)
}

// spellGoTargets reads an SMSG_SPELL_GO: two packed GUIDs, cast count, spell id, cast flags,
// timestamp, then the hit GUID list and the miss list of GUID plus miss condition (a reflected
// miss carries one more byte). The harness parses SPELL_GO for its own waiters but exposes
// neither the target lists nor a packed-GUID reader.
func spellGoTargets(data []byte) (spellID uint32, hits []uint64, misses map[uint64]uint8, ok bool) {
	off := 0
	for i := 0; i < 2; i++ {
		if off >= len(data) {
			return 0, nil, nil, false
		}
		mask := data[off]
		off++
		for bit := 0; bit < 8; bit++ {
			if mask&(1<<uint(bit)) != 0 {
				off++
			}
		}
	}
	off++ // cast count
	if off+13 > len(data) {
		return 0, nil, nil, false
	}
	spellID = binary.LittleEndian.Uint32(data[off:])
	off += 4 + 4 + 4 // spell id, cast flags, timestamp
	hitCount := int(data[off])
	off++
	if off+8*hitCount > len(data) {
		return 0, nil, nil, false
	}
	for i := 0; i < hitCount; i++ {
		hits = append(hits, binary.LittleEndian.Uint64(data[off:]))
		off += 8
	}
	if off >= len(data) {
		return 0, nil, nil, false
	}
	missCount := int(data[off])
	off++
	misses = make(map[uint64]uint8, missCount)
	for i := 0; i < missCount; i++ {
		if off+9 > len(data) {
			return 0, nil, nil, false
		}
		guid := binary.LittleEndian.Uint64(data[off:])
		cond := data[off+8]
		off += 9
		if cond == 11 { // SPELL_MISS_REFLECT carries the reflect result
			off++
		}
		misses[guid] = cond
	}
	return spellID, hits, misses, true
}
