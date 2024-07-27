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

#include "BattlegroundQueue.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "BattlegroundMgr.h"
#include "BattlegroundSpamProtect.h"
#include "Channel.h"
#include "Chat.h"
#include "GameTime.h"
#include "Group.h"
#include "Language.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include <unordered_map>

//npcbot
//non-PCH
#include "Creature.h"
#include "botmgr.h"
#include "botdatamgr.h"
//end npcbot

/*********************************************************/
/***            BATTLEGROUND QUEUE SYSTEM              ***/
/*********************************************************/

BattlegroundQueue::BattlegroundQueue()
{
    for (uint32 i = 0; i < PVP_TEAMS_COUNT; ++i)
    {
        for (uint32 j = 0; j < MAX_BATTLEGROUND_BRACKETS; ++j)
        {
            m_WaitTimeLastIndex[i][j] = 0;
            for (uint32 k = 0; k < COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME; ++k)
                m_WaitTimes[i][j][k] = 0;
        }
    }

    _queueAnnouncementTimer.fill(-1);
    _queueAnnouncementCrossfactioned = false;
}

BattlegroundQueue::~BattlegroundQueue()
{
    m_events.KillAllEvents(false);

    m_QueuedPlayers.clear();
    for (auto& m_QueuedGroup : m_QueuedGroups)
    {
        for (auto& j : m_QueuedGroup)
        {
            for (auto& itr : j)
                delete itr;
            j.clear();
        }
    }
}

/*********************************************************/
/***      BATTLEGROUND QUEUE SELECTION POOLS           ***/
/*********************************************************/

// selection pool initialization, used to clean up from prev selection
void BattlegroundQueue::SelectionPool::Init()
{
    SelectedGroups.clear();
    PlayerCount = 0;
}

// returns true if we kicked more than requested
bool BattlegroundQueue::SelectionPool::KickGroup(const uint32 size)
{
    if (SelectedGroups.empty())
        return false;

    // find last group with proper size or largest
    bool foundProper = false;
    GroupQueueInfo* groupToKick{ SelectedGroups.front() };

    for (auto const& gInfo : SelectedGroups)
    {
        // if proper size - overwrite to kick last one
        if (std::abs(int32(gInfo->Players.size()) - (int32)size) <= 1)
        {
            groupToKick = gInfo;
            foundProper = true;
        }
        else if (!foundProper && gInfo->Players.size() >= groupToKick->Players.size())
            groupToKick = gInfo;
    }

    // remove selected from pool
    auto playersCountInGroup{ groupToKick->Players.size() };
    PlayerCount -= playersCountInGroup;
    std::erase(SelectedGroups, groupToKick);

    if (foundProper)
        return false;

    return playersCountInGroup > size;
}

// returns true if added or desired count not yet reached
bool BattlegroundQueue::SelectionPool::AddGroup(GroupQueueInfo* ginfo, uint32 desiredCount)
{
    // add if we don't exceed desiredCount
    if (!ginfo->IsInvitedToBGInstanceGUID && desiredCount >= PlayerCount + ginfo->Players.size())
    {
        SelectedGroups.push_back(ginfo);
        PlayerCount += ginfo->Players.size();
        return true;
    }
    return PlayerCount < desiredCount;
}

/*********************************************************/
/***               BATTLEGROUND QUEUES                 ***/
/*********************************************************/

// add group or player (grp == nullptr) to bg queue with the given leader and bg specifications
GroupQueueInfo* BattlegroundQueue::AddGroup(Player* leader, Group* group, BattlegroundTypeId bgTypeId, PvPDifficultyEntry const* bracketEntry, uint8 arenaType, bool isRated, bool isPremade,
    uint32 arenaRating, uint32 matchmakerRating, uint32 arenaTeamId /*= 0*/, uint32 opponentsArenaTeamId /*= 0*/)
{
    BattlegroundBracketId bracketId = bracketEntry->GetBracketId();

    // create new ginfo
    auto* ginfo                         = new GroupQueueInfo;
    ginfo->BgTypeId                     = bgTypeId;
    ginfo->ArenaType                    = arenaType;
    ginfo->ArenaTeamId                  = arenaTeamId;
    ginfo->IsRated                      = isRated;
    ginfo->IsInvitedToBGInstanceGUID    = 0;
    ginfo->JoinTime                     = GameTime::GetGameTimeMS().count();
    ginfo->RemoveInviteTime             = 0;
    ginfo->teamId                       = leader->GetTeamId();
    ginfo->RealTeamID                   = leader->GetTeamId(true);
    ginfo->ArenaTeamRating              = arenaRating;
    ginfo->ArenaMatchmakerRating        = matchmakerRating;
    ginfo->PreviousOpponentsTeamId      = opponentsArenaTeamId;
    ginfo->OpponentsTeamRating          = 0;
    ginfo->OpponentsMatchmakerRating    = 0;

    ginfo->Players.clear();

    //compute index (if group is premade or joined a rated match) to queues
    uint32 index = 0;

    if (!isRated && !isPremade)
        index += PVP_TEAMS_COUNT;

    if (ginfo->teamId == TEAM_HORDE)
        index++;

    sScriptMgr->OnAddGroup(this, ginfo, index, leader, group, bgTypeId, bracketEntry,
        arenaType, isRated, isPremade, arenaRating, matchmakerRating, arenaTeamId, opponentsArenaTeamId);

    LOG_DEBUG("bg.battleground", "Adding Group to BattlegroundQueue bgTypeId: {}, bracket_id: {}, index: {}", bgTypeId, bracketId, index);

    // pussywizard: store indices at which GroupQueueInfo is in m_QueuedGroups
    ginfo->BracketId = bracketId;
    ginfo->GroupType = index;

    //add players from group to ginfo
    if (group)
    {
        group->DoForAllMembers([this, ginfo](Player* member)
        {
            ASSERT(m_QueuedPlayers.count(member->GetGUID()) == 0);
            m_QueuedPlayers[member->GetGUID()] = ginfo;
            ginfo->Players.emplace(member->GetGUID());
        });
        //npcbot: queue bots (bg only)
        if (!arenaTeamId)
        {
            for (GroupBotReference* itr = group->GetFirstBotMember(); itr != nullptr; itr = itr->next())
            {
                Creature const* bot = itr->GetSource();
                if (!bot)
                    continue;
                m_QueuedPlayers[bot->GetGUID()] = ginfo;
                ginfo->Players.emplace(bot->GetGUID());
            }
        }
        //end npcbot
    }
    else
    {
        ASSERT(m_QueuedPlayers.count(leader->GetGUID()) == 0);
        m_QueuedPlayers[leader->GetGUID()] = ginfo;
        ginfo->Players.emplace(leader->GetGUID());
    }

    //add GroupInfo to m_QueuedGroups
    m_QueuedGroups[bracketId][index].push_back(ginfo);

    // announce world (this doesn't need mutex)
    SendJoinMessageArenaQueue(leader, ginfo, bracketEntry, isRated);

    Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(ginfo->BgTypeId);
    if (!bg)
        return ginfo;

    if (!isRated && !isPremade && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_ENABLE))
        SendMessageBGQueue(leader, bg, bracketEntry);

    //npcbot: try to queue wandering bots
    if (!isRated && !arenaType && !arenaTeamId && !sBattlegroundMgr->isTesting())
    {
        if (!BotDataMgr::GenerateBattlegroundBots(leader, group, this, bracketEntry, ginfo))
        {
            LOG_WARN("npcbots", "Did NOT generate bots for BG {} for leader {} ({} members)",
                uint32(bgTypeId), leader->GetDebugInfo().c_str(), group ? group->GetMembersCount() : 0u);
        }
    }
    //end npcbot

    return ginfo;
}

//npcbot
GroupQueueInfo* BattlegroundQueue::AddBotAsGroup(ObjectGuid guid, TeamId teamId, BattlegroundTypeId bgTypeId, PvPDifficultyEntry const* bracketEntry, uint8 arenaType, bool isRated, uint32 arenaRating, uint32 matchmakerRating, uint32 arenaTeamId, uint32 opponentsArenaTeamId)
{
    ASSERT(guid.IsCreature());

    BattlegroundBracketId bracketId = bracketEntry->GetBracketId();

    // create new ginfo
    GroupQueueInfo* ginfo            = new GroupQueueInfo;
    ginfo->BgTypeId                  = bgTypeId;
    ginfo->ArenaType                 = arenaType;
    ginfo->ArenaTeamId               = arenaTeamId;
    ginfo->IsRated                   = isRated;
    ginfo->IsInvitedToBGInstanceGUID = 0;
    ginfo->JoinTime                  = GameTime::GetGameTimeMS().count();
    ginfo->RemoveInviteTime          = 0;
    ginfo->teamId                    = teamId;
    ginfo->ArenaTeamRating           = arenaRating;
    ginfo->ArenaMatchmakerRating     = matchmakerRating;
    ginfo->PreviousOpponentsTeamId   = opponentsArenaTeamId;
    ginfo->OpponentsTeamRating       = 0;
    ginfo->OpponentsMatchmakerRating = 0;

    ginfo->Players.clear();

    uint32 index = 0;
    if (!isRated)
        index += PVP_TEAMS_COUNT;

    if (ginfo->teamId == TEAM_HORDE)
        index++;

    LOG_DEBUG("bg.battleground", "Adding Group to BattlegroundQueue bgTypeId: {}, bracket_id: {}, index: {}", bgTypeId, bracketId, index);

    // pussywizard: store indices at which GroupQueueInfo is in m_QueuedGroups
    ginfo->BracketId = bracketId;
    ginfo->GroupType = index;

    ASSERT(m_QueuedPlayers.count(guid) == 0);
    m_QueuedPlayers[guid] = ginfo;
    ginfo->Players.emplace(guid);

    //add GroupInfo to m_QueuedGroups
    m_QueuedGroups[bracketId][index].push_back(ginfo);

    Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(ginfo->BgTypeId);
    if (!bg)
        return ginfo;

    if (!isRated && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_ENABLE))
    {
        BattlegroundBracketId bracketId = bracketEntry->GetBracketId();
        std::string const& bgName = bg->GetName();
        uint32 MinPlayers = bg->GetMinPlayersPerTeam();
        uint32 MaxPlayers = MinPlayers * 2;
        uint32 q_min_level = std::min(bracketEntry->minLevel, (uint32)80);
        uint32 q_max_level = std::min(bracketEntry->maxLevel, (uint32)80);
        uint32 qHorde = GetPlayersCountInGroupsQueue(bracketId, BG_QUEUE_NORMAL_HORDE);
        uint32 qAlliance = GetPlayersCountInGroupsQueue(bracketId, BG_QUEUE_NORMAL_ALLIANCE);
        sWorld->SendWorldTextOptional(LANG_BG_QUEUE_ANNOUNCE_WORLD, ANNOUNCER_FLAG_DISABLE_BG_QUEUE, bgName.c_str(), q_min_level, q_max_level, qAlliance + qHorde, MaxPlayers);
    }

    return ginfo;
}
//end npcbot

void BattlegroundQueue::PlayerInvitedToBGUpdateAverageWaitTime(GroupQueueInfo* ginfo)
{
    uint32 timeInQueue = std::max<uint32>(1, getMSTimeDiff(ginfo->JoinTime, GameTime::GetGameTimeMS().count()));

    // team_index: bg alliance - TEAM_ALLIANCE, bg horde - TEAM_HORDE, arena skirmish - TEAM_ALLIANCE, arena rated - TEAM_HORDE
    uint8 team_index;
    if (!ginfo->ArenaType)
        team_index = ginfo->teamId;
    else
        team_index = (ginfo->IsRated ? TEAM_HORDE : TEAM_ALLIANCE);

    // just to be sure
    if (team_index >= TEAM_NEUTRAL)
        return;

    // pointer to last index
    uint32* lastIndex = &m_WaitTimeLastIndex[team_index][ginfo->BracketId];

    // set time at index to new value
    m_WaitTimes[team_index][ginfo->BracketId][*lastIndex] = timeInQueue;

    // set last index to next one
    (*lastIndex)++;
    (*lastIndex) %= COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME;
}

uint32 BattlegroundQueue::GetAverageQueueWaitTime(GroupQueueInfo* ginfo) const
{
    // team_index: bg alliance - TEAM_ALLIANCE, bg horde - TEAM_HORDE, arena skirmish - TEAM_ALLIANCE, arena rated - TEAM_HORDE
    uint8 team_index;
    if (!ginfo->ArenaType)
        team_index = ginfo->teamId;
    else
        team_index = (ginfo->IsRated ? TEAM_HORDE : TEAM_ALLIANCE);

    // just to be sure
    if (team_index >= TEAM_NEUTRAL)
        return 0;

    // if there are enough values:
    if (m_WaitTimes[team_index][ginfo->BracketId][COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME - 1])
    {
        uint32 sum = 0;
        for (uint32 i = 0; i < COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME; ++i)
            sum += m_WaitTimes[team_index][ginfo->BracketId][i];
        return sum / COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME;
    }
    else
        return 0;
}

//remove player from queue and from group info, if group info is empty then remove it too
void BattlegroundQueue::RemovePlayer(ObjectGuid guid, bool decreaseInvitedCount)
{
    //remove player from map, if he's there
    auto const& itr = m_QueuedPlayers.find(guid);
    if (itr == m_QueuedPlayers.end())
    {
        //This happens if a player logs out while in a bg because WorldSession::LogoutPlayer() notifies the bg twice
        std::string playerName = "Unknown";

        if (Player* player = ObjectAccessor::FindPlayer(guid))
        {
            playerName = player->GetName();
        }

        LOG_ERROR("bg.battleground", "BattlegroundQueue: couldn't find player {} ({})", playerName, guid.ToString());
        //ABORT("BattlegroundQueue: couldn't find player {} ({})", playerName, guid.ToString());
        return;
    }

    GroupQueueInfo* groupInfo = itr->second;

    uint32 _bracketId = groupInfo->BracketId;
    uint32 _groupType = groupInfo->GroupType;

    // find iterator
    auto group_itr = m_QueuedGroups[_bracketId][_groupType].end();

    for (auto k = m_QueuedGroups[_bracketId][_groupType].begin(); k != m_QueuedGroups[_bracketId][_groupType].end(); k++)
        if ((*k) == groupInfo)
        {
            group_itr = k;
            break;
        }

    // player can't be in queue without group, but just in case
    if (group_itr == m_QueuedGroups[_bracketId][_groupType].end())
    {
        LOG_ERROR("bg.battleground", "BattlegroundQueue: ERROR Cannot find groupinfo for {}", guid.ToString());
        //ABORT("BattlegroundQueue: ERROR Cannot find groupinfo for {}", guid.ToString());
        return;
    }

    LOG_DEBUG("bg.battleground", "BattlegroundQueue: Removing {}, from bracket_id {}", guid.ToString(), _bracketId);

    // remove player from group queue info
    auto const& pitr = groupInfo->Players.find(guid);
    ASSERT(pitr != groupInfo->Players.end());
    if (pitr != groupInfo->Players.end())
        groupInfo->Players.erase(pitr);

    // if invited to bg, and should decrease invited count, then do it
    if (decreaseInvitedCount && groupInfo->IsInvitedToBGInstanceGUID)
        if (Battleground* bg = sBattlegroundMgr->GetBattleground(groupInfo->IsInvitedToBGInstanceGUID, groupInfo->BgTypeId))
            bg->DecreaseInvitedCount(groupInfo->teamId);

    // remove player queue info
    m_QueuedPlayers.erase(itr);

    // announce to world if arena team left queue for rated match, show only once
    SendExitMessageArenaQueue(groupInfo);

    // if player leaves queue and he is invited to a rated arena match, then count it as he lost
    if (groupInfo->IsInvitedToBGInstanceGUID && groupInfo->IsRated && decreaseInvitedCount)
    {
        if (ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(groupInfo->ArenaTeamId))
        {
            LOG_DEBUG("bg.battleground", "UPDATING memberLost's personal arena rating for {} by opponents rating: {}", guid.ToString(), groupInfo->OpponentsTeamRating);

            if (Player* player = ObjectAccessor::FindConnectedPlayer(guid))
            {
                at->MemberLost(player, groupInfo->OpponentsMatchmakerRating);
            }

            at->SaveToDB();
        }
    }

    //npcbot: remove player's bots
    if (!groupInfo->Players.empty() && guid.IsPlayer())
    {
        std::vector<ObjectGuid> botguids;
        botguids.reserve(BotMgr::GetMaxNpcBots(DEFAULT_MAX_LEVEL) / 2);
        BotDataMgr::GetNPCBotGuidsByOwner(botguids, guid);
        for (std::vector<ObjectGuid>::const_iterator ci = botguids.begin(); ci != botguids.end() && !groupInfo->Players.empty(); ++ci)
        {
            auto bqpitr = m_QueuedPlayers.find(*ci);
            if (bqpitr != m_QueuedPlayers.end())
            {
                auto bgpitr = groupInfo->Players.find(*ci);
                if (bgpitr != groupInfo->Players.end())
                    groupInfo->Players.erase(bgpitr);

                if (decreaseInvitedCount && groupInfo->IsInvitedToBGInstanceGUID)
                    if (Battleground* bg = sBattlegroundMgr->GetBattleground(groupInfo->IsInvitedToBGInstanceGUID, groupInfo->BgTypeId))
                        bg->DecreaseInvitedCount(groupInfo->teamId);

                m_QueuedPlayers.erase(bqpitr);
            }
        }
    }
    //end npcbot

    // remove group queue info no players left
    if (groupInfo->Players.empty())
    {
        m_QueuedGroups[_bracketId][_groupType].erase(group_itr);
        delete groupInfo;
        return;
    }

    // group isn't yet empty, so not deleted yet
    // if it's a rated arena and any member leaves when group not yet invited - everyone from group leaves too!
    if (groupInfo->IsRated && !groupInfo->IsInvitedToBGInstanceGUID)
    {
        if (Player* plr = ObjectAccessor::FindConnectedPlayer(*(groupInfo->Players.begin())))
        {
            Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(groupInfo->BgTypeId);
            BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(groupInfo->BgTypeId, groupInfo->ArenaType);
            uint32 queueSlot = plr->GetBattlegroundQueueIndex(bgQueueTypeId);
            plr->RemoveBattlegroundQueueId(bgQueueTypeId);

            WorldPacket data;
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_NONE, 0, 0, 0, TEAM_NEUTRAL);
            plr->SendDirectMessage(&data);
        }

        // recursive call
        RemovePlayer(*groupInfo->Players.begin(), decreaseInvitedCount);
    }
}

void BattlegroundQueue::AddEvent(BasicEvent* Event, uint64 e_time)
{
    m_events.AddEvent(Event, m_events.CalculateTime(e_time));
}

bool BattlegroundQueue::IsPlayerInvitedToRatedArena(ObjectGuid pl_guid)
{
    auto qItr = m_QueuedPlayers.find(pl_guid);
    return qItr != m_QueuedPlayers.end() && qItr->second->IsRated && qItr->second->IsInvitedToBGInstanceGUID;
}

//returns true when player pl_guid is in queue and is invited to bgInstanceGuid
bool BattlegroundQueue::IsPlayerInvited(ObjectGuid pl_guid, const uint32 bgInstanceGuid, const uint32 removeTime)
{
    auto qItr = m_QueuedPlayers.find(pl_guid);
    return qItr != m_QueuedPlayers.end() && qItr->second->IsInvitedToBGInstanceGUID == bgInstanceGuid && qItr->second->RemoveInviteTime == removeTime;
}

//npcbot
bool BattlegroundQueue::IsBotInvited(ObjectGuid guid, uint32 bgInstanceGuid) const
{
    ASSERT(guid.IsCreature());
    QueuedPlayersMap::const_iterator qItr = m_QueuedPlayers.find(guid);
    return qItr != m_QueuedPlayers.end() && qItr->second->IsInvitedToBGInstanceGUID == bgInstanceGuid;
}
//end npcbot

bool BattlegroundQueue::GetPlayerGroupInfoData(ObjectGuid guid, GroupQueueInfo* ginfo)
{
    auto qItr = m_QueuedPlayers.find(guid);
    if (qItr == m_QueuedPlayers.end())
        return false;
    *ginfo = *(qItr->second);
    return true;
}

// this function is filling pools given free slots on both sides, result is ballanced
void BattlegroundQueue::FillPlayersToBG(Battleground* bg, BattlegroundBracketId bracket_id)
{
    if (!sScriptMgr->CanFillPlayersToBG(this, bg, bracket_id))
    {
        return;
    }

    int32 hordeFree = bg->GetFreeSlotsForTeam(TEAM_HORDE);
    int32 aliFree = bg->GetFreeSlotsForTeam(TEAM_ALLIANCE);
    uint32 aliCount = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].size();
    uint32 hordeCount = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].size();

    // try to get even teams
    if (sWorld->getIntConfig(CONFIG_BATTLEGROUND_INVITATION_TYPE) == BG_QUEUE_INVITATION_TYPE_EVEN)
    {
        // check if the teams are even
        if (hordeFree == 1 && aliFree == 1)
        {
            // if we are here, the teams have the same amount of players
            // then we have to allow to join the same amount of players
            int32 hordeExtra = hordeCount - aliCount;
            int32 aliExtra = aliCount - hordeCount;

            hordeExtra = std::max(hordeExtra, 0);
            aliExtra = std::max(aliExtra, 0);

            if (aliCount != hordeCount)
            {
                aliFree -= aliExtra;
                hordeFree -= hordeExtra;

                aliFree = std::max(aliFree, 0);
                hordeFree = std::max(hordeFree, 0);
            }
        }
    }

    GroupsQueueType::const_iterator Ali_itr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].begin();
    //count of groups in queue - used to stop cycles

    //index to queue which group is current
    uint32 aliIndex = 0;
    for (; aliIndex < aliCount && m_SelectionPools[TEAM_ALLIANCE].AddGroup((*Ali_itr), aliFree); aliIndex++)
        ++Ali_itr;

    //the same thing for horde
    GroupsQueueType::const_iterator Horde_itr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].begin();

    uint32 hordeIndex = 0;
    for (; hordeIndex < hordeCount && m_SelectionPools[TEAM_HORDE].AddGroup((*Horde_itr), hordeFree); hordeIndex++)
        ++Horde_itr;

    //if ofc like BG queue invitation is set in config, then we are happy
    if (sWorld->getIntConfig(CONFIG_BATTLEGROUND_INVITATION_TYPE) == BG_QUEUE_INVITATION_TYPE_NO_BALANCE)
        return;

    /*
    if we reached this code, then we have to solve NP - complete problem called Subset sum problem
    So one solution is to check all possible invitation subgroups, or we can use these conditions:
    1. Last time when BattlegroundQueue::Update was executed we invited all possible players - so there is only small possibility
        that we will invite now whole queue, because only 1 change has been made to queues from the last BattlegroundQueue::Update call
    2. Other thing we should consider is group order in queue
    */

    // At first we need to compare free space in bg and our selection pool
    int32 diffAli = aliFree - int32(m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount());
    int32 diffHorde = hordeFree - int32(m_SelectionPools[TEAM_HORDE].GetPlayerCount());

    while (std::abs(diffAli - diffHorde) > 1 && (m_SelectionPools[TEAM_HORDE].GetPlayerCount() > 0 || m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() > 0))
    {
        //each cycle execution we need to kick at least 1 group
        if (diffAli < diffHorde)
        {
            //kick alliance group, add to pool new group if needed
            if (m_SelectionPools[TEAM_ALLIANCE].KickGroup(diffHorde - diffAli))
            {
                for (; aliIndex < aliCount && m_SelectionPools[TEAM_ALLIANCE].AddGroup((*Ali_itr), (aliFree >= diffHorde) ? aliFree - diffHorde : 0); aliIndex++)
                    ++Ali_itr;
            }

            //if ali selection is already empty, then kick horde group, but if there are less horde than ali in bg - break;
            if (!m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount())
            {
                if (aliFree <= diffHorde + 1)
                    break;

                m_SelectionPools[TEAM_HORDE].KickGroup(diffHorde - diffAli);
            }
        }
        else
        {
            //kick horde group, add to pool new group if needed
            if (m_SelectionPools[TEAM_HORDE].KickGroup(diffAli - diffHorde))
            {
                for (; hordeIndex < hordeCount && m_SelectionPools[TEAM_HORDE].AddGroup((*Horde_itr), (hordeFree >= diffAli) ? hordeFree - diffAli : 0); hordeIndex++)
                    ++Horde_itr;
            }

            if (!m_SelectionPools[TEAM_HORDE].GetPlayerCount())
            {
                if (hordeFree <= diffAli + 1)
                    break;

                m_SelectionPools[TEAM_ALLIANCE].KickGroup(diffAli - diffHorde);
            }
        }

        //count diffs after small update
        diffAli = aliFree - int32(m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount());
        diffHorde = hordeFree - int32(m_SelectionPools[TEAM_HORDE].GetPlayerCount());
    }
}

// this method checks if premade versus premade battleground is possible
// then after 30 mins (default) in queue it moves premade group to normal queue
bool BattlegroundQueue::CheckPremadeMatch(BattlegroundBracketId bracket_id, uint32 MinPlayersPerTeam, uint32 MaxPlayersPerTeam)
{
    if (!m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].empty() && !m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].empty())
    {
        //start premade match
        //if groups aren't invited
        GroupsQueueType::const_iterator ali_group, horde_group;
        for (ali_group = m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].begin(); ali_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].end(); ++ali_group)
            if (!(*ali_group)->IsInvitedToBGInstanceGUID)
                break;

        for (horde_group = m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].begin(); horde_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].end(); ++horde_group)
            if (!(*horde_group)->IsInvitedToBGInstanceGUID)
                break;

        // if found both groups
        if (ali_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].end() && horde_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].end())
        {
            m_SelectionPools[TEAM_ALLIANCE].AddGroup((*ali_group), MaxPlayersPerTeam);
            m_SelectionPools[TEAM_HORDE].AddGroup((*horde_group), MaxPlayersPerTeam);

            //add groups/players from normal queue to size of bigger group
            uint32 maxPlayers = std::min(m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount(), m_SelectionPools[TEAM_HORDE].GetPlayerCount());
            GroupsQueueType::const_iterator itr;

            for (uint32 i = 0; i < PVP_TEAMS_COUNT; i++)
            {
                for (itr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].begin(); itr != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].end(); ++itr)
                {
                    //if itr can join BG and player count is less that maxPlayers, then add group to selectionpool
                    if (!(*itr)->IsInvitedToBGInstanceGUID && !m_SelectionPools[i].AddGroup((*itr), maxPlayers))
                        break;
                }
            }

            //premade selection pools are set
            return true;
        }
    }

    // now check if we can move group from Premade queue to normal queue (timer has expired) or group size lowered!!
    // this could be 2 cycles but i'm checking only first team in queue - it can cause problem -
    // if first is invited to BG and seconds timer expired, but we can ignore it, because players have only 80 seconds to click to enter bg
    // and when they click or after 80 seconds the queue info is removed from queue
    uint32 time_before = GameTime::GetGameTimeMS().count() - sWorld->getIntConfig(CONFIG_BATTLEGROUND_PREMADE_GROUP_WAIT_FOR_MATCH);

    for (uint32 i = 0; i < PVP_TEAMS_COUNT; i++)
    {
        if (!m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE + i].empty())
        {
            GroupsQueueType::iterator itr = m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE + i].begin();
            if (!(*itr)->IsInvitedToBGInstanceGUID && ((*itr)->JoinTime < time_before || (*itr)->Players.size() < MinPlayersPerTeam))
            {
                //we must insert group to normal queue and erase pointer from premade queue
                (*itr)->GroupType = BG_QUEUE_NORMAL_ALLIANCE + i; // pussywizard: update GroupQueueInfo internal variable
                m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].push_front((*itr));
                m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE + i].erase(itr);
            }
        }
    }

    //selection pools are not set
    return false;
}

// this method tries to create battleground or arena with MinPlayersPerTeam against MinPlayersPerTeam
bool BattlegroundQueue::CheckNormalMatch(Battleground* bgTemplate, BattlegroundBracketId bracket_id, uint32 minPlayers, uint32 maxPlayers)
{
    auto CanStartMatch = [this, bgTemplate, minPlayers]()
    {
        //allow 1v0 if debug bg
        if (sBattlegroundMgr->isTesting() && bgTemplate->isBattleground() && (m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() || m_SelectionPools[TEAM_HORDE].GetPlayerCount()))
            return true;

        //return true if there are enough players in selection pools - enable to work .debug bg command correctly
        return m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() >= minPlayers && m_SelectionPools[TEAM_HORDE].GetPlayerCount() >= minPlayers;
    };

    if (sScriptMgr->IsCheckNormalMatch(this, bgTemplate, bracket_id, minPlayers, maxPlayers))
        return CanStartMatch();

    GroupsQueueType::const_iterator itr_team[PVP_TEAMS_COUNT];
    for (uint32 i = 0; i < PVP_TEAMS_COUNT; i++)
    {
        itr_team[i] = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].begin();
        for (; itr_team[i] != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].end(); ++(itr_team[i]))
        {
            if (!(*(itr_team[i]))->IsInvitedToBGInstanceGUID)
            {
                m_SelectionPools[i].AddGroup(*(itr_team[i]), maxPlayers);
                if (m_SelectionPools[i].GetPlayerCount() >= minPlayers)
                    break;
            }
        }
    }

    //try to invite same number of players - this cycle may cause longer wait time even if there are enough players in queue, but we want ballanced bg
    uint32 j = TEAM_ALLIANCE;
    if (m_SelectionPools[TEAM_HORDE].GetPlayerCount() < m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount())
        j = TEAM_HORDE;

    if (sWorld->getIntConfig(CONFIG_BATTLEGROUND_INVITATION_TYPE) != BG_QUEUE_INVITATION_TYPE_NO_BALANCE
        && m_SelectionPools[TEAM_HORDE].GetPlayerCount() >= minPlayers && m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() >= minPlayers)
    {
        //we will try to invite more groups to team with less players indexed by j
        ++(itr_team[j]);                                         //this will not cause a crash, because for cycle above reached break;
        for (; itr_team[j] != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + j].end(); ++(itr_team[j]))
        {
            if (!(*(itr_team[j]))->IsInvitedToBGInstanceGUID)
                if (!m_SelectionPools[j].AddGroup(*(itr_team[j]), m_SelectionPools[(j + 1) % PVP_TEAMS_COUNT].GetPlayerCount()))
                    break;
        }

        // do not allow to start bg with more than 2 players more on 1 faction
        if (std::abs((int32)(m_SelectionPools[TEAM_HORDE].GetPlayerCount() - m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount())) > 2)
            return false;
    }

    return CanStartMatch();
}

// this method will check if we can invite players to same faction skirmish match
bool BattlegroundQueue::CheckSkirmishForSameFaction(BattlegroundBracketId bracket_id, uint32 minPlayersPerTeam)
{
    if (m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() < minPlayersPerTeam && m_SelectionPools[TEAM_HORDE].GetPlayerCount() < minPlayersPerTeam)
        return false;

    TeamId teamIndex = TEAM_ALLIANCE;
    TeamId otherTeam = TEAM_HORDE;

    if (m_SelectionPools[TEAM_HORDE].GetPlayerCount() == minPlayersPerTeam)
    {
        teamIndex = TEAM_HORDE;
        otherTeam = TEAM_ALLIANCE;
    }

    //clear other team's selection
    m_SelectionPools[otherTeam].Init();

    //store last ginfo pointer
    GroupQueueInfo* ginfo = m_SelectionPools[teamIndex].SelectedGroups.back();

    //set itr_team to group that was added to selection pool latest
    GroupsQueueType::iterator itr_team = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + static_cast<uint8>(teamIndex)].begin();
    for (; itr_team != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + static_cast<uint8>(teamIndex)].end(); ++itr_team)
        if (ginfo == *itr_team)
            break;

    if (itr_team == m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + static_cast<uint8>(teamIndex)].end())
        return false;

    GroupsQueueType::iterator itr_team2 = itr_team;
    ++itr_team2;

    //invite players to other selection pool
    for (; itr_team2 != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + static_cast<uint8>(teamIndex)].end(); ++itr_team2)
    {
        //if selection pool is full then break;
        if (!(*itr_team2)->IsInvitedToBGInstanceGUID && !m_SelectionPools[otherTeam].AddGroup(*itr_team2, minPlayersPerTeam))
            break;
    }

    if (m_SelectionPools[otherTeam].GetPlayerCount() != minPlayersPerTeam)
        return false;

    //here we have correct 2 selections and we need to change one teams team and move selection pool teams to other team's queue
    for (GroupsQueueType::iterator itr = m_SelectionPools[otherTeam].SelectedGroups.begin(); itr != m_SelectionPools[otherTeam].SelectedGroups.end(); ++itr)
    {
        //set correct team
        (*itr)->teamId = otherTeam;
        (*itr)->GroupType = static_cast<uint8>(BG_QUEUE_NORMAL_ALLIANCE) + static_cast<uint8>(otherTeam);

        //add team to other queue
        m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + static_cast<uint8>(otherTeam)].push_front(*itr);

        //remove team from old queue
        GroupsQueueType::iterator itr2 = itr_team;
        ++itr2;

        for (; itr2 != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + static_cast<uint8>(teamIndex)].end(); ++itr2)
        {
            if (*itr2 == *itr)
            {
                m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + static_cast<uint8>(teamIndex)].erase(itr2);
                break;
            }
        }
    }

    return true;
}

void BattlegroundQueue::UpdateEvents(uint32 diff)
{
    m_events.Update(diff);
}

void BattlegroundQueue::BattlegroundQueueUpdate(uint32 diff, BattlegroundTypeId bgTypeId, BattlegroundBracketId bracket_id, uint8 arenaType, bool isRated, uint32 arenaRating)
{
    // if no players in queue - do nothing
    if (IsAllQueuesEmpty(bracket_id))
        return;

    auto InviteAllGroupsToBg = [this](Battleground* bg)
    {
        // invite those selection pools
        for (uint32 i = 0; i < PVP_TEAMS_COUNT; i++)
        {
            for (auto const& citr : m_SelectionPools[TEAM_ALLIANCE + i].SelectedGroups)
            {
                InviteGroupToBG(citr, bg, citr->teamId);
            }
        }
    };

    // battleground with free slot for player should be always in the beggining of the queue
    // maybe it would be better to create bgfreeslotqueue for each bracket_id
    BGFreeSlotQueueContainer& bgQueues = sBattlegroundMgr->GetBGFreeSlotQueueStore(bgTypeId);
    for (BGFreeSlotQueueContainer::iterator itr = bgQueues.begin(); itr != bgQueues.end();)
    {
        Battleground* bg = *itr; ++itr;
        // DO NOT allow queue manager to invite new player to rated games
        if (!bg->isRated() && bg->GetBgTypeID() == bgTypeId && bg->GetBracketId() == bracket_id &&
            bg->GetStatus() > STATUS_WAIT_QUEUE && bg->GetStatus() < STATUS_WAIT_LEAVE)
        {
            // clear selection pools
            m_SelectionPools[TEAM_ALLIANCE].Init();
            m_SelectionPools[TEAM_HORDE].Init();

            // call a function that does the job for us
            FillPlayersToBG(bg, bracket_id);

            // now everything is set, invite players
            InviteAllGroupsToBg(bg);

            if (!bg->HasFreeSlots())
                bg->RemoveFromBGFreeSlotQueue();
        }
    }

    Battleground* bg_template = sBattlegroundMgr->GetBattlegroundTemplate(bgTypeId);
    if (!bg_template)
    {
        LOG_ERROR("bg.battleground", "Battleground: Update: bg template not found for {}", bgTypeId);
        return;
    }

    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketById(bg_template->GetMapId(), bracket_id);
    if (!bracketEntry)
    {
        LOG_ERROR("bg.battleground", "Battleground: Update: bg bracket entry not found for map {} bracket id {}", bg_template->GetMapId(), bracket_id);
        return;
    }

    // get min and max players per team
    uint32 MinPlayersPerTeam = bg_template->GetMinPlayersPerTeam();
    uint32 MaxPlayersPerTeam = bg_template->GetMaxPlayersPerTeam();

    if (bg_template->isArena())
    {
        MinPlayersPerTeam = sBattlegroundMgr->isArenaTesting() ? 1 : arenaType;
        MaxPlayersPerTeam = arenaType;
    }
    else if (sBattlegroundMgr->isTesting())
        MinPlayersPerTeam = 1;

    sScriptMgr->OnQueueUpdate(this, diff, bgTypeId, bracket_id, arenaType, isRated, arenaRating);

    m_SelectionPools[TEAM_ALLIANCE].Init();
    m_SelectionPools[TEAM_HORDE].Init();

    // check if can start new premade battleground
    if (bg_template->isBattleground() && bgTypeId != BATTLEGROUND_RB && CheckPremadeMatch(bracket_id, MinPlayersPerTeam, MaxPlayersPerTeam))
    {
        // create new battleground
        Battleground* bg = sBattlegroundMgr->CreateNewBattleground(bgTypeId, bracketEntry, 0, false);
        if (!bg)
        {
            LOG_ERROR("bg.battleground", "BattlegroundQueue::Update - Cannot create battleground: {}", bgTypeId);
            return;
        }

        // invite those selection pools
        InviteAllGroupsToBg(bg);

        bg->StartBattleground();

        // clear structures
        m_SelectionPools[TEAM_ALLIANCE].Init();
        m_SelectionPools[TEAM_HORDE].Init();
    }

    // check if can start new normal battleground or non-rated arena
    if (!isRated)
    {
        if (CheckNormalMatch(bg_template, bracket_id, MinPlayersPerTeam, MaxPlayersPerTeam) ||
            (bg_template->isArena() && CheckSkirmishForSameFaction(bracket_id, MinPlayersPerTeam)))
        {
            // create new battleground
            Battleground* bg = sBattlegroundMgr->CreateNewBattleground(bgTypeId, bracketEntry, arenaType, false);
            if (!bg)
            {
                LOG_ERROR("bg.battleground", "BattlegroundQueue::Update - Cannot create battleground: {}", bgTypeId);
                return;
            }

            // invite players
            InviteAllGroupsToBg(bg);

            bg->StartBattleground();
        }
    }
    // check if can start new rated arenas (can create many in single queue update)
    else if (bg_template->isArena())
    {
        // found out the minimum and maximum ratings the newly added team should battle against
        // arenaRating is the rating of the latest joined team, or 0
        // 0 is on (automatic update call) and we must set it to team's with longest wait time
        if (!arenaRating)
        {
            GroupQueueInfo* front1 = nullptr;
            GroupQueueInfo* front2 = nullptr;

            if (!m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].empty())
            {
                front1 = m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].front();
                arenaRating = front1->ArenaMatchmakerRating;
            }

            if (!m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].empty())
            {
                front2 = m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].front();
                arenaRating = front2->ArenaMatchmakerRating;
            }

            if (front1 && front2)
            {
                if (front1->JoinTime < front2->JoinTime)
                    arenaRating = front1->ArenaMatchmakerRating;
            }
            else if (!front1 && !front2)
                return; // queues are empty
        }

        //set rating range
        uint32 arenaMinRating = (arenaRating <= sBattlegroundMgr->GetMaxRatingDifference()) ? 0 : arenaRating - sBattlegroundMgr->GetMaxRatingDifference();
        uint32 arenaMaxRating = arenaRating + sBattlegroundMgr->GetMaxRatingDifference();

        // if max rating difference is set and the time past since server startup is greater than the rating discard time
        // (after what time the ratings aren't taken into account when making teams) then
        // the discard time is current_time - time_to_discard, teams that joined after that, will have their ratings taken into account
        // else leave the discard time on 0, this way all ratings will be discarded
        // this has to be signed value - when the server starts, this value would be negative and thus overflow
        int32 discardTime = GameTime::GetGameTimeMS().count() - sBattlegroundMgr->GetRatingDiscardTimer();

        // timer for previous opponents
        int32 discardOpponentsTime = GameTime::GetGameTimeMS().count() - sWorld->getIntConfig(CONFIG_ARENA_PREV_OPPONENTS_DISCARD_TIMER);

        // we need to find 2 teams which will play next game
        GroupsQueueType::iterator itr_teams[PVP_TEAMS_COUNT];
        uint8 found = 0;
        uint8 team = 0;

        for (uint8 i = BG_QUEUE_PREMADE_ALLIANCE; i < BG_QUEUE_NORMAL_ALLIANCE; i++)
        {
            // take the group that joined first
            GroupsQueueType::iterator itr2 = m_QueuedGroups[bracket_id][i].begin();
            for (; itr2 != m_QueuedGroups[bracket_id][i].end(); ++itr2)
            {
                // if group match conditions, then add it to pool
                if (!(*itr2)->IsInvitedToBGInstanceGUID
                    && (((*itr2)->ArenaMatchmakerRating >= arenaMinRating && (*itr2)->ArenaMatchmakerRating <= arenaMaxRating)
                        || (int32)(*itr2)->JoinTime < discardTime))
                {
                    itr_teams[found++] = itr2;
                    team = i;
                    break;
                }
            }
        }

        if (!found)
            return;

        if (found == 1)
        {
            for (GroupsQueueType::iterator itr3 = itr_teams[0]; itr3 != m_QueuedGroups[bracket_id][team].end(); ++itr3)
            {
                if (!(*itr3)->IsInvitedToBGInstanceGUID
                    && (((*itr3)->ArenaMatchmakerRating >= arenaMinRating && (*itr3)->ArenaMatchmakerRating <= arenaMaxRating) || (int32)(*itr3)->JoinTime < discardTime)
                    && ((*(itr_teams[0]))->ArenaTeamId != (*itr3)->PreviousOpponentsTeamId || ((int32)(*itr3)->JoinTime < discardOpponentsTime))
                    && (*(itr_teams[0]))->ArenaTeamId != (*itr3)->ArenaTeamId)
                {
                    itr_teams[found++] = itr3;
                    break;
                }
            }
        }

        //if we have 2 teams, then start new arena and invite players!
        if (found == 2)
        {
            GroupQueueInfo* aTeam = *(itr_teams[TEAM_ALLIANCE]);
            GroupQueueInfo* hTeam = *(itr_teams[TEAM_HORDE]);

            Battleground* arena = sBattlegroundMgr->CreateNewBattleground(bgTypeId, bracketEntry, arenaType, true);
            if (!arena)
            {
                LOG_ERROR("bg.battleground", "BattlegroundQueue::Update couldn't create arena instance for rated arena match!");
                return;
            }

            aTeam->OpponentsTeamRating = hTeam->ArenaTeamRating;
            hTeam->OpponentsTeamRating = aTeam->ArenaTeamRating;
            aTeam->OpponentsMatchmakerRating = hTeam->ArenaMatchmakerRating;
            hTeam->OpponentsMatchmakerRating = aTeam->ArenaMatchmakerRating;

            LOG_DEBUG("bg.battleground", "setting oposite teamrating for team {} to {}", aTeam->ArenaTeamId, aTeam->OpponentsTeamRating);
            LOG_DEBUG("bg.battleground", "setting oposite teamrating for team {} to {}", hTeam->ArenaTeamId, hTeam->OpponentsTeamRating);

            // now we must move team if we changed its faction to another faction queue, because then we will spam log by errors in Queue::RemovePlayer
            if (aTeam->teamId != TEAM_ALLIANCE)
            {
                aTeam->GroupType = BG_QUEUE_PREMADE_ALLIANCE;
                m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].push_front(aTeam);
                m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].erase(itr_teams[TEAM_ALLIANCE]);
            }

            if (hTeam->teamId != TEAM_HORDE)
            {
                hTeam->GroupType = BG_QUEUE_PREMADE_HORDE;
                m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].push_front(hTeam);
                m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].erase(itr_teams[TEAM_HORDE]);
            }

            arena->SetArenaMatchmakerRating(TEAM_ALLIANCE, aTeam->ArenaMatchmakerRating);
            arena->SetArenaMatchmakerRating(TEAM_HORDE, hTeam->ArenaMatchmakerRating);
            InviteGroupToBG(aTeam, arena, TEAM_ALLIANCE);
            InviteGroupToBG(hTeam, arena, TEAM_HORDE);

            LOG_DEBUG("bg.battleground", "Starting rated arena match!");
            arena->StartBattleground();
        }
    }
}

void BattlegroundQueue::BattlegroundQueueAnnouncerUpdate(uint32 diff, BattlegroundQueueTypeId bgQueueTypeId, BattlegroundBracketId bracket_id)
{
    BattlegroundTypeId bgTypeId = BattlegroundMgr::BGTemplateId(bgQueueTypeId);
    Battleground* bg_template = sBattlegroundMgr->GetBattlegroundTemplate(bgTypeId);
    if (!bg_template)
    {
        return;
    }

    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketById(bg_template->GetMapId(), bracket_id);
    if (!bracketEntry)
    {
        return;
    }

    if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_TIMED))
    {
        uint32 qPlayers = 0;

        if (_queueAnnouncementCrossfactioned)
        {
            qPlayers = GetPlayersCountInGroupsQueue(bracket_id, BG_QUEUE_CFBG);
        }
        else
        {
            qPlayers = GetPlayersCountInGroupsQueue(bracket_id, BG_QUEUE_NORMAL_HORDE) + GetPlayersCountInGroupsQueue(bracket_id, BG_QUEUE_NORMAL_ALLIANCE);
        }

        if (!qPlayers)
        {
            _queueAnnouncementTimer[bracket_id] = -1;
            return;
        }

        if (_queueAnnouncementTimer[bracket_id] >= 0)
        {
            if (_queueAnnouncementTimer[bracket_id] <= static_cast<int32>(diff))
            {
                _queueAnnouncementTimer[bracket_id] = -1;

                auto bgName = bg_template->GetName();
                uint32 MaxPlayers = bg_template->GetMinPlayersPerTeam() * 2;
                uint32 q_min_level = std::min(bracketEntry->minLevel, (uint32) 80);
                uint32 q_max_level = std::min(bracketEntry->maxLevel, (uint32) 80);

                sWorld->SendWorldTextOptional(LANG_BG_QUEUE_ANNOUNCE_WORLD, ANNOUNCER_FLAG_DISABLE_BG_QUEUE, bgName.c_str(), q_min_level, q_max_level, qPlayers, MaxPlayers);
            }
            else
            {
                _queueAnnouncementTimer[bracket_id] -= static_cast<int32>(diff);
            }
        }
    }
}

uint32 BattlegroundQueue::GetPlayersCountInGroupsQueue(BattlegroundBracketId bracketId, BattlegroundQueueGroupTypes bgqueue)
{
    uint32 playersCount = 0;

    for (auto const& itr : m_QueuedGroups[bracketId][bgqueue])
        if (!itr->IsInvitedToBGInstanceGUID)
            playersCount += static_cast<uint32>(itr->Players.size());

    return playersCount;
}

bool BattlegroundQueue::IsAllQueuesEmpty(BattlegroundBracketId bracket_id)
{
    uint8 queueEmptyCount = 0;

    for (uint8 i = 0; i < BG_QUEUE_MAX; i++)
        if (m_QueuedGroups[bracket_id][i].empty())
            queueEmptyCount++;

    return queueEmptyCount == BG_QUEUE_MAX;
}

void BattlegroundQueue::SendMessageBGQueue(Player* leader, Battleground* bg, PvPDifficultyEntry const* bracketEntry)
{
    if (!sScriptMgr->CanSendMessageBGQueue(this, leader, bg, bracketEntry))
    {
        return;
    }

    if (bg->isArena())
    {
        // Skip announce for arena skirmish
        return;
    }

    BattlegroundBracketId bracketId = bracketEntry->GetBracketId();
    auto bgName = bg->GetName();
    uint32 MinPlayers = bg->GetMinPlayersPerTeam();
    uint32 MaxPlayers = MinPlayers * 2;
    uint32 q_min_level = std::min(bracketEntry->minLevel, (uint32)80);
    uint32 q_max_level = std::min(bracketEntry->maxLevel, (uint32)80);
    uint32 qHorde = GetPlayersCountInGroupsQueue(bracketId, BG_QUEUE_NORMAL_HORDE);
    uint32 qAlliance = GetPlayersCountInGroupsQueue(bracketId, BG_QUEUE_NORMAL_ALLIANCE);
    auto qTotal = qHorde + qAlliance;

    LOG_DEBUG("bg.battleground", "> Queue status for {} (Lvl: {} to {}) Queued: {} (Need at least {} more)",
        bgName, q_min_level, q_max_level, qAlliance + qHorde, MaxPlayers - qTotal);

    // Show queue status to player only (when joining battleground queue or Arena and arena world announcer is disabled)
    if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_PLAYERONLY))
    {
        ChatHandler(leader->GetSession()).PSendSysMessage(LANG_BG_QUEUE_ANNOUNCE_SELF, bgName, q_min_level, q_max_level,
            qAlliance, (MinPlayers > qAlliance) ? MinPlayers - qAlliance : (uint32)0,
            qHorde, (MinPlayers > qHorde) ? MinPlayers - qHorde : (uint32)0);
    }
    else // Show queue status to server (when joining battleground queue)
    {
        if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_TIMED))
        {
            if (_queueAnnouncementTimer[bracketId] < 0)
            {
                _queueAnnouncementTimer[bracketId] = sWorld->getIntConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_TIMER);
            }
        }
        else
        {
            if (!sBGSpam->CanAnnounce(leader, bg, q_min_level, qTotal))
            {
                return;
            }

            sWorld->SendWorldTextOptional(LANG_BG_QUEUE_ANNOUNCE_WORLD, ANNOUNCER_FLAG_DISABLE_BG_QUEUE, bgName.c_str(), q_min_level, q_max_level, qAlliance + qHorde, MaxPlayers);
        }
    }
}

void BattlegroundQueue::SendJoinMessageArenaQueue(Player* leader, GroupQueueInfo* ginfo, PvPDifficultyEntry const* bracketEntry, bool isRated)
{
    if (!sWorld->getBoolConfig(CONFIG_ARENA_QUEUE_ANNOUNCER_ENABLE))
        return;

    if (!sScriptMgr->OnBeforeSendJoinMessageArenaQueue(this, leader, ginfo, bracketEntry, isRated))
        return;

    if (!isRated)
    {
        Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(ginfo->BgTypeId);
        if (!bg)
        {
            LOG_ERROR("bg.arena", "> Not found bg template for bgtype id {}", uint32(ginfo->BgTypeId));
            return;
        }

        if (!bg->isArena())
        {
            // Skip announce for non arena
            return;
        }

        BattlegroundBracketId bracketId = bracketEntry->GetBracketId();
        auto bgName = bg->GetName();
        auto arenatype = Acore::StringFormat("%uv%u", ginfo->ArenaType, ginfo->ArenaType);
        uint32 playersNeed = ArenaTeam::GetReqPlayersForType(ginfo->ArenaType);
        uint32 q_min_level = std::min(bracketEntry->minLevel, (uint32)80);
        uint32 q_max_level = std::min(bracketEntry->maxLevel, (uint32)80);
        uint32 qPlayers = GetPlayersCountInGroupsQueue(bracketId, BG_QUEUE_NORMAL_HORDE) + GetPlayersCountInGroupsQueue(bracketId, BG_QUEUE_NORMAL_ALLIANCE);

        LOG_DEBUG("bg.arena", "> Queue status for {} (skirmish {}) (Lvl: {} to {}) Queued: {} (Need at least {} more)",
            bgName, arenatype, q_min_level, q_max_level, qPlayers, playersNeed - qPlayers);

        if (sWorld->getBoolConfig(CONFIG_ARENA_QUEUE_ANNOUNCER_PLAYERONLY))
        {
            ChatHandler(leader->GetSession()).PSendSysMessage(LANG_ARENA_QUEUE_ANNOUNCE_SELF,
                bgName, arenatype, q_min_level, q_max_level, qPlayers, playersNeed - qPlayers);
        }
        else
        {
            if (!sBGSpam->CanAnnounce(leader, bg, q_min_level, qPlayers))
            {
                return;
            }

            sWorld->SendWorldTextOptional(LANG_ARENA_QUEUE_ANNOUNCE_WORLD, ANNOUNCER_FLAG_DISABLE_ARENA_QUEUE, bgName.c_str(), arenatype.c_str(), q_min_level, q_max_level, qPlayers, playersNeed);
        }
    }
    else
    {
        ArenaTeam* team = sArenaTeamMgr->GetArenaTeamById(ginfo->ArenaTeamId);
        if (!team || !ginfo->IsRated)
        {
            return;
        }

        uint8 ArenaType = ginfo->ArenaType;
        uint32 ArenaTeamRating = ginfo->ArenaTeamRating;
        std::string TeamName = team->GetName();

        uint32 announcementDetail = sWorld->getIntConfig(CONFIG_ARENA_QUEUE_ANNOUNCER_DETAIL);
        switch (announcementDetail)
        {
        case 3:
            sWorld->SendWorldTextOptional(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_JOIN_NAME_RATING, ANNOUNCER_FLAG_DISABLE_ARENA_QUEUE, TeamName.c_str(), ArenaType, ArenaType, ArenaTeamRating);
            break;
        case 2:
            sWorld->SendWorldTextOptional(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_JOIN_NAME, ANNOUNCER_FLAG_DISABLE_ARENA_QUEUE, TeamName.c_str(), ArenaType, ArenaType);
            break;
        case 1:
            sWorld->SendWorldTextOptional(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_JOIN_RATING, ANNOUNCER_FLAG_DISABLE_ARENA_QUEUE, ArenaType, ArenaType, ArenaTeamRating);
            break;
        default:
            sWorld->SendWorldTextOptional(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_JOIN, ANNOUNCER_FLAG_DISABLE_ARENA_QUEUE, ArenaType, ArenaType);
            break;
        }
    }
}

void BattlegroundQueue::SendExitMessageArenaQueue(GroupQueueInfo* ginfo)
{
    if (!sWorld->getBoolConfig(CONFIG_ARENA_QUEUE_ANNOUNCER_ENABLE))
        return;

    if (!sScriptMgr->OnBeforeSendExitMessageArenaQueue(this, ginfo))
        return;

    ArenaTeam* team = sArenaTeamMgr->GetArenaTeamById(ginfo->ArenaTeamId);
    if (!team)
        return;

    if (!ginfo->IsRated)
        return;

    uint8 ArenaType = ginfo->ArenaType;
    uint32 ArenaTeamRating = ginfo->ArenaTeamRating;
    std::string TeamName = team->GetName();

    if (ArenaType && ginfo->Players.empty())
    {
        uint32 announcementDetail = sWorld->getIntConfig(CONFIG_ARENA_QUEUE_ANNOUNCER_DETAIL);
        switch (announcementDetail)
        {
        case 3:
            sWorld->SendWorldTextOptional(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_EXIT_NAME_RATING, ANNOUNCER_FLAG_DISABLE_ARENA_QUEUE, TeamName.c_str(), ArenaType, ArenaType, ArenaTeamRating);
            break;
        case 2:
            sWorld->SendWorldTextOptional(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_EXIT_NAME, ANNOUNCER_FLAG_DISABLE_ARENA_QUEUE, TeamName.c_str(), ArenaType, ArenaType);
            break;
        case 1:
            sWorld->SendWorldTextOptional(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_EXIT_RATING, ANNOUNCER_FLAG_DISABLE_ARENA_QUEUE, ArenaType, ArenaType, ArenaTeamRating);
            break;
        default:
            sWorld->SendWorldTextOptional(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_EXIT, ANNOUNCER_FLAG_DISABLE_ARENA_QUEUE, ArenaType, ArenaType);
            break;
        }
    }
}

void BattlegroundQueue::SetQueueAnnouncementTimer(uint32 bracketId, int32 timer, bool isCrossFactionBG /*= true*/)
{
    _queueAnnouncementTimer[bracketId] = timer;
    _queueAnnouncementCrossfactioned = isCrossFactionBG;
}

int32 BattlegroundQueue::GetQueueAnnouncementTimer(uint32 bracketId) const
{
    return _queueAnnouncementTimer[bracketId];
}

void BattlegroundQueue::InviteGroupToBG(GroupQueueInfo* ginfo, Battleground* bg, TeamId teamId)
{
    // set side if needed
    if (teamId != TEAM_NEUTRAL)
        ginfo->teamId = teamId;

    if (ginfo->IsInvitedToBGInstanceGUID)
        return;

    // set invitation
    ginfo->IsInvitedToBGInstanceGUID = bg->GetInstanceID();

    BattlegroundTypeId bgTypeId = bg->GetBgTypeID();
    BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(ginfo->BgTypeId, ginfo->ArenaType);
    BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);

    // set ArenaTeamId for rated matches
    if (bg->isArena() && bg->isRated())
        bg->SetArenaTeamIdForTeam(ginfo->teamId, ginfo->ArenaTeamId);

    ginfo->RemoveInviteTime = GameTime::GetGameTimeMS().count() + INVITE_ACCEPT_WAIT_TIME;

    // loop through the players
    for (auto const& itr : ginfo->Players)
    {
        //npcbot: invite bots
        if (itr.IsCreature())
        {
            PlayerInvitedToBGUpdateAverageWaitTime(ginfo);
            BotMgr::InviteBotToBG(itr, ginfo, bg);
            continue;
        }
        //end npcbot

        // get the player
        Player* player = ObjectAccessor::FindConnectedPlayer(itr);
        if (!player)
            continue;

        // update average wait time
        bgQueue.PlayerInvitedToBGUpdateAverageWaitTime(ginfo);

        // increase invited counter for each invited player
        bg->IncreaseInvitedCount(ginfo->teamId);

        player->SetInviteForBattlegroundQueueType(bgQueueTypeId, ginfo->IsInvitedToBGInstanceGUID);

        // create remind invite events
        BGQueueInviteEvent* inviteEvent = new BGQueueInviteEvent(player->GetGUID(), ginfo->IsInvitedToBGInstanceGUID, bgTypeId, ginfo->ArenaType, ginfo->RemoveInviteTime);
        bgQueue.AddEvent(inviteEvent, INVITATION_REMIND_TIME);

        // create automatic remove events
        BGQueueRemoveEvent* removeEvent = new BGQueueRemoveEvent(player->GetGUID(), ginfo->IsInvitedToBGInstanceGUID, bgTypeId, bgQueueTypeId, ginfo->RemoveInviteTime);
        bgQueue.AddEvent(removeEvent, INVITE_ACCEPT_WAIT_TIME);

        // Check queueSlot
        uint32 queueSlot = player->GetBattlegroundQueueIndex(bgQueueTypeId);
        ASSERT(queueSlot < PLAYER_MAX_BATTLEGROUND_QUEUES);

        LOG_DEBUG("bg.battleground", "Battleground: invited player {} {} to BG instance {} queueindex {} bgtype {}",
            player->GetName(), player->GetGUID().ToString(), bg->GetInstanceID(), queueSlot, bgTypeId);

        // send status packet
        WorldPacket data;
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_JOIN, INVITE_ACCEPT_WAIT_TIME, 0, ginfo->ArenaType, TEAM_NEUTRAL, bg->isRated());
        player->GetSession()->SendPacket(&data);

        // pussywizard:
        if (bg->isArena() && bg->isRated())
            bg->ArenaLogEntries[player->GetGUID()].Fill(player->GetName(), player->GetGUID().GetCounter(), player->GetSession()->GetAccountId(), ginfo->ArenaTeamId, player->GetSession()->GetRemoteAddress());
    }
}

/*********************************************************/
/***            BATTLEGROUND QUEUE EVENTS              ***/
/*********************************************************/

bool BGQueueInviteEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    Player* player = ObjectAccessor::FindConnectedPlayer(m_PlayerGuid);

    // player logged off, so he is no longer in queue
    if (!player)
        return true;

    Battleground* bg = sBattlegroundMgr->GetBattleground(m_BgInstanceGUID, m_BgTypeId);

    // if battleground ended, do nothing
    if (!bg)
        return true;

    // check if still in queue for this battleground
    BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(m_BgTypeId, m_ArenaType);
    uint32 queueSlot = player->GetBattlegroundQueueIndex(bgQueueTypeId);
    if (queueSlot < PLAYER_MAX_BATTLEGROUND_QUEUES)
    {
        // confirm the player is invited to this instance id (he didn't requeue in the meanwhile)
        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
        if (bgQueue.IsPlayerInvited(m_PlayerGuid, m_BgInstanceGUID, m_RemoveTime))
        {
            // send remaining time in queue
            WorldPacket data;
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_JOIN, INVITE_ACCEPT_WAIT_TIME - INVITATION_REMIND_TIME, 0, m_ArenaType, TEAM_NEUTRAL, bg->isRated(), m_BgTypeId);
            player->GetSession()->SendPacket(&data);
        }
    }

    return true;
}

void BGQueueInviteEvent::Abort(uint64 /*e_time*/)
{
    //do nothing
}

bool BGQueueRemoveEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    Player* player = ObjectAccessor::FindConnectedPlayer(m_PlayerGuid);

    // player logged off, so he is no longer in queue
    if (!player)
        return true;

    Battleground* bg = sBattlegroundMgr->GetBattleground(m_BgInstanceGUID, m_BgTypeId);

    // battleground can be already deleted, bg may be nullptr!

    // check if still in queue for this battleground
    uint32 queueSlot = player->GetBattlegroundQueueIndex(m_BgQueueTypeId);
    if (queueSlot < PLAYER_MAX_BATTLEGROUND_QUEUES) // player is in queue
    {
        // confirm the player is invited to this instance id (he didn't requeue in the meanwhile)
        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(m_BgQueueTypeId);
        if (bgQueue.IsPlayerInvited(m_PlayerGuid, m_BgInstanceGUID, m_RemoveTime))
        {
            // track if player leaves the BG by not clicking enter button
            if (bg && bg->isBattleground() && (bg->GetStatus() == STATUS_IN_PROGRESS || bg->GetStatus() == STATUS_WAIT_JOIN))
            {
                if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_TRACK_DESERTERS))
                {
                    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_DESERTER_TRACK);
                    stmt->SetData(0, player->GetGUID().GetCounter());
                    stmt->SetData(1, BG_DESERTION_TYPE_NO_ENTER_BUTTON);
                    CharacterDatabase.Execute(stmt);
                }

                sScriptMgr->OnBattlegroundDesertion(player, BG_DESERTION_TYPE_NO_ENTER_BUTTON);
            }

            LOG_DEBUG("bg.battleground", "Battleground: removing player {} from bg queue for instance {} because of not pressing enter battle in time.", player->GetGUID().ToString(), m_BgInstanceGUID);

            player->RemoveBattlegroundQueueId(m_BgQueueTypeId);
            bgQueue.RemovePlayer(m_PlayerGuid, true);

            //update queues if battleground isn't ended
            if (bg && bg->isBattleground() && bg->GetStatus() != STATUS_WAIT_LEAVE)
                sBattlegroundMgr->ScheduleQueueUpdate(0, 0, m_BgQueueTypeId, m_BgTypeId, bg->GetBracketId());

            WorldPacket data;
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_NONE, 0, 0, 0, TEAM_NEUTRAL);
            player->SendDirectMessage(&data);
        }
    }

    return true;
}

void BGQueueRemoveEvent::Abort(uint64 /*e_time*/)
{
    //do nothing
}
