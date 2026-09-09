//go:build e2e

package trainers_test

import (
	"encoding/binary"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27146
//
// Twelve TBC master-tier Engineering recipes were missing from some of the eight
// Engineering trainer groups, so e.g. Technician Mihila (33677, TrainerId 90) did
// not teach Frost Grenades (39973) even at skill 335.
//
// The player-visible surface is SMSG_TRAINER_LIST: Trainer::SendSpells emits the
// trainer group's spells, so a missing `trainer_spell` row means the recipe never
// appears in the client's trainer window.
//
// Two server rules shape what a test can assert:
//
//   - SendSpells filters each spell through IsSpellFitByClassAndRace. Eleven of the
//     twelve recipes are class-restricted goggles, so any single character sees only
//     its own. Four classes together cover all twelve (see recipesByClass).
//   - HandleTrainerListOpcode goes through GetNPCIfCanInteractWith, which refuses
//     hostile NPCs. Zebig and Mack Diver are Horde-side, Lebowski Alliance-side, so
//     the trainers are split by the faction that can reach them.
//
// Skill level is irrelevant here: `trainer`.`Requirement` is 0 for all eight groups
// and skill only changes each spell's Usable byte, not its presence in the packet.
const (
	cmsgTrainerList = 0x1B0
	smsgTrainerList = 0x1B1

	// SMSG_TRAINER_LIST: uint64 TrainerGUID, int32 TrainerType, int32 SpellCount,
	// then SpellCount fixed-width records (NPCPackets.cpp, TrainerList::Write).
	trainerListHeader = 16
	// int32 SpellID, uint8 Usable, int32 MoneyCost, int32[2] PointCost, uint8 ReqLevel,
	// int32 ReqSkillLine, int32 ReqSkillRank, int32[3] ReqAbility = 38 bytes.
	trainerListSpellSize = 38
)

var recipeNames = map[uint32]string{
	39973: "Frost Grenades",
	40274: "Furious Gizmatic Goggles",
	41311: "Justicebringer 2000 Specs",
	41312: "Tankatronic Goggles",
	41314: "Surestrike Goggles v2.0",
	41315: "Gadgetstorm Goggles",
	41316: "Living Replicator Specs",
	41317: "Deathblow X11 Goggles",
	41318: "Wonderheal XT40 Shades",
	41319: "Magnified Moon Specs",
	41320: "Destruction Holo-gogs",
	41321: "Powerheal 4000 Lens",
}

type trainerSpec struct {
	name    string
	entry   uint32
	trainer int
}

var (
	kLeeSmallfry    = trainerSpec{"KLeeSmallfry", 17634, 84}
	zebig           = trainerSpec{"Zebig", 18752, 85}
	lebowski        = trainerSpec{"Lebowski", 18775, 86}
	xyrol           = trainerSpec{"Xyrol", 19576, 87}
	mackDiver       = trainerSpec{"MackDiver", 17637, 88}
	tishaLongbridge = trainerSpec{"TishaLongbridge", 26907, 89}
	mihila          = trainerSpec{"TechnicianMihila", 33677, 90}
	sinbei          = trainerSpec{"EngineerSinbei", 33634, 91}
)

// botSpec pairs a character with the trainers it can actually reach.
//
// Reachability is a faction matter, verified against the live server: Zebig and
// Mack Diver are Horde-side, Lebowski Alliance-side, and the Shattrath pair splits
// on the Aldor/Scryer divide — Draenei cannot interact with Sinbei (Scryer, faction
// 1744) and Blood Elves cannot interact with Mihila (Aldor, 1743). Every other race
// reaches both. Two characters per class therefore cover all eight groups, and the
// four classes together cover all twelve recipes.
type botSpec struct {
	name        string
	race, class uint8
	recipes     []uint32
	trainers    []trainerSpec
}

// Frost Grenades (39973) is class-neutral, so every character asserts it.
var bots = []botSpec{
	{"HumanPaladin", e2eharness.RaceHuman, e2eharness.ClassPaladin,
		[]uint32{39973, 40274, 41311, 41312},
		[]trainerSpec{kLeeSmallfry, lebowski, xyrol, tishaLongbridge, mihila, sinbei}},
	{"BloodElfPaladin", e2eharness.RaceBloodElf, e2eharness.ClassPaladin,
		[]uint32{39973, 40274, 41311, 41312},
		[]trainerSpec{zebig, mackDiver}},

	{"DraeneiShaman", e2eharness.RaceDraenei, e2eharness.ClassShaman,
		[]uint32{39973, 41314, 41315, 41316},
		[]trainerSpec{kLeeSmallfry, lebowski, xyrol, tishaLongbridge, mihila}},
	{"OrcShaman", e2eharness.RaceOrc, e2eharness.ClassShaman,
		[]uint32{39973, 41314, 41315, 41316},
		[]trainerSpec{zebig, mackDiver, sinbei}},

	{"NightElfDruid", e2eharness.RaceNightElf, e2eharness.ClassDruid,
		[]uint32{39973, 41317, 41318, 41319},
		[]trainerSpec{kLeeSmallfry, lebowski, xyrol, tishaLongbridge, mihila, sinbei}},
	{"TaurenDruid", e2eharness.RaceTauren, e2eharness.ClassDruid,
		[]uint32{39973, 41317, 41318, 41319},
		[]trainerSpec{zebig, mackDiver}},

	{"HumanPriest", e2eharness.RaceHuman, e2eharness.ClassPriest,
		[]uint32{39973, 41320, 41321},
		[]trainerSpec{kLeeSmallfry, lebowski, xyrol, tishaLongbridge, mihila, sinbei}},
	{"TrollPriest", e2eharness.RaceTroll, e2eharness.ClassPriest,
		[]uint32{39973, 41320, 41321},
		[]trainerSpec{zebig, mackDiver}},
}

// decodeTrainerSpells returns the spell IDs advertised for trainerGUID, or ok=false
// if the packet is for a different NPC or is too short to trust.
func decodeTrainerSpells(data []byte, trainerGUID uint64) (spells []uint32, ok bool) {
	if len(data) < trainerListHeader {
		return nil, false
	}
	if binary.LittleEndian.Uint64(data[0:8]) != trainerGUID {
		return nil, false
	}
	count := int(int32(binary.LittleEndian.Uint32(data[12:16])))
	if count < 0 || trainerListHeader+count*trainerListSpellSize > len(data) {
		return nil, false
	}
	spells = make([]uint32, 0, count)
	for i := 0; i < count; i++ {
		off := trainerListHeader + i*trainerListSpellSize
		spells = append(spells, binary.LittleEndian.Uint32(data[off:off+4]))
	}
	return spells, true
}

// trainerSpells asks npc for its spell list and returns what it advertises.
func trainerSpells(t *testing.T, bot *e2eharness.ScenarioBot, tr trainerSpec) []uint32 {
	t.Helper()
	bot.GoCreatureID(t, tr.entry)
	guid := bot.WaitUnit(t, tr.entry, 20*time.Second)
	if guid == 0 {
		e2eharness.Preconditionf(t, "%s (%d) not found after .go creature id %d",
			tr.name, tr.entry, tr.entry)
	}

	var (
		mu   sync.Mutex
		got  []uint32
		once sync.Once
	)
	done := make(chan struct{})
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != smsgTrainerList {
			return
		}
		spells, ok := decodeTrainerSpells(data, guid)
		if !ok {
			return
		}
		mu.Lock()
		got = spells
		mu.Unlock()
		once.Do(func() { close(done) })
	})
	defer cancel()

	req := make([]byte, 8)
	binary.LittleEndian.PutUint64(req, guid)

	// GetNPCIfCanInteractWith tests the server-side position, which can still lag a
	// same-map .go teleport when the request goes out. A dropped request is silent,
	// so resend until the trainer answers rather than waiting on the first one.
	deadline := time.After(15 * time.Second)
	for received := false; !received; {
		if err := bot.World.SendPacketRaw(cmsgTrainerList, req); err != nil {
			e2eharness.HarnessFailf(t, "sending CMSG_TRAINER_LIST for %s: %v", tr.name, err)
		}
		select {
		case <-done:
			received = true
		case <-deadline:
			e2eharness.Preconditionf(t, "%s (%d, TrainerId %d) sent no SMSG_TRAINER_LIST; "+
				"the character cannot interact with this trainer", tr.name, tr.entry, tr.trainer)
		case <-time.After(1500 * time.Millisecond):
		}
	}

	mu.Lock()
	defer mu.Unlock()
	return got
}

// TestAC_27146_EngineeringTrainersTeachMasterRecipes asserts every Engineering
// trainer group advertises the master-tier recipes its visitor's class can learn.
func TestAC_27146_EngineeringTrainersTeachMasterRecipes(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "professions", "issue"},
		Runtime:  "med",
		Issue:    27146,
		Category: "professions/trainers",
	})

	for _, bs := range bots {
		t.Run(bs.name, func(t *testing.T) {
			bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
				Prefix: "ET" + bs.name[:4],
				Level:  80,
				Race:   bs.race,
				Class:  bs.class,
			})
			for _, tr := range bs.trainers {
				t.Run(tr.name, func(t *testing.T) {
					spells := trainerSpells(t, bot, tr)
					have := make(map[uint32]bool, len(spells))
					for _, s := range spells {
						have[s] = true
					}
					for _, id := range bs.recipes {
						if !have[id] {
							e2eharness.Assertf(t, "%s (%d, TrainerId %d) does not advertise "+
								"%s (%d) to a %s; without the trainer_spell row the recipe "+
								"never appears in the trainer window",
								tr.name, tr.entry, tr.trainer, recipeNames[id], id, bs.name)
						}
					}
					t.Logf("OK %s (TrainerId %d) advertises all %d recipes to %s (%d spells total)",
						tr.name, tr.trainer, len(bs.recipes), bs.name, len(spells))
				})
			}
		})
	}
}
