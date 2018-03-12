/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "BattlegroundMgr.h"
#include "BattlegroundQueue.h"
#include "Chat.h"
#include "Group.h"
#include "Log.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ChannelMgr.h"
#include "Channel.h"

/*********************************************************/
/***            BATTLEGROUND QUEUE SYSTEM              ***/
/*********************************************************/

BattlegroundQueue::BattlegroundQueue() : m_bgTypeId(BATTLEGROUND_TYPE_NONE), m_arenaType(ArenaType(0))
{
    for (uint32 i = 0; i < BG_TEAMS_COUNT; ++i)
    {
        for (uint32 j = 0; j < MAX_BATTLEGROUND_BRACKETS; ++j)
        {
            m_WaitTimeLastIndex[i][j] = 0;
            for (uint32 k = 0; k < COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME; ++k)
                m_WaitTimes[i][j][k] = 0;
        }
    }
}

BattlegroundQueue::~BattlegroundQueue()
{
    m_events.KillAllEvents(false);

    m_QueuedPlayers.clear();
    for (int i = 0; i < MAX_BATTLEGROUND_BRACKETS; ++i)
    {
        for (uint32 j = 0; j < BG_QUEUE_GROUP_TYPES_COUNT; ++j)
        {
            for (GroupsQueueType::iterator itr = m_QueuedGroups[i][j].begin(); itr!= m_QueuedGroups[i][j].end(); ++itr)
                delete (*itr);
            m_QueuedGroups[i][j].clear();
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
    GroupsQueueType::iterator groupToKick = SelectedGroups.begin();
    for (GroupsQueueType::iterator itr = groupToKick; itr != SelectedGroups.end(); ++itr)
    {
        // if proper size - overwrite to kick last one
        if (abs(int32((*itr)->Players.size()) - (int32)size) <= 1)
        {
            groupToKick = itr;
            foundProper = true;
        }
        else if (!foundProper && (*itr)->Players.size() >= (*groupToKick)->Players.size())
            groupToKick = itr;
    }

    // remove selected from pool
    GroupQueueInfo* ginfo = (*groupToKick);
    SelectedGroups.erase(groupToKick);
    PlayerCount -= ginfo->Players.size();

    if (foundProper)
        return false;

    return (ginfo->Players.size() > size);
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
    if (PlayerCount < desiredCount)
        return true;
    return false;
}

/*********************************************************/
/***               BATTLEGROUND QUEUES                 ***/
/*********************************************************/

// add group or player (grp == NULL) to bg queue with the given leader and bg specifications
GroupQueueInfo* BattlegroundQueue::AddGroup(Player* leader, Group* grp, PvPDifficultyEntry const*  bracketEntry, bool isRated, bool isPremade, uint32 ArenaRating, uint32 MatchmakerRating, uint32 arenateamid)
{
    BattlegroundBracketId bracketId = bracketEntry->GetBracketId();

    // create new ginfo
    GroupQueueInfo* ginfo            = new GroupQueueInfo;
    ginfo->BgTypeId                  = m_bgTypeId;
    ginfo->ArenaType                 = m_arenaType;
    ginfo->ArenaTeamId               = arenateamid;
    ginfo->IsRated                   = isRated;
    ginfo->IsInvitedToBGInstanceGUID = 0;
    ginfo->JoinTime                  = World::GetGameTimeMS();
    ginfo->RemoveInviteTime          = 0;
    ginfo->teamId                    = leader->GetTeamId();
    ginfo->ArenaTeamRating           = ArenaRating;
    ginfo->ArenaMatchmakerRating     = MatchmakerRating;
    ginfo->OpponentsTeamRating       = 0;
    ginfo->OpponentsMatchmakerRating = 0;

    ginfo->Players.clear();

    //compute index (if group is premade or joined a rated match) to queues
    uint32 index = 0;
    if (!isRated && !isPremade)
        index += BG_TEAMS_COUNT;
    if (ginfo->teamId == TEAM_HORDE)
        index++;

    // pussywizard: store indices at which GroupQueueInfo is in m_QueuedGroups
    ginfo->_bracketId = bracketId;
    ginfo->_groupType = index;

    // announce world (this doesn't need mutex)
    if (isRated && sWorld->getBoolConfig(CONFIG_ARENA_QUEUE_ANNOUNCER_ENABLE))
    {
        ArenaTeam* team = sArenaTeamMgr->GetArenaTeamById(arenateamid);
        if (team)
            sWorld->SendWorldText(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_JOIN, team->GetName().c_str(), ginfo->ArenaType, ginfo->ArenaType, ginfo->ArenaTeamRating);
    }

    //add players from group to ginfo
    if (grp)
    {
        for (GroupReference* itr = grp->GetFirstMember(); itr != NULL; itr = itr->next())
        {
            Player* member = itr->GetSource();
            if (!member)
                continue;

            ASSERT(m_QueuedPlayers.count(member->GetGUID()) == 0);
            m_QueuedPlayers[member->GetGUID()] = ginfo;
            ginfo->Players.insert(member->GetGUID());
        }
    }
    else
    {
        ASSERT(m_QueuedPlayers.count(leader->GetGUID()) == 0);
        m_QueuedPlayers[leader->GetGUID()] = ginfo;
        ginfo->Players.insert(leader->GetGUID());
    }

    //add GroupInfo to m_QueuedGroups
    m_QueuedGroups[bracketId][index].push_back(ginfo);

    //announce current queue status
    if (!isRated && !isPremade && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_ENABLE))
        if (Battleground* bgt = sBattlegroundMgr->GetBattlegroundTemplate(ginfo->BgTypeId))
        {
            char const* bgName = bgt->GetName();
            uint32 q_min_level = std::min(bracketEntry->minLevel, (uint32)80);
            uint32 q_max_level = std::min(bracketEntry->maxLevel, (uint32)80);
            uint32 qHorde = 0;
            uint32 qAlliance = 0;
            GroupsQueueType::const_iterator itr;
            for (itr = m_QueuedGroups[bracketId][BG_QUEUE_NORMAL_ALLIANCE].begin(); itr != m_QueuedGroups[bracketId][BG_QUEUE_NORMAL_ALLIANCE].end(); ++itr)
                if (!(*itr)->IsInvitedToBGInstanceGUID)
                    qAlliance += (*itr)->Players.size();
            for (itr = m_QueuedGroups[bracketId][BG_QUEUE_NORMAL_HORDE].begin(); itr != m_QueuedGroups[bracketId][BG_QUEUE_NORMAL_HORDE].end(); ++itr)
                if (!(*itr)->IsInvitedToBGInstanceGUID)
                    qHorde += (*itr)->Players.size();

            // show queue status to player when joining queue
            if (ginfo->BgTypeId == BATTLEGROUND_RB)
                ChatHandler(leader->GetSession()).PSendSysMessage(LANG_BG_QUEUE_ANNOUNCE_80_RANDOM, bgName, q_min_level, q_max_level, qAlliance, qHorde);
            else if (bgt->isArena())
                ChatHandler(leader->GetSession()).PSendSysMessage(LANG_BG_QUEUE_ANNOUNCE_STANDARD, bgName, q_min_level, q_max_level, qAlliance, ((uint32)m_arenaType > qAlliance ? (uint32)m_arenaType - qAlliance : 0), qHorde, ((uint32)m_arenaType > qHorde ? (uint32)m_arenaType - qHorde : 0));
            else if (q_min_level >= 80)
                ChatHandler(leader->GetSession()).PSendSysMessage(LANG_BG_QUEUE_ANNOUNCE_80_SPECIFIC, bgName, q_min_level, q_max_level, qAlliance, bgt->GetMinPlayersPerTeam(), qHorde, bgt->GetMinPlayersPerTeam());
            else
                ChatHandler(leader->GetSession()).PSendSysMessage(LANG_BG_QUEUE_ANNOUNCE_STANDARD, bgName, q_min_level, q_max_level, qAlliance, (bgt->GetMinPlayersPerTeam() > qAlliance ? bgt->GetMinPlayersPerTeam() - qAlliance : 0), qHorde, (bgt->GetMinPlayersPerTeam() > qHorde ? bgt->GetMinPlayersPerTeam() - qHorde : 0));
        }

    return ginfo;
}

void BattlegroundQueue::PlayerInvitedToBGUpdateAverageWaitTime(GroupQueueInfo* ginfo)
{
    uint32 timeInQueue = std::max<uint32>(1, getMSTimeDiff(ginfo->JoinTime, World::GetGameTimeMS()));

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
    uint32* lastIndex = &m_WaitTimeLastIndex[team_index][ginfo->_bracketId];

    // set time at index to new value
    m_WaitTimes[team_index][ginfo->_bracketId][*lastIndex] = timeInQueue;

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
    if (m_WaitTimes[team_index][ginfo->_bracketId][COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME - 1])
    {
        uint32 sum = 0;
        for (uint32 i=0; i<COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME; ++i)
            sum += m_WaitTimes[team_index][ginfo->_bracketId][i];
        return sum / COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME;
    }
    else
        return 0;
}

//remove player from queue and from group info, if group info is empty then remove it too
void BattlegroundQueue::RemovePlayer(uint64 guid, bool sentToBg, uint32 playerQueueSlot)
{
    // pussywizard: leave queue packet
    if (playerQueueSlot < PLAYER_MAX_BATTLEGROUND_QUEUES)
        if (Player* p = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
        {
            WorldPacket data;
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, NULL, playerQueueSlot, STATUS_NONE, 0, 0, 0, TEAM_NEUTRAL);
            p->GetSession()->SendPacket(&data);
        }

    //remove player from map, if he's there
    QueuedPlayersMap::iterator itr = m_QueuedPlayers.find(guid);
    if (itr == m_QueuedPlayers.end())
    {
        ASSERT(false);
        return;
    }

    GroupQueueInfo* groupInfo = itr->second;

    uint32 _bracketId = groupInfo->_bracketId;
    uint32 _groupType = groupInfo->_groupType;

    // find iterator
    GroupsQueueType::iterator group_itr = m_QueuedGroups[_bracketId][_groupType].end();
    for (GroupsQueueType::iterator k = m_QueuedGroups[_bracketId][_groupType].begin(); k != m_QueuedGroups[_bracketId][_groupType].end(); ++k)
        if ((*k) == groupInfo)
        {
            group_itr = k;
            break;
        }

    //player can't be in queue without group, but just in case
    if (group_itr == m_QueuedGroups[_bracketId][_groupType].end())
    {
        ASSERT(false);
        return;
    }

    // remove player from group queue info
    std::set<uint64>::iterator pitr = groupInfo->Players.find(guid);
    ASSERT(pitr != groupInfo->Players.end());
    if (pitr != groupInfo->Players.end())
        groupInfo->Players.erase(pitr);

    // if invited to bg, then always decrease invited count when removed from queue
    // sending player to bg will increase it again
    if (groupInfo->IsInvitedToBGInstanceGUID)
        if (Battleground* bg = sBattlegroundMgr->GetBattleground(groupInfo->IsInvitedToBGInstanceGUID))
            bg->DecreaseInvitedCount(groupInfo->teamId);

    // remove player queue info
    m_QueuedPlayers.erase(itr);

    // announce to world if arena team left queue for rated match, show only once
    if (groupInfo->ArenaType && groupInfo->IsRated && groupInfo->Players.empty() && sWorld->getBoolConfig(CONFIG_ARENA_QUEUE_ANNOUNCER_ENABLE))
        if (ArenaTeam* team = sArenaTeamMgr->GetArenaTeamById(groupInfo->ArenaTeamId))
            sWorld->SendWorldText(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_EXIT, team->GetName().c_str(), groupInfo->ArenaType, groupInfo->ArenaType, groupInfo->ArenaTeamRating);

    // if player leaves queue and he is invited to a rated arena match, then count it as he lost
    if (groupInfo->IsInvitedToBGInstanceGUID && groupInfo->IsRated && !sentToBg)
        if (ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(groupInfo->ArenaTeamId))
        {
            if (Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
                at->MemberLost(player, groupInfo->OpponentsMatchmakerRating);
            at->SaveToDB();
        }

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
        uint32 queueSlot = PLAYER_MAX_BATTLEGROUND_QUEUES;

        if (Player* plr = ObjectAccessor::FindPlayerInOrOutOfWorld(*(groupInfo->Players.begin())))
        {
            BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(groupInfo->BgTypeId, groupInfo->ArenaType);
            queueSlot = plr->GetBattlegroundQueueIndex(bgQueueTypeId);
            plr->RemoveBattlegroundQueueId(bgQueueTypeId);
        }

        // recursive call
        RemovePlayer(*(groupInfo->Players.begin()), false, queueSlot);
    }
}

void BattlegroundQueue::AddEvent(BasicEvent* Event, uint64 e_time)
{
    m_events.AddEvent(Event, m_events.CalculateTime(e_time));
}

bool BattlegroundQueue::IsPlayerInvitedToRatedArena(uint64 pl_guid)
{
    QueuedPlayersMap::const_iterator qItr = m_QueuedPlayers.find(pl_guid);
    return qItr != m_QueuedPlayers.end() && qItr->second->IsRated && qItr->second->IsInvitedToBGInstanceGUID;
}

//returns true when player pl_guid is in queue and is invited to bgInstanceGuid
bool BattlegroundQueue::IsPlayerInvited(uint64 pl_guid, const uint32 bgInstanceGuid, const uint32 removeTime)
{
    QueuedPlayersMap::const_iterator qItr = m_QueuedPlayers.find(pl_guid);
    return qItr != m_QueuedPlayers.end() && qItr->second->IsInvitedToBGInstanceGUID == bgInstanceGuid && qItr->second->RemoveInviteTime == removeTime;
}

bool BattlegroundQueue::GetPlayerGroupInfoData(uint64 guid, GroupQueueInfo* ginfo)
{
    QueuedPlayersMap::const_iterator qItr = m_QueuedPlayers.find(guid);
    if (qItr == m_QueuedPlayers.end())
        return false;
    *ginfo = *(qItr->second);
    return true;
}

// this function is filling pools given free slots on both sides, result is ballanced
void BattlegroundQueue::FillPlayersToBG(const int32 aliFree, const int32 hordeFree, BattlegroundBracketId bracket_id)
{
    // clear selection pools
    m_SelectionPools[TEAM_ALLIANCE].Init();
    m_SelectionPools[TEAM_HORDE].Init();

    // quick check if nothing we can do:
    if (!sBattlegroundMgr->isTesting())
        if ((aliFree > hordeFree && m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].empty()) ||
            (hordeFree > aliFree && m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].empty()))
            return;

    // ally: at first fill as much as possible
    GroupsQueueType::const_iterator Ali_itr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].begin();
    for (; Ali_itr != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].end() && m_SelectionPools[TEAM_ALLIANCE].AddGroup((*Ali_itr), aliFree); ++Ali_itr);

    // horde: at first fill as much as possible
    GroupsQueueType::const_iterator Horde_itr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].begin();
    for (; Horde_itr != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].end() && m_SelectionPools[TEAM_HORDE].AddGroup((*Horde_itr), hordeFree); ++Horde_itr);

    // calculate free space after adding
    int32 aliDiff   = aliFree   - int32(m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount());
    int32 hordeDiff = hordeFree - int32(m_SelectionPools[TEAM_HORDE].GetPlayerCount());

    // if free space differs too much, ballance
    while (abs(aliDiff - hordeDiff) > 1 && (m_SelectionPools[TEAM_HORDE].GetPlayerCount() > 0 || m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() > 0))
    {
        // if results in more alliance players than horde:
        if (aliDiff < hordeDiff)
        {
            // no more alliance in pool, invite whatever we can from horde
            if (!m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount())
                break;

            // kick alliance, returns true if kicked more than needed, so then try to fill up
            if (m_SelectionPools[TEAM_ALLIANCE].KickGroup(hordeDiff - aliDiff))
                for (; Ali_itr != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].end() && m_SelectionPools[TEAM_ALLIANCE].AddGroup((*Ali_itr), aliFree >= hordeDiff ? aliFree - hordeDiff : 0); ++Ali_itr);
        }
        // if results in more horde players than alliance:
        else
        {
            // no more horde in pool, invite whatever we can from alliance
            if (!m_SelectionPools[TEAM_HORDE].GetPlayerCount())
                break;

            // kick horde, returns true if kicked more than needed, so then try to fill up
            if (m_SelectionPools[TEAM_HORDE].KickGroup(aliDiff - hordeDiff))
                for (; Horde_itr != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].end() && m_SelectionPools[TEAM_HORDE].AddGroup((*Horde_itr), hordeFree >= aliDiff ? hordeFree - aliDiff : 0); ++Horde_itr);
        }

        // recalculate free space after adding
        aliDiff   = aliFree   - int32(m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount());
        hordeDiff = hordeFree - int32(m_SelectionPools[TEAM_HORDE].GetPlayerCount());
    }
}

void BattlegroundQueue::FillPlayersToBGWithSpecific(const int32 aliFree, const int32 hordeFree, BattlegroundBracketId thisBracketId, BattlegroundQueue* specificQueue, BattlegroundBracketId specificBracketId)
{
    // clear selection pools
    m_SelectionPools[TEAM_ALLIANCE].Init();
    m_SelectionPools[TEAM_HORDE].Init();

    // quick check if nothing we can do:
    if (!sBattlegroundMgr->isTesting())
        if ((m_QueuedGroups[thisBracketId][BG_QUEUE_NORMAL_ALLIANCE].empty() && specificQueue->m_QueuedGroups[specificBracketId][BG_QUEUE_NORMAL_ALLIANCE].empty()) ||
            (m_QueuedGroups[thisBracketId][BG_QUEUE_NORMAL_HORDE].empty() && specificQueue->m_QueuedGroups[specificBracketId][BG_QUEUE_NORMAL_HORDE].empty()))
            return;

    // copy groups from both queues to new joined container
    GroupsQueueType m_QueuedBoth[BG_TEAMS_COUNT];
    m_QueuedBoth[TEAM_ALLIANCE].insert(m_QueuedBoth[TEAM_ALLIANCE].end(), specificQueue->m_QueuedGroups[specificBracketId][BG_QUEUE_NORMAL_ALLIANCE].begin(), specificQueue->m_QueuedGroups[specificBracketId][BG_QUEUE_NORMAL_ALLIANCE].end());
    m_QueuedBoth[TEAM_ALLIANCE].insert(m_QueuedBoth[TEAM_ALLIANCE].end(), m_QueuedGroups[thisBracketId][BG_QUEUE_NORMAL_ALLIANCE].begin(), m_QueuedGroups[thisBracketId][BG_QUEUE_NORMAL_ALLIANCE].end());
    m_QueuedBoth[TEAM_HORDE].insert(m_QueuedBoth[TEAM_HORDE].end(), specificQueue->m_QueuedGroups[specificBracketId][BG_QUEUE_NORMAL_HORDE].begin(), specificQueue->m_QueuedGroups[specificBracketId][BG_QUEUE_NORMAL_HORDE].end());
    m_QueuedBoth[TEAM_HORDE].insert(m_QueuedBoth[TEAM_HORDE].end(), m_QueuedGroups[thisBracketId][BG_QUEUE_NORMAL_HORDE].begin(), m_QueuedGroups[thisBracketId][BG_QUEUE_NORMAL_HORDE].end());

    // ally: at first fill as much as possible
    GroupsQueueType::const_iterator Ali_itr = m_QueuedBoth[TEAM_ALLIANCE].begin();
    for (; Ali_itr != m_QueuedBoth[TEAM_ALLIANCE].end() && m_SelectionPools[TEAM_ALLIANCE].AddGroup((*Ali_itr), aliFree); ++Ali_itr);

    // horde: at first fill as much as possible
    GroupsQueueType::const_iterator Horde_itr = m_QueuedBoth[TEAM_HORDE].begin();
    for (; Horde_itr != m_QueuedBoth[TEAM_HORDE].end() && m_SelectionPools[TEAM_HORDE].AddGroup((*Horde_itr), hordeFree); ++Horde_itr);

    // calculate free space after adding
    int32 aliDiff   = aliFree   - int32(m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount());
    int32 hordeDiff = hordeFree - int32(m_SelectionPools[TEAM_HORDE].GetPlayerCount());

    // if free space differs too much, ballance
    while (abs(aliDiff - hordeDiff) > 1 && (m_SelectionPools[TEAM_HORDE].GetPlayerCount() > 0 || m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() > 0))
    {
        // if results in more alliance players than horde:
        if (aliDiff < hordeDiff)
        {
            // no more alliance in pool, invite whatever we can from horde
            if (!m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount())
                break;

            // kick alliance, returns true if kicked more than needed, so then try to fill up
            if (m_SelectionPools[TEAM_ALLIANCE].KickGroup(hordeDiff - aliDiff))
                for (; Ali_itr != m_QueuedBoth[TEAM_ALLIANCE].end() && m_SelectionPools[TEAM_ALLIANCE].AddGroup((*Ali_itr), aliFree >= hordeDiff ? aliFree - hordeDiff : 0); ++Ali_itr);
        }
        // if results in more horde players than alliance:
        else
        {
            // no more horde in pool, invite whatever we can from alliance
            if (!m_SelectionPools[TEAM_HORDE].GetPlayerCount())
                break;

            // kick horde, returns true if kicked more than needed, so then try to fill up
            if (m_SelectionPools[TEAM_HORDE].KickGroup(aliDiff - hordeDiff))
                for (; Horde_itr != m_QueuedBoth[TEAM_HORDE].end() && m_SelectionPools[TEAM_HORDE].AddGroup((*Horde_itr), hordeFree >= aliDiff ? hordeFree - aliDiff : 0); ++Horde_itr);
        }

        // recalculate free space after adding
        aliDiff   = aliFree   - int32(m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount());
        hordeDiff = hordeFree - int32(m_SelectionPools[TEAM_HORDE].GetPlayerCount());
    }
}

// this method checks if premade versus premade battleground is possible
// then after 30 mins (default) in queue it moves premade group to normal queue
bool BattlegroundQueue::CheckPremadeMatch(BattlegroundBracketId bracket_id, uint32 MinPlayersPerTeam, uint32 MaxPlayersPerTeam)
{
    // clear selection pools
    m_SelectionPools[TEAM_ALLIANCE].Init();
    m_SelectionPools[TEAM_HORDE].Init();

    if (!m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].empty() && !m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].empty())
    {
        // find premade group for both factions:
        GroupsQueueType::const_iterator ali_group, horde_group;
        for (ali_group = m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].begin(); ali_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].end(); ++ali_group)
            if (!(*ali_group)->IsInvitedToBGInstanceGUID && (*ali_group)->Players.size() >= MinPlayersPerTeam)
                break;
        for (horde_group = m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].begin(); horde_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].end(); ++horde_group)
            if (!(*horde_group)->IsInvitedToBGInstanceGUID && (*horde_group)->Players.size() >= MinPlayersPerTeam)
                break;

        // if found both groups
        if (ali_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].end() && horde_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].end())
        {
            // add premade groups to selection pools
            m_SelectionPools[TEAM_ALLIANCE].AddGroup((*ali_group), MaxPlayersPerTeam);
            m_SelectionPools[TEAM_HORDE].AddGroup((*horde_group), MaxPlayersPerTeam);

            // battleground will be immediately filled (after calling this function and creating new battleground) with more players from normal queue

            return m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() >= MinPlayersPerTeam && m_SelectionPools[TEAM_HORDE].GetPlayerCount() >= MinPlayersPerTeam;
        }
    }

    // now check if we can move groups from premade queue to normal queue
    // this happens if timer has expired or group size lowered

    uint32 premade_time = sWorld->getIntConfig(CONFIG_BATTLEGROUND_PREMADE_GROUP_WAIT_FOR_MATCH);
    uint32 time_before = World::GetGameTimeMS() >= premade_time ? World::GetGameTimeMS() - premade_time : 0;

    for (uint32 i = 0; i < BG_TEAMS_COUNT; i++)
        if (!m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE + i].empty())
            for (GroupsQueueType::iterator itr = m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE + i].begin(); itr != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE + i].end(); )
            {
                if (!(*itr)->IsInvitedToBGInstanceGUID && ((*itr)->JoinTime < time_before || (*itr)->Players.size() < MinPlayersPerTeam))
                {
                    (*itr)->_groupType = BG_QUEUE_NORMAL_ALLIANCE + i; // pussywizard: update GroupQueueInfo internal variable
                    m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].push_front((*itr));
                    m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE + i].erase(itr++);
                    continue;
                }
                ++itr;
            }

    return false;
}

// this method tries to create battleground or arena with MinPlayersPerTeam against MinPlayersPerTeam
bool BattlegroundQueue::CheckNormalMatch(Battleground* bgTemplate, BattlegroundBracketId bracket_id, uint32 minPlayers, uint32 maxPlayers)
{
    // if current queue is BATTLEGROUND_QUEUE_RB, then we are trying to create bg using players from 2 queues
    if (bgTemplate->GetBgTypeID() == BATTLEGROUND_RB)
    {
        // specific template
        Battleground* specificTemplate = sBattlegroundMgr->GetBattlegroundTemplate(sBattlegroundMgr->RandomSystem.GetCurrentRandomBg());
        if (!specificTemplate)
            return false;

        // specific bracket id
        PvPDifficultyEntry const* specificBracket = GetBattlegroundBracketByLevel(specificTemplate->GetMapId(), sBattlegroundMgr->randomBgDifficultyEntry.minLevel);
        if (!specificBracket || specificBracket->maxLevel < sBattlegroundMgr->randomBgDifficultyEntry.maxLevel)
            return false;

        // specific queue
        BattlegroundQueue& specificQueue = sBattlegroundMgr->GetBattlegroundQueue(BattlegroundMgr::BGQueueTypeId(sBattlegroundMgr->RandomSystem.GetCurrentRandomBg(), 0));

        FillPlayersToBGWithSpecific(specificTemplate->GetMaxPlayersPerTeam(), specificTemplate->GetMaxPlayersPerTeam(), bracket_id, &specificQueue, BattlegroundBracketId(specificBracket->bracketId));

        //allow 1v0 if debug bg
        if (sBattlegroundMgr->isTesting() && bgTemplate->isBattleground() && (m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() || m_SelectionPools[TEAM_HORDE].GetPlayerCount()))
            return true;

        return m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() >= std::min<uint32>(specificTemplate->GetMinPlayersPerTeam(), 15) && m_SelectionPools[TEAM_HORDE].GetPlayerCount() >= std::min<uint32>(specificTemplate->GetMinPlayersPerTeam(), 15);
    }
    // if this is not random bg queue - use players only from this queue
    else
    {
        FillPlayersToBG(maxPlayers, maxPlayers, bracket_id);

        //allow 1v0 if debug bg
        if (sBattlegroundMgr->isTesting() && bgTemplate->isBattleground() && (m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() || m_SelectionPools[TEAM_HORDE].GetPlayerCount()))
            return true;

        return m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() >= minPlayers && m_SelectionPools[TEAM_HORDE].GetPlayerCount() >= minPlayers;
    }
}

// this method will check if we can invite players to same faction skirmish match
bool BattlegroundQueue::CheckSkirmishForSameFaction(BattlegroundBracketId bracket_id, uint32 minPlayersPerTeam)
{
    for (uint32 i = 0; i < BG_TEAMS_COUNT; i++)
        if (!m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].empty())
        {
            // clear selection pools
            m_SelectionPools[TEAM_ALLIANCE].Init();
            m_SelectionPools[TEAM_HORDE].Init();

            // fill one queue to both selection pools
            for (GroupsQueueType::const_iterator itr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].begin(); itr != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].end(); ++itr)
                for (uint32 j = 0; j < BG_TEAMS_COUNT; j++) // try to add this group to both pools
                    if (m_SelectionPools[TEAM_ALLIANCE + j].GetPlayerCount() < minPlayersPerTeam) // if this pool is not full
                        if (m_SelectionPools[TEAM_ALLIANCE + j].AddGroup((*itr), minPlayersPerTeam)) // successfully added
                        {
                            // if both selection pools are full
                            if (m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() >= minPlayersPerTeam && m_SelectionPools[TEAM_HORDE].GetPlayerCount() >= minPlayersPerTeam)
                            {
                                // need to move groups from one pool to another queue (for another faction)
                                TeamId wrongTeamId = (i == 0 ? TEAM_HORDE : TEAM_ALLIANCE);

                                for (GroupsQueueType::iterator pitr = m_SelectionPools[wrongTeamId].SelectedGroups.begin(); pitr != m_SelectionPools[wrongTeamId].SelectedGroups.end(); ++pitr)
                                {
                                    // update internal GroupQueueInfo data
                                    (*pitr)->teamId = wrongTeamId;
                                    (*pitr)->_groupType = BG_QUEUE_NORMAL_ALLIANCE + wrongTeamId;

                                    // add GroupQueueInfo to new queue
                                    m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + wrongTeamId].push_front(*pitr);

                                    // remove GroupQueueInfo from old queue
                                    for (GroupsQueueType::iterator qitr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].begin(); qitr != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].end(); ++qitr)
                                        if (*qitr == *pitr)
                                        {
                                            m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].erase(qitr);
                                            break;
                                        }
                                }

                                return true;
                            }

                            break; // added to one pool, prevent adding it to the second pool
                        }
        }

    return false;
}

void BattlegroundQueue::UpdateEvents(uint32 diff)
{
    m_events.Update(diff);
}

struct BgEmptinessComp { bool operator()(Battleground* const &bg1, Battleground* const &bg2) { return ((float)bg1->GetMaxFreeSlots() / (float)bg1->GetMaxPlayersPerTeam()) > ((float)bg2->GetMaxFreeSlots() / (float)bg2->GetMaxPlayersPerTeam()); } };
typedef std::set<Battleground*, BgEmptinessComp> BattlegroundNeedSet;

void BattlegroundQueue::BattlegroundQueueUpdate(BattlegroundBracketId bracket_id, uint8 actionMask, bool isRated, uint32 arenaRatedTeamId)
{
    // if no players in queue - do nothing
    if (m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].empty() &&
        m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].empty() &&
        m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].empty() &&
        m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].empty())
        return;

    Battleground* bg_template = sBattlegroundMgr->GetBattlegroundTemplate(m_bgTypeId);
    if (!bg_template)
        return;

    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketById(bg_template->GetMapId(), bracket_id);
    if (!bracketEntry)
        return;

    // battlegrounds with free slots should be populated first using players in queue
    if ((actionMask & 0x01) && !BattlegroundMgr::IsArenaType(m_bgTypeId))
    {
        const BattlegroundContainer& bgList = sBattlegroundMgr->GetBattlegroundList();
        BattlegroundNeedSet bgsToCheck;

        // sort from most needing (most empty) to least needing using a std::set with functor
        for (BattlegroundContainer::const_iterator itr = bgList.begin(); itr != bgList.end(); ++itr)
        {
            Battleground* bg = itr->second;
            if (!BattlegroundMgr::IsArenaType(bg->GetBgTypeID()) && (bg->GetBgTypeID() == m_bgTypeId || m_bgTypeId == BATTLEGROUND_RB) && 
                bg->HasFreeSlots() && bg->GetMinLevel() <= bracketEntry->minLevel && bg->GetMaxLevel() >= bracketEntry->maxLevel)
                bgsToCheck.insert(bg);
        }

        // now iterate needing battlegrounds
        for (BattlegroundNeedSet::iterator itr = bgsToCheck.begin(); itr != bgsToCheck.end(); ++itr)
        {
            Battleground* bg = *itr;

            // call a function that fills whatever we can from normal queues
            FillPlayersToBG(bg->GetFreeSlotsForTeam(TEAM_ALLIANCE), bg->GetFreeSlotsForTeam(TEAM_HORDE), bracket_id);

            // invite players
            for (uint32 i = 0; i < BG_TEAMS_COUNT; i++)
                for (GroupsQueueType::const_iterator citr = m_SelectionPools[TEAM_ALLIANCE + i].SelectedGroups.begin(); citr != m_SelectionPools[TEAM_ALLIANCE + i].SelectedGroups.end(); ++citr)
                    BattlegroundMgr::InviteGroupToBG((*citr), bg, (*citr)->teamId);
        }
    }

    // finished iterating through battlegrounds with free slots, maybe we need to create a new bg

    if ((actionMask & 0x02) == 0)
        return;

    // get min and max players per team
    uint32 MinPlayersPerTeam = bg_template->GetMinPlayersPerTeam();
    uint32 MaxPlayersPerTeam = bg_template->GetMaxPlayersPerTeam();
    if (bg_template->isArena())
    {
        MinPlayersPerTeam = sBattlegroundMgr->isArenaTesting() ? 1 : m_arenaType;
        MaxPlayersPerTeam = m_arenaType;
    }

    // check if can start new premade battleground
    if (bg_template->isBattleground() && m_bgTypeId != BATTLEGROUND_RB)
        if (CheckPremadeMatch(bracket_id, MinPlayersPerTeam, MaxPlayersPerTeam))
        {
            // create new battleground
            Battleground* bg = sBattlegroundMgr->CreateNewBattleground(m_bgTypeId, bracketEntry->minLevel, bracketEntry->maxLevel, 0, false);
            if (!bg)
                return;

            // invite players
            for (uint32 i = 0; i < BG_TEAMS_COUNT; i++)
                for (GroupsQueueType::const_iterator citr = m_SelectionPools[TEAM_ALLIANCE + i].SelectedGroups.begin(); citr != m_SelectionPools[TEAM_ALLIANCE + i].SelectedGroups.end(); ++citr)
                    BattlegroundMgr::InviteGroupToBG((*citr), bg, (*citr)->teamId);

            bg->StartBattleground();

            // now fill the premade bg if possible (only one team for each side has been invited yet)
            if (bg->HasFreeSlots())
            {
                // call a function that fills whatever we can from normal queues
                FillPlayersToBG(bg->GetFreeSlotsForTeam(TEAM_ALLIANCE), bg->GetFreeSlotsForTeam(TEAM_HORDE), bracket_id);

                // invite players
                for (uint32 i = 0; i < BG_TEAMS_COUNT; i++)
                    for (GroupsQueueType::const_iterator citr = m_SelectionPools[TEAM_ALLIANCE + i].SelectedGroups.begin(); citr != m_SelectionPools[TEAM_ALLIANCE + i].SelectedGroups.end(); ++citr)
                        BattlegroundMgr::InviteGroupToBG((*citr), bg, (*citr)->teamId);
            }
        }

    // check if can start new normal battleground or non-rated arena
    if (!isRated)
    {
        if (CheckNormalMatch(bg_template, bracket_id, MinPlayersPerTeam, MaxPlayersPerTeam) ||
            (bg_template->isArena() && CheckSkirmishForSameFaction(bracket_id, MinPlayersPerTeam)))
        {
            BattlegroundTypeId newBgTypeId = m_bgTypeId;
            uint32 minLvl = bracketEntry->minLevel;
            uint32 maxLvl = bracketEntry->maxLevel;

            // for random bg use values from specific
            if (m_bgTypeId == BATTLEGROUND_RB)
            {
                newBgTypeId = sBattlegroundMgr->RandomSystem.GetCurrentRandomBg();
                Battleground* specificTemplate = sBattlegroundMgr->GetBattlegroundTemplate(newBgTypeId);
                if (!specificTemplate)
                    return;
                PvPDifficultyEntry const* specificBracket = GetBattlegroundBracketByLevel(specificTemplate->GetMapId(), sBattlegroundMgr->randomBgDifficultyEntry.minLevel);
                if (!specificBracket)
                    return;
                minLvl = specificBracket->minLevel;
                maxLvl = specificBracket->maxLevel;

                sBattlegroundMgr->RandomSystem.BattlegroundCreated(newBgTypeId);
            }

            // create new battleground
            Battleground* bg = sBattlegroundMgr->CreateNewBattleground(newBgTypeId, minLvl, maxLvl, m_arenaType, false);
            if (!bg)
                return;

            // invite players
            for (uint32 i = 0; i < BG_TEAMS_COUNT; i++)
                for (GroupsQueueType::const_iterator citr = m_SelectionPools[TEAM_ALLIANCE + i].SelectedGroups.begin(); citr != m_SelectionPools[TEAM_ALLIANCE + i].SelectedGroups.end(); ++citr)
                    BattlegroundMgr::InviteGroupToBG((*citr), bg, (*citr)->teamId);

            bg->StartBattleground();
        }
    }
    // check if can start new rated arenas (can create many in single queue update)
    else if (bg_template->isArena())
    {
        // pussywizard: everything inside this section is mine, do NOT destroy!

        const uint32 currMSTime = World::GetGameTimeMS();
        const uint32 discardTime = sBattlegroundMgr->GetRatingDiscardTimer();
        const uint32 maxDefaultRatingDifference = (MaxPlayersPerTeam > 2 ? 300 : 200);
        const uint32 maxCountedMMR = 2500;

        // we need to find 2 teams which will play next game
        GroupsQueueType::iterator itr_teams[BG_TEAMS_COUNT];

        bool increaseItr = true;
        bool reverse1 = urand(0,1) ? true : false;
        for (uint8 ii = BG_QUEUE_PREMADE_ALLIANCE; ii <= BG_QUEUE_PREMADE_HORDE; ii++)
        {
            uint8 i = reverse1 ? (BG_QUEUE_PREMADE_HORDE-ii) : ii;
            for (GroupsQueueType::iterator itr = m_QueuedGroups[bracket_id][i].begin(); itr != m_QueuedGroups[bracket_id][i].end(); (increaseItr ? ++itr : itr))
            {
                increaseItr = true;

                // if arenaRatedTeamId is set - look for oponents only for one team, if not - pair every possible team
                if (arenaRatedTeamId != 0 && arenaRatedTeamId != (*itr)->ArenaTeamId)
                    continue;
                if ((*itr)->IsInvitedToBGInstanceGUID)
                    continue;

                uint32 MMR1 = std::min((*itr)->ArenaMatchmakerRating, maxCountedMMR);

                GroupsQueueType::iterator oponentItr;
                uint8 oponentQueue = BG_QUEUE_GROUP_TYPES_COUNT;
                uint32 minOponentMMRDiff = 0xffffffff;
                uint8 oponentValid = 0;

                bool reverse2 = urand(0,1) ? true : false;
                for (uint8 jj = BG_QUEUE_PREMADE_ALLIANCE; jj <= BG_QUEUE_PREMADE_HORDE; jj++)
                {
                    uint8 j = reverse2 ? (BG_QUEUE_PREMADE_HORDE-jj) : jj;
                    bool brk = false;
                    for (GroupsQueueType::iterator itr2 = m_QueuedGroups[bracket_id][j].begin(); itr2 != m_QueuedGroups[bracket_id][j].end(); ++itr2)
                    {
                        if ((*itr)->ArenaTeamId == (*itr2)->ArenaTeamId)
                            continue;
                        if ((*itr2)->IsInvitedToBGInstanceGUID)
                            continue;
                        uint32 MMR2 = std::min((*itr2)->ArenaMatchmakerRating, maxCountedMMR);
                        uint32 MMRDiff = (MMR2>=MMR1 ? MMR2-MMR1 : MMR1-MMR2);

                        uint32 maxAllowedDiff = maxDefaultRatingDifference;
                        uint32 shorterWaitTime, longerWaitTime;
                        if (currMSTime-(*itr)->JoinTime <= currMSTime-(*itr2)->JoinTime)
                        {
                            shorterWaitTime = currMSTime-(*itr)->JoinTime;
                            longerWaitTime = currMSTime-(*itr2)->JoinTime;
                        }
                        else
                        {
                            shorterWaitTime = currMSTime-(*itr2)->JoinTime;
                            longerWaitTime = currMSTime-(*itr)->JoinTime;
                        }
                        if (longerWaitTime >= discardTime)
                            maxAllowedDiff += 150;
                        maxAllowedDiff += shorterWaitTime/600; // increased by 100 for each minute

                        // now check if this team is more appropriate than previous ones:

                        if (currMSTime-(*itr)->JoinTime >= 20*MINUTE*IN_MILLISECONDS && (oponentValid < 3 || MMRDiff < minOponentMMRDiff)) // after 20 minutes of waiting, pair with closest mmr, regardless the difference
                        {
                            oponentValid = 3;
                            minOponentMMRDiff = MMRDiff; oponentItr = itr2; oponentQueue = j;
                        }
                        else if (MMR1 >= 2000 && MMR2 >= 2000 && longerWaitTime >= 2*discardTime && (oponentValid < 2 || MMRDiff < minOponentMMRDiff)) // after 6 minutes of waiting, pair any 2000+ vs 2000+
                        {
                            oponentValid = 2;
                            minOponentMMRDiff = MMRDiff; oponentItr = itr2; oponentQueue = j;
                        }
                        else if (oponentValid < 2 && MMRDiff < minOponentMMRDiff)
                        {
                            if (!oponentValid)
                            {
                                minOponentMMRDiff = MMRDiff; oponentItr = itr2; oponentQueue = j;
                                if (MMRDiff <= maxAllowedDiff)
                                    oponentValid = 1;
                            }
                            if ((MMR1 < 1800 || MMR2 < 1800) && MaxPlayersPerTeam == 2 && MMRDiff <= maxDefaultRatingDifference) // in 2v2 below 1800 mmr - priority for default allowed difference
                            {
                                minOponentMMRDiff = MMRDiff; oponentItr = itr2; oponentQueue = j;
                                brk = true;
                                break;
                            }
                        }
                    }
                    if (brk)
                        break;
                }

                if (oponentQueue != BG_QUEUE_GROUP_TYPES_COUNT)
                {
                    if (oponentValid)
                    {
                        itr_teams[i] = itr;
                        itr_teams[i == 0 ? 1 : 0] = oponentItr;

                        {
                            GroupQueueInfo* aTeam = *itr_teams[TEAM_ALLIANCE];
                            GroupQueueInfo* hTeam = *itr_teams[TEAM_HORDE];
                            Battleground* arena = sBattlegroundMgr->CreateNewBattleground(m_bgTypeId, bracketEntry->minLevel, bracketEntry->maxLevel, m_arenaType, true);
                            if (!arena)
                                return;

                            aTeam->OpponentsTeamRating = hTeam->ArenaTeamRating;
                            hTeam->OpponentsTeamRating = aTeam->ArenaTeamRating;
                            aTeam->OpponentsMatchmakerRating = hTeam->ArenaMatchmakerRating;
                            hTeam->OpponentsMatchmakerRating = aTeam->ArenaMatchmakerRating;

                            // now we must move team if we changed its faction to another faction queue, because then we will spam log by errors in Queue::RemovePlayer
                            if (aTeam->teamId != TEAM_ALLIANCE)
                            {
                                aTeam->_groupType = BG_QUEUE_PREMADE_ALLIANCE;
                                m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].push_front(aTeam);
                                m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].erase(itr_teams[TEAM_ALLIANCE]);
                                increaseItr = false;
                                itr = m_QueuedGroups[bracket_id][i].begin();
                            }
                            if (hTeam->teamId != TEAM_HORDE)
                            {
                                hTeam->_groupType = BG_QUEUE_PREMADE_HORDE;
                                m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].push_front(hTeam);
                                m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].erase(itr_teams[TEAM_HORDE]);
                                increaseItr = false;
                                itr = m_QueuedGroups[bracket_id][i].begin();
                            }

                            arena->SetArenaMatchmakerRating(TEAM_ALLIANCE, aTeam->ArenaMatchmakerRating);
                            arena->SetArenaMatchmakerRating(TEAM_HORDE, hTeam->ArenaMatchmakerRating);
                            BattlegroundMgr::InviteGroupToBG(aTeam, arena, TEAM_ALLIANCE);
                            BattlegroundMgr::InviteGroupToBG(hTeam, arena, TEAM_HORDE);

                            arena->StartBattleground();
                        }

                        if (arenaRatedTeamId)
                            return;
                        else
                            continue;
                    }
                    else if (arenaRatedTeamId)
                        return;
                }
            }
        }
    }
}

/*********************************************************/
/***            BATTLEGROUND QUEUE EVENTS              ***/
/*********************************************************/

bool BGQueueInviteEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(m_PlayerGuid);

    // player logged off, so he is no longer in queue
    if (!player)
        return true;

    Battleground* bg = sBattlegroundMgr->GetBattleground(m_BgInstanceGUID);

    // if battleground ended, do nothing
    if (!bg)
        return true;

    // check if still in queue for this battleground
    BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(m_BgTypeId, m_ArenaType);
    uint32 queueSlot = player->GetBattlegroundQueueIndex(bgQueueTypeId);
    if (queueSlot < PLAYER_MAX_BATTLEGROUND_QUEUES)
    {
        // confirm the player is invited to this instance id (he didn't requeue in the meanwhile)
        BattlegroundQueue &bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
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
    Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(m_PlayerGuid);

    // player logged off, so he is no longer in queue
    if (!player)
        return true;

    Battleground* bg = sBattlegroundMgr->GetBattleground(m_BgInstanceGUID);

    // battleground can be already deleted, bg may be NULL!

    // check if still in queue for this battleground
    uint32 queueSlot = player->GetBattlegroundQueueIndex(m_BgQueueTypeId);
    if (queueSlot < PLAYER_MAX_BATTLEGROUND_QUEUES) // player is in queue
    {
        // confirm the player is invited to this instance id (he didn't requeue in the meanwhile)
        BattlegroundQueue &bgQueue = sBattlegroundMgr->GetBattlegroundQueue(m_BgQueueTypeId);
        if (bgQueue.IsPlayerInvited(m_PlayerGuid, m_BgInstanceGUID, m_RemoveTime))
        {
            // track if player leaves the BG by not clicking enter button
            if (bg && bg->isBattleground() && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_TRACK_DESERTERS) &&
            (bg->GetStatus() == STATUS_IN_PROGRESS || bg->GetStatus() == STATUS_WAIT_JOIN))
            {
                PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_DESERTER_TRACK);
                stmt->setUInt32(0, player->GetGUIDLow());
                stmt->setUInt8(1, BG_DESERTION_TYPE_NO_ENTER_BUTTON);
                CharacterDatabase.Execute(stmt);
            }
            player->RemoveBattlegroundQueueId(m_BgQueueTypeId);
            bgQueue.RemovePlayer(m_PlayerGuid, false, queueSlot);
        }
    }

    return true;
}

void BGQueueRemoveEvent::Abort(uint64 /*e_time*/)
{
    //do nothing
}
