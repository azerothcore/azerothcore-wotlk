//go:build e2e

package trial_of_the_crusader_test

import (
	"testing"
	"time"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	_ "github.com/go-sql-driver/mysql"
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/14076
// Hand of Protection must retain the marked target after the spike reaches it.
// Divine Shield grants full immunity and must still cause retargeting:
// https://github.com/azerothcore/azerothcore-wotlk/issues/14076#issuecomment-1345338310
// Use the actual summon spell inside a fresh ToC instance, without starting the
// full encounter. GM setup gives health, not god mode or damage immunity.
func TestAC_14076_PursuingSpikesImmunity(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags: []string{"med", "issue", "multi_bot"}, Runtime: "med",
		Issue: 14076, Category: "instances/trial_of_the_crusader",
	})
	const (
		mark       = uint32(67574)
		protection = uint32(10278)
		shield     = uint32(642)
		speed2     = uint32(65922)
	)
	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "Spike", Bots: []e2eharness.BotSpec{
			{Role: "one", Race: e2eharness.RaceHuman, Class: e2eharness.ClassPaladin, Level: 80},
			{Role: "two", Race: e2eharness.RaceHuman, Class: e2eharness.ClassPaladin, Level: 80},
		},
	})
	a, b := bots[0], bots[1]
	e2eharness.FormPartyAtPad(t, e2eharness.PackagePad(t), a, b)
	// CMSG_GROUP_RAID_CONVERT has no payload (GroupHandler.cpp).
	// AzerothGhost v1.0.8 exposes raw packets but no raid conversion helper.
	const groupRaidConvert = uint16(0x28e)
	if err := a.World.SendPacketRaw(groupRaidConvert, nil); err != nil {
		e2eharness.HarnessFailf(t, "convert party to raid: %v", err)
	}
	if !waitSpikeCondition(3*time.Second, func() bool { return a.GroupState().GroupType&2 != 0 }) {
		e2eharness.Preconditionf(t, "raid conversion not acknowledged")
	}
	for _, bot := range bots {
		bot.GM(t, ".gm on")
		bot.FlushWorld(t)
	}
	// Empty arena above Anub'arak: no Frost Spheres or encounter waves.
	a.Teleport(t, 563, 140, 394, 649)
	b.Teleport(t, 563, 140, 394, 649)
	caster, _ := a.SpawnPersistent(t, 12999, 10*time.Second)
	a.Teleport(t, 550, 120, 394, 649)
	b.Teleport(t, 580, 120, 394, 649)
	for _, bot := range bots {
		bot.Learn(t, protection)
		bot.Learn(t, shield)
		selectSpikeUnit(t, bot, bot.GUID)
		bot.GM(t, ".modify hp 1000000")
		e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{Power: true})
		bot.FlushWorld(t)
	}
	a.WaitUnitGUID(t, b.GUID, 10*time.Second)
	a.WaitUnitGUID(t, caster, 10*time.Second)
	for _, tc := range []struct {
		name  string
		spell uint32
	}{
		{"hand_of_protection", protection},
		{"divine_shield", shield},
		{"initially_immune", shield},
	} {
		t.Run(tc.name, func(t *testing.T) {
			for _, bot := range bots {
				selectSpikeUnit(t, bot, bot.GUID)
				bot.GM(t, ".combatstop")
				bot.GM(t, ".unaura all")
				bot.GM(t, ".cooldown")
				bot.GM(t, ".modify hp 1000000")
				bot.FlushWorld(t)
			}
			if tc.name == "initially_immune" {
				for _, bot := range bots {
					bot.CastMust(t, shield, bot.GUID, 5*time.Second)
					bot.WaitUnitAura(t, bot.GUID, shield, 2*time.Second)
				}
			}
			selectSpikeUnit(t, a, caster)
			// Same spell as EVENT_SPELL_SUMMON_SPIKE. No "triggered" suffix:
			// the GM command's debug mask would ignore the summon effect.
			a.GM(t, ".cast self 66169")
			spike := a.WaitUnit(t, 34660, 10*time.Second)
			t.Cleanup(func() {
				// Delete only this summon, before its persistent caster cleanup.
				selectSpikeUnit(t, a, spike)
				a.GM(t, ".npc delete")
			})
			if tc.name == "initially_immune" {
				a.WaitUnitAura(t, spike, speed2, 8*time.Second)
				a.AssertHasAura(t, shield)
				b.AssertHasAura(t, shield)
				if a.UnitTarget(spike) != 0 || a.HasAura(mark) || b.HasAura(mark) {
					e2eharness.ConfirmedBugf(t, 14076, "spike selected a fully immune player on initial acquisition")
				}
				a.CancelAura(t, shield)
				if !waitSpikeCondition(3*time.Second, func() bool {
					return a.HasAura(mark) && a.UnitTarget(spike) == a.GUID && a.UnitHasAura(spike, speed2)
				}) {
					e2eharness.ConfirmedBugf(t, 14076, "spike stalled after all players were immune on initial acquisition")
				}
				t.Log("PASS: initially all immune -> acquisition resumes without resetting acceleration")
				return
			}
			if !waitSpikeCondition(3*time.Second, func() bool { return a.HasAura(mark) != b.HasAura(mark) }) {
				e2eharness.Preconditionf(t, "expected exactly one marked player")
			}
			marked, other := a, b
			if b.HasAura(mark) {
				marked, other = b, a
			}
			a.WaitUnitTarget(t, spike, marked.GUID, 3*time.Second)
			t.Logf("spike=0x%X marked=0x%X other=0x%X spell=%d", spike, marked.GUID, other.GUID, tc.spell)
			marked.CastMust(t, tc.spell, marked.GUID, 5*time.Second)
			marked.WaitUnitAura(t, marked.GUID, tc.spell, 2*time.Second)
			if tc.spell == shield {
				if !waitSpikeCondition(3*time.Second, func() bool {
					return !marked.HasAura(mark) && other.HasAura(mark) && a.UnitTarget(spike) == other.GUID
				}) {
					e2eharness.ConfirmedBugf(t, 14076, "Divine Shield must allow retargeting: target=0x%X", a.UnitTarget(spike))
				}
				t.Log("PASS: Divine Shield causes the spike to mark and target the other player")
				other.CastMust(t, shield, other.GUID, 5*time.Second)
				if !waitSpikeCondition(3*time.Second, func() bool {
					return a.UnitTarget(spike) == 0 && !a.HasAura(mark) && !b.HasAura(mark)
				}) {
					e2eharness.ConfirmedBugf(t, 14076, "spike must release its target when both players are fully immune")
				}
				// The existing 7s acceleration timer must keep running without a
				// target, then pursuit must resume when one player becomes eligible.
				a.WaitUnitAura(t, spike, speed2, 8*time.Second)
				marked.AssertHasAura(t, shield)
				other.AssertHasAura(t, shield)
				marked.CancelAura(t, shield)
				if !waitSpikeCondition(3*time.Second, func() bool {
					return marked.HasAura(mark) && a.UnitTarget(spike) == marked.GUID
				}) {
					e2eharness.ConfirmedBugf(t, 14076, "spike did not reacquire player after full immunity ended")
				}
				if !a.UnitHasAura(spike, speed2) {
					e2eharness.ConfirmedBugf(t, 14076, "reacquiring a target reset the spike's speed")
				}
				t.Log("PASS: both immune -> no target; cancel immunity -> pursuit resumes at accelerated speed")
				return
			}

			// Spike reaches these stationary players in about 7s at its first
			// speed. Observe 9s of the 10s protection, including arrival and the
			// 7s acceleration event. Polling must not return early on arrival.
			reached := false
			deadline := time.Now().Add(9 * time.Second)
			for time.Now().Before(deadline) {
				if !marked.HasAura(protection) {
					e2eharness.Preconditionf(t, "Hand of Protection expired before observation completed")
				}
				if !marked.HasAura(mark) || other.HasAura(mark) || a.UnitTarget(spike) != marked.GUID {
					e2eharness.ConfirmedBugf(t, 14076, "spike lost protected target on arrival: target=0x%X mark=%v otherMark=%v",
						a.UnitTarget(spike), marked.HasAura(mark), other.HasAura(mark))
				}
				if obj := a.World.GetObject(spike); obj != nil && obj.HasKnownPosition() {
					x, y, z := obj.InterpolatedPosition()
					px, py, pz, _ := marked.Pos()
					reached = reached || e2eharness.Distance3D(x, y, z, px, py, pz) < 4
				}
				time.Sleep(25 * time.Millisecond)
			}
			if !reached {
				e2eharness.Preconditionf(t, "spike never reached the protected player; cannot judge arrival behavior")
			}
			if !a.UnitHasAura(spike, speed2) {
				e2eharness.ConfirmedBugf(t, 14076, "spike failed to accelerate while retaining the protected target")
			}
			t.Log("PASS: spike reaches protected player, keeps the mark and target, and accelerates")
		})
	}
}

func selectSpikeUnit(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64) {
	t.Helper()
	if err := bot.World.SetTarget(guid); err != nil {
		e2eharness.HarnessFailf(t, "select 0x%X: %v", guid, err)
	}
}

func waitSpikeCondition(timeout time.Duration, condition func() bool) bool {
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if condition() {
			return true
		}
		time.Sleep(25 * time.Millisecond)
	}
	return condition()
}
