/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "LFGMgr.h"
#include "ObjectMgr.h"
#include "Group.h"
#include "Player.h"
#include "Opcodes.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void BuildPlayerLockDungeonBlock(WorldPacket& data, lfg::LfgLockMap const& lock)
{
    data << uint32(lock.size());                           // Size of lock dungeons
    for (lfg::LfgLockMap::const_iterator it = lock.begin(); it != lock.end(); ++it)
    {
        data << uint32(it->first);                         // Dungeon entry (id + type)
        data << uint32(it->second);                        // Lock status
    }
}

void BuildPartyLockDungeonBlock(WorldPacket& data, const lfg::LfgLockPartyMap& lockMap)
{
    data << uint8(lockMap.size());
    for (lfg::LfgLockPartyMap::const_iterator it = lockMap.begin(); it != lockMap.end(); ++it)
    {
        data << uint64(it->first);                         // Player guid
        BuildPlayerLockDungeonBlock(data, it->second);
    }
}

void WorldSession::HandleLfgJoinOpcode(WorldPacket& recvData)
{
    if (!sLFGMgr->isOptionEnabled(lfg::LFG_OPTION_ENABLE_DUNGEON_FINDER | lfg::LFG_OPTION_ENABLE_RAID_BROWSER))
    {
        recvData.rfinish();
        return;
    }

    // pussywizard:
    if (Group* g = GetPlayer()->GetGroup())
        if (g->isLFGGroup() && g->GetLeaderGUID() != GetPlayer()->GetGUID())
        {
            recvData.rfinish();
            return;
        }

    uint8 numDungeons;
    uint32 roles;

    recvData >> roles;
    recvData.read_skip<uint16>();                          // uint8 (always 0) - uint8 (always 0)
    recvData >> numDungeons;
    if (!numDungeons)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LFG_JOIN [" UI64FMTD "] no dungeons selected", GetPlayer()->GetGUID());
#endif
        recvData.rfinish();
        return;
    }

    lfg::LfgDungeonSet newDungeons;
    for (int8 i = 0; i < numDungeons; ++i)
    {
        uint32 dungeon;
        recvData >> dungeon;
        dungeon &= 0x00FFFFFF;                             // remove the type from the dungeon entry
        if (dungeon)
            newDungeons.insert(dungeon);
    }

    recvData.read_skip<uint32>();                          // for 0..uint8 (always 3) { uint8 (always 0) }

    std::string comment;
    recvData >> comment;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LFG_JOIN [" UI64FMTD "] roles: %u, Dungeons: %u, Comment: %s", GetPlayer()->GetGUID(), roles, uint8(newDungeons.size()), comment.c_str());
#endif

    sLFGMgr->JoinLfg(GetPlayer(), uint8(roles), newDungeons, comment);
}

void WorldSession::HandleLfgLeaveOpcode(WorldPacket&  /*recvData*/)
{
    Group* group = GetPlayer()->GetGroup();
    uint64 guid = GetPlayer()->GetGUID();
    uint64 gguid = group ? group->GetGUID() : guid;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LFG_LEAVE [" UI64FMTD "] in group: %u", guid, group ? 1 : 0);
#endif

    // Check cheating - only leader can leave the queue
    if (!group || group->GetLeaderGUID() == guid)
    {
        sLFGMgr->LeaveLfg(sLFGMgr->GetState(guid) == lfg::LFG_STATE_RAIDBROWSER ? guid : gguid);
        sLFGMgr->LeaveAllLfgQueues(guid, true, group ? group->GetGUID() : 0);
    }
}

void WorldSession::HandleLfgProposalResultOpcode(WorldPacket& recvData)
{
    uint32 proposalID;                                      // Internal lfgGroupID
    bool accept;                                           // Accept to join?
    recvData >> proposalID;
    recvData >> accept;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LFG_PROPOSAL_RESULT [" UI64FMTD "] proposal: %u accept: %u", GetPlayer()->GetGUID(), proposalID, accept ? 1 : 0);
#endif
    sLFGMgr->UpdateProposal(proposalID, GetPlayer()->GetGUID(), accept);
}

void WorldSession::HandleLfgSetRolesOpcode(WorldPacket& recvData)
{
    uint8 roles;
    recvData >> roles;                                    // Player Group Roles
    uint64 guid = GetPlayer()->GetGUID();
    Group* group = GetPlayer()->GetGroup();
    if (!group)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LFG_SET_ROLES [" UI64FMTD "] Not in group", guid);
#endif
        return;
    }
    uint64 gguid = group->GetGUID();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LFG_SET_ROLES: Group [" UI64FMTD "], Player [" UI64FMTD "], Roles: %u", gguid, guid, roles);
#endif
    sLFGMgr->UpdateRoleCheck(gguid, guid, roles);
}

void WorldSession::HandleLfgSetCommentOpcode(WorldPacket&  recvData)
{
    std::string comment;
    recvData >> comment;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    uint64 guid = GetPlayer()->GetGUID();
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LFG_SET_COMMENT [" UI64FMTD "] comment: %s", guid, comment.c_str());
#endif

    sLFGMgr->SetComment(GetPlayer()->GetGUID(), comment);
    sLFGMgr->LfrSetComment(GetPlayer(), comment);
}

void WorldSession::HandleLfgSetBootVoteOpcode(WorldPacket& recvData)
{
    bool agree;                                            // Agree to kick player
    recvData >> agree;

    uint64 guid = GetPlayer()->GetGUID();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LFG_SET_BOOT_VOTE [" UI64FMTD "] agree: %u", guid, agree ? 1 : 0);
#endif
    sLFGMgr->UpdateBoot(guid, agree);
}

void WorldSession::HandleLfgTeleportOpcode(WorldPacket& recvData)
{
    bool out;
    recvData >> out;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LFG_TELEPORT [" UI64FMTD "] out: %u", GetPlayer()->GetGUID(), out ? 1 : 0);
#endif
    sLFGMgr->TeleportPlayer(GetPlayer(), out, true);
}

void WorldSession::HandleLfgPlayerLockInfoRequestOpcode(WorldPacket& /*recvData*/)
{
    uint64 guid = GetPlayer()->GetGUID();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LFG_PLAYER_LOCK_INFO_REQUEST [" UI64FMTD "]", guid);
#endif

    // Get Random dungeons that can be done at a certain level and expansion
    uint8 level = GetPlayer()->getLevel();
    lfg::LfgDungeonSet const& randomDungeons =
        sLFGMgr->GetRandomAndSeasonalDungeons(level, GetPlayer()->GetSession()->Expansion());

    // Get player locked Dungeons
    sLFGMgr->InitializeLockedDungeons(GetPlayer()); // pussywizard
    lfg::LfgLockMap const& lock = sLFGMgr->GetLockedDungeons(guid);
    uint32 rsize = uint32(randomDungeons.size());
    uint32 lsize = uint32(lock.size());

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_PLAYER_INFO [" UI64FMTD "]", guid);
#endif
    WorldPacket data(SMSG_LFG_PLAYER_INFO, 1 + rsize * (4 + 1 + 4 + 4 + 4 + 4 + 1 + 4 + 4 + 4) + 4 + lsize * (1 + 4 + 4 + 4 + 4 + 1 + 4 + 4 + 4));

    data << uint8(randomDungeons.size());                  // Random Dungeon count
    for (lfg::LfgDungeonSet::const_iterator it = randomDungeons.begin(); it != randomDungeons.end(); ++it)
    {
        data << uint32(*it);                               // Dungeon Entry (id + type)
        lfg::LfgReward const* reward = sLFGMgr->GetRandomDungeonReward(*it, level);
        Quest const* quest = nullptr;
        bool done = false;
        if (reward)
        {
            quest = sObjectMgr->GetQuestTemplate(reward->firstQuest);
            if (quest)
            {
                done = !GetPlayer()->CanRewardQuest(quest, false);
                if (done)
                    quest = sObjectMgr->GetQuestTemplate(reward->otherQuest);
            }
        }

        if (quest)
        {
            data << uint8(done);
            data << uint32(quest->GetRewOrReqMoney());
            data << uint32(quest->XPValue(GetPlayer()));
            data << uint32(0);
            data << uint32(0);
            data << uint8(quest->GetRewItemsCount());
            if (quest->GetRewItemsCount())
            {
                for (uint8 i = 0; i < QUEST_REWARDS_COUNT; ++i)
                    if (uint32 itemId = quest->RewardItemId[i])
                    {
                        ItemTemplate const* item = sObjectMgr->GetItemTemplate(itemId);
                        data << uint32(itemId);
                        data << uint32(item ? item->DisplayInfoID : 0);
                        data << uint32(quest->RewardItemIdCount[i]);
                    }
            }
        }
        else
        {
            data << uint8(0);
            data << uint32(0);
            data << uint32(0);
            data << uint32(0);
            data << uint32(0);
            data << uint8(0);
        }
    }
    BuildPlayerLockDungeonBlock(data, lock);
    SendPacket(&data);
}

void WorldSession::HandleLfgPartyLockInfoRequestOpcode(WorldPacket&  /*recvData*/)
{
    uint64 guid = GetPlayer()->GetGUID();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LFG_PARTY_LOCK_INFO_REQUEST [" UI64FMTD "]", guid);
#endif

    Group* group = GetPlayer()->GetGroup();
    if (!group)
        return;

    // Get the locked dungeons of the other party members
    lfg::LfgLockPartyMap lockMap;
    for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
    {
        Player* plrg = itr->GetSource();
        if (!plrg)
            continue;

        uint64 pguid = plrg->GetGUID();
        if (pguid == guid)
            continue;

        sLFGMgr->InitializeLockedDungeons(plrg); // pussywizard
        lockMap[pguid] = sLFGMgr->GetLockedDungeons(pguid);
    }

    uint32 size = 0;
    for (lfg::LfgLockPartyMap::const_iterator it = lockMap.begin(); it != lockMap.end(); ++it)
        size += 8 + 4 + uint32(it->second.size()) * (4 + 4);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_PARTY_INFO [" UI64FMTD "]", guid);
#endif
    WorldPacket data(SMSG_LFG_PARTY_INFO, 1 + size);
    BuildPartyLockDungeonBlock(data, lockMap);
    SendPacket(&data);
}

void WorldSession::HandleLfrSearchJoinOpcode(WorldPacket& recvData)
{
    uint32 dungeonId;
    recvData >> dungeonId;
    dungeonId = (dungeonId & 0x00FFFFFF); // remove the type from the dungeon entry
    sLFGMgr->LfrSearchAdd(GetPlayer(), dungeonId);
    sLFGMgr->SendRaidBrowserCachedList(GetPlayer(), dungeonId);
}

void WorldSession::HandleLfrSearchLeaveOpcode(WorldPacket& recvData)
{
    uint32 dungeonId;
    recvData >> dungeonId;
    sLFGMgr->LfrSearchRemove(GetPlayer());
}

void WorldSession::HandleLfgGetStatus(WorldPacket& /*recvData*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "CMSG_LFG_GET_STATUS %s", GetPlayerInfo().c_str());
#endif

    uint64 guid = GetPlayer()->GetGUID();
    lfg::LfgUpdateData updateData = sLFGMgr->GetLfgStatus(guid);

    if (GetPlayer()->GetGroup())
    {
        SendLfgUpdateParty(updateData);
        updateData.dungeons.clear();
        SendLfgUpdatePlayer(updateData);
    }
    else
    {
        SendLfgUpdatePlayer(updateData);
        updateData.dungeons.clear();
        SendLfgUpdateParty(updateData);
    }
}

void WorldSession::SendLfgUpdatePlayer(lfg::LfgUpdateData const& updateData)
{
    bool queued = false;
    uint8 size = uint8(updateData.dungeons.size());

    switch (updateData.updateType)
    {
        case lfg::LFG_UPDATETYPE_JOIN_QUEUE:
        case lfg::LFG_UPDATETYPE_ADDED_TO_QUEUE:
            queued = true;
            break;
        case lfg::LFG_UPDATETYPE_UPDATE_STATUS:
            queued = updateData.state == lfg::LFG_STATE_QUEUED;
            break;
        default:
            break;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "SMSG_LFG_UPDATE_PLAYER %s updatetype: %u",
        GetPlayerInfo().c_str(), updateData.updateType);
#endif
    WorldPacket data(SMSG_LFG_UPDATE_PLAYER, 1 + 1 + (size > 0 ? 1 : 0) * (1 + 1 + 1 + 1 + size * 4 + updateData.comment.length()));
    data << uint8(updateData.updateType);                  // Lfg Update type
    data << uint8(size > 0);                               // Extra info
    if (size)
    {
        data << uint8(queued);                             // Join the queue
        data << uint8(0);                                  // unk - Always 0
        data << uint8(0);                                  // unk - Always 0

        data << uint8(size);
        for (lfg::LfgDungeonSet::const_iterator it = updateData.dungeons.begin(); it != updateData.dungeons.end(); ++it)
            data << uint32(*it);
        data << updateData.comment;
    }
    SendPacket(&data);
}

void WorldSession::SendLfgUpdateParty(lfg::LfgUpdateData const& updateData)
{
    bool join = false;
    bool queued = false;
    uint8 size = uint8(updateData.dungeons.size());

    switch (updateData.updateType)
    {
        case lfg::LFG_UPDATETYPE_ADDED_TO_QUEUE:                // Rolecheck Success
            queued = true;
            // no break on purpose
        case lfg::LFG_UPDATETYPE_PROPOSAL_BEGIN:
            join = true;
            break;
        case lfg::LFG_UPDATETYPE_UPDATE_STATUS:
            join = updateData.state != lfg::LFG_STATE_ROLECHECK && updateData.state != lfg::LFG_STATE_NONE;
            queued = updateData.state == lfg::LFG_STATE_QUEUED;
            break;
        default:
            break;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_LFG, "SMSG_LFG_UPDATE_PARTY %s updatetype: %u",
        GetPlayerInfo().c_str(), updateData.updateType);
#endif
    WorldPacket data(SMSG_LFG_UPDATE_PARTY, 1 + 1 + (size > 0 ? 1 : 0) * (1 + 1 + 1 + 1 + 1 + size * 4 + updateData.comment.length()));
    data << uint8(updateData.updateType);                  // Lfg Update type
    data << uint8(size > 0);                               // Extra info
    if (size)
    {
        data << uint8(join);                               // LFG Join
        data << uint8(queued);                             // Join the queue
        data << uint8(0);                                  // unk - Always 0
        data << uint8(0);                                  // unk - Always 0
        for (uint8 i = 0; i < 3; ++i)
            data << uint8(0);                              // unk - Always 0

        data << uint8(size);
        for (lfg::LfgDungeonSet::const_iterator it = updateData.dungeons.begin(); it != updateData.dungeons.end(); ++it)
            data << uint32(*it);
        data << updateData.comment;
    }
    SendPacket(&data);
}

void WorldSession::SendLfgRoleChosen(uint64 guid, uint8 roles)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_ROLE_CHOSEN [" UI64FMTD "] guid: [" UI64FMTD "] roles: %u", GetPlayer()->GetGUID(), guid, roles);
#endif

    WorldPacket data(SMSG_LFG_ROLE_CHOSEN, 8 + 1 + 4);
    data << uint64(guid);                                  // Guid
    data << uint8(roles > 0);                              // Ready
    data << uint32(roles);                                 // Roles
    SendPacket(&data);
}

void WorldSession::SendLfgRoleCheckUpdate(lfg::LfgRoleCheck const& roleCheck)
{
    lfg::LfgDungeonSet dungeons;
    if (roleCheck.rDungeonId)
        dungeons.insert(roleCheck.rDungeonId);
    else
        dungeons = roleCheck.dungeons;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_ROLE_CHECK_UPDATE [" UI64FMTD "]", GetPlayer()->GetGUID());
#endif
    WorldPacket data(SMSG_LFG_ROLE_CHECK_UPDATE, 4 + 1 + 1 + dungeons.size() * 4 + 1 + roleCheck.roles.size() * (8 + 1 + 4 + 1));

    data << uint32(roleCheck.state);                       // Check result
    data << uint8(roleCheck.state == lfg::LFG_ROLECHECK_INITIALITING);
    data << uint8(dungeons.size());                        // Number of dungeons
    if (!dungeons.empty())
        for (lfg::LfgDungeonSet::iterator it = dungeons.begin(); it != dungeons.end(); ++it)
            data << uint32(sLFGMgr->GetLFGDungeonEntry(*it)); // Dungeon

    data << uint8(roleCheck.roles.size());                 // Players in group
    if (!roleCheck.roles.empty())
    {
        // Leader info MUST be sent 1st :S
        uint64 guid = roleCheck.leader;
        uint8 roles = roleCheck.roles.find(guid)->second;
        data << uint64(guid);                              // Guid
        data << uint8(roles > 0);                          // Ready
        data << uint32(roles);                             // Roles
        Player* player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid);
        data << uint8(player ? player->getLevel() : 0);    // Level

        for (lfg::LfgRolesMap::const_iterator it = roleCheck.roles.begin(); it != roleCheck.roles.end(); ++it)
        {
            if (it->first == roleCheck.leader)
                continue;

            guid = it->first;
            roles = it->second;
            data << uint64(guid);                          // Guid
            data << uint8(roles > 0);                      // Ready
            data << uint32(roles);                         // Roles
            player = ObjectAccessor::FindPlayerInOrOutOfWorld(guid);
            data << uint8(player ? player->getLevel() : 0);// Level
        }
    }
    SendPacket(&data);
}

void WorldSession::SendLfgJoinResult(lfg::LfgJoinResultData const& joinData)
{
    uint32 size = 0;
    for (lfg::LfgLockPartyMap::const_iterator it = joinData.lockmap.begin(); it != joinData.lockmap.end(); ++it)
        size += 8 + 4 + uint32(it->second.size()) * (4 + 4);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_JOIN_RESULT [" UI64FMTD "] checkResult: %u checkValue: %u", GetPlayer()->GetGUID(), joinData.result, joinData.state);
#endif
    WorldPacket data(SMSG_LFG_JOIN_RESULT, 4 + 4 + size);
    data << uint32(joinData.result);                       // Check Result
    data << uint32(joinData.state);                        // Check Value
    if (!joinData.lockmap.empty())
        BuildPartyLockDungeonBlock(data, joinData.lockmap);
    SendPacket(&data);
}

void WorldSession::SendLfgQueueStatus(lfg::LfgQueueStatusData const& queueData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_QUEUE_STATUS [" UI64FMTD "] dungeon: %u - waitTime: %d - avgWaitTime: %d - waitTimeTanks: %d - waitTimeHealer: %d - waitTimeDps: %d - queuedTime: %u - tanks: %u - healers: %u - dps: %u",
        GetPlayer()->GetGUID(), queueData.dungeonId, queueData.waitTime, queueData.waitTimeAvg, queueData.waitTimeTank, queueData.waitTimeHealer, queueData.waitTimeDps, queueData.queuedTime, queueData.tanks, queueData.healers, queueData.dps);
#endif
    WorldPacket data(SMSG_LFG_QUEUE_STATUS, 4 + 4 + 4 + 4 + 4 +4 + 1 + 1 + 1 + 4);
    data << uint32(queueData.dungeonId);                   // Dungeon
    data << int32(queueData.waitTimeAvg);                  // Average Wait time
    data << int32(queueData.waitTime);                     // Wait Time
    data << int32(queueData.waitTimeTank);                 // Wait Tanks
    data << int32(queueData.waitTimeHealer);               // Wait Healers
    data << int32(queueData.waitTimeDps);                  // Wait Dps
    data << uint8(queueData.tanks);                        // Tanks needed
    data << uint8(queueData.healers);                      // Healers needed
    data << uint8(queueData.dps);                          // Dps needed
    data << uint32(queueData.queuedTime);                  // Player wait time in queue
    SendPacket(&data);
}

void WorldSession::SendLfgPlayerReward(lfg::LfgPlayerRewardData const& rewardData)
{
    if (!rewardData.rdungeonEntry || !rewardData.sdungeonEntry || !rewardData.quest)
        return;

    sLog->outDebug(LOG_FILTER_LFG, "SMSG_LFG_PLAYER_REWARD %s rdungeonEntry: %u, sdungeonEntry: %u, done: %u",
        GetPlayerInfo().c_str(), rewardData.rdungeonEntry, rewardData.sdungeonEntry, rewardData.done);

    uint8 itemNum = rewardData.quest->GetRewItemsCount();

    WorldPacket data(SMSG_LFG_PLAYER_REWARD, 4 + 4 + 1 + 4 + 4 + 4 + 4 + 4 + 1 + itemNum * (4 + 4 + 4));
    data << uint32(rewardData.rdungeonEntry);              // Random Dungeon Finished
    data << uint32(rewardData.sdungeonEntry);              // Dungeon Finished
    data << uint8(rewardData.done);
    data << uint32(1);
    data << uint32(rewardData.quest->GetRewOrReqMoney());
    data << uint32(rewardData.quest->XPValue(GetPlayer()));
    data << uint32(0);
    data << uint32(0);
    data << uint8(itemNum);
    if (itemNum)
    {
        for (uint8 i = 0; i < QUEST_REWARDS_COUNT; ++i)
            if (uint32 itemId = rewardData.quest->RewardItemId[i])
            {
                ItemTemplate const* item = sObjectMgr->GetItemTemplate(itemId);
                data << uint32(itemId);
                data << uint32(item ? item->DisplayInfoID : 0);
                data << uint32(rewardData.quest->RewardItemIdCount[i]);
            }
    }
    SendPacket(&data);
}

void WorldSession::SendLfgBootProposalUpdate(lfg::LfgPlayerBoot const& boot)
{
    uint64 guid = GetPlayer()->GetGUID();
    lfg::LfgAnswer playerVote = boot.votes.find(guid)->second;
    uint8 votesNum = 0;
    uint8 agreeNum = 0;
    uint32 secsleft = boot.cancelTime - time(nullptr);
    for (lfg::LfgAnswerContainer::const_iterator it = boot.votes.begin(); it != boot.votes.end(); ++it)
    {
        if (it->second != lfg::LFG_ANSWER_PENDING)
        {
            ++votesNum;
            if (it->second == lfg::LFG_ANSWER_AGREE)
                ++agreeNum;
        }
    }
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_BOOT_PROPOSAL_UPDATE [" UI64FMTD "] inProgress: %u - didVote: %u - agree: %u - victim: [" UI64FMTD "] votes: %u - agrees: %u - left: %u - needed: %u - reason %s",
        guid, uint8(boot.inProgress), uint8(playerVote != lfg::LFG_ANSWER_PENDING), uint8(playerVote == lfg::LFG_ANSWER_AGREE), boot.victim, votesNum, agreeNum, secsleft, lfg::LFG_GROUP_KICK_VOTES_NEEDED, boot.reason.c_str());
#endif
    WorldPacket data(SMSG_LFG_BOOT_PROPOSAL_UPDATE, 1 + 1 + 1 + 8 + 4 + 4 + 4 + 4 + boot.reason.length());
    data << uint8(boot.inProgress);                        // Vote in progress
    data << uint8(playerVote != lfg::LFG_ANSWER_PENDING);       // Did Vote
    data << uint8(playerVote == lfg::LFG_ANSWER_AGREE);         // Agree
    data << uint64(boot.victim);                           // Victim GUID
    data << uint32(votesNum);                              // Total Votes
    data << uint32(agreeNum);                              // Agree Count
    data << uint32(secsleft);                              // Time Left
    data << uint32(lfg::LFG_GROUP_KICK_VOTES_NEEDED);           // Needed Votes
    data << boot.reason.c_str();                           // Kick reason
    SendPacket(&data);
}

void WorldSession::SendLfgUpdateProposal(lfg::LfgProposal const& proposal)
{
    uint64 guid = GetPlayer()->GetGUID();
    uint64 gguid = proposal.players.find(guid)->second.group;
    bool silent = !proposal.isNew && gguid == proposal.group;
    uint32 dungeonEntry = proposal.dungeonId;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_PROPOSAL_UPDATE [" UI64FMTD "] state: %u", guid, proposal.state);
#endif

    // show random dungeon if player selected random dungeon and it's not lfg group
    if (!silent)
    {
        lfg::LfgDungeonSet const& playerDungeons = sLFGMgr->GetSelectedDungeons(guid);
        if (playerDungeons.find(proposal.dungeonId) == playerDungeons.end())
            dungeonEntry = (*playerDungeons.begin());
    }

    dungeonEntry = sLFGMgr->GetLFGDungeonEntry(dungeonEntry);

    WorldPacket data(SMSG_LFG_PROPOSAL_UPDATE, 4 + 1 + 4 + 4 + 1 + 1 + proposal.players.size() * (4 + 1 + 1 + 1 + 1 +1));
    data << uint32(dungeonEntry);                          // Dungeon
    data << uint8(proposal.state);                         // Proposal state
    data << uint32(proposal.id);                           // Proposal ID
    data << uint32(proposal.encounters);                   // encounters done
    data << uint8(silent);                                 // Show proposal window
    data << uint8(proposal.players.size());                // Group size

    for (lfg::LfgProposalPlayerContainer::const_iterator it = proposal.players.begin(); it != proposal.players.end(); ++it)
    {
        lfg::LfgProposalPlayer const& player = it->second;
        data << uint32(player.role);                       // Role
        data << uint8(it->first == guid);                  // Self player
        if (!player.group)                                 // Player not it a group
        {
            data << uint8(0);                              // Not in dungeon
            data << uint8(0);                              // Not same group
        }
        else
        {
            data << uint8(player.group == proposal.group); // In dungeon (silent)
            data << uint8(player.group == gguid);          // Same Group than player
        }
        data << uint8(player.accept != lfg::LFG_ANSWER_PENDING);// Answered
        data << uint8(player.accept == lfg::LFG_ANSWER_AGREE);  // Accepted
    }
    SendPacket(&data);
}

void WorldSession::SendLfgLfrList(bool update)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_LFR_LIST [" UI64FMTD "] update: %u", GetPlayer()->GetGUID(), update ? 1 : 0);
#endif
    WorldPacket data(SMSG_LFG_UPDATE_SEARCH, 1);
    data << uint8(update);                                 // In Lfg Queue?
    SendPacket(&data);
}

void WorldSession::SendLfgDisabled()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_DISABLED [" UI64FMTD "]", GetPlayer()->GetGUID());
#endif
    WorldPacket data(SMSG_LFG_DISABLED, 0);
    SendPacket(&data);
}

void WorldSession::SendLfgOfferContinue(uint32 dungeonEntry)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_OFFER_CONTINUE [" UI64FMTD "] dungeon entry: %u", GetPlayer()->GetGUID(), dungeonEntry);
#endif
    WorldPacket data(SMSG_LFG_OFFER_CONTINUE, 4);
    data << uint32(dungeonEntry);
    SendPacket(&data);
}

void WorldSession::SendLfgTeleportError(uint8 err)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "SMSG_LFG_TELEPORT_DENIED [" UI64FMTD "] reason: %u", GetPlayer()->GetGUID(), err);
#endif
    WorldPacket data(SMSG_LFG_TELEPORT_DENIED, 4);
    data << uint32(err);                                   // Error
    SendPacket(&data);
}
