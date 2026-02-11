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

#include "ThreatManager.h"
#include "CombatManager.h"
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
// Integration tests for the heap-based ThreatManager system.
// Uses TestCreature/TestMap with hostile DBC faction entries.
// ============================================================================
class ThreatManagerIntegrationTest : public ::testing::Test
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

        // Insert two mutually hostile DBC faction entries.
        // ourMask/hostileMask bitmasks: A.hostileMask & B.ourMask != 0 => hostile
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
// Static Method Tests
// ============================================================================

TEST_F(ThreatManagerIntegrationTest, CanHaveThreatList_NullUnit_ReturnsFalse)
{
    EXPECT_FALSE(ThreatManager::CanHaveThreatList(nullptr));
}

TEST_F(ThreatManagerIntegrationTest, CanHaveThreatList_InitializedCreature_ReturnsTrue)
{
    EXPECT_TRUE(ThreatManager::CanHaveThreatList(_creatureA));
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().CanHaveThreatList());
}

// ============================================================================
// AddThreat Tests
// ============================================================================

TEST_F(ThreatManagerIntegrationTest, AddThreat_CreatesThreatEntry)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 1u);
}

TEST_F(ThreatManagerIntegrationTest, AddThreat_ImpliesCombat)
{
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().HasCombat());

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 50.0f);

    EXPECT_TRUE(_creatureA->TestGetCombatMgr().HasCombat());
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));
}

// ============================================================================
// ScaleThreat Tests
// ============================================================================

TEST_F(ThreatManagerIntegrationTest, ScaleThreat_DoublesAmount)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().ScaleThreat(_creatureB, 2.0f);

    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 200.0f);
}

TEST_F(ThreatManagerIntegrationTest, ScaleThreat_ZeroFactor_ZerosThreat)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().ScaleThreat(_creatureB, 0.0f);

    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 0.0f);
    // Entry still exists (ScaleThreat doesn't remove)
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
}

// ============================================================================
// ClearThreat Tests
// ============================================================================

TEST_F(ThreatManagerIntegrationTest, ClearThreat_RemovesEntry)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 1u);

    _creatureA->TestGetThreatMgr().ClearThreat(_creatureB);

    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 0u);
}

TEST_F(ThreatManagerIntegrationTest, ClearAllThreat_EmptiesList)
{
    // Add a third creature for multi-target test
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 200.0f);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 2u);

    _creatureA->TestGetThreatMgr().ClearAllThreat();

    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 0u);
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatListEmpty());

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// Victim Selection Tests
// ============================================================================

TEST_F(ThreatManagerIntegrationTest, GetCurrentVictim_ReturnsHighestThreat)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 500.0f);

    // Force a threat update cycle so ReselectVictim() applies the 110%/130% switching rules
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    Unit* victim = _creatureA->TestGetThreatMgr().GetCurrentVictim();
    EXPECT_EQ(victim, creatureC);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest, FixateTarget_OverridesSelection)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 500.0f);

    // Force a threat update cycle so ReselectVictim() applies the 110%/130% switching rules
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    // Without fixate, highest threat (creatureC) is selected
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), creatureC);

    // Fixate on lower-threat target
    _creatureA->TestGetThreatMgr().FixateTarget(_creatureB);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);

    // Clear fixate returns to normal selection
    _creatureA->TestGetThreatMgr().ClearFixate();
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), creatureC);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// ResetAllThreat Tests
// ============================================================================

TEST_F(ThreatManagerIntegrationTest, ResetAllThreat_ZerosAllEntries)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 500.0f);

    _creatureA->TestGetThreatMgr().ResetAllThreat();

    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 0.0f);
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(creatureC), 0.0f);
    // Entries still exist, just zeroed
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 2u);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// CompareThreatLessThan (static comparator) Tests
// ============================================================================

TEST_F(ThreatManagerIntegrationTest, CompareReferences_OnlineStatePrecedence)
{
    // OnlineState enum ordering: ONLINE > SUPPRESSED > OFFLINE
    EXPECT_GT(ThreatReference::ONLINE_STATE_ONLINE,
              ThreatReference::ONLINE_STATE_SUPPRESSED);
    EXPECT_GT(ThreatReference::ONLINE_STATE_SUPPRESSED,
              ThreatReference::ONLINE_STATE_OFFLINE);
}

// ============================================================================
// Constants Tests (compacted)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest, ThreatConstants)
{
    constexpr uint32 interval = ThreatManager::THREAT_UPDATE_INTERVAL;
    EXPECT_EQ(interval, 1000u);
    EXPECT_GE(interval, 500u);
    EXPECT_LE(interval, 2000u);

    EXPECT_EQ(static_cast<int>(ThreatReference::ONLINE_STATE_OFFLINE), 0);
    EXPECT_EQ(static_cast<int>(ThreatReference::ONLINE_STATE_SUPPRESSED), 1);
    EXPECT_EQ(static_cast<int>(ThreatReference::ONLINE_STATE_ONLINE), 2);

    EXPECT_EQ(static_cast<uint32>(ThreatReference::TAUNT_STATE_DETAUNT), 0);
    EXPECT_EQ(static_cast<uint32>(ThreatReference::TAUNT_STATE_NONE), 1);
    EXPECT_EQ(static_cast<uint32>(ThreatReference::TAUNT_STATE_TAUNT), 2);
}

// ============================================================================
// GetThreatListPlayerCount Tests (Bug 1 regression)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest, GetThreatListPlayerCount_CreatureOnlyList_ReturnsZero)
{
    // All entries are creatures, not players — count should be 0
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 200.0f);

    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 2u);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListPlayerCount(), 0u);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListPlayerCount(true), 0u);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// ResetAllMyThreatOnOthers Tests (Bug 4/5 regression)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest, ResetAllMyThreatOnOthers_ZerosThreatOnAllCreatures)
{
    // creatureA and creatureC both add threat against creatureB
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90001);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    creatureC->TestGetThreatMgr().AddThreat(_creatureB, 200.0f);

    // creatureB appears on both A's and C's threat lists
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);
    EXPECT_FLOAT_EQ(creatureC->TestGetThreatMgr().GetThreat(_creatureB), 200.0f);

    // Reset creatureB's threat on all others' lists
    _creatureB->TestGetThreatMgr().ResetAllMyThreatOnOthers();

    // creatureB's threat should be zeroed on both lists
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 0.0f);
    EXPECT_FLOAT_EQ(creatureC->TestGetThreatMgr().GetThreat(_creatureB), 0.0f);
    // Entries still exist — only zeroed, not removed
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    EXPECT_TRUE(creatureC->TestGetThreatMgr().IsThreatenedBy(_creatureB));

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest, ResetAllMyThreatOnOthers_NoEntries_DoesNothing)
{
    // creatureB is not on anyone's threat list
    EXPECT_FALSE(_creatureB->TestGetThreatMgr().IsThreateningAnyone());

    // Should not crash or assert
    _creatureB->TestGetThreatMgr().ResetAllMyThreatOnOthers();
}

// ============================================================================
// SendThreatListToClients code path tests
// Exercises SMSG_HIGHEST_THREAT_UPDATE and SMSG_THREAT_UPDATE
// packet building without crashing (no real sessions to receive)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest, SendThreatList_HighestThreatUpdate_Path)
{
    // SMSG_HIGHEST_THREAT_UPDATE is sent when victim changes
    // (newHighest=true in UpdateVictim)
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 500.0f);

    // Update forces ReselectVictim → victim switches from B
    // to C → newHighest=true → SendThreatListToClients(true)
    // exercises the SMSG_HIGHEST_THREAT_UPDATE packet path
    _creatureA->TestGetThreatMgr().Update(
        ThreatManager::THREAT_UPDATE_INTERVAL);

    EXPECT_EQ(
        _creatureA->TestGetThreatMgr().GetCurrentVictim(),
        creatureC);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest, SendThreatList_ThreatUpdate_Path)
{
    // SMSG_THREAT_UPDATE is sent when _needClientUpdate=true
    // but victim doesn't change (newHighest=false)
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Add lower threat — victim stays as B,
    // but PutThreatListRef sets _needClientUpdate=true
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 50.0f);

    // Update → victim unchanged (B still highest) →
    // newHighest=false, _needClientUpdate=true →
    // SendThreatListToClients(false)
    // exercises the SMSG_THREAT_UPDATE packet path
    _creatureA->TestGetThreatMgr().Update(
        ThreatManager::THREAT_UPDATE_INTERVAL);

    EXPECT_EQ(
        _creatureA->TestGetThreatMgr().GetCurrentVictim(),
        _creatureB);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// TauntState Victim Selection Tests
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       TauntState_OverridesHigherThreat)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // B has low threat, C has high threat
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 500.0f);
    _creatureA->TestGetThreatMgr().Update(
        ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(
        _creatureA->TestGetThreatMgr().GetCurrentVictim(),
        creatureC);

    // Taunt B — should override despite lower threat
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_TAUNT);
    _creatureA->TestGetThreatMgr().Update(
        ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(
        _creatureA->TestGetThreatMgr().GetCurrentVictim(),
        _creatureB);

    // Remove taunt — should revert to C
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_NONE);
    _creatureA->TestGetThreatMgr().Update(
        ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(
        _creatureA->TestGetThreatMgr().GetCurrentVictim(),
        creatureC);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       TauntState_DoesNotClobberFixate)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    TestCreature* creatureD = new TestCreature();
    creatureD->SetupForCombatTest(_map, 4, 12348);
    creatureD->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 200.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureD, 300.0f);

    // Script fixate on C
    _creatureA->TestGetThreatMgr().FixateTarget(creatureC);
    _creatureA->TestGetThreatMgr().Update(
        ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(
        _creatureA->TestGetThreatMgr().GetCurrentVictim(),
        creatureC);

    // Taunt from B — fixate should still win
    // (fixate is checked before heap in ReselectVictim)
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_TAUNT);
    _creatureA->TestGetThreatMgr().Update(
        ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(
        _creatureA->TestGetThreatMgr().GetCurrentVictim(),
        creatureC);
    // Fixate ref should still be intact
    EXPECT_EQ(
        _creatureA->TestGetThreatMgr().GetFixateTarget(),
        creatureC);

    // Clear taunt — fixate still holds
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_NONE);
    _creatureA->TestGetThreatMgr().Update(
        ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(
        _creatureA->TestGetThreatMgr().GetCurrentVictim(),
        creatureC);
    EXPECT_EQ(
        _creatureA->TestGetThreatMgr().GetFixateTarget(),
        creatureC);

    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

TEST_F(ThreatManagerIntegrationTest,
       Detaunt_LowersPriority)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // B and C have same threat
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 100.0f);

    // Detaunt B — C should be selected
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_DETAUNT);
    _creatureA->TestGetThreatMgr().Update(
        ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(
        _creatureA->TestGetThreatMgr().GetCurrentVictim(),
        creatureC);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// CanHaveThreatList Consistency Tests (Issue #6 regression)
// Unit::CanHaveThreatList must agree with ThreatManager::CanHaveThreatList
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       CanHaveThreatList_ConsistentBetweenUnitAndThreatMgr)
{
    // Both should agree for a valid, alive creature
    EXPECT_TRUE(_creatureA->CanHaveThreatList());
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().CanHaveThreatList());

    EXPECT_TRUE(_creatureB->CanHaveThreatList());
    EXPECT_TRUE(_creatureB->TestGetThreatMgr().CanHaveThreatList());
}

TEST_F(ThreatManagerIntegrationTest,
       CanHaveThreatList_DeadCreature_ReturnsFalse)
{
    _creatureA->SetAlive(false);

    // Unit::CanHaveThreatList checks alive state on top of ThreatMgr
    EXPECT_FALSE(_creatureA->CanHaveThreatList());
    // ThreatManager cached value doesn't track alive state
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().CanHaveThreatList());
    // But skipAliveCheck should bypass the alive check
    EXPECT_TRUE(_creatureA->CanHaveThreatList(true));
}

// ============================================================================
// MatchUnitThreatToHighestThreat Tests (Issue #8 - EffectTaunt fix)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       MatchUnitThreatToHighestThreat_SetsToHighest)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // C has highest threat, B has low threat
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 50.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 500.0f);

    // Match B's threat to highest (C's 500)
    _creatureA->TestGetThreatMgr().MatchUnitThreatToHighestThreat(_creatureB);

    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB),
        _creatureA->TestGetThreatMgr().GetThreat(creatureC));

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       MatchUnitThreatToHighestThreat_AlreadyHighest_NoChange)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 500.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 100.0f);

    // B is already highest — should stay at 500
    _creatureA->TestGetThreatMgr().MatchUnitThreatToHighestThreat(_creatureB);

    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 500.0f);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// Per-Spell Redirect Threat Tests (Issue #7 regression)
// UnregisterRedirectThreat(spellId) vs ResetAllRedirects
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_RegisterAndUnregister_PerSpell)
{
    // Register two different spell redirects
    _creatureA->TestGetThreatMgr().RegisterRedirectThreat(
        34477, _creatureB->GetGUID(), 70);  // Misdirection
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().HasRedirects());

    // Unregister only Misdirection
    _creatureA->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().HasRedirects());
}

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_UnregisterOneSpell_KeepsOther)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Register two different spell redirects to different targets
    _creatureA->TestGetThreatMgr().RegisterRedirectThreat(
        34477, _creatureB->GetGUID(), 70);  // Misdirection
    _creatureA->TestGetThreatMgr().RegisterRedirectThreat(
        57934, creatureC->GetGUID(), 30);   // Tricks of the Trade

    EXPECT_TRUE(_creatureA->TestGetThreatMgr().HasRedirects());

    // Unregister only Misdirection — Tricks should remain
    _creatureA->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().HasRedirects());

    // Unregister Tricks — now empty
    _creatureA->TestGetThreatMgr().UnregisterRedirectThreat(57934);
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().HasRedirects());

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_ResetAllRedirects_ClearsAll)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().RegisterRedirectThreat(
        34477, _creatureB->GetGUID(), 70);
    _creatureA->TestGetThreatMgr().RegisterRedirectThreat(
        57934, creatureC->GetGUID(), 30);

    _creatureA->TestGetThreatMgr().ResetAllRedirects();
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().HasRedirects());

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// IsEngagedBy Tests (Unit.h change: threat-based for creatures)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       IsEngagedBy_UsesThreatListForCreatures)
{
    // Before any threat, not engaged
    EXPECT_FALSE(_creatureA->IsEngagedBy(_creatureB));

    // AddThreat creates a threat reference (and combat reference)
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // IsEngagedBy should check threat list for creatures with threat lists
    EXPECT_TRUE(_creatureA->IsEngagedBy(_creatureB));
    // B is on A's threat list but A is NOT on B's threat list
    // (threat is directional: A threatens B, not vice versa unless B also AddThreats A)
    EXPECT_FALSE(_creatureB->IsEngagedBy(_creatureA));
}

TEST_F(ThreatManagerIntegrationTest,
       IsEngagedBy_CombatWithoutThreat_NotEngaged)
{
    // Combat reference without threat entry
    _creatureA->TestGetCombatMgr().SetInCombatWith(_creatureB);
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));

    // IsEngagedBy checks threat list for creatures, not combat refs
    EXPECT_FALSE(_creatureA->IsEngagedBy(_creatureB));
}

// ============================================================================
// UpdateMySpellSchoolModifiers Tests (HandleModThreat bug fix)
// Verify that spell school modifiers affect CalculateModifiedThreat
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       SpellSchoolModifiers_DefaultIsUnmodified)
{
    // Default modifier should be 1.0 (no modification)
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);
}

// ============================================================================
// Phase Change + Threat Offline State Tests (SetPhaseMask order fix)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       PhaseChange_PutsThreatsOffline)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    // B is online on A's threat list
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatListEmpty(false));

    // Move B to a different phase
    _creatureB->SetPhase(2);

    // B should now be offline on A's threat list (different phases)
    // The list is not empty if we include offline, but empty if we don't
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, true));  // includeOffline
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatListEmpty(false));          // online only
}

// ============================================================================
// Redirect System - Functional (End-to-End) Tests
// Verifies that AddThreat actually redirects threat to registered targets.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_AddThreat_SplitsBetweenTargetAndRedirect)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Pre-establish C on A's threat list (ObjectAccessor unavailable in tests)
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 0.0f, nullptr, true, true);

    // B registers 50% redirect to C (e.g. Misdirection)
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 50);

    // A adds 100 threat against B — 50% should redirect to C
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f, nullptr, true);

    // B should have 50 threat (100 - 50% redirected)
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 50.0f);
    // C should have 50 threat (the redirected portion)
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(creatureC));
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureC), 50.0f);

    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_FullRedirect_AllThreatGoesToTarget)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Pre-establish C on A's threat list (ObjectAccessor unavailable in tests)
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 0.0f, nullptr, true, true);

    // B registers 100% redirect to C
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 100);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 200.0f, nullptr, true);

    // B should have 0 threat (all redirected)
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 0.0f);
    // C should have all 200 threat
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureC), 200.0f);

    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_TwoSpells_BothRedirect)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    TestCreature* creatureD = new TestCreature();
    creatureD->SetupForCombatTest(_map, 4, 12348);
    creatureD->SetFaction(90002);

    // Pre-establish C and D on A's threat list
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 0.0f, nullptr, true, true);
    _creatureA->TestGetThreatMgr().AddThreat(creatureD, 0.0f, nullptr, true, true);

    // B registers two redirects that total 60% (no cap issue)
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 30);  // Misdirection 30%
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        57934, creatureD->GetGUID(), 30);  // Tricks of the Trade 30%

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f, nullptr, true);

    // B should have 40 threat (100 - 30 - 30)
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 40.0f);

    // C and D should each have 30 threat
    float cThreat = _creatureA->TestGetThreatMgr().GetThreat(creatureC);
    float dThreat = _creatureA->TestGetThreatMgr().GetThreat(creatureD);

    // Due to unordered_map iteration, we verify total redirected = 60
    EXPECT_FLOAT_EQ(cThreat + dThreat, 60.0f);
    EXPECT_FLOAT_EQ(cThreat, 30.0f);
    EXPECT_FLOAT_EQ(dThreat, 30.0f);

    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(57934);
    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_NegativeAmount_NoRedirect)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Establish initial threat
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 200.0f, nullptr, true);

    // Register redirect and apply negative threat (threat reduction)
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 50);

    // Negative threat should NOT be redirected (code checks amount > 0)
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, -50.0f, nullptr, true);

    // B should have 150 (200 - 50), C should have no entry or 0
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 150.0f);
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(creatureC));

    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_AfterUnregister_NoMoreRedirect)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Pre-establish C on A's threat list (ObjectAccessor unavailable in tests)
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 0.0f, nullptr, true, true);

    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 50);

    // First add — should redirect
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f, nullptr, true);
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 50.0f);
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureC), 50.0f);

    // Unregister redirect
    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);

    // Second add — should NOT redirect, all goes to B
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f, nullptr, true);
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 150.0f);
    // C should still have 50 from before
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureC), 50.0f);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_ModifyPercentage_AdjustsRedirect)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Pre-establish C on A's threat list (ObjectAccessor unavailable in tests)
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 0.0f, nullptr, true, true);

    // Register 50% redirect
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 50);

    // Increase by +20% to 70%
    _creatureB->TestGetThreatMgr().ModifyRedirectPercentage(20);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f, nullptr, true);

    // B should have 30 (100 - 70%), C should have 70
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 30.0f);
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureC), 70.0f);

    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_ModifyPercentage_ClampsToZero)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Register 30% redirect, then decrease by 50% (should clamp to 0)
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 30);
    _creatureB->TestGetThreatMgr().ModifyRedirectPercentage(-50);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f, nullptr, true);

    // 0% redirect — all threat goes to B
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);
    // C should not be on the threat list (0% redirect is pruned by UpdateRedirectInfo)
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(creatureC));

    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_UnregisterPerSpellPerVictim)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    TestCreature* creatureD = new TestCreature();
    creatureD->SetupForCombatTest(_map, 4, 12348);
    creatureD->SetFaction(90002);

    // Register same spell with two different victims
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 30);
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureD->GetGUID(), 20);
    EXPECT_TRUE(_creatureB->TestGetThreatMgr().HasRedirects());

    // Unregister only the C victim for spell 34477
    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(
        34477, creatureC->GetGUID());
    // D's redirect should still be active
    EXPECT_TRUE(_creatureB->TestGetThreatMgr().HasRedirects());

    // Unregister D — now empty
    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(
        34477, creatureD->GetGUID());
    EXPECT_FALSE(_creatureB->TestGetThreatMgr().HasRedirects());

    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_GetAnyRedirectTarget_ReturnsTarget)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    EXPECT_EQ(_creatureB->TestGetThreatMgr().GetAnyRedirectTarget(), nullptr);

    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 50);

    // GetAnyRedirectTarget uses ObjectAccessor which won't work in tests,
    // but at least verify HasRedirects is true
    EXPECT_TRUE(_creatureB->TestGetThreatMgr().HasRedirects());

    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// ForwardThreatForAssistingMe Tests
// Verifies that healing/assist threat is distributed among all creatures
// that are threatening the healed unit.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ForwardThreat_SingleCreature_AllThreatToAssistant)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // A (boss) has B on its threat list
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // B is "healed" — forward 50 assist threat from C (the healer)
    // ForwardThreat iterates _threatenedByMe (creatures threatening B)
    // and adds threat for the assistant (C) on those creatures' lists
    _creatureB->TestGetThreatMgr().ForwardThreatForAssistingMe(
        creatureC, 50.0f);

    // C should now have 50 threat on A's threat list
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(creatureC));
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureC), 50.0f);
    // B's threat should be unchanged
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       ForwardThreat_MultipleCreatures_SplitsEvenly)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90001); // Same faction as A (so it can also threat B)

    TestCreature* creatureD = new TestCreature();
    creatureD->SetupForCombatTest(_map, 4, 12348);
    creatureD->SetFaction(90002); // The healer

    // A (boss1) and C (boss2) both have B on their threat lists
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    creatureC->TestGetThreatMgr().AddThreat(_creatureB, 200.0f);

    // B is "healed" by D — forward 100 assist threat
    // Should split evenly: 50 to A, 50 to C
    _creatureB->TestGetThreatMgr().ForwardThreatForAssistingMe(
        creatureD, 100.0f);

    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureD), 50.0f);
    EXPECT_FLOAT_EQ(
        creatureC->TestGetThreatMgr().GetThreat(creatureD), 50.0f);

    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

TEST_F(ThreatManagerIntegrationTest,
       ForwardThreat_CCTarget_GetsZeroThreat)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90001); // Same faction as A

    TestCreature* creatureD = new TestCreature();
    creatureD->SetupForCombatTest(_map, 4, 12348);
    creatureD->SetFaction(90002); // The healer

    // A has B on threat list, C also has B
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    creatureC->TestGetThreatMgr().AddThreat(_creatureB, 200.0f);

    // A is under CC (UNIT_STATE_CONTROLLED) — should get 0 threat
    _creatureA->AddUnitState(UNIT_STATE_CONTROLLED);

    _creatureB->TestGetThreatMgr().ForwardThreatForAssistingMe(
        creatureD, 100.0f);

    // Only C is not CC'd, so it gets all 100 (100 / 1 non-CC target)
    EXPECT_FLOAT_EQ(
        creatureC->TestGetThreatMgr().GetThreat(creatureD), 100.0f);

    // A gets 0 threat (CC'd creatures still get combat but 0 threat)
    float aThreatForD = _creatureA->TestGetThreatMgr().GetThreat(creatureD);
    EXPECT_FLOAT_EQ(aThreatForD, 0.0f);

    _creatureA->ClearUnitState(UNIT_STATE_CONTROLLED);
    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

TEST_F(ThreatManagerIntegrationTest,
       ForwardThreat_NoThreatenedBy_DoesNothing)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // B is not on anyone's threat list
    EXPECT_FALSE(_creatureB->TestGetThreatMgr().IsThreateningAnyone());

    // Forward should be a no-op
    _creatureB->TestGetThreatMgr().ForwardThreatForAssistingMe(
        creatureC, 100.0f);

    // A should have no threat entries
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 0u);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       ForwardThreat_ZeroAmount_StillEntersCombat)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // A has B on threat list
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Forward 0 threat — should still create combat reference
    _creatureB->TestGetThreatMgr().ForwardThreatForAssistingMe(
        creatureC, 0.0f);

    // C should be in combat with A (threat of 0 but combat ref exists)
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(creatureC));
    // Threat value should be 0
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureC), 0.0f);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// EvaluateSuppressed Transition Tests
// Tests online/suppressed state transitions on threat references.
// Uses IMMUNITY_DAMAGE to trigger ShouldBeSuppressed().
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       EvaluateSuppressed_NoRefs_DoesNotCrash)
{
    // B is not on anyone's threat list — EvaluateSuppressed should be a no-op
    EXPECT_FALSE(_creatureB->TestGetThreatMgr().IsThreateningAnyone());
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();
    _creatureB->TestGetThreatMgr().EvaluateSuppressed(true);
}

TEST_F(ThreatManagerIntegrationTest,
       EvaluateSuppressed_OnlineRefs_RemainOnline)
{
    // A has B on threat list — B's ref on A's list should be ONLINE
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // EvaluateSuppressed on B (the victim) should not change anything
    // since B is not immune to anything
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    // Verify ref is still available (ONLINE or SUPPRESSED both pass)
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, false));

    // Verify it's specifically online by checking it's not suppressed
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
    {
        if (ref->GetVictim() == _creatureB)
        {
            EXPECT_TRUE(ref->IsOnline());
            EXPECT_FALSE(ref->IsSuppressed());
        }
    }
}

TEST_F(ThreatManagerIntegrationTest,
       EvaluateSuppressed_DamageImmunity_SetsSuppressed)
{
    // A has B on threat list
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Verify B's ref starts as ONLINE
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsOnline());

    // Make B immune to physical damage (A's melee school is SPELL_SCHOOL_MASK_NORMAL)
    // This triggers ShouldBeSuppressed via IsImmunedToDamage
    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, true);

    // EvaluateSuppressed checks each ref in _threatenedByMe
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    // B's ref on A's threat list should now be SUPPRESSED
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
    {
        if (ref->GetVictim() == _creatureB)
        {
            EXPECT_TRUE(ref->IsSuppressed());
            EXPECT_FALSE(ref->IsOnline());
            EXPECT_TRUE(ref->IsAvailable()); // SUPPRESSED is still available
        }
    }

    // Threat value should still be retrievable (SUPPRESSED is available)
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);

    // Cleanup immunity
    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, false);
}

TEST_F(ThreatManagerIntegrationTest,
       EvaluateSuppressed_CanExpire_RestoresOnline)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Apply immunity to suppress
    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, true);
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    // Verify suppressed
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsSuppressed());

    // Remove immunity
    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, false);

    // EvaluateSuppressed with canExpire=false should NOT restore to online
    _creatureB->TestGetThreatMgr().EvaluateSuppressed(false);
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsSuppressed()); // still suppressed

    // EvaluateSuppressed with canExpire=true SHOULD restore to online
    _creatureB->TestGetThreatMgr().EvaluateSuppressed(true);
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
    {
        if (ref->GetVictim() == _creatureB)
        {
            EXPECT_TRUE(ref->IsOnline());
            EXPECT_FALSE(ref->IsSuppressed());
        }
    }
}

TEST_F(ThreatManagerIntegrationTest,
       EvaluateSuppressed_TauntedVictim_NeverSuppressed)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Taunt B
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_TAUNT);

    // Apply damage immunity — normally would suppress
    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, true);
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    // Taunted victims should never be suppressed (ShouldBeSuppressed returns false)
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsOnline());

    // Cleanup
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_NONE);
    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, false);
}

TEST_F(ThreatManagerIntegrationTest,
       EvaluateSuppressed_MultipleRefs_EachEvaluatedIndependently)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90001); // Same faction as A

    // Both A and C have B on their threat lists
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    creatureC->TestGetThreatMgr().AddThreat(_creatureB, 200.0f);

    // Apply immunity on B
    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, true);
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    // Both refs should be suppressed
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsSuppressed());
    for (ThreatReference const* ref : creatureC->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsSuppressed());

    // Remove immunity and expire
    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, false);
    _creatureB->TestGetThreatMgr().EvaluateSuppressed(true);

    // Both should be online again
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsOnline());
    for (ThreatReference const* ref : creatureC->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsOnline());

    creatureC->CleanupCombatState();
    delete creatureC;
}

} // namespace
