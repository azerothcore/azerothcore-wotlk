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

#include "BattlegroundBE.h"
#include "Log.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldStatePackets.h"
#include "WorldStateDefines.h"

BattlegroundBE::BattlegroundBE()
{
    BgObjects.resize(BG_BE_OBJECT_MAX);
}

void BattlegroundBE::StartingEventCloseDoors()
{
    for (uint32 i = BG_BE_OBJECT_DOOR_1; i <= BG_BE_OBJECT_DOOR_4; ++i)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);

    for (uint32 i = BG_BE_OBJECT_BUFF_1; i <= BG_BE_OBJECT_BUFF_2; ++i)
        SpawnBGObject(i, RESPAWN_ONE_DAY);
}

void BattlegroundBE::StartingEventOpenDoors()
{
    for (uint32 i = BG_BE_OBJECT_DOOR_1; i <= BG_BE_OBJECT_DOOR_2; ++i)
        DoorOpen(i);

    for (uint32 i = BG_BE_OBJECT_BUFF_1; i <= BG_BE_OBJECT_BUFF_2; ++i)
        SpawnBGObject(i, 90);
}

bool BattlegroundBE::HandlePlayerUnderMap(Player* player)
{
    player->NearTeleportTo(6238.930176f, 262.963470f, 0.889519f, player->GetOrientation());
    return true;
}

void BattlegroundBE::HandleAreaTrigger(Player* player, uint32 trigger)
{
    // this is wrong way to implement these things. On official it done by gameobject spell cast.
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    switch (trigger)
    {
        case 4538:                                          // buff trigger?
            //buff_guid = BgObjects[BG_BE_OBJECT_BUFF_1];
            break;
        case 4539:                                          // buff trigger?
            //buff_guid = BgObjects[BG_BE_OBJECT_BUFF_2];
            break;
        // OUTSIDE OF ARENA, TELEPORT!
        case 4919:
            player->NearTeleportTo(6220.90f, 318.94f, 5.1f, 5.3f);
            break;
        case 4921:
            player->NearTeleportTo(6250.27f, 208.50f, 4.77f, 1.9f);
            break;
        case 4922:
            player->NearTeleportTo(6214.4f, 227.12f, 4.28f, 0.8f);
            break;
        case 4923:
            player->NearTeleportTo(6180.98f, 265.28f, 4.27f, 6.06f);
            break;
        case 4924:
            player->NearTeleportTo(6269.0f, 295.06f, 4.46f, 3.98f);
            break;
        case 4944: // under arena -20
        case 5039: // under arena -40
        case 5040: // under arena -60
            player->NearTeleportTo(6238.930176f, 262.963470f, 0.889519f, player->GetOrientation());
            break;
    }
}

void BattlegroundBE::FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet)
{
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEGROUND_BE_ARENA_SHOW, 1);
    Arena::FillInitialWorldStates(packet);
}

bool BattlegroundBE::SetupBattleground()
{
    // gates
    if (!AddObject(BG_BE_OBJECT_DOOR_1, BG_BE_OBJECT_TYPE_DOOR_1, 6287.277f, 282.1877f, 3.810925f, -2.260201f, 0, 0, 0.9044551f, -0.4265689f, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_BE_OBJECT_DOOR_2, BG_BE_OBJECT_TYPE_DOOR_2, 6189.546f, 241.7099f, 3.101481f, 0.8813917f, 0, 0, 0.4265689f, 0.9044551f, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_BE_OBJECT_DOOR_3, BG_BE_OBJECT_TYPE_DOOR_3, 6299.116f, 296.5494f, 3.308032f, 0.8813917f, 0, 0, 0.4265689f, 0.9044551f, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_BE_OBJECT_DOOR_4, BG_BE_OBJECT_TYPE_DOOR_4, 6177.708f, 227.3481f, 3.604374f, -2.260201f, 0, 0, 0.9044551f, -0.4265689f, RESPAWN_IMMEDIATELY)
            // buffs
            || !AddObject(BG_BE_OBJECT_BUFF_1, BG_BE_OBJECT_TYPE_BUFF_1, 6249.042f, 275.3239f, 11.22033f, -1.448624f, 0, 0, 0.6626201f, -0.7489557f, 120)
            || !AddObject(BG_BE_OBJECT_BUFF_2, BG_BE_OBJECT_TYPE_BUFF_2, 6228.26f, 249.566f, 11.21812f, -0.06981307f, 0, 0, 0.03489945f, -0.9993908f, 120)
            // Arena Ready Marker
            || !AddObject(BG_BE_OBJECT_READY_MARKER_1, ARENA_READY_MARKER_ENTRY, 6189.47f, 235.54f, 5.52f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 300)
            || !AddObject(BG_BE_OBJECT_READY_MARKER_2, ARENA_READY_MARKER_ENTRY, 6287.19f, 288.25f, 5.33f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 300))
    {
        LOG_ERROR("sql.sql", "BatteGroundBE: Failed to spawn some object!");
        return false;
    }

    return true;
}
