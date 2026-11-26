//go:build e2e

// Item refunds: an item bought for an extended cost keeps an item_refund_instance
// row only while it can still be refunded.
package refund_test

import (
	"bytes"
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
	creatureVendor        = 23245 // Aether-tech Master: faction 35 vendor of the Ogri'la Apexis items
	itemAcceleratorModule = 32759 // sold for ExtendedCost 1910 (35 Apexis Shards), flagged ITEM_FLAG_ITEM_PURCHASE_RECORD
	itemApexisShard       = 32569
	apexisShardCost       = 35

	opDestroyItem      = 0x111 // CMSG_DESTROYITEM
	opListInventory    = 0x19E // CMSG_LIST_INVENTORY
	opListInventoryRes = 0x19F // SMSG_LIST_INVENTORY
	opBuyItem          = 0x1A2 // CMSG_BUY_ITEM
	opBuyFailed        = 0x1A5 // SMSG_BUY_FAILED

	charDeleteSuccess = 0x47
)

func TestRefund_DestroyDeletesRefundRow(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "items"}, Runtime: "short", Category: "items/refund"})

	bot := newRefundBot(t, "RfDstr")
	item, bag, slot := buyRefundable(t, bot)

	sendRaw(t, bot, opDestroyItem, func(buf *bytes.Buffer) {
		buf.Write([]byte{bag, slot, 0, 0, 0, 0})
	})
	bot.FlushWorld(t)

	pollOutcome(t, fmt.Sprintf("refund row of destroyed item guid=%d deleted", item), func() bool {
		return !refundRowExists(t, bot, item)
	})
	t.Logf("PASS destroying refundable item guid=%d deleted its item_refund_instance row", item)
}

func TestRefund_CharacterDeleteDeletesRefundRows(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "items"}, Runtime: "short", Category: "items/refund"})

	bot := newRefundBot(t, "RfDelC")
	item, _, _ := buyRefundable(t, bot)
	owner := uint32(bot.GUID)

	_ = bot.World.SendLogout()
	if err := bot.World.WaitForLogout(30 * time.Second); err != nil {
		e2eharness.HarnessFailf(t, "logout before character delete: %v", err)
	}

	result := make(chan byte, 1)
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode == client.SmsgCharDelete && len(data) > 0 {
			select {
			case result <- data[0]:
			default:
			}
		}
	})
	defer cancel()

	if err := bot.World.DeleteCharacter(bot.GUID); err != nil {
		e2eharness.HarnessFailf(t, "send character delete: %v", err)
	}
	select {
	case code := <-result:
		if code != charDeleteSuccess {
			e2eharness.Preconditionf(t, "character delete answered 0x%X, want CHAR_DELETE_SUCCESS (0x47)", code)
		}
	case <-time.After(15 * time.Second):
		e2eharness.HarnessFailf(t, "no SMSG_CHAR_DELETE for guid=%d", owner)
	}

	removed := poll(func() bool {
		var n int
		if err := bot.CharDB.QueryRow(`SELECT COUNT(*) FROM characters WHERE guid = ?`, owner).Scan(&n); err != nil {
			e2eharness.HarnessFailf(t, "characters query: %v", err)
		}
		return n == 0
	})
	if !removed {
		e2eharness.Preconditionf(t, "character guid=%d still in characters: the realm needs CharDelete.Method = 0", owner)
	}
	pollOutcome(t, fmt.Sprintf("refund rows of deleted character guid=%d deleted", owner), func() bool {
		var n int
		if err := bot.CharDB.QueryRow(`SELECT COUNT(*) FROM item_refund_instance WHERE player_guid = ?`, owner).Scan(&n); err != nil {
			e2eharness.HarnessFailf(t, "item_refund_instance query: %v", err)
		}
		return n == 0
	})
	t.Logf("PASS deleting character guid=%d deleted the refund row of item guid=%d", owner, item)
}

func newRefundBot(t *testing.T, prefix string) *e2eharness.ScenarioBot {
	t.Helper()
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: prefix,
		Race:   e2eharness.RaceHuman,
		Class:  e2eharness.ClassWarrior,
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	return bot
}

// buyRefundable buys one Accelerator Module and returns its item guid and bag/slot once its refund row is stored.
func buyRefundable(t *testing.T, bot *e2eharness.ScenarioBot) (item uint32, bag, slot uint8) {
	t.Helper()
	bot.AddItemWait(t, itemApexisShard, apexisShardCost)
	vendor := bot.Spawn(t, creatureVendor, 15*time.Second)
	vendorSlot := vendorSlotOf(t, bot, vendor, itemAcceleratorModule)

	failed := make(chan []byte, 1)
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode == opBuyFailed {
			select {
			case failed <- append([]byte(nil), data...):
			default:
			}
		}
	})
	defer cancel()

	bot.ArmAllWaiters()
	bot.DrainItemPushes()
	sendRaw(t, bot, opBuyItem, func(buf *bytes.Buffer) {
		writeLE(buf, vendor)
		writeLE(buf, uint32(itemAcceleratorModule))
		writeLE(buf, vendorSlot)
		writeLE(buf, uint32(1))
		buf.WriteByte(0)
	})
	push, err := bot.WaitItemPushEntry(itemAcceleratorModule, 10*time.Second)
	if err != nil {
		select {
		case data := <-failed:
			e2eharness.Preconditionf(t, "buying the Accelerator Module failed: SMSG_BUY_FAILED %X", data)
		default:
		}
		e2eharness.Preconditionf(t, "buying the Accelerator Module stored no item: %v", err)
	}
	if push.ItemSlot > 0xFF {
		e2eharness.Preconditionf(t, "bought Accelerator Module landed in bag=%d slot=%d", push.BagSlot, push.ItemSlot)
	}

	owner := uint32(bot.GUID)
	stored := poll(func() bool {
		err := bot.CharDB.QueryRow(`SELECT item_guid FROM item_refund_instance WHERE player_guid = ?`, owner).Scan(&item)
		return err == nil
	})
	if !stored {
		e2eharness.Preconditionf(t, "no item_refund_instance row for the Accelerator Module bought by guid=%d", owner)
	}
	t.Logf("bought Accelerator Module guid=%d bag=%d slot=%d", item, push.BagSlot, push.ItemSlot)
	return item, push.BagSlot, uint8(push.ItemSlot)
}

// vendorSlotOf returns the 1-based vendor slot SMSG_LIST_INVENTORY gives the item.
func vendorSlotOf(t *testing.T, bot *e2eharness.ScenarioBot, vendor uint64, entry uint32) uint32 {
	t.Helper()
	list := make(chan []byte, 1)
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode == opListInventoryRes {
			select {
			case list <- append([]byte(nil), data...):
			default:
			}
		}
	})
	defer cancel()

	sendRaw(t, bot, opListInventory, func(buf *bytes.Buffer) {
		writeLE(buf, vendor)
	})
	var data []byte
	select {
	case data = <-list:
	case <-time.After(10 * time.Second):
		e2eharness.Preconditionf(t, "vendor 0x%X sent no SMSG_LIST_INVENTORY", vendor)
	}

	// guid, count, then per item: slot, entry, display, stock, price, durability, buy count, extended cost
	const header, row = 9, 32
	if len(data) < header {
		e2eharness.HarnessFailf(t, "SMSG_LIST_INVENTORY too short: %d bytes", len(data))
	}
	count := int(data[8])
	for i := 0; i < count && header+(i+1)*row <= len(data); i++ {
		r := data[header+i*row:]
		if binary.LittleEndian.Uint32(r[4:]) == entry {
			return binary.LittleEndian.Uint32(r[0:])
		}
	}
	e2eharness.Preconditionf(t, "vendor %d does not list item %d", creatureVendor, entry)
	return 0
}

func refundRowExists(t *testing.T, bot *e2eharness.ScenarioBot, item uint32) bool {
	t.Helper()
	var n int
	if err := bot.CharDB.QueryRow(`SELECT COUNT(*) FROM item_refund_instance WHERE item_guid = ?`, item).Scan(&n); err != nil {
		e2eharness.HarnessFailf(t, "item_refund_instance query: %v", err)
	}
	return n > 0
}

func sendRaw(t *testing.T, bot *e2eharness.ScenarioBot, opcode uint16, build func(*bytes.Buffer)) {
	t.Helper()
	buf := new(bytes.Buffer)
	build(buf)
	if err := bot.World.SendPacketRaw(opcode, buf.Bytes()); err != nil {
		e2eharness.HarnessFailf(t, "send opcode 0x%X: %v", opcode, err)
	}
}

func writeLE(buf *bytes.Buffer, v any) {
	_ = binary.Write(buf, binary.LittleEndian, v)
}

// poll retries ok for 20s, since refund rows are written and deleted on the async DB queue.
func poll(ok func() bool) bool {
	deadline := time.Now().Add(20 * time.Second)
	for time.Now().Before(deadline) {
		if ok() {
			return true
		}
		time.Sleep(100 * time.Millisecond)
	}
	return false
}

func pollOutcome(t *testing.T, what string, ok func() bool) {
	t.Helper()
	if !poll(ok) {
		e2eharness.Assertf(t, "timed out waiting for %s", what)
	}
}
