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

#include "BattlegroundRL.h"
#include "Log.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldStateDefines.h"

BattlegroundRL::BattlegroundRL()
{
    BgObjects.resize(BG_RL_OBJECT_MAX);
}

void BattlegroundRL::StartingEventCloseDoors()
{
    for (uint32 i = BG_RL_OBJECT_DOOR_1; i <= BG_RL_OBJECT_DOOR_2; ++i)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);
}

void BattlegroundRL::StartingEventOpenDoors()
{
    for (uint32 i = BG_RL_OBJECT_DOOR_1; i <= BG_RL_OBJECT_DOOR_2; ++i)
        DoorOpen(i);

    for (uint32 i = BG_RL_OBJECT_BUFF_1; i <= BG_RL_OBJECT_BUFF_2; ++i)
        SpawnBGObject(i, 90);
}

bool BattlegroundRL::HandlePlayerUnderMap(Player* player)
{
    player->NearTeleportTo(1285.810547f, 1667.896851f, 39.957642f, player->GetOrientation());
    return true;
}

void BattlegroundRL::HandleAreaTrigger(Player* player, uint32 trigger)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    switch (trigger)
    {
        case 4696:                                          // buff trigger?
        case 4697:                                          // buff trigger?
            break;
        // OUTSIDE OF ARENA, TELEPORT!
        case 4927:
        case 4928:
            player->NearTeleportTo(1230.77f, 1662.42f, 34.56f, 0.0f);
            break;
        case 4929:
        case 4930:
            player->NearTeleportTo(1341.16f, 1673.52f, 34.43f, 3.5f);
            break;
        case 4931:
            player->NearTeleportTo(1294.74f, 1584.5f, 31.62f, 1.66f);
            break;
        case 4932:
            player->NearTeleportTo(1277.5f, 1751.07f, 31.61f, 4.7f);
            break;
        case 4933:
            player->NearTeleportTo(1269.14f, 1713.85f, 34.46f, 5.23f);
            break;
        case 4934:
            player->NearTeleportTo(1298.14f, 1713.8f, 33.58f, 4.55f);
            break;
        case 4935:
            player->NearTeleportTo(1306.32f, 1620.75f, 34.25f, 1.97f);
            break;
        case 4936:
            player->NearTeleportTo(1277.97f, 1615.51f, 34.56f, 1.15f);
            break;
        case 4941: // under arena +10
        case 5041: // under arena -10
        case 5042: // under arena -30
            player->NearTeleportTo(1285.810547f, 1667.896851f, 39.957642f, player->GetOrientation());
            break;
    }
}

void BattlegroundRL::FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet)
{
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEGROUND_RL_ARENA_SHOW, 1);
    Arena::FillInitialWorldStates(packet);
}

bool BattlegroundRL::SetupBattleground()
{
    // gates
    if (!AddObject(BG_RL_OBJECT_DOOR_1, BG_RL_OBJECT_TYPE_DOOR_1, 1293.561f, 1601.938f, 31.60557f, -1.457349f, 0, 0, -0.6658813f, 0.7460576f, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_RL_OBJECT_DOOR_2, BG_RL_OBJECT_TYPE_DOOR_2, 1278.648f, 1730.557f, 31.60557f, 1.684245f, 0, 0, 0.7460582f, 0.6658807f, RESPAWN_IMMEDIATELY)
            // buffs
            || !AddObject(BG_RL_OBJECT_BUFF_1, BG_RL_OBJECT_TYPE_BUFF_1, 1328.719971f, 1632.719971f, 36.730400f, -1.448624f, 0, 0, 0.6626201f, -0.7489557f, 120)
            || !AddObject(BG_RL_OBJECT_BUFF_2, BG_RL_OBJECT_TYPE_BUFF_2, 1243.300049f, 1699.170044f, 34.872601f, -0.06981307f, 0, 0, 0.03489945f, -0.9993908f, 120)
            // Arena Ready Marker
            || !AddObject(BG_RL_OBJECT_READY_MARKER_1, ARENA_READY_MARKER_ENTRY, 1298.61f, 1598.59f, 31.62f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 300)
            || !AddObject(BG_RL_OBJECT_READY_MARKER_2, ARENA_READY_MARKER_ENTRY, 1273.71f, 1734.05f, 31.61f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 300))
    {
        LOG_ERROR("sql.sql", "BatteGroundRL: Failed to spawn some object!");
        return false;
    }

    return true;
}
