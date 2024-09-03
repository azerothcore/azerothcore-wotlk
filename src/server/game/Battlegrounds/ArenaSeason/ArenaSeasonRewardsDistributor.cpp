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

#include "ArenaSeasonRewardsDistributor.h"
#include "AchievementMgr.h"
#include "CharacterDatabase.h"
#include "Mail.h"
#include "Player.h"

const float minPctTeamGamesForMemberToGetReward = 30;

void ArenaSeasonTeamRewarderImpl::RewardTeamWithRewardGroup(ArenaTeam *arenaTeam, const ArenaSeasonRewardGroup &rewardGroup)
{
    RewardWithMail(arenaTeam, rewardGroup);
    RewardWithAchievements(arenaTeam, rewardGroup);
}

void ArenaSeasonTeamRewarderImpl::RewardWithMail(ArenaTeam* arenaTeam, ArenaSeasonRewardGroup const & rewardGroup)
{
    const int npcKingDondSender = 18897;

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

        auto draft = MailDraft(rewardGroup.rewardMailTemplateID);
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

    const uint minRequiredGames = 30;

    for (auto const& [id, team] : arenaTeams)
        if (team->GetStats().SeasonGames >= minRequiredGames)
            sortedTeams.push_back(team);

    std::sort(sortedTeams.begin(), sortedTeams.end(), [](ArenaTeam* a, ArenaTeam* b) {
        return a->GetRating() > b->GetRating();
    });

    std::sort(rewardGroups.begin(), rewardGroups.end(), [](ArenaSeasonRewardGroup a, ArenaSeasonRewardGroup b) {
        return a.minPctCriteria < b.minPctCriteria;
    });

    size_t totalTeams = sortedTeams.size();
    size_t prevTeamIndexRewarded = 0;

    for (auto const& rewardGroup : rewardGroups)
    {
        size_t minIndex = static_cast<size_t>(rewardGroup.minPctCriteria * totalTeams / 100);
        size_t maxIndex = static_cast<size_t>(rewardGroup.maxPctCriteria * totalTeams / 100);

        minIndex = std::min(minIndex, totalTeams);
        maxIndex = std::min(maxIndex, totalTeams);

        // Prevent rewarding the same team twice
        minIndex = std::max(minIndex, prevTeamIndexRewarded);

        // Ensure that at least one team is rewarded, even if the percentage is very small
        if (minIndex == maxIndex && minIndex < totalTeams)
            maxIndex = minIndex + 1;

        // Distribute rewards to the selected teams
        for (prevTeamIndexRewarded = minIndex; prevTeamIndexRewarded < maxIndex; ++prevTeamIndexRewarded)
        {
            ArenaTeam* team = sortedTeams[prevTeamIndexRewarded];
            _rewarder->RewardTeamWithRewardGroup(team, rewardGroup);
        }
    }
}
