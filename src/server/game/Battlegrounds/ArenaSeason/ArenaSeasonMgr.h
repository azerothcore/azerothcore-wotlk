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

#ifndef _ARENASEASONMGR_H
#define _ARENASEASONMGR_H

#include "Common.h"
#include "ArenaTeamFilter.h"
#include <vector>
#include <unordered_map>

enum ArenaSeasonState
{
    ARENA_SEASON_STATE_DISABLED    = 0,
    ARENA_SEASON_STATE_IN_PROGRESS = 1
};

enum ArenaSeasonRewardType
{
    ARENA_SEASON_REWARD_TYPE_ITEM,
    ARENA_SEASON_REWARD_TYPE_ACHIEVEMENT
};

enum ArenaSeasonRewardGroupCriteriaType
{
    ARENA_SEASON_REWARD_CRITERIA_TYPE_PERCENT_VALUE,
    ARENA_SEASON_REWARD_CRITERIA_TYPE_ABSOLUTE_VALUE
};

// ArenaSeasonReward represents one reward, it can be an item or achievement.
struct ArenaSeasonReward
{
    ArenaSeasonReward() = default;

    // Item or acheivement entry.
    uint32 entry{};

    ArenaSeasonRewardType type{ARENA_SEASON_REWARD_TYPE_ITEM};

    // Used in unit tests.
    bool operator==(const ArenaSeasonReward& other) const
    {
        return entry == other.entry && type == other.type;
    }
};

struct ArenaSeasonRewardGroup
{
    ArenaSeasonRewardGroup() = default;

    uint8 season{};

    ArenaSeasonRewardGroupCriteriaType criteriaType;

    float minCriteria{};
    float maxCriteria{};

    uint32 rewardMailTemplateID{};
    std::string rewardMailSubject{};
    std::string rewardMailBody{};
    uint32 goldReward{};

    std::vector<ArenaSeasonReward> itemRewards;
    std::vector<ArenaSeasonReward> achievementRewards;

    // Used in unit tests.
    bool operator==(const ArenaSeasonRewardGroup& other) const
    {
        return minCriteria == other.minCriteria &&
               maxCriteria == other.maxCriteria &&
               criteriaType == other.criteriaType &&
               itemRewards == other.itemRewards &&
               achievementRewards == other.achievementRewards;
    }
};

class ArenaSeasonMgr
{
public:
    static ArenaSeasonMgr* instance();

    using ArenaSeasonRewardGroupsBySeasonContainer = std::unordered_map<uint8, std::vector<ArenaSeasonRewardGroup>>;

    // Loading functions
    void LoadRewards();
    void LoadActiveSeason();

    // Season management functions
    void ChangeCurrentSeason(uint8 season);
    uint8 GetCurrentSeason() { return _currentSeason; }

    void SetSeasonState(ArenaSeasonState state);
    ArenaSeasonState GetSeasonState() { return _currentSeasonState; }

    // Season completion functions
    void RewardTeamsForTheSeason(std::shared_ptr<ArenaTeamFilter> teamsFilter);
    bool CanDeleteArenaTeams();
    void DeleteArenaTeams();

private:
    uint16 GameEventForArenaSeason(uint8 season);
    void BroadcastUpdatedWorldState();

    ArenaSeasonRewardGroupsBySeasonContainer _arenaSeasonRewardGroupsStore;

    uint8 _currentSeason{};
    ArenaSeasonState _currentSeasonState{};
};

#define sArenaSeasonMgr ArenaSeasonMgr::instance()

#endif // _ARENASEASONMGR_H
