/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "BattlegroundBE.h"
#include "Language.h"
#include "Object.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldSession.h"

BattlegroundBE::BattlegroundBE()
{
    BgObjects.resize(BG_BE_OBJECT_MAX);

    StartDelayTimes[BG_STARTING_EVENT_FIRST]  = BG_START_DELAY_1M;
    StartDelayTimes[BG_STARTING_EVENT_SECOND] = BG_START_DELAY_30S;
    StartDelayTimes[BG_STARTING_EVENT_THIRD]  = BG_START_DELAY_15S;
    StartDelayTimes[BG_STARTING_EVENT_FOURTH] = BG_START_DELAY_NONE;
    //we must set messageIds
    StartMessageIds[BG_STARTING_EVENT_FIRST]  = LANG_ARENA_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = LANG_ARENA_THIRTY_SECONDS;
    StartMessageIds[BG_STARTING_EVENT_THIRD]  = LANG_ARENA_FIFTEEN_SECONDS;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = LANG_ARENA_HAS_BEGUN;
}

BattlegroundBE::~BattlegroundBE()
{

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
        SpawnBGObject(i, 60);
}

void BattlegroundBE::AddPlayer(Player* player)
{
    Battleground::AddPlayer(player);
    PlayerScores[player->GetGUID()] = new BattlegroundScore(player);
    Battleground::UpdateArenaWorldState();
}

void BattlegroundBE::RemovePlayer(Player* /*player*/)
{
    if (GetStatus() == STATUS_WAIT_LEAVE)
        return;

    Battleground::UpdateArenaWorldState();
    CheckArenaWinConditions();
}

void BattlegroundBE::HandleKillPlayer(Player* player, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    if (!killer)
    {
        sLog->outError("Killer player not found");
        return;
    }

    Battleground::HandleKillPlayer(player, killer);

    Battleground::UpdateArenaWorldState();
    CheckArenaWinConditions();
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

void BattlegroundBE::FillInitialWorldStates(WorldPacket &data)
{
    data << uint32(0x9f3) << uint32(1);           // 9
    Battleground::UpdateArenaWorldState();
}

void BattlegroundBE::Init()
{
    //call parent's class reset
    Battleground::Init();
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
        sLog->outErrorDb("BatteGroundBE: Failed to spawn some object!");
        return false;
    }

    return true;
}

void BattlegroundBE::UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor)
{
    Battleground::UpdatePlayerScore(player, type, value, doAddHonor);
}
