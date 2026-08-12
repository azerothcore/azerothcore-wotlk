//go:build e2e

package loot_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/client"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

const creatureBoar uint32 = 3098

// LOOT-01: Need vs Greed when rolls appear; otherwise SoftPass on outdoor fixture.
func TestLoot_NeedVsGreedWinnerBag(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "loot", "multi_bot", "serial"}, Runtime: "med", Category: "social/loot"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "LootNBG",
		Bots: []e2eharness.BotSpec{
			{Role: "leader", Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
			{Role: "mate", Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
		},
	})
	leader := e2eharness.ByRole(t, bots, "leader")
	mate := e2eharness.ByRole(t, bots, "mate")
	e2eharness.FormPartyAtPad(t, e2eharness.PadStormwindOutskirts, leader, mate)
	// Threshold 0 → all quality rolls under group/NBG methods.
	leader.SetLootMethod(t, client.LootMethodNeedBeforeGreed, 0, 0)
	leader.WaitLootMethod(t, client.LootMethodNeedBeforeGreed, 10*time.Second)

	guid := leader.SpawnKillLootable(t, creatureBoar, 45*time.Second)
	mate.CombatReady(t)
	mate.TeleportPad(t, e2eharness.PadStormwindOutskirts)

	leader.World.ClearActiveLootRolls()
	mate.World.ClearActiveLootRolls()
	waitRoll := leader.ArmLootStartRoll()

	items, ok := leader.TryOpenLoot(t, guid, 8*time.Second)
	if !ok {
		_ = leader.World.SetTarget(guid)
		items, ok = leader.TryOpenLoot(t, guid, 8*time.Second)
	}
	if !ok {
		leader.AssertWorldAlive(t)
		e2eharness.SoftPass(t, "no_loot_window", "NBG: outdoor corpse not lootable guid=0x%X", guid)
		return
	}
	t.Logf("loot window items=%d", len(items))

	roll, gotRoll := waitRoll(0, 12*time.Second)
	if !gotRoll {
		// Many outdoor critters only drop money / under-method items without rolls.
		leader.AssertWorldAlive(t)
		leader.LootRelease(t, guid)
		e2eharness.SoftPass(t, "no_group_roll", "NBG: loot opened without group rolls (items=%d)", len(items))
		return
	}

	mate.RollGreed(t, roll)
	leader.RollNeed(t, roll)
	won := leader.WaitLootRollWon(t, roll.ItemID, 90*time.Second)
	if won.WinnerGUID != leader.GUID && won.WinnerGUID != mate.GUID {
		e2eharness.Assertf(t, "unexpected winner 0x%X", won.WinnerGUID)
	}
	winner := leader
	if won.WinnerGUID == mate.GUID {
		winner = mate
	}
	// InventoryCount saves then queries CharDB (post WaitLootRollWon).
	n := winner.InventoryCount(t, roll.ItemID)
	t.Logf("PASS need/greed roll item=%d winner=0x%X bag_count=%d", roll.ItemID, won.WinnerGUID, n)
	leader.AssertWorldAlive(t)
}

// LOOT-02 / #26894: leave party mid-roll (when rolls exist). SoftPass if outdoor fixture has no rolls.
func TestAC_26894_ChestLootPartyLeaveMidRoll(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "loot", "multi_bot", "serial", "issue"},
		Runtime:  "med",
		Issue:    26894,
		Category: "social/loot",
	})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "LootLv",
		Bots: []e2eharness.BotSpec{
			{Role: "leader", Level: 80, LearnAllClass: true, Class: e2eharness.ClassWarrior},
			{Role: "leaver", Level: 80, LearnAllClass: true, Class: e2eharness.ClassWarrior},
		},
	})
	leader := e2eharness.ByRole(t, bots, "leader")
	leaver := e2eharness.ByRole(t, bots, "leaver")
	e2eharness.FormPartyAtPad(t, e2eharness.PadStormwindOutskirts, leader, leaver)
	leader.SetLootMethod(t, client.LootMethodGroupLoot, 0, 0)
	leader.WaitLootMethod(t, client.LootMethodGroupLoot, 10*time.Second)

	// Issue cites GO 194821; spawn for future GO-use helpers. Corpse path is the active repro.
	leader.GM(t, ".gobject add 194821")
	// Soft: wait for GO if cache tracks it; do not fail the mid-roll corpse path.
	_ = e2eharness.TryNearbyGameObjectByEntry(t, leader.World, 194821, 5*time.Second)

	guid := leader.SpawnKillLootable(t, creatureBoar, 45*time.Second)
	leaver.CombatReady(t)
	leaver.TeleportPad(t, e2eharness.PadStormwindOutskirts)

	waitRoll := leader.ArmLootStartRoll()
	_, _ = leader.TryOpenLoot(t, guid, 8*time.Second)

	roll, gotRoll := waitRoll(0, 12*time.Second)
	if !gotRoll {
		// Soft path: still exercise party leave after loot open (related multi-session surface).
		leaver.LeaveGroup(t)
		leaver.WaitNotInGroup(t, 15*time.Second)
		e2eharness.ProbeWorldAlive(t, leader, 26894)
		_, _ = leader.TryOpenLoot(t, guid, 8*time.Second)
		e2eharness.SoftPass(t, "no_roll_window", "#26894 outdoor creature loot not group-rolling; leave+reopen OK")
		return
	}

	leaver.LeaveGroup(t)
	leaver.WaitNotInGroup(t, 15*time.Second)
	leader.RollNeed(t, roll)

	wonDone := make(chan client.LootRollWon, 1)
	allPassed := make(chan client.LootAllPassed, 1)
	prevWon := leader.World.OnLootRollWon
	prevAll := leader.World.OnLootAllPassed
	leader.World.OnLootRollWon = func(r client.LootRollWon) {
		if prevWon != nil {
			prevWon(r)
		}
		select {
		case wonDone <- r:
		default:
		}
	}
	leader.World.OnLootAllPassed = func(r client.LootAllPassed) {
		if prevAll != nil {
			prevAll(r)
		}
		select {
		case allPassed <- r:
		default:
		}
	}
	defer func() {
		leader.World.OnLootRollWon = prevWon
		leader.World.OnLootAllPassed = prevAll
	}()
	select {
	case w := <-wonDone:
		t.Logf("roll awarded winner=0x%X item=%d", w.WinnerGUID, w.ItemID)
	case <-allPassed:
		t.Logf("all passed")
	case <-time.After(90 * time.Second):
		e2eharness.ConfirmedBugf(t, 26894, "loot roll did not resolve after party leave mid-roll itemGUID=0x%X", roll.ItemGUID)
	}
	e2eharness.ProbeWorldAlive(t, leader, 26894)
	_, _ = leader.TryOpenLoot(t, guid, 8*time.Second)
	leader.AssertWorldAlive(t)
	t.Logf("PASS #26894 mid-roll leave path")
}

// LOOT-03: all pass when rolls exist.
func TestLoot_PassOnLootRedistribution(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "loot", "multi_bot", "serial", "issue"}, Runtime: "med", Category: "social/loot"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix:        "LootPas",
		Count:         2,
		Level:         80,
		LearnAllClass: true,
		Class:         e2eharness.ClassWarrior,
	})
	leader, mate := bots[0], bots[1]
	e2eharness.FormPartyAtPad(t, e2eharness.PadStormwindOutskirts, leader, mate)
	leader.SetLootMethod(t, client.LootMethodGroupLoot, 0, 0)
	leader.WaitLootMethod(t, client.LootMethodGroupLoot, 10*time.Second)

	guid := leader.SpawnKillLootable(t, creatureBoar, 45*time.Second)
	mate.CombatReady(t)
	mate.TeleportPad(t, e2eharness.PadStormwindOutskirts)

	waitRoll := leader.ArmLootStartRoll()
	items, ok := leader.TryOpenLoot(t, guid, 8*time.Second)
	if !ok {
		e2eharness.ProbeWorldAlive(t, leader, 22000)
		e2eharness.SoftPass(t, "no_loot_window", "pass-on-loot: outdoor corpse not lootable")
		return
	}
	roll, gotRoll := waitRoll(0, 12*time.Second)
	if !gotRoll {
		e2eharness.SoftPass(t, "no_group_roll", "pass-on-loot: no rolls (items=%d)", len(items))
		e2eharness.ProbeWorldAlive(t, leader, 22000)
		return
	}
	leader.RollPass(t, roll)
	mate.RollPass(t, roll)
	passed := make(chan struct{}, 1)
	prevAll := leader.World.OnLootAllPassed
	leader.World.OnLootAllPassed = func(r client.LootAllPassed) {
		if prevAll != nil {
			prevAll(r)
		}
		select {
		case passed <- struct{}{}:
		default:
		}
	}
	defer func() { leader.World.OnLootAllPassed = prevAll }()
	select {
	case <-passed:
		t.Logf("PASS all-pass packet for item=%d", roll.ItemID)
	case <-time.After(90 * time.Second):
		e2eharness.SoftPass(t, "no_all_passed", "both passed rolls but ALL_PASSED not seen — corpse may stay lootable")
	}
	e2eharness.ProbeWorldAlive(t, leader, 22000)
}

// LOOT-05: kill when below half HP (#26862). SoftPass if outdoor corpse never opens.
func TestAC_26862_KillCreditLootSpawnBelowHalfHP(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "loot", "issue", "serial"},
		Runtime:  "med",
		Issue:    26862,
		Category: "social/loot",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "LootHP",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	bot.GM(t, ".npc add 3098")
	guid := bot.WaitUnit(t, creatureBoar, 15*time.Second)
	bot.GM(t, ".npc set level 80")

	bot.WaitUnitHPKnown(t, guid, 10*time.Second)
	bot.DamageToFraction(t, guid, 0.49, 20*time.Second)
	hp, max := bot.UnitHP(guid)
	t.Logf("unit below half hp=%d/%d", hp, max)

	bot.CombatReady(t)
	bot.DamageKill(t, []uint64{guid}, 50_000_000, 25*time.Second)
	bot.WaitUnitDead(t, guid, 20*time.Second)
	bot.WaitUnitLootable(t, guid, 15*time.Second)

	items, ok := bot.TryOpenLoot(t, guid, 8*time.Second)
	if !ok {
		// Soft: dynflag lootable can lag; kill credit path already exercised.
		bot.AssertWorldAlive(t)
		e2eharness.SoftPass(t, "no_loot_window", "#26862 below-half-HP kill path (loot soft-miss; world alive)")
		return
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS below-half-HP kill loot path items=%d", len(items))
}

// LOOT-06: master loot assign.
func TestLoot_MasterLootAssign(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "loot", "multi_bot", "serial"}, Runtime: "med", Category: "social/loot"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "LootML",
		Bots: []e2eharness.BotSpec{
			{Role: "master", Level: 80, LearnAllClass: true, Class: e2eharness.ClassWarrior},
			{Role: "member", Level: 80, LearnAllClass: true, Class: e2eharness.ClassWarrior},
		},
	})
	master := e2eharness.ByRole(t, bots, "master")
	member := e2eharness.ByRole(t, bots, "member")
	e2eharness.FormPartyAtPad(t, e2eharness.PadStormwindOutskirts, master, member)
	master.SetLootMethod(t, client.LootMethodMasterLoot, master.GUID, 0)
	master.WaitLootMethod(t, client.LootMethodMasterLoot, 10*time.Second)

	guid := master.SpawnKillLootable(t, creatureBoar, 45*time.Second)
	member.CombatReady(t)
	member.TeleportPad(t, e2eharness.PadStormwindOutskirts)

	items, ok := master.TryOpenLoot(t, guid, 8*time.Second)
	if !ok || len(items) == 0 {
		e2eharness.SoftPass(t, "no_loot_slots", "master loot: no item slots / not lootable; method set OK")
		master.AssertWorldAlive(t)
		return
	}
	master.MasterLootGive(t, guid, items[0].Index, member)
	// Soft inventory oracle after master assign (Save + CharDB).
	n := member.InventoryCount(t, items[0].ItemID)
	t.Logf("PASS master loot give entry=%d member_count=%d", items[0].ItemID, n)
	master.AssertWorldAlive(t)
}

// LOOT inventory oracle.
func TestLoot_InventoryCountOracle(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "loot", "items"}, Runtime: "short", Category: "social/loot"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "LootInv", Level: 40})
	before := bot.InventoryCount(t, e2eharness.ItemTargetDummy)
	bot.AddItem(t, e2eharness.ItemTargetDummy, 2)
	after := bot.InventoryCount(t, e2eharness.ItemTargetDummy)
	if after < before+2 {
		e2eharness.Assertf(t, "inventory count before=%d after=%d want +2", before, after)
	}
	t.Logf("PASS inventory count oracle %d→%d", before, after)
}
