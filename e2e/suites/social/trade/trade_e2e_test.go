//go:build e2e

package trade_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// Cheap stackable trade bait (Linen Cloth).
const itemLinenCloth uint32 = 2589

func tradePair(t *testing.T, prefix string) (a, b *e2eharness.ScenarioBot) {
	t.Helper()
	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: prefix,
		Bots: []e2eharness.BotSpec{
			{Role: "trader_a", Level: 20},
			{Role: "trader_b", Level: 20},
		},
	})
	a = e2eharness.ByRole(t, bots, "trader_a")
	b = e2eharness.ByRole(t, bots, "trader_b")
	// Place both tightly (TRADE_DISTANCE) and combatstop — pad leftovers aggro trades.
	pad := e2eharness.PackagePad(t)
	a.Teleport(t, pad.X, pad.Y, pad.Z, pad.Map)
	b.Teleport(t, pad.X+1.5, pad.Y, pad.Z, pad.Map)
	a.CombatStop(t)
	b.CombatStop(t)
	return a, b
}

// Spec 1 — Item + gold dual-accept.
func TestTrade_ItemGoldDualAcceptInventories(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "trade", "multi_bot"}, Runtime: "short", Category: "social/trade"})

	a, b := tradePair(t, "TrdOK")
	const goldOffer uint32 = 5000

	a.CombatStop(t)
	b.CombatStop(t)
	a.SetMoney(t, 50_000)
	b.SetMoney(t, 10_000)
	// CharDB oracle — live PLAYER_FIELD_COINAGE often lags under pad combat noise.
	a.AssertMoneyAtLeast(t, 50_000)
	b.AssertMoneyAtLeast(t, 10_000)
	bag, slot := a.AddItemWait(t, itemLinenCloth, 1)

	aCount0 := a.InventoryCount(t, itemLinenCloth)
	bCount0 := b.InventoryCount(t, itemLinenCloth)
	aMoney0 := a.MoneyAfterSave(t)
	bMoney0 := b.MoneyAfterSave(t)

	e2eharness.OpenTrade(t, a, b)
	a.SetTradeItem(t, 0, bag, slot)
	a.SetTradeGold(t, goldOffer)
	e2eharness.CompleteTrade(t, a, b)

	aCount1 := a.InventoryCount(t, itemLinenCloth)
	bCount1 := b.InventoryCount(t, itemLinenCloth)
	aMoney1 := a.MoneyAfterSave(t)
	bMoney1 := b.MoneyAfterSave(t)

	if aCount1 != aCount0-1 {
		e2eharness.Assertf(t, "A linen count %d→%d want -1", aCount0, aCount1)
	}
	if bCount1 != bCount0+1 {
		e2eharness.Assertf(t, "B linen count %d→%d want +1", bCount0, bCount1)
	}
	// Money: A loses goldOffer, B gains goldOffer (tight bound after MoneyAfterSave).
	const moneyTol int64 = 100
	if int64(aMoney0)-int64(aMoney1) < int64(goldOffer)-moneyTol || int64(aMoney0)-int64(aMoney1) > int64(goldOffer)+moneyTol {
		e2eharness.Assertf(t, "A money %d→%d want −%d (±%d)", aMoney0, aMoney1, goldOffer, moneyTol)
	}
	if int64(bMoney1)-int64(bMoney0) < int64(goldOffer)-moneyTol || int64(bMoney1)-int64(bMoney0) > int64(goldOffer)+moneyTol {
		e2eharness.Assertf(t, "B money %d→%d want +%d (±%d)", bMoney0, bMoney1, goldOffer, moneyTol)
	}
	a.AssertWorldAlive(t)
	b.AssertWorldAlive(t)
	t.Logf("PASS dual-accept item+gold a_linen=%d→%d b_linen=%d→%d a$=%d→%d b$=%d→%d",
		aCount0, aCount1, bCount0, bCount1, aMoney0, aMoney1, bMoney0, bMoney1)
}

// Spec 2 — Cancel mid-trade restores inventories.
func TestTrade_CancelMidTradeRestores(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "trade", "multi_bot"}, Runtime: "short", Category: "social/trade"})

	a, b := tradePair(t, "TrdCan")
	bag, slot := a.AddItemWait(t, itemLinenCloth, 1)
	a.SetMoney(t, 20_000)
	b.SetMoney(t, 5_000)

	aCount0 := a.InventoryCount(t, itemLinenCloth)
	bCount0 := b.InventoryCount(t, itemLinenCloth)
	aMoney0 := a.MoneyAfterSave(t)
	bMoney0 := b.MoneyAfterSave(t)

	e2eharness.OpenTrade(t, a, b)
	a.SetTradeItem(t, 0, bag, slot)
	a.SetTradeGold(t, 1000)
	a.CancelTrade(t)
	_ = a.WaitTradeCancelled(t, 10*time.Second)
	// B should also observe cancel/close (no fixed settle sleep).
	_ = b.WaitTradeCancelled(t, 10*time.Second)

	aCount1 := a.InventoryCount(t, itemLinenCloth)
	bCount1 := b.InventoryCount(t, itemLinenCloth)
	aMoney1 := a.MoneyAfterSave(t)
	bMoney1 := b.MoneyAfterSave(t)
	if aCount1 != aCount0 || bCount1 != bCount0 {
		e2eharness.Assertf(t, "inventory changed after cancel A %d→%d B %d→%d", aCount0, aCount1, bCount0, bCount1)
	}
	if aMoney1 != aMoney0 || bMoney1 != bMoney0 {
		e2eharness.Assertf(t, "money changed after cancel A %d→%d B %d→%d", aMoney0, aMoney1, bMoney0, bMoney1)
	}
	a.AssertWorldAlive(t)
	t.Logf("PASS cancel restores inventories")
}

// Spec 3 — Move OOR mid-trade aborts cleanly.
func TestTrade_MoveOorMidTradeAborts(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "trade", "multi_bot", "issue"}, Runtime: "short", Category: "social/trade"})

	a, b := tradePair(t, "TrdOOR")
	bag, slot := a.AddItemWait(t, itemLinenCloth, 1)
	aCount0 := a.InventoryCount(t, itemLinenCloth)
	bCount0 := b.InventoryCount(t, itemLinenCloth)

	e2eharness.OpenTrade(t, a, b)
	a.SetTradeItem(t, 0, bag, slot)
	// Tele far (cross-map) while trade open — server must drop trade without client cancel.
	a.Teleport(t, 3758.2554, 3689.5754, 47.241505, e2eharness.MapNorthrend)
	info := a.WaitTradeCancelled(t, 10*time.Second)
	if a.World.TradeOpen() {
		e2eharness.Assertf(t, "trade still open after far tele (server must OOR-abort; do not client-cancel to invent PASS)")
	}

	aCount1 := a.InventoryCount(t, itemLinenCloth)
	bCount1 := b.InventoryCount(t, itemLinenCloth)
	if aCount1 != aCount0 || bCount1 != bCount0 {
		e2eharness.Assertf(t, "inventory changed after OOR abort A %d→%d B %d→%d", aCount0, aCount1, bCount0, bCount1)
	}
	e2eharness.ProbeWorldAlive(t, b, 25723)
	t.Logf("PASS OOR mid-trade abort status=%d open=%v", info.Status, a.World.TradeOpen())
}

// Spec 4 — Stackable merge.
func TestTrade_StackableMerge(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "trade", "multi_bot"}, Runtime: "short", Category: "social/trade"})

	a, b := tradePair(t, "TrdStk")
	// A has 5, B has 3; partial-stack trade API is not available — trade A's full stack of 5.
	// After accept: totals conserved and B gains.
	bag, slot := a.AddItemWait(t, itemLinenCloth, 5)
	b.AddItem(t, itemLinenCloth, 3)
	a.Save(t)
	b.Save(t)
	a0 := a.InventoryCount(t, itemLinenCloth)
	b0 := b.InventoryCount(t, itemLinenCloth)
	if a0 < 5 || b0 < 3 {
		e2eharness.Preconditionf(t, "seed failed a=%d b=%d", a0, b0)
	}

	e2eharness.OpenTrade(t, a, b)
	a.SetTradeItem(t, 0, bag, slot)
	e2eharness.CompleteTrade(t, a, b)

	a1 := a.InventoryCount(t, itemLinenCloth)
	b1 := b.InventoryCount(t, itemLinenCloth)
	if a1+b1 != a0+b0 {
		e2eharness.Assertf(t, "linen not conserved %d+%d → %d+%d", a0, b0, a1, b1)
	}
	if b1 <= b0 {
		e2eharness.Assertf(t, "B did not gain stack %d→%d", b0, b1)
	}
	t.Logf("PASS stackable merge/conserve a %d→%d b %d→%d", a0, a1, b0, b1)
}

// Spec 5 — Rapid open/close no crash (UAF stress).
func TestTrade_RapidOpenCloseNoCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "trade", "multi_bot", "issue"},
		Runtime:  "short",
		Issue:    25723,
		Category: "social/trade",
	})

	a, b := tradePair(t, "TrdSpm")
	probe := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "TrdPrb", Level: 10})
	probe.TeleportPad(t, e2eharness.PackagePad(t))

	for i := 0; i < 8; i++ {
		e2eharness.OpenTrade(t, a, b)
		if i%3 == 0 {
			a.CancelTrade(t)
			_ = a.WaitTradeCancelled(t, 5*time.Second)
		} else {
			e2eharness.CompleteTrade(t, a, b)
		}
		// Re-seat both on pad without thrashing tele every cycle if already close.
		if i%2 == 1 {
			pad := e2eharness.PackagePad(t)
			e2eharness.TeleportAllPad(t, []*e2eharness.ScenarioBot{a, b}, pad)
			b.Teleport(t, pad.X+2, pad.Y, pad.Z, pad.Map)
		}
	}
	// One OOR abort in the mix (crash surface): server must clear without client cancel.
	e2eharness.OpenTrade(t, a, b)
	a.Teleport(t, 3758.2554, 3689.5754, 47.241505, e2eharness.MapNorthrend)
	_ = a.WaitTradeCancelled(t, 10*time.Second)
	if a.World.TradeOpen() {
		e2eharness.Assertf(t, "trade still open after far tele in rapid stress (server OOR-abort required)")
	}

	e2eharness.ProbeWorldAlive(t, probe, 25723)
	a.AssertWorldAlive(t)
	b.AssertWorldAlive(t)
	t.Logf("PASS rapid open/close no crash")
}
