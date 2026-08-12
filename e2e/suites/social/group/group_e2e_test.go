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
	// serial: SW pad thrash + concurrent party tests can drop invites under load.
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "social", "multi_bot", "serial"}, Runtime: "short", Category: "social/group"})

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
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "social", "multi_bot", "serial"}, Runtime: "short", Category: "social/group"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "GrpLeave", Count: 2, Level: 20})
	leader, mate := bots[0], bots[1]
	e2eharness.TeleportAll(t, bots,
		e2eharness.PadStormwindOutskirts.X, e2eharness.PadStormwindOutskirts.Y,
		e2eharness.PadStormwindOutskirts.Z, e2eharness.PadStormwindOutskirts.Map)
	e2eharness.FormParty(t, leader, mate)
	mate.LeaveGroup(t)
	mate.WaitNotInGroup(t, 15*time.Second)
	if mate.InGroup() {
		e2eharness.Assertf(t, "mate still InGroup after leave")
	}
	t.Logf("PASS leave group")
}

// GRP-03: transfer leader.
func TestGroup_SetLeaderTransfer(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "social", "multi_bot", "serial"}, Runtime: "short", Category: "social/group"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "GrpLead", Count: 2, Level: 20})
	a, b := bots[0], bots[1]
	e2eharness.TeleportAll(t, bots,
		e2eharness.PadStormwindOutskirts.X, e2eharness.PadStormwindOutskirts.Y,
		e2eharness.PadStormwindOutskirts.Z, e2eharness.PadStormwindOutskirts.Map)
	e2eharness.FormParty(t, a, b)
	a.SetLeader(t, b)
	b.WaitIsGroupLeader(t, 15*time.Second)
	t.Logf("PASS set leader transfer")
}

// GRP-04 / #23459 style: rapid invite/decline loops must not crash world.
func TestGroup_RapidInviteDeclineNoCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "social", "multi_bot", "serial", "issue"},
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
		// Arm before Invite (no last-invite cache; WaitGroupInvite alone can miss a fast SMSG).
		waitInv, cancelInv := b.ArmGroupInvite()
		a.Invite(t, b)
		if _, ok := waitInv(5 * time.Second); !ok {
			cancelInv()
			e2eharness.Assertf(t, "rapid invite loop %d: no SMSG_GROUP_INVITE", i)
			return
		}
		cancelInv()
		b.DeclineGroup(t)
		// Decline must leave b out of party before the next invite.
		b.WaitNotInGroup(t, 5*time.Second)
	}
	e2eharness.ProbeWorldAlive(t, a, 23459)
	t.Logf("PASS rapid invite/decline no crash")
}

// GRP-05: set loot method NeedBeforeGreed.
func TestGroup_SetLootMethodNBG(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "social", "loot", "multi_bot", "serial"}, Runtime: "short", Category: "social/group"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "GrpLoot", Count: 2, Level: 20})
	leader, mate := bots[0], bots[1]
	e2eharness.TeleportAll(t, bots,
		e2eharness.PadStormwindOutskirts.X, e2eharness.PadStormwindOutskirts.Y,
		e2eharness.PadStormwindOutskirts.Z, e2eharness.PadStormwindOutskirts.Map)
	e2eharness.FormParty(t, leader, mate)
	leader.SetLootMethod(t, client.LootMethodNeedBeforeGreed, 0, 2)
	st := leader.WaitLootMethod(t, client.LootMethodNeedBeforeGreed, 10*time.Second)
	t.Logf("PASS set loot method state_in_group=%v loot=%d", st.InGroup, st.LootMethod)
}

// GRP-06: disband party.
func TestGroup_DisbandParty(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "social", "multi_bot", "serial"}, Runtime: "short", Category: "social/group"})

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
