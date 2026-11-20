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

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	npcConcentratedDark   = uint32(34628)
	npcConcentratedLight  = uint32(34630)
	npcBulletStalkerLight = uint32(34720)

	spellLightOrbSummon = uint32(66150)
	spellDarkOrbSummon  = uint32(66151)

	// UNIT_FIELD_FLAGS (OBJECT_END + 0x35)
	unitFieldFlags = uint16(0x3B)
)

// One of the Light Bullet Stalkers on the north edge of the arena.
var lightStalkerPos = [3]float32{563.5851, 79.60764, 395.2964}

// Unleashed Light and Unleashed Dark on every difficulty.
var unleashedSpells = map[uint32]bool{
	65795: true, 67238: true, 67239: true, 67240: true,
	65808: true, 67172: true, 67173: true, 67174: true,
}

// spellGoHits reads the caster guid, spell id and hit guids from a 3.3.5 SMSG_SPELL_GO: cast-item and
// caster packed guids, cast count, spell id, cast flags, timestamp, then the full hit guids.
func spellGoHits(data []byte) (caster uint64, spell uint32, hits []uint64, ok bool) {
	_, off := readPackedGUID(data, 0)
	caster, off = readPackedGUID(data, off)
	off++ // cast count
	if off+13 > len(data) {
		return 0, 0, nil, false
	}
	spell = binary.LittleEndian.Uint32(data[off:])
	off += 12 // spell id, cast flags, timestamp
	count := int(data[off])
	off++
	if off+8*count > len(data) {
		return 0, 0, nil, false
	}
	for i := 0; i < count; i++ {
		hits = append(hits, binary.LittleEndian.Uint64(data[off+8*i:]))
	}
	return caster, spell, hits, true
}

// A Bullet Stalker summons Concentrated Light or Darkness with the controller's summon spells. The
// orb's passive pulses a 3 yard dummy every 500ms, and on a player it casts Unleashed Light or
// Unleashed Dark, whose second effect kills the orb through Quiet Suicide. Unleashed is player-only
// (SPELL_ATTR3_ONLY_ON_PLAYER), which keeps the twins safe from orbs of the hostile faction 2189.
//
// Drive: the bot stands on a Light Bullet Stalker with temp twins summoned on top of it, attackable as
// they are once the intro ends (UNIT_FIELD_FLAGS cleared). The stalker casts 66150 then 66151.
// Oracle: each summon is followed by an Unleashed SMSG_SPELL_GO from the new orb that lists the bot
// and neither twin, and the orb dies right after.
func TestToC_TwinValkyrOrbsExplodeOnPlayers(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances"},
		Runtime:  "med",
		Category: "instances/northrend/trial_of_the_crusader",
	})

	const (
		summonWindow  = 3 * time.Second
		explodeWindow = 5 * time.Second
		// Quiet Suicide lands in the same cast as Unleashed; allow for the death update to arrive.
		deathWindow = 2 * time.Second
		// Unleashed's radius is 6 yards; the twins must stand well inside it for the oracle to judge.
		twinReach = float32(4)
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "VlkOrb", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})

	// Stay GM through the raid enter (.go xyz onto a raid map is ignored after .gm off).
	bot.Teleport(t, lightStalkerPos[0], lightStalkerPos[1], lightStalkerPos[2], mapTrialOfTheCrusader)
	if _, _, _, m := bot.Pos(); m != mapTrialOfTheCrusader {
		e2eharness.Preconditionf(t, "bot not in Trial of the Crusader after tele map=%d", m)
	}

	var stalker uint64
	for deadline := time.Now().Add(20 * time.Second); stalker == 0 && time.Now().Before(deadline); time.Sleep(sampleEvery) {
		stalker = bot.FindUnit(npcBulletStalkerLight, 1.5)
	}
	if stalker == 0 {
		e2eharness.Preconditionf(t, "no Light Bullet Stalker (%d) under the bot; are the stalker spawns applied?", npcBulletStalkerLight)
	}

	fjola := spawnTwin(t, bot, npcFjola)
	eydis := spawnTwin(t, bot, npcEydis)
	twins := map[uint64]string{fjola: "Fjola", eydis: "Eydis"}
	for guid, name := range twins {
		if err := bot.World.SetTarget(guid); err != nil {
			e2eharness.HarnessFailf(t, "SetTarget %s: %v", name, err)
		}
		bot.GM(t, fmt.Sprintf(".debug setvalue %d 0", unitFieldFlags))
		var flags uint32 = math.MaxUint32
		for deadline := time.Now().Add(5 * time.Second); flags != 0 && time.Now().Before(deadline); time.Sleep(sampleEvery) {
			if o := bot.World.GetObject(guid); o != nil {
				flags = o.Value(unitFieldFlags)
			}
		}
		if flags != 0 {
			e2eharness.Preconditionf(t, "%s 0x%X still has unit flags 0x%X; it must be attackable like after the intro", name, guid, flags)
		}
		o := bot.World.GetObject(guid)
		if o == nil {
			e2eharness.Preconditionf(t, "%s 0x%X left the object cache", name, guid)
		}
		dx, dy := o.PosX-lightStalkerPos[0], o.PosY-lightStalkerPos[1]
		if d := float32(math.Sqrt(float64(dx*dx + dy*dy))); d > twinReach {
			e2eharness.Preconditionf(t, "%s stands %.1f yards from the stalker, outside the %.0f the oracle needs", name, d, twinReach)
		}
	}
	t.Logf("Fjola 0x%X and Eydis 0x%X stand attackable on Light Bullet Stalker 0x%X", fjola, eydis, stalker)

	type explosion struct {
		orb   uint64
		spell uint32
		hits  []uint64
	}
	var mu sync.Mutex
	summoned := map[uint32]bool{}
	explosions := map[uint32]explosion{}
	unhook := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != 0x0132 { // SMSG_SPELL_GO
			return
		}
		caster, spell, hits, ok := spellGoHits(data)
		if !ok {
			return
		}
		mu.Lock()
		defer mu.Unlock()
		if caster == stalker && (spell == spellLightOrbSummon || spell == spellDarkOrbSummon) {
			summoned[spell] = true
			return
		}
		entry := guidEntry(caster)
		if !unleashedSpells[spell] || (entry != npcConcentratedLight && entry != npcConcentratedDark) {
			return
		}
		if _, seen := explosions[entry]; !seen {
			explosions[entry] = explosion{caster, spell, hits}
		}
	})
	t.Cleanup(unhook)

	// Out of GM mode so the orbs' passive sees the bot; god keeps it up through the explosions.
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true})

	for _, c := range []struct {
		name   string
		summon uint32
		orb    uint32
	}{
		{"Concentrated Light", spellLightOrbSummon, npcConcentratedLight},
		{"Concentrated Darkness", spellDarkOrbSummon, npcConcentratedDark},
	} {
		if err := bot.World.SetTarget(stalker); err != nil {
			e2eharness.HarnessFailf(t, "SetTarget stalker: %v", err)
		}
		bot.GM(t, fmt.Sprintf(".cast self %d", c.summon))

		var cast bool
		for deadline := time.Now().Add(summonWindow); !cast && time.Now().Before(deadline); time.Sleep(50 * time.Millisecond) {
			mu.Lock()
			cast = summoned[c.summon]
			mu.Unlock()
		}
		if !cast {
			e2eharness.Preconditionf(t, "the stalker did not cast %d (%s summon) within %s", c.summon, c.name, summonWindow)
		}

		var got explosion
		var seen bool
		for deadline := time.Now().Add(explodeWindow); !seen && time.Now().Before(deadline); time.Sleep(50 * time.Millisecond) {
			mu.Lock()
			got, seen = explosions[c.orb]
			mu.Unlock()
		}
		if !seen {
			e2eharness.Assertf(t, "%s summoned by the stalker (%d) cast no Unleashed on the bot standing on it within %s", c.name, c.summon, explodeWindow)
		}

		hitBot := false
		for _, g := range got.hits {
			if g == bot.GUID {
				hitBot = true
			}
			if name, twin := twins[g]; twin {
				e2eharness.Assertf(t, "%s's Unleashed (%d) hit %s 0x%X; it must hit players only", c.name, got.spell, name, g)
			}
		}
		if !hitBot {
			e2eharness.Assertf(t, "%s's Unleashed (%d) did not hit the bot it exploded on; hits %x", c.name, got.spell, got.hits)
		}

		dead := false
		for deadline := time.Now().Add(deathWindow); !dead && time.Now().Before(deadline); time.Sleep(50 * time.Millisecond) {
			hp, _ := bot.UnitHP(got.orb)
			dead = hp == 0
		}
		if !dead {
			e2eharness.Assertf(t, "%s 0x%X is still alive %s after its Unleashed (%d)", c.name, got.orb, deathWindow, got.spell)
		}
		t.Logf("%s 0x%X cast Unleashed (%d) on the bot, no twin among its %d hit(s), and died", c.name, got.orb, got.spell, len(got.hits))
	}

	t.Logf("PASS stalker-summoned Concentrated Light and Darkness explode on the bot, spare both twins in reach, and die")
}
