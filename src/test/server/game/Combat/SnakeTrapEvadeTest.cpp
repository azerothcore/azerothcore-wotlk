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
#include "CreatureAI.h"
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
// Regression test for snake trap evade recursion crash.
//
// The old npc_pet_hunter_snake_trap::EnterEvadeMode called CombatStop(true)
// which triggers ClearInCombat -> EndAllCombat -> CombatReference::EndCombat
// -> JustExitedCombat -> EnterEvadeMode, causing deep recursion and a
// freeze-detector crash during Battleground::EndBattleground.
//
// The fix removes the custom EnterEvadeMode override entirely, using the base
// CreatureAI::EnterEvadeMode which properly guards against recursion via
// UNIT_STATE_EVADE before calling CombatStop.
//
// This test verifies that ending combat on a creature with multiple PvE refs
// does not cause unbounded recursion or leave stale combat state.
// ============================================================================
class SnakeTrapEvadeTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        _previousWorld = std::move(sWorld);
        _worldMock = new NiceMock<WorldMock>();

        ON_CALL(*_worldMock, getIntConfig(_)).WillByDefault(Return(0));
        ON_CALL(*_worldMock, getFloatConfig(_)).WillByDefault(Return(1.0f));
        ON_CALL(*_worldMock, getBoolConfig(_)).WillByDefault(Return(false));
        static std::string emptyString;
        ON_CALL(*_worldMock, GetDataPath()).WillByDefault(ReturnRef(emptyString));

        sWorld.reset(_worldMock);

        // Create two mutually hostile factions
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

        // Simulate a "snake trap snake" — a creature with multiple combat refs
        _snake = new TestCreature();
        _snake->SetupForCombatTest(_map, 1, 19833); // NPC_VENOMOUS_SNAKE entry
        _snake->SetFaction(90001);

        // Simulate two enemy targets (e.g., players in a BG)
        _targetA = new TestCreature();
        _targetA->SetupForCombatTest(_map, 2, 50001);
        _targetA->SetFaction(90002);

        _targetB = new TestCreature();
        _targetB->SetupForCombatTest(_map, 3, 50002);
        _targetB->SetFaction(90002);
    }

    void TearDown() override
    {
        _snake->CleanupCombatState();
        _targetA->CleanupCombatState();
        _targetB->CleanupCombatState();
        delete _snake;
        delete _targetA;
        delete _targetB;
        delete _map;
        sWorld = std::move(_previousWorld);
    }

    std::unique_ptr<IWorld> _previousWorld;
    NiceMock<WorldMock>* _worldMock = nullptr;
    TestMap* _map = nullptr;
    TestCreature* _snake = nullptr;
    TestCreature* _targetA = nullptr;
    TestCreature* _targetB = nullptr;
};

// Verify that ending all combat on a creature with multiple refs completes
// without hanging or leaving stale state (regression: recursive EnterEvadeMode)
// cppcheck-suppress syntaxError
TEST_F(SnakeTrapEvadeTest, EndAllCombat_WithMultipleRefs_DoesNotRecurse)
{
    // Put the snake in combat with both targets
    _snake->TestGetCombatMgr().SetInCombatWith(_targetA);
    _snake->TestGetCombatMgr().SetInCombatWith(_targetB);

    ASSERT_TRUE(_snake->TestGetCombatMgr().HasCombat());
    ASSERT_TRUE(_snake->TestGetCombatMgr().IsInCombatWith(_targetA));
    ASSERT_TRUE(_snake->TestGetCombatMgr().IsInCombatWith(_targetB));

    // This is the call path that caused the crash:
    // EndAllCombat -> EndCombat -> JustExitedCombat -> EnterEvadeMode -> CombatStop -> EndAllCombat
    // With the old custom EnterEvadeMode, this would recurse unboundedly.
    _snake->TestGetCombatMgr().EndAllPvECombat();

    // All combat state should be cleanly resolved
    EXPECT_FALSE(_snake->TestGetCombatMgr().HasCombat());
    EXPECT_FALSE(_targetA->TestGetCombatMgr().HasCombat());
    EXPECT_FALSE(_targetB->TestGetCombatMgr().HasCombat());
}

// Verify that CombatStop on a target also clears the snake's refs cleanly
TEST_F(SnakeTrapEvadeTest, TargetCombatStop_ClearsSnakeRefs)
{
    _snake->TestGetCombatMgr().SetInCombatWith(_targetA);
    _snake->TestGetCombatMgr().SetInCombatWith(_targetB);

    ASSERT_TRUE(_snake->TestGetCombatMgr().HasCombat());

    // Simulate what Battleground::EndBattleground does: CombatStop on the target
    // This triggers ClearInCombat -> EndAllCombat on _targetA, which calls
    // EndCombat on the ref(targetA, snake), which triggers JustExitedCombat
    // on the snake if it's the snake's last ref.
    _targetA->TestGetCombatMgr().EndAllPvECombat();

    // targetA should be out of combat
    EXPECT_FALSE(_targetA->TestGetCombatMgr().HasCombat());
    // Snake should still be in combat with targetB
    EXPECT_TRUE(_snake->TestGetCombatMgr().HasCombat());
    EXPECT_TRUE(_snake->TestGetCombatMgr().IsInCombatWith(_targetB));

    // Now end targetB's combat too
    _targetB->TestGetCombatMgr().EndAllPvECombat();

    // Everything clean
    EXPECT_FALSE(_snake->TestGetCombatMgr().HasCombat());
    EXPECT_FALSE(_targetB->TestGetCombatMgr().HasCombat());
}

// Verify that adding threat during evade is rejected (guards against
// the old Reset() -> AddThreat -> re-enter combat pattern)
TEST_F(SnakeTrapEvadeTest, AddThreat_DuringEvade_IsRejected)
{
    _snake->TestGetCombatMgr().SetInCombatWith(_targetA);
    _snake->TestGetThreatMgr().AddThreat(_targetA, 100.0f);

    ASSERT_TRUE(_snake->TestGetThreatMgr().IsThreatenedBy(_targetA));

    // Enter evade state
    _snake->AddUnitState(UNIT_STATE_EVADE);

    // AddThreat should be rejected while in evade
    _snake->TestGetThreatMgr().ClearAllThreat();
    _snake->AddThreat(_targetB, 100000.0f);

    // Should NOT have threat on targetB because UNIT_STATE_EVADE blocks AddThreat
    EXPECT_FALSE(_snake->TestGetThreatMgr().IsThreatenedBy(_targetB));

    _snake->ClearUnitState(UNIT_STATE_EVADE);
}

} // namespace
