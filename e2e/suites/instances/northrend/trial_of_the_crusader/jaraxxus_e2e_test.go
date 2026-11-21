//go:build e2e

package trial_of_the_crusader_test

import (
	"encoding/binary"
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	npcJaraxxus = uint32(34780)

	spellNetherPower = uint32(66228)
	spellSpellsteal  = uint32(30449)

	opSpellStealLog = uint16(0x0333) // SMSG_SPELLSTEALLOG, no harness constant
)

// spellStealLog reads victim, caster, steal spell and the stolen spell ids from a 3.3.5
// SMSG_SPELLSTEALLOG: packed victim and caster guids, steal spell id, an unused byte, the entry
// count, then per stolen aura its spell id and a steal/transfer flag byte (0 = steal).
func spellStealLog(data []byte) (victim, caster uint64, spell uint32, stolen []uint32, ok bool) {
	victim, off := readPackedGUID(data, 0)
	caster, off = readPackedGUID(data, off)
	if off+9 > len(data) {
		return 0, 0, 0, nil, false
	}
	spell = binary.LittleEndian.Uint32(data[off:])
	count := int(binary.LittleEndian.Uint32(data[off+5:]))
	off += 9
	if off+5*count > len(data) {
		return 0, 0, 0, nil, false
	}
	for i := 0; i < count; i++ {
		stolen = append(stolen, binary.LittleEndian.Uint32(data[off+5*i:]))
	}
	return victim, caster, spell, stolen, true
}

// waitUnitStacks waits until guid carries want stacks of spellID and returns the last count seen.
func waitUnitStacks(bot *e2eharness.ScenarioBot, guid uint64, spellID uint32, want int, timeout time.Duration) int {
	got := bot.UnitAuraStacks(guid, spellID)
	for deadline := time.Now().Add(timeout); got != want && time.Now().Before(deadline); time.Sleep(50 * time.Millisecond) {
		got = bot.UnitAuraStacks(guid, spellID)
	}
	return got
}

// A mage's Spellsteal on Lord Jaraxxus takes his Nether Power through the core steal effect: the
// server logs the steal with SMSG_SPELLSTEALLOG, one stack leaves him per cast and the buff lands on
// the mage. The buff used to carry a forced SPELL_ATTR4_CANNOT_BE_STOLEN that made the core skip it,
// with the boss script moving a stack by hand instead, which sent no steal log.
//
// Drive: a temp Jaraxxus in the arena, made attackable with `.modify faction` since the harness
// cannot run his intro, casts Nether Power on himself through `.cast self`, which his script raises
// to the 10 player stack count; a level 80 mage then casts Spellsteal on him twice. A level 83 boss
// resists about one Spellsteal in six from a mage without hit rating, so a cast whose SMSG_SPELL_GO
// does not list him as hit is cast again, up to five times.
// Oracle: each landed Spellsteal sends a steal log naming Jaraxxus, the mage and Nether Power, his
// stacks drop by exactly one (5 -> 4 -> 3), and the mage holds Nether Power.
func TestToC_JaraxxusNetherPowerSpellsteal(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "instances"},
		Runtime:  "short",
		Category: "instances/northrend/trial_of_the_crusader",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "JaxNPow", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassMage, Level: 80, LearnAllClass: true,
	})

	// Stay GM through the raid enter (.go xyz onto a raid map is ignored after .gm off).
	bot.Teleport(t, centerX, centerY, centerZ, mapTrialOfTheCrusader)
	if _, _, _, m := bot.Pos(); m != mapTrialOfTheCrusader {
		e2eharness.Preconditionf(t, "bot not in Trial of the Crusader after tele map=%d", m)
	}

	boss := spawnTemp(t, bot, npcJaraxxus)
	t.Logf("Jaraxxus guid=0x%X", boss)

	if err := bot.World.SetTarget(boss); err != nil {
		e2eharness.HarnessFailf(t, "select Jaraxxus: %v", err)
	}
	// He spawns NON_ATTACKABLE until his intro ends; clear it so Spellsteal can target him.
	bot.GM(t, ".modify faction 14 0")
	bot.GM(t, fmt.Sprintf(".cast self %d", spellNetherPower))
	if got := waitUnitStacks(bot, boss, spellNetherPower, 5, 5*time.Second); got != 5 {
		e2eharness.Preconditionf(t, "Jaraxxus has %d stacks of Nether Power after .cast self, want 5", got)
	}

	mage := bot.World.CharGUID()
	gos := make(chan bool, 16)    // one per Spellsteal SMSG_SPELL_GO: did it hit Jaraxxus
	steals := make(chan bool, 16) // one per steal log from the mage on Jaraxxus: did it take Nether Power
	unhook := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		switch opcode {
		case client.SmsgSpellGo:
			caster, spell, hits, ok := spellGoHits(data)
			if !ok || caster != mage || spell != spellSpellsteal {
				return
			}
			hit := false
			for _, g := range hits {
				hit = hit || g == boss
			}
			select {
			case gos <- hit:
			default:
			}
		case opSpellStealLog:
			victim, caster, spell, stolen, ok := spellStealLog(data)
			if !ok || victim != boss || caster != mage || spell != spellSpellsteal {
				return
			}
			took := false
			for _, s := range stolen {
				took = took || s == spellNetherPower
			}
			select {
			case steals <- took:
			default:
			}
		}
	})
	t.Cleanup(unhook)

	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true, Power: true})
	// Spellsteal is on the global cooldown.
	bot.GM(t, ".cheat cooldown on")
	e2eharness.FlushWorld(t, bot.World)
	bot.Face(t, boss)

	for i, want := range []int{4, 3} {
		landed := false
		for attempt := 1; attempt <= 5 && !landed; attempt++ {
			res := bot.Cast(t, spellSpellsteal, boss, 5*time.Second)
			if !res.Success {
				e2eharness.Assertf(t, "Spellsteal %d on Jaraxxus failed: %s", i+1, e2eharness.SpellFailReasonName(res.FailReason))
			}
			select {
			case landed = <-gos:
			case <-time.After(3 * time.Second):
				e2eharness.HarnessFailf(t, "no SMSG_SPELL_GO for Spellsteal %d", i+1)
			}
			if !landed {
				t.Logf("Spellsteal %d attempt %d missed Jaraxxus, casting again", i+1, attempt)
			}
		}
		if !landed {
			e2eharness.Preconditionf(t, "Spellsteal %d missed Jaraxxus five times in a row", i+1)
		}

		select {
		case took := <-steals:
			if !took {
				e2eharness.Assertf(t, "steal log for Spellsteal %d does not list Nether Power", i+1)
			}
		case <-time.After(3 * time.Second):
			e2eharness.Assertf(t, "Spellsteal %d hit Jaraxxus but the core sent no steal log", i+1)
		}

		if got := waitUnitStacks(bot, boss, spellNetherPower, want, 3*time.Second); got != want {
			e2eharness.Assertf(t, "after Spellsteal %d Jaraxxus has %d stacks of Nether Power, want %d", i+1, got, want)
		}
		for deadline := time.Now().Add(3 * time.Second); !bot.HasAura(spellNetherPower) && time.Now().Before(deadline); {
			time.Sleep(50 * time.Millisecond)
		}
		if !bot.HasAura(spellNetherPower) {
			e2eharness.Assertf(t, "mage has no Nether Power after Spellsteal %d", i+1)
		}
		t.Logf("Spellsteal %d: steal logged, Jaraxxus %d stacks, mage %d stacks", i+1, want, bot.AuraStacks(spellNetherPower))
	}

	t.Logf("PASS each Spellsteal is logged by the core, takes one Nether Power stack and leaves the buff on the mage")
}
