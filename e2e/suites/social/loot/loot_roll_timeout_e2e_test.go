//go:build e2e

package loot_test

import (
	"fmt"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// rollPacketLog collects every SMSG_LOOT_ROLL a bot receives.
type rollPacketLog struct {
	mu     sync.Mutex
	events []client.LootRollEvent
}

func (r *rollPacketLog) add(e client.LootRollEvent) {
	r.mu.Lock()
	r.events = append(r.events, e)
	r.mu.Unlock()
}

func (r *rollPacketLog) snapshot() []client.LootRollEvent {
	r.mu.Lock()
	defer r.mu.Unlock()
	out := make([]client.LootRollEvent, len(r.events))
	copy(out, r.events)
	return out
}

func (r *rollPacketLog) describe() string {
	s := ""
	for _, e := range r.snapshot() {
		s += fmt.Sprintf("\n    rollID=0x%X target=0x%X item=%d num=%d type=%d autoPass=%d",
			e.ItemGUID, e.TargetGUID, e.ItemID, e.RollNumber, e.RollType, e.AutoPass)
	}
	if s == "" {
		return " (none)"
	}
	return s
}

// rollStillOpen reports whether the bot still holds rollID as a pending roll.
// A roll is dropped only when a terminating packet matches it by roll id and
// slot, which is the identity rule the client uses to cancel its roll frame.
func rollStillOpen(bot *e2eharness.ScenarioBot, rollID uint64) bool {
	for _, r := range bot.World.ActiveLootRolls() {
		if r.ItemGUID == rollID {
			return true
		}
	}
	return false
}

// countPasses returns how many PASS lines target got for rollID.
func countPasses(events []client.LootRollEvent, target, rollID uint64) int {
	n := 0
	for _, e := range events {
		if e.TargetGUID == target && e.RollType == client.RollPass && e.ItemGUID == rollID {
			n++
		}
	}
	return n
}

// TestAC_27299_TimedOutRollTerminates covers a group loot roll that ends on the
// timer rather than on a vote. A member who never answers must be told it
// passed, and the packet that ends the roll must name the roll, otherwise the
// client cannot cancel the roll frame and the window stays on screen.
//
// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27299
func TestAC_27299_TimedOutRollTerminates(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"long", "loot", "multi_bot", "issue", "serial"}, Issue: 27299, Runtime: "long", Category: "social/loot"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "LootTmo",
		Bots: []e2eharness.BotSpec{
			{Role: "leader", Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
			{Role: "silent", Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
		},
	})
	leader := e2eharness.ByRole(t, bots, "leader")
	silent := e2eharness.ByRole(t, bots, "silent")
	e2eharness.FormPartyAtPad(t, e2eharness.PackagePad(t), leader, silent)

	// AC rejects a threshold below Uncommon; greys never start a group roll.
	leader.SetLootMethod(t, client.LootMethodGroupLoot, 0, e2eharness.LootThresholdUncommon)
	leader.WaitLootMethod(t, client.LootMethodGroupLoot, 10*time.Second)
	silent.CombatReady(t)

	// startRoll kills a fresh fixture corpse and returns the roll the silent bot
	// was offered, with a collector for every roll packet it subsequently sees.
	startRoll := func(t *testing.T) (client.LootStartRoll, uint64, *rollPacketLog, bool) {
		t.Helper()
		corpse := leader.SpawnKillLootable(t, e2eharness.CreatureGroupLootFixture, 45*time.Second)

		leader.World.ClearActiveLootRolls()
		silent.World.ClearActiveLootRolls()

		waitRoll, cancelRoll := silent.ArmLootStartRoll()
		t.Cleanup(cancelRoll)

		items, opened := leader.TryOpenLoot(t, corpse, 8*time.Second)
		if !opened {
			_ = leader.World.SetTarget(corpse)
			items, opened = leader.TryOpenLoot(t, corpse, 8*time.Second)
		}
		if !opened {
			e2eharness.Preconditionf(t, "group-loot fixture corpse not lootable guid=0x%X", corpse)
			return client.LootStartRoll{}, 0, nil, false
		}

		roll, ok := waitRoll(0, 12*time.Second)
		if !ok {
			leader.LootRelease(t, corpse)
			e2eharness.Preconditionf(t, "no SMSG_LOOT_START_ROLL on fixture %d (items=%d)", e2eharness.CreatureGroupLootFixture, len(items))
			return client.LootStartRoll{}, 0, nil, false
		}

		seen := &rollPacketLog{}
		t.Cleanup(silent.World.AddLootRollHook(seen.add))
		t.Logf("roll armed item=%d rollID=0x%X slot=%d countdown=%dms silent=0x%X",
			roll.ItemID, roll.ItemGUID, roll.ItemSlot, roll.CountdownMS, silent.GUID)
		return roll, corpse, seen, true
	}

	// The reported case: someone else needs and wins while one member never
	// answers the popup.
	t.Run("NeedWinNamesTheRoll", func(t *testing.T) {
		roll, corpse, seen, ok := startRoll(t)
		if !ok {
			return
		}

		wonCh, allCh, cancelOut := silent.ArmLootRollOutcome(roll.ItemID)
		t.Cleanup(cancelOut)

		leader.RollNeed(t, roll)
		// silent deliberately never votes; the server timer must resolve the roll.

		var won client.LootRollWon
		select {
		case won = <-wonCh:
		case all := <-allCh:
			e2eharness.Preconditionf(t, "expected a NEED winner, roll ended as ALL_PASSED item=%d", all.ItemID)
			return
		case <-time.After(100 * time.Second):
			e2eharness.Assertf(t, "roll never resolved item=%d rollID=0x%X; SMSG_LOOT_ROLL seen:%s",
				roll.ItemID, roll.ItemGUID, seen.describe())
			return
		}

		// Primary oracle: the packet that ends the roll names the roll, so the
		// client can cancel the frame it opened from SMSG_LOOT_START_ROLL.
		if won.ItemGUID != roll.ItemGUID {
			e2eharness.Assertf(t, "SMSG_LOOT_ROLL_WON rollID=0x%X does not match SMSG_LOOT_START_ROLL rollID=0x%X; the client cannot close the roll window",
				won.ItemGUID, roll.ItemGUID)
		}
		if rollStillOpen(silent, roll.ItemGUID) {
			e2eharness.Assertf(t, "roll 0x%X still pending after LOOT_ROLL_WON; nothing terminated it for the member who never voted", roll.ItemGUID)
		}

		// The member who never voted is told it passed, exactly once, and not as
		// an automatic "you cannot loot that item" pass.
		events := seen.snapshot()
		switch n := countPasses(events, silent.GUID, roll.ItemGUID); {
		case n == 0:
			e2eharness.Assertf(t, "no timeout PASS for the member who never voted (target=0x%X rollID=0x%X); SMSG_LOOT_ROLL seen:%s",
				silent.GUID, roll.ItemGUID, seen.describe())
		case n > 1:
			e2eharness.Assertf(t, "member who never voted got %d PASS lines for one roll, want 1;%s", n, seen.describe())
		}
		for _, e := range events {
			if e.TargetGUID == silent.GUID && e.RollType == client.RollPass && e.ItemGUID == roll.ItemGUID && e.AutoPass != 0 {
				e2eharness.Assertf(t, "timeout PASS sent with autoPass=%d; the client prints the \"cannot loot that item\" line instead of a plain pass", e.AutoPass)
			}
		}

		t.Logf("PASS timed-out NEED win: winner=0x%X rollID=0x%X matches start-roll, roll closed", won.WinnerGUID, won.ItemGUID)
		leader.LootRelease(t, corpse)
	})

	// Nobody answers, so the roll ends as all-passed instead of with a winner.
	t.Run("AllTimeoutNamesTheRoll", func(t *testing.T) {
		roll, corpse, seen, ok := startRoll(t)
		if !ok {
			return
		}

		wonCh, allCh, cancelOut := silent.ArmLootRollOutcome(roll.ItemID)
		t.Cleanup(cancelOut)

		var all client.LootAllPassed
		select {
		case all = <-allCh:
		case won := <-wonCh:
			e2eharness.Preconditionf(t, "expected ALL_PASSED with nobody voting, got a winner 0x%X", won.WinnerGUID)
			return
		case <-time.After(100 * time.Second):
			e2eharness.Assertf(t, "roll never resolved item=%d rollID=0x%X; SMSG_LOOT_ROLL seen:%s",
				roll.ItemID, roll.ItemGUID, seen.describe())
			return
		}

		if all.ItemGUID != roll.ItemGUID {
			e2eharness.Assertf(t, "SMSG_LOOT_ALL_PASSED rollID=0x%X does not match SMSG_LOOT_START_ROLL rollID=0x%X",
				all.ItemGUID, roll.ItemGUID)
		}
		if rollStillOpen(silent, roll.ItemGUID) {
			e2eharness.Assertf(t, "roll 0x%X still pending after LOOT_ALL_PASSED", roll.ItemGUID)
		}
		if n := countPasses(seen.snapshot(), silent.GUID, roll.ItemGUID); n != 1 {
			e2eharness.Assertf(t, "member who never voted got %d PASS lines for one roll, want 1;%s", n, seen.describe())
		}

		t.Logf("PASS full timeout: ALL_PASSED rollID=0x%X matches start-roll, roll closed", all.ItemGUID)
		leader.LootRelease(t, corpse)
	})

	leader.AssertWorldAlive(t)
}
