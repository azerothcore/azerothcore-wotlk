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

#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "GameTime.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldSession.h"

// Sends to player the window to invite them to join the war
// Param1:(battleId) the BattleId of Bf
// Param2:(zoneId) the zone where the battle is (4197 for wg)
// Param3:(time) Time in seconds that the player has to accept
void WorldSession::SendBfInvitePlayerToWar(uint32 battleId, uint32 zoneId, uint32 time)
{
    WorldPacket data(SMSG_BATTLEFIELD_MGR_ENTRY_INVITE, 12);
    data << uint32(battleId);
    data << uint32(zoneId);
    data << uint32(GameTime::GetGameTime().count() + time);
    SendPacket(&data);
}

// Sends invitation to player to join the queue
// Param1:(battleId) the BattleId of Bf
void WorldSession::SendBfInvitePlayerToQueue(uint32 battleId)
{
    WorldPacket data(SMSG_BATTLEFIELD_MGR_QUEUE_INVITE, 5);
    data << uint32(battleId);
    data << uint8(1);                                       // warmup ? used ?
    SendPacket(&data);
}

// Sends packet to inform player that they joined the queue
// Param1:(battleId) the BattleId of Bf
// Param2:(zoneId) the zone where the battle is (4197 for wg)
// Param3:(canQueue) if able to queue
// Param4:(full) on log in is full
void WorldSession::SendBfQueueInviteResponse(uint32 battleId, uint32 zoneId, bool canQueue, bool full)
{
    WorldPacket data(SMSG_BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE, 11);
    data << uint32(battleId);
    data << uint32(zoneId);
    data << uint8((canQueue ? 1 : 0));  //Accepted          //0 you cannot queue wg     //1 you are queued
    data << uint8((full ? 0 : 1));      //Logging In        //0 wg full                 //1 queue for upcoming
    data << uint8(1); //Warmup
    SendPacket(&data);
}

// Called when player accepts to join war
// Param1:(battleId) the BattleId of Bf
void WorldSession::SendBfEntered(uint32 battleId)
{
    WorldPacket data(SMSG_BATTLEFIELD_MGR_ENTERED, 7);
    data << uint32(battleId);
    data << uint8(1);                                       // unk
    data << uint8(1);                                       // unk
    data << uint8(_player->isAFK() ? 1 : 0);               // Clear AFK
    SendPacket(&data);
}

void WorldSession::SendBfLeaveMessage(uint32 battleId, BFLeaveReason reason)
{
    WorldPacket data(SMSG_BATTLEFIELD_MGR_EJECTED, 7);
    data << uint32(battleId);
    data << uint8(reason);  // byte Reason
    data << uint8(2);       // byte BattleStatus
    data << uint8(0);       // bool Relocated
    SendPacket(&data);
}

// Sent by client when they click accept for queue
void WorldSession::HandleBfQueueInviteResponse(WorldPacket& recvData)
{
    uint32 battleId;
    uint8 accepted;

    recvData >> battleId >> accepted;

    Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);
    if (!bf)
        return;

    if (accepted)
        bf->PlayerAcceptInviteToQueue(_player);
}

// Sent by client on clicking accept or refuse of invitation window to join game
void WorldSession::HandleBfEntryInviteResponse(WorldPacket& recvData)
{
    uint32 battleId;
    uint8 accepted;

    recvData >> battleId >> accepted;

    Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);
    if (!bf)
        return;

    if (accepted)
        bf->PlayerAcceptInviteToWar(_player);
    else
    {
        if (_player->GetZoneId() == bf->GetZoneId())
            bf->KickPlayerFromBattlefield(_player->GetGUID());
    }
}

void WorldSession::HandleBfExitRequest(WorldPacket& recvData)
{
    uint32 battleId;

    recvData >> battleId;

    Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);
    if (!bf)
        return;

    bf->AskToLeaveQueue(_player);
}
