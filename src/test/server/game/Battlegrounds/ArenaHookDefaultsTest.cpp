/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "ScriptDefines/ArenaScript.h"
#include "ScriptDefines/AllBattlegroundScript.h"
#include "ArenaTeam.h"
#include "ObjectGuid.h"
#include "WorldMock.h"
#include "gtest/gtest.h"

/**
 * Tests that ArenaScript and AllBattlegroundScript hooks return
 * safe defaults when no scripts are registered, ensuring core
 * game logic (MemberWon/MemberLost, SaveToDB, etc.) is not
 * accidentally skipped.
 */
class ArenaHookDefaultsTest : public ::testing::Test
{
protected:
    static void EnsureScriptRegistriesInitialized()
    {
        static bool initialized = false;
        if (!initialized)
        {
            ScriptRegistry<ArenaScript>::InitEnabledHooksIfNeeded(ARENAHOOK_END);
            ScriptRegistry<BGScript>::InitEnabledHooksIfNeeded(ALLBATTLEGROUNDHOOK_END);
            initialized = true;
        }
    }

    void SetUp() override
    {
        previousWorld_ = std::move(sWorld);
        auto* mock = new ::testing::NiceMock<WorldMock>();
        ON_CALL(*mock, getIntConfig(::testing::_))
            .WillByDefault(::testing::Return(0));
        ON_CALL(*mock, getIntConfig(CONFIG_LEGACY_ARENA_START_RATING))
            .WillByDefault(::testing::Return(1500));
        ON_CALL(*mock, getIntConfig(CONFIG_ARENA_START_RATING))
            .WillByDefault(::testing::Return(0));
        sWorld.reset(mock);

        EnsureScriptRegistriesInitialized();
    }

    void TearDown() override
    {
        sWorld = std::move(previousWorld_);
    }

    std::unique_ptr<IWorld> previousWorld_;
};

// CanSaveToDB must return true by default so ArenaTeam::SaveToDB
// proceeds to write team and member stats to the database.
TEST_F(ArenaHookDefaultsTest, CanSaveToDBDefaultsTrue)
{
    ArenaTeam team;
    EXPECT_TRUE(sScriptMgr->CanSaveToDB(&team));
}

// OnBeforeArenaTeamMemberUpdate must return true by default so that
// MemberWon/MemberLost execute. A false return would skip personal
// rating and game count updates for all arena participants.
TEST_F(ArenaHookDefaultsTest, OnBeforeArenaTeamMemberUpdateDefaultsTrue)
{
    ArenaTeam team;
    EXPECT_TRUE(sScriptMgr->OnBeforeArenaTeamMemberUpdate(&team, nullptr, true, 1500, 0));
    EXPECT_TRUE(sScriptMgr->OnBeforeArenaTeamMemberUpdate(&team, nullptr, false, 1500, 0));
}

// CanSaveArenaStatsForMember must return true by default so that
// character_arena_stats (MMR, MaxMMR) are written to the database.
TEST_F(ArenaHookDefaultsTest, CanSaveArenaStatsForMemberDefaultsTrue)
{
    ArenaTeam team;
    EXPECT_TRUE(sScriptMgr->CanSaveArenaStatsForMember(&team, ObjectGuid::Empty));
}

// OnBeforeArenaCheckWinConditions must return true by default so
// the normal win condition check proceeds.
TEST_F(ArenaHookDefaultsTest, OnBeforeArenaCheckWinConditionsDefaultsTrue)
{
    EXPECT_TRUE(sScriptMgr->OnBeforeArenaCheckWinConditions(nullptr));
}

// CanAddGroupToMatchingPool must return true by default so groups
// are not filtered out of the BG matchmaking pool.
TEST_F(ArenaHookDefaultsTest, CanAddGroupToMatchingPoolDefaultsTrue)
{
    EXPECT_TRUE(sScriptMgr->CanAddGroupToMatchingPool(nullptr, nullptr, 0, nullptr, BattlegroundBracketId(0)));
}

// Verify the calling convention used in Arena::EndBattleground:
//   if (sScriptMgr->OnBeforeArenaTeamMemberUpdate(...))
//       team->MemberWon/MemberLost(...)
//
// The hook returns true when no scripts override it.
// The caller must NOT negate the result, or MemberWon/MemberLost
// will never execute and arena stats will silently stop saving.
TEST_F(ArenaHookDefaultsTest, MemberUpdateCallingConventionAllowsByDefault)
{
    ArenaTeam team;
    bool hookResult = sScriptMgr->OnBeforeArenaTeamMemberUpdate(
        &team, nullptr, true, 1500, 0);

    // This simulates the condition in Arena::EndBattleground.
    // MemberWon must be called when no scripts are registered.
    bool memberWonWouldExecute = hookResult; // NOT !hookResult
    EXPECT_TRUE(memberWonWouldExecute)
        << "MemberWon/MemberLost must execute when no scripts override "
           "OnBeforeArenaTeamMemberUpdate. Check Arena.cpp is using "
           "if(sScriptMgr->OnBeforeArenaTeamMemberUpdate(...)) without negation.";
}
