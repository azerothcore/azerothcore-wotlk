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
//     its own. Four classes together cover all twelve.
//
//     That filter is asserted in both directions: each character must see its own
//     recipes and must NOT see the others'. Presence alone would still pass if the
//     class filter broke and every character saw all twelve.
//
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

// allRecipes fixes iteration order so failures are reproducible. A character's
// expected set is its botSpec.recipes; everything else here it must not be offered.
var allRecipes = []uint32{39973, 40274, 41311, 41312, 41314, 41315, 41316, 41317, 41318, 41319, 41320, 41321}

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

	// The remaining six classes add no recipe the four above miss, so they visit only
	// the trainer the issue names. They pin the armour-type sharing: a warrior gets the
	// plate goggles a paladin gets, minus the paladin-only one, and so on. Death knights
	// share that plate set — SkillLineAbility gives 40274 and 41312 ClassMask 0x23, which
	// is warrior, paladin and death knight.
	{"HumanWarrior", e2eharness.RaceHuman, e2eharness.ClassWarrior,
		[]uint32{39973, 40274, 41312},
		[]trainerSpec{mihila}},
	{"NightElfHunter", e2eharness.RaceNightElf, e2eharness.ClassHunter,
		[]uint32{39973, 41314},
		[]trainerSpec{mihila}},
	{"HumanRogue", e2eharness.RaceHuman, e2eharness.ClassRogue,
		[]uint32{39973, 41317},
		[]trainerSpec{mihila}},
	{"HumanMage", e2eharness.RaceHuman, e2eharness.ClassMage,
		[]uint32{39973, 41320},
		[]trainerSpec{mihila}},
	{"HumanWarlock", e2eharness.RaceHuman, e2eharness.ClassWarlock,
		[]uint32{39973, 41320},
		[]trainerSpec{mihila}},
	{"HumanDeathKnight", e2eharness.RaceHuman, e2eharness.ClassDeathKnight,
		[]uint32{39973, 40274, 41312},
		[]trainerSpec{mihila}},
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
					want := make(map[uint32]bool, len(bs.recipes))
					for _, id := range bs.recipes {
						want[id] = true
					}
					for _, id := range allRecipes {
						switch {
						case want[id] && !have[id]:
							e2eharness.Assertf(t, "%s (%d, TrainerId %d) does not advertise "+
								"%s (%d) to a %s; without the trainer_spell row the recipe "+
								"never appears in the trainer window",
								tr.name, tr.entry, tr.trainer, recipeNames[id], id, bs.name)
						case !want[id] && have[id]:
							e2eharness.Assertf(t, "%s (%d, TrainerId %d) advertises %s (%d) to "+
								"a %s, which cannot learn it; SendSpells should have dropped it "+
								"via IsSpellFitByClassAndRace",
								tr.name, tr.entry, tr.trainer, recipeNames[id], id, bs.name)
						}
					}
					t.Logf("OK %s (TrainerId %d) offers %s exactly its %d of the %d master "+
						"recipes (%d spells total)",
						tr.name, tr.trainer, bs.name, len(bs.recipes), len(allRecipes), len(spells))
				})
			}
		})
	}
}

// Review on https://github.com/azerothcore/azerothcore-wotlk/pull/27573 asked what
// the correct 3.3.5 behaviour for the goggles is: a druid cannot use mail, so should
// the mail goggle sit greyed out in the trainer window, or not appear at all? And is
// a goggle meant for one class hidden from the rest?
//
// It is absent entirely, and the gate is not `conditions`. Trainer::SendSpells drops
// every spell through Player::IsSpellFitByClassAndRace
// (src/server/game/Entities/Creature/Trainer.cpp:49), which reads ClassMask and
// RaceMask from SkillLineAbility.dbc — client data, so the 3.3.5 client itself draws
// the line and the server is only honouring it.
//
// That line is NOT armour type. Every crafted goggle carries AllowableClass -1 and
// differs only in armour subclass (item_template.subclass: 4 plate, 3 mail, 2
// leather, 1 cloth), so the item is wearable by anyone holding the proficiency —
// Player::CanEquipItem refuses on GetSkillValue(pItem->GetSkill()) == 0
// (PlayerStorage.cpp:2340), nothing class-specific. The recipes are cut finer, by
// role, which is what makes the two questions have different answers:
//
//   - a druid is offered no mail goggle and cannot wear one either — armour type and
//     recipe agree, and hiding it costs the player nothing;
//   - a warrior CAN wear Justicebringer 2000 Specs, which is plate, yet is not
//     offered its recipe: it is the paladin's goggle. The druid-only leather pair
//     against a rogue, and the priest-only cloth one against a mage, are the same
//     shape.
//
// So "can this class wear it" would be the wrong filter to build — it would hand a
// warrior the paladin recipe. This test pins both halves for all eleven goggles so
// neither drifts: what the trainer offers, and whether the character can put the
// result on its head. Refusals
// are read from SMSG_INVENTORY_CHANGE_FAILURE rather than inferred from "nothing
// happened", so an equip that fails for an unrelated reason fails the test too.
const (
	smsgInventoryChangeFailure = 0x112

	// Item.h: InventoryResult. The armour-proficiency refusal, and the one that would
	// mask it if Engineering were left below the goggles' RequiredSkillRank of 350.
	equipErrNoRequiredProficiency = 8
	equipErrCantEquipSkill        = 21

	skillEngineering = 202
)

// goggleItems maps each recipe to what it crafts. Entries and armour subclasses read
// from item_template; all eleven are RequiredSkill 202 rank 350, RequiredLevel 62,
// AllowableClass -1.
var goggleItems = map[uint32]struct {
	entry  uint32
	armour string
}{
	40274: {32461, "plate"},
	41311: {32472, "plate"},
	41312: {32473, "plate"},
	41314: {32474, "mail"},
	41315: {32476, "mail"},
	41316: {32475, "mail"},
	41317: {32478, "leather"},
	41318: {32479, "leather"},
	41319: {32480, "leather"},
	41320: {32494, "cloth"},
	41321: {32495, "cloth"},
}

// gogglePerm is one (character, goggle) pair: whether the trainer offers the recipe,
// and whether the character can wear what it makes. The two are independent on
// purpose — the pairs where they disagree are the point of the test.
type gogglePerm struct {
	recipe   uint32
	offered  bool
	wearable bool
	why      string
}

type goggleBot struct {
	prefix      string
	name        string
	race, class uint8
	cases       []gogglePerm
}

// Every character visits Technician Mihila (TrainerId 90), the trainer #27146 names.
// Armour proficiency at level 80 with all class spells learned: warrior and paladin
// reach plate, shaman mail, druid and rogue leather, mage cloth.
var goggleBots = []goggleBot{
	{"GGPala", "HumanPaladin", e2eharness.RaceHuman, e2eharness.ClassPaladin, []gogglePerm{
		{41311, true, true, "plate, and the paladin is the class it was made for"},
		{41314, false, true, "mail: a paladin wears mail, but this recipe is a hunter's and a shaman's"},
		{41320, false, true, "cloth: a paladin wears cloth, but this recipe is a mage's and a warlock's"},
	}},
	{"GGWarr", "HumanWarrior", e2eharness.RaceHuman, e2eharness.ClassWarrior, []gogglePerm{
		{41312, true, true, "plate, shared by warrior, paladin and death knight"},
		{41311, false, true, "plate the warrior can wear, but the recipe is paladin-only"},
	}},
	{"GGDrui", "NightElfDruid", e2eharness.RaceNightElf, e2eharness.ClassDruid, []gogglePerm{
		{41318, true, true, "leather, and druid-only"},
		{41319, true, true, "leather, and druid-only — the caster counterpart to Wonderheal"},
		{41315, false, false, "mail: a druid can neither learn it nor wear it"},
		{41312, false, false, "plate: a druid can neither learn it nor wear it"},
	}},
	{"GGRogu", "HumanRogue", e2eharness.RaceHuman, e2eharness.ClassRogue, []gogglePerm{
		{41317, true, true, "leather, shared by rogue and druid"},
		{41318, false, true, "leather the rogue can wear, but the recipe is druid-only"},
		{41319, false, true, "the other druid-only leather goggle the rogue can wear but not learn"},
		{41314, false, false, "mail: a rogue can neither learn it nor wear it"},
	}},
	{"GGMage", "HumanMage", e2eharness.RaceHuman, e2eharness.ClassMage, []gogglePerm{
		{41320, true, true, "cloth, shared by mage and warlock"},
		{41321, false, true, "cloth the mage can wear, but the recipe is priest-only"},
		{41317, false, false, "leather: a mage can neither learn it nor wear it"},
	}},
	{"GGDK", "HumanDeathKnight", e2eharness.RaceHuman, e2eharness.ClassDeathKnight, []gogglePerm{
		{40274, true, true, "plate, shared by warrior, paladin and death knight"},
		{41311, false, true, "plate the death knight can wear, but the recipe is paladin-only"},
	}},
	{"GGSham", "DraeneiShaman", e2eharness.RaceDraenei, e2eharness.ClassShaman, []gogglePerm{
		{41316, true, true, "mail, shared by shaman and hunter"},
		{41311, false, false, "plate: a shaman can neither learn it nor wear it"},
	}},
}

// equipOutcome is what the server did with one CMSG_AUTOEQUIP_ITEM.
type equipOutcome struct {
	slot       uint8
	equipped   bool
	failure    uint8
	hasFailure bool
}

// equipGoggle hands the character the crafted goggle and tries to put it on,
// returning the paper-doll slot it reached or the InventoryResult that refused it.
func equipGoggle(t *testing.T, bot *e2eharness.ScenarioBot, entry uint32) equipOutcome {
	t.Helper()

	bag, slot := bot.AddItemWait(t, entry, 1)

	// Arm before sending: the refusal comes back on the same round trip.
	var (
		mu     sync.Mutex
		result uint8
		seen   bool
	)
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		// data[0] is the InventoryResult (Player::SendEquipError). 0 is EQUIP_ERR_OK
		// and carries no refusal.
		if opcode != smsgInventoryChangeFailure || len(data) < 1 || data[0] == 0 {
			return
		}
		mu.Lock()
		result, seen = data[0], true
		mu.Unlock()
	})
	defer cancel()

	if err := bot.World.AutoEquipItem(bag, slot); err != nil {
		e2eharness.HarnessFailf(t, "sending CMSG_AUTOEQUIP_ITEM for item %d: %v", entry, err)
	}

	deadline := time.Now().Add(5 * time.Second)
	for {
		if s, ok := bot.EquippedSlot(entry); ok {
			return equipOutcome{slot: s, equipped: true}
		}
		mu.Lock()
		res, ok := result, seen
		mu.Unlock()
		if ok {
			return equipOutcome{failure: res, hasFailure: true}
		}
		if time.Now().After(deadline) {
			return equipOutcome{}
		}
		time.Sleep(150 * time.Millisecond)
	}
}

// TestAC_27146_GoggleRecipesGatedByRoleNotArmour asserts that the trainer hides a
// goggle recipe a character cannot learn, and that hiding it is right: either the
// character cannot wear the result at all, or the goggle belongs to another class
// that shares its armour type.
func TestAC_27146_GoggleRecipesGatedByRoleNotArmour(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "professions", "issue"},
		Runtime:  "med",
		Issue:    27146,
		Category: "professions/trainers",
	})

	for _, gb := range goggleBots {
		t.Run(gb.name, func(t *testing.T) {
			bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
				Prefix:        gb.prefix,
				Level:         80,
				Race:          gb.race,
				Class:         gb.class,
				LearnAllClass: true,
			})

			// Plate and mail proficiency are trainer-taught at level 40, so without the
			// class spells "can this class wear it" would be false for everyone.
			// Engineering 375 clears the goggles' own RequiredSkillRank 350, which would
			// otherwise refuse every equip with EQUIP_ERR_CANT_EQUIP_SKILL and hide the
			// proficiency answer behind it.
			bot.SetSkill(t, skillEngineering, 375, 375)
			bot.FlushWorld(t)

			spells := trainerSpells(t, bot, mihila)
			have := make(map[uint32]bool, len(spells))
			for _, s := range spells {
				have[s] = true
			}

			for _, c := range gb.cases {
				item := goggleItems[c.recipe]
				t.Run(recipeNames[c.recipe], func(t *testing.T) {
					switch {
					case c.offered && !have[c.recipe]:
						e2eharness.Assertf(t, "%s (%d, TrainerId %d) does not offer %s (%d) to a %s; %s",
							mihila.name, mihila.entry, mihila.trainer, recipeNames[c.recipe], c.recipe, gb.name, c.why)
					case !c.offered && have[c.recipe]:
						e2eharness.Assertf(t, "%s (%d, TrainerId %d) offers %s (%d) to a %s; %s, so "+
							"IsSpellFitByClassAndRace should have dropped it from SMSG_TRAINER_LIST",
							mihila.name, mihila.entry, mihila.trainer, recipeNames[c.recipe], c.recipe, gb.name, c.why)
					}

					got := equipGoggle(t, bot, item.entry)
					switch {
					case c.wearable && !got.equipped:
						e2eharness.Assertf(t, "a %s cannot equip %s (item %d, %s), refused with "+
							"InventoryResult %d; %s, and %s armour is within its proficiency",
							gb.name, recipeNames[c.recipe], item.entry, item.armour, got.failure, c.why, item.armour)
					case !c.wearable && got.equipped:
						e2eharness.Assertf(t, "a %s equipped %s (item %d, %s) in slot %d; %s, and "+
							"CanEquipItem should have refused it for want of %s proficiency",
							gb.name, recipeNames[c.recipe], item.entry, item.armour, got.slot, c.why, item.armour)
					case !c.wearable && got.hasFailure && got.failure != equipErrNoRequiredProficiency:
						reason := "an unexpected InventoryResult"
						if got.failure == equipErrCantEquipSkill {
							reason = "EQUIP_ERR_CANT_EQUIP_SKILL, so Engineering never reached the goggles' rank 350"
						}
						e2eharness.Assertf(t, "a %s was refused %s (item %d, %s) with InventoryResult %d — %s; "+
							"the refusal should be EQUIP_ERR_NO_REQUIRED_PROFICIENCY (%d)",
							gb.name, recipeNames[c.recipe], item.entry, item.armour, got.failure, reason,
							equipErrNoRequiredProficiency)
					case !c.wearable && !got.hasFailure:
						e2eharness.Assertf(t, "a %s neither equipped %s (item %d, %s) nor was refused; "+
							"CMSG_AUTOEQUIP_ITEM drew no SMSG_INVENTORY_CHANGE_FAILURE, so nothing was proven",
							gb.name, recipeNames[c.recipe], item.entry, item.armour)
					}

					offered, wearable := "hidden", "cannot wear"
					if c.offered {
						offered = "offered"
					}
					if c.wearable {
						wearable = "wears"
					}
					t.Logf("OK %s: %s (%d, %s) %s at TrainerId %d, %s the item (%d) — %s",
						gb.name, recipeNames[c.recipe], c.recipe, item.armour, offered, mihila.trainer,
						wearable, item.entry, c.why)
				})
			}
		})
	}
}
