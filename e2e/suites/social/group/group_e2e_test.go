//go:build e2e

package group_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/client"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// GRP-01: FormParty → both InGroup, leader flag.
func TestGroup_FormPartyBasic(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "social", "multi_bot"}, Runtime: "short", Category: "social/group"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "GrpForm",
		Count:  2,
		Level:  20,
	})
	leader, mate := bots[0], bots[1]
	e2eharness.FormPartyAtPad(t, e2eharness.PadStormwindOutskirts, leader, mate)
	if !leader.InGroup() || !mate.InGroup() {
		e2eharness.Preconditionf(t, "expected both in group leader=%v mate=%v", leader.InGroup(), mate.InGroup())
	}
	if !leader.IsGroupLeader() {
		e2eharness.Preconditionf(t, "leader bot not IsGroupLeader")
	}
	t.Logf("PASS FormParty members=%d", len(leader.GroupMembers())+1)
}

// GRP-02: leave group clears membership.
func TestGroup_LeaveClearsMembership(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "social", "multi_bot"}, Runtime: "short", Category: "social/group"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "GrpLeave", Count: 2, Level: 20})
	leader, mate := bots[0], bots[1]
	e2eharness.TeleportAll(t, bots,
		e2eharness.PadStormwindOutskirts.X, e2eharness.PadStormwindOutskirts.Y,
		e2eharness.PadStormwindOutskirts.Z, e2eharness.PadStormwindOutskirts.Map)
	e2eharness.FormParty(t, leader, mate)
	mate.LeaveGroup(t)
	mate.WaitNotInGroup(t, 15*time.Second)
	if mate.InGroup() {
		e2eharness.ConfirmedBugf(t, 0, "mate still InGroup after leave")
	}
	t.Logf("PASS leave group")
}

// GRP-03: transfer leader.
func TestGroup_SetLeaderTransfer(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "social", "multi_bot"}, Runtime: "short", Category: "social/group"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "GrpLead", Count: 2, Level: 20})
	a, b := bots[0], bots[1]
	e2eharness.TeleportAll(t, bots,
		e2eharness.PadStormwindOutskirts.X, e2eharness.PadStormwindOutskirts.Y,
		e2eharness.PadStormwindOutskirts.Z, e2eharness.PadStormwindOutskirts.Map)
	e2eharness.FormParty(t, a, b)
	a.SetLeader(t, b)
	// Wait for group list update reflecting new leader.
	deadline := time.Now().Add(15 * time.Second)
	for time.Now().Before(deadline) {
		if b.IsGroupLeader() {
			t.Logf("PASS set leader transfer")
			return
		}
		time.Sleep(200 * time.Millisecond)
	}
	e2eharness.Preconditionf(t, "mate never became leader (a=%v b=%v)", a.IsGroupLeader(), b.IsGroupLeader())
}

// GRP-04 / #23459 style: rapid invite/decline loops must not crash world.
func TestGroup_RapidInviteDeclineNoCrash(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{
		Tags:     []string{"med", "social", "multi_bot", "issue"},
		Runtime:  "med",
		Issue:    23459,
		Category: "social/group",
	})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "GrpFast", Count: 2, Level: 20})
	a, b := bots[0], bots[1]
	e2eharness.TeleportAll(t, bots,
		e2eharness.PadStormwindOutskirts.X, e2eharness.PadStormwindOutskirts.Y,
		e2eharness.PadStormwindOutskirts.Z, e2eharness.PadStormwindOutskirts.Map)
	for i := 0; i < 5; i++ {
		a.Invite(t, b)
		_ = b.WaitGroupInvite(t, 5*time.Second)
		b.DeclineGroup(t)
		time.Sleep(200 * time.Millisecond)
	}
	e2eharness.ProbeWorldAlive(t, a, 23459)
	t.Logf("PASS rapid invite/decline no crash")
}

// GRP-05: set loot method NeedBeforeGreed.
func TestGroup_SetLootMethodNBG(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "social", "loot", "multi_bot"}, Runtime: "short", Category: "social/group"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "GrpLoot", Count: 2, Level: 20})
	leader, mate := bots[0], bots[1]
	e2eharness.TeleportAll(t, bots,
		e2eharness.PadStormwindOutskirts.X, e2eharness.PadStormwindOutskirts.Y,
		e2eharness.PadStormwindOutskirts.Z, e2eharness.PadStormwindOutskirts.Map)
	e2eharness.FormParty(t, leader, mate)
	leader.SetLootMethod(t, client.LootMethodNeedBeforeGreed, 0, 2)
	st := leader.WaitGroupList(t, true, 2, 10*time.Second)
	t.Logf("PASS set loot method state_in_group=%v loot=%d", st.InGroup, st.LootMethod)
}

// GRP-06: disband party.
func TestGroup_DisbandParty(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "social", "multi_bot"}, Runtime: "short", Category: "social/group"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "GrpDis", Count: 2, Level: 20})
	leader, mate := bots[0], bots[1]
	e2eharness.TeleportAll(t, bots,
		e2eharness.PadStormwindOutskirts.X, e2eharness.PadStormwindOutskirts.Y,
		e2eharness.PadStormwindOutskirts.Z, e2eharness.PadStormwindOutskirts.Map)
	e2eharness.FormParty(t, leader, mate)
	e2eharness.DisbandParty(t, bots...)
	leader.WaitNotInGroup(t, 15*time.Second)
	mate.WaitNotInGroup(t, 15*time.Second)
	t.Logf("PASS disband party")
}
