/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "DisableMgr.h"
#include "Group.h"
#include "Language.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleBattlemasterHelloOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    recvData >> guid;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Recvd CMSG_BATTLEMASTER_HELLO Message from (%s)", guid.ToString().c_str());
#endif

    Creature* unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit)
        return;

    if (!unit->IsBattleMaster())                             // it's not battlemaster
        return;

    // Stop the npc if moving
    unit->StopMoving();

    BattlegroundTypeId bgTypeId = sBattlegroundMgr->GetBattleMasterBG(unit->GetEntry());

    if (!_player->GetBGAccessByLevel(bgTypeId))
    {
        // temp, must be gossip message...
        SendNotification(LANG_YOUR_BG_LEVEL_REQ_ERROR);
        return;
    }

    SendBattleGroundList(guid, bgTypeId);
}

void WorldSession::SendBattleGroundList(ObjectGuid guid, BattlegroundTypeId bgTypeId)
{
    WorldPacket data;
    sBattlegroundMgr->BuildBattlegroundListPacket(&data, guid, _player, bgTypeId, 0);
    SendPacket(&data);
}

void WorldSession::HandleBattlemasterJoinOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    uint32 bgTypeId_;
    uint32 instanceId;                                     // sent to queue for particular bg from battlemaster's list, currently not used
    uint8 joinAsGroup;

    recvData >> guid;                                      // battlemaster guid
    recvData >> bgTypeId_;                                 // battleground type id (DBC id)
    recvData >> instanceId;                                // instance id, 0 if First Available selected
    recvData >> joinAsGroup;                               // join as group

    // entry not found
    if (!sBattlemasterListStore.LookupEntry(bgTypeId_))
        return;

    // chosen battleground type is disabled
    if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, bgTypeId_, nullptr))
    {
        ChatHandler(this).PSendSysMessage(LANG_BG_DISABLED);
        return;
    }

    // get queue typeid and random typeid to check if already queued for them
    BattlegroundTypeId bgTypeId = BattlegroundTypeId(bgTypeId_);
    BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, 0);
    BattlegroundQueueTypeId bgQueueTypeIdRandom = BattlegroundMgr::BGQueueTypeId(BATTLEGROUND_RB, 0);

    // safety check - bgQueueTypeId == BATTLEGROUND_QUEUE_NONE if tried to queue for arena using this function
    if (bgQueueTypeId == BATTLEGROUND_QUEUE_NONE)
        return;

    // get bg template
    Battleground* bgt = sBattlegroundMgr->GetBattlegroundTemplate(bgTypeId);
    if (!bgt)
        return;

    // expected bracket entry
    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bgt->GetMapId(), _player->getLevel());
    if (!bracketEntry)
        return;

    // pussywizard: if trying to queue for already queued
    // just remove from queue and it will requeue!
    uint32 qSlot = _player->GetBattlegroundQueueIndex(bgQueueTypeId);
    if (qSlot < PLAYER_MAX_BATTLEGROUND_QUEUES)
    {
        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);

        if (bgQueue.IsPlayerInvitedToRatedArena(_player->GetGUID()))
        {
            WorldPacket data;
            sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_BATTLEGROUND_JOIN_FAILED);
            SendPacket(&data);
            return;
        }

        bgQueue.RemovePlayer(_player->GetGUID(), false, qSlot);
        _player->RemoveBattlegroundQueueId(bgQueueTypeId);
    }

    // must have free queue slot
    if (!_player->HasFreeBattlegroundQueueId())
    {
        WorldPacket data;
        sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_BATTLEGROUND_TOO_MANY_QUEUES);
        SendPacket(&data);
        return;
    }

    // queue result (default ok)
    GroupJoinBattlegroundResult err = GroupJoinBattlegroundResult(bgt->GetBgTypeID());

    if (!sScriptMgr->CanJoinInBattlegroundQueue(_player, guid, bgTypeId, joinAsGroup, err) && err <= 0)
    {
        WorldPacket data;
        sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
        SendPacket(&data);
        return;
    }

    // check if player can queue:
    if (!joinAsGroup)
    {
        if (GetPlayer()->InBattleground()) // currently in battleground
            err = ERR_BATTLEGROUND_NOT_IN_BATTLEGROUND;
        else if (GetPlayer()->isUsingLfg()) // using lfg system
            err = ERR_LFG_CANT_USE_BATTLEGROUND;
        else if (!_player->CanJoinToBattleground()) // has deserter debuff
            err = ERR_GROUP_JOIN_BATTLEGROUND_DESERTERS;
        else if (_player->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeIdRandom)) // queued for random bg, so can't queue for anything else
            err = ERR_IN_RANDOM_BG;
        else if (_player->InBattlegroundQueue() && bgTypeId == BATTLEGROUND_RB) // already in queue, so can't queue for random
            err = ERR_IN_NON_RANDOM_BG;
        else if (_player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_2v2) ||
                 _player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3) ||
                 _player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_5v5)) // can't be already queued for arenas
            err = ERR_BATTLEGROUND_QUEUED_FOR_RATED;
        // don't let Death Knights join BG queues when they are not allowed to be teleported yet
        else if (_player->getClass() == CLASS_DEATH_KNIGHT && _player->GetMapId() == 609 && !_player->IsGameMaster() && !_player->HasSpell(50977))
            err = ERR_BATTLEGROUND_NONE;

        if (err <= 0)
        {
            WorldPacket data;
            sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
            SendPacket(&data);
            return;
        }

        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
        GroupQueueInfo* ginfo = bgQueue.AddGroup(_player, nullptr, bracketEntry, false, false, 0, 0, 0);
        uint32 avgWaitTime = bgQueue.GetAverageQueueWaitTime(ginfo);

        uint32 queueSlot = _player->AddBattlegroundQueueId(bgQueueTypeId);

        // send status packet
        WorldPacket data;
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bgt, queueSlot, STATUS_WAIT_QUEUE, avgWaitTime, 0, 0, TEAM_NEUTRAL);
        SendPacket(&data);

        sScriptMgr->OnPlayerJoinBG(_player);
    }
    // check if group can queue:
    else
    {
        Group* grp = _player->GetGroup();
        // no group or not a leader
        if (!grp || grp->GetLeaderGUID() != _player->GetGUID())
            return;

        // pussywizard: for party members - remove queues for which leader is not queued to!
        std::set<uint32> leaderQueueTypeIds;
        for (uint32 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
            leaderQueueTypeIds.insert((uint32)_player->GetBattlegroundQueueTypeId(i));
        for (GroupReference* itr = grp->GetFirstMember(); itr != nullptr; itr = itr->next())
            if (Player* member = itr->GetSource())
                for (uint32 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
                    if (BattlegroundQueueTypeId mqtid = member->GetBattlegroundQueueTypeId(i))
                        if (leaderQueueTypeIds.count((uint32)mqtid) == 0)
                        {
                            BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(mqtid);

                            if (bgQueue.IsPlayerInvitedToRatedArena(member->GetGUID()))
                            {
                                WorldPacket data;
                                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_BATTLEGROUND_JOIN_FAILED);
                                SendPacket(&data);
                                return;
                            }

                            bgQueue.RemovePlayer(member->GetGUID(), false, i);
                            member->RemoveBattlegroundQueueId(mqtid);
                        }

        if (_player->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeIdRandom)) // queued for random bg, so can't queue for anything else
            err = ERR_IN_RANDOM_BG;
        else if (_player->InBattlegroundQueue() && bgTypeId == BATTLEGROUND_RB) // already in queue, so can't queue for random
            err = ERR_IN_NON_RANDOM_BG;
        else if (_player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_2v2) ||
                 _player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3) ||
                 _player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_5v5)) // can't be already queued for arenas
            err = ERR_BATTLEGROUND_QUEUED_FOR_RATED;

        if (err > 0)
            err = grp->CanJoinBattlegroundQueue(bgt, bgQueueTypeId, 0, bgt->GetMaxPlayersPerTeam(), false, 0);

        bool isPremade = (grp->GetMembersCount() >= bgt->GetMinPlayersPerTeam() && bgTypeId != BATTLEGROUND_RB);
        uint32 avgWaitTime = 0;

        if (err > 0)
        {
            BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
            GroupQueueInfo* ginfo = bgQueue.AddGroup(_player, grp, bracketEntry, false, isPremade, 0, 0, 0);
            avgWaitTime = bgQueue.GetAverageQueueWaitTime(ginfo);
        }

        WorldPacket data;
        for (GroupReference* itr = grp->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* member = itr->GetSource();
            if (!member)
                continue;

            if (err <= 0)
            {
                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
                member->GetSession()->SendPacket(&data);
                continue;
            }

            uint32 queueSlot = member->AddBattlegroundQueueId(bgQueueTypeId);

            // send status packet
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bgt, queueSlot, STATUS_WAIT_QUEUE, avgWaitTime, 0, 0, TEAM_NEUTRAL);
            member->GetSession()->SendPacket(&data);

            sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
            member->GetSession()->SendPacket(&data);

            sScriptMgr->OnPlayerJoinBG(member);
        }
    }
}

void WorldSession::HandleBattlegroundPlayerPositionsOpcode(WorldPacket& /*recvData*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Recvd MSG_BATTLEGROUND_PLAYER_POSITIONS Message");
#endif

    Battleground* bg = _player->GetBattleground();
    if (!bg)                                                 // can't be received if player not in battleground
        return;

    uint32 flagCarrierCount = 0;
    Player* allianceFlagCarrier = nullptr;
    Player* hordeFlagCarrier = nullptr;

    if (ObjectGuid guid = bg->GetFlagPickerGUID(TEAM_ALLIANCE))
    {
        allianceFlagCarrier = ObjectAccessor::FindPlayer(guid);
        if (allianceFlagCarrier)
            ++flagCarrierCount;
    }

    if (ObjectGuid guid = bg->GetFlagPickerGUID(TEAM_HORDE))
    {
        hordeFlagCarrier = ObjectAccessor::FindPlayer(guid);
        if (hordeFlagCarrier)
            ++flagCarrierCount;
    }

    WorldPacket data(MSG_BATTLEGROUND_PLAYER_POSITIONS, 4 + 4 + 16 * flagCarrierCount);
    // Used to send several player positions (found used in AV)
    data << 0;  // CGBattlefieldInfo__m_numPlayerPositions
    /*
    for (CGBattlefieldInfo__m_numPlayerPositions)
        data << guid << posx << posy;
    */
    data << flagCarrierCount;
    if (allianceFlagCarrier)
    {
        data << allianceFlagCarrier->GetGUID();
        data << float(allianceFlagCarrier->GetPositionX());
        data << float(allianceFlagCarrier->GetPositionY());
    }

    if (hordeFlagCarrier)
    {
        data << hordeFlagCarrier->GetGUID();
        data << float(hordeFlagCarrier->GetPositionX());
        data << float(hordeFlagCarrier->GetPositionY());
    }

    SendPacket(&data);
}

void WorldSession::HandlePVPLogDataOpcode(WorldPacket& /*recvData*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Recvd MSG_PVP_LOG_DATA Message");
#endif

    Battleground* bg = _player->GetBattleground();
    if (!bg)
        return;

    // Prevent players from sending BuildPvpLogDataPacket in an arena except for when sent in BattleGround::EndBattleGround.
    if (bg->isArena())
        return;

    WorldPacket data;
    sBattlegroundMgr->BuildPvpLogDataPacket(&data, bg);
    SendPacket(&data);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Sent MSG_PVP_LOG_DATA Message");
#endif
}

void WorldSession::HandleBattlefieldListOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Recvd CMSG_BATTLEFIELD_LIST Message");
#endif

    uint32 bgTypeId;
    recvData >> bgTypeId;                                  // id from DBC

    uint8 fromWhere;
    recvData >> fromWhere;                                 // 0 - battlemaster (lua: ShowBattlefieldList), 1 - UI (lua: RequestBattlegroundInstanceInfo)

    uint8 canGainXP;
    recvData >> canGainXP;                                 // players with locked xp have their own bg queue on retail

    BattlemasterListEntry const* bl = sBattlemasterListStore.LookupEntry(bgTypeId);
    if (!bl)
        return;

    WorldPacket data;
    sBattlegroundMgr->BuildBattlegroundListPacket(&data, ObjectGuid::Empty, _player, BattlegroundTypeId(bgTypeId), fromWhere);
    SendPacket(&data);
}

void WorldSession::HandleBattleFieldPortOpcode(WorldPacket& recvData)
{
    uint8 arenaType;                                        // arenatype if arena
    uint8 unk2;                                             // unk, can be 0x0 (may be if was invited?) and 0x1
    uint32 bgTypeId_;                                       // type id from dbc
    uint16 unk;                                             // 0x1F90 constant?
    uint8 action;                                           // enter battle 0x1, leave queue 0x0

    recvData >> arenaType >> unk2 >> bgTypeId_ >> unk >> action;

    // bgTypeId not valid
    if (!sBattlemasterListStore.LookupEntry(bgTypeId_))
        return;

    // player not in any queue, so can't really answer
    if (!_player->InBattlegroundQueue())
        return;

    // get BattlegroundQueue for received
    BattlegroundTypeId bgTypeId = BattlegroundTypeId(bgTypeId_);
    BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, arenaType);
    BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);

    if (!sScriptMgr->CanBattleFieldPort(_player, arenaType, bgTypeId, action))
        return;

    // get group info from queue
    GroupQueueInfo ginfo;
    if (!bgQueue.GetPlayerGroupInfoData(_player->GetGUID(), &ginfo))
        return;

    // to accept, player must be invited to particular battleground id
    if (!ginfo.IsInvitedToBGInstanceGUID && action == 1)
        return;

    Battleground* bg = sBattlegroundMgr->GetBattleground(ginfo.IsInvitedToBGInstanceGUID);

    // use template if leaving queue (instance might not be created yet)
    if (!bg && action == 0)
        bg = sBattlegroundMgr->GetBattlegroundTemplate(bgTypeId);

    if (!bg)
        return;

    // expected bracket entry
    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), _player->getLevel());
    if (!bracketEntry)
        return;

    // safety checks
    if (action == 1 && ginfo.ArenaType == 0)
    {
        // can't join with deserter, check it here right before joining to be sure
        if (!_player->CanJoinToBattleground())
        {
            WorldPacket data;
            sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_GROUP_JOIN_BATTLEGROUND_DESERTERS);
            SendPacket(&data);
            action = 0;
        }

        if (_player->getLevel() > bg->GetMaxLevel())
            action = 0;
    }

    // get player queue slot index for this bg (can be in up to 2 queues at the same time)
    uint32 queueSlot = _player->GetBattlegroundQueueIndex(bgQueueTypeId);

    WorldPacket data;
    switch (action)
    {
        case 1: // accept
            {
                // set entry point if not in battleground
                if (!_player->InBattleground())
                    _player->SetEntryPoint();

                // resurrect the player
                if (!_player->IsAlive())
                {
                    _player->ResurrectPlayer(1.0f);
                    _player->SpawnCorpseBones();
                }

                TeamId teamId = ginfo.teamId;

                // remove player from all bg queues
                for (uint32 qslot = 0; qslot < PLAYER_MAX_BATTLEGROUND_QUEUES; ++qslot)
                    if (BattlegroundQueueTypeId q = _player->GetBattlegroundQueueTypeId(qslot))
                    {
                        BattlegroundQueue& queue = sBattlegroundMgr->GetBattlegroundQueue(q);
                        queue.RemovePlayer(_player->GetGUID(), (bgQueueTypeId == q), qslot);
                        _player->RemoveBattlegroundQueueId(q);
                    }

                // send status packet
                sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_IN_PROGRESS, 0, bg->GetStartTime(), bg->GetArenaType(), teamId);
                SendPacket(&data);

                _player->SetBattlegroundId(bg->GetInstanceID(), bg->GetBgTypeID(), queueSlot, true, bgTypeId == BATTLEGROUND_RB, teamId);

                sBattlegroundMgr->SendToBattleground(_player, ginfo.IsInvitedToBGInstanceGUID, bgTypeId);
            }
            break;
        case 0: // leave queue
            {
                bgQueue.RemovePlayer(_player->GetGUID(), false, queueSlot);
                _player->RemoveBattlegroundQueueId(bgQueueTypeId);
                // track if player refuses to join the BG after being invited
                if (bg->isBattleground() && (bg->GetStatus() == STATUS_IN_PROGRESS || bg->GetStatus() == STATUS_WAIT_JOIN))
                {
                    if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_TRACK_DESERTERS))
                    {
                        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_DESERTER_TRACK);
                        stmt->setUInt32(0, _player->GetGUID().GetCounter());
                        stmt->setUInt8(1, BG_DESERTION_TYPE_LEAVE_QUEUE);
                        CharacterDatabase.Execute(stmt);
                    }

                    sScriptMgr->OnBattlegroundDesertion(_player, BG_DESERTION_TYPE_LEAVE_QUEUE);
                }
            }
            break;
        default:
            break;
    }
}

void WorldSession::HandleBattlefieldLeaveOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Recvd CMSG_LEAVE_BATTLEFIELD Message");
#endif

    recvData.read_skip<uint8>();                           // unk1
    recvData.read_skip<uint8>();                           // unk2
    recvData.read_skip<uint32>();                          // BattlegroundTypeId
    recvData.read_skip<uint16>();                          // unk3

    // not allow leave battleground in combat
    if (_player->IsInCombat())
        if (Battleground* bg = _player->GetBattleground())
            if (bg->GetStatus() != STATUS_WAIT_LEAVE)
                return;

    _player->LeaveBattleground();
}

void WorldSession::HandleBattlefieldStatusOpcode(WorldPacket& /*recvData*/)
{
    // requested at login and on map change
    // send status for current queues and current bg

    WorldPacket data;

    // for current bg send STATUS_IN_PROGRESS
    if (Battleground* bg = _player->GetBattleground())
        if (bg->GetPlayers().count(_player->GetGUID()))
        {
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, _player->GetCurrentBattlegroundQueueSlot(), STATUS_IN_PROGRESS, bg->GetEndTime(), bg->GetStartTime(), bg->GetArenaType(), _player->GetBgTeamId());
            SendPacket(&data);
        }

    // for queued bgs send STATUS_WAIT_JOIN or STATUS_WAIT_QUEUE
    for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
    {
        // check if in queue
        BattlegroundQueueTypeId bgQueueTypeId = _player->GetBattlegroundQueueTypeId(i);
        if (!bgQueueTypeId)
            continue;

        // get group info from queue
        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
        GroupQueueInfo ginfo;
        if (!bgQueue.GetPlayerGroupInfoData(_player->GetGUID(), &ginfo))
            continue;

        BattlegroundTypeId bgTypeId = BattlegroundMgr::BGTemplateId(bgQueueTypeId);

        // if invited - send STATUS_WAIT_JOIN
        if (ginfo.IsInvitedToBGInstanceGUID)
        {
            Battleground* bg = sBattlegroundMgr->GetBattleground(ginfo.IsInvitedToBGInstanceGUID);
            if (!bg)
                continue;

            uint32 remainingTime = (World::GetGameTimeMS() < ginfo.RemoveInviteTime ? getMSTimeDiff(World::GetGameTimeMS(), ginfo.RemoveInviteTime) : 1);
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, i, STATUS_WAIT_JOIN, remainingTime, 0, ginfo.ArenaType, TEAM_NEUTRAL, bg->isRated(), ginfo.BgTypeId);
            SendPacket(&data);
        }
        // if not invited - send STATUS_WAIT_QUEUE
        else
        {
            Battleground* bgt = sBattlegroundMgr->GetBattlegroundTemplate(bgTypeId);
            if (!bgt)
                continue;

            // expected bracket entry
            PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bgt->GetMapId(), _player->getLevel());
            if (!bracketEntry)
                continue;

            uint32 avgWaitTime = bgQueue.GetAverageQueueWaitTime(&ginfo);
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bgt, i, STATUS_WAIT_QUEUE, avgWaitTime, getMSTimeDiff(ginfo.JoinTime, World::GetGameTimeMS()), ginfo.ArenaType, TEAM_NEUTRAL, ginfo.IsRated);
            SendPacket(&data);
        }
    }
}

void WorldSession::HandleBattlemasterJoinArena(WorldPacket& recvData)
{
    ObjectGuid guid;                                            // arena Battlemaster guid
    uint8 arenaslot;                                        // 2v2, 3v3 or 5v5
    uint8 asGroup;                                          // asGroup
    uint8 isRated;                                          // isRated

    recvData >> guid >> arenaslot >> asGroup >> isRated;

    // can't queue for rated without a group
    if (isRated && !asGroup)
        return;

    // find creature by guid
    Creature* unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit || !unit->IsBattleMaster())
        return;

    // get arena type
    uint8 arenatype = 0;
    switch (arenaslot)
    {
        case 0:
            arenatype = ARENA_TYPE_2v2;
            break;
        case 1:
            arenatype = ARENA_TYPE_3v3;
            break;
        case 2:
            arenatype = ARENA_TYPE_5v5;
            break;
        default:
            return;
    }

    // get template for all arenas
    Battleground* bgt = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA);
    if (!bgt)
        return;

    // arenas disabled
    if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, BATTLEGROUND_AA, nullptr))
    {
        ChatHandler(this).PSendSysMessage(LANG_ARENA_DISABLED);
        return;
    }

    BattlegroundTypeId bgTypeId = bgt->GetBgTypeID();
    BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, arenatype);

    // expected bracket entry
    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bgt->GetMapId(), _player->getLevel());
    if (!bracketEntry)
        return;

    // pussywizard: if trying to queue for already queued
    // just remove from queue and it will requeue!
    uint32 qSlot = _player->GetBattlegroundQueueIndex(bgQueueTypeId);
    if (qSlot < PLAYER_MAX_BATTLEGROUND_QUEUES)
    {
        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);

        if (bgQueue.IsPlayerInvitedToRatedArena(_player->GetGUID()))
        {
            WorldPacket data;
            sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_BATTLEGROUND_JOIN_FAILED);
            SendPacket(&data);
            return;
        }

        bgQueue.RemovePlayer(_player->GetGUID(), false, qSlot);
        _player->RemoveBattlegroundQueueId(bgQueueTypeId);
    }

    // must have free queue slot
    // pussywizard: allow being queued only in one arena queue, and it even cannot be together with bg queues
    if (_player->InBattlegroundQueue())
    {
        WorldPacket data;
        sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_BATTLEGROUND_CANNOT_QUEUE_FOR_RATED);
        SendPacket(&data);
        return;
    }

    // queue result (default ok)
    GroupJoinBattlegroundResult err = GroupJoinBattlegroundResult(bgt->GetBgTypeID());

    if (!sScriptMgr->CanJoinInArenaQueue(_player, guid, arenaslot, bgTypeId, asGroup, isRated, err) && err <= 0)
    {
        WorldPacket data;
        sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
        SendPacket(&data);
        return;
    }

    // check if player can queue:
    if (!asGroup)
    {
        if (GetPlayer()->InBattleground()) // currently in battleground
            err = ERR_BATTLEGROUND_NOT_IN_BATTLEGROUND;
        else if (GetPlayer()->isUsingLfg()) // using lfg system
            err = ERR_LFG_CANT_USE_BATTLEGROUND;

        if (err <= 0)
        {
            WorldPacket data;
            sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
            SendPacket(&data);
            return;
        }

        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
        GroupQueueInfo* ginfo = bgQueue.AddGroup(_player, nullptr, bracketEntry, false, false, 0, 0, 0);
        uint32 avgWaitTime = bgQueue.GetAverageQueueWaitTime(ginfo);

        uint32 queueSlot = _player->AddBattlegroundQueueId(bgQueueTypeId);

        WorldPacket data;
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bgt, queueSlot, STATUS_WAIT_QUEUE, avgWaitTime, 0, arenatype, TEAM_NEUTRAL);
        SendPacket(&data);

        sScriptMgr->OnPlayerJoinArena(_player);
    }
    // check if group can queue:
    else
    {
        Group* grp = _player->GetGroup();
        // no group or not a leader
        if (!grp || grp->GetLeaderGUID() != _player->GetGUID())
            return;

        // pussywizard: for party members - remove queues for which leader is not queued to!
        std::set<uint32> leaderQueueTypeIds;
        for (uint32 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
            leaderQueueTypeIds.insert((uint32)_player->GetBattlegroundQueueTypeId(i));
        for (GroupReference* itr = grp->GetFirstMember(); itr != nullptr; itr = itr->next())
            if (Player* member = itr->GetSource())
                for (uint32 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
                    if (BattlegroundQueueTypeId mqtid = member->GetBattlegroundQueueTypeId(i))
                        if (leaderQueueTypeIds.count((uint32)mqtid) == 0)
                        {
                            BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(mqtid);

                            if (bgQueue.IsPlayerInvitedToRatedArena(member->GetGUID()))
                            {
                                WorldPacket data;
                                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_BATTLEGROUND_JOIN_FAILED);
                                SendPacket(&data);
                                return;
                            }

                            bgQueue.RemovePlayer(member->GetGUID(), false, i);
                            member->RemoveBattlegroundQueueId(mqtid);
                        }

        uint32 ateamId = 0;
        uint32 arenaRating = 0;
        uint32 matchmakerRating = 0;

        // additional checks for rated arenas
        if (isRated)
        {
            // pussywizard: for rated matches check if season is in progress!
            if (!sWorld->getBoolConfig(CONFIG_ARENA_SEASON_IN_PROGRESS))
                return;

            ateamId = _player->GetArenaTeamId(arenaslot);

            // check team existence
            ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(ateamId);
            if (!at)
            {
                SendNotInArenaTeamPacket(arenatype);
                return;
            }

            // get team rating for queueing
            arenaRating = at->GetRating();
            matchmakerRating = at->GetAverageMMR(grp);
            if (arenaRating <= 0)
                arenaRating = 1;
        }

        err = grp->CanJoinBattlegroundQueue(bgt, bgQueueTypeId, arenatype, arenatype, (bool)isRated, arenaslot);

        uint32 avgWaitTime = 0;
        if (err > 0)
        {
            BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
            GroupQueueInfo* ginfo = bgQueue.AddGroup(_player, grp, bracketEntry, isRated, false, arenaRating, matchmakerRating, ateamId);
            avgWaitTime = bgQueue.GetAverageQueueWaitTime(ginfo);
        }

        WorldPacket data;
        for (GroupReference* itr = grp->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* member = itr->GetSource();
            if (!member)
                continue;

            if (err <= 0)
            {
                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
                member->GetSession()->SendPacket(&data);
                continue;
            }

            uint32 queueSlot = member->AddBattlegroundQueueId(bgQueueTypeId);

            // send status packet
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bgt, queueSlot, STATUS_WAIT_QUEUE, avgWaitTime, 0, arenatype, TEAM_NEUTRAL, isRated);
            member->GetSession()->SendPacket(&data);

            sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
            member->GetSession()->SendPacket(&data);

            sScriptMgr->OnPlayerJoinArena(member);
        }

        // pussywizard: schedule update for rated arena
        if (ateamId)
            sBattlegroundMgr->ScheduleArenaQueueUpdate(ateamId, bgQueueTypeId, bracketEntry->GetBracketId());
    }
}

void WorldSession::HandleReportPvPAFK(WorldPacket& recvData)
{
    ObjectGuid playerGuid;
    recvData >> playerGuid;
    Player* reportedPlayer = ObjectAccessor::FindPlayer(playerGuid);

    if (!reportedPlayer)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("bg.battleground", "WorldSession::HandleReportPvPAFK: player not found");
#endif
        return;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("bg.battleground", "WorldSession::HandleReportPvPAFK: %s reported %s", _player->GetName().c_str(), reportedPlayer->GetName().c_str());
#endif

    reportedPlayer->ReportedAfkBy(_player);
}
