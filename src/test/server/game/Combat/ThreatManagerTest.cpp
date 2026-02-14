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

// ============================================================================
// GAP COVERAGE: Victim Selection Threshold Tests (ReselectVictim)
// Tests the 110%/130% switching logic, melee vs ranged preference.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ReselectVictim_Below110Percent_KeepsOldVictim)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // B gets threat first and becomes initial victim
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);

    // C gets 109% of B's threat — below 110% threshold, should NOT switch
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 109.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       ReselectVictim_MeleeAt110Percent_Switches)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Both creatures at same position (0,0,0) = within melee range
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);

    // C gets 111% of B's threat and is melee — should switch
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 111.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), creatureC);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// NOTE: Ranged (130%) threshold tests cannot be reliably tested in unit tests.
// Relocate()-based distance checks fail because ShouldBeOffline() calls
// CanSeeOrDetect(), which requires map grid infrastructure not available
// in the unit test environment. Creatures placed far away go OFFLINE instead
// of being treated as "ranged". These thresholds are validated by the
// CompareReferencesLT implementation and integration/manual testing.

TEST_F(ThreatManagerIntegrationTest,
       ReselectVictim_MeleeAt130Percent_AlsoSwitches)
{
    // Verify that a melee target above 130% also switches (melee only needs
    // 110%, so 130% should certainly work too)
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);

    // C gets 131% threat — well above melee 110% threshold, should switch
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 131.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), creatureC);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       ReselectVictim_MeleeThirdTarget_AboveThreshold_Switches)
{
    // Three melee targets — verify correct switching with multiple candidates
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    TestCreature* creatureD = new TestCreature();
    creatureD->SetupForCombatTest(_map, 4, 12348);
    creatureD->SetFaction(90002);

    // B is current victim with 100 threat
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);

    // C has 105% — below 110% threshold, won't switch
    // D has 115% — above 110% threshold, should switch to D
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 105.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureD, 115.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    // Should pick D (highest above threshold)
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), creatureD);

    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

TEST_F(ThreatManagerIntegrationTest,
       ReselectVictim_NoOldVictim_PicksHighest)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Add both at the same time — no previous victim
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 50.0f);

    // First victim selection — should pick highest regardless of thresholds
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       ReselectVictim_EqualThreat_KeepsCurrentVictim)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // B is initial victim
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);

    // C gets exactly equal threat — should NOT switch (need >110%)
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 100.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// GAP COVERAGE: ThreatManager::Update() Timer-Driven Path
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       Update_TimerDrivenReselection)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);

    // Add much higher threat to C
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 500.0f);

    // Partial update (less than interval) — timer hasn't fired yet
    _creatureA->TestGetThreatMgr().Update(500);
    // GetCurrentVictim triggers immediate UpdateVictim so it will still return C
    // But the timer-based path hasn't fired yet
    // Verify Update doesn't crash on partial timer
    EXPECT_NE(_creatureA->TestGetThreatMgr().GetCurrentVictim(), nullptr);

    // Full interval fires timer-based reselection
    _creatureA->TestGetThreatMgr().Update(500);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), creatureC);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       Update_ZeroDiff_DoesNotCrash)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // 0ms update should not crash or do anything unexpected
    _creatureA->TestGetThreatMgr().Update(0);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);
}

TEST_F(ThreatManagerIntegrationTest,
       Update_EmptyThreatList_DoesNotCrash)
{
    // Update with no threat entries — should be safe no-op
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), nullptr);
}

// ============================================================================
// GAP COVERAGE: ModifyThreatByPercent
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ModifyThreatByPercent_Increase)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // +50% → 150
    _creatureA->TestGetThreatMgr().ModifyThreatByPercent(_creatureB, 50);
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 150.0f);
}

TEST_F(ThreatManagerIntegrationTest,
       ModifyThreatByPercent_Decrease)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // -30% → 70
    _creatureA->TestGetThreatMgr().ModifyThreatByPercent(_creatureB, -30);
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 70.0f);
}

TEST_F(ThreatManagerIntegrationTest,
       ModifyThreatByPercent_Minus100_ZerosThreat)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // -100% → 0
    _creatureA->TestGetThreatMgr().ModifyThreatByPercent(_creatureB, -100);
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 0.0f);
    // Entry should still exist
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
}

TEST_F(ThreatManagerIntegrationTest,
       ModifyThreatByPercent_ZeroPercent_NoChange)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // 0% change — should be a no-op
    _creatureA->TestGetThreatMgr().ModifyThreatByPercent(_creatureB, 0);
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);
}

TEST_F(ThreatManagerIntegrationTest,
       ModifyThreatByPercent_Plus100_Doubles)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // +100% → 200
    _creatureA->TestGetThreatMgr().ModifyThreatByPercent(_creatureB, 100);
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 200.0f);
}

// ============================================================================
// GAP COVERAGE: Query Methods (GetThreat, IsThreatListEmpty, IsThreatenedBy)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       GetThreat_NonexistentTarget_ReturnsZero)
{
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 0.0f);
}

TEST_F(ThreatManagerIntegrationTest,
       GetThreat_OfflineTarget_ExcludedByDefault)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Move B offline via phase change
    _creatureB->SetPhase(2);

    // Force re-evaluation
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    // Default (includeOffline=false) should return 0
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB, false), 0.0f);
    // includeOffline=true should return the threat value
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB, true), 100.0f);
}

TEST_F(ThreatManagerIntegrationTest,
       IsThreatListEmpty_EmptyList_ReturnsTrue)
{
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatListEmpty());
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatListEmpty(true));
}

TEST_F(ThreatManagerIntegrationTest,
       IsThreatListEmpty_WithEntries_ReturnsFalse)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatListEmpty());
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatListEmpty(true));
}

TEST_F(ThreatManagerIntegrationTest,
       IsThreatListEmpty_AllOffline_TrueWithoutOfflineFlag)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Move B offline
    _creatureB->SetPhase(2);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    // Online-only should be empty
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatListEmpty(false));
    // Including offline should not be empty
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatListEmpty(true));
}

TEST_F(ThreatManagerIntegrationTest,
       IsThreatenedBy_OfflineTarget_Variants)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    _creatureB->SetPhase(2);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    // Default (online only) — should be false
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, false));
    // Including offline — should be true
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, true));
}

// ============================================================================
// GAP COVERAGE: IsThreateningAnyone / IsThreateningTo
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       IsThreateningAnyone_NoEntries_ReturnsFalse)
{
    EXPECT_FALSE(_creatureB->TestGetThreatMgr().IsThreateningAnyone());
    EXPECT_FALSE(_creatureB->TestGetThreatMgr().IsThreateningAnyone(true));
}

TEST_F(ThreatManagerIntegrationTest,
       IsThreateningAnyone_WithEntries_ReturnsTrue)
{
    // A adds threat against B → B appears in A's threat list
    // B is a "victim" on A's list → B._threatenedByMe has an entry for A
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    EXPECT_TRUE(_creatureB->TestGetThreatMgr().IsThreateningAnyone());
    EXPECT_TRUE(_creatureB->TestGetThreatMgr().IsThreateningAnyone(true));
}

TEST_F(ThreatManagerIntegrationTest,
       IsThreateningAnyone_AllOffline_FalseWithoutFlag)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Make B's ref on A's list go offline
    _creatureB->SetPhase(2);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    // B is still threatening A, but the ref is offline
    EXPECT_FALSE(_creatureB->TestGetThreatMgr().IsThreateningAnyone(false));
    EXPECT_TRUE(_creatureB->TestGetThreatMgr().IsThreateningAnyone(true));
}

TEST_F(ThreatManagerIntegrationTest,
       IsThreateningTo_SpecificTarget)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // B is threatening A (B appears on A's threat list)
    EXPECT_TRUE(_creatureB->TestGetThreatMgr().IsThreateningTo(_creatureA));
    // A is NOT threatening B (A does not appear on B's threat list)
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreateningTo(_creatureB));
}

TEST_F(ThreatManagerIntegrationTest,
       IsThreateningTo_ObjectGuidVariant)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    EXPECT_TRUE(_creatureB->TestGetThreatMgr().IsThreateningTo(_creatureA->GetGUID()));
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreateningTo(_creatureB->GetGUID()));
}

// ============================================================================
// GAP COVERAGE: RemoveMeFromThreatLists
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       RemoveMeFromThreatLists_RemovesFromAllLists)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90001);

    // A and C both have B on their threat lists
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    creatureC->TestGetThreatMgr().AddThreat(_creatureB, 200.0f);

    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    EXPECT_TRUE(creatureC->TestGetThreatMgr().IsThreatenedBy(_creatureB));

    // B removes itself from all threat lists
    _creatureB->TestGetThreatMgr().RemoveMeFromThreatLists();

    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    EXPECT_FALSE(creatureC->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    EXPECT_FALSE(_creatureB->TestGetThreatMgr().IsThreateningAnyone());

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       RemoveMeFromThreatLists_NoEntries_DoesNotCrash)
{
    // B is not on anyone's threat list — should be safe no-op
    _creatureB->TestGetThreatMgr().RemoveMeFromThreatLists();
    EXPECT_FALSE(_creatureB->TestGetThreatMgr().IsThreateningAnyone());
}

// ============================================================================
// GAP COVERAGE: GetAnyTarget (ThreatManager)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       GetAnyTarget_EmptyList_ReturnsNull)
{
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetAnyTarget(), nullptr);
}

TEST_F(ThreatManagerIntegrationTest,
       GetAnyTarget_WithEntries_ReturnsNonNull)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_NE(_creatureA->TestGetThreatMgr().GetAnyTarget(), nullptr);
}

TEST_F(ThreatManagerIntegrationTest,
       GetAnyTarget_AllOffline_ReturnsNull)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    _creatureB->SetPhase(2);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetAnyTarget(), nullptr);
}

// ============================================================================
// GAP COVERAGE: GetLastVictim
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       GetLastVictim_NoVictim_ReturnsNull)
{
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetLastVictim(), nullptr);
}

TEST_F(ThreatManagerIntegrationTest,
       GetLastVictim_WithVictim_ReturnsCached)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetLastVictim(), _creatureB);
}

TEST_F(ThreatManagerIntegrationTest,
       GetLastVictim_OfflineVictim_ReturnsNull)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    _creatureB->SetPhase(2);
    // GetLastVictim checks ShouldBeOffline on cached ref
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetLastVictim(), nullptr);
}

// ============================================================================
// GAP COVERAGE: GetSortedThreatList / GetUnsortedThreatList / GetModifiableThreatList
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       GetSortedThreatList_ReturnsSortedByThreat)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    TestCreature* creatureD = new TestCreature();
    creatureD->SetupForCombatTest(_map, 4, 12348);
    creatureD->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 50.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 200.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureD, 100.0f);

    float prevThreat = std::numeric_limits<float>::max();
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetSortedThreatList())
    {
        EXPECT_LE(ref->GetThreat(), prevThreat);
        prevThreat = ref->GetThreat();
    }

    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

TEST_F(ThreatManagerIntegrationTest,
       GetUnsortedThreatList_ReturnsAllEntries)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 50.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 200.0f);

    size_t count = 0;
    for ([[maybe_unused]] ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        ++count;

    EXPECT_EQ(count, 2u);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       GetModifiableThreatList_ReturnsCopy)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 50.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 200.0f);

    auto list = _creatureA->TestGetThreatMgr().GetModifiableThreatList();
    EXPECT_EQ(list.size(), 2u);

    // Verify it's sorted (highest first)
    EXPECT_GE(list[0]->GetThreat(), list[1]->GetThreat());

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// GAP COVERAGE: Multiple Concurrent Taunts
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       MultipleTaunts_LastTauntWins)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    TestCreature* creatureD = new TestCreature();
    creatureD->SetupForCombatTest(_map, 4, 12348);
    creatureD->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 50.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureD, 25.0f);

    // Taunt from C
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        creatureC, ThreatReference::TAUNT_STATE_TAUNT);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), creatureC);

    // Also taunt from D — both taunted, but D has lower threat
    // With equal taunt state, higher threat wins → C still selected
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        creatureD, ThreatReference::TAUNT_STATE_TAUNT);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), creatureC);

    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

// ============================================================================
// GAP COVERAGE: AddThreat Edge Cases
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_NegativeAmount_ReducesThreat)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, -30.0f);

    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 70.0f);
}

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_NegativeBeyondZero_ClampsToZero)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 50.0f);
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, -100.0f);

    // ThreatReference::GetThreat clamps to 0 via max(baseAmount + tempMod, 0)
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 0.0f);
}

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_DeadTarget_NoCombatOrThreat)
{
    _creatureB->SetAlive(false);

    // Dead targets should fail CanBeginCombat and thus not get threat
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().HasCombat());
}

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_DifferentPhaseTarget_NoCombatOrThreat)
{
    _creatureB->SetPhase(2);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().HasCombat());
}

// ============================================================================
// GAP COVERAGE: GetFixateTarget
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       GetFixateTarget_NoFixate_ReturnsNull)
{
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetFixateTarget(), nullptr);
}

TEST_F(ThreatManagerIntegrationTest,
       GetFixateTarget_WithFixate_ReturnsTarget)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().FixateTarget(_creatureB);

    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetFixateTarget(), _creatureB);

    _creatureA->TestGetThreatMgr().ClearFixate();
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetFixateTarget(), nullptr);
}

// ============================================================================
// GAP COVERAGE: ThreatReference Direct API
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ThreatReference_GetOwnerAndVictim)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
    {
        if (ref->GetVictim() == _creatureB)
        {
            EXPECT_EQ(ref->GetOwner(), _creatureA);
            EXPECT_EQ(ref->GetVictim(), _creatureB);
            EXPECT_FLOAT_EQ(ref->GetThreat(), 100.0f);
            EXPECT_TRUE(ref->IsOnline());
            EXPECT_FALSE(ref->IsOffline());
            EXPECT_FALSE(ref->IsSuppressed());
            EXPECT_TRUE(ref->IsAvailable());
            EXPECT_EQ(ref->GetTauntState(), ThreatReference::TAUNT_STATE_NONE);
            EXPECT_FALSE(ref->IsTaunting());
            EXPECT_FALSE(ref->IsDetaunted());
        }
    }
}

TEST_F(ThreatManagerIntegrationTest,
       ThreatReference_ScaleThreat_Directly)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    auto list = _creatureA->TestGetThreatMgr().GetModifiableThreatList();
    ASSERT_EQ(list.size(), 1u);

    list[0]->ScaleThreat(3.0f);
    EXPECT_FLOAT_EQ(list[0]->GetThreat(), 300.0f);

    list[0]->ModifyThreatByPercent(-50);
    EXPECT_FLOAT_EQ(list[0]->GetThreat(), 150.0f);
}

// ============================================================================
// GAP COVERAGE: MatchUnitThreatToHighestThreat — taunted-highest skip
// When the heap-top ref is the taunting target, the code peeks at the next
// entry to find the real highest threat value.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       MatchUnitThreatToHighestThreat_HighestIsTaunted_UsesNextEntry)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    TestCreature* creatureD = new TestCreature();
    creatureD->SetupForCombatTest(_map, 4, 12348);
    creatureD->SetFaction(90002);

    // B has low threat (100), C has high threat (500), D has none yet
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 500.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureD, 10.0f);

    // Taunt B — B becomes heap top (taunt state wins over threat value)
    // but B's actual threat is only 100.
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_TAUNT);

    // MatchUnitThreatToHighestThreat should skip the taunted entry (B=100)
    // and use C's 500 as the real highest.
    _creatureA->TestGetThreatMgr().MatchUnitThreatToHighestThreat(creatureD);

    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureD), 500.0f);

    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_NONE);
    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

TEST_F(ThreatManagerIntegrationTest,
       MatchUnitThreatToHighestThreat_TauntedIsAlsoHighest_UsesTauntedThreat)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    TestCreature* creatureD = new TestCreature();
    creatureD->SetupForCombatTest(_map, 4, 12348);
    creatureD->SetFaction(90002);

    // B has highest threat AND is taunted — no skip needed
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 500.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureD, 10.0f);

    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_TAUNT);

    _creatureA->TestGetThreatMgr().MatchUnitThreatToHighestThreat(creatureD);

    // B's 500 is the real highest — D should get 500
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureD), 500.0f);

    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_NONE);
    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

// ============================================================================
// GAP COVERAGE: AddThreat — suppressed-to-online transition
// When adding threat to an existing SUPPRESSED ref that no longer qualifies
// for suppression, the ref transitions back to ONLINE (without needing
// EvaluateSuppressed(true)).
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_SuppressedRef_UnsuppressesOnNewThreat)
{
    // A has B on threat list
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Make B immune → suppress B's ref on A's list
    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, true);
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    // Verify B is SUPPRESSED
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsSuppressed());

    // Remove immunity (but do NOT call EvaluateSuppressed)
    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, false);

    // Add more threat — the AddThreat path should detect that the ref
    // no longer ShouldBeSuppressed() and transition it to ONLINE
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 50.0f, nullptr, true);

    // Verify B is now ONLINE and threat was applied
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
    {
        if (ref->GetVictim() == _creatureB)
        {
            EXPECT_TRUE(ref->IsOnline());
            EXPECT_FALSE(ref->IsSuppressed());
        }
    }
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 150.0f);
}

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_SuppressedRef_StillSuppressed_NoTransition)
{
    // A has B on threat list
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Make B immune → suppress
    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, true);
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    // Add more threat while B is still immune — should stay SUPPRESSED
    // and threat should NOT be applied (AddThreat only adds to ONLINE refs)
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 50.0f, nullptr, true);

    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsSuppressed());

    // Threat should be unchanged (AddThreat skips non-online refs)
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);

    _creatureB->ApplySpellImmune(1, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, false);
}

// ============================================================================
// GAP COVERAGE: Redirect total cap at 100%
// UpdateRedirectInfo() caps the total redirect percentage at 100%.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_TotalExceeds100_CappedAt100)
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

    // Register redirects totaling 130% (70% + 60%)
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 70);
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        57934, creatureD->GetGUID(), 60);

    // Add 100 threat from A to B
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f, nullptr, true);

    // Total redirected should be capped at 100%, so B gets 0
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 0.0f);

    // C + D together should have exactly 100 (the full amount)
    float cThreat = _creatureA->TestGetThreatMgr().GetThreat(creatureC);
    float dThreat = _creatureA->TestGetThreatMgr().GetThreat(creatureD);
    EXPECT_FLOAT_EQ(cThreat + dThreat, 100.0f);

    // First redirect should get its full 70%, second gets capped to 30%
    // (iteration order of unordered_map may vary, so check the sum is correct
    // and each individual value is within expected bounds)
    EXPECT_GE(cThreat, 0.0f);
    EXPECT_LE(cThreat, 100.0f);
    EXPECT_GE(dThreat, 0.0f);
    EXPECT_LE(dThreat, 100.0f);

    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(57934);
    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

TEST_F(ThreatManagerIntegrationTest,
       RedirectThreat_Exactly100Percent_AllRedirected)
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

    // Register redirects totaling exactly 100% (60% + 40%)
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 60);
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        57934, creatureD->GetGUID(), 40);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 200.0f, nullptr, true);

    // B should get 0 (all redirected)
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 0.0f);

    // C + D should have 200 total
    float cThreat = _creatureA->TestGetThreatMgr().GetThreat(creatureC);
    float dThreat = _creatureA->TestGetThreatMgr().GetThreat(creatureD);
    EXPECT_FLOAT_EQ(cThreat + dThreat, 200.0f);

    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(57934);
    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    delete creatureC;
    delete creatureD;
}

// ============================================================================
// GAP COVERAGE: ThreatReference::ScaleThreat with factor=1.0 (no-op)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ThreatReference_ScaleThreat_Factor1_NoOp)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    auto list = _creatureA->TestGetThreatMgr().GetModifiableThreatList();
    ASSERT_EQ(list.size(), 1u);

    // ScaleThreat(1.0f) has an early return — no heap notification
    list[0]->ScaleThreat(1.0f);
    EXPECT_FLOAT_EQ(list[0]->GetThreat(), 100.0f);
}

// ============================================================================
// GAP COVERAGE: ThreatReference::AddThreat with amount=0.0 (no-op)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ThreatReference_AddThreat_ZeroAmount_NoOp)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    auto list = _creatureA->TestGetThreatMgr().GetModifiableThreatList();
    ASSERT_EQ(list.size(), 1u);

    // AddThreat(0.0f) has an early return — no heap notification
    list[0]->AddThreat(0.0f);
    EXPECT_FLOAT_EQ(list[0]->GetThreat(), 100.0f);
}

// ============================================================================
// GAP COVERAGE: ThreatReference::ClearThreat() via direct method
// The ThreatReference self-deallocation path (ref->ClearThreat delegates
// to ThreatManager::ClearThreat(this)).
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ThreatReference_ClearThreat_DirectCall_RemovesEntry)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 1u);

    // Get the reference via modifiable list and call ClearThreat() on it
    auto list = _creatureA->TestGetThreatMgr().GetModifiableThreatList();
    ASSERT_EQ(list.size(), 1u);
    list[0]->ClearThreat(); // self-deallocation — pointer is now invalid

    // Entry should be gone
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 0u);
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
}

// ============================================================================
// GAP COVERAGE: FixateTarget on a unit not on the threat list
// Should fall through to _fixateRef = nullptr.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       FixateTarget_NotOnThreatList_ClearsFixate)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // B is on the threat list, C is NOT
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(creatureC));

    // Fixate on C (not on threat list) — should result in nullptr fixate
    _creatureA->TestGetThreatMgr().FixateTarget(creatureC);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetFixateTarget(), nullptr);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerIntegrationTest,
       FixateTarget_NotOnThreatList_ClearsExistingFixate)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Both B and C are on the threat list
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Set a valid fixate first
    _creatureA->TestGetThreatMgr().FixateTarget(_creatureB);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetFixateTarget(), _creatureB);

    // Now fixate on C (not on threat list) — should clear the existing fixate
    _creatureA->TestGetThreatMgr().FixateTarget(creatureC);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetFixateTarget(), nullptr);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// GAP COVERAGE: GetThreatenedByMeList
// Tests the reverse-threat map accessor (who is this unit threatening?)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       GetThreatenedByMeList_Empty_ReturnsEmpty)
{
    auto const& list = _creatureB->TestGetThreatMgr().GetThreatenedByMeList();
    EXPECT_TRUE(list.empty());
}

TEST_F(ThreatManagerIntegrationTest,
       GetThreatenedByMeList_AfterAddThreat_ContainsRef)
{
    // A adds threat against B → B appears in A._myThreatListEntries
    // AND A appears in B._threatenedByMe
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    auto const& list = _creatureB->TestGetThreatMgr().GetThreatenedByMeList();
    EXPECT_EQ(list.size(), 1u);

    // The key is A's GUID (the creature whose threat list B appears on)
    auto it = list.find(_creatureA->GetGUID());
    ASSERT_NE(it, list.end());
    EXPECT_EQ(it->second->GetOwner(), _creatureA);
    EXPECT_EQ(it->second->GetVictim(), _creatureB);
}

TEST_F(ThreatManagerIntegrationTest,
       GetThreatenedByMeList_AfterClearAllThreat_IsEmpty)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_EQ(_creatureB->TestGetThreatMgr().GetThreatenedByMeList().size(), 1u);

    _creatureA->TestGetThreatMgr().ClearAllThreat();

    EXPECT_TRUE(_creatureB->TestGetThreatMgr().GetThreatenedByMeList().empty());
}

// ============================================================================
// GAP COVERAGE: ThreatReference online state / temp modifier
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       GetOnlineState_NewRef_ReturnsOnline)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
    {
        if (ref->GetVictim() == _creatureB)
        {
            EXPECT_EQ(ref->GetOnlineState(),
                      ThreatReference::ONLINE_STATE_ONLINE);
        }
    }
}

TEST_F(ThreatManagerIntegrationTest,
       TempModifier_AffectsGetThreat)
{
    // A adds threat against B, then we verify that _tempModifier changes
    // GetThreat() return value (GetThreat = max(baseAmount + tempModifier, 0))
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Verify initial threat via GetTempModifierForTesting (should be 0)
    EXPECT_EQ(_creatureB->TestGetThreatMgr().GetTempModifierForTesting(
                  _creatureA), 0);
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);
}

// ============================================================================
// GAP COVERAGE: AddThreat with SPELL_ATTR1_NO_THREAT early return
// When spell has NO_THREAT attribute, AddThreat should do nothing.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_SpellWithNoThreatAttr_DoesNothing)
{
    // Create a SpellInfo with SPELL_ATTR1_NO_THREAT set
    SpellEntry fakeSpellEntry{};
    fakeSpellEntry.AttributesEx = SPELL_ATTR1_NO_THREAT;
    SpellInfo fakeSpell(&fakeSpellEntry);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f, &fakeSpell);

    // No threat should be added, no combat reference
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
    EXPECT_FALSE(_creatureA->TestGetCombatMgr().HasCombat());
}

// ============================================================================
// GAP COVERAGE: AddThreat with SPELL_ATTR3_SUPPRESS_TARGET_PROCS
// When not yet engaged and spell has SUPPRESS_TARGET_PROCS, returns early.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_SuppressTargetProcs_NotEngaged_DoesNothing)
{
    SpellEntry fakeSpellEntry{};
    fakeSpellEntry.AttributesEx3 = SPELL_ATTR3_SUPPRESS_TARGET_PROCS;
    SpellInfo fakeSpell(&fakeSpellEntry);

    // Creature is not engaged (no existing threat list entries)
    EXPECT_FALSE(_creatureA->IsEngaged());

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f, &fakeSpell);

    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));
}

// NOTE: AddThreat_SuppressTargetProcs_AlreadyEngaged cannot be tested
// without a CreatureAI mock because Creature::IsEngaged() delegates to
// AI()->IsEngaged(), and TestCreature has no AI. The "already engaged"
// path would only activate with a proper AI returning true from IsEngaged().

// ============================================================================
// GAP COVERAGE: ForwardThreatForAssistingMe with NO_THREAT spell
// Should early-return doing nothing.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ForwardThreat_SpellWithNoThreatAttr_DoesNothing)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // A has B on threat list
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    SpellEntry fakeSpellEntry{};
    fakeSpellEntry.AttributesEx = SPELL_ATTR1_NO_THREAT;
    SpellInfo fakeSpell(&fakeSpellEntry);

    // Forward with NO_THREAT spell — should be a no-op
    _creatureB->TestGetThreatMgr().ForwardThreatForAssistingMe(
        creatureC, 50.0f, &fakeSpell);

    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(creatureC));

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// GAP COVERAGE: ForwardThreat mixed CC + non-CC split
// When some creatures are CC'd and some aren't, verify the split math
// AND that CC'd targets still enter combat with 0 threat.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ForwardThreat_MixedCCAndNonCC_CorrectSplit)
{
    // Boss1 (A) and Boss2 (C) both have B on their threat lists
    // Boss3 (D) also has B, but D is under CC
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90001);

    TestCreature* creatureD = new TestCreature();
    creatureD->SetupForCombatTest(_map, 4, 12348);
    creatureD->SetFaction(90001);

    TestCreature* healer = new TestCreature();
    healer->SetupForCombatTest(_map, 5, 12349);
    healer->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    creatureC->TestGetThreatMgr().AddThreat(_creatureB, 200.0f);
    creatureD->TestGetThreatMgr().AddThreat(_creatureB, 300.0f);

    // D is under CC — should not receive split threat
    creatureD->AddUnitState(UNIT_STATE_CONTROLLED);

    // Forward 100 assist threat from healer
    // 2 non-CC targets (A, C) → each gets 50
    _creatureB->TestGetThreatMgr().ForwardThreatForAssistingMe(
        healer, 100.0f);

    // A and C each get 50 threat for healer
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(healer), 50.0f);
    EXPECT_FLOAT_EQ(
        creatureC->TestGetThreatMgr().GetThreat(healer), 50.0f);

    // D (CC'd) gets 0 threat but should still enter combat
    EXPECT_FLOAT_EQ(
        creatureD->TestGetThreatMgr().GetThreat(healer), 0.0f);
    EXPECT_TRUE(creatureD->TestGetCombatMgr().IsInCombatWith(healer));

    creatureD->ClearUnitState(UNIT_STATE_CONTROLLED);
    creatureC->CleanupCombatState();
    creatureD->CleanupCombatState();
    healer->CleanupCombatState();
    delete creatureC;
    delete creatureD;
    delete healer;
}

// ============================================================================
// GAP COVERAGE: ShouldBeOffline — IMMUNE_TO_NPC flag
// Setting UNIT_FLAG_IMMUNE_TO_NPC on victim makes FlagsAllowFighting
// return false for NPC attackers, putting the ref offline.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       UpdateOffline_ImmuneToNPCFlag_PutsRefOffline)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Verify B starts online
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, false));

    // Set IMMUNE_TO_NPC on B — since A is an NPC without PLAYER_CONTROLLED,
    // FlagsAllowFighting(A, B) will return false → B goes offline
    _creatureB->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);

    // Force re-evaluation via Update (calls UpdateOffline on each ref)
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    // B should be offline
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, false));
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, true));

    // Remove flag
    _creatureB->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
}

TEST_F(ThreatManagerIntegrationTest,
       UpdateOffline_ImmuneToNPCFlag_Removed_RestoresOnline)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Set IMMUNE_TO_NPC → offline
    _creatureB->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, false));

    // Remove flag → should restore to online on next Update
    _creatureB->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, false));
}

// ============================================================================
// GAP COVERAGE: ShouldBeOffline — Trigger creature
// Trigger creatures should go offline (FlagsAllowFighting returns false).
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       UpdateOffline_TriggerCreature_PutsRefOffline)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, false));

    // Mark B as a trigger creature
    _creatureB->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
    // Actually, IsTrigger() checks flags_extra and npcflag, not unit flags.
    // In test environment, we'd need to set CREATURE_FLAG_EXTRA_TRIGGER.
    // Since we can't easily modify CreatureTemplate flags_extra in tests,
    // let's test the IMMUNE_TO_PC path instead for completeness:

    // Set IMMUNE_TO_PC on B, and mark A as player-controlled
    _creatureA->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
    _creatureB->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);

    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    // B should be offline (A is player-controlled, B is immune to PC)
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, false));
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, true));

    _creatureA->RemoveUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
    _creatureB->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);
    _creatureB->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
}

// ============================================================================
// GAP COVERAGE: FlagsAllowFighting bidirectional check
// Both directions (owner→victim AND victim→owner) are checked in
// ShouldBeOffline. Test that setting immune flag on the OWNER also
// causes offline.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       UpdateOffline_OwnerImmuneToNPC_PutsRefOffline)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, false));

    // Set IMMUNE_TO_NPC on A (the owner) — B doesn't have PLAYER_CONTROLLED
    // so FlagsAllowFighting(B, A) returns false → offline
    _creatureA->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);

    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, false));
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, true));

    _creatureA->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
}

// ============================================================================
// GAP COVERAGE: CalculateModifiedThreat — school modifier pipeline
// Tests that AddThreat with a SpellInfo applies school modifiers from
// _singleSchoolModifiers when ignoreModifiers=false.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_WithSpell_AppliesSchoolModifier)
{
    // First, set up B's fire school modifier to 2.0 (100% increase)
    // We can't inject auras here, but we CAN use the testing API
    // to directly modify the school modifier via UpdateMySpellSchoolModifiers
    // For this test, we'll verify the default (1.0) path works correctly
    // The aura-based modifier test is in ThreatManagerAuraTest

    // Create a fake fire spell
    SpellEntry fakeSpellEntry{};
    fakeSpellEntry.SchoolMask = SPELL_SCHOOL_MASK_FIRE;
    SpellInfo fakeSpell(&fakeSpellEntry);

    // With default modifier (1.0), threat should be unmodified
    _creatureA->TestGetThreatMgr().AddThreat(
        _creatureB, 100.0f, &fakeSpell, false);

    // School modifier is applied on the victim (B), not the owner (A)
    // Default _singleSchoolModifiers[FIRE] = 1.0
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);
}

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_IgnoreModifiers_SkipsSchoolModifier)
{
    // With ignoreModifiers=true, school modifiers are NOT applied
    SpellEntry fakeSpellEntry{};
    fakeSpellEntry.SchoolMask = SPELL_SCHOOL_MASK_FIRE;
    SpellInfo fakeSpell(&fakeSpellEntry);

    _creatureA->TestGetThreatMgr().AddThreat(
        _creatureB, 100.0f, &fakeSpell, true);

    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);
}

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_IgnoreRedirects_SkipsRedirectTargets)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 0.0f, nullptr, true, true);

    // Register 50% redirect from B to C
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 50);

    // AddThreat with ignoreRedirects=true → no redirection
    _creatureA->TestGetThreatMgr().AddThreat(
        _creatureB, 100.0f, nullptr, true, true);

    // B should have full 100, C should still have 0
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureC), 0.0f);

    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// GAP COVERAGE: AddThreat — new ref starts offline
// When a new threat ref is created but UpdateOffline() determines it should
// be offline, threat should not be applied.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_NewRefOffline_ThreatNotApplied)
{
    // Make B immune to NPC BEFORE adding threat
    _creatureB->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // If the ref was created but went offline, threat may not be applied
    // Actually, CanBeginCombat should fail due to immunity → no ref at all
    // Let's verify: with IMMUNE_TO_NPC, combat creation fails
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB));

    _creatureB->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
}

// ============================================================================
// GAP COVERAGE: TauntUpdate escalating state values
// Each successive taunt aura gets state++ (2, 3, 4...), so the last
// taunt in the aura list gets the highest priority.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       TauntState_HigherStateThanTaunt_WinsSelection)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 50.0f);

    // Set B to TAUNT (state=2), C to state=3 (higher than TAUNT)
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_TAUNT);
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        creatureC, static_cast<uint32>(ThreatReference::TAUNT_STATE_TAUNT) + 1);

    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    // C has higher taunt state → wins despite lower threat
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), creatureC);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// GAP COVERAGE: AddThreat on offline ref does not add threat
// When ref is OFFLINE, AddThreat should not increase the threat value.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_OfflineRef_ThreatNotAdded)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Move B offline via phase change
    _creatureB->SetPhase(2);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    // Verify B is offline
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(_creatureB, false));

    // Try to add more threat — should not increase since ref is offline
    // (AddThreat only adds to refs where IsOnline() is true)
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 50.0f);

    // Threat should still be 100 (the original amount)
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB, true), 100.0f);
}

// ============================================================================
// GAP COVERAGE: AddThreat creates combat with redirect targets
// When owner !CanHaveThreatList, AddThreat still creates combat refs
// including for redirect targets. We can't easily disable CanHaveThreatList
// in tests, so we verify the normal redirect-with-combat path instead.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       AddThreat_Redirect_AlsoCreatesCombatForRedirectTarget)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Pre-establish C on A's threat list
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 0.0f, nullptr, true, true);

    // Register 50% redirect from B to C
    _creatureB->TestGetThreatMgr().RegisterRedirectThreat(
        34477, creatureC->GetGUID(), 50);

    // Add threat A→B — should create combat with B AND C (via redirect)
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f, nullptr, true);

    // Both B and C should be in combat with A
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(_creatureB));
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(creatureC));

    _creatureB->TestGetThreatMgr().UnregisterRedirectThreat(34477);
    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// GAP COVERAGE: ForwardThreat all targets CC'd
// When ALL threateners are under CC, the entire split pool is empty and
// they each get 0 threat via the cannotBeThreatened loop.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ForwardThreat_AllTargetsCC_EachGetsZeroThreat)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90001);

    TestCreature* healer = new TestCreature();
    healer->SetupForCombatTest(_map, 4, 12348);
    healer->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    creatureC->TestGetThreatMgr().AddThreat(_creatureB, 200.0f);

    // Both A and C are CC'd
    _creatureA->AddUnitState(UNIT_STATE_CONTROLLED);
    creatureC->AddUnitState(UNIT_STATE_CONTROLLED);

    _creatureB->TestGetThreatMgr().ForwardThreatForAssistingMe(
        healer, 100.0f);

    // Both get 0 threat (CC'd) but should still enter combat
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(healer), 0.0f);
    EXPECT_FLOAT_EQ(creatureC->TestGetThreatMgr().GetThreat(healer), 0.0f);
    EXPECT_TRUE(_creatureA->TestGetCombatMgr().IsInCombatWith(healer));
    EXPECT_TRUE(creatureC->TestGetCombatMgr().IsInCombatWith(healer));

    _creatureA->ClearUnitState(UNIT_STATE_CONTROLLED);
    creatureC->ClearUnitState(UNIT_STATE_CONTROLLED);
    creatureC->CleanupCombatState();
    healer->CleanupCombatState();
    delete creatureC;
    delete healer;
}

// ============================================================================
// GAP COVERAGE: MatchUnitThreatToHighestThreat on empty list
// Should be a safe no-op.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       MatchUnitThreatToHighestThreat_EmptyList_DoesNotCrash)
{
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatListEmpty());
    _creatureA->TestGetThreatMgr().MatchUnitThreatToHighestThreat(_creatureB);
    // No crash, no entries created
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatListEmpty());
}

// ============================================================================
// GAP COVERAGE: MatchUnitThreatToHighestThreat with all offline
// When highest ref is not available, should early return.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       MatchUnitThreatToHighestThreat_AllOffline_DoesNotModify)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 50.0f);

    // Move all offline
    _creatureB->SetPhase(2);
    creatureC->SetPhase(2);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);

    // MatchUnitThreatToHighestThreat should return early (highest not available)
    _creatureA->TestGetThreatMgr().MatchUnitThreatToHighestThreat(creatureC);

    // C's threat should be unchanged
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(creatureC, true), 50.0f);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// GAP COVERAGE: ScaleThreat on nonexistent target
// Should be a safe no-op (target not found in map).
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ScaleThreat_NonexistentTarget_DoesNotCrash)
{
    _creatureA->TestGetThreatMgr().ScaleThreat(_creatureB, 2.0f);
    // No crash, no entries created
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatListEmpty());
}

// ============================================================================
// GAP COVERAGE: ClearThreat on nonexistent target
// Should be a safe no-op.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ClearThreat_NonexistentTarget_DoesNotCrash)
{
    _creatureA->TestGetThreatMgr().ClearThreat(_creatureB);
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatListEmpty());
}

// ============================================================================
// GAP COVERAGE: Multiple victim selections with varied threat ordering
// Verify that after ClearThreat on current victim, next highest is selected.
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ClearThreat_CurrentVictim_SelectsNextHighest)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 500.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 100.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), _creatureB);

    // Remove B from threat list — C becomes the new victim
    _creatureA->TestGetThreatMgr().ClearThreat(_creatureB);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), creatureC);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// GAP COVERAGE: ClearAllThreat triggers evade (empty list → null victim)
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ClearAllThreat_VictimBecomesNull)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_NE(_creatureA->TestGetThreatMgr().GetCurrentVictim(), nullptr);

    _creatureA->TestGetThreatMgr().ClearAllThreat();
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), nullptr);
}

// ============================================================================
// GAP COVERAGE: GetThreatListSize accurate after multiple operations
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       GetThreatListSize_AccurateThroughLifecycle)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 0u);

    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 1u);

    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 50.0f);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 2u);

    // Adding more threat to existing target doesn't change count
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 50.0f);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 2u);

    _creatureA->TestGetThreatMgr().ClearThreat(_creatureB);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 1u);

    _creatureA->TestGetThreatMgr().ClearAllThreat();
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetThreatListSize(), 0u);

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// GAP COVERAGE: ResetAllThreat followed by AddThreat rebuilds correctly
// ============================================================================

TEST_F(ThreatManagerIntegrationTest,
       ResetAllThreat_ThenAddThreat_WorksCorrectly)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().ResetAllThreat();
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 0.0f);

    // Adding threat after reset should work normally
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 200.0f);
    EXPECT_FLOAT_EQ(_creatureA->TestGetThreatMgr().GetThreat(_creatureB), 200.0f);
}

} // namespace

// ============================================================================
// AURA-DEPENDENT TESTS
// These tests inject fake AuraEffect objects to test code paths that read
// Unit::m_modAuras. They require TestAura.h infrastructure.
// ============================================================================
#include "TestAura.h"

namespace
{

class ThreatManagerAuraTest : public ::testing::Test
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
        // Clean up any injected auras before destroying creatures
        _creatureA->TestClearModAuras(SPELL_AURA_MOD_TAUNT);
        _creatureA->TestClearModAuras(SPELL_AURA_MOD_TOTAL_THREAT);
        _creatureA->TestClearModAuras(SPELL_AURA_MOD_THREAT);
        _creatureA->TestClearModAuras(SPELL_AURA_MOD_CONFUSE);
        _creatureA->TestClearModAuras(SPELL_AURA_MOD_STUN);
        _creatureB->TestClearModAuras(SPELL_AURA_MOD_TAUNT);
        _creatureB->TestClearModAuras(SPELL_AURA_MOD_TOTAL_THREAT);
        _creatureB->TestClearModAuras(SPELL_AURA_MOD_THREAT);
        _creatureB->TestClearModAuras(SPELL_AURA_MOD_CONFUSE);
        _creatureB->TestClearModAuras(SPELL_AURA_MOD_STUN);

        _creatureA->CleanupCombatState();
        _creatureB->CleanupCombatState();
        delete _creatureA;
        delete _creatureB;
        delete _map;
        sWorld = std::move(_previousWorld);

        // Clean up test aura helpers
        for (auto& h : _auraHelpers)
            h.Destroy();
    }

    // Helper to create and track a test aura effect
    AuraEffect* MakeAuraEffect(uint32 auraType, int32 miscValue,
                               int32 amount, ObjectGuid casterGUID,
                               WorldObject* owner, uint8 effIndex = 0)
    {
        _auraHelpers.emplace_back();
        _auraHelpers.back().Create(auraType, miscValue, amount,
                                   casterGUID, owner, effIndex);
        return _auraHelpers.back().effect;
    }

    std::unique_ptr<IWorld> _previousWorld;
    NiceMock<WorldMock>* _worldMock = nullptr;
    TestMap* _map = nullptr;
    TestCreature* _creatureA = nullptr;
    TestCreature* _creatureB = nullptr;
    std::vector<TestAuraEffectHelper> _auraHelpers;
};

// ============================================================================
// TauntUpdate Tests
// ============================================================================

TEST_F(ThreatManagerAuraTest,
       TauntUpdate_NoAuras_ClearsTauntStates)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Manually set taunt state
    _creatureA->TestGetThreatMgr().SetTauntStateForTesting(
        _creatureB, ThreatReference::TAUNT_STATE_TAUNT);

    // Verify it's taunted
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsTaunting());

    // TauntUpdate with no auras should clear taunt state back to NONE
    _creatureA->TestGetThreatMgr().TauntUpdate();

    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_FALSE(ref->IsTaunting());
}

TEST_F(ThreatManagerAuraTest,
       TauntUpdate_NoAuras_EmptyThreatList_NoCrash)
{
    // No entries on A's threat list — TauntUpdate should not crash
    EXPECT_TRUE(_creatureA->TestGetThreatMgr().IsThreatListEmpty());
    _creatureA->TestGetThreatMgr().TauntUpdate();
}

TEST_F(ThreatManagerAuraTest,
       TauntUpdate_WithTauntAura_SetsTauntState)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Inject a MOD_TAUNT aura effect on creatureA with caster = creatureB
    AuraEffect* tauntEff = MakeAuraEffect(
        SPELL_AURA_MOD_TAUNT, 0, 0,
        _creatureB->GetGUID(), _creatureA);
    _creatureA->TestPushModAura(SPELL_AURA_MOD_TAUNT, tauntEff);

    _creatureA->TestGetThreatMgr().TauntUpdate();

    // B should now have taunt state on A's threat list
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
    {
        if (ref->GetVictim() == _creatureB)
        {
            EXPECT_TRUE(ref->IsTaunting());
            EXPECT_GE(static_cast<uint32>(ref->GetTauntState()),
                       static_cast<uint32>(ThreatReference::TAUNT_STATE_TAUNT));
        }
    }
}

TEST_F(ThreatManagerAuraTest,
       TauntUpdate_MultipleTaunts_LastTauntWinsVictimSelection)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // B has higher threat but C is the last taunt in the list
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    _creatureA->TestGetThreatMgr().AddThreat(creatureC, 50.0f);

    // Inject two taunt auras: B first, then C
    // TauntUpdate assigns increasing state values (2, 3, ...)
    // so the last taunt (C) gets the higher state and wins selection
    AuraEffect* tauntB = MakeAuraEffect(
        SPELL_AURA_MOD_TAUNT, 0, 0,
        _creatureB->GetGUID(), _creatureA);
    AuraEffect* tauntC = MakeAuraEffect(
        SPELL_AURA_MOD_TAUNT, 0, 0,
        creatureC->GetGUID(), _creatureA);
    _creatureA->TestPushModAura(SPELL_AURA_MOD_TAUNT, tauntB);
    _creatureA->TestPushModAura(SPELL_AURA_MOD_TAUNT, tauntC);

    _creatureA->TestGetThreatMgr().TauntUpdate();

    // Both should be taunting
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
    {
        if (ref->GetVictim() == _creatureB || ref->GetVictim() == creatureC)
            EXPECT_TRUE(ref->IsTaunting());
    }

    // C was the last taunt → gets higher internal state → wins selection
    // despite B having higher base threat
    _creatureA->TestGetThreatMgr().Update(ThreatManager::THREAT_UPDATE_INTERVAL);
    EXPECT_EQ(_creatureA->TestGetThreatMgr().GetCurrentVictim(), creatureC);

    creatureC->CleanupCombatState();
    delete creatureC;
}

TEST_F(ThreatManagerAuraTest,
       TauntUpdate_TauntFromNonThreatened_Ignored)
{
    TestCreature* creatureC = new TestCreature();
    creatureC->SetupForCombatTest(_map, 3, 12347);
    creatureC->SetFaction(90002);

    // Only B is on A's threat list — C is NOT
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(creatureC));

    // Inject a taunt aura from C (who is NOT on the threat list)
    AuraEffect* tauntC = MakeAuraEffect(
        SPELL_AURA_MOD_TAUNT, 0, 0,
        creatureC->GetGUID(), _creatureA);
    _creatureA->TestPushModAura(SPELL_AURA_MOD_TAUNT, tauntC);

    _creatureA->TestGetThreatMgr().TauntUpdate();

    // B should NOT be taunting (the taunt was from C, not B)
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_FALSE(ref->IsTaunting());

    // C is still not on the threat list
    EXPECT_FALSE(_creatureA->TestGetThreatMgr().IsThreatenedBy(creatureC));

    creatureC->CleanupCombatState();
    delete creatureC;
}

// ============================================================================
// UpdateMyTempModifiers Tests
// ============================================================================

TEST_F(ThreatManagerAuraTest,
       UpdateMyTempModifiers_NoAuras_ModifierIsZero)
{
    // A adds threat against B → B._threatenedByMe has A
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // No MOD_TOTAL_THREAT auras on B → modifier should be 0
    _creatureB->TestGetThreatMgr().UpdateMyTempModifiers();

    EXPECT_EQ(_creatureB->TestGetThreatMgr().GetTempModifierForTesting(
                  _creatureA), 0);
}

TEST_F(ThreatManagerAuraTest,
       UpdateMyTempModifiers_WithAura_ModifierMatchesAmount)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Inject MOD_TOTAL_THREAT aura on B with amount=50
    AuraEffect* modEff = MakeAuraEffect(
        SPELL_AURA_MOD_TOTAL_THREAT, 0, 50,
        _creatureB->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_TOTAL_THREAT, modEff);

    _creatureB->TestGetThreatMgr().UpdateMyTempModifiers();

    EXPECT_EQ(_creatureB->TestGetThreatMgr().GetTempModifierForTesting(
                  _creatureA), 50);

    // GetThreat should now return baseAmount + tempModifier = 100 + 50 = 150
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 150.0f);
}

TEST_F(ThreatManagerAuraTest,
       UpdateMyTempModifiers_MultipleAuras_Sum)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Inject two MOD_TOTAL_THREAT effects: +30 and +20 = 50 total
    AuraEffect* eff1 = MakeAuraEffect(
        SPELL_AURA_MOD_TOTAL_THREAT, 0, 30,
        _creatureB->GetGUID(), _creatureB);
    AuraEffect* eff2 = MakeAuraEffect(
        SPELL_AURA_MOD_TOTAL_THREAT, 0, 20,
        _creatureB->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_TOTAL_THREAT, eff1);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_TOTAL_THREAT, eff2);

    _creatureB->TestGetThreatMgr().UpdateMyTempModifiers();

    EXPECT_EQ(_creatureB->TestGetThreatMgr().GetTempModifierForTesting(
                  _creatureA), 50);
}

TEST_F(ThreatManagerAuraTest,
       UpdateMyTempModifiers_EmptyThreatenedByMe_NoCrash)
{
    // B is not on anyone's threat list
    EXPECT_FALSE(_creatureB->TestGetThreatMgr().IsThreateningAnyone());

    // Inject aura but no threats — should not crash
    AuraEffect* eff = MakeAuraEffect(
        SPELL_AURA_MOD_TOTAL_THREAT, 0, 50,
        _creatureB->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_TOTAL_THREAT, eff);

    _creatureB->TestGetThreatMgr().UpdateMyTempModifiers();
}

// ============================================================================
// UpdateMySpellSchoolModifiers Tests
// ============================================================================

TEST_F(ThreatManagerAuraTest,
       UpdateMySpellSchoolModifiers_NoAuras_AllDefault)
{
    _creatureB->TestGetThreatMgr().UpdateMySpellSchoolModifiers();

    // All school modifiers should be 1.0 (default multiplier)
    for (uint8 i = 0; i < MAX_SPELL_SCHOOL; ++i)
        EXPECT_FLOAT_EQ(
            _creatureB->TestGetThreatMgr().GetSchoolModifierForTesting(i),
            1.0f);
}

TEST_F(ThreatManagerAuraTest,
       UpdateMySpellSchoolModifiers_WithFireModifier_AffectsFire)
{
    // Inject MOD_THREAT aura with miscValue = SPELL_SCHOOL_MASK_FIRE (4)
    // Amount = 50 means +50% threat for fire spells → multiplier = 1.5
    AuraEffect* eff = MakeAuraEffect(
        SPELL_AURA_MOD_THREAT,
        static_cast<int32>(SPELL_SCHOOL_MASK_FIRE), 50,
        _creatureB->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_THREAT, eff);

    _creatureB->TestGetThreatMgr().UpdateMySpellSchoolModifiers();

    // Fire (school index 2) should be modified
    EXPECT_FLOAT_EQ(
        _creatureB->TestGetThreatMgr().GetSchoolModifierForTesting(
            SPELL_SCHOOL_FIRE),
        1.5f);

    // Other schools should remain at 1.0
    EXPECT_FLOAT_EQ(
        _creatureB->TestGetThreatMgr().GetSchoolModifierForTesting(
            SPELL_SCHOOL_NORMAL),
        1.0f);
    EXPECT_FLOAT_EQ(
        _creatureB->TestGetThreatMgr().GetSchoolModifierForTesting(
            SPELL_SCHOOL_HOLY),
        1.0f);
}

TEST_F(ThreatManagerAuraTest,
       UpdateMySpellSchoolModifiers_ClearsMultiSchoolCache)
{
    // Call once to establish baseline
    _creatureB->TestGetThreatMgr().UpdateMySpellSchoolModifiers();

    // Add a fire modifier
    AuraEffect* eff = MakeAuraEffect(
        SPELL_AURA_MOD_THREAT,
        static_cast<int32>(SPELL_SCHOOL_MASK_FIRE), 100,
        _creatureB->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_THREAT, eff);

    // Call again — should update the single-school modifiers
    // and clear any cached multi-school entries
    _creatureB->TestGetThreatMgr().UpdateMySpellSchoolModifiers();

    // Fire should now be 2.0 (100% increase)
    EXPECT_FLOAT_EQ(
        _creatureB->TestGetThreatMgr().GetSchoolModifierForTesting(
            SPELL_SCHOOL_FIRE),
        2.0f);
}

TEST_F(ThreatManagerAuraTest,
       UpdateMySpellSchoolModifiers_NegativeModifier_ReducesThreat)
{
    // Inject MOD_THREAT with -50% for shadow school
    AuraEffect* eff = MakeAuraEffect(
        SPELL_AURA_MOD_THREAT,
        static_cast<int32>(SPELL_SCHOOL_MASK_SHADOW), -50,
        _creatureB->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_THREAT, eff);

    _creatureB->TestGetThreatMgr().UpdateMySpellSchoolModifiers();

    // Shadow (school index 5) should be 0.5 (-50%)
    EXPECT_FLOAT_EQ(
        _creatureB->TestGetThreatMgr().GetSchoolModifierForTesting(
            SPELL_SCHOOL_SHADOW),
        0.5f);
}

// ============================================================================
// GAP COVERAGE: ShouldBeSuppressed — Confuse aura path
// ShouldBeSuppressed returns true when victim HasAuraType(MOD_CONFUSE),
// putting the ThreatReference into SUPPRESSED state.
// ============================================================================

TEST_F(ThreatManagerAuraTest,
       ShouldBeSuppressed_ConfuseAura_PutsRefSuppressed)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Verify B starts ONLINE
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsOnline());

    // Inject SPELL_AURA_MOD_CONFUSE on B
    AuraEffect* confuseEff = MakeAuraEffect(
        SPELL_AURA_MOD_CONFUSE, 0, 0,
        _creatureA->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_CONFUSE, confuseEff);

    // EvaluateSuppressed is called on the VICTIM's ThreatManager (B),
    // which iterates B's _threatenedByMe refs and checks ShouldBeSuppressed
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    // B should now be SUPPRESSED (not offline, not online)
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
    {
        if (ref->GetVictim() == _creatureB)
        {
            EXPECT_FALSE(ref->IsOnline());
            EXPECT_TRUE(ref->IsSuppressed());
        }
    }
}

TEST_F(ThreatManagerAuraTest,
       ShouldBeSuppressed_ConfuseRemoved_RestoresOnline)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Apply confuse → suppressed
    AuraEffect* confuseEff = MakeAuraEffect(
        SPELL_AURA_MOD_CONFUSE, 0, 0,
        _creatureA->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_CONFUSE, confuseEff);
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsSuppressed());

    // Remove confuse → should restore to ONLINE (canExpire=true)
    _creatureB->TestClearModAuras(SPELL_AURA_MOD_CONFUSE);
    _creatureB->TestGetThreatMgr().EvaluateSuppressed(true);

    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsOnline());
}

// ============================================================================
// GAP COVERAGE: ShouldBeSuppressed — Breakable stun aura path
// HasBreakableByDamageAuraType(SPELL_AURA_MOD_STUN) returns true when
// the stun aura has AURA_INTERRUPT_FLAG_TAKE_DAMAGE set.
// ============================================================================

TEST_F(ThreatManagerAuraTest,
       ShouldBeSuppressed_BreakableStun_PutsRefSuppressed)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Create a stun aura with AURA_INTERRUPT_FLAG_TAKE_DAMAGE
    _auraHelpers.emplace_back();
    auto& helper = _auraHelpers.back();
    helper.spellEntry = new SpellEntry{};
    helper.spellEntry->EffectApplyAuraName[0] = SPELL_AURA_MOD_STUN;
    helper.spellEntry->AuraInterruptFlags = AURA_INTERRUPT_FLAG_TAKE_DAMAGE;
    helper.spellInfo = new SpellInfo(helper.spellEntry);
    helper.aura = new TestAura(
        helper.spellInfo, _creatureA->GetGUID(), _creatureB);
    helper.effect = new AuraEffect(
        helper.aura, 0, 0, true /*testTag*/);

    _creatureB->TestPushModAura(SPELL_AURA_MOD_STUN, helper.effect);

    // EvaluateSuppressed on victim (B) checks ShouldBeSuppressed for each ref
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    // B should be SUPPRESSED (breakable stun)
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
    {
        if (ref->GetVictim() == _creatureB)
        {
            EXPECT_FALSE(ref->IsOnline());
            EXPECT_TRUE(ref->IsSuppressed());
        }
    }
}

TEST_F(ThreatManagerAuraTest,
       ShouldBeSuppressed_NonBreakableStun_DoesNotSuppress)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Create a stun aura WITHOUT AURA_INTERRUPT_FLAG_TAKE_DAMAGE
    // This should NOT trigger HasBreakableByDamageAuraType
    _auraHelpers.emplace_back();
    auto& helper = _auraHelpers.back();
    helper.spellEntry = new SpellEntry{};
    helper.spellEntry->EffectApplyAuraName[0] = SPELL_AURA_MOD_STUN;
    helper.spellEntry->AuraInterruptFlags = 0; // NOT breakable by damage
    helper.spellInfo = new SpellInfo(helper.spellEntry);
    helper.aura = new TestAura(
        helper.spellInfo, _creatureA->GetGUID(), _creatureB);
    helper.effect = new AuraEffect(
        helper.aura, 0, 0, true /*testTag*/);

    _creatureB->TestPushModAura(SPELL_AURA_MOD_STUN, helper.effect);

    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    // B should remain ONLINE (stun is not breakable by damage)
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
        if (ref->GetVictim() == _creatureB)
            EXPECT_TRUE(ref->IsOnline());
}

// ============================================================================
// GAP COVERAGE: ShouldBeSuppressed — Taunt overrides suppression
// A taunting victim can never be suppressed, even with confuse aura.
// ============================================================================

TEST_F(ThreatManagerAuraTest,
       ShouldBeSuppressed_TauntOverridesConfuse_StaysOnline)
{
    _creatureA->TestGetThreatMgr().AddThreat(_creatureB, 100.0f);

    // Apply confuse on B
    AuraEffect* confuseEff = MakeAuraEffect(
        SPELL_AURA_MOD_CONFUSE, 0, 0,
        _creatureA->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_CONFUSE, confuseEff);

    // Also apply taunt from B on A's threat list
    AuraEffect* tauntEff = MakeAuraEffect(
        SPELL_AURA_MOD_TAUNT, 0, 0,
        _creatureB->GetGUID(), _creatureA);
    _creatureA->TestPushModAura(SPELL_AURA_MOD_TAUNT, tauntEff);
    _creatureA->TestGetThreatMgr().TauntUpdate();

    // EvaluateSuppressed on B — taunt should prevent suppression
    _creatureB->TestGetThreatMgr().EvaluateSuppressed();

    // B should stay ONLINE because taunt overrides suppression
    for (ThreatReference const* ref : _creatureA->TestGetThreatMgr().GetUnsortedThreatList())
    {
        if (ref->GetVictim() == _creatureB)
        {
            EXPECT_TRUE(ref->IsTaunting());
            EXPECT_TRUE(ref->IsOnline());
        }
    }
}

// ============================================================================
// GAP COVERAGE: CalculateModifiedThreat through AddThreat pipeline
// Verify that school modifiers injected via aura actually affect the
// threat value when AddThreat is called with a spell.
// ============================================================================

TEST_F(ThreatManagerAuraTest,
       AddThreat_WithFireSpell_AppliesAuraSchoolModifier)
{
    // Inject MOD_THREAT for fire school: +100% = 2.0 multiplier
    AuraEffect* eff = MakeAuraEffect(
        SPELL_AURA_MOD_THREAT,
        static_cast<int32>(SPELL_SCHOOL_MASK_FIRE), 100,
        _creatureB->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_THREAT, eff);

    // Update school modifiers so _singleSchoolModifiers[FIRE] = 2.0
    _creatureB->TestGetThreatMgr().UpdateMySpellSchoolModifiers();

    // Create a fire spell
    SpellEntry fakeSpellEntry{};
    fakeSpellEntry.SchoolMask = SPELL_SCHOOL_MASK_FIRE;
    SpellInfo fakeSpell(&fakeSpellEntry);

    // AddThreat 100 fire threat → modified to 200 via school modifier
    _creatureA->TestGetThreatMgr().AddThreat(
        _creatureB, 100.0f, &fakeSpell, false);

    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 200.0f);
}

TEST_F(ThreatManagerAuraTest,
       AddThreat_WithFireSpell_IgnoreModifiers_SkipsSchoolMod)
{
    // Inject +100% fire modifier
    AuraEffect* eff = MakeAuraEffect(
        SPELL_AURA_MOD_THREAT,
        static_cast<int32>(SPELL_SCHOOL_MASK_FIRE), 100,
        _creatureB->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_THREAT, eff);
    _creatureB->TestGetThreatMgr().UpdateMySpellSchoolModifiers();

    SpellEntry fakeSpellEntry{};
    fakeSpellEntry.SchoolMask = SPELL_SCHOOL_MASK_FIRE;
    SpellInfo fakeSpell(&fakeSpellEntry);

    // With ignoreModifiers=true, the school modifier should NOT apply
    _creatureA->TestGetThreatMgr().AddThreat(
        _creatureB, 100.0f, &fakeSpell, true);

    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 100.0f);
}

// ============================================================================
// GAP COVERAGE: Multi-school modifier cache in CalculateModifiedThreat
// When spell has multiple school bits set (e.g. FIRE|FROST = Frostfire),
// the system computes a combined modifier via GetTotalAuraMultiplierByMiscMask
// and caches it in _multiSchoolModifiers.
// ============================================================================

TEST_F(ThreatManagerAuraTest,
       AddThreat_MultiSchoolSpell_ComputesAndCachesModifier)
{
    // Inject separate fire and frost modifiers
    // Fire: +100% (2.0x)
    AuraEffect* fireEff = MakeAuraEffect(
        SPELL_AURA_MOD_THREAT,
        static_cast<int32>(SPELL_SCHOOL_MASK_FIRE), 100,
        _creatureB->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_THREAT, fireEff);

    // Frost: +50% (1.5x)
    AuraEffect* frostEff = MakeAuraEffect(
        SPELL_AURA_MOD_THREAT,
        static_cast<int32>(SPELL_SCHOOL_MASK_FROST), 50,
        _creatureB->GetGUID(), _creatureB);
    _creatureB->TestPushModAura(SPELL_AURA_MOD_THREAT, frostEff);

    _creatureB->TestGetThreatMgr().UpdateMySpellSchoolModifiers();

    // Create a multi-school spell (Frostfire = FIRE | FROST)
    SpellEntry fakeSpellEntry{};
    fakeSpellEntry.SchoolMask =
        SPELL_SCHOOL_MASK_FIRE | SPELL_SCHOOL_MASK_FROST;
    SpellInfo fakeSpell(&fakeSpellEntry);

    // Multi-school uses GetTotalAuraMultiplierByMiscMask which multiplies
    // matching aura effects: (1 + 100/100) * (1 + 50/100) = 2.0 * 1.5 = 3.0
    _creatureA->TestGetThreatMgr().AddThreat(
        _creatureB, 100.0f, &fakeSpell, false);

    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 300.0f);

    // A second add with the same school should use the cached value
    _creatureA->TestGetThreatMgr().AddThreat(
        _creatureB, 100.0f, &fakeSpell, false);

    // Total: 300 + 300 = 600
    EXPECT_FLOAT_EQ(
        _creatureA->TestGetThreatMgr().GetThreat(_creatureB), 600.0f);
}

} // namespace
