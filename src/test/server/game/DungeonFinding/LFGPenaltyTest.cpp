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
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "LFGMgr.h"
#include "gtest/gtest.h"

namespace lfg
{
    TEST(LFGPenaltyTest, DungeonCooldownOnlyAppliesToRandomDungeonQueuers)
    {
        EXPECT_TRUE(ShouldApplyDungeonCooldown(true, false, false));
        EXPECT_FALSE(ShouldApplyDungeonCooldown(false, false, false));
        EXPECT_FALSE(ShouldApplyDungeonCooldown(true, true, false));
        EXPECT_FALSE(ShouldApplyDungeonCooldown(true, false, true));
    }

    TEST(LFGPenaltyTest, VoteKickedPlayerWithCooldownCannotQueueSpecificDungeon)
    {
        bool constexpr hasDungeonCooldown = true;

        EXPECT_FALSE(ShouldApplyDungeonDeserter(true, false, hasDungeonCooldown, 4, true));
        EXPECT_TRUE(IsDungeonQueueBlockedByCooldown(false, hasDungeonCooldown));
    }

    TEST(LFGPenaltyTest, PlayerLeavingGroupOfAtMostThreeWithCooldownCannotQueueSpecificDungeon)
    {
        bool constexpr hasDungeonCooldown = true;
        uint8 constexpr playersRemainingFromTwoPlayerGroup = 1;
        uint8 constexpr playersRemainingFromThreePlayerGroup = 2;

        EXPECT_FALSE(ShouldApplyDungeonDeserter(
            false, false, hasDungeonCooldown, playersRemainingFromTwoPlayerGroup, true));
        EXPECT_FALSE(ShouldApplyDungeonDeserter(
            false, false, hasDungeonCooldown, playersRemainingFromThreePlayerGroup, true));
        EXPECT_TRUE(IsDungeonQueueBlockedByCooldown(false, hasDungeonCooldown));
    }

    TEST(LFGPenaltyTest, PlayerLeavingLargerGroupReceivesDeserter)
    {
        EXPECT_TRUE(ShouldApplyDungeonDeserter(false, false, true, LFG_GROUP_KICK_VOTES_NEEDED, true));
    }

    TEST(LFGPenaltyTest, ContinuingExistingDungeonIgnoresDungeonCooldown)
    {
        EXPECT_FALSE(IsDungeonQueueBlockedByCooldown(true, true));
    }
}
