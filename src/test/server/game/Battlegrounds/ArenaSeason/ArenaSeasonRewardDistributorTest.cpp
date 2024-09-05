/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Define.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include "ArenaSeasonRewardsDistributor.h"

class MockArenaSeasonTeamRewarder : public ArenaSeasonTeamRewarder
{
public:
    MOCK_METHOD(void, RewardTeamWithRewardGroup, (ArenaTeam* arenaTeam, ArenaSeasonRewardGroup const& rewardGroup), (override));
};

class ArenaSeasonRewardDistributorTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        _mockRewarder = std::make_unique<MockArenaSeasonTeamRewarder>();
        _distributor = std::make_unique<ArenaSeasonRewardDistributor>(_mockRewarder.get());
    }

    std::unique_ptr<MockArenaSeasonTeamRewarder> _mockRewarder;
    std::unique_ptr<ArenaSeasonRewardDistributor> _distributor;
};

ArenaTeam ArenaTeamWithRating(int rating, int gamesPlayed)
{
    ArenaTeamStats stats;
    stats.Rating = rating;
    stats.SeasonGames = gamesPlayed;
    ArenaTeam team;
    team.SetArenaTeamStats(stats);
    return team;
}

// This test verifies that a single team receives the correct reward group when multiple percent reward groups are defined.
TEST_F(ArenaSeasonRewardDistributorTest, SingleTeamMultiplePctRewardDistribution)
{
    ArenaTeamMgr::ArenaTeamContainer arenaTeams;
    std::vector<ArenaSeasonRewardGroup> rewardGroups;

    ArenaTeam team = ArenaTeamWithRating(1500, 50);
    arenaTeams[1] = &team;

    ArenaSeasonRewardGroup rewardGroup;
    rewardGroup.criteriaType = ARENA_SEASON_REWARD_CRITERIA_TYPE_PERCENT_VALUE;
    rewardGroup.minCriteria = 0;
    rewardGroup.maxCriteria = 0.5;
    rewardGroups.push_back(rewardGroup);
    ArenaSeasonRewardGroup rewardGroup2;
    rewardGroup2.criteriaType = ARENA_SEASON_REWARD_CRITERIA_TYPE_PERCENT_VALUE;
    rewardGroup2.minCriteria = 0.5;
    rewardGroup2.maxCriteria = 100;
    rewardGroups.push_back(rewardGroup2);

    EXPECT_CALL(*_mockRewarder, RewardTeamWithRewardGroup(&team, rewardGroup2)).Times(1);

    _distributor->DistributeRewards(arenaTeams, rewardGroups);
}

// This test verifies that a single team receives the correct reward group when multiple abs percent reward groups are defined.
TEST_F(ArenaSeasonRewardDistributorTest, SingleTeamMultipleAbsRewardDistribution)
{
    ArenaTeamMgr::ArenaTeamContainer arenaTeams;
    std::vector<ArenaSeasonRewardGroup> rewardGroups;

    ArenaTeam team = ArenaTeamWithRating(1500, 50);
    arenaTeams[1] = &team;

    ArenaSeasonRewardGroup rewardGroup;
    rewardGroup.criteriaType = ARENA_SEASON_REWARD_CRITERIA_TYPE_ABSOLUTE_VALUE;
    rewardGroup.minCriteria = 1;
    rewardGroup.maxCriteria = 1;
    rewardGroups.push_back(rewardGroup);
    ArenaSeasonRewardGroup rewardGroup2;
    rewardGroup2.criteriaType = ARENA_SEASON_REWARD_CRITERIA_TYPE_ABSOLUTE_VALUE;
    rewardGroup2.minCriteria = 2;
    rewardGroup2.maxCriteria = 10;
    rewardGroups.push_back(rewardGroup2);

    EXPECT_CALL(*_mockRewarder, RewardTeamWithRewardGroup(&team, rewardGroup)).Times(1);

    _distributor->DistributeRewards(arenaTeams, rewardGroups);
}

// Input: 1000 teams with incremental ratings and two reward groups with 0% - 0.5% and 0.5% - 3% percentage criteria.
// Purpose: Ensures that the top 0.5% of teams receive the first reward and the next 3% receive the second reward.
//          Each team should be rewarded only once.
TEST_F(ArenaSeasonRewardDistributorTest, ManyTeamsTwoRewardsDistribution)
{
    ArenaTeamMgr::ArenaTeamContainer arenaTeams;
    std::vector<ArenaSeasonRewardGroup> rewardGroups;

    const int numTeams = 1000;
    ArenaTeam teams[numTeams + 1]; // used just to prevent teams deletion
    for (int i = 1; i <= numTeams; i++)
    {
        teams[i] = ArenaTeamWithRating(i, 50);
        arenaTeams[i] = &teams[i];
    }

    ArenaSeasonRewardGroup rewardGroup1;
    rewardGroup1.criteriaType = ARENA_SEASON_REWARD_CRITERIA_TYPE_PERCENT_VALUE;
    rewardGroup1.minCriteria = 0.0;  // 0%
    rewardGroup1.maxCriteria = 0.5;  // 0.5% of total teams
    rewardGroups.push_back(rewardGroup1);

    ArenaSeasonRewardGroup rewardGroup2;
    rewardGroup2.criteriaType = ARENA_SEASON_REWARD_CRITERIA_TYPE_PERCENT_VALUE;
    rewardGroup2.minCriteria = 0.5;  // 0.5% (the top 0.5% of the teams)
    rewardGroup2.maxCriteria = 3.0;  // 3% of total teams
    rewardGroups.push_back(rewardGroup2);

    ArenaSeasonRewardGroup rewardGroup3;
    rewardGroup3.criteriaType = ARENA_SEASON_REWARD_CRITERIA_TYPE_PERCENT_VALUE;
    rewardGroup3.minCriteria = 3;
    rewardGroup3.maxCriteria = 10;
    rewardGroups.push_back(rewardGroup3);

    ArenaSeasonRewardGroup rewardGroup4;
    rewardGroup4.criteriaType = ARENA_SEASON_REWARD_CRITERIA_TYPE_PERCENT_VALUE;
    rewardGroup4.minCriteria = 10;
    rewardGroup4.maxCriteria = 35;
    rewardGroups.push_back(rewardGroup4);

    // Top 1
    ArenaSeasonRewardGroup rewardGroup5;
    rewardGroup5.criteriaType = ARENA_SEASON_REWARD_CRITERIA_TYPE_ABSOLUTE_VALUE;
    rewardGroup5.minCriteria = 1;
    rewardGroup5.maxCriteria = 1;
    rewardGroups.push_back(rewardGroup5);

    // Calculate expected reward distributions
    int expectedTeamsInGroup1 = static_cast<int>(0.005 * numTeams);  // 0.5% of 1000 = 5
    int expectedTeamsInGroup2 = static_cast<int>(0.03 * numTeams);   // 3% of 1000 = 30
    int expectedTeamsInGroup3 = static_cast<int>(0.10 * numTeams);   // 10% of 1000 = 100
    int expectedTeamsInGroup4 = static_cast<int>(0.35 * numTeams);   // 35% of 1000 = 350

    int teamsIndexCounter = numTeams;

    // Expectation for rewardGroup1 (top 0.5% of teams)
    for (; teamsIndexCounter > numTeams - expectedTeamsInGroup1; --teamsIndexCounter)
        EXPECT_CALL(*_mockRewarder, RewardTeamWithRewardGroup(&teams[teamsIndexCounter], rewardGroup1)).Times(1);

    // Expectation for rewardGroup2 (next 3% - 0.5% teams)
    for (; teamsIndexCounter > numTeams - expectedTeamsInGroup2; --teamsIndexCounter)
        EXPECT_CALL(*_mockRewarder, RewardTeamWithRewardGroup(&teams[teamsIndexCounter], rewardGroup2)).Times(1);

    for (; teamsIndexCounter > numTeams - expectedTeamsInGroup3; --teamsIndexCounter)
        EXPECT_CALL(*_mockRewarder, RewardTeamWithRewardGroup(&teams[teamsIndexCounter], rewardGroup3)).Times(1);

    for (; teamsIndexCounter > numTeams - expectedTeamsInGroup4; --teamsIndexCounter)
        EXPECT_CALL(*_mockRewarder, RewardTeamWithRewardGroup(&teams[teamsIndexCounter], rewardGroup4)).Times(1);

    // Top 1
    EXPECT_CALL(*_mockRewarder, RewardTeamWithRewardGroup(&teams[numTeams], rewardGroup5)).Times(1);

    _distributor->DistributeRewards(arenaTeams, rewardGroups);
}

// Input: Three teams where one has fewer than the minimum required games and two have enough games.
// Purpose: Ensures that only teams meeting the minimum required games threshold are eligible for rewards.
TEST_F(ArenaSeasonRewardDistributorTest, MinimumRequiredGamesFilter)
{
    ArenaTeamMgr::ArenaTeamContainer arenaTeams;
    std::vector<ArenaSeasonRewardGroup> rewardGroups;

    // Creating three teams: one below and two above the minRequiredGames threshold (30 games)
    ArenaTeam team1 = ArenaTeamWithRating(1500, 50);  // Eligible, as it has 50 games
    ArenaTeam team2 = ArenaTeamWithRating(1100, 20);  // Not eligible, as it has only 20 games
    ArenaTeam team3 = ArenaTeamWithRating(1300, 40);  // Eligible, as it has 40 games

    // Adding teams to the container
    arenaTeams[1] = &team1;
    arenaTeams[2] = &team2;
    arenaTeams[3] = &team3;

    // Creating a single reward group covering all teams
    ArenaSeasonRewardGroup rewardGroup;
    rewardGroup.criteriaType = ARENA_SEASON_REWARD_CRITERIA_TYPE_PERCENT_VALUE;
    rewardGroup.minCriteria = 0.0;
    rewardGroup.maxCriteria = 100;
    rewardGroups.push_back(rewardGroup);

    // We expect the rewarder to be called for team1 and team3, but not for team2.
    EXPECT_CALL(*_mockRewarder, RewardTeamWithRewardGroup(&team1, rewardGroup)).Times(1);
    EXPECT_CALL(*_mockRewarder, RewardTeamWithRewardGroup(&team3, rewardGroup)).Times(1);
    EXPECT_CALL(*_mockRewarder, RewardTeamWithRewardGroup(&team2, rewardGroup)).Times(0);

    _distributor->DistributeRewards(arenaTeams, rewardGroups);
}
