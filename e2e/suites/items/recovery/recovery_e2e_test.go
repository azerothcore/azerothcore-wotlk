//go:build e2e

// Item recovery (recovery_item, .item restore): what destroying, selling and
// disenchanting record, and what a restore mails back.
//
// The realm needs ItemDelete.Method, ItemDelete.Vendor and ItemDelete.Disenchant
// set to 1, with the default ItemDelete.Quality (3) and ItemDelete.ItemLevel (80):
// every item used here passes those filters.
package recovery_test

import (
	"bytes"
	"database/sql"
	"encoding/binary"
	"fmt"
	"strconv"
	"strings"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	itemSocketedBracer = 37590 // Bands of Fading Light: rare BoE plate wrist, one blue socket
	itemSuffixBracer   = 44674 // Ichor-Stained Wraps: rare BoE cloth wrist with a random suffix
	itemSuffixCloak    = 31254 // Striderhide Cloak: rare BoE cloak rolling from 37 random suffixes
	itemScarletRuby    = 36918 // Scarlet Ruby: rare, stacks to 20, sells for 3g
	itemSolidSapphire  = 40008 // Solid Sky Sapphire: blue gem, matches the bracer's socket
	itemStrangeDust    = 10940 // reagent of Enchant Bracer - Minor Health
	itemRunedCopperRod = 6218  // enchanting rod the enchant requires as a tool

	spellEnchantBracerMinorHealth = 7418
	spellDisenchant               = 13262
	skillEnchanting               = 333

	creatureVendor = 18664 // Aged Dalaran Wizard: plain vendor, faction 35

	opDestroyItem = 0x111 // CMSG_DESTROYITEM
	opCastSpell   = 0x12E // CMSG_CAST_SPELL
	opSellItem    = 0x1A0 // CMSG_SELL_ITEM
	opBuybackItem = 0x290 // CMSG_BUYBACK_ITEM
	opSocketGems  = 0x347 // CMSG_SOCKET_GEMS
	opMessageChat = 0x096 // SMSG_MESSAGECHAT

	targetFlagItem = 0x10

	slotWrist         = 8
	buybackSlotStart  = 74
	maxEnchantSlots   = 12
	enchantFieldsSlot = 3 // id, duration, charges

	sourceDestroyed    = 0
	sourceVendored     = 1
	sourceDisenchanted = 2

	itemFlagSoulbound = 0x1
)

// Enchant slots a restore carries over: permanent, the three sockets, socket bonus, prismatic.
var restoredEnchantSlots = []int{0, 2, 3, 4, 5, 6}

type recoveryRow struct {
	ID               uint32
	ItemEntry        uint32
	ItemGuid         uint32
	Count            uint32
	Source           uint8
	Money            uint32
	RandomPropertyID int32
	Enchantments     string
	Bound            uint8
}

type itemInstance struct {
	GUID             uint32
	Entry            uint32
	Owner            uint32
	Flags            uint32
	Enchantments     string
	RandomPropertyID int32
}

func TestRecovery_DestroyRestoresItemAsItWas(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "items"}, Runtime: "med", Category: "items/recovery"})

	bot := newRecoveryBot(t, "RcDstr")
	requireRecoveryEnabled(t, bot)

	bot.Learn(t, spellEnchantBracerMinorHealth)
	bot.SetSkill(t, skillEnchanting, 450, 450)
	bot.AddItem(t, itemStrangeDust, 5)
	bot.AddItem(t, itemRunedCopperRod, 1)
	bracerBag, bracerSlot := bot.AddItemWait(t, itemSocketedBracer, 1)
	bot.AddItemWait(t, itemSolidSapphire, 1)
	persist(t, bot)

	bracer := itemGUIDsByEntry(t, bot, itemSocketedBracer, 1)[0]
	gem := itemGUIDsByEntry(t, bot, itemSolidSapphire, 1)[0]

	socketGem(t, bot, bracer, gem)
	if res := castOnItem(t, bot, spellEnchantBracerMinorHealth, bracer); !res.Success {
		e2eharness.Preconditionf(t, "Enchant Bracer - Minor Health failed: %s", e2eharness.SpellFailReasonName(res.FailReason))
	}

	// Equipping binds the BoE bracer, so the snapshot has to carry the bound state.
	if err := bot.World.AutoEquipItem(bracerBag, bracerSlot); err != nil {
		e2eharness.HarnessFailf(t, "AutoEquipItem: %v", err)
	}
	bot.WaitEquipped(t, itemSocketedBracer, 5*time.Second)
	persist(t, bot)

	original := waitItemInstance(t, bot, bracer, "enchanted, socketed and bound", func(ii itemInstance) bool {
		return enchantID(ii.Enchantments, 0) != 0 && enchantID(ii.Enchantments, 5) != 0 && ii.Flags&itemFlagSoulbound != 0
	})
	t.Logf("bracer guid=%d enchantments=%q flags=0x%X", original.GUID, original.Enchantments, original.Flags)

	destroyItem(t, bot, e2eharness.InventoryBagBackpack, slotWrist, 0)
	bracerRow := waitRecoveryRow(t, bot, original.GUID, "destroyed bracer")
	if bracerRow.Source != sourceDestroyed || bracerRow.Count != 1 || bracerRow.Bound != 1 {
		e2eharness.Assertf(t, "bracer row source=%d count=%d bound=%d, want 0/1/1", bracerRow.Source, bracerRow.Count, bracerRow.Bound)
	}
	assertSameEnchants(t, "recorded bracer", original.Enchantments, bracerRow.Enchantments)

	// Both copies share one rolled suffix from a 37-entry group; a restore that rerolled would have to land on it twice, about 0.4% of the time.
	bot.AddItem(t, itemSuffixCloak, 2)
	persist(t, bot)
	var cloaks []itemInstance
	var cloakRows []recoveryRow
	for _, guid := range itemGUIDsByEntry(t, bot, itemSuffixCloak, 2) {
		cloak := waitItemInstance(t, bot, guid, "random suffix rolled", func(ii itemInstance) bool {
			return ii.RandomPropertyID != 0
		})
		bag, slot := inventorySlot(t, bot, guid)
		destroyItem(t, bot, bag, slot, 0)
		row := waitRecoveryRow(t, bot, guid, "destroyed suffix cloak")
		if row.RandomPropertyID != cloak.RandomPropertyID {
			e2eharness.Assertf(t, "cloak row randomPropertyId=%d, item had %d", row.RandomPropertyID, cloak.RandomPropertyID)
		}
		cloaks = append(cloaks, cloak)
		cloakRows = append(cloakRows, row)
	}

	bot.GM(t, fmt.Sprintf(".item restore %d %s", bracerRow.ID, bot.Name))
	for _, row := range cloakRows {
		bot.GM(t, fmt.Sprintf(".item restore %d %s", row.ID, bot.Name))
	}

	restoredBracer := waitMailedItems(t, bot, itemSocketedBracer, 1)[0]
	assertSameEnchants(t, "restored bracer", original.Enchantments, restoredBracer.Enchantments)
	if restoredBracer.Flags&itemFlagSoulbound == 0 {
		e2eharness.Assertf(t, "restored bracer flags=0x%X, want soulbound", restoredBracer.Flags)
	}
	// Taking a soulbound item from the mail fails with EQUIP_ERR_DONT_OWN_THAT_ITEM unless it already belongs to the receiver
	if uint64(restoredBracer.Owner) != bot.GUID {
		e2eharness.Assertf(t, "restored bracer owner_guid=%d, want the receiver %d", restoredBracer.Owner, bot.GUID)
	}

	want := map[int32]int{}
	for _, cloak := range cloaks {
		want[cloak.RandomPropertyID]++
	}
	got := map[int32]int{}
	for _, cloak := range waitMailedItems(t, bot, itemSuffixCloak, len(cloaks)) {
		got[cloak.RandomPropertyID]++
	}
	for id, n := range want {
		if got[id] != n {
			e2eharness.Assertf(t, "restored cloak randomPropertyIds %v, originals %v", got, want)
		}
	}

	waitRecoveryRowGone(t, bot, bracerRow.ID)
	for _, row := range cloakRows {
		waitRecoveryRowGone(t, bot, row.ID)
	}
	t.Logf("PASS destroyed items restored with enchants %q, bound flag and randomPropertyIds %v",
		restoredBracer.Enchantments, got)
}

func TestRecovery_VendorRecordsPriceAndBuybackMatchesItem(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "items"}, Runtime: "med", Category: "items/recovery"})

	bot := newRecoveryBot(t, "RcVend")
	requireRecoveryEnabled(t, bot)
	bot.AddItem(t, itemSuffixBracer, 2)
	persist(t, bot)
	copies := itemGUIDsByEntry(t, bot, itemSuffixBracer, 2)
	first, second := copies[0], copies[1]
	vendor := bot.Spawn(t, creatureVendor, 15*time.Second)

	firstPaid := sellItem(t, bot, vendor, first, 0)
	secondPaid := sellItem(t, bot, vendor, second, 0)

	firstRow := waitRecoveryRow(t, bot, first, "first sold copy")
	secondRow := waitRecoveryRow(t, bot, second, "second sold copy")
	for _, c := range []struct {
		row  recoveryRow
		paid uint32
	}{{firstRow, firstPaid}, {secondRow, secondPaid}} {
		if c.row.Source != sourceVendored || c.row.Money != c.paid {
			e2eharness.Assertf(t, "row %d source=%d money=%d, want source=1 money=%d (copper received)",
				c.row.ID, c.row.Source, c.row.Money, c.paid)
		}
	}

	// The first sale sits in the first buyback slot. Buying it back must drop its own row only.
	sendRaw(t, bot, opBuybackItem, func(buf *bytes.Buffer) {
		writeLE(buf, vendor)
		writeLE(buf, uint32(buybackSlotStart))
	})
	waitRecoveryRowGone(t, bot, firstRow.ID)
	if _, ok := recoveryRowByID(t, bot, secondRow.ID); !ok {
		e2eharness.Assertf(t, "buying back copy guid=%d also deleted the row of copy guid=%d", first, second)
	}

	// The second copy is still in the buyback tab, so restoring it would duplicate it.
	chat := watchChat(t, bot)
	bot.GM(t, fmt.Sprintf(".item restore %d %s", secondRow.ID, bot.Name))
	bot.FlushWorld(t)
	if !chat.contains("buyback") {
		e2eharness.Assertf(t, "restoring row %d while the item is in buyback was not refused", secondRow.ID)
	}
	if _, ok := recoveryRowByID(t, bot, secondRow.ID); !ok {
		e2eharness.Assertf(t, "refused restore still deleted row %d", secondRow.ID)
	}
	if n := mailedItemCount(t, bot, itemSuffixBracer); n != 0 {
		e2eharness.Assertf(t, "refused restore mailed %d item(s)", n)
	}

	// The buyback tab does not survive a relog, after which the restore is allowed.
	bot.Relog(t)
	bot.GM(t, fmt.Sprintf(".item restore %d %s", secondRow.ID, bot.Name))
	waitMailedItems(t, bot, itemSuffixBracer, 1)
	waitRecoveryRowGone(t, bot, secondRow.ID)
	t.Logf("PASS vendor rows money=%d/%d, buyback dropped only its own row, in-buyback restore refused", firstPaid, secondPaid)
}

func TestRecovery_PartialStackRecordsOnlyRemovedCount(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "items"}, Runtime: "short", Category: "items/recovery"})

	bot := newRecoveryBot(t, "RcStak")
	requireRecoveryEnabled(t, bot)
	bag, slot := bot.AddItemWait(t, itemScarletRuby, 5)
	persist(t, bot)
	stack := itemGUIDsByEntry(t, bot, itemScarletRuby, 1)[0]
	vendor := bot.Spawn(t, creatureVendor, 15*time.Second)

	destroyItem(t, bot, bag, slot, 2)
	destroyed := waitRecoveryRow(t, bot, stack, "partly destroyed stack")
	if destroyed.Count != 2 || destroyed.Source != sourceDestroyed {
		e2eharness.Assertf(t, "destroy row count=%d source=%d, want 2/0", destroyed.Count, destroyed.Source)
	}

	// Selling part of a stack sells a clone, so its row is keyed on a new guid.
	paid := sellItem(t, bot, vendor, stack, 2)
	sold := waitRecoveryRowWhere(t, bot, "partly sold stack", func(r recoveryRow) bool {
		return r.ItemEntry == itemScarletRuby && r.Source == sourceVendored
	})
	if sold.Count != 2 || sold.Money != paid || sold.ItemGuid == stack {
		e2eharness.Assertf(t, "sell row count=%d money=%d itemGuid=%d, want count=2 money=%d and the clone's guid (not %d)",
			sold.Count, sold.Money, sold.ItemGuid, paid, stack)
	}

	persist(t, bot)
	pollOutcome(t, "one Scarlet Ruby left in the stack", func() bool {
		return bot.InventoryCountNoSave(t, itemScarletRuby) == 1
	})
	t.Logf("PASS partial destroy and sale each recorded count=2 (sale money=%d)", paid)
}

func TestRecovery_DisenchantRecordsLootedMaterials(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "items"}, Runtime: "med", Category: "items/recovery"})

	bot := newRecoveryBot(t, "RcDise")
	requireRecoveryEnabled(t, bot)
	bot.Learn(t, spellDisenchant)
	bot.SetSkill(t, skillEnchanting, 450, 450)

	bot.AddItem(t, itemSuffixBracer, 2)
	persist(t, bot)
	copies := itemGUIDsByEntry(t, bot, itemSuffixBracer, 2)

	// Loot everything: the row owes exactly what was taken.
	loot := disenchant(t, bot, copies[0])
	if len(loot) == 0 {
		e2eharness.Preconditionf(t, "disenchanting item guid=%d produced no loot", copies[0])
	}
	for _, item := range loot {
		bot.LootTakeItem(t, item.Index)
	}
	looted := waitRecoveryRow(t, bot, copies[0], "fully looted disenchant")
	if looted.Source != sourceDisenchanted {
		e2eharness.Assertf(t, "row %d source=%d, want 2", looted.ID, looted.Source)
	}
	want := map[uint32]uint32{}
	for _, item := range loot {
		want[item.ItemID] += item.Quantity
	}
	if got := recoveryLoot(t, bot, looted.ID); !sameLoot(got, want) {
		e2eharness.Assertf(t, "row %d loot=%v, looted %v", looted.ID, got, want)
	}

	// Close the window without looting: the item is still gone, and nothing is owed.
	untouched := disenchant(t, bot, copies[1])
	bot.LootRelease(t, e2eharness.ItemGUID(copies[1]))
	unlooted := waitRecoveryRow(t, bot, copies[1], "unlooted disenchant")
	if got := recoveryLoot(t, bot, unlooted.ID); len(got) != 0 {
		e2eharness.Assertf(t, "row %d loot=%v after releasing %v untaken, want none", unlooted.ID, got, untouched)
	}
	t.Logf("PASS disenchant rows: looted %v recorded, released-unlooted recorded none", want)
}

func newRecoveryBot(t *testing.T, prefix string) *e2eharness.ScenarioBot {
	t.Helper()
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        prefix,
		Race:          e2eharness.RaceHuman,
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	return bot
}

// persist relogs the bot: a GM .save does not reliably write newly changed items to CharDB, a logout always does.
func persist(t *testing.T, bot *e2eharness.ScenarioBot) {
	t.Helper()
	bot.Relog(t)
}

// requireRecoveryEnabled fails as a precondition when the realm records nothing at all.
func requireRecoveryEnabled(t *testing.T, bot *e2eharness.ScenarioBot) {
	t.Helper()
	chat := watchChat(t, bot)
	bot.GM(t, ".item restore list "+bot.Name)
	bot.FlushWorld(t)
	if chat.contains("disabled") {
		e2eharness.Preconditionf(t, ".item restore is disabled: set ItemDelete.Method, ItemDelete.Vendor and ItemDelete.Disenchant to 1")
	}
}

func itemGUIDsByEntry(t *testing.T, bot *e2eharness.ScenarioBot, entry uint32, want int) []uint32 {
	t.Helper()
	var guids []uint32
	found := poll(func() bool {
		rows, err := bot.CharDB.Query(`
			SELECT ci.item FROM character_inventory ci
			INNER JOIN item_instance ii ON ii.guid = ci.item
			WHERE ci.guid = ? AND ii.itemEntry = ? ORDER BY ci.item`, bot.GUID, entry)
		if err != nil {
			e2eharness.HarnessFailf(t, "inventory query: %v", err)
		}
		defer rows.Close()
		guids = guids[:0]
		for rows.Next() {
			var g uint32
			if err := rows.Scan(&g); err != nil {
				e2eharness.HarnessFailf(t, "inventory scan: %v", err)
			}
			guids = append(guids, g)
		}
		return len(guids) >= want
	})
	if !found {
		e2eharness.Preconditionf(t, "timed out waiting for %d item(s) of entry %d in CharDB, found %v", want, entry, guids)
	}
	return guids
}

func loadItemInstance(t *testing.T, db *sql.DB, query string, args ...any) (itemInstance, bool) {
	t.Helper()
	var ii itemInstance
	err := db.QueryRow(query, args...).Scan(&ii.GUID, &ii.Entry, &ii.Owner, &ii.Flags, &ii.Enchantments, &ii.RandomPropertyID)
	if err == sql.ErrNoRows {
		return ii, false
	}
	if err != nil {
		e2eharness.HarnessFailf(t, "item_instance query: %v", err)
	}
	return ii, true
}

func waitItemInstance(t *testing.T, bot *e2eharness.ScenarioBot, guid uint32, what string, ok func(itemInstance) bool) itemInstance {
	t.Helper()
	var ii itemInstance
	done := poll(func() bool {
		var found bool
		ii, found = loadItemInstance(t, bot.CharDB,
			`SELECT guid, itemEntry, owner_guid, flags, enchantments, randomPropertyId FROM item_instance WHERE guid = ?`, guid)
		return found && ok(ii)
	})
	if !done {
		e2eharness.Preconditionf(t, "timed out waiting for item guid=%d %s, last seen %+v", guid, what, ii)
	}
	return ii
}

func waitMailedItems(t *testing.T, bot *e2eharness.ScenarioBot, entry uint32, want int) []itemInstance {
	t.Helper()
	var items []itemInstance
	pollOutcome(t, fmt.Sprintf("restore mail with %d item(s) of entry %d", want, entry), func() bool {
		rows, err := bot.CharDB.Query(`
			SELECT ii.guid, ii.itemEntry, ii.owner_guid, ii.flags, ii.enchantments, ii.randomPropertyId
			FROM mail_items mi INNER JOIN item_instance ii ON ii.guid = mi.item_guid
			WHERE mi.receiver = ? AND ii.itemEntry = ? ORDER BY ii.guid`, bot.GUID, entry)
		if err != nil {
			e2eharness.HarnessFailf(t, "mail_items query: %v", err)
		}
		defer rows.Close()
		items = items[:0]
		for rows.Next() {
			var ii itemInstance
			if err := rows.Scan(&ii.GUID, &ii.Entry, &ii.Owner, &ii.Flags, &ii.Enchantments, &ii.RandomPropertyID); err != nil {
				e2eharness.HarnessFailf(t, "mail_items scan: %v", err)
			}
			items = append(items, ii)
		}
		return len(items) >= want
	})
	return items
}

// inventorySlot returns the packet bag/slot of an item in the character's own slots.
func inventorySlot(t *testing.T, bot *e2eharness.ScenarioBot, itemGUID uint32) (bag, slot uint8) {
	t.Helper()
	var container uint32
	if err := bot.CharDB.QueryRow(`SELECT bag, slot FROM character_inventory WHERE item = ?`, itemGUID).Scan(&container, &slot); err != nil {
		e2eharness.Preconditionf(t, "inventory slot of item guid=%d: %v", itemGUID, err)
	}
	if container != 0 {
		e2eharness.Preconditionf(t, "item guid=%d is inside bag guid=%d, want the backpack", itemGUID, container)
	}
	return e2eharness.InventoryBagBackpack, slot
}

func mailedItemCount(t *testing.T, bot *e2eharness.ScenarioBot, entry uint32) int {
	t.Helper()
	var n int
	err := bot.CharDB.QueryRow(`
		SELECT COUNT(*) FROM mail_items mi INNER JOIN item_instance ii ON ii.guid = mi.item_guid
		WHERE mi.receiver = ? AND ii.itemEntry = ?`, bot.GUID, entry).Scan(&n)
	if err != nil {
		e2eharness.HarnessFailf(t, "mail_items query: %v", err)
	}
	return n
}

const recoveryColumns = `Id, ItemEntry, ItemGuid, Count, Source, Money, RandomPropertyId, Enchantments, Bound`

func scanRecoveryRows(t *testing.T, rows *sql.Rows) []recoveryRow {
	t.Helper()
	defer rows.Close()
	var out []recoveryRow
	for rows.Next() {
		var r recoveryRow
		if err := rows.Scan(&r.ID, &r.ItemEntry, &r.ItemGuid, &r.Count, &r.Source, &r.Money, &r.RandomPropertyID, &r.Enchantments, &r.Bound); err != nil {
			e2eharness.HarnessFailf(t, "recovery_item scan: %v", err)
		}
		out = append(out, r)
	}
	return out
}

func recoveryRows(t *testing.T, bot *e2eharness.ScenarioBot) []recoveryRow {
	t.Helper()
	rows, err := bot.CharDB.Query(`SELECT `+recoveryColumns+` FROM recovery_item WHERE Guid = ? ORDER BY Id`, bot.GUID)
	if err != nil {
		e2eharness.HarnessFailf(t, "recovery_item query: %v", err)
	}
	return scanRecoveryRows(t, rows)
}

func recoveryRowByID(t *testing.T, bot *e2eharness.ScenarioBot, id uint32) (recoveryRow, bool) {
	t.Helper()
	for _, r := range recoveryRows(t, bot) {
		if r.ID == id {
			return r, true
		}
	}
	return recoveryRow{}, false
}

func waitRecoveryRowWhere(t *testing.T, bot *e2eharness.ScenarioBot, what string, match func(recoveryRow) bool) recoveryRow {
	t.Helper()
	var row recoveryRow
	pollOutcome(t, "recovery_item row for "+what+" (needs ItemDelete.Method/Vendor/Disenchant = 1)", func() bool {
		for _, r := range recoveryRows(t, bot) {
			if match(r) {
				row = r
				return true
			}
		}
		return false
	})
	t.Logf("recovery row %s: %+v", what, row)
	return row
}

func waitRecoveryRow(t *testing.T, bot *e2eharness.ScenarioBot, itemGUID uint32, what string) recoveryRow {
	t.Helper()
	return waitRecoveryRowWhere(t, bot, what, func(r recoveryRow) bool { return r.ItemGuid == itemGUID })
}

func waitRecoveryRowGone(t *testing.T, bot *e2eharness.ScenarioBot, id uint32) {
	t.Helper()
	pollOutcome(t, fmt.Sprintf("recovery row %d deleted", id), func() bool {
		_, ok := recoveryRowByID(t, bot, id)
		return !ok
	})
}

func recoveryLoot(t *testing.T, bot *e2eharness.ScenarioBot, id uint32) map[uint32]uint32 {
	t.Helper()
	rows, err := bot.CharDB.Query(`SELECT ItemEntry, Count FROM recovery_item_loot WHERE RecoveryId = ?`, id)
	if err != nil {
		e2eharness.HarnessFailf(t, "recovery_item_loot query: %v", err)
	}
	defer rows.Close()
	out := map[uint32]uint32{}
	for rows.Next() {
		var entry, count uint32
		if err := rows.Scan(&entry, &count); err != nil {
			e2eharness.HarnessFailf(t, "recovery_item_loot scan: %v", err)
		}
		out[entry] = count
	}
	return out
}

func sameLoot(a, b map[uint32]uint32) bool {
	if len(a) != len(b) {
		return false
	}
	for k, v := range a {
		if b[k] != v {
			return false
		}
	}
	return true
}

// enchantID reads one slot's enchant id from an item_instance.enchantments string.
func enchantID(enchantments string, slot int) uint32 {
	tokens := strings.Fields(enchantments)
	if len(tokens) != maxEnchantSlots*enchantFieldsSlot {
		return 0
	}
	v, _ := strconv.ParseUint(tokens[slot*enchantFieldsSlot], 10, 32)
	return uint32(v)
}

func assertSameEnchants(t *testing.T, what, want, got string) {
	t.Helper()
	for _, slot := range restoredEnchantSlots {
		if w, g := enchantID(want, slot), enchantID(got, slot); w != g {
			e2eharness.Assertf(t, "%s enchant slot %d = %d, original %d (original %q, got %q)", what, slot, g, w, want, got)
		}
	}
}

func destroyItem(t *testing.T, bot *e2eharness.ScenarioBot, bag, slot, count uint8) {
	t.Helper()
	sendRaw(t, bot, opDestroyItem, func(buf *bytes.Buffer) {
		buf.Write([]byte{bag, slot, count, 0, 0, 0})
	})
}

// sellItem sells count of the item (0 = whole stack) and returns the copper received.
func sellItem(t *testing.T, bot *e2eharness.ScenarioBot, vendor uint64, itemGUID uint32, count uint32) uint32 {
	t.Helper()
	before := bot.PlayerMoney()
	sendRaw(t, bot, opSellItem, func(buf *bytes.Buffer) {
		writeLE(buf, vendor)
		writeLE(buf, e2eharness.ItemGUID(itemGUID))
		writeLE(buf, count)
	})
	var after uint32
	if !poll(func() bool {
		after = bot.PlayerMoney()
		return after > before
	}) {
		e2eharness.Preconditionf(t, "selling item guid=%d paid nothing (money %d -> %d)", itemGUID, before, after)
	}
	return after - before
}

func socketGem(t *testing.T, bot *e2eharness.ScenarioBot, itemGUID, gemGUID uint32) {
	t.Helper()
	sendRaw(t, bot, opSocketGems, func(buf *bytes.Buffer) {
		writeLE(buf, e2eharness.ItemGUID(itemGUID))
		writeLE(buf, e2eharness.ItemGUID(gemGUID))
		writeLE(buf, uint64(0))
		writeLE(buf, uint64(0))
	})
}

func castOnItem(t *testing.T, bot *e2eharness.ScenarioBot, spellID, itemGUID uint32) e2eharness.SpellCastResult {
	t.Helper()
	bot.ArmSpellWaiter()
	sendRaw(t, bot, opCastSpell, func(buf *bytes.Buffer) {
		buf.WriteByte(0) // cast count
		writeLE(buf, spellID)
		buf.WriteByte(0) // cast flags
		writeLE(buf, uint32(targetFlagItem))
		writePackedGUID(buf, e2eharness.ItemGUID(itemGUID))
	})
	res, err := bot.WaitSpellID(spellID, 15*time.Second)
	if err != nil {
		e2eharness.HarnessFailf(t, "spell %d on item guid=%d: %v", spellID, itemGUID, err)
	}
	return res
}

// disenchant casts Disenchant on the item and returns the loot window it opens.
func disenchant(t *testing.T, bot *e2eharness.ScenarioBot, itemGUID uint32) []client.LootItem {
	t.Helper()
	lootGUID := e2eharness.ItemGUID(itemGUID)
	opened := make(chan []client.LootItem, 1)
	cancel := bot.World.AddLootOpenedHook(func(g uint64, items []client.LootItem) {
		if g == lootGUID {
			select {
			case opened <- items:
			default:
			}
		}
	})
	defer cancel()

	if res := castOnItem(t, bot, spellDisenchant, itemGUID); !res.Success {
		e2eharness.Preconditionf(t, "Disenchant on item guid=%d failed: %s", itemGUID, e2eharness.SpellFailReasonName(res.FailReason))
	}
	select {
	case items := <-opened:
		t.Logf("disenchant loot for item guid=%d: %+v", itemGUID, items)
		return items
	case <-time.After(10 * time.Second):
		e2eharness.HarnessFailf(t, "no loot window after disenchanting item guid=%d", itemGUID)
		return nil
	}
}

type chatWatch struct {
	mu   sync.Mutex
	text [][]byte
}

// watchChat records SMSG_MESSAGECHAT payloads until the test ends, for GM command replies.
func watchChat(t *testing.T, bot *e2eharness.ScenarioBot) *chatWatch {
	w := &chatWatch{}
	t.Cleanup(bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != opMessageChat {
			return
		}
		w.mu.Lock()
		w.text = append(w.text, append([]byte(nil), data...))
		w.mu.Unlock()
	}))
	return w
}

func (w *chatWatch) contains(s string) bool {
	w.mu.Lock()
	defer w.mu.Unlock()
	for _, msg := range w.text {
		if bytes.Contains(bytes.ToLower(msg), []byte(strings.ToLower(s))) {
			return true
		}
	}
	return false
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

func writePackedGUID(buf *bytes.Buffer, guid uint64) {
	var mask byte
	var packed []byte
	for i := 0; i < 8; i++ {
		if b := byte(guid >> (8 * i)); b != 0 {
			mask |= 1 << i
			packed = append(packed, b)
		}
	}
	buf.WriteByte(mask)
	buf.Write(packed)
}

// poll retries ok until it holds or 20s pass, since saves and recovery deletes reach the DB asynchronously.
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
