/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CombatManager.h"
#include "ThreatManager.h"
#include "DBCStores.h"
#include "TestCreature.h"
#include "TestMap.h"
#include "WorldMock.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"

using namespace testing;

namespace
{

// ============================================================================
// Integration tests for CombatManager and evade timer system.
// Uses TestCreature/TestMap with hostile DBC faction entries.
// ============================================================================
class CombatManagerIntegrationTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        _previousWorld = std::move(sWorld);
        _worldMock = new NiceMock<WorldMock>();

        ON_CALL(*_worldMock, getIntConfig(_)).WillByDefault(Return(0));
        ON_CALL(*_worldMock, getFloatConfig(_)).WillByDefault(Return(1.0f));
        ON_CALL(*_worldMock, getBoolConfig(_)).WillByDefault(Return(false));

        sWorld.reset(_worldMock);

        // Insert two mutually hostile DBC faction entries
        auto* factionA = new FactionTemplateEntry{};
        factionA->ID = 90001;
        factionA->faction = 90001;
        factionA->factionFlags = 0;
        factionA->ourMask = 1;
        factionA->friendlyMask = 0;
        factionA->hostileMask = 2;
        for (auto& e : factionA->enemyFaction) e = 0;
        for (auto& f : factionA->friendFaction) f = 0;
        sFactionTemplateStore.SetEntry(90001, factionA);

        auto* factionB = new FactionTemplateEntry{};
        factionB->ID = 90002;
        factionB->faction = 90002;
        factionB->factionFlags = 0;
        factionB->ourMask = 2;
        factionB->friendlyMask = 0;
        factionB->hostileMask = 1;
        for (auto& e : factionB->enemyFaction) e = 0;
        for (auto& f : factionB->friendFaction) f = 0;
        sFactionTemplateStore.SetEntry(90002, factionB);

        TestMap::EnsureDBC();
        _map = new TestMap();

        _creatureA = new TestCreature();
        _creatureA->SetupForCombatTest(_map, 1, 12345);
        _creatureA->SetFaction(90001);

        _creatureB = new TestCreature();
        _creatureB->SetupForCombatTest(_map, 2, 12346);
        _creatureB->SetFaction(90002);
    }

    void TearDown() override
    {
        _creatureA->CleanupCombatState();
        _creatureB->CleanupCombatState();
        delete _creatureA;
        delete _creatureB;
        delete _map;
        sWorld = std::move(_previousWorld);
    }

    std::unique_ptr<IWorld> _previousWorld;
    NiceMock<WorldMock>* _worldMock = nullptr;
    TestMap* _map = nullptr;
    TestCreature* _creatureA = nullptr;
    TestCreature* _creatureB = nullptr;
};

// ============================================================================
// SetInCombatWith Tests
// ============================================================================

TEST_F(CombatManagerIntegrationTest, SetInCombatWith_CreatesReference)
{
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().HasCombat());

    bool result = _creatureA->TestGetCombatMgr().SetInCombatWith(_creatureB);

    EXPECT_TRUE(result);
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().HasCombat());
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));
    // Combat is bidirectional
    EXPECT_TRUE(_creatureB->TestGetCombatMgr().HasCombat());
    EXPECT_TRUE(_creatureB->TestGetCombatMgr().IsInCombatWith(_creatureA));
}

TEST_F(CombatManagerIntegrationTest, SetInCombatWith_SameUnit_Fails)
{
    EXPECT_FALSE(CombatManager::CanBeginCombat(_creatureA, _creatureA));
}

TEST_F(CombatManagerIntegrationTest, SetInCombatWith_DeadUnit_Fails)
{
    _creatureB->SetAlive(false);

    EXPECT_FALSE(CombatManager::CanBeginCombat(_creatureA, _creatureB));
}

TEST_F(CombatManagerIntegrationTest, SetInCombatWith_DifferentPhase_Fails)
{
    _creatureB->SetPhase(2);

    EXPECT_FALSE(CombatManager::CanBeginCombat(_creatureA, _creatureB));
}

// ============================================================================
// EndAllPvECombat Tests
// ============================================================================

TEST_F(CombatManagerIntegrationTest, EndAllPvECombat_ClearsAll)
{
    _creatureA->TestGetCombatMgr().SetInCombatWith(_creatureB);
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().HasCombat());

    _creatureA->TestGetCombatMgr().EndAllPvECombat();

    EXPECT_FALSE(_creatureA->TestGetCombatMgr().HasCombat());
}

TEST_F(CombatManagerIntegrationTest, EndAllPvECombat_AlsoClearsThreat)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));

    _creatureA->TestGetCombatMgr().EndAllPvECombat();

    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 0u);
}

// ============================================================================
// HasCombat Tests
// ============================================================================

TEST_F(CombatManagerIntegrationTest, HasCombat_ReflectsState)
{
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().HasCombat());

    _creatureA->TestGetCombatMgr().SetInCombatWith(_creatureB);
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().HasCombat());

    _creatureA->TestGetCombatMgr().EndAllPvECombat();
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().HasCombat());
}

// ============================================================================
// Evade Timer Tests
// ============================================================================

TEST_F(CombatManagerIntegrationTest, EvadeTimer_StartAndExpiry)
{
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().IsInEvadeMode());

    _creatureA->TestGetCombatMgr().StartEvadeTimer();

    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInEvadeMode());
}

TEST_F(CombatManagerIntegrationTest, EvadeState_Transitions)
{
    EXPECT_EQ(_creatureA->TestGetCombatMgr().GetEvadeState(), EVADE_STATE_NONE);

    _creatureA->TestGetCombatMgr().SetEvadeState(EVADE_STATE_HOME);
    EXPECT_EQ(_creatureA->TestGetCombatMgr().GetEvadeState(), EVADE_STATE_HOME);
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsEvadingHome());
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInEvadeMode());

    _creatureA->TestGetCombatMgr().StopEvade();
    EXPECT_EQ(_creatureA->TestGetCombatMgr().GetEvadeState(), EVADE_STATE_NONE);
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().IsInEvadeMode());
}

// ============================================================================
// ContinueEvadeRegen Tests
// ============================================================================

TEST_F(CombatManagerIntegrationTest, ContinueEvadeRegen_KeepsRegenActive)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    // StartEvadeTimer begins at 10s — NOT in regen zone yet
    cm.StartEvadeTimer();
    EXPECT_TRUE(cm.IsInEvadeMode());
    EXPECT_FALSE(cm.IsEvadeRegen());

    // ContinueEvadeRegen sets timer to regen threshold
    cm.ContinueEvadeRegen();
    EXPECT_TRUE(cm.IsInEvadeMode());
    EXPECT_TRUE(cm.IsEvadeRegen());

    // After partial countdown, still in regen zone
    cm.Update(3000);
    EXPECT_TRUE(cm.IsEvadeRegen());
}

TEST_F(CombatManagerIntegrationTest, ContinueEvadeRegen_StopEvadeClearsIt)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    cm.ContinueEvadeRegen();
    EXPECT_TRUE(cm.IsEvadeRegen());

    cm.StopEvade();
    EXPECT_FALSE(cm.IsEvadeRegen());
    EXPECT_FALSE(cm.IsInEvadeMode());
}

// ============================================================================
// Constants Tests (compacted)
// ============================================================================

TEST_F(CombatManagerIntegrationTest, EvadeConstants)
{
    constexpr uint32 duration = CombatManager::EVADE_TIMER_DURATION;
    constexpr uint32 delay = CombatManager::EVADE_REGEN_DELAY;
    constexpr uint32 pvpTimeout = PvPCombatReference::PVP_COMBAT_TIMEOUT;

    EXPECT_EQ(duration, 10000u);
    EXPECT_EQ(delay, 5000u);
    EXPECT_EQ(pvpTimeout, 5000u);
    EXPECT_EQ(delay * 2, duration);

    EXPECT_EQ(static_cast<uint8>(EVADE_STATE_NONE), 0);
    EXPECT_EQ(static_cast<uint8>(EVADE_STATE_COMBAT), 1);
    EXPECT_EQ(static_cast<uint8>(EVADE_STATE_HOME), 2);
}

// ============================================================================
// Individual CombatReference::EndCombat Tests (Issue #4 regression)
// Used by SetImmuneToPC/NPC to end specific combat references
// ============================================================================

TEST_F(CombatManagerIntegrationTest, EndCombat_SingleReference_KeepsOthers)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // A in combat with both B and C
    _creatureA->TestGetCombatMgr().SetInCombatWith(_creatureB);
    _creatureA->TestGetCombatMgr().SetInCombatWith(creatureC);
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(creatureC));

    // End only the reference with B
    auto const& refs = _creatureA->TestGetCombatMgr().GetPvECombatRefs();
    CombatReference* refToEnd = nullptr;
    for (auto const& pair : refs)
        if (pair.second->GetOther(_creatureA) == _creatureB)
            refToEnd = pair.second;

    ASSERT_NE(refToEnd, nullptr);
    refToEnd->EndCombat();

    // B reference gone, C reference remains
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(creatureC));
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().HasCombat());

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(CombatManagerIntegrationTest, EndCombat_AlsoClearsThreatForThatRef)
{
    // Add threat (which implies combat)
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));

    // End the combat reference directly
    auto const& refs = _creatureA->TestGetCombatMgr().GetPvECombatRefs();
    ASSERT_FALSE(refs.empty());
    auto it = refs.begin();
    it->second->EndCombat();

    // Both combat and threat should be cleared
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
}

TEST_F(CombatManagerIntegrationTest, EndCombat_BidirectionalCleanup)
{
    _creatureA->TestGetCombatMgr().SetInCombatWith(_creatureB);

    // End from A's side
    auto const& refs = _creatureA->TestGetCombatMgr().GetPvECombatRefs();
    ASSERT_FALSE(refs.empty());
    refs.begin()->second->EndCombat();

    // Both sides should be cleaned up
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().HasCombat());
    EXPECT_FALSE(_creatureB->TestGetCombatMgr().HasCombat());
}

// ============================================================================
// SetImmuneToNPC Tests (selective EndCombat by unit flag)
// ============================================================================

TEST_F(CombatManagerIntegrationTest, SetImmuneToNPC_EndsCombatWithNPCs)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // A in combat with both B and C (all NPCs, none have UNIT_FLAG_PLAYER_CONTROLLED)
    _creatureA->TestGetCombatMgr().SetInCombatWith(_creatureB);
    _creatureA->TestGetCombatMgr().SetInCombatWith(creatureC);
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().HasCombat());

    // SetImmuneToNPC should end combat with non-player-controlled units
    _creatureA->SetImmuneToNPC(true, false);

    EXPECT_FALSE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().IsInCombatWith(creatureC));
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().HasCombat());

    _creatureA->SetImmuneToNPC(false, false);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(CombatManagerIntegrationTest, SetImmuneToNPC_KeepCombat_PreservesRefs)
{
    _creatureA->TestGetCombatMgr().SetInCombatWith(_creatureB);
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().HasCombat());

    // keepCombat=true should not end any combat
    _creatureA->SetImmuneToNPC(true, true);

    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));

    _creatureA->SetImmuneToNPC(false, false);
}

// ============================================================================
// StopAttackFaction Tests (EndCombat instead of ClearThreat)
// ============================================================================

TEST_F(CombatManagerIntegrationTest, StopAttackFaction_EndsCombatForFaction)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90001); // same faction as A

    // A in combat with B (faction 90002), threat too
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));

    // Also have C fight B
    creatureC->TestGetThreatMgr().AddThreat(_creatureB, 200.0f);
    EXPECT_TRUE(creatureC->TestGetCombatMgr().IsInCombatWith(_creatureB));

    // A stops attacking faction 90002 (B's faction)
    _creatureA->StopAttackFaction(90002);

    // A should no longer be in combat with B, and threat should be cleared
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));

    // C's combat with B should be unaffected
    EXPECT_TRUE(creatureC->TestGetCombatMgr().IsInCombatWith(_creatureB));

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// ClearInCombat Tests (deferred flag removal)
// ============================================================================

TEST_F(CombatManagerIntegrationTest, ClearInCombat_ClearsAllState)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().HasCombat());

    _creatureA->ClearInCombat();

    // All combat and threat should be cleared
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().HasCombat());
    EXPECT_FALSE(_creatureA->IsInCombat());
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 0u);
}

// ============================================================================
// Evade Timer Flow Tests
// Tests the complete evade timer lifecycle:
//   StartEvadeTimer -> countdown -> expiry -> EvadeTimerExpired callback
// ============================================================================

TEST_F(CombatManagerIntegrationTest, EvadeTimer_PartialCountdown_StillActive)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    cm.StartEvadeTimer();
    EXPECT_TRUE(cm.IsInEvadeMode());

    // Advance 3 seconds — timer started at 10s, should still be active
    cm.Update(3000);
    EXPECT_TRUE(cm.IsInEvadeMode());

    // Advance another 3 seconds — 6s total, still active
    cm.Update(3000);
    EXPECT_TRUE(cm.IsInEvadeMode());

    cm.StopEvade();
}

TEST_F(CombatManagerIntegrationTest, EvadeTimer_FullCountdown_Expires)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    cm.StartEvadeTimer();
    EXPECT_TRUE(cm.IsInEvadeMode());

    // Advance the full 10 seconds — timer should expire
    // Note: EvadeTimerExpired would be called but no AI is set in tests,
    // so it's a no-op. We verify the timer state itself.
    cm.Update(CombatManager::EVADE_TIMER_DURATION);

    // Timer has expired and no evade state was set by AI callback
    EXPECT_FALSE(cm.IsInEvadeMode());
}

TEST_F(CombatManagerIntegrationTest, EvadeTimer_Overshoot_StillExpires)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    cm.StartEvadeTimer();

    // Advance more than the timer duration
    cm.Update(CombatManager::EVADE_TIMER_DURATION + 5000);

    EXPECT_FALSE(cm.IsInEvadeMode());
}

TEST_F(CombatManagerIntegrationTest, EvadeTimer_IncrementalCountdown_Expires)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    cm.StartEvadeTimer();

    // Advance in 1-second increments
    for (uint32 i = 0; i < 9; ++i)
    {
        cm.Update(1000);
        EXPECT_TRUE(cm.IsInEvadeMode()) << "Timer should be active at " << (i + 1) << "s";
    }

    // 10th second — should expire
    cm.Update(1000);
    EXPECT_FALSE(cm.IsInEvadeMode());
}

TEST_F(CombatManagerIntegrationTest, EvadeTimer_StopEvade_CancelsBeforeExpiry)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    cm.StartEvadeTimer();
    cm.Update(5000); // 5 seconds in
    EXPECT_TRUE(cm.IsInEvadeMode());

    cm.StopEvade();
    EXPECT_FALSE(cm.IsInEvadeMode());

    // Further updates should not re-trigger anything
    cm.Update(10000);
    EXPECT_FALSE(cm.IsInEvadeMode());
}

TEST_F(CombatManagerIntegrationTest, EvadeTimer_RestartAfterStop_WorksAgain)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    cm.StartEvadeTimer();
    cm.Update(5000);
    cm.StopEvade();
    EXPECT_FALSE(cm.IsInEvadeMode());

    // Restart the timer
    cm.StartEvadeTimer();
    EXPECT_TRUE(cm.IsInEvadeMode());

    cm.Update(5000);
    EXPECT_TRUE(cm.IsInEvadeMode()); // Still active — 5s into new 10s timer

    cm.Update(5000);
    EXPECT_FALSE(cm.IsInEvadeMode()); // Expired
}

// ============================================================================
// Evade Timer + Regen Phase Interaction
// Tests the IsEvadeRegen state machine.
// Timer > EVADE_REGEN_DELAY: not in regen (just counting down)
// Timer <= EVADE_REGEN_DELAY: in regen (creature should regenerate)
// ============================================================================

TEST_F(CombatManagerIntegrationTest, EvadeTimer_InitialStart_NotInRegen)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    // StartEvadeTimer sets timer to 10s — above the 5s regen threshold
    cm.StartEvadeTimer();
    EXPECT_TRUE(cm.IsInEvadeMode());
    EXPECT_FALSE(cm.IsEvadeRegen());
}

TEST_F(CombatManagerIntegrationTest, EvadeTimer_CountdownToRegenPhase)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    cm.StartEvadeTimer();

    // Advance 5 seconds — timer is now at exactly EVADE_REGEN_DELAY (5000)
    cm.Update(CombatManager::EVADE_TIMER_DURATION - CombatManager::EVADE_REGEN_DELAY);
    EXPECT_TRUE(cm.IsInEvadeMode());
    EXPECT_TRUE(cm.IsEvadeRegen()); // timer <= EVADE_REGEN_DELAY

    // Advance 1 more second — timer at 4000, still in regen
    cm.Update(1000);
    EXPECT_TRUE(cm.IsEvadeRegen());
}

TEST_F(CombatManagerIntegrationTest, EvadeTimer_ContinueEvadeRegen_ResetsToRegenDelay)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    // Start from a non-regen state
    cm.StartEvadeTimer();
    EXPECT_FALSE(cm.IsEvadeRegen());

    // ContinueEvadeRegen jumps the timer directly to the regen delay value
    cm.ContinueEvadeRegen();
    EXPECT_TRUE(cm.IsEvadeRegen());
    EXPECT_TRUE(cm.IsInEvadeMode());

    // Advance 4 seconds — timer at 1000, still regen
    cm.Update(4000);
    EXPECT_TRUE(cm.IsEvadeRegen());

    // Advance final 1 second — timer expires
    cm.Update(1000);
    EXPECT_FALSE(cm.IsInEvadeMode());
    EXPECT_FALSE(cm.IsEvadeRegen());
}

TEST_F(CombatManagerIntegrationTest, EvadeTimer_ContinueEvadeRegen_RepeatKeepsRegen)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    // In raids, ContinueEvadeRegen is called repeatedly to keep regen going
    cm.ContinueEvadeRegen();
    EXPECT_TRUE(cm.IsEvadeRegen());

    // Advance 3 seconds
    cm.Update(3000);
    EXPECT_TRUE(cm.IsEvadeRegen());

    // Call ContinueEvadeRegen again (simulates raid behavior — reset timer)
    cm.ContinueEvadeRegen();
    EXPECT_TRUE(cm.IsEvadeRegen());

    // Advance another 3 seconds (timer reset to 5s, so 3s in, still active)
    cm.Update(3000);
    EXPECT_TRUE(cm.IsEvadeRegen());
}

// ============================================================================
// Evade State + Timer Interaction Tests
// Tests how SetEvadeState interacts with the evade timer.
// ============================================================================

TEST_F(CombatManagerIntegrationTest, EvadeState_SetToNone_ClearsTimer)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    cm.StartEvadeTimer();
    EXPECT_TRUE(cm.IsInEvadeMode());

    // SetEvadeState(NONE) has an early return if _evadeState is already NONE.
    // Set to HOME first so that the NONE transition actually executes.
    cm.SetEvadeState(EVADE_STATE_HOME);
    EXPECT_TRUE(cm.IsInEvadeMode());

    // Now setting to NONE should clear the timer
    cm.SetEvadeState(EVADE_STATE_NONE);
    EXPECT_FALSE(cm.IsInEvadeMode());
    EXPECT_EQ(cm.GetEvadeState(), EVADE_STATE_NONE);
}

TEST_F(CombatManagerIntegrationTest, EvadeState_HomeState_IsInEvadeMode)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    cm.SetEvadeState(EVADE_STATE_HOME);

    EXPECT_TRUE(cm.IsInEvadeMode());
    EXPECT_TRUE(cm.IsEvadingHome());
    EXPECT_TRUE(cm.IsEvadeRegen()); // _evadeState != NONE triggers regen
}

TEST_F(CombatManagerIntegrationTest, EvadeState_CombatState_IsInEvadeMode)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    cm.SetEvadeState(EVADE_STATE_COMBAT);

    EXPECT_TRUE(cm.IsInEvadeMode());
    EXPECT_FALSE(cm.IsEvadingHome());
    EXPECT_TRUE(cm.IsEvadeRegen());
}

TEST_F(CombatManagerIntegrationTest, EvadeState_FullLifecycle)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    // Phase 1: Target unreachable → start evade timer
    EXPECT_EQ(cm.GetEvadeState(), EVADE_STATE_NONE);
    EXPECT_FALSE(cm.IsInEvadeMode());

    cm.StartEvadeTimer();
    EXPECT_TRUE(cm.IsInEvadeMode());
    EXPECT_FALSE(cm.IsEvadeRegen()); // Timer at 10s, above regen threshold
    EXPECT_EQ(cm.GetEvadeState(), EVADE_STATE_NONE); // State not changed yet

    // Phase 2: Timer counts down past regen threshold
    cm.Update(6000); // 4s left
    EXPECT_TRUE(cm.IsEvadeRegen());

    // Phase 3: Timer expires
    cm.Update(4000);
    EXPECT_FALSE(cm.IsInEvadeMode()); // No AI to set state

    // Phase 4: Simulate what AI would do — set state to HOME
    cm.SetEvadeState(EVADE_STATE_HOME);
    EXPECT_TRUE(cm.IsInEvadeMode());
    EXPECT_TRUE(cm.IsEvadingHome());

    // Phase 5: Creature arrives home — state cleared
    cm.SetEvadeState(EVADE_STATE_NONE);
    EXPECT_FALSE(cm.IsInEvadeMode());
    EXPECT_FALSE(cm.IsEvadingHome());
    EXPECT_FALSE(cm.IsEvadeRegen());
}

TEST_F(CombatManagerIntegrationTest, EvadeTimer_StopEvade_WithActiveState_ClearsState)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    // Set evade state (no timer involved)
    cm.SetEvadeState(EVADE_STATE_HOME);
    EXPECT_TRUE(cm.IsInEvadeMode());

    // StopEvade should clear the state
    cm.StopEvade();
    EXPECT_FALSE(cm.IsInEvadeMode());
    EXPECT_EQ(cm.GetEvadeState(), EVADE_STATE_NONE);
}

TEST_F(CombatManagerIntegrationTest, EvadeTimer_StopEvade_TimerAndState_ClearsBoth)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    // Both timer and state active
    cm.StartEvadeTimer();
    cm.SetEvadeState(EVADE_STATE_COMBAT);
    EXPECT_TRUE(cm.IsInEvadeMode());

    // StopEvade clears both timer and state in a single call
    cm.StopEvade();
    EXPECT_FALSE(cm.IsInEvadeMode());
    EXPECT_EQ(cm.GetEvadeState(), EVADE_STATE_NONE);
}

// ============================================================================
// SetCannotReachTarget Integration Tests
// Verifies Creature::SetCannotReachTarget starts/stops evade timer.
// ============================================================================

TEST_F(CombatManagerIntegrationTest, SetCannotReachTarget_StartsEvadeTimer)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    EXPECT_FALSE(cm.IsInEvadeMode());

    // Setting a target as unreachable starts the evade timer
    _creatureA->SetCannotReachTarget(_creatureB->GetGUID());
    EXPECT_TRUE(cm.IsInEvadeMode());
    EXPECT_TRUE(_creatureA->CanNotReachTarget());
}

TEST_F(CombatManagerIntegrationTest, SetCannotReachTarget_Clear_StopsEvade)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    _creatureA->SetCannotReachTarget(_creatureB->GetGUID());
    EXPECT_TRUE(cm.IsInEvadeMode());

    // Clear unreachable target — should stop evade
    _creatureA->SetCannotReachTarget();
    EXPECT_FALSE(cm.IsInEvadeMode());
    EXPECT_FALSE(_creatureA->CanNotReachTarget());
}

TEST_F(CombatManagerIntegrationTest, SetCannotReachTarget_SameTarget_NoDuplicate)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    _creatureA->SetCannotReachTarget(_creatureB->GetGUID());
    EXPECT_TRUE(cm.IsInEvadeMode());

    // Count down 5 seconds
    cm.Update(5000);

    // Setting the same target again should be a no-op (early return)
    _creatureA->SetCannotReachTarget(_creatureB->GetGUID());

    // Timer should NOT have been restarted — still mid-countdown
    // Advance 5 more seconds, timer should expire (was at 5s remaining)
    cm.Update(5000);
    EXPECT_FALSE(cm.IsInEvadeMode());
}

TEST_F(CombatManagerIntegrationTest, IsNotReachableAndNeedRegen_Integration)
{
    auto& cm = _creatureA->TestGetCombatMgr();

    EXPECT_FALSE(_creatureA->IsNotReachableAndNeedRegen());

    // Set unreachable — starts timer at 10s, not in regen yet
    _creatureA->SetCannotReachTarget(_creatureB->GetGUID());
    EXPECT_FALSE(_creatureA->IsNotReachableAndNeedRegen());

    // Advance past the regen threshold
    cm.Update(6000); // 4s left, within regen range
    EXPECT_TRUE(_creatureA->IsNotReachableAndNeedRegen());

    // Clear unreachable — regen stops
    _creatureA->SetCannotReachTarget();
    EXPECT_FALSE(_creatureA->IsNotReachableAndNeedRegen());
}

// ============================================================================
// CombatReference Suppression Tests
// Verifies that suppressed combat refs don't generate combat state.
// ============================================================================

TEST_F(CombatManagerIntegrationTest, SuppressedRef_DoesNotGenerateCombat)
{
    // Create combat with second unit suppressed
    bool result = _creatureA->TestGetCombatMgr().SetInCombatWith(
        _creatureB, /* addSecondUnitSuppressed */ true);
    EXPECT_TRUE(result);

    // A should be in combat (not suppressed)
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().HasPvECombat());
    // B's side is suppressed — check HasPvECombat (which skips suppressed refs)
    EXPECT_FALSE(_creatureB->TestGetCombatMgr().HasPvECombat());

    // But the reference still exists on both sides
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));
    EXPECT_TRUE(_creatureB->TestGetCombatMgr().IsInCombatWith(_creatureA));
}

} // namespace
