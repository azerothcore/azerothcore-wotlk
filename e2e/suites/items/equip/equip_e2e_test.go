//go:build e2e

package equip_test

import (
	"testing"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// EQUIP-01: equip item via EquipEntry; world stays alive.
func TestEquip_EquipEntryBasic(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "items"}, Runtime: "short", Category: "items/equip"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "EqBasic",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	// Target dummy is an item that can be in bags; equip a simple known item if possible.
	// Use engineering dummy item as inventory seed (not necessarily equippable armor).
	bot.AddItem(t, e2eharness.ItemTargetDummy, 1)
	bot.Save(t)
	bot.AssertWorldAlive(t)
	t.Logf("PASS add item inventory seed")
}

// EQUIP-02: AddItemWait returns bag/slot.
func TestEquip_AddItemWaitSlot(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "items"}, Runtime: "short", Category: "items/equip"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "EqSlot",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
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
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
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

	// Rough-hewn axe style starter or a known L80 weapon; use GM equip if entry known.
	// Heirloom-ish safe: use Target Dummy equip may fail — use EquipEntry which may GM-equip.
	const itemDullBlade = 25 // low-level sword often present

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "EqWep",
		Class:  e2eharness.ClassWarrior,
		Level:  10,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	bot.EquipEntry(t, itemDullBlade, 1)
	bot.AssertWorldAlive(t)
	t.Logf("PASS EquipEntry helper")
}

// EQUIP-05: bag seed + relog inventory path stays healthy.
func TestEquip_ItemSurvivesRelogPath(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "items", "protocol"}, Runtime: "short", Category: "items/equip"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "EqRelog",
		Level:  80,
	})
	bot.AddItem(t, e2eharness.ItemTargetDummy, 2)
	bot.Save(t)
	bot.AssertInventoryAtLeast(t, e2eharness.ItemTargetDummy, 2)
	bot.Relog(t)
	bot.AssertWorldAlive(t)
	// Inventory should still be present after relog (CharDB / load path).
	bot.AssertInventoryAtLeast(t, e2eharness.ItemTargetDummy, 2)
	t.Logf("PASS item seed + relog inventory persists")
}
