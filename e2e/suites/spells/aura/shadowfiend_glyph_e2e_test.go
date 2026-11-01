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

// Found while reviewing https://github.com/azerothcore/azerothcore-wotlk/pull/28299.
//
// Glyph of Shadowfiend (58228): "if your Shadowfiend dies from damage, you gain 5% of your maximum
// mana" (58227). The Shadowfiend (19668) always carries 57989, whose script casts 58227 on the
// glyphed owner each time 57989 procs. Its spell_proc row had ProcFlags 0, so it used the DBC flags
// (every hit taken) and the priest gained 5% mana on every hit the fiend took. The fix makes 57989
// proc on PROC_FLAG_KILLED only.
//
// Drive: a level 80 priest with the glyph sends its Shadowfiend at an Unkillable Test Dummy, which
// fights back with melee swings and, through `.cast target`, 2653 "Damage 100 (TEST)" at its victim
// (the fiend dodges 35% of melee; a spell hit cannot be dodged). Then the priest kills the fiend
// with `.damage`. Then it sends a second fiend at a Heroic Training Dummy, which never swings, and
// lets it expire.
// Oracle: SMSG_SPELL_GO for 58227 from the priest (it has a visual, so it is sent though
// triggered), against the hits the fiend takes (SMSG_ATTACKERSTATEUPDATE and
// SMSG_SPELLNONMELEEDAMAGELOG with the fiend as victim):
//   - HitsTaken: 0 casts while the fiend takes at least fiendMinHits hits and stays alive;
//   - KilledByDamage: exactly 1 cast for the kill;
//   - Expired: 0 casts when the fiend's 15s run out.

const (
	fiendSpellShadowfiend = uint32(34433)
	fiendSpellGlyphAura   = uint32(58228)
	fiendSpellGlyphMana   = uint32(58227)
	fiendNpcShadowfiend   = uint32(19668)
	// "Damage 100 (TEST)": instant, no cost or cooldown, ~100 fire damage to an enemy target.
	fiendSpellTestDamage = uint32(2653)
	// Level 80, neutral, 2000x health, no script: it fights back at whatever attacks it.
	fiendNpcFighter = uint32(32171)
	// Heroic Training Dummy: never swings, so a fiend on it takes no hits.
	fiendNpcIdleTarget = e2eharness.CreatureHeroicTrainingDummy

	fiendOpAttackerStateUpdate = uint16(0x014A)
	fiendOpSpellDamageLog      = uint16(0x0250)
)

// fiendLog counts 58227 casts by the priest and the hits taken by the current Shadowfiend.
type fiendLog struct {
	mu        sync.Mutex
	fiend     uint64
	manaCasts int
	hits      int
}

func (l *fiendLog) setFiend(guid uint64) {
	l.mu.Lock()
	l.fiend = guid
	l.mu.Unlock()
}

func (l *fiendLog) counts() (manaCasts, hits int) {
	l.mu.Lock()
	defer l.mu.Unlock()
	return l.manaCasts, l.hits
}

func (l *fiendLog) hitOn(victim uint64) {
	l.mu.Lock()
	if victim != 0 && victim == l.fiend {
		l.hits++
	}
	l.mu.Unlock()
}

func watchFiend(t *testing.T, priest *e2eharness.ScenarioBot) *fiendLog {
	t.Helper()
	l := &fiendLog{}
	cancel := priest.World.AddPacketHook(func(opcode uint16, data []byte) {
		r := bytes.NewReader(data)
		switch opcode {
		case client.SmsgSpellGo:
			if _, ok := readPackedGUID(r); !ok { // cast item or caster
				return
			}
			caster, ok := readPackedGUID(r)
			var castCount uint8
			var spellID uint32
			if !ok || caster != priest.GUID || binary.Read(r, binary.LittleEndian, &castCount) != nil ||
				binary.Read(r, binary.LittleEndian, &spellID) != nil || spellID != fiendSpellGlyphMana {
				return
			}
			l.mu.Lock()
			l.manaCasts++
			l.mu.Unlock()
		case fiendOpAttackerStateUpdate:
			var hitInfo, damage uint32
			if binary.Read(r, binary.LittleEndian, &hitInfo) != nil {
				return
			}
			_, ok1 := readPackedGUID(r)
			victim, ok2 := readPackedGUID(r)
			if ok1 && ok2 && binary.Read(r, binary.LittleEndian, &damage) == nil && damage > 0 {
				l.hitOn(victim)
			}
		case fiendOpSpellDamageLog:
			victim, ok := readPackedGUID(r)
			if !ok {
				return
			}
			var spellID, damage uint32
			if _, ok := readPackedGUID(r); ok && binary.Read(r, binary.LittleEndian, &spellID) == nil &&
				binary.Read(r, binary.LittleEndian, &damage) == nil && damage > 0 {
				l.hitOn(victim)
			}
		}
	})
	t.Cleanup(cancel)
	return l
}

// summonFiend casts Shadowfiend at target and returns the new fiend's GUID.
func summonFiend(t *testing.T, priest *e2eharness.ScenarioBot, target uint64) uint64 {
	t.Helper()
	known := map[uint64]struct{}{}
	for _, u := range priest.UnitsByEntry(100, fiendNpcShadowfiend) {
		known[u.GUID] = struct{}{}
	}
	priest.Face(t, target)
	priest.CastMust(t, fiendSpellShadowfiend, target, 10*time.Second)
	fiends := priest.WaitNewUnits(t, known, []uint32{fiendNpcShadowfiend}, 10*time.Second)
	if len(fiends) == 0 {
		e2eharness.Preconditionf(t, "no Shadowfiend (%d) appeared after casting %d", fiendNpcShadowfiend,
			fiendSpellShadowfiend)
	}
	// A fiend cast at a neutral target that nobody fights stands idle: send it in.
	if err := priest.World.PetAttackCommand(fiends[0].GUID, target); err != nil {
		e2eharness.HarnessFailf(t, "pet attack command for Shadowfiend 0x%X: %v", fiends[0].GUID, err)
	}
	return fiends[0].GUID
}

// hasLearnedSpell reports whether the bot's saved character_spell rows include spellID.
func hasLearnedSpell(t *testing.T, bot *e2eharness.ScenarioBot, spellID uint32) bool {
	t.Helper()
	charDB, err := e2eharness.OpenCharDB()
	if err != nil {
		e2eharness.Preconditionf(t, "characters DB: %v", err)
	}
	defer charDB.Close()
	var n int
	if err := charDB.QueryRow("SELECT COUNT(*) FROM character_spell WHERE guid = ? AND spell = ?",
		uint32(bot.GUID), spellID).Scan(&n); err != nil {
		e2eharness.Preconditionf(t, "character_spell query: %v", err)
	}
	return n > 0
}

func TestAura_GlyphOfShadowfiendOnlyOnDeath(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "aura", "pet", "proc"},
		Runtime:  "med",
		Category: "spells/aura",
	})

	const (
		fiendMinHits = 5
		// The fiend lasts 15s; stop counting hits before the fighter can kill it.
		hitsWindow   = 12 * time.Second
		castEvery    = 300 * time.Millisecond
		minFiendHP   = 0.2
		settle       = 1500 * time.Millisecond
		expiryWindow = 25 * time.Second
	)

	// Subtests close the harness's cached world DB after the first one; spawns need their own.
	db, err := e2eharness.OpenWorldDB()
	if err != nil {
		e2eharness.Preconditionf(t, "world DB: %v", err)
	}
	t.Cleanup(func() { _ = db.Close() })

	priest := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Fiend",
		Race:   e2eharness.RaceHuman,
		Class:  e2eharness.ClassPriest,
		Level:  80,
	})
	priest.WorldDB = db
	priest.TeleportPad(t, e2eharness.PackagePad(t))
	priest.Learn(t, fiendSpellShadowfiend)
	// The glyph aura is passive and hidden, so the client never sees it: learn it, save, and check the
	// character's spells. KilledByDamage then shows it working (one 58227 for the kill).
	priest.Learn(t, fiendSpellGlyphAura)
	priest.Save(t)
	if !hasLearnedSpell(t, priest, fiendSpellGlyphAura) {
		e2eharness.Preconditionf(t, "priest 0x%X did not learn Glyph of Shadowfiend (%d)", priest.GUID,
			fiendSpellGlyphAura)
	}
	log := watchFiend(t, priest)

	// Spawn puts the spawner in GM mode, so every fixture is spawned before anything engages.
	fighter := priest.Spawn(t, fiendNpcFighter, 15*time.Second)
	idle := priest.Spawn(t, fiendNpcIdleTarget, 15*time.Second)
	priest.CombatReadyFull(t)
	priest.GM(t, ".cheat cooldown on")

	var fiend uint64
	t.Run("HitsTaken", func(t *testing.T) {
		// Only the fiend attacks, so it is the only unit with threat on the fighter.
		fiend = summonFiend(t, priest, fighter)
		log.setFiend(fiend)
		casts0, hits0 := log.counts()
		for wait := time.Now().Add(5 * time.Second); time.Now().Before(wait); time.Sleep(50 * time.Millisecond) {
			if e2eharness.UnitTargetGUID(priest.World, fighter) == fiend {
				break
			}
		}
		if got := e2eharness.UnitTargetGUID(priest.World, fighter); got != fiend {
			e2eharness.Preconditionf(t, "the fighter 0x%X targets 0x%X, not Shadowfiend 0x%X", fighter, got, fiend)
		}
		// Its swings land only about every 2.5s past the fiend's 35% dodge, so the fighter also casts a
		// costless instant 100-damage spell at its victim: a non-triggered spell hit taken, same proc path.
		_ = priest.World.SetTarget(fighter)
		nextCast := time.Now()
		for deadline := time.Now().Add(hitsWindow); time.Now().Before(deadline); time.Sleep(50 * time.Millisecond) {
			_, hits := log.counts()
			hp, max := priest.UnitHP(fiend)
			if hits-hits0 >= fiendMinHits || (max > 0 && float64(hp) < minFiendHP*float64(max)) {
				break
			}
			if time.Now().After(nextCast) {
				priest.GM(t, fmt.Sprintf(".cast target %d", fiendSpellTestDamage))
				nextCast = time.Now().Add(castEvery)
			}
		}
		casts, hits := log.counts()
		casts, hits = casts-casts0, hits-hits0
		if hp, _ := priest.UnitHP(fiend); hp == 0 || priest.World.GetObject(fiend) == nil {
			e2eharness.Preconditionf(t, "the fighter killed Shadowfiend 0x%X after %d hits, before the window ended",
				fiend, hits)
		}
		if hits < fiendMinHits {
			e2eharness.Preconditionf(t, "Shadowfiend 0x%X took only %d hits in %s", fiend, hits, hitsWindow)
		}
		hp, max := priest.UnitHP(fiend)
		t.Logf("Shadowfiend 0x%X took %d hits (now %d/%d hp): %d Glyph of Shadowfiend mana casts", fiend, hits, hp,
			max, casts)
		if casts != 0 {
			e2eharness.Assertf(t, "Glyph of Shadowfiend (%d) fired %d times while the living fiend took %d hits",
				fiendSpellGlyphMana, casts, hits)
		}
		t.Logf("PASS no mana from hits the fiend survives")
	})

	t.Run("KilledByDamage", func(t *testing.T) {
		if fiend == 0 || priest.World.GetObject(fiend) == nil {
			e2eharness.Preconditionf(t, "no living Shadowfiend left from HitsTaken")
		}
		casts0, _ := log.counts()
		priest.Damage(t, fiend, 10_000_000)
		for deadline := time.Now().Add(5 * time.Second); time.Now().Before(deadline); {
			if hp, _ := priest.UnitHP(fiend); hp == 0 || priest.World.GetObject(fiend) == nil {
				break
			}
			time.Sleep(50 * time.Millisecond)
		}
		if hp, _ := priest.UnitHP(fiend); hp != 0 && priest.World.GetObject(fiend) != nil {
			e2eharness.Preconditionf(t, "Shadowfiend 0x%X still alive (%d hp) after .damage", fiend, hp)
		}
		time.Sleep(settle)
		casts, _ := log.counts()
		casts -= casts0
		t.Logf("Shadowfiend 0x%X killed by .damage: %d Glyph of Shadowfiend mana casts", fiend, casts)
		if casts != 1 {
			e2eharness.Assertf(t, "Glyph of Shadowfiend (%d) fired %d times for the fiend's death, want 1",
				fiendSpellGlyphMana, casts)
		}
		t.Logf("PASS one mana cast for the fiend killed by damage")
	})

	t.Run("Expired", func(t *testing.T) {
		// Nothing but the idle dummy may be near the fiend: the fighter would hit it.
		priest.DespawnNearbyEntry(t, fiendNpcFighter, 100)
		priest.CombatStop(t)
		priest.CombatReadyFull(t)
		if priest.World.GetObject(idle) == nil {
			priest.WaitUnit(t, fiendNpcIdleTarget, 15*time.Second)
		}

		expiring := summonFiend(t, priest, idle)
		log.setFiend(expiring)
		casts0, hits0 := log.counts()
		summoned := time.Now()
		lastHP := uint32(0)
		for deadline := summoned.Add(expiryWindow); time.Now().Before(deadline); time.Sleep(100 * time.Millisecond) {
			if priest.World.GetObject(expiring) == nil {
				break
			}
			if hp, _ := priest.UnitHP(expiring); hp > 0 {
				lastHP = hp
			}
		}
		if priest.World.GetObject(expiring) != nil {
			e2eharness.Preconditionf(t, "Shadowfiend 0x%X still there %s after its summon", expiring, expiryWindow)
		}
		gone := time.Since(summoned)
		time.Sleep(settle)
		casts, hits := log.counts()
		casts, hits = casts-casts0, hits-hits0
		t.Logf("Shadowfiend 0x%X gone %s after its summon (last %d hp, %d hits taken): %d Glyph of Shadowfiend "+
			"mana casts", expiring, gone.Round(100*time.Millisecond), lastHP, hits, casts)
		if hits != 0 || lastHP == 0 {
			e2eharness.Preconditionf(t, "Shadowfiend 0x%X took %d hits (last %d hp); it has to expire untouched",
				expiring, hits, lastHP)
		}
		if casts != 0 {
			e2eharness.Assertf(t, "Glyph of Shadowfiend (%d) fired %d times when the fiend expired",
				fiendSpellGlyphMana, casts)
		}
		t.Logf("PASS no mana when the fiend expires")
	})
}
