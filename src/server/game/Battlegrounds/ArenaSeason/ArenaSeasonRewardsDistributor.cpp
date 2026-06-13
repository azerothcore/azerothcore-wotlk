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

#include "ArenaSeasonRewardsDistributor.h"
#include "AchievementMgr.h"
#include "CharacterDatabase.h"
#include "Mail.h"
#include "Player.h"
#include <algorithm>

constexpr float minPctTeamGamesForMemberToGetReward = 30;

void ArenaSeasonTeamRewarderImpl::RewardTeamWithRewardGroup(ArenaTeam *arenaTeam, const ArenaSeasonRewardGroup &rewardGroup)
{
    RewardWithMail(arenaTeam, rewardGroup);
    RewardWithAchievements(arenaTeam, rewardGroup);
}

void ArenaSeasonTeamRewarderImpl::RewardWithMail(ArenaTeam* arenaTeam, ArenaSeasonRewardGroup const & rewardGroup)
{
    if (rewardGroup.itemRewards.empty() && rewardGroup.goldReward == 0)
        return;

    const uint32 npcKingDondSender = 18897;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    for (auto const& member : arenaTeam->GetMembers())
    {
        uint32 teamSeasonGames = arenaTeam->GetStats().SeasonGames;
        // Avoid division by zero.
        if (teamSeasonGames == 0)
            continue;

        float memberParticipationPercentage = (static_cast<float>(member.SeasonGames) / teamSeasonGames) * 100;
        if (memberParticipationPercentage < minPctTeamGamesForMemberToGetReward)
            continue;

        Player* player = ObjectAccessor::FindPlayer(member.Guid);

        auto draft = rewardGroup.rewardMailTemplateID > 0 ?
            MailDraft(rewardGroup.rewardMailTemplateID, false) :
            MailDraft(rewardGroup.rewardMailSubject, rewardGroup.rewardMailBody);

        if (rewardGroup.goldReward > 0)
            draft.AddMoney(rewardGroup.goldReward);

        for (auto const& reward : rewardGroup.itemRewards)
            if (Item* item = Item::CreateItem(reward.entry, 1))
            {
                item->SaveToDB(trans);
                draft.AddItem(item);
            }

        draft.SendMailTo(trans, MailReceiver(player, member.Guid.GetCounter()), MailSender(npcKingDondSender));
    }
    CharacterDatabase.CommitTransaction(trans);
}

void ArenaSeasonTeamRewarderImpl::RewardWithAchievements(ArenaTeam* arenaTeam, ArenaSeasonRewardGroup const & rewardGroup)
{
    if (rewardGroup.achievementRewards.empty())
        return;

    for (auto const& member : arenaTeam->GetMembers())
    {
        uint32 teamSeasonGames = arenaTeam->GetStats().SeasonGames;
        // Avoid division by zero.
        if (teamSeasonGames == 0)
            continue;

        float memberParticipationPercentage = (static_cast<float>(member.SeasonGames) / teamSeasonGames) * 100;
        if (memberParticipationPercentage < minPctTeamGamesForMemberToGetReward)
            continue;

        Player* player = ObjectAccessor::FindPlayer(member.Guid);
        for (auto const& reward : rewardGroup.achievementRewards)
        {
            AchievementEntry const* achievement = sAchievementStore.LookupEntry(reward.entry);
            if (!achievement)
                continue;

            if (player)
                player->CompletedAchievement(achievement);
            else
                sAchievementMgr->CompletedAchievementForOfflinePlayer(member.Guid.GetCounter(), achievement);
        }
    }
}

ArenaSeasonRewardDistributor::ArenaSeasonRewardDistributor(ArenaSeasonTeamRewarder* rewarder)
    : _rewarder(rewarder)
{
}

void ArenaSeasonRewardDistributor::DistributeRewards(ArenaTeamMgr::ArenaTeamContainer &arenaTeams, std::vector<ArenaSeasonRewardGroup> &rewardGroups)
{
    std::vector<ArenaTeam*> sortedTeams;
    sortedTeams.reserve(arenaTeams.size());

    static constexpr uint16 minRequiredGames = 30;

    for (auto const& [id, team] : arenaTeams)
        if (team->GetStats().SeasonGames >= minRequiredGames)
            sortedTeams.push_back(team);

    std::sort(sortedTeams.begin(), sortedTeams.end(), [](ArenaTeam* a, ArenaTeam* b) {
        return a->GetRating() > b->GetRating();
    });

    std::vector<ArenaSeasonRewardGroup> pctRewardGroup;
    std::vector<ArenaSeasonRewardGroup> absRewardGroup;

    for (auto const& reward : rewardGroups)
    {
        if (reward.criteriaType == ARENA_SEASON_REWARD_CRITERIA_TYPE_PERCENT_VALUE)
            pctRewardGroup.push_back(reward);
        else
            absRewardGroup.push_back(reward);
    }

    size_t totalTeams = sortedTeams.size();
    for (auto const& rewardGroup : pctRewardGroup)
    {
        size_t minIndex = static_cast<size_t>(rewardGroup.minCriteria * totalTeams / 100);
        size_t maxIndex = static_cast<size_t>(rewardGroup.maxCriteria * totalTeams / 100);

        minIndex = std::min(minIndex, totalTeams);
        maxIndex = std::min(maxIndex, totalTeams);

        for (size_t i = minIndex; i < maxIndex; ++i)
        {
            ArenaTeam* team = sortedTeams[i];
            _rewarder->RewardTeamWithRewardGroup(team, rewardGroup);
        }
    }

    for (auto const& rewardGroup : absRewardGroup)
    {
        size_t minIndex = rewardGroup.minCriteria-1; // Top 1 team is the team with index 0, so we need make -1.
        size_t maxIndex = rewardGroup.maxCriteria;

        minIndex = std::max(minIndex, size_t(0));
        minIndex = std::min(minIndex, totalTeams);
        maxIndex = std::min(maxIndex, totalTeams);

        for (size_t i = minIndex; i < maxIndex; ++i)
        {
            ArenaTeam* team = sortedTeams[i];
            _rewarder->RewardTeamWithRewardGroup(team, rewardGroup);
        }
    }
}
