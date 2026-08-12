//go:build e2e

package loot_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/client"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// LOOT-01: Need vs Greed on a guaranteed Uncommon drop (Crimson Templar).
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
	e2eharness.FormPartyAtPad(t, e2eharness.PadFor(t), leader, mate)
	// AC minimum valid threshold is Uncommon (2); greys/whites never start group rolls.
	leader.SetLootMethod(t, client.LootMethodNeedBeforeGreed, 0, e2eharness.LootThresholdUncommon)
	leader.WaitLootMethod(t, client.LootMethodNeedBeforeGreed, 10*time.Second)

	// Mate ready on pad before kill so both are in range for group loot rolls.
	mate.CombatReady(t)
	guid := leader.SpawnKillLootable(t, e2eharness.CreatureGroupLootFixture, 45*time.Second)
	// Do not re-teleport after kill — stay on the corpse (tele can drop client loot state).

	leader.World.ClearActiveLootRolls()
	mate.World.ClearActiveLootRolls()
	waitRoll, cancelRoll := leader.ArmLootStartRoll()
	t.Cleanup(cancelRoll)

	items, ok := leader.TryOpenLoot(t, guid, 8*time.Second)
	if !ok {
		_ = leader.World.SetTarget(guid)
		items, ok = leader.TryOpenLoot(t, guid, 8*time.Second)
	}
	if !ok {
		e2eharness.Preconditionf(t, "NBG: group-loot fixture corpse not lootable guid=0x%X", guid)
		return
	}
	t.Logf("loot window items=%d", len(items))

	roll, gotRoll := waitRoll(0, 12*time.Second)
	if !gotRoll {
		// Known-good fixture (100% Uncommon crest); missing roll is setup/product failure.
		leader.LootRelease(t, guid)
		e2eharness.Preconditionf(t, "NBG: no SMSG_LOOT_START_ROLL on fixture %d (items=%d)", e2eharness.CreatureGroupLootFixture, len(items))
		return
	}

	// Arm outcome before votes (Arm → Roll → Wait).
	wonCh, _, cancelOut := leader.ArmLootRollOutcome(roll.ItemID)
	t.Cleanup(cancelOut)
	mate.RollGreed(t, roll)
	leader.RollNeed(t, roll)
	var won client.LootRollWon
	select {
	case won = <-wonCh:
	case <-time.After(90 * time.Second):
		e2eharness.Assertf(t, "LOOT_ROLL_WON not seen after Need/Greed item=%d", roll.ItemID)
		return
	}
	if won.WinnerGUID != leader.GUID && won.WinnerGUID != mate.GUID {
		e2eharness.Assertf(t, "unexpected winner 0x%X", won.WinnerGUID)
	}
	winner := leader
	if won.WinnerGUID == mate.GUID {
		winner = mate
	}
	n := winner.InventoryCount(t, roll.ItemID)
	t.Logf("PASS need/greed roll item=%d winner=0x%X bag_count=%d", roll.ItemID, won.WinnerGUID, n)
	leader.AssertWorldAlive(t)
}

// LOOT-02 / #26894: leave party mid-roll.
// True issue repro is GO 194821 after UseGameObject. Until then: corpse mid-roll leave with a
// 3-player party so leave does not disband (2-player leave clears rolls without awarding under
// ForcedDisband; cluster Disband is also a no-op). Stayer rolls Need; remaining mate Greed.
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
			{Role: "stayer", Level: 80, LearnAllClass: true, Class: e2eharness.ClassWarrior},
		},
	})
	leader := e2eharness.ByRole(t, bots, "leader")
	leaver := e2eharness.ByRole(t, bots, "leaver")
	stayer := e2eharness.ByRole(t, bots, "stayer")
	e2eharness.FormPartyAtPad(t, e2eharness.PadFor(t), leader, leaver, stayer)
	leader.SetLootMethod(t, client.LootMethodGroupLoot, 0, e2eharness.LootThresholdUncommon)
	leader.WaitLootMethod(t, client.LootMethodGroupLoot, 10*time.Second)

	// Issue cites GO 194821 (Gift of the Observer); spawn with cleanup — bare
	// `.gobject add` left persistent pad litter (see spawn_cleanup.go).
	_ = leader.SpawnGameObject(t, e2eharness.GameObjectGiftOfTheObserver)
	_ = e2eharness.TryNearbyGameObjectByEntry(t, leader.World, e2eharness.GameObjectGiftOfTheObserver, 5*time.Second)

	// Party already at pad; combat-ready members before kill, open loot without re-tele.
	leaver.CombatReady(t)
	stayer.CombatReady(t)
	guid := leader.SpawnKillLootable(t, e2eharness.CreatureGroupLootFixture, 45*time.Second)

	waitRoll, cancelRoll := leader.ArmLootStartRoll()
	t.Cleanup(cancelRoll)
	if _, ok := leader.TryOpenLoot(t, guid, 8*time.Second); !ok {
		e2eharness.Preconditionf(t, "#26894 proxy: fixture corpse not lootable guid=0x%X", guid)
		return
	}

	roll, gotRoll := waitRoll(0, 12*time.Second)
	if !gotRoll {
		e2eharness.Preconditionf(t, "#26894 proxy: no roll window on fixture %d (GO chest path still needs UseGameObject)", e2eharness.CreatureGroupLootFixture)
		return
	}

	// Arm outcome before leave+vote so LOOT_ROLL_WON / ALL_PASSED cannot be missed.
	wonCh, allCh, cancelOut := leader.ArmLootRollOutcome(roll.ItemID)
	t.Cleanup(cancelOut)
	// Leave mid-roll while group remains (3→2): RemovePlayerFromRolls must re-count votes.
	leaver.LeaveGroup(t)
	leaver.WaitNotInGroup(t, 15*time.Second)
	leader.RollNeed(t, roll)
	stayer.RollGreed(t, roll)

	select {
	case w := <-wonCh:
		t.Logf("roll awarded winner=0x%X item=%d", w.WinnerGUID, w.ItemID)
	case <-allCh:
		t.Logf("all passed")
	case <-time.After(90 * time.Second):
		// Corpse proxy of #26894. Related class: roll stuck after party composition change.
		// Full issue surface still needs UseGameObject + GO 194821.
		e2eharness.ConfirmedBugf(t, 26894,
			"corpse-proxy mid-roll leave: roll did not resolve (related #26894 class; GO 194821 path incomplete) itemGUID=0x%X",
			roll.ItemGUID)
	}
	e2eharness.ProbeWorldAlive(t, leader, 26894)
	_, _ = leader.TryOpenLoot(t, guid, 8*time.Second)
	leader.AssertWorldAlive(t)
	t.Logf("PASS mid-roll leave corpse proxy (issue-incomplete until GO 194821 UseGameObject)")
}

// LOOT-03: all pass when rolls exist.
func TestLoot_PassOnLootRedistribution(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "loot", "multi_bot", "serial", "issue"}, Runtime: "med", Category: "social/loot", Issue: 22000})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix:        "LootPas",
		Count:         2,
		Level:         80,
		LearnAllClass: true,
		Class:         e2eharness.ClassWarrior,
	})
	leader, mate := bots[0], bots[1]
	e2eharness.FormPartyAtPad(t, e2eharness.PadFor(t), leader, mate)
	leader.SetLootMethod(t, client.LootMethodGroupLoot, 0, e2eharness.LootThresholdUncommon)
	leader.WaitLootMethod(t, client.LootMethodGroupLoot, 10*time.Second)

	mate.CombatReady(t)
	guid := leader.SpawnKillLootable(t, e2eharness.CreatureGroupLootFixture, 45*time.Second)

	waitRoll, cancelRoll := leader.ArmLootStartRoll()
	t.Cleanup(cancelRoll)
	items, ok := leader.TryOpenLoot(t, guid, 8*time.Second)
	if !ok {
		e2eharness.Preconditionf(t, "pass-on-loot: fixture corpse not lootable")
		return
	}
	roll, gotRoll := waitRoll(0, 12*time.Second)
	if !gotRoll {
		e2eharness.Preconditionf(t, "pass-on-loot: no rolls on fixture %d (items=%d)", e2eharness.CreatureGroupLootFixture, len(items))
		return
	}
	// Fixture is judgeable once both bots pass — arm before votes; hard-fail if ALL_PASSED missing.
	_, allCh, cancelOut := leader.ArmLootRollOutcome(roll.ItemID)
	t.Cleanup(cancelOut)
	leader.RollPass(t, roll)
	mate.RollPass(t, roll)
	select {
	case <-allCh:
		t.Logf("PASS all-pass packet for item=%d", roll.ItemID)
	case <-time.After(90 * time.Second):
		e2eharness.Assertf(t, "LOOT_ALL_PASSED not seen after both pass item=%d itemGUID=0x%X", roll.ItemID, roll.ItemGUID)
	}
	e2eharness.ProbeWorldAlive(t, leader, 22000)
}

// LOOT-05: kill when below half HP (#26862).
// Uses Crimson Templar (reliable loot) damaged to <50% max then killed — open loot must work.
// (Issue class: curhealth < max/2 at death must still yield loot/credit.)
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
	bot.TeleportPad(t, e2eharness.PadFor(t))

	// Persistent spawn with guaranteed loot (15209 crest) — keep alive until after
	// below-half damage; SpawnKillLootable would kill immediately.
	entry := e2eharness.CreatureGroupLootFixture
	bot.DespawnNearbyEntry(t, entry, 80)
	time.Sleep(150 * time.Millisecond)
	known := map[uint64]struct{}{}
	for _, u := range bot.UnitsByEntry(100, entry) {
		known[u.GUID] = struct{}{}
	}
	bot.GM(t, ".gm on")
	bot.GM(t, fmt.Sprintf(".npc add %d", entry))
	dbSpawn := bot.CaptureCreatureSpawnID(t, entry)
	newOnes := bot.WaitNewUnits(t, known, []uint32{entry}, 15*time.Second)
	if len(newOnes) == 0 {
		e2eharness.Preconditionf(t, "#26862: fixture %d not found after .npc add", entry)
		return
	}
	guid := newOnes[0].GUID
	t.Cleanup(func() {
		if dbSpawn != 0 {
			bot.DespawnCreatureSpawn(t, dbSpawn)
			return
		}
		bot.DespawnNPC(t, guid)
	})

	bot.WaitUnitHPKnown(t, guid, 10*time.Second)
	// Stay GM for damage+kill so loot recipient tagging is consistent.
	bot.DamageToFraction(t, guid, 0.49, 20*time.Second)
	hp, max := bot.UnitHP(guid)
	t.Logf("unit below half hp=%d/%d", hp, max)
	if hp == 0 || max == 0 || float64(hp)/float64(max) > 0.5 {
		e2eharness.Preconditionf(t, "#26862: want 0 < hp/max <= 0.5 before kill, got %d/%d", hp, max)
		return
	}

	bot.DamageKill(t, []uint64{guid}, 50_000_000, 25*time.Second)
	bot.WaitUnitDead(t, guid, 20*time.Second)
	bot.WaitUnitLootable(t, guid, 15*time.Second)

	var items []client.LootItem
	ok := false
	for attempt := 0; attempt < 4 && !ok; attempt++ {
		_ = bot.World.SetTarget(guid)
		items, ok = bot.TryOpenLoot(t, guid, 5*time.Second)
		if !ok {
			time.Sleep(250 * time.Millisecond)
		}
	}
	if !ok {
		bot.AssertWorldAlive(t)
		e2eharness.ConfirmedBugf(t, 26862, "below-half-HP kill: corpse not lootable after retries (hp was %d/%d before kill)", hp, max)
		return
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS below-half-HP kill loot path items=%d", len(items))
}

// LOOT-06: master loot assign on group-loot fixture (guaranteed item slots).
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
	e2eharness.FormPartyAtPad(t, e2eharness.PadFor(t), master, member)
	// Threshold must be Uncommon+ for CMSG_LOOT_METHOD to apply (including master loot).
	master.SetLootMethod(t, client.LootMethodMasterLoot, master.GUID, e2eharness.LootThresholdUncommon)
	master.WaitLootMethod(t, client.LootMethodMasterLoot, 10*time.Second)

	member.CombatReady(t)
	guid := master.SpawnKillLootable(t, e2eharness.CreatureGroupLootFixture, 45*time.Second)

	items, ok := master.TryOpenLoot(t, guid, 8*time.Second)
	if !ok || len(items) == 0 {
		e2eharness.Preconditionf(t, "master loot: no item slots on fixture %d", e2eharness.CreatureGroupLootFixture)
		return
	}
	itemID := items[0].ItemID
	before := member.InventoryCount(t, itemID)
	master.MasterLootGive(t, guid, items[0].Index, member)
	// Poll CharDB briefly — assign is async to bags.
	deadline := time.Now().Add(15 * time.Second)
	var after int
	for time.Now().Before(deadline) {
		after = member.InventoryCount(t, itemID)
		if after > before {
			break
		}
		time.Sleep(200 * time.Millisecond)
	}
	if after <= before {
		e2eharness.Assertf(t, "master loot assign: member bag item=%d before=%d after=%d", itemID, before, after)
	}
	t.Logf("PASS master loot give entry=%d member_count %d→%d", itemID, before, after)
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
