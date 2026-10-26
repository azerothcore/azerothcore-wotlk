//go:build e2e

package gameobjectcasters_test

import (
	"bytes"
	"encoding/binary"
	"io"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Since GameObjects cast their own spells (#26152), a gameobject with no owner (a world spawn, a wild
// summon, a herb's linked trap) is the caster of its trap spell, where a summoned world trigger used
// to be. Each test here sets off such a trap the way a player does and asserts the part of its spell
// that has to work without a unit caster.
// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/26152

const (
	cmsgCastSpell        uint16 = 0x12E
	smsgSpellEnergizeLog uint16 = 0x151
	smsgSpellLogExecute  uint16 = 0x24C

	targetFlagGameObject uint32 = 0x800
	spellEffectSummon    uint32 = 28

	npcSalvagedChopper  uint32 = 33062
	goRepairStationTrap uint32 = 194262 // RX-214 Repair-o-matic Station TRAP
	spellAutoRepair     uint32 = 62705

	goManaThistle        uint32 = 181281 // herb; its linked trap 181284 casts 28718 on whoever gathers it
	spellManaThistle     uint32 = 28718
	spellHerbGathering   uint32 = 2366
	skillHerbalism       uint32 = 182
	herbalismForThistle  uint32 = 375
	herbalismSkill       uint32 = 450
	goLandMine           uint32 = 191502
	spellLandMine        uint32 = 54355 // Detonation: damage, then a Land Mine Bunny guardian
	npcLandMineBunny     uint32 = 29397
	landMineArmingWindow        = 15 * time.Second

	// How long a trap may take to notice the bot and the effect to land.
	trapWindow = 10 * time.Second
)

// The Repair-o-matic Station in Flame Leviathan's arena casts Auto-repair (62705) on the siege vehicles
// in reach: its script restores their health and its energize effect refills their energy to full.
// The energize needs a unit caster or an owner, and the station is a world spawn with neither.
func TestGameObjectCaster_RepairStationRefillsVehicleEnergy(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "spells", "vehicles"},
		Runtime:  "short",
		Category: "spells/gameobject_casters",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "GoRepai", Level: 80})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	watch := watchAsGM(t, "GoRepaW")

	// Auto-repair picks its targets by entry around the station, so the chopper only has to be parked
	// in reach of it; the bot standing on the station is what sets it off.
	chopper := bot.Spawn(t, npcSalvagedChopper, 15*time.Second)
	if spawn := bot.SpawnGameObject(t, goRepairStationTrap); spawn == 0 {
		e2eharness.Preconditionf(t, "no spawn id resolved for the Repair-o-matic trap (%d)", goRepairStationTrap)
	}
	gmOff(t, bot)

	if !watch.waitCast(spellAutoRepair, trapWindow) {
		e2eharness.Preconditionf(t, "the Repair-o-matic trap never cast Auto-repair (%d) within %s",
			spellAutoRepair, trapWindow)
	}
	if !watch.waitEnergized(spellAutoRepair, chopper, 2*time.Second) {
		e2eharness.Assertf(t, "Auto-repair (%d) went off next to the Salvaged Chopper 0x%X but never energized it; "+
			"the station has no owner to energize from", spellAutoRepair, chopper)
	}
	t.Logf("PASS the Repair-o-matic refilled the Salvaged Chopper 0x%X", chopper)
}

// Gathering Mana Thistle sets off its linked trap, which casts 28718 to restore 500 mana to the
// herbalist. The linked trap is created with the herb and has no owner.
func TestGameObjectCaster_ManaThistleRestoresMana(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "spells", "professions"},
		Runtime:  "short",
		Category: "spells/gameobject_casters",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "GoThist", Class: e2eharness.ClassMage, Level: 80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	watch := watchAsGM(t, "GoThiW")

	bot.Learn(t, spellHerbGathering)
	bot.SetSkill(t, skillHerbalism, herbalismSkill, herbalismSkill)
	if spawn := bot.SpawnGameObject(t, goManaThistle); spawn == 0 {
		e2eharness.Preconditionf(t, "no spawn id resolved for Mana Thistle (%d)", goManaThistle)
	}
	gmOff(t, bot)
	herb := bot.WaitGameObject(t, goManaThistle, 15*time.Second)

	// The harness cannot target a gameobject with a cast, so Herb Gathering goes out as a raw
	// CMSG_CAST_SPELL: cast counter, spell id, cast flags, then the targets with the herb's GUID.
	var req bytes.Buffer
	req.WriteByte(1)
	_ = binary.Write(&req, binary.LittleEndian, spellHerbGathering)
	req.WriteByte(0)
	_ = binary.Write(&req, binary.LittleEndian, targetFlagGameObject)
	writePackedGUID(&req, herb)
	if err := bot.World.SendPacketRaw(cmsgCastSpell, req.Bytes()); err != nil {
		e2eharness.HarnessFailf(t, "send Herb Gathering on 0x%X: %v", herb, err)
	}

	if !watch.waitCast(spellManaThistle, 15*time.Second) {
		e2eharness.Preconditionf(t, "gathering Mana Thistle 0x%X (skill %d of %d needed) never set off its trap's %d",
			herb, herbalismSkill, herbalismForThistle, spellManaThistle)
	}
	_ = bot.World.LootRelease(herb)
	if !watch.waitEnergized(spellManaThistle, bot.World.CharGUID(), 2*time.Second) {
		e2eharness.Assertf(t, "Mana Thistle's trap cast %d on the herbalist but restored no mana; "+
			"the linked trap has no owner to energize from", spellManaThistle)
	}
	t.Logf("PASS gathering Mana Thistle restored mana")
}

// Stepping on a Land Mine casts Detonation (54355): damage, knocked back by spell_gen_mine_sweeper, and
// a Land Mine Bunny summoned as the mine's guardian. Summoning a guardian needs a unit caster or an
// owner, and the mines are world spawns.
func TestGameObjectCaster_LandMineSummonsBunny(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "spells"},
		Runtime:  "short",
		Category: "spells/gameobject_casters",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "GoMine", Level: 80})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	watch := watchAsGM(t, "GoMineW")

	if spawn := bot.SpawnGameObject(t, goLandMine); spawn == 0 {
		e2eharness.Preconditionf(t, "no spawn id resolved for the Land Mine (%d)", goLandMine)
	}
	// God mode: Detonation would otherwise kill a low-health bot before the summon is judged.
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true})
	bot.FlushWorld(t)

	if !watch.waitCast(spellLandMine, landMineArmingWindow) {
		e2eharness.Preconditionf(t, "the Land Mine never detonated (%d) under the bot within %s",
			spellLandMine, landMineArmingWindow)
	}
	ok := watch.waitFor(2*time.Second, func(w *spellWatch) bool {
		for _, guid := range w.summoned[spellLandMine] {
			if entryOf(guid) == npcLandMineBunny {
				return true
			}
		}
		return false
	})
	if !ok {
		e2eharness.Assertf(t, "Detonation (%d) went off but summoned no Land Mine Bunny (%d); "+
			"the mine has no owner to summon its guardian for", spellLandMine, npcLandMineBunny)
	}
	t.Logf("PASS the Land Mine summoned its bunny")
}

// watchAsGM logs a second bot in as a GM on the pad and watches spells through it. The server only
// sends a player the packets of objects that player has in view, and only a GM sees an invisible
// trap such as the Repair-o-matic. A trap never fires on a GM.
func watchAsGM(t *testing.T, prefix string) *spellWatch {
	t.Helper()
	gm := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: prefix, Level: 80})
	gm.TeleportPad(t, e2eharness.PackagePad(t))
	e2eharness.MustGM(t, gm.World, ".gm on")
	gm.FlushWorld(t)
	return watchSpells(t, gm)
}

// spellWatch records what the server reports about spells while a test runs.
type spellWatch struct {
	mu        sync.Mutex
	gos       map[uint32]int
	energized map[uint32][]uint64
	summoned  map[uint32][]uint64
}

func watchSpells(t *testing.T, bot *e2eharness.ScenarioBot) *spellWatch {
	w := &spellWatch{gos: map[uint32]int{}, energized: map[uint32][]uint64{}, summoned: map[uint32][]uint64{}}
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		r := bytes.NewReader(data)
		switch opcode {
		case client.SmsgSpellGo:
			// cast-item and caster packed GUIDs, the cast counter, then the spell id
			if _, err := readPackedGUID(r); err != nil {
				return
			}
			if _, err := readPackedGUID(r); err != nil {
				return
			}
			var head struct {
				CastCount uint8
				Spell     uint32
			}
			if binary.Read(r, binary.LittleEndian, &head) != nil {
				return
			}
			w.mu.Lock()
			w.gos[head.Spell]++
			w.mu.Unlock()
		case smsgSpellEnergizeLog:
			// victim and caster packed GUIDs, then the spell id
			victim, err := readPackedGUID(r)
			if err != nil {
				return
			}
			if _, err := readPackedGUID(r); err != nil {
				return
			}
			var spell uint32
			if binary.Read(r, binary.LittleEndian, &spell) != nil {
				return
			}
			w.mu.Lock()
			w.energized[spell] = append(w.energized[spell], victim)
			w.mu.Unlock()
		case smsgSpellLogExecute:
			// caster packed GUID, spell id, effect count, then per effect its id, target count and
			// targets; only a summon's targets, one packed GUID each, are read
			if _, err := readPackedGUID(r); err != nil {
				return
			}
			var head struct{ Spell, Effects uint32 }
			if binary.Read(r, binary.LittleEndian, &head) != nil {
				return
			}
			for i := uint32(0); i < head.Effects; i++ {
				var effect struct{ Effect, Targets uint32 }
				if binary.Read(r, binary.LittleEndian, &effect) != nil || effect.Effect != spellEffectSummon {
					return
				}
				for j := uint32(0); j < effect.Targets; j++ {
					guid, err := readPackedGUID(r)
					if err != nil {
						return
					}
					w.mu.Lock()
					w.summoned[head.Spell] = append(w.summoned[head.Spell], guid)
					w.mu.Unlock()
				}
			}
		}
	})
	t.Cleanup(cancel)
	return w
}

// waitFor polls cond under the watch's lock until it holds or timeout passes.
func (w *spellWatch) waitFor(timeout time.Duration, cond func(w *spellWatch) bool) bool {
	for deadline := time.Now().Add(timeout); ; {
		w.mu.Lock()
		ok := cond(w)
		w.mu.Unlock()
		if ok {
			return true
		}
		if time.Now().After(deadline) {
			return false
		}
		time.Sleep(50 * time.Millisecond)
	}
}

func (w *spellWatch) waitCast(spell uint32, timeout time.Duration) bool {
	return w.waitFor(timeout, func(w *spellWatch) bool { return w.gos[spell] > 0 })
}

func (w *spellWatch) waitEnergized(spell uint32, victim uint64, timeout time.Duration) bool {
	return w.waitFor(timeout, func(w *spellWatch) bool {
		for _, v := range w.energized[spell] {
			if v == victim {
				return true
			}
		}
		return false
	})
}

// gmOff leaves GM mode: an ownerless trap only notices players who are not GMs.
func gmOff(t *testing.T, bot *e2eharness.ScenarioBot) {
	t.Helper()
	e2eharness.MustGM(t, bot.World, ".gm off")
	bot.FlushWorld(t)
}

func entryOf(guid uint64) uint32 { return uint32((guid >> 24) & 0xFFFFFF) }

func readPackedGUID(r io.ByteReader) (uint64, error) {
	mask, err := r.ReadByte()
	if err != nil {
		return 0, err
	}
	var guid uint64
	for bit := 0; bit < 8; bit++ {
		if mask&(1<<uint(bit)) == 0 {
			continue
		}
		b, err := r.ReadByte()
		if err != nil {
			return 0, err
		}
		guid |= uint64(b) << (8 * uint(bit))
	}
	return guid, nil
}

func writePackedGUID(b *bytes.Buffer, guid uint64) {
	var mask byte
	var packed []byte
	for bit := 0; bit < 8; bit++ {
		if v := byte(guid >> (8 * uint(bit))); v != 0 {
			mask |= 1 << uint(bit)
			packed = append(packed, v)
		}
	}
	b.WriteByte(mask)
	b.Write(packed)
}
