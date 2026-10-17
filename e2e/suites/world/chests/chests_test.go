//go:build e2e

package chests_test

import (
	"encoding/binary"
	"fmt"
	"reflect"
	"testing"
	"time"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	_ "github.com/go-sql-driver/mysql"
)

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/27381
// Use fresh, cleaned-up spawns at an isolation pad, never the dungeon's real graves.
// These are chest lifecycle tests, not tests of Ahune or Zum'rah's encounter.
func chestBots(t *testing.T) (actor, mate, observer *e2eharness.ScenarioBot) {
	t.Helper()
	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "Chests", Count: 3, Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarrior, Level: 80,
	})
	actor, mate, observer = bots[0], bots[1], bots[2]
	pad := e2eharness.PackagePad(t)
	e2eharness.FormPartyAtPad(t, pad, actor, mate)
	observer.TeleportPad(t, pad)
	// The Ice Chest's bunny is an invisible trigger; a separate GM observes it.
	// Neither looter gets GM-mode loot privileges.
	observer.GM(t, ".gm on")
	observer.FlushWorld(t)
	actor.CombatReady(t)
	mate.CombatReady(t)
	return
}

func spawnChest(t *testing.T, observer, actor *e2eharness.ScenarioBot, entry uint32) uint64 {
	t.Helper()
	if observer.SpawnGameObject(t, entry) == 0 {
		e2eharness.Preconditionf(t, "cannot resolve cleanup spawn ID for chest %d", entry)
	}
	return actor.WaitGameObject(t, entry, 10*time.Second)
}

type chestLoot struct {
	gold  uint32
	items []client.LootItem
}

// v1.0.8 has no gameobject-target cast helper. Use its raw packet API, with the
// same CMSG_CAST_SPELL layout read by WorldSession::HandleCastSpellOpcode.
// CMSG_LOOT bypasses Spell::SendLoot; CMSG_GAMEOBJ_USE alone does not open a chest.
func castOpening(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64, spell uint32) {
	t.Helper()
	payload := make([]byte, 11) // cast count, spell, cast flags, target flags, packed-GUID mask
	binary.LittleEndian.PutUint32(payload[1:5], spell)
	binary.LittleEndian.PutUint32(payload[6:10], 0x0800) // TARGET_FLAG_GAMEOBJECT
	for i := uint(0); i < 8; i++ {
		if b := byte(guid >> (8 * i)); b != 0 {
			payload[10] |= 1 << i
			payload = append(payload, b)
		}
	}
	if err := bot.World.SendPacketRaw(client.CmsgCastSpell, payload); err != nil {
		e2eharness.HarnessFailf(t, "Opening packet: %v", err)
	}
}

func openChest(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64, spell uint32) chestLoot {
	t.Helper()
	packets := make(chan []byte, 1)
	cancel := bot.World.AddPacketHook(func(op uint16, data []byte) {
		if op == client.SmsgLootResponse && len(data) >= 8 && binary.LittleEndian.Uint64(data) == guid {
			select {
			case packets <- append([]byte(nil), data...):
			default:
			}
		}
	})
	defer cancel()
	castOpening(t, bot, guid, spell)
	select {
	case data := <-packets:
		if len(data) < 14 || len(data) < 14+22*int(data[13]) {
			e2eharness.Assertf(t, "chest 0x%X rejected opening or returned malformed loot: %x", guid, data)
		}
		result := chestLoot{gold: binary.LittleEndian.Uint32(data[9:13])}
		for i := 0; i < int(data[13]); i++ {
			row := data[14+i*22:]
			result.items = append(result.items, client.LootItem{
				Index: row[0], ItemID: binary.LittleEndian.Uint32(row[1:5]), Quantity: binary.LittleEndian.Uint32(row[5:9]),
			})
		}
		return result
	case <-time.After(12 * time.Second):
		e2eharness.Assertf(t, "chest 0x%X: no loot response to Opening spell %d", guid, spell)
		return chestLoot{}
	}
}

func closeChest(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64) {
	t.Helper()
	ack := make(chan struct{}, 1)
	cancel := bot.World.AddPacketHook(func(op uint16, data []byte) {
		if op == client.SmsgLootReleaseResponse && len(data) >= 8 && binary.LittleEndian.Uint64(data) == guid {
			select {
			case ack <- struct{}{}:
			default:
			}
		}
	})
	defer cancel()
	bot.LootRelease(t, guid)
	select {
	case <-ack:
	case <-time.After(5 * time.Second):
		e2eharness.HarnessFailf(t, "no loot release acknowledgement for 0x%X", guid)
	}
}

func waitChestGone(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64) {
	t.Helper()
	deadline := time.Now().Add(5 * time.Second)
	for bot.World.GetObject(guid) != nil {
		if time.Now().After(deadline) {
			e2eharness.Assertf(t, "consumed/deleted chest 0x%X remained visible", guid)
		}
		time.Sleep(25 * time.Millisecond)
	}
}

// Count GUIDs, not surviving creatures: dying/despawning must not conceal a
// repeated summon. Only new units of the fixture's entries are cleaned up.
type summonObserver struct {
	bot     *e2eharness.ScenarioBot
	entries map[uint32]bool
	seen    map[uint64]bool
	owned   map[uint64]bool
}

func observeSummons(t *testing.T, bot *e2eharness.ScenarioBot, entries ...uint32) *summonObserver {
	t.Helper()
	o := &summonObserver{bot: bot, entries: map[uint32]bool{}, seen: map[uint64]bool{}, owned: map[uint64]bool{}}
	for _, entry := range entries {
		o.entries[entry] = true
	}
	o.scan()
	o.owned = map[uint64]bool{} // existing units are not ours
	t.Cleanup(func() { o.clean(t) })
	return o
}

func (o *summonObserver) scan() {
	for _, unit := range o.bot.World.GetNearbyUnits(100) {
		if o.entries[unit.Entry] && !o.seen[unit.GUID] {
			o.seen[unit.GUID], o.owned[unit.GUID] = true, true
		}
	}
}

func (o *summonObserver) watch(duration time.Duration) {
	deadline := time.Now().Add(duration)
	for time.Now().Before(deadline) {
		o.scan()
		time.Sleep(25 * time.Millisecond)
	}
	o.scan()
}

func (o *summonObserver) clean(t *testing.T) {
	t.Helper()
	o.scan()
	for guid := range o.owned {
		if o.bot.World.GetObject(guid) != nil {
			if err := o.bot.World.SetTarget(guid); err != nil {
				e2eharness.HarnessFailf(t, "select fixture summon: %v", err)
			}
			o.bot.FlushWorld(t)
			o.bot.GM(t, ".npc delete")
			o.bot.FlushWorld(t)
		}
		delete(o.owned, guid)
	}
}

func (o *summonObserver) unchanged(t *testing.T, baseline int) {
	t.Helper()
	// A bounded negative observation window also lets delayed object updates arrive.
	o.watch(2 * time.Second)
	if len(o.seen) != baseline {
		e2eharness.Assertf(t, "reopening summoned new creatures: distinct GUIDs %d -> %d", baseline, len(o.seen))
	}
}

func TestChests_CatFigurineReopen(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "loot", "serial"}, Runtime: "med", Category: "world/chests"})
	actor, _, observer := chestBots(t)
	o := observeSummons(t, observer, 3619)
	guid := spawnChest(t, observer, actor, 13873)
	before := len(o.seen)
	first := openChest(t, actor, guid, 3365) // lock type 5, Opening
	o.watch(2 * time.Second)
	baseline := len(o.seen)
	if baseline == before || len(first.items) != 1 || first.items[0].ItemID != 5329 {
		e2eharness.Assertf(t, "Cat Figurine must summon Ghost Saber(s) and offer item 5329: summons=%d loot=%+v", baseline-before, first)
	}
	// Existing SAI also casts 5968; this test deliberately does not assert one saber.
	closeChest(t, actor, guid)
	o.clean(t)
	for i := 0; i < 3; i++ {
		got := openChest(t, actor, guid, 3365)
		if !reflect.DeepEqual(got, first) {
			e2eharness.Assertf(t, "unclaimed figurine loot changed on reopen: %+v -> %+v", first, got)
		}
		o.unchanged(t, baseline)
		closeChest(t, actor, guid)
	}
	t.Log("PASS Cat Figurine summons on first opening; unclaimed loot survives without repeat summons")
}

func fillBackpack(t *testing.T, bot *e2eharness.ScenarioBot) {
	t.Helper()
	bot.Save(t)
	var bags, used int
	if err := bot.CharDB.QueryRow("SELECT COUNT(*) FROM character_inventory WHERE guid = ? AND bag = 0 AND slot BETWEEN 19 AND 22", bot.GUID).Scan(&bags); err != nil {
		e2eharness.HarnessFailf(t, "bag query: %v", err)
	}
	if bags != 0 {
		e2eharness.Preconditionf(t, "full-bag fixture expects a fresh character without equipped bags")
	}
	if err := bot.CharDB.QueryRow("SELECT COUNT(*) FROM character_inventory WHERE guid = ? AND bag = 0 AND slot BETWEEN 23 AND 38", bot.GUID).Scan(&used); err != nil {
		e2eharness.HarnessFailf(t, "backpack query: %v", err)
	}
	if used < 16 {
		if err := bot.World.SetTarget(0); err != nil {
			e2eharness.HarnessFailf(t, "clear item-command target: %v", err)
		}
		bot.FlushWorld(t)
		bot.GM(t, fmt.Sprintf(".additem 38 %d", 16-used)) // non-stackable Recruit's Shirt
		bot.FlushWorld(t)
	}
}

func assertBagFull(t *testing.T, bot *e2eharness.ScenarioBot, slot uint8) {
	t.Helper()
	ch := make(chan byte, 1)
	cancel := bot.World.AddPacketHook(func(op uint16, data []byte) {
		if op == 0x0112 && len(data) > 0 { // SMSG_INVENTORY_CHANGE_FAILURE
			select {
			case ch <- data[0]:
			default:
			}
		}
	})
	defer cancel()
	bot.LootTakeItem(t, slot)
	select {
	case reason := <-ch:
		if reason != 50 { // EQUIP_ERR_INVENTORY_FULL
			e2eharness.Preconditionf(t, "expected inventory-full error, got %d", reason)
		}
	case <-time.After(5 * time.Second):
		e2eharness.Assertf(t, "taking grave loot with full bags did not return inventory-full error")
	}
}

// Issues: https://github.com/azerothcore/azerothcore-wotlk/issues/24692
//
//	https://github.com/azerothcore/azerothcore-wotlk/issues/12433
func TestAC_24692_ShallowGraveLifecycle(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "loot", "issue", "serial"}, Runtime: "med", Category: "world/chests", Issue: 24692})
	for _, entry := range []uint32{128308, 128403} {
		t.Run(fmt.Sprint(entry), func(t *testing.T) {
			actor, mate, observer := chestBots(t)
			actor.SetLootMethod(t, client.LootMethodFreeForAll, 0, e2eharness.LootThresholdUncommon)
			actor.WaitLootMethod(t, client.LootMethodFreeForAll, 5*time.Second)
			fillBackpack(t, actor)
			o := observeSummons(t, observer, 7286, 7276)
			covered := false
			// Sample stock item loot and, for the trapped variant, a positive summon
			// roll. Money is now always present; an initially empty grave is not a fixture.
			for attempt := 0; attempt < 48 && !covered; attempt++ {
				sid := observer.SpawnGameObject(t, entry)
				if sid == 0 {
					e2eharness.Preconditionf(t, "cannot resolve grave spawn for cleanup")
				}
				guid := actor.WaitGameObject(t, entry, 10*time.Second)
				before := len(o.seen)
				first := openChest(t, actor, guid, 6247) // lock type 10, Opening (no text)
				o.watch(2 * time.Second)
				baseline := len(o.seen)
				if entry == 128308 && baseline != before {
					e2eharness.ConfirmedBugf(t, 24692, "inert grave summoned %d creatures", baseline-before)
				}
				if len(first.items) == 0 || (entry == 128403 && baseline == before) {
					closeChest(t, actor, guid)
					o.clean(t)
					observer.DespawnGameObjectSpawn(t, sid)
					waitChestGone(t, actor, guid)
					continue
				}
				assertBagFull(t, actor, first.items[0].Index)
				closeChest(t, actor, guid)
				o.clean(t)
				for reopen := 0; reopen < 6; reopen++ {
					looter := actor
					if reopen%2 == 1 {
						looter = mate
					}
					got := openChest(t, looter, guid, 6247)
					if !reflect.DeepEqual(got, first) {
						e2eharness.Assertf(t, "grave %d changed unclaimed loot: %+v -> %+v", entry, first, got)
					}
					closeChest(t, looter, guid)
					o.unchanged(t, baseline)
				}
				// A different player can still collect everything left by full bags.
				loot := openChest(t, mate, guid, 6247)
				for _, item := range loot.items {
					count := mate.InventoryCount(t, item.ItemID)
					mate.LootTakeItem(t, item.Index)
					mate.FlushWorld(t)
					if got := mate.InventoryCount(t, item.ItemID); got != count+int(item.Quantity) {
						e2eharness.Assertf(t, "grave %d item %d was not credited: %d -> %d", entry, item.ItemID, count, got)
					}
				}
				if loot.gold != 0 {
					if err := mate.World.SendPacketRaw(0x015E, nil); err != nil { // CMSG_LOOT_MONEY
						e2eharness.HarnessFailf(t, "loot grave money: %v", err)
					}
					mate.FlushWorld(t)
				}
				closeChest(t, mate, guid)
				waitChestGone(t, mate, guid)
				// A stale opening request must not produce another wave after consumption.
				castOpening(t, mate, guid, 6247)
				mate.FlushWorld(t)
				o.unchanged(t, baseline)
				covered = true
				observer.DespawnGameObjectSpawn(t, sid)
				waitChestGone(t, actor, guid)
				t.Logf("PASS grave %d initial summons=%d; six reopens and a consumed-GUID request added none", entry, baseline-before)
			}
			if !covered {
				e2eharness.Preconditionf(t, "48 fresh graves did not produce an item-loot fixture with the required active/inert behavior")
			}
		})
	}
}

func TestChests_IceChestGroupLoot(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "loot", "multi_bot", "serial"}, Runtime: "med", Category: "world/chests"})
	actor, mate, observer := chestBots(t)
	actor.SetLootMethod(t, client.LootMethodGroupLoot, 0, e2eharness.LootThresholdUncommon)
	actor.WaitLootMethod(t, client.LootMethodGroupLoot, 5*time.Second)
	o := observeSummons(t, observer, 26391)
	guid := spawnChest(t, observer, actor, 187892)
	waitActor, cancelActor := actor.ArmLootStartRoll()
	defer cancelActor()
	waitMate, cancelMate := mate.ArmLootStartRoll()
	defer cancelMate()
	before := len(o.seen)
	loot := openChest(t, actor, guid, 6247)
	var reward uint32
	for _, item := range loot.items {
		if item.ItemID >= 54801 && item.ItemID <= 54805 {
			reward = item.ItemID
		}
	}
	if reward == 0 {
		e2eharness.Assertf(t, "Ice Chest did not offer one of its guaranteed cloaks: %+v", loot.items)
	}
	roll, ok := waitActor(reward, 10*time.Second)
	if !ok {
		e2eharness.Assertf(t, "Ice Chest did not start a group roll for its epic reward")
	}
	otherRoll, ok := waitMate(roll.ItemID, 10*time.Second)
	if !ok || otherRoll.ItemGUID != roll.ItemGUID || otherRoll.ItemSlot != roll.ItemSlot {
		e2eharness.Assertf(t, "party members did not receive the same Ice Chest roll")
	}
	o.watch(time.Second)
	baseline := len(o.seen)
	if baseline-before != 1 {
		e2eharness.Assertf(t, "Ice Chest should summon its bunny on initial opening: got %d", baseline-before)
	}
	closeChest(t, actor, guid)
	openChest(t, mate, guid, 6247)
	closeChest(t, mate, guid)
	openChest(t, actor, guid, 6247)
	closeChest(t, actor, guid)
	o.unchanged(t, baseline)
	// The trap has a long stock cooldown; repeat-open observations here cannot
	// prove the once-per-generation guard by themselves. The reward is the oracle.
	count := actor.InventoryCount(t, roll.ItemID)
	won, _, cancel := actor.ArmLootRollOutcome(roll.ItemID)
	defer cancel()
	mate.RollGreed(t, roll)
	actor.RollNeed(t, roll)
	select {
	case result := <-won:
		if result.WinnerGUID != actor.GUID {
			e2eharness.Assertf(t, "Need did not beat Greed for Ice Chest item %d", roll.ItemID)
		}
	case <-time.After(10 * time.Second):
		e2eharness.Assertf(t, "Ice Chest roll did not resolve after both votes")
	}
	deadline := time.Now().Add(5 * time.Second)
	for actor.InventoryCount(t, roll.ItemID) != count+1 {
		if time.Now().After(deadline) {
			e2eharness.Assertf(t, "Ice Chest roll winner did not receive exactly one item %d", roll.ItemID)
		}
		time.Sleep(100 * time.Millisecond)
	}
	t.Logf("PASS Ice Chest first-open bunny, shared roll, second-player reopening and reward %d", roll.ItemID)
}
