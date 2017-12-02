/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Player.h"
#include "Battleground.h"
#include "BattlegroundIC.h"
#include "Language.h"
#include "WorldPacket.h"
#include "GameObject.h"
#include "ObjectMgr.h"
#include "Vehicle.h"
#include "Transport.h"
#include "WorldSession.h"
#include "ScriptedCreature.h"

BattlegroundIC::BattlegroundIC()
{
    BgObjects.resize(MAX_NORMAL_GAMEOBJECTS_SPAWNS + MAX_AIRSHIPS_SPAWNS + MAX_HANGAR_TELEPORTERS_SPAWNS + MAX_FORTRESS_TELEPORTERS_SPAWNS + MAX_HANGAR_TELEPORTER_EFFECTS_SPAWNS + MAX_FORTRESS_TELEPORTER_EFFECTS_SPAWNS);
    BgCreatures.resize(MAX_NORMAL_NPCS_SPAWNS + MAX_WORKSHOP_SPAWNS + MAX_DOCKS_SPAWNS + MAX_SPIRIT_GUIDES_SPAWNS + MAX_HANGAR_NPCS_SPAWNS);

    StartMessageIds[BG_STARTING_EVENT_FIRST]  = LANG_BG_IC_START_TWO_MINUTES;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = LANG_BG_IC_START_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_THIRD]  = LANG_BG_IC_START_HALF_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = LANG_BG_IC_HAS_BEGUN;

    for (uint8 i = 0; i < 2; ++i)
        factionReinforcements[i] = MAX_REINFORCEMENTS;

    for (uint8 i = 0; i < BG_IC_MAXDOOR; ++i)
        GateStatus[i] = BG_IC_GATE_OK;

    closeFortressDoorsTimer = CLOSE_DOORS_TIME; // the doors are closed again... in a special way
    doorsClosed = false;
    docksTimer = DOCKS_UPDATE_TIME;
    resourceTimer = IC_RESOURCE_TIME;

    for (uint8 i = NODE_TYPE_REFINERY; i < MAX_NODE_TYPES; ++i)
        nodePoint[i] = nodePointInitial[i];

    siegeEngineWorkshopTimer = WORKSHOP_UPDATE_TIME;

    gunshipHorde = NULL;
    gunshipAlliance = NULL;
    respawnMap.clear();
}

BattlegroundIC::~BattlegroundIC()
{
}

void BattlegroundIC::DoAction(uint32 action, uint64 guid)
{
    if (action != ACTION_TELEPORT_PLAYER_TO_TRANSPORT)
        return;

    if (!gunshipAlliance || !gunshipHorde)
        return;

    Player* player = ObjectAccessor::GetPlayer(*gunshipAlliance, guid);
    if (!player)
        return;

    MotionTransport* transport = player->GetTeamId() == TEAM_ALLIANCE ? gunshipAlliance : gunshipHorde;
    float x = BG_IC_HangarTrigger[player->GetTeamId()].GetPositionX();
    float y = BG_IC_HangarTrigger[player->GetTeamId()].GetPositionY();
    float z = BG_IC_HangarTrigger[player->GetTeamId()].GetPositionZ();
    transport->CalculatePassengerPosition(x, y, z);

    player->TeleportTo(GetMapId(), x, y, z, player->GetOrientation(), TELE_TO_NOT_LEAVE_TRANSPORT);
}

void BattlegroundIC::HandlePlayerResurrect(Player* player)
{
    if (nodePoint[NODE_TYPE_QUARRY].nodeState == (player->GetTeamId() == TEAM_ALLIANCE ? NODE_STATE_CONTROLLED_A : NODE_STATE_CONTROLLED_H))
        player->CastSpell(player, SPELL_QUARRY, true);

    if (nodePoint[NODE_TYPE_REFINERY].nodeState == (player->GetTeamId() == TEAM_ALLIANCE ? NODE_STATE_CONTROLLED_A : NODE_STATE_CONTROLLED_H))
        player->CastSpell(player, SPELL_OIL_REFINERY, true);
}

void BattlegroundIC::PostUpdateImpl(uint32 diff)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    if (!doorsClosed)
    {
        if (closeFortressDoorsTimer <= diff)
        {
            GetBGObject(BG_IC_GO_DOODAD_ND_HUMAN_GATE_CLOSEDFX_DOOR01)->RemoveFromWorld();
            GetBGObject(BG_IC_GO_DOODAD_ND_WINTERORC_WALL_GATEFX_DOOR01)->RemoveFromWorld();
            GetBGObject(BG_IC_GO_DOODAD_ND_HUMAN_GATE_CLOSEDFX_DOOR02)->RemoveFromWorld();
            GetBGObject(BG_IC_GO_DOODAD_ND_WINTERORC_WALL_GATEFX_DOOR02)->RemoveFromWorld();
            GetBGObject(BG_IC_GO_DOODAD_ND_HUMAN_GATE_CLOSEDFX_DOOR03)->RemoveFromWorld();
            GetBGObject(BG_IC_GO_DOODAD_ND_WINTERORC_WALL_GATEFX_DOOR03)->RemoveFromWorld();

            GetBGObject(BG_IC_GO_ALLIANCE_GATE_1)->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);
            GetBGObject(BG_IC_GO_HORDE_GATE_1)->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);
            GetBGObject(BG_IC_GO_ALLIANCE_GATE_2)->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);
            GetBGObject(BG_IC_GO_HORDE_GATE_2)->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);
            GetBGObject(BG_IC_GO_ALLIANCE_GATE_3)->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);
            GetBGObject(BG_IC_GO_HORDE_GATE_3)->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);

            doorsClosed = true;
        } else closeFortressDoorsTimer -= diff;
    }

    for (uint8 i = NODE_TYPE_REFINERY; i < MAX_NODE_TYPES; ++i)
    {
        if (nodePoint[i].nodeType == NODE_TYPE_DOCKS)
        {
            if (nodePoint[i].nodeState == NODE_STATE_CONTROLLED_A ||
                nodePoint[i].nodeState == NODE_STATE_CONTROLLED_H)
            {
                if (nodePoint[i].timer <= diff)
                {
                    // we need to confirm this, i am not sure if this every 3 minutes
                    for (uint8 j = 0; j < MAX_CATAPULTS_SPAWNS_PER_FACTION; ++j)
                    {
                        uint8 type = (nodePoint[i].faction == TEAM_ALLIANCE ? BG_IC_NPC_CATAPULT_1_A : BG_IC_NPC_CATAPULT_1_H)+j;
                        if (Creature* catapult = GetBGCreature(type))
                            if (!catapult->IsAlive())
                            {
                                // Check if creature respawn time is properly saved
                                RespawnMap::iterator itr = respawnMap.find(catapult->GetGUIDLow());
                                if (itr == respawnMap.end() || time(NULL) < itr->second)
                                    continue;

                                catapult->Relocate(BG_IC_DocksVehiclesCatapults[j].GetPositionX(), BG_IC_DocksVehiclesCatapults[j].GetPositionY(), BG_IC_DocksVehiclesCatapults[j].GetPositionZ(), BG_IC_DocksVehiclesCatapults[j].GetOrientation());
                                catapult->Respawn(true);
                                respawnMap.erase(itr);
                            }
                    }

                    // we need to confirm this is blizzlike, not sure if it is every 3 minutes
                    for (uint8 j = 0; j < MAX_GLAIVE_THROWERS_SPAWNS_PER_FACTION; ++j)
                    {
                        uint8 type = (nodePoint[i].faction == TEAM_ALLIANCE ? BG_IC_NPC_GLAIVE_THROWER_1_A : BG_IC_NPC_GLAIVE_THROWER_1_H)+j;
                        if (Creature* glaiveThrower = GetBGCreature(type))
                            if (!glaiveThrower->IsAlive())
                            {
                                // Check if creature respawn time is properly saved
                                RespawnMap::iterator itr = respawnMap.find(glaiveThrower->GetGUIDLow());
                                if (itr == respawnMap.end() || time(NULL) < itr->second)
                                    continue;

                                glaiveThrower->Relocate(BG_IC_DocksVehiclesGlaives[j].GetPositionX(), BG_IC_DocksVehiclesGlaives[j].GetPositionY(), BG_IC_DocksVehiclesGlaives[j].GetPositionZ(), BG_IC_DocksVehiclesGlaives[j].GetOrientation());
                                glaiveThrower->Respawn(true);
                                respawnMap.erase(itr);
                            }
                    }

                    docksTimer = DOCKS_UPDATE_TIME;
                }
                else
                    nodePoint[i].timer -= diff;
            }
        }

        if (nodePoint[i].nodeType == NODE_TYPE_WORKSHOP)
        {
            if (nodePoint[i].nodeState == NODE_STATE_CONTROLLED_A ||
                nodePoint[i].nodeState == NODE_STATE_CONTROLLED_H)
            {
                if (siegeEngineWorkshopTimer <= diff)
                {
                    uint8 siegeType = (nodePoint[i].faction == TEAM_ALLIANCE ? BG_IC_NPC_SIEGE_ENGINE_A : BG_IC_NPC_SIEGE_ENGINE_H);
                    if (Creature* siege = GetBGCreature(siegeType)) // this always should be true
                        if (!siege->IsAlive())
                        {
                            // Check if creature respawn time is properly saved
                            RespawnMap::iterator itr = respawnMap.find(siege->GetGUIDLow());
                            if (itr == respawnMap.end() || time(NULL) < itr->second)
                                continue;

                            siege->Relocate(BG_IC_WorkshopVehicles[4].GetPositionX(), BG_IC_WorkshopVehicles[4].GetPositionY(), BG_IC_WorkshopVehicles[4].GetPositionZ(), BG_IC_WorkshopVehicles[4].GetOrientation());
                            siege->Respawn(true);
                            respawnMap.erase(itr);
                        }

                    // we need to confirm this, i am not sure if this every 3 minutes
                    for (uint8 u = 0; u < MAX_DEMOLISHERS_SPAWNS_PER_FACTION; ++u)
                    {
                        
                        uint8 type = (nodePoint[i].faction == TEAM_ALLIANCE ? BG_IC_NPC_DEMOLISHER_1_A : BG_IC_NPC_DEMOLISHER_1_H)+u;
                        if (Creature* demolisher = GetBGCreature(type))
                            if (!demolisher->IsAlive())
                            {
                                // Check if creature respawn time is properly saved
                                RespawnMap::iterator itr = respawnMap.find(demolisher->GetGUIDLow());
                                if (itr == respawnMap.end() || time(NULL) < itr->second)
                                    continue;

                                demolisher->Relocate(BG_IC_WorkshopVehicles[u].GetPositionX(), BG_IC_WorkshopVehicles[u].GetPositionY(), BG_IC_WorkshopVehicles[u].GetPositionZ(), BG_IC_WorkshopVehicles[u].GetOrientation());
                                demolisher->Respawn(true);
                                respawnMap.erase(itr);
                            }
                    }

                    siegeEngineWorkshopTimer = WORKSHOP_UPDATE_TIME;
                }
                else
                    siegeEngineWorkshopTimer -= diff;
            }
        }

        // the point is waiting for a change on its banner
        if (nodePoint[i].needChange)
        {
            if (nodePoint[i].timer <= diff)
            {
                uint32 nextBanner = GetNextBanner(&nodePoint[i], nodePoint[i].faction, true);

                nodePoint[i].last_entry = nodePoint[i].gameobject_entry;
                nodePoint[i].gameobject_entry = nextBanner;
                // nodePoint[i].faction = the faction should be the same one...

                GameObject* banner = GetBGObject(nodePoint[i].gameobject_type);

                if (!banner) // this should never happen
                    return;

                float cords[4] = {banner->GetPositionX(), banner->GetPositionY(), banner->GetPositionZ(), banner->GetOrientation() };

                DelObject(nodePoint[i].gameobject_type);
                AddObject(nodePoint[i].gameobject_type, nodePoint[i].gameobject_entry, cords[0], cords[1], cords[2], cords[3], 0, 0, 0, 0, RESPAWN_ONE_DAY);

                GetBGObject(nodePoint[i].gameobject_type)->SetUInt32Value(GAMEOBJECT_FACTION, nodePoint[i].faction == TEAM_ALLIANCE ? BG_IC_Factions[1] : BG_IC_Factions[0]);

                UpdateNodeWorldState(&nodePoint[i]);
                HandleCapturedNodes(&nodePoint[i], false);

                SendMessage2ToAll(LANG_BG_IC_TEAM_HAS_TAKEN_NODE, CHAT_MSG_BG_SYSTEM_NEUTRAL, NULL, (nodePoint[i].faction == TEAM_ALLIANCE ? LANG_BG_IC_ALLIANCE : LANG_BG_IC_HORDE), nodePoint[i].string);

                nodePoint[i].needChange = false;
                nodePoint[i].timer = BANNER_STATE_CHANGE_TIME;
            } else nodePoint[i].timer -= diff;
        }
    }

    if (resourceTimer <= diff)
    {
        for (uint8 i = 0; i < NODE_TYPE_DOCKS; ++i)
        {
            if (nodePoint[i].nodeState == NODE_STATE_CONTROLLED_A ||
                nodePoint[i].nodeState == NODE_STATE_CONTROLLED_H)
            {
                factionReinforcements[nodePoint[i].faction] += 1;
                RewardHonorToTeam(RESOURCE_HONOR_AMOUNT, nodePoint[i].faction);
                UpdateWorldState((nodePoint[i].faction == TEAM_ALLIANCE ? BG_IC_ALLIANCE_RENFORT : BG_IC_HORDE_RENFORT), factionReinforcements[nodePoint[i].faction]);
            }
        }
        resourceTimer = IC_RESOURCE_TIME;
    } else resourceTimer -= diff;
}

void BattlegroundIC::StartingEventCloseDoors()
{
}

void BattlegroundIC::StartingEventOpenDoors()
{
    //after 20 seconds they should be despawned
    DoorOpen(BG_IC_GO_DOODAD_ND_HUMAN_GATE_CLOSEDFX_DOOR01);
    DoorOpen(BG_IC_GO_DOODAD_ND_WINTERORC_WALL_GATEFX_DOOR01);
    DoorOpen(BG_IC_GO_DOODAD_ND_HUMAN_GATE_CLOSEDFX_DOOR02);
    DoorOpen(BG_IC_GO_DOODAD_ND_WINTERORC_WALL_GATEFX_DOOR02);
    DoorOpen(BG_IC_GO_DOODAD_ND_HUMAN_GATE_CLOSEDFX_DOOR03);
    DoorOpen(BG_IC_GO_DOODAD_ND_WINTERORC_WALL_GATEFX_DOOR03);

    DoorOpen(BG_IC_GO_DOODAD_HU_PORTCULLIS01_1);
    DoorOpen(BG_IC_GO_DOODAD_HU_PORTCULLIS01_2);
    DoorOpen(BG_IC_GO_DOODAD_VR_PORTCULLIS01_1);
    DoorOpen(BG_IC_GO_DOODAD_VR_PORTCULLIS01_2);

    for (uint8 i = 0; i < MAX_FORTRESS_TELEPORTERS_SPAWNS; ++i)
        GetBGObject(BG_IC_Teleporters[i].type)->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);

    for (uint8 i = 0; i < MAX_FORTRESS_TELEPORTER_EFFECTS_SPAWNS; ++i)
        GetBGObject(BG_IC_TeleporterEffects[i].type)->SetGoState(GO_STATE_ACTIVE);
}

bool BattlegroundIC::AllNodesConrolledByTeam(TeamId teamId) const
{
    uint32 count = 0;
    ICNodeState controlledState = teamId == TEAM_ALLIANCE ? NODE_STATE_CONTROLLED_A : NODE_STATE_CONTROLLED_H;
    for (int i = 0; i < NODE_TYPE_WORKSHOP; ++i)
    {
        if (nodePoint[i].nodeState == controlledState)
            ++count;
    }

    return count == NODE_TYPE_WORKSHOP;
}

bool BattlegroundIC::IsResourceGlutAllowed(TeamId teamId) const
{
    ICNodeState controlledState = teamId == TEAM_ALLIANCE ? NODE_STATE_CONTROLLED_A : NODE_STATE_CONTROLLED_H;
    return nodePoint[NODE_TYPE_QUARRY].nodeState == controlledState && nodePoint[NODE_TYPE_REFINERY].nodeState == controlledState;
}

void BattlegroundIC::AddPlayer(Player* player)
{
    Battleground::AddPlayer(player);
    PlayerScores[player->GetGUID()] = new BattlegroundICScore(player);

    if (nodePoint[NODE_TYPE_QUARRY].nodeState == (player->GetTeamId() == TEAM_ALLIANCE ? NODE_STATE_CONTROLLED_A : NODE_STATE_CONTROLLED_H))
        player->CastSpell(player, SPELL_QUARRY, true);

    if (nodePoint[NODE_TYPE_REFINERY].nodeState == (player->GetTeamId() == TEAM_ALLIANCE ? NODE_STATE_CONTROLLED_A : NODE_STATE_CONTROLLED_H))
        player->CastSpell(player, SPELL_OIL_REFINERY, true);
}

void BattlegroundIC::RemovePlayer(Player* player)
{
    player->RemoveAura(SPELL_QUARRY);
    player->RemoveAura(SPELL_OIL_REFINERY);
}

void BattlegroundIC::HandleAreaTrigger(Player* player, uint32 trigger)
{
    // this is wrong way to implement these things. On official it done by gameobject spell cast.
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    switch (trigger)
    {
        case AREA_TRIGGER_HORDE_KEEP:
            if (player->GetTeamId() != TEAM_ALLIANCE)
                return;
            for (uint8 i = BG_IC_H_FRONT; i < BG_IC_A_FRONT; ++i)
                if (GateStatus[i] == BG_IC_GATE_DESTROYED)
                    return;
            if (!player->HasAchieved(3854)) // ACHIEVEMENT_BACK_DOOR_JOB
                player->CastSpell(player, SPELL_BACK_DOOR_JOB, true);
            break;
        case AREA_TRIGGER_ALLIANCE_KEEP:
            if (player->GetTeamId() != TEAM_HORDE)
                return;
            for (uint8 i = BG_IC_A_FRONT; i < BG_IC_MAXDOOR; ++i)
                if (GateStatus[i] == BG_IC_GATE_DESTROYED)
                    return;
            if (!player->HasAchieved(3854)) // ACHIEVEMENT_BACK_DOOR_JOB
                player->CastSpell(player, SPELL_BACK_DOOR_JOB, true);
            break;
    }

}

void BattlegroundIC::UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor)
{
    std::map<uint64, BattlegroundScore*>::iterator itr = PlayerScores.find(player->GetGUID());
    if (itr == PlayerScores.end())
        return;

    switch (type)
    {
        case SCORE_BASES_ASSAULTED:
            ((BattlegroundICScore*)itr->second)->BasesAssaulted += value;
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, IC_OBJECTIVE_ASSAULT_BASE);
            break;
        case SCORE_BASES_DEFENDED:
            ((BattlegroundICScore*)itr->second)->BasesDefended += value;
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, IC_OBJECTIVE_DEFEND_BASE);
            break;
        default:
            Battleground::UpdatePlayerScore(player, type, value, doAddHonor);
            break;
    }
}

void BattlegroundIC::FillInitialWorldStates(WorldPacket& data)
{
    data << uint32(BG_IC_ALLIANCE_RENFORT_SET) << uint32(1);
    data << uint32(BG_IC_HORDE_RENFORT_SET) << uint32(1);
    data << uint32(BG_IC_ALLIANCE_RENFORT) << uint32(factionReinforcements[TEAM_ALLIANCE]);
    data << uint32(BG_IC_HORDE_RENFORT) << uint32(factionReinforcements[TEAM_HORDE]);

    for (uint8 i = 0; i < MAX_FORTRESS_GATES_SPAWNS; ++i)
    {
        uint32 uws = GetWorldStateFromGateEntry(BG_IC_ObjSpawnlocs[i].entry, (GateStatus[GetGateIDFromEntry(BG_IC_ObjSpawnlocs[i].entry)] == BG_IC_GATE_DESTROYED ? true : false));
        data << uint32(uws) << uint32(1);
    }

    for (uint8 i = 0; i < MAX_NODE_TYPES; ++i)
        data << uint32(nodePoint[i].worldStates[nodePoint[i].nodeState]) << uint32(1);
}

bool BattlegroundIC::SetupBattleground()
{
    for (uint8 i = 0; i < MAX_NORMAL_GAMEOBJECTS_SPAWNS; ++i)
    {
        if (!AddObject(BG_IC_ObjSpawnlocs[i].type, BG_IC_ObjSpawnlocs[i].entry, BG_IC_ObjSpawnlocs[i].x, BG_IC_ObjSpawnlocs[i].y, BG_IC_ObjSpawnlocs[i].z, BG_IC_ObjSpawnlocs[i].o, 0, 0, 0, 0, RESPAWN_ONE_DAY))
        {
            sLog->outError("Isle of Conquest: There was an error spawning gameobject %u", BG_IC_ObjSpawnlocs[i].entry);
            return false;
        }

        // Horde / Alliance gates, set active
        if (i < 6)
            GetBGObject(BG_IC_ObjSpawnlocs[i].type)->setActive(true);
    }

    for (uint8 i = 0; i < MAX_FORTRESS_TELEPORTERS_SPAWNS; ++i)
    {
        if (!AddObject(BG_IC_Teleporters[i].type, BG_IC_Teleporters[i].entry, BG_IC_Teleporters[i].x, BG_IC_Teleporters[i].y, BG_IC_Teleporters[i].z, BG_IC_Teleporters[i].o, 0, 0, 0, 0, RESPAWN_ONE_DAY))
        {
            sLog->outError("Isle of Conquest | Starting Event Open Doors: There was an error spawning gameobject %u", BG_IC_Teleporters[i].entry);
            return false;
        }
    }

    for (uint8 i = 0; i < MAX_FORTRESS_TELEPORTER_EFFECTS_SPAWNS; ++i)
    {
        if (!AddObject(BG_IC_TeleporterEffects[i].type, BG_IC_TeleporterEffects[i].entry, BG_IC_TeleporterEffects[i].x, BG_IC_TeleporterEffects[i].y, BG_IC_TeleporterEffects[i].z, BG_IC_TeleporterEffects[i].o, 0, 0, 0, 0, RESPAWN_ONE_DAY))
        {
            sLog->outError("Isle of Conquest | Starting Event Open Doors: There was an error spawning gameobject %u", BG_IC_Teleporters[i].entry);
            return false;
        }
    }

    for (uint8 i = 0; i < MAX_NORMAL_NPCS_SPAWNS; ++i)
    {
        if (!AddCreature(BG_IC_NpcSpawnlocs[i].entry, BG_IC_NpcSpawnlocs[i].type, BG_IC_NpcSpawnlocs[i].x, BG_IC_NpcSpawnlocs[i].y, BG_IC_NpcSpawnlocs[i].z, BG_IC_NpcSpawnlocs[i].o, RESPAWN_ONE_DAY))
        {
            sLog->outError("Isle of Conquest: There was an error spawning creature %u", BG_IC_NpcSpawnlocs[i].entry);
            return false;
        }
    }

    if (!AddSpiritGuide(BG_IC_NPC_SPIRIT_GUIDE_1+3, BG_IC_SpiritGuidePos[5][0], BG_IC_SpiritGuidePos[5][1], BG_IC_SpiritGuidePos[5][2], BG_IC_SpiritGuidePos[5][3], TEAM_ALLIANCE)
        || !AddSpiritGuide(BG_IC_NPC_SPIRIT_GUIDE_1+4, BG_IC_SpiritGuidePos[6][0], BG_IC_SpiritGuidePos[6][1], BG_IC_SpiritGuidePos[6][2], BG_IC_SpiritGuidePos[6][3], TEAM_HORDE)
        || !AddSpiritGuide(BG_IC_NPC_SPIRIT_GUIDE_1+5, BG_IC_SpiritGuidePos[7][0], BG_IC_SpiritGuidePos[7][1], BG_IC_SpiritGuidePos[7][2], BG_IC_SpiritGuidePos[7][3], TEAM_ALLIANCE)
        || !AddSpiritGuide(BG_IC_NPC_SPIRIT_GUIDE_1+6, BG_IC_SpiritGuidePos[8][0], BG_IC_SpiritGuidePos[8][1], BG_IC_SpiritGuidePos[8][2], BG_IC_SpiritGuidePos[8][3], TEAM_HORDE))
    {
        sLog->outError("Isle of Conquest: Failed to spawn initial spirit guide!");
        return false;
    }

    gunshipHorde = sTransportMgr->CreateTransport(GO_HORDE_GUNSHIP, 0, GetBgMap());
    gunshipAlliance = sTransportMgr->CreateTransport(GO_ALLIANCE_GUNSHIP, 0, GetBgMap());

    if (!gunshipAlliance || !gunshipHorde)
    {
        sLog->outError("Isle of Conquest: There was an error creating gunships!");
        return false;
    }

    gunshipHorde->EnableMovement(false);
    gunshipAlliance->EnableMovement(false);

    // setting correct factions for Keep Cannons
    for (uint8 i = BG_IC_NPC_KEEP_CANNON_1; i <= BG_IC_NPC_KEEP_CANNON_12; ++i)
        GetBGCreature(i)->setFaction(BG_IC_Factions[0]);
    for (uint8 i = BG_IC_NPC_KEEP_CANNON_13; i <= BG_IC_NPC_KEEP_CANNON_25; ++i)
        GetBGCreature(i)->setFaction(BG_IC_Factions[1]);
    // Flags
    if (GameObject* go = GetBGObject(BG_IC_GO_ALLIANCE_BANNER))
    {
        go->SetUInt32Value(GAMEOBJECT_FACTION, BG_IC_Factions[1]);
        go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
    }
    if (GameObject* go = GetBGObject(BG_IC_GO_HORDE_BANNER))
    {
        go->SetUInt32Value(GAMEOBJECT_FACTION, BG_IC_Factions[0]);
        go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
    }

    // correcting spawn time for keeps bombs
    for (uint8 i = BG_IC_GO_HUGE_SEAFORIUM_BOMBS_A_1; i < BG_IC_GO_HUGE_SEAFORIUM_BOMBS_H_4; ++i)
        GetBGObject(i)->SetRespawnTime(10);

    TurnBosses(false);
    return true;
}

void BattlegroundIC::TurnBosses(bool on)
{
    // Make Bosses invisible and passive
    // or visible and active
    if (Creature* boss = GetBGCreature(BG_IC_NPC_OVERLORD_AGMAR))
    {
        boss->SetVisible(on);
        boss->SetReactState(on ? REACT_AGGRESSIVE : REACT_PASSIVE);
    }
    if (Creature* boss = GetBGCreature(BG_IC_NPC_HIGH_COMMANDER_HALFORD_WYRMBANE))
    {
        boss->SetVisible(on);
        boss->SetReactState(on ? REACT_AGGRESSIVE : REACT_PASSIVE);
    }
}

void BattlegroundIC::HandleKillUnit(Creature* unit, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
       return;

    uint32 entry = unit->GetEntry();
    if (entry == NPC_HIGH_COMMANDER_HALFORD_WYRMBANE)
    {
        RewardHonorToTeam(WINNER_HONOR_AMOUNT, TEAM_HORDE);
        EndBattleground(TEAM_HORDE);
    }
    else if (entry == NPC_OVERLORD_AGMAR)
    {
        RewardHonorToTeam(WINNER_HONOR_AMOUNT, TEAM_ALLIANCE);
        EndBattleground(TEAM_ALLIANCE);
    }

    //Achievement Mowed Down
    // TO-DO: This should be done on the script of each vehicle of the BG.
    if (unit->IsVehicle())
    {
        killer->CastSpell(killer, SPELL_DESTROYED_VEHICLE_ACHIEVEMENT, true);
        
        // Xinef: Add to respawn list
        if (entry == NPC_DEMOLISHER || entry == NPC_SIEGE_ENGINE_H || entry == NPC_SIEGE_ENGINE_A || 
            entry == NPC_GLAIVE_THROWER_A || entry == NPC_GLAIVE_THROWER_H || entry == NPC_CATAPULT)
            respawnMap[unit->GetGUIDLow()] = time(NULL) + VEHICLE_RESPAWN_TIME;
    }
}

void BattlegroundIC::HandleKillPlayer(Player* player, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    Battleground::HandleKillPlayer(player, killer);

    factionReinforcements[player->GetTeamId()] -= 1;

    UpdateWorldState((player->GetTeamId() == TEAM_ALLIANCE ? BG_IC_ALLIANCE_RENFORT : BG_IC_HORDE_RENFORT), factionReinforcements[player->GetTeamId()]);

    // we must end the battleground
    if (factionReinforcements[player->GetTeamId()] < 1)
        EndBattleground(killer->GetTeamId());
}

void BattlegroundIC::EndBattleground(TeamId winnerTeamId)
{
    SendMessage2ToAll(LANG_BG_IC_TEAM_WINS, CHAT_MSG_BG_SYSTEM_NEUTRAL, NULL, (winnerTeamId == TEAM_ALLIANCE ? LANG_BG_IC_ALLIANCE : LANG_BG_IC_HORDE));
    Battleground::EndBattleground(winnerTeamId);
}

void BattlegroundIC::EventPlayerClickedOnFlag(Player* player, GameObject* gameObject)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    // All the node points are iterated to find the clicked one
    for (uint8 i = 0; i < MAX_NODE_TYPES; ++i)
    {
        if (nodePoint[i].gameobject_entry == gameObject->GetEntry())
        {
            // THIS SHOULD NEEVEER HAPPEN
            if (nodePoint[i].faction == player->GetTeamId())
                return;

            // Prevent capturing of keep if none of gates was destroyed
            if (nodePoint[i].gameobject_entry == GO_ALLIANCE_BANNER)
            {
                if (GateStatus[BG_IC_A_FRONT] != BG_IC_GATE_DESTROYED && 
                    GateStatus[BG_IC_A_WEST] != BG_IC_GATE_DESTROYED && 
                    GateStatus[BG_IC_A_EAST] != BG_IC_GATE_DESTROYED)
                    return;
            }
            else if (nodePoint[i].gameobject_entry == GO_HORDE_BANNER)
            {
                if (GateStatus[BG_IC_H_FRONT] != BG_IC_GATE_DESTROYED && 
                    GateStatus[BG_IC_H_WEST] != BG_IC_GATE_DESTROYED && 
                    GateStatus[BG_IC_H_EAST] != BG_IC_GATE_DESTROYED)
                    return;
            }

            uint32 nextBanner = GetNextBanner(&nodePoint[i], player->GetTeamId(), false);

            // we set the new settings of the nodePoint
            nodePoint[i].faction = player->GetTeamId();
            nodePoint[i].last_entry = nodePoint[i].gameobject_entry;
            nodePoint[i].gameobject_entry = nextBanner;

            // this is just needed if the next banner is grey
            if (nodePoint[i].banners[BANNER_A_CONTESTED] == nextBanner || nodePoint[i].banners[BANNER_H_CONTESTED] == nextBanner)
            {
                nodePoint[i].timer = BANNER_STATE_CHANGE_TIME; // 1 minute for last change (real faction banner)
                nodePoint[i].needChange = true;

                RelocateDeadPlayers(BgCreatures[BG_IC_NPC_SPIRIT_GUIDE_1 + nodePoint[i].nodeType - 2]);

                // if we are here means that the point has been lost, or it is the first capture

                if (nodePoint[i].nodeType != NODE_TYPE_REFINERY && nodePoint[i].nodeType != NODE_TYPE_QUARRY)
                    if (BgCreatures[BG_IC_NPC_SPIRIT_GUIDE_1+(nodePoint[i].nodeType)-2])
                        DelCreature(BG_IC_NPC_SPIRIT_GUIDE_1+(nodePoint[i].nodeType)-2);

                UpdatePlayerScore(player, SCORE_BASES_ASSAULTED, 1);

                SendMessage2ToAll(LANG_BG_IC_TEAM_ASSAULTED_NODE_1, CHAT_MSG_BG_SYSTEM_NEUTRAL, player, nodePoint[i].string);
                SendMessage2ToAll(LANG_BG_IC_TEAM_ASSAULTED_NODE_2, CHAT_MSG_BG_SYSTEM_NEUTRAL, player, nodePoint[i].string, (player->GetTeamId() == TEAM_ALLIANCE ? LANG_BG_IC_ALLIANCE : LANG_BG_IC_HORDE));
                HandleContestedNodes(&nodePoint[i]);
            }
            else if (nextBanner == nodePoint[i].banners[BANNER_A_CONTROLLED] || nextBanner == nodePoint[i].banners[BANNER_H_CONTROLLED])
                       // if we are going to spawn the definitve faction banner, we dont need the timer anymore
            {
                nodePoint[i].timer = BANNER_STATE_CHANGE_TIME;
                nodePoint[i].needChange = false;
                SendMessage2ToAll(LANG_BG_IC_TEAM_DEFENDED_NODE, CHAT_MSG_BG_SYSTEM_NEUTRAL, player, nodePoint[i].string);
                HandleCapturedNodes(&nodePoint[i], true);
                UpdatePlayerScore(player, SCORE_BASES_DEFENDED, 1);
            }

            GameObject* banner = GetBGObject(nodePoint[i].gameobject_type);

            if (!banner) // this should never happen
                return;

            float cords[4] = {banner->GetPositionX(), banner->GetPositionY(), banner->GetPositionZ(), banner->GetOrientation() };

            DelObject(nodePoint[i].gameobject_type);
            AddObject(nodePoint[i].gameobject_type, nodePoint[i].gameobject_entry, cords[0], cords[1], cords[2], cords[3], 0, 0, 0, 0, RESPAWN_ONE_DAY);

            GetBGObject(nodePoint[i].gameobject_type)->SetUInt32Value(GAMEOBJECT_FACTION, nodePoint[i].faction == TEAM_ALLIANCE ? BG_IC_Factions[1] : BG_IC_Factions[0]);

            UpdateNodeWorldState(&nodePoint[i]);
            // we dont need iterating if we are here
            // If the needChange bool was set true, we will handle the rest in the Update Map function.
            return;
        }
    }
}

void BattlegroundIC::UpdateNodeWorldState(ICNodePoint* nodePoint)
{
    //updating worldstate
    if (nodePoint->gameobject_entry == nodePoint->banners[BANNER_A_CONTROLLED])
        nodePoint->nodeState = NODE_STATE_CONTROLLED_A;
    else if (nodePoint->gameobject_entry == nodePoint->banners[BANNER_A_CONTESTED])
        nodePoint->nodeState = NODE_STATE_CONFLICT_A;
    else if (nodePoint->gameobject_entry == nodePoint->banners[BANNER_H_CONTROLLED])
        nodePoint->nodeState = NODE_STATE_CONTROLLED_H;
    else if (nodePoint->gameobject_entry == nodePoint->banners[BANNER_H_CONTESTED])
        nodePoint->nodeState = NODE_STATE_CONFLICT_H;

    uint32 worldstate = nodePoint->worldStates[nodePoint->nodeState];

    // with this we are sure we dont bug the client
    for (uint8 i = 0; i < 5; ++i)
        UpdateWorldState(nodePoint->worldStates[i], 0);

    UpdateWorldState(worldstate, 1);
}

uint32 BattlegroundIC::GetNextBanner(ICNodePoint* nodePoint, uint32 team, bool returnDefinitve)
{
    // this is only used in the update map function
    if (returnDefinitve)
        // here is a special case, here we must return the definitve faction banner after the grey banner was spawned 1 minute
        return nodePoint->banners[(team == TEAM_ALLIANCE ? BANNER_A_CONTROLLED : BANNER_H_CONTROLLED)];

    // there were no changes, this point has never been captured by any faction or at least clicked
    if (nodePoint->last_entry == 0)
        // 1 returns the CONTESTED ALLIANCE BANNER, 3 returns the HORDE one
        return nodePoint->banners[(team == TEAM_ALLIANCE ? BANNER_A_CONTESTED : BANNER_H_CONTESTED)];

    // If the actual banner is the definitive faction banner, we must return the grey banner of the player's faction
    if (nodePoint->gameobject_entry == nodePoint->banners[BANNER_A_CONTROLLED] || nodePoint->gameobject_entry == nodePoint->banners[BANNER_H_CONTROLLED])
        return nodePoint->banners[(team == TEAM_ALLIANCE ? BANNER_A_CONTESTED : BANNER_H_CONTESTED)];

    // If the actual banner is the grey faction banner, we must return the previous banner
    if (nodePoint->gameobject_entry == nodePoint->banners[BANNER_A_CONTESTED] || nodePoint->banners[BANNER_H_CONTESTED])
        return nodePoint->last_entry;

    // we should never be here...
    sLog->outError("Isle Of Conquest: Unexpected return in GetNextBanner function");
    return 0;
}

void BattlegroundIC::HandleContestedNodes(ICNodePoint* nodePoint)
{
    if (nodePoint->nodeType == NODE_TYPE_HANGAR)
    {
        if (gunshipAlliance && gunshipHorde)
            (nodePoint->faction == TEAM_ALLIANCE ? gunshipHorde : gunshipAlliance)->EnableMovement(false);

        for (uint8 u = BG_IC_GO_HANGAR_TELEPORTER_1; u <= BG_IC_GO_HANGAR_TELEPORTER_3; ++u)
            DelObject(u);

        for (uint8 u = BG_IC_GO_HANGAR_TELEPORTER_EFFECT_1; u <= BG_IC_GO_HANGAR_TELEPORTER_EFFECT_3; ++u)
            DelObject(u);

        DelCreature(BG_IC_NPC_WORLD_TRIGGER_NOT_FLOATING);

        for (uint8 u = 0; u < MAX_CAPTAIN_SPAWNS_PER_FACTION; ++u)
        {
            uint8 type = BG_IC_NPC_GUNSHIP_CAPTAIN_1 + u;
            DelCreature(type);
        }

        std::list<Creature*> cannons;
        if (nodePoint->faction == TEAM_HORDE)
            gunshipAlliance->GetCreatureListWithEntryInGrid(cannons, NPC_ALLIANCE_GUNSHIP_CANNON, 150.0f);
        else
            gunshipHorde->GetCreatureListWithEntryInGrid(cannons, NPC_HORDE_GUNSHIP_CANNON, 150.0f);

        for (std::list<Creature*>::const_iterator itr = cannons.begin(); itr != cannons.end(); ++itr)
        {
            (*itr)->GetVehicleKit()->RemoveAllPassengers();
            (*itr)->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }
    }
    else if (nodePoint->nodeType == NODE_TYPE_WORKSHOP)
    {
        DelObject(BG_IC_GO_SEAFORIUM_BOMBS_1);
        DelObject(BG_IC_GO_SEAFORIUM_BOMBS_2);
    }
}

void BattlegroundIC::HandleCapturedNodes(ICNodePoint* nodePoint, bool recapture)
{
    if (nodePoint->nodeType != NODE_TYPE_REFINERY && nodePoint->nodeType != NODE_TYPE_QUARRY)
    {
        if (!AddSpiritGuide(BG_IC_NPC_SPIRIT_GUIDE_1+nodePoint->nodeType-2,
            BG_IC_SpiritGuidePos[nodePoint->nodeType][0], BG_IC_SpiritGuidePos[nodePoint->nodeType][1],
            BG_IC_SpiritGuidePos[nodePoint->nodeType][2], BG_IC_SpiritGuidePos[nodePoint->nodeType][3],
            nodePoint->faction))
            sLog->outError("Isle of Conquest: Failed to spawn spirit guide! point: %u, team: %u, ", nodePoint->nodeType, nodePoint->faction);
    }

    switch (nodePoint->gameobject_type)
    {
        case BG_IC_GO_HANGAR_BANNER:
        {
            if (!gunshipAlliance || !gunshipHorde)
                break;

            std::list<Creature*> cannons;
            if (nodePoint->faction == TEAM_ALLIANCE)
                gunshipAlliance->GetCreatureListWithEntryInGrid(cannons, NPC_ALLIANCE_GUNSHIP_CANNON, 150.0f);
            else
                gunshipHorde->GetCreatureListWithEntryInGrid(cannons, NPC_HORDE_GUNSHIP_CANNON, 150.0f);

            for (std::list<Creature*>::const_iterator itr = cannons.begin(); itr != cannons.end(); ++itr)
                (*itr)->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

            for (uint8 u = 0; u < MAX_HANGAR_TELEPORTERS_SPAWNS; ++u)
            {
                uint8 type = BG_IC_GO_HANGAR_TELEPORTER_1 + u;
                if (!AddObject(type, (nodePoint->faction == TEAM_ALLIANCE ? GO_ALLIANCE_GUNSHIP_PORTAL : GO_HORDE_GUNSHIP_PORTAL), BG_IC_HangarTeleporters[u].GetPositionX(), BG_IC_HangarTeleporters[u].GetPositionY(), BG_IC_HangarTeleporters[u].GetPositionZ(), BG_IC_HangarTeleporters[u].GetOrientation(), 0, 0, 0, 0, RESPAWN_ONE_DAY))
                    sLog->outError("Isle of Conquest: There was an error spawning a gunship portal. Type: %u", BG_IC_GO_HANGAR_TELEPORTER_1 + u);
            }

            for (uint8 u = 0; u < MAX_HANGAR_TELEPORTER_EFFECTS_SPAWNS; ++u)
            {
                uint8 type = BG_IC_GO_HANGAR_TELEPORTER_EFFECT_1 + u;
                if (!AddObject(type, (nodePoint->faction == TEAM_ALLIANCE ? GO_ALLIANCE_GUNSHIP_PORTAL_EFFECTS : GO_HORDE_GUNSHIP_PORTAL_EFFECTS), BG_IC_HangarTeleporterEffects[u].GetPositionX(), BG_IC_HangarTeleporterEffects[u].GetPositionY(), BG_IC_HangarTeleporterEffects[u].GetPositionZ(), BG_IC_HangarTeleporterEffects[u].GetOrientation(), 0, 0, 0, 0, RESPAWN_ONE_DAY, GO_STATE_ACTIVE))
                    sLog->outError("Isle of Conquest: There was an error spawning a gunship portal effects. Type: %u", BG_IC_GO_HANGAR_TELEPORTER_1 + u);
            }

            for (uint8 u = 0; u < MAX_TRIGGER_SPAWNS_PER_FACTION; ++u)
            {
                if (!AddCreature(NPC_WORLD_TRIGGER_NOT_FLOATING, BG_IC_NPC_WORLD_TRIGGER_NOT_FLOATING, BG_IC_HangarTrigger[nodePoint->faction].GetPositionX(), BG_IC_HangarTrigger[nodePoint->faction].GetPositionY(), BG_IC_HangarTrigger[nodePoint->faction].GetPositionZ(), BG_IC_HangarTrigger[nodePoint->faction].GetOrientation(), RESPAWN_ONE_DAY, nodePoint->faction == TEAM_ALLIANCE ? gunshipAlliance : gunshipHorde))
                    sLog->outError("Isle of Conquest: There was an error spawning a world trigger. Type: %u", BG_IC_NPC_WORLD_TRIGGER_NOT_FLOATING);
            }

            for (uint8 u = 0; u < MAX_CAPTAIN_SPAWNS_PER_FACTION; ++u)
            {
                uint8 type = BG_IC_NPC_GUNSHIP_CAPTAIN_1 + u;

                if (type == BG_IC_NPC_GUNSHIP_CAPTAIN_1)
                    if (AddCreature(nodePoint->faction == TEAM_ALLIANCE ? NPC_ALLIANCE_GUNSHIP_CAPTAIN : NPC_HORDE_GUNSHIP_CAPTAIN, type, BG_IC_HangarCaptains[nodePoint->faction == TEAM_ALLIANCE ? 2 : 0].GetPositionX(), BG_IC_HangarCaptains[nodePoint->faction == TEAM_ALLIANCE ? 2 : 0].GetPositionY(), BG_IC_HangarCaptains[nodePoint->faction == TEAM_ALLIANCE ? 2 : 0].GetPositionZ(), BG_IC_HangarCaptains[nodePoint->faction == TEAM_ALLIANCE ? 2 : 0].GetOrientation(), RESPAWN_ONE_DAY))
                        GetBGCreature(BG_IC_NPC_GUNSHIP_CAPTAIN_1)->GetAI()->DoAction(ACTION_GUNSHIP_READY);

                if (type == BG_IC_NPC_GUNSHIP_CAPTAIN_2)
                    if (!AddCreature(nodePoint->faction == TEAM_ALLIANCE ? NPC_ALLIANCE_GUNSHIP_CAPTAIN : NPC_HORDE_GUNSHIP_CAPTAIN, type, BG_IC_HangarCaptains[nodePoint->faction == TEAM_ALLIANCE ? 3 : 1].GetPositionX(), BG_IC_HangarCaptains[nodePoint->faction == TEAM_ALLIANCE ? 3 : 1].GetPositionY(), BG_IC_HangarCaptains[nodePoint->faction == TEAM_ALLIANCE ? 3 : 1].GetPositionZ(), BG_IC_HangarCaptains[nodePoint->faction == TEAM_ALLIANCE ? 3 : 1].GetOrientation(), RESPAWN_ONE_DAY, nodePoint->faction == TEAM_ALLIANCE ? gunshipAlliance : gunshipHorde))
                        sLog->outError("Isle of Conquest: There was an error spawning a world trigger. Type: %u", BG_IC_NPC_GUNSHIP_CAPTAIN_2);
            }

            (nodePoint->faction == TEAM_ALLIANCE ? gunshipAlliance : gunshipHorde)->EnableMovement(true);
            break;
        }
        case BG_IC_GO_QUARRY_BANNER:
            RemoveAuraOnTeam(SPELL_QUARRY, GetOtherTeamId(nodePoint->faction));
            CastSpellOnTeam(SPELL_QUARRY, nodePoint->faction);
            break;
        case BG_IC_GO_REFINERY_BANNER:
            RemoveAuraOnTeam(SPELL_OIL_REFINERY, GetOtherTeamId(nodePoint->faction));
            CastSpellOnTeam(SPELL_OIL_REFINERY, nodePoint->faction);
            break;
        case BG_IC_GO_DOCKS_BANNER:
            if (recapture)
                break;

            if (docksTimer < DOCKS_UPDATE_TIME)
                docksTimer = DOCKS_UPDATE_TIME;

            // spawning glaive throwers
            for (uint8 i = 0; i < MAX_GLAIVE_THROWERS_SPAWNS_PER_FACTION; ++i)
            {
                uint8 type = (nodePoint->faction == TEAM_ALLIANCE ? BG_IC_NPC_GLAIVE_THROWER_1_A : BG_IC_NPC_GLAIVE_THROWER_1_H)+i;

                if (GetBGCreature(type))
                    continue;

                if (AddCreature(nodePoint->faction == TEAM_ALLIANCE ? NPC_GLAIVE_THROWER_A : NPC_GLAIVE_THROWER_H, type,
                        BG_IC_DocksVehiclesGlaives[i].GetPositionX(), BG_IC_DocksVehiclesGlaives[i].GetPositionY(),
                        BG_IC_DocksVehiclesGlaives[i].GetPositionZ(), BG_IC_DocksVehiclesGlaives[i].GetOrientation(),
                        RESPAWN_ONE_DAY))
                        GetBGCreature(type)->setFaction(BG_IC_Factions[nodePoint->faction]);
            }

            // spawning catapults
            for (uint8 i = 0; i < MAX_CATAPULTS_SPAWNS_PER_FACTION; ++i)
            {
                uint8 type = (nodePoint->faction == TEAM_ALLIANCE ? BG_IC_NPC_CATAPULT_1_A : BG_IC_NPC_CATAPULT_1_H)+i;

                if (GetBGCreature(type))
                    continue;

                if (AddCreature(NPC_CATAPULT, type,
                        BG_IC_DocksVehiclesCatapults[i].GetPositionX(), BG_IC_DocksVehiclesCatapults[i].GetPositionY(),
                        BG_IC_DocksVehiclesCatapults[i].GetPositionZ(), BG_IC_DocksVehiclesCatapults[i].GetOrientation(),
                        RESPAWN_ONE_DAY))
                        GetBGCreature(type)->setFaction(BG_IC_Factions[(nodePoint->faction == TEAM_ALLIANCE ? 0 : 1)]);
            }
            break;
        case BG_IC_GO_WORKSHOP_BANNER:
            {
                if (siegeEngineWorkshopTimer < WORKSHOP_UPDATE_TIME)
                    siegeEngineWorkshopTimer = WORKSHOP_UPDATE_TIME;

                if (!recapture)
                {
                    for (uint8 i = 0; i < MAX_DEMOLISHERS_SPAWNS_PER_FACTION; ++i)
                    {
                        uint8 type = (nodePoint->faction == TEAM_ALLIANCE ? BG_IC_NPC_DEMOLISHER_1_A : BG_IC_NPC_DEMOLISHER_1_H)+i;

                        if (GetBGCreature(type))
                            continue;

                        if (AddCreature(NPC_DEMOLISHER, type,
                            BG_IC_WorkshopVehicles[i].GetPositionX(), BG_IC_WorkshopVehicles[i].GetPositionY(),
                            BG_IC_WorkshopVehicles[i].GetPositionZ(), BG_IC_WorkshopVehicles[i].GetOrientation(),
                            RESPAWN_ONE_DAY))
                            GetBGCreature(type)->setFaction(BG_IC_Factions[(nodePoint->faction == TEAM_ALLIANCE ? 0 : 1)]);
                    }

                    uint8 siegeType = (nodePoint->faction == TEAM_ALLIANCE ? BG_IC_NPC_SIEGE_ENGINE_A : BG_IC_NPC_SIEGE_ENGINE_H);
                    if (!GetBGCreature(siegeType))
                    {
                        AddCreature((nodePoint->faction == TEAM_ALLIANCE ? NPC_SIEGE_ENGINE_A : NPC_SIEGE_ENGINE_H), siegeType,
                            BG_IC_WorkshopVehicles[4].GetPositionX(), BG_IC_WorkshopVehicles[4].GetPositionY(),
                            BG_IC_WorkshopVehicles[4].GetPositionZ(), BG_IC_WorkshopVehicles[4].GetOrientation(),
                            RESPAWN_ONE_DAY);
                    }

                    if (Creature* siegeEngine = GetBGCreature(siegeType))
                    {
                        siegeEngine->setFaction(BG_IC_Factions[(nodePoint->faction == TEAM_ALLIANCE ? 0 : 1)]);
                        siegeEngine->SetCorpseDelay(5*MINUTE);

                        if (siegeEngine->IsAlive())
                            if (Vehicle* siegeVehicle = siegeEngine->GetVehicleKit())
                                if (!siegeVehicle->IsVehicleInUse())
                                    Unit::Kill(siegeEngine, siegeEngine);

                        respawnMap[siegeEngine->GetGUIDLow()] = time(NULL) + VEHICLE_RESPAWN_TIME;
                    }
                }

                for (uint8 i = 0; i < MAX_WORKSHOP_BOMBS_SPAWNS_PER_FACTION; ++i)
                {
                    AddObject(BG_IC_GO_SEAFORIUM_BOMBS_1+i, GO_SEAFORIUM_BOMBS,
                    workshopBombs[i].GetPositionX(), workshopBombs[i].GetPositionY(),
                    workshopBombs[i].GetPositionZ(), workshopBombs[i].GetOrientation(),
                    0, 0, 0, 0, 10);

                    if (GameObject* seaforiumBombs = GetBGObject(BG_IC_GO_SEAFORIUM_BOMBS_1+i))
                    {
                        seaforiumBombs->SetRespawnTime(10);
                        seaforiumBombs->SetUInt32Value(GAMEOBJECT_FACTION, BG_IC_Factions[(nodePoint->faction == TEAM_ALLIANCE ? 0 : 1)]);
                    }
                }
                break;
            }
        default:
            break;
    }
}

void BattlegroundIC::DestroyGate(Player*  /*player*/, GameObject* go)
{
    GateStatus[GetGateIDFromEntry(go->GetEntry())] = BG_IC_GATE_DESTROYED;
    uint32 uws_open = GetWorldStateFromGateEntry(go->GetEntry(), true);
    uint32 uws_close = GetWorldStateFromGateEntry(go->GetEntry(), false);
    if (uws_open)
    {
        UpdateWorldState(uws_close, 0);
        UpdateWorldState(uws_open, 1);
    }

    TeamId teamId = TEAM_ALLIANCE;
    uint32 lang_entry = 0;
    switch (go->GetEntry())
    {
        case GO_HORDE_GATE_1:
            lang_entry = LANG_BG_IC_NORTH_GATE_DESTROYED;
            break;
        case GO_HORDE_GATE_2:
            lang_entry = LANG_BG_IC_EAST_GATE_DESTROYED;
            break;
        case GO_HORDE_GATE_3:
            lang_entry = LANG_BG_IC_WEST_GATE_DESTROYED;
            break;
        case GO_ALLIANCE_GATE_1:
            teamId = TEAM_HORDE;
            lang_entry = LANG_BG_IC_WEST_GATE_DESTROYED;
            break;
        case GO_ALLIANCE_GATE_2:
            teamId = TEAM_HORDE;
            lang_entry = LANG_BG_IC_EAST_GATE_DESTROYED;
            break;
        case GO_ALLIANCE_GATE_3:
            teamId = TEAM_HORDE;
            lang_entry = LANG_BG_IC_SOUTH_GATE_DESTROYED;
            break;
        default:
            break;
    }

    if (teamId == TEAM_ALLIANCE)
    {
        DoorOpen(BG_IC_GO_HORDE_KEEP_PORTCULLIS);
        GetBGObject(BG_IC_GO_HORDE_BANNER)->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
    }
    else
    {
        DoorOpen(BG_IC_GO_DOODAD_PORTCULLISACTIVE02);
        GetBGObject(BG_IC_GO_ALLIANCE_BANNER)->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
    }

    TurnBosses(true);
    SendMessage2ToAll(lang_entry, CHAT_MSG_BG_SYSTEM_NEUTRAL, NULL, (teamId == TEAM_ALLIANCE ? LANG_BG_IC_HORDE_KEEP : LANG_BG_IC_ALLIANCE_KEEP));
}

void BattlegroundIC::EventPlayerDamagedGO(Player* /*player*/, GameObject* /*go*/, uint32 /*eventType*/)
{

}

WorldSafeLocsEntry const* BattlegroundIC::GetClosestGraveyard(Player* player)
{
    // Is there any occupied node for this team?
    std::vector<uint8> nodes;
    for (uint8 i = 0; i < MAX_NODE_TYPES; ++i)
        if (nodePoint[i].faction == player->GetTeamId() && !nodePoint[i].needChange) // xinef: controlled by faction and not contested!
            nodes.push_back(i);

    WorldSafeLocsEntry const* good_entry = NULL;
    // If so, select the closest node to place ghost on
    if (!nodes.empty())
    {
        float plr_x = player->GetPositionX();
        float plr_y = player->GetPositionY();

        float mindist = 999999.0f;
        for (uint8 i = 0; i < nodes.size(); ++i)
        {
            WorldSafeLocsEntry const*entry = sWorldSafeLocsStore.LookupEntry(BG_IC_GraveyardIds[nodes[i]]);
            if (!entry)
                continue;
            float dist = (entry->x - plr_x)*(entry->x - plr_x)+(entry->y - plr_y)*(entry->y - plr_y);
            if (mindist > dist)
            {
                mindist = dist;
                good_entry = entry;
            }
        }
        nodes.clear();
    }
    // If not, place ghost on starting location
    if (!good_entry)
        good_entry = sWorldSafeLocsStore.LookupEntry(BG_IC_GraveyardIds[player->GetTeamId()+MAX_NODE_TYPES]);

    return good_entry;
}
