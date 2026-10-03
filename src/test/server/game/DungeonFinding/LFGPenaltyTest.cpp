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

TEST(LFGPenaltyTest, DungeonCooldownOnlyAppliesToRandomDungeonQueuers)
{
    bool constexpr randomSelection = true;
    bool constexpr specificSelection = false;
    bool constexpr testingEnabled = true;
    bool constexpr testingDisabled = false;
    bool constexpr hasCooldown = true;
    bool constexpr noCooldown = false;

    EXPECT_TRUE(lfg::ShouldApplyDungeonCooldown(randomSelection, testingDisabled, noCooldown));
    EXPECT_FALSE(lfg::ShouldApplyDungeonCooldown(specificSelection, testingDisabled, noCooldown));
    EXPECT_FALSE(lfg::ShouldApplyDungeonCooldown(randomSelection, testingEnabled, noCooldown));
    EXPECT_FALSE(lfg::ShouldApplyDungeonCooldown(randomSelection, testingDisabled, hasCooldown));
}

TEST(LFGPenaltyTest, VoteKickedPlayerWithRunCooldownCanQueueSpecificDungeon)
{
    bool constexpr hasDungeonCooldown = true;
    bool constexpr isVoteKick = true;
    bool constexpr dungeonFinished = false;
    bool constexpr castDeserter = true;
    bool constexpr hasDeclineCooldown = false;
    uint8 constexpr remainingPlayers = 4;
    uint32 constexpr specificQueue = 0;

    EXPECT_FALSE(lfg::ShouldApplyDungeonDeserter(
        isVoteKick, dungeonFinished, hasDungeonCooldown, remainingPlayers, castDeserter));
    EXPECT_FALSE(lfg::IsDungeonQueueBlockedByCooldown(specificQueue, hasDungeonCooldown, hasDeclineCooldown));
}

TEST(LFGPenaltyTest, PlayerLeavingGroupOfAtMostThreeWithRunCooldownCanQueueSpecificDungeon)
{
    bool constexpr hasDungeonCooldown = true;
    bool constexpr isVoteKick = false;
    bool constexpr dungeonFinished = false;
    bool constexpr castDeserter = true;
    bool constexpr hasDeclineCooldown = false;
    uint32 constexpr specificQueue = 0;
    uint8 constexpr playersRemainingFromTwoPlayerGroup = 1;
    uint8 constexpr playersRemainingFromThreePlayerGroup = 2;

    EXPECT_FALSE(lfg::ShouldApplyDungeonDeserter(
        isVoteKick, dungeonFinished, hasDungeonCooldown, playersRemainingFromTwoPlayerGroup, castDeserter));
    EXPECT_FALSE(lfg::ShouldApplyDungeonDeserter(
        isVoteKick, dungeonFinished, hasDungeonCooldown, playersRemainingFromThreePlayerGroup, castDeserter));
    EXPECT_FALSE(lfg::IsDungeonQueueBlockedByCooldown(specificQueue, hasDungeonCooldown, hasDeclineCooldown));
}

TEST(LFGPenaltyTest, PlayerLeavingLargerGroupReceivesDeserter)
{
    bool constexpr isVoteKick = false;
    bool constexpr dungeonFinished = false;
    bool constexpr hasDungeonCooldown = true;
    bool constexpr castDeserter = true;

    EXPECT_TRUE(lfg::ShouldApplyDungeonDeserter(
        isVoteKick, dungeonFinished, hasDungeonCooldown, lfg::LFG_GROUP_KICK_VOTES_NEEDED, castDeserter));
}

TEST(LFGPenaltyTest, DeclineExpirySurvivesStateRestoration)
{
    lfg::LfgPlayerData data;
    time_t constexpr now = 1000;
    EXPECT_FALSE(data.HasDeclineCooldown(now));
    data.SetDeclineCooldown(now + lfg::LFG_TIME_DECLINE_COOLDOWN);
    data.SetState(lfg::LFG_STATE_PROPOSAL);
    data.RestoreState();
    data.SetState(lfg::LFG_STATE_NONE);
    EXPECT_TRUE(data.HasDeclineCooldown(now + lfg::LFG_TIME_DECLINE_COOLDOWN - 1));
    EXPECT_FALSE(data.HasDeclineCooldown(now + lfg::LFG_TIME_DECLINE_COOLDOWN));
}
