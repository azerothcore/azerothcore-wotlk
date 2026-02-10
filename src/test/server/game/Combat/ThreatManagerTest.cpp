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

} // namespace
