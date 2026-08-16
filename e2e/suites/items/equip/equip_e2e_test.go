//go:build e2e

package equip_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
)

// EQUIP-01: add+inventory oracle (EquipEntry is EQUIP-04).
func TestEquip_AddItemInventorySeed(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "items"}, Runtime: "short", Category: "items/equip"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "EqBasic",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.AddItemWait(t, e2eharness.ItemTargetDummy, 1)
	waitInventoryAtLeast(t, bot, e2eharness.ItemTargetDummy, 1)
	t.Logf("PASS add item inventory seed")
}

// EQUIP-02: AddItemWait returns bag/slot.
func TestEquip_AddItemWaitSlot(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "items"}, Runtime: "short", Category: "items/equip"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "EqSlot",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bag, slot := bot.AddItemWait(t, e2eharness.ItemTargetDummy, 1)
	bot.AssertInventoryAtLeast(t, e2eharness.ItemTargetDummy, 1)
	t.Logf("PASS AddItemWait bag=%d slot=%d inventory>=1", bag, slot)
}

// EQUIP-03: multiple adds without crash.
func TestEquip_MultipleAddsNoCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "items"}, Runtime: "short", Category: "items/equip"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "EqMulti",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	for i := 0; i < 3; i++ {
		bot.AddItem(t, e2eharness.ItemTargetDummy, 1)
	}
	bot.Save(t)
	bot.AssertWorldAlive(t)
	t.Logf("PASS multiple item adds")
}

// EQUIP-04: equip entry helper on a simple weapon if available via GM add+equip.
func TestEquip_EquipEntryHelper(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "items"}, Runtime: "short", Category: "items/equip"})

	const itemWornShortsword = 25 // Worn Shortsword, main-hand slot 15

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "EqWep",
		Class:  e2eharness.ClassWarrior,
		Level:  10,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.EquipEntry(t, itemWornShortsword, 1)
	slot := bot.WaitEquipped(t, itemWornShortsword, 5*time.Second)
	t.Logf("PASS EquipEntry helper worn entry=%d visible slot=%d", itemWornShortsword, slot)
}

// EQUIP-05: bag seed + relog inventory path stays healthy.
func TestEquip_ItemSurvivesRelogPath(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "items", "protocol"}, Runtime: "short", Category: "items/equip"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "EqRelog",
		Level:  80,
	})
	// AddItem is fire-and-forget; CharDB after an immediate .save often still
	// reads 0 on a fast runner. Wait for the push, then poll the persisted count.
	bot.AddItemWait(t, e2eharness.ItemTargetDummy, 2)
	waitInventoryAtLeast(t, bot, e2eharness.ItemTargetDummy, 2)
	bot.Relog(t)
	bot.AssertWorldAlive(t)
	// Inventory should still be present after relog (CharDB / load path).
	bot.AssertInventoryAtLeast(t, e2eharness.ItemTargetDummy, 2)
	t.Logf("PASS item seed + relog inventory persists")
}

// waitInventoryAtLeast polls CharDB (InventoryCount Saves) until count >= min.
func waitInventoryAtLeast(t *testing.T, bot *e2eharness.ScenarioBot, entry uint32, least int) {
	t.Helper()
	deadline := time.Now().Add(5 * time.Second)
	var got int
	for time.Now().Before(deadline) {
		got = bot.InventoryCount(t, entry)
		if got >= least {
			return
		}
		time.Sleep(100 * time.Millisecond)
	}
	e2eharness.Preconditionf(t, "inventory entry=%d count=%d want>=%d", entry, got, least)
}
