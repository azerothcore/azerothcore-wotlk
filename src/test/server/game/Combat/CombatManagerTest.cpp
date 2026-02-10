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

} // namespace
