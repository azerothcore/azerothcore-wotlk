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

#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "UpdateMask.h"
#include "WaypointMovementGenerator.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleTaxiNodeStatusQueryOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_TAXINODE_STATUS_QUERY");

    ObjectGuid guid;

    recvData >> guid;
    SendTaxiStatus(guid);
}

void WorldSession::SendTaxiStatus(ObjectGuid guid)
{
    // cheating checks
    Creature* unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit)
    {
        LOG_DEBUG("network", "WorldSession::SendTaxiStatus - Unit ({}) not found.", guid.ToString());
        return;
    }

    uint32 curloc = sObjectMgr->GetNearestTaxiNode(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ(), unit->GetMapId(), GetPlayer()->GetTeamId());

    // not found nearest
    if (curloc == 0)
        return;

    LOG_DEBUG("network", "WORLD: current location {} ", curloc);

    WorldPacket data(SMSG_TAXINODE_STATUS, 9);
    data << guid;
    data << uint8(GetPlayer()->m_taxi.IsTaximaskNodeKnown(curloc) ? 1 : 0);
    SendPacket(&data);
    LOG_DEBUG("network", "WORLD: Sent SMSG_TAXINODE_STATUS");
}

void WorldSession::HandleTaxiQueryAvailableNodes(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_TAXIQUERYAVAILABLENODES");

    ObjectGuid guid;
    recvData >> guid;

    // cheating checks
    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_FLIGHTMASTER);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: HandleTaxiQueryAvailableNodes - Unit ({}) not found or you can't interact with him.", guid.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    // unknown taxi node case
    if (SendLearnNewTaxiNode(unit))
        return;

    // known taxi node case
    SendTaxiMenu(unit);
}

void WorldSession::SendTaxiMenu(Creature* unit)
{
    // find current node
    uint32 curloc = sObjectMgr->GetNearestTaxiNode(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ(), unit->GetMapId(), GetPlayer()->GetTeamId());

    if (curloc == 0)
        return;

    bool lastTaxiCheaterState = GetPlayer()->isTaxiCheater();
    if (unit->GetEntry() == 29480) GetPlayer()->SetTaxiCheater(true); // Grimwing in Ebon Hold, special case. NOTE: Not perfect, Zul'Aman should not be included according to WoWhead, and I think taxicheat includes it.

    LOG_DEBUG("network", "WORLD: CMSG_TAXINODE_STATUS_QUERY {} ", curloc);

    WorldPacket data(SMSG_SHOWTAXINODES, (4 + 8 + 4 + 8 * 4));
    data << uint32(1);
    data << unit->GetGUID();
    data << uint32(curloc);
    GetPlayer()->m_taxi.AppendTaximaskTo(data, GetPlayer()->isTaxiCheater());
    SendPacket(&data);

    LOG_DEBUG("network", "WORLD: Sent SMSG_SHOWTAXINODES");

    GetPlayer()->SetTaxiCheater(lastTaxiCheaterState);
}

void WorldSession::SendDoFlight(uint32 mountDisplayId, uint32 path, uint32 pathNode)
{
    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    while (GetPlayer()->GetMotionMaster()->GetCurrentMovementGeneratorType() == FLIGHT_MOTION_TYPE)
        GetPlayer()->GetMotionMaster()->MovementExpired(false);

    if (mountDisplayId)
        GetPlayer()->Mount(mountDisplayId);

    if (Creature* critter = ObjectAccessor::GetCreature(*GetPlayer(), GetPlayer()->GetCritterGUID()))
    {
        critter->DespawnOrUnsummon();
    }

    GetPlayer()->GetMotionMaster()->MoveTaxiFlight(path, pathNode);

    sScriptMgr->AnticheatSetSkipOnePacketForASH(GetPlayer(), true);
}

bool WorldSession::SendLearnNewTaxiNode(Creature* unit)
{
    // find current node
    uint32 curloc = sObjectMgr->GetNearestTaxiNode(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ(), unit->GetMapId(), GetPlayer()->GetTeamId());

    if (curloc == 0)
        return true;                                        // `true` send to avoid WorldSession::SendTaxiMenu call with one more curlock seartch with same false result.

    if (GetPlayer()->m_taxi.SetTaximaskNode(curloc))
    {
        WorldPacket msg(SMSG_NEW_TAXI_PATH, 0);
        SendPacket(&msg);

        WorldPacket update(SMSG_TAXINODE_STATUS, 9);
        update << unit->GetGUID();
        update << uint8(1);
        SendPacket(&update);

        return true;
    }
    else
        return false;
}

void WorldSession::SendDiscoverNewTaxiNode(uint32 nodeid)
{
    if (GetPlayer()->m_taxi.SetTaximaskNode(nodeid))
    {
        WorldPacket msg(SMSG_NEW_TAXI_PATH, 0);
        SendPacket(&msg);
    }
}

void WorldSession::HandleActivateTaxiExpressOpcode (WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_ACTIVATETAXIEXPRESS");

    ObjectGuid guid;
    uint32 node_count;

    recvData >> guid >> node_count;

    Creature* npc = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_FLIGHTMASTER);
    if (!npc)
    {
        LOG_DEBUG("network", "WORLD: HandleActivateTaxiExpressOpcode - Unit ({}) not found or you can't interact with it.", guid.ToString());
        return;
    }
    std::vector<uint32> nodes;

    for (uint32 i = 0; i < node_count; ++i)
    {
        uint32 node;
        recvData >> node;

        if (!GetPlayer()->m_taxi.IsTaximaskNodeKnown(node) && !GetPlayer()->isTaxiCheater())
        {
            SendActivateTaxiReply(ERR_TAXINOTVISITED);
            recvData.rfinish();
            return;
        }

        nodes.push_back(node);
    }

    if (nodes.empty())
        return;

    LOG_DEBUG("network", "WORLD: Received CMSG_ACTIVATETAXIEXPRESS from {} to {}", nodes.front(), nodes.back());

    GetPlayer()->ActivateTaxiPathTo(nodes, npc, 0);
}

void WorldSession::HandleMoveSplineDoneOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_MOVE_SPLINE_DONE");

    ObjectGuid guid; // used only for proper packet read
    recvData >> guid.ReadAsPacked();

    MovementInfo movementInfo;                              // used only for proper packet read
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);

    recvData.read_skip<uint32>();                          // spline id
}

void WorldSession::HandleActivateTaxiOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_ACTIVATETAXI");

    ObjectGuid guid;
    std::vector<uint32> nodes;
    nodes.resize(2);

    recvData >> guid >> nodes[0] >> nodes[1];
    LOG_DEBUG("network", "WORLD: Received CMSG_ACTIVATETAXI from {} to {}", nodes[0], nodes[1]);
    Creature* npc = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_FLIGHTMASTER);
    if (!npc)
    {
        LOG_DEBUG("network", "WORLD: HandleActivateTaxiOpcode - Unit ({}) not found or you can't interact with it.", guid.ToString());
        return;
    }

    if (!GetPlayer()->isTaxiCheater())
    {
        if (!GetPlayer()->m_taxi.IsTaximaskNodeKnown(nodes[0]) || !GetPlayer()->m_taxi.IsTaximaskNodeKnown(nodes[1]))
        {
            SendActivateTaxiReply(ERR_TAXINOTVISITED);
            return;
        }
    }

    GetPlayer()->ActivateTaxiPathTo(nodes, npc, 0);
}

void WorldSession::SendActivateTaxiReply(ActivateTaxiReply reply)
{
    WorldPacket data(SMSG_ACTIVATETAXIREPLY, 4);
    data << uint32(reply);
    SendPacket(&data);

    LOG_DEBUG("network", "WORLD: Sent SMSG_ACTIVATETAXIREPLY");
}
