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

#ifndef _ARENASEASONREWARDDISTRIBUTOR_H
#define _ARENASEASONREWARDDISTRIBUTOR_H

#include "ArenaSeasonMgr.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"

class ArenaSeasonTeamRewarder
{
public:
    virtual ~ArenaSeasonTeamRewarder() = default;

    virtual void RewardTeamWithRewardGroup(ArenaTeam* arenaTeam, ArenaSeasonRewardGroup const & rewardGroup) = 0;
};

class ArenaSeasonTeamRewarderImpl: public ArenaSeasonTeamRewarder
{
public:
    void RewardTeamWithRewardGroup(ArenaTeam* arenaTeam, ArenaSeasonRewardGroup const & rewardGroup) override;

private:
    void RewardWithMail(ArenaTeam* arenaTeam, ArenaSeasonRewardGroup const & rewardGroup);
    void RewardWithAchievements(ArenaTeam* arenaTeam, ArenaSeasonRewardGroup const & rewardGroup);
};

class ArenaSeasonRewardDistributor
{
public:
    ArenaSeasonRewardDistributor(ArenaSeasonTeamRewarder* rewarder);

    void DistributeRewards(ArenaTeamMgr::ArenaTeamContainer& arenaTeams, std::vector<ArenaSeasonRewardGroup>& rewardGroups);

private:
    ArenaSeasonTeamRewarder* _rewarder;
};

#endif // _ARENASEASONREWARDDISTRIBUTOR_H
