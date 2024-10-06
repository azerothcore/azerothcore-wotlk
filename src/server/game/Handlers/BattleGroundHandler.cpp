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

#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "DisableMgr.h"
#include "GameTime.h"
#include "Group.h"
#include "LFGMgr.h"
#include "Language.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "WorldPacket.h"
#include "WorldSession.h"

//npcbot
#include "botdatamgr.h"
#include "botmgr.h"
//end npcbot

void WorldSession::HandleBattlemasterHelloOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    recvData >> guid;
    LOG_DEBUG("network", "WORLD: Recvd CMSG_BATTLEMASTER_HELLO Message from ({})", guid.ToString());

    Creature* unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit)
        return;

    if (!unit->IsBattleMaster())                             // it's not battlemaster
        return;

    // Stop the npc if moving
    if (uint32 pause = unit->GetMovementTemplate().GetInteractionPauseTimer())
        unit->PauseMovement(pause);
    unit->SetHomePosition(unit->GetPosition());

    BattlegroundTypeId bgTypeId = sBattlegroundMgr->GetBattleMasterBG(unit->GetEntry());

    if (!_player->GetBGAccessByLevel(bgTypeId))
    {
        // temp, must be gossip message...
        ChatHandler(this).SendNotification(LANG_YOUR_BG_LEVEL_REQ_ERROR);
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
    uint32 instanceId;
    uint8 joinAsGroup;
    bool isPremade = false;

    recvData >> guid;                                      // battlemaster guid
    recvData >> bgTypeId_;                                 // battleground type id (DBC id)
    recvData >> instanceId;                                // instance id, 0 if First Available selected
    recvData >> joinAsGroup;                               // join as group

    // entry not found
    if (!sBattlemasterListStore.LookupEntry(bgTypeId_))
    {
        LOG_ERROR("network", "Battleground: invalid bgtype ({}) received. possible cheater? player {}", bgTypeId_, _player->GetGUID().ToString());
        return;
    }

    // chosen battleground type is disabled
    if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, bgTypeId_, nullptr))
    {
        ChatHandler(this).PSendSysMessage(LANG_BG_DISABLED);
        return;
    }

    LOG_DEBUG("network", "WORLD: Recvd CMSG_BATTLEMASTER_JOIN Message from {}", guid.ToString());

    // get queue typeid and random typeid to check if already queued for them
    BattlegroundTypeId bgTypeId = BattlegroundTypeId(bgTypeId_);
    BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, 0);
    BattlegroundQueueTypeId bgQueueTypeIdRandom = BattlegroundMgr::BGQueueTypeId(BATTLEGROUND_RB, 0);

    // safety check - bgQueueTypeId == BATTLEGROUND_QUEUE_NONE if tried to queue for arena using this function
    if (bgQueueTypeId == BATTLEGROUND_QUEUE_NONE)
        return;

    // ignore if player is already in BG
    if (_player->InBattleground())
        return;

    // get bg instance or bg template if instance not found
    Battleground* bg = nullptr;
    if (instanceId)
        bg = sBattlegroundMgr->GetBattlegroundThroughClientInstance(instanceId, bgTypeId);

    if (!bg)
        bg = sBattlegroundMgr->GetBattlegroundTemplate(bgTypeId);

    if (!bg)
        return;

    // expected bracket entry
    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), _player->GetLevel());
    if (!bracketEntry)
        return;

    // must have free queue slot
    if (!_player->HasFreeBattlegroundQueueId())
    {
        WorldPacket data;
        sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_BATTLEGROUND_TOO_MANY_QUEUES);
        SendPacket(&data);
        return;
    }

    // queue result (default ok)
    GroupJoinBattlegroundResult err = GroupJoinBattlegroundResult(bg->GetBgTypeID());

    if (!sScriptMgr->CanJoinInBattlegroundQueue(_player, guid, bgTypeId, joinAsGroup, err) && err <= 0)
    {
        WorldPacket data;
        sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
        SendPacket(&data);
        return;
    }

    BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);

    // check if player can queue:
    if (!joinAsGroup)
    {
        lfg::LfgState lfgState = sLFGMgr->GetState(GetPlayer()->GetGUID());
        if (GetPlayer()->InBattleground()) // currently in battleground
        {
            err = ERR_BATTLEGROUND_NOT_IN_BATTLEGROUND;
        }
        else if (lfgState > lfg::LFG_STATE_NONE && (lfgState != lfg::LFG_STATE_QUEUED || !sWorld->getBoolConfig(CONFIG_ALLOW_JOIN_BG_AND_LFG))) // using lfg system
        {
            err = ERR_LFG_CANT_USE_BATTLEGROUND;
        }
        else if (!_player->CanJoinToBattleground()) // has deserter debuff
        {
            err = ERR_GROUP_JOIN_BATTLEGROUND_DESERTERS;
        }
        else if (_player->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeIdRandom)) // queued for random bg, so can't queue for anything else
        {
            err = ERR_IN_RANDOM_BG;
        }
        else if (_player->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeId)) // queued for this bg
        {
            err = ERR_BATTLEGROUND_NONE;
        }
        else if (_player->InBattlegroundQueue() && bgTypeId == BATTLEGROUND_RB) // already in queue, so can't queue for random
        {
            err = ERR_IN_NON_RANDOM_BG;
        }
        else if (_player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_2v2) ||
            _player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3) ||
            _player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_5v5)) // can't be already queued for arenas
        {
            err = ERR_BATTLEGROUND_QUEUED_FOR_RATED;
        }
        // don't let Death Knights join BG queues when they are not allowed to be teleported yet
        else if (_player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_TELEPORT) && _player->GetMapId() == 609 && !_player->IsGameMaster() && !_player->HasSpell(50977))
        {
            err = ERR_BATTLEGROUND_NONE;
        }
        else if (!_player->GetBGAccessByLevel(bgTypeId))
        {
            err = ERR_BATTLEGROUND_NONE;
        }

        if (err <= 0)
        {
            WorldPacket data;
            sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
            SendPacket(&data);
            return;
        }

        //npcbot: do not allow entering as group if there are bots in group
        if (_player->GetGroup() && _player->HaveBot())
        {
            for (auto const& mslot : _player->GetGroup()->GetMemberSlots())
            {
                if (mslot.guid.IsCreature() && _player->GetBotMgr()->GetBot(mslot.guid))
                {
                    WorldPacket data;
                    sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_BATTLEGROUND_JOIN_FAILED);
                    _player->SendDirectMessage(&data);
                    return;
                }
            }
        }
        //end npcbot

        GroupQueueInfo* ginfo = bgQueue.AddGroup(_player, nullptr, bgTypeId, bracketEntry, 0, false, isPremade, 0, 0);
        uint32 avgWaitTime = bgQueue.GetAverageQueueWaitTime(ginfo);
        uint32 queueSlot = _player->AddBattlegroundQueueId(bgQueueTypeId);

        // send status packet
        WorldPacket data;
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_QUEUE, avgWaitTime, 0, 0, TEAM_NEUTRAL);
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

        grp->DoForAllMembers([&err, bgQueueTypeId, bgQueueTypeIdRandom, bgTypeId](Player* member)
        {
            if (member->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeIdRandom)) // queued for random bg, so can't queue for anything else
            {
                err = ERR_IN_RANDOM_BG;
            }
            else if (member->InBattlegroundQueue() && bgTypeId == BATTLEGROUND_RB) // already in queue, so can't queue for random
            {
                err = ERR_IN_NON_RANDOM_BG;
            }
            else if (member->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_2v2) ||
                member->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3) ||
                member->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_5v5)) // can't be already queued for arenas
            {
                err = ERR_BATTLEGROUND_QUEUED_FOR_RATED;
            }
            else if (member->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeId)) // queued for this bg
            {
                err = ERR_BATTLEGROUND_NONE;
            }
            else if (!member->GetBGAccessByLevel(bgTypeId))
            {
                err = ERR_BATTLEGROUND_JOIN_TIMED_OUT;
            }

            if (err < 0)
            {
                return;
            }
        });

        if (err)
        {
            err = grp->CanJoinBattlegroundQueue(bg, bgQueueTypeId, 0, bg->GetMaxPlayersPerTeam(), false, 0);
        }

        if (err <= 0)
        {
            grp->DoForAllMembers([err](Player* member)
            {
                WorldPacket data;
                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
                member->GetSession()->SendPacket(&data);
            });

            return;
        }

        isPremade = (grp->GetMembersCount() >= bg->GetMinPlayersPerTeam() && bgTypeId != BATTLEGROUND_RB);
        //npcbot: check premade for bots
        if (isPremade && !BotMgr::IsNpcBotsPremadeEnabled() && grp->GetFirstBotMember() != nullptr)
            isPremade = false;
        //end npcbot
        uint32 avgWaitTime = 0;

        GroupQueueInfo* ginfo = bgQueue.AddGroup(_player, grp, bgTypeId, bracketEntry, 0, false, isPremade, 0, 0);
        avgWaitTime = bgQueue.GetAverageQueueWaitTime(ginfo);

        grp->DoForAllMembers([bg, err, bgQueueTypeId, avgWaitTime](Player* member)
        {
            WorldPacket data;

            // send status packet
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, member->AddBattlegroundQueueId(bgQueueTypeId), STATUS_WAIT_QUEUE, avgWaitTime, 0, 0, TEAM_NEUTRAL);
            member->GetSession()->SendPacket(&data);

            sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
            member->GetSession()->SendPacket(&data);

            sScriptMgr->OnPlayerJoinBG(member);
        });
        //npcbot: debug report
        for (GroupReference* itr = grp->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* member = itr->GetSource();
            if (!member)
                continue;   // this should never happen

            LOG_DEBUG("bg.battleground", "Battleground: player joined queue for bg queue type {} bg type {}: GUID {}, NAME {}",
                bgQueueTypeId, bgTypeId, member->GetGUID().ToString().c_str(), member->GetName().c_str());

            if (!member->HaveBot())
                continue;

            BotMap const* map = member->GetBotMgr()->GetBotMap();
            for (BotMap::const_iterator itr = map->begin(); itr != map->end(); ++itr)
            {
                Creature const* bot = itr->second;
                if (!bot || !grp->IsMember(bot->GetGUID()))
                    continue;

                LOG_DEBUG("bg.battleground", "Battleground: NPCBot joined queue for bg queue type {} bg type {}: GUID {}, NAME {} (owner: {})",
                    bgQueueTypeId, bgTypeId, bot->GetGUID().ToString().c_str(), bot->GetName().c_str(), member->GetName().c_str());
            }
        }
        //end npcbot
    }

    sBattlegroundMgr->ScheduleQueueUpdate(0, 0, bgQueueTypeId, bgTypeId, bracketEntry->GetBracketId());
}

void WorldSession::HandleBattlegroundPlayerPositionsOpcode(WorldPacket& /*recvData*/)
{
    LOG_DEBUG("network", "WORLD: Recvd MSG_BATTLEGROUND_PLAYER_POSITIONS Message");

    Battleground* bg = _player->GetBattleground();
    if (!bg)                                                 // can't be received if player not in battleground
        return;

    uint32 flagCarrierCount = 0;
    Player* allianceFlagCarrier = nullptr;
    Player* hordeFlagCarrier = nullptr;

    //npcbot
    Creature const* afcbot = nullptr;
    Creature const* hfcbot = nullptr;
    //end npcbot

    if (ObjectGuid guid = bg->GetFlagPickerGUID(TEAM_ALLIANCE))
    {
        allianceFlagCarrier = ObjectAccessor::FindPlayer(guid);
        if (allianceFlagCarrier)
            ++flagCarrierCount;
        //npcbot
        else if (guid.IsCreature())
        {
            afcbot = BotDataMgr::FindBot(guid.GetEntry());
            if (afcbot)
                ++flagCarrierCount;
        }
        //end npcbot
    }

    if (ObjectGuid guid = bg->GetFlagPickerGUID(TEAM_HORDE))
    {
        hordeFlagCarrier = ObjectAccessor::FindPlayer(guid);
        if (hordeFlagCarrier)
            ++flagCarrierCount;
        //npcbot
        else if (guid.IsCreature())
        {
            hfcbot = BotDataMgr::FindBot(guid.GetEntry());
            if (hfcbot)
                ++flagCarrierCount;
        }
        //end npcbot
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
    //npcbot
    else if (afcbot)
    {
        data << afcbot->GetGUID();
        data << float(afcbot->GetPositionX());
        data << float(afcbot->GetPositionY());
    }
    //end npcbot

    if (hordeFlagCarrier)
    {
        data << hordeFlagCarrier->GetGUID();
        data << float(hordeFlagCarrier->GetPositionX());
        data << float(hordeFlagCarrier->GetPositionY());
    }
    //npcbot
    else if (hfcbot)
    {
        data << hfcbot->GetGUID();
        data << float(hfcbot->GetPositionX());
        data << float(hfcbot->GetPositionY());
    }
    //end npcbot

    SendPacket(&data);
}

void WorldSession::HandlePVPLogDataOpcode(WorldPacket& /*recvData*/)
{
    LOG_DEBUG("network", "WORLD: Recvd MSG_PVP_LOG_DATA Message");

    Battleground* bg = _player->GetBattleground();
    if (!bg)
        return;

    // Prevent players from sending BuildPvpLogDataPacket in an arena except for when sent in BattleGround::EndBattleGround.
    if (bg->isArena())
        return;

    WorldPacket data;
    bg->BuildPvPLogDataPacket(data);
    SendPacket(&data);

    LOG_DEBUG("network", "WORLD: Sent MSG_PVP_LOG_DATA Message");
}

void WorldSession::HandleBattlefieldListOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recvd CMSG_BATTLEFIELD_LIST Message");

    uint32 bgTypeId;
    recvData >> bgTypeId;                                  // id from DBC

    uint8 fromWhere;
    recvData >> fromWhere;                                 // 0 - battlemaster (lua: ShowBattlefieldList), 1 - UI (lua: RequestBattlegroundInstanceInfo)

    uint8 canGainXP;
    recvData >> canGainXP;                                 // players with locked xp have their own bg queue on retail

    BattlemasterListEntry const* bl = sBattlemasterListStore.LookupEntry(bgTypeId);
    if (!bl)
    {
        LOG_DEBUG("bg.battleground", "BattlegroundHandler: invalid bgtype ({}) with player (Name: {}, {}) received.", bgTypeId, _player->GetName(), _player->GetGUID().ToString());
        return;
    }

    WorldPacket data;
    sBattlegroundMgr->BuildBattlegroundListPacket(&data, ObjectGuid::Empty, _player, BattlegroundTypeId(bgTypeId), fromWhere);
    SendPacket(&data);
}

void WorldSession::HandleBattleFieldPortOpcode(WorldPacket& recvData)
{
    uint8 arenaType;    // arenatype if arena
    uint8 unk2;         // unk, can be 0x0 (may be if was invited?) and 0x1
    uint32 bgTypeId_;   // type id from dbc
    uint16 unk;         // 0x1F90 constant?
    uint8 action;       // enter battle 0x1, leave queue 0x0

    recvData >> arenaType >> unk2 >> bgTypeId_ >> unk >> action;

    // bgTypeId not valid
    if (!sBattlemasterListStore.LookupEntry(bgTypeId_))
    {
        LOG_DEBUG("bg.battleground", "CMSG_BATTLEFIELD_PORT {} ArenaType: {}, Unk: {}, BgType: {}, Action: {}. Invalid BgType!", GetPlayerInfo(), arenaType, unk2, bgTypeId_, action);
        return;
    }

    // player not in any queue, so can't really answer
    if (!_player->InBattlegroundQueue())
    {
        LOG_DEBUG("bg.battleground", "CMSG_BATTLEFIELD_PORT {} ArenaType: {}, Unk: {}, BgType: {}, Action: {}. Player not in queue!", GetPlayerInfo(), arenaType, unk2, bgTypeId_, action);
        return;
    }

    if (_player->GetCharmGUID() || _player->IsInCombat())
    {
        ChatHandler(_player->GetSession()).SendNotification(LANG_YOU_IN_COMBAT);
        return;
    }

    // get BattlegroundQueue for received
    BattlegroundTypeId bgTypeId = BattlegroundTypeId(bgTypeId_);
    BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, arenaType);
    BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);

    if (!sScriptMgr->CanBattleFieldPort(_player, arenaType, bgTypeId, action))
        return;

    // get group info from queue
    GroupQueueInfo ginfo;
    if (!bgQueue.GetPlayerGroupInfoData(_player->GetGUID(), &ginfo))
    {
        LOG_DEBUG("bg.battleground", "CMSG_BATTLEFIELD_PORT {} ArenaType: {}, Unk: {}, BgType: {}, Action: {}. Player not in queue (No player Group Info)!",
            GetPlayerInfo(), arenaType, unk2, bgTypeId_, action);
        return;
    }

    // to accept, player must be invited to particular battleground id
    if (!ginfo.IsInvitedToBGInstanceGUID && action == 1)
    {
        LOG_DEBUG("bg.battleground", "CMSG_BATTLEFIELD_PORT {} ArenaType: {}, Unk: {}, BgType: {}, Action: {}. Player is not invited to any bg!",
            GetPlayerInfo(), arenaType, unk2, bgTypeId_, action);
        return;
    }

    Battleground* bg = sBattlegroundMgr->GetBattleground(ginfo.IsInvitedToBGInstanceGUID, bgTypeId);
    if (!bg)
    {
        if (action)
        {
            LOG_DEBUG("bg.battleground", "CMSG_BATTLEFIELD_PORT {} ArenaType: {}, Unk: {}, BgType: {}, Action: {}. Cant find BG with id {}!",
                GetPlayerInfo(), arenaType, unk2, bgTypeId_, action, ginfo.IsInvitedToBGInstanceGUID);
            return;
        }

        bg = sBattlegroundMgr->GetBattlegroundTemplate(bgTypeId);
        if (!bg)
        {
            LOG_ERROR("network", "BattlegroundHandler: bg_template not found for type id {}.", bgTypeId);
            return;
        }
    }

    LOG_DEBUG("bg.battleground", "CMSG_BATTLEFIELD_PORT {} ArenaType: {}, Unk: {}, BgType: {}, Action: {}.",
        GetPlayerInfo(), arenaType, unk2, bgTypeId_, action);

    // expected bracket entry
    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), _player->GetLevel());
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
            LOG_DEBUG("bg.battleground", "Player {} {} has a deserter debuff, do not port him to battleground!", _player->GetName(), _player->GetGUID().ToString());
        }

        if (_player->GetLevel() > bg->GetMaxLevel())
        {
            LOG_ERROR("network", "Player {} {} has level ({}) higher than maxlevel ({}) of battleground ({})! Do not port him to battleground!",
                _player->GetName(), _player->GetGUID().ToString(), _player->GetLevel(), bg->GetMaxLevel(), bg->GetBgTypeID());
            action = 0;
        }
    }

    // get player queue slot index for this bg (can be in up to 2 queues at the same time)
    uint32 queueSlot = _player->GetBattlegroundQueueIndex(bgQueueTypeId);
    WorldPacket data;

    if (action) // accept
    {
        // check Freeze debuff
        if (_player->HasAura(9454))
            return;

        if (!_player->IsInvitedForBattlegroundQueueType(bgQueueTypeId))
            return; // cheating?

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

        // send status packet
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_IN_PROGRESS, 0, bg->GetStartTime(), bg->GetArenaType(), teamId);
        SendPacket(&data);

        // remove battleground queue status from BGmgr
        bgQueue.RemovePlayer(_player->GetGUID(), false);

        // this is still needed here if battleground "jumping" shouldn't add deserter debuff
        // also this is required to prevent stuck at old battleground after SetBattlegroundId set to new
        if (Battleground* currentBg = _player->GetBattleground())
            currentBg->RemovePlayerAtLeave(_player);

        for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
        {
            auto playerBgQueueTypeId = _player->GetBattlegroundQueueTypeId(i);
            if (playerBgQueueTypeId != BATTLEGROUND_QUEUE_NONE && playerBgQueueTypeId != bgQueueTypeId)
            {
                _player->RemoveBattlegroundQueueId(playerBgQueueTypeId);
                sBattlegroundMgr->GetBattlegroundQueue(playerBgQueueTypeId).RemovePlayer(_player->GetGUID(), true);
            }
        }

        // Remove from LFG queues
        sLFGMgr->LeaveAllLfgQueues(_player->GetGUID(), false);

        _player->SetBattlegroundId(bg->GetInstanceID(), bg->GetBgTypeID(), queueSlot, true, bgTypeId == BATTLEGROUND_RB, teamId);
        sBattlegroundMgr->SendToBattleground(_player, ginfo.IsInvitedToBGInstanceGUID, bgTypeId);

        LOG_DEBUG("bg.battleground", "Battleground: player {} {} joined battle for bg {}, bgtype {}, queue type {}.", _player->GetName(), _player->GetGUID().ToString(), bg->GetInstanceID(), bg->GetBgTypeID(), bgQueueTypeId);
    }
    else // leave queue
    {
        for (auto const& playerGuid : ginfo.Players)
        {
            auto player = ObjectAccessor::FindConnectedPlayer(playerGuid);
            if (!player)
                continue;

            bgQueue.RemovePlayer(playerGuid, true);
            player->RemoveBattlegroundQueueId(bgQueueTypeId);

            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_NONE, 0, 0, 0, TEAM_NEUTRAL);
            player->SendDirectMessage(&data);

            LOG_DEBUG("bg.battleground", "Battleground: player {} {} left queue for bgtype {}, queue type {}.", player->GetName(), playerGuid.ToString(), bg->GetBgTypeID(), bgQueueTypeId);
        }

        // player left queue, we should update it - do not update Arena Queue
        if (!ginfo.ArenaType)
            sBattlegroundMgr->ScheduleQueueUpdate(ginfo.ArenaMatchmakerRating, ginfo.ArenaType, bgQueueTypeId, bgTypeId, bracketEntry->GetBracketId());

        // track if player refuses to join the BG after being invited
        if (bg->isBattleground() && (bg->GetStatus() == STATUS_IN_PROGRESS || bg->GetStatus() == STATUS_WAIT_JOIN))
        {
            if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_TRACK_DESERTERS))
            {
                CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_DESERTER_TRACK);
                stmt->SetData(0, _player->GetGUID().GetCounter());
                stmt->SetData(1, BG_DESERTION_TYPE_LEAVE_QUEUE);
                CharacterDatabase.Execute(stmt);
            }

            sScriptMgr->OnBattlegroundDesertion(_player, BG_DESERTION_TYPE_LEAVE_QUEUE);
        }

        if (bg->isArena() && (bg->GetStatus() == STATUS_IN_PROGRESS || bg->GetStatus() == STATUS_WAIT_JOIN))
            sScriptMgr->OnBattlegroundDesertion(_player, ARENA_DESERTION_TYPE_LEAVE_QUEUE);
    }
}

void WorldSession::HandleBattlefieldLeaveOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recvd CMSG_LEAVE_BATTLEFIELD Message");

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
            Battleground* bg = sBattlegroundMgr->GetBattleground(ginfo.IsInvitedToBGInstanceGUID, bgTypeId);
            if (!bg)
                continue;

            uint32 remainingTime = (GameTime::GetGameTimeMS().count() < ginfo.RemoveInviteTime ? getMSTimeDiff(GameTime::GetGameTimeMS().count(), ginfo.RemoveInviteTime) : 1);
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
            PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bgt->GetMapId(), _player->GetLevel());
            if (!bracketEntry)
                continue;

            uint32 avgWaitTime = bgQueue.GetAverageQueueWaitTime(&ginfo);
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bgt, i, STATUS_WAIT_QUEUE, avgWaitTime, getMSTimeDiff(ginfo.JoinTime, GameTime::GetGameTimeMS().count()), ginfo.ArenaType, TEAM_NEUTRAL, ginfo.IsRated);
            SendPacket(&data);
        }
    }
}

void WorldSession::HandleBattlemasterJoinArena(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: CMSG_BATTLEMASTER_JOIN_ARENA");

    ObjectGuid guid; // arena Battlemaster guid
    uint8 arenaslot; // 2v2, 3v3 or 5v5
    uint8 asGroup;   // asGroup
    uint8 isRated;   // isRated

    recvData >> guid >> arenaslot >> asGroup >> isRated;

    // can't queue for rated without a group
    if (isRated && !asGroup)
        return;

    // ignore if we already in BG or BG queue
    if (_player->InBattleground())
        return;

    // find creature by guid
    Creature* unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit || !unit->IsBattleMaster())
        return;

    // get arena type
    uint8 arenatype = 0;
    uint32 ateamId = 0;
    uint32 arenaRating = 0;
    uint32 matchmakerRating = 0;
    uint32 previousOpponents = 0;

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
            LOG_ERROR("network", "Unknown arena slot {} at HandleBattlemasterJoinArena()", arenaslot);
            return;
    }

    // get template for all arenas
    Battleground* bgt = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA);
    if (!bgt)
    {
        LOG_ERROR("network", "Battleground: template bg (all arenas) not found");
        return;
    }

    // arenas disabled
    if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, BATTLEGROUND_AA, nullptr))
    {
        ChatHandler(this).PSendSysMessage(LANG_ARENA_DISABLED);
        return;
    }

    BattlegroundTypeId bgTypeId = bgt->GetBgTypeID();

    // expected bracket entry
    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bgt->GetMapId(), _player->GetLevel());
    if (!bracketEntry)
        return;

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

    BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, arenatype);
    BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);

    // check if player can queue:
    if (!asGroup)
    {
        lfg::LfgState lfgState = sLFGMgr->GetState(GetPlayer()->GetGUID());
        if (GetPlayer()->InBattleground()) // currently in battleground
        {
            err = ERR_BATTLEGROUND_NOT_IN_BATTLEGROUND;
        }
        else if (lfgState > lfg::LFG_STATE_NONE && (lfgState != lfg::LFG_STATE_QUEUED || !sWorld->getBoolConfig(CONFIG_ALLOW_JOIN_BG_AND_LFG))) // using lfg system
        {
            err = ERR_LFG_CANT_USE_BATTLEGROUND;
        }

        if (err <= 0)
        {
            WorldPacket data;
            sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
            SendPacket(&data);
            return;
        }

        // check if already in queue
        if (_player->GetBattlegroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES)
            //player is already in this queue
            return;

        // check if has free queue slots
        if (!_player->HasFreeBattlegroundQueueId())
            return;

        GroupQueueInfo* ginfo = bgQueue.AddGroup(_player, nullptr, bgTypeId, bracketEntry, arenatype, isRated != 0, false, arenaRating, matchmakerRating, ateamId, previousOpponents);
        uint32 avgWaitTime = bgQueue.GetAverageQueueWaitTime(ginfo);
        uint32 queueSlot = _player->AddBattlegroundQueueId(bgQueueTypeId);

        WorldPacket data;
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bgt, queueSlot, STATUS_WAIT_QUEUE, avgWaitTime, 0, arenatype, TEAM_NEUTRAL);
        SendPacket(&data);

        LOG_DEBUG("bg.battleground", "Battleground: player joined queue for arena, skirmish, bg queue type {} bg type {}: {}, NAME {}", bgQueueTypeId, bgTypeId, _player->GetGUID().ToString(), _player->GetName());

        sScriptMgr->OnPlayerJoinArena(_player);
    }
    // check if group can queue:
    else
    {
        Group* grp = _player->GetGroup();
        // no group or not a leader
        if (!grp || grp->GetLeaderGUID() != _player->GetGUID())
            return;

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

            previousOpponents = at->GetPreviousOpponents();
        }

        err = grp->CanJoinBattlegroundQueue(bgt, bgQueueTypeId, arenatype, arenatype, (bool)isRated, arenaslot);

        // Check queue group members
        if (err)
        {
            grp->DoForAllMembers([&bgQueue, &err](Player* member)
            {
                if (bgQueue.IsPlayerInvitedToRatedArena(member->GetGUID()))
                {
                    err = ERR_BATTLEGROUND_JOIN_FAILED;
                }
            });
        }

        uint32 avgWaitTime = 0;
        if (err > 0)
        {
            LOG_DEBUG("bg.battleground", "Battleground: arena join as group start");

            if (isRated)
            {
                LOG_DEBUG("bg.battleground", "Battleground: arena team id {}, leader {} queued with matchmaker rating {} for type {}", _player->GetArenaTeamId(arenaslot), _player->GetName(), matchmakerRating, arenatype);
                bgt->SetRated(true);
            }
            else
            {
                bgt->SetRated(false);
            }

            GroupQueueInfo* ginfo = bgQueue.AddGroup(_player, grp, bgTypeId, bracketEntry, arenatype, isRated != 0, false, arenaRating, matchmakerRating, ateamId, previousOpponents);
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

            LOG_DEBUG("bg.battleground", "Battleground: player joined queue for arena as group bg queue type {} bg type {}: {}, NAME {}", bgQueueTypeId, bgTypeId, member->GetGUID().ToString(), member->GetName());

            sScriptMgr->OnPlayerJoinArena(member);
        }
    }

    sBattlegroundMgr->ScheduleQueueUpdate(matchmakerRating, arenatype, bgQueueTypeId, bgTypeId, bracketEntry->GetBracketId());
}

void WorldSession::HandleReportPvPAFK(WorldPacket& recvData)
{
    ObjectGuid playerGuid;
    recvData >> playerGuid;
    Player* reportedPlayer = ObjectAccessor::FindPlayer(playerGuid);

    if (!reportedPlayer)
    {
        LOG_DEBUG("bg.battleground", "WorldSession::HandleReportPvPAFK: player not found");
        return;
    }

    LOG_DEBUG("bg.battleground", "WorldSession::HandleReportPvPAFK: {} reported {}", _player->GetName(), reportedPlayer->GetName());

    reportedPlayer->ReportedAfkBy(_player);
}
