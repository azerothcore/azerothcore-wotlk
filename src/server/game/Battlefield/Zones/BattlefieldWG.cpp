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

/// @todo: Implement proper support for vehicle+player teleportation
/// @todo: Use spell victory/defeat in wg instead of RewardMarkOfHonor() && RewardHonor
/// @todo: Add proper implement of achievement

#include "AreaDefines.h"
#include "BattlefieldWG.h"
#include "Chat.h"
#include "GameTime.h"
#include "MapMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "SpellAuras.h"
#include "TemporarySummon.h"
#include "Vehicle.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"
#include "WorldStateDefines.h"
#include "WorldStatePackets.h"

BattlefieldWG::~BattlefieldWG()
{
    for (Workshop::const_iterator itr = WorkshopsList.begin(); itr != WorkshopsList.end(); ++itr)
        delete *itr;

    for (GameObjectBuilding::const_iterator itr = BuildingsInZone.begin(); itr != BuildingsInZone.end(); ++itr)
        delete *itr;
}

bool BattlefieldWG::SetupBattlefield()
{
    m_TypeId = BATTLEFIELD_WG;                              // See enum BattlefieldTypes
    m_BattleId = BATTLEFIELD_BATTLEID_WG;
    m_ZoneId = AREA_WINTERGRASP;
    m_MapId = MAP_NORTHREND;
    m_Map = sMapMgr->FindMap(m_MapId, 0);

    // init stalker AFTER setting map id... we spawn it at map=random memory value?...
    InitStalker(BATTLEFIELD_WG_NPC_STALKER, WintergraspStalkerPos[0], WintergraspStalkerPos[1], WintergraspStalkerPos[2], WintergraspStalkerPos[3]);

    m_MaxPlayer = sWorld->getIntConfig(CONFIG_WINTERGRASP_PLR_MAX);
    m_IsEnabled = sWorld->getIntConfig(CONFIG_WINTERGRASP_ENABLE) == 1;
    m_MinPlayer = sWorld->getIntConfig(CONFIG_WINTERGRASP_PLR_MIN);
    m_MinLevel = sWorld->getIntConfig(CONFIG_WINTERGRASP_PLR_MIN_LVL);
    m_BattleTime = sWorld->getIntConfig(CONFIG_WINTERGRASP_BATTLETIME) * MINUTE * IN_MILLISECONDS;
    m_NoWarBattleTime = sWorld->getIntConfig(CONFIG_WINTERGRASP_NOBATTLETIME) * MINUTE * IN_MILLISECONDS;
    m_RestartAfterCrash = sWorld->getIntConfig(CONFIG_WINTERGRASP_RESTART_AFTER_CRASH) * MINUTE * IN_MILLISECONDS;

    m_TimeForAcceptInvite = 20;
    m_StartGroupingTimer = 15 * MINUTE * IN_MILLISECONDS;
    m_StartGrouping = false;

    m_tenacityStack = 0;
    m_titansRelic.Clear();

    KickPosition.Relocate(5728.117f, 2714.346f, 697.733f, 0);
    KickPosition.m_mapId = m_MapId;

    RegisterZone(m_ZoneId);

    m_Data32.resize(BATTLEFIELD_WG_DATA_MAX);

    m_saveTimer = 60000;

    // Init Graveyards
    SetGraveyardNumber(BATTLEFIELD_WG_GRAVEYARD_MAX);

    // Load from db
    if (!sWorldState->getWorldState(WORLD_STATE_BATTLEFIELD_WG_ACTIVE) &&
        !sWorldState->getWorldState(WORLD_STATE_BATTLEFIELD_WG_DEFENDER) &&
        !sWorldState->getWorldState(ClockWorldState[0]))
    {
        sWorldState->setWorldState(WORLD_STATE_BATTLEFIELD_WG_ACTIVE, uint64(false));
        sWorldState->setWorldState(WORLD_STATE_BATTLEFIELD_WG_DEFENDER, uint64(urand(0, 1)));
        sWorldState->setWorldState(ClockWorldState[0], uint64(m_NoWarBattleTime));
    }

    m_isActive = bool(sWorldState->getWorldState(WORLD_STATE_BATTLEFIELD_WG_ACTIVE));
    m_DefenderTeam = TeamId(sWorldState->getWorldState(WORLD_STATE_BATTLEFIELD_WG_DEFENDER));

    m_Timer = sWorldState->getWorldState(ClockWorldState[0]);
    if (m_isActive)
    {
        m_isActive = false;
        m_Timer = m_RestartAfterCrash;
    }

    for (uint8 i = 0; i < BATTLEFIELD_WG_GRAVEYARD_MAX; i++)
    {
        BfGraveyardWG* graveyard = new BfGraveyardWG(this);

        // When between games, the graveyard is controlled by the defending team
        if (WGGraveyard[i].startcontrol == TEAM_NEUTRAL)
            graveyard->Initialize(WGGraveyard[i].gyid == BATTLEFIELD_WG_GY_WORKSHOP_SE || WGGraveyard[i].gyid == BATTLEFIELD_WG_GY_WORKSHOP_SW ? GetAttackerTeam() : m_DefenderTeam, WGGraveyard[i].gyid);
        else
            graveyard->Initialize(WGGraveyard[i].startcontrol, WGGraveyard[i].gyid);

        graveyard->SetTextId(WGGraveyard[i].textid);
        m_GraveyardList[i] = graveyard;
    }

    // Spawn workshop creatures and gameobjects
    for (uint8 i = 0; i < WG_MAX_WORKSHOP; i++)
    {
        WGWorkshop* workshop = new WGWorkshop(this, i);
        if (i == BATTLEFIELD_WG_WORKSHOP_SE || i == BATTLEFIELD_WG_WORKSHOP_SW)
            workshop->GiveControlTo(GetAttackerTeam(), true);
        else
            workshop->GiveControlTo(GetDefenderTeam(), true);

        // Note: Capture point is added once the gameobject is created.
        WorkshopsList.insert(workshop);
    }

    // Spawn NPCs in the defender's keep, both Horde and Alliance
    for (uint8 i = 0; i < WG_MAX_KEEP_NPC; i++)
    {
        // Horde npc
        if (Creature* creature = SpawnCreature(WGKeepNPC[i].entryHorde, WGKeepNPC[i].x, WGKeepNPC[i].y, WGKeepNPC[i].z, WGKeepNPC[i].o, TEAM_HORDE))
            KeepCreature[TEAM_HORDE].insert(creature->GetGUID());
        // Alliance npc
        if (Creature* creature = SpawnCreature(WGKeepNPC[i].entryAlliance, WGKeepNPC[i].x, WGKeepNPC[i].y, WGKeepNPC[i].z, WGKeepNPC[i].o, TEAM_ALLIANCE))
            KeepCreature[TEAM_ALLIANCE].insert(creature->GetGUID());
    }

    // Hide NPCs from the Attacker's team in the keep
    for (GuidUnorderedSet::const_iterator itr = KeepCreature[GetAttackerTeam()].begin(); itr != KeepCreature[GetAttackerTeam()].end(); ++itr)
        if (Creature* creature = GetCreature(*itr))
            HideNpc(creature);

    // Spawn Horde NPCs outside the keep
    for (uint8 i = 0; i < WG_OUTSIDE_ALLIANCE_NPC; i++)
        if (Creature* creature = SpawnCreature(WGOutsideNPC[i].entryHorde, WGOutsideNPC[i].x, WGOutsideNPC[i].y, WGOutsideNPC[i].z, WGOutsideNPC[i].o, TEAM_HORDE))
            OutsideCreature[TEAM_HORDE].insert(creature->GetGUID());

    // Spawn Alliance NPCs outside the keep
    for (uint8 i = WG_OUTSIDE_ALLIANCE_NPC; i < WG_MAX_OUTSIDE_NPC; i++)
        if (Creature* creature = SpawnCreature(WGOutsideNPC[i].entryAlliance, WGOutsideNPC[i].x, WGOutsideNPC[i].y, WGOutsideNPC[i].z, WGOutsideNPC[i].o, TEAM_ALLIANCE))
            OutsideCreature[TEAM_ALLIANCE].insert(creature->GetGUID());

    // Hide units outside the keep that are defenders
    for (GuidUnorderedSet::const_iterator itr = OutsideCreature[GetDefenderTeam()].begin(); itr != OutsideCreature[GetDefenderTeam()].end(); ++itr)
        if (Creature* creature = GetCreature(*itr))
            HideNpc(creature);

    // Spawn turrets and hide them per default
    for (uint8 i = 0; i < WG_MAX_TURRET; i++)
    {
        Position towerCannonPos = WGTurret[i].GetPosition();
        if (Creature* creature = SpawnCreature(NPC_WINTERGRASP_TOWER_CANNON, towerCannonPos, TEAM_ALLIANCE))
        {
            CanonList.insert(creature->GetGUID());
            HideNpc(creature);
        }
    }

    // Spawn all gameobjects
    for (uint8 i = 0; i < WG_MAX_OBJ; i++)
    {
        GameObject* go = SpawnGameObject(WGGameObjectBuilding[i].entry, WGGameObjectBuilding[i].x, WGGameObjectBuilding[i].y, WGGameObjectBuilding[i].z, WGGameObjectBuilding[i].o);
        BfWGGameObjectBuilding* b = new BfWGGameObjectBuilding(this);
        b->Init(go, WGGameObjectBuilding[i].type, WGGameObjectBuilding[i].WorldState, WGGameObjectBuilding[i].damageText, WGGameObjectBuilding[i].destroyText);
        BuildingsInZone.insert(b);
    }

    // Spawning portal defender
    for (uint8 i = 0; i < WG_MAX_TELEPORTER; i++)
    {
        GameObject* go = SpawnGameObject(WGPortalDefenderData[i].entry, WGPortalDefenderData[i].x, WGPortalDefenderData[i].y, WGPortalDefenderData[i].z, WGPortalDefenderData[i].o);
        DefenderPortalList.insert(go);
        go->SetUInt32Value(GAMEOBJECT_FACTION, WintergraspFaction[GetDefenderTeam()]);
    }

    UpdateCounterVehicle(true);
    return true;
}

bool BattlefieldWG::Update(uint32 diff)
{
    bool m_return = Battlefield::Update(diff);
    if (m_saveTimer <= diff)
    {
        sWorldState->setWorldState(WORLD_STATE_BATTLEFIELD_WG_ACTIVE, m_isActive);
        sWorldState->setWorldState(WORLD_STATE_BATTLEFIELD_WG_DEFENDER, m_DefenderTeam);
        sWorldState->setWorldState(ClockWorldState[0], m_Timer);
        m_saveTimer = 60 * IN_MILLISECONDS;
    }
    else
        m_saveTimer -= diff;

    // Update Tenacity
    if (IsWarTime())
    {
        if (m_tenacityUpdateTimer <= diff)
        {
            m_tenacityUpdateTimer = 10000;
            if (!m_updateTenacityList.empty())
                UpdateTenacity();
            m_updateTenacityList.clear();
        }
        else
            m_tenacityUpdateTimer -= diff;
    }

    return m_return;
}

void BattlefieldWG::OnBattleStart()
{
    // Spawn titan relic
    GameObject* go = SpawnGameObject(GO_WINTERGRASP_TITAN_S_RELIC, 5440.37890625f, 2840.493408203125f, 430.2816162109375, 4.45059061050415039f); // VerifiedBuild 51943
    if (go)
    {
        // Update faction of relic, only attacker can click on
        go->SetUInt32Value(GAMEOBJECT_FACTION, WintergraspFaction[GetAttackerTeam()]);
        // Set in use (not allow to click on before last door is broken)
        go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);

        // save guid
        m_titansRelic = go->GetGUID();
    }
    else
        LOG_ERROR("bg.battlefield", "WG: Failed to spawn titan relic.");

    // Update tower visibility and update faction
    for (GuidUnorderedSet::const_iterator itr = CanonList.begin(); itr != CanonList.end(); ++itr)
    {
        if (Creature* creature = GetCreature(*itr))
        {
            ShowNpc(creature, true);
            creature->SetFaction(WintergraspFaction[GetDefenderTeam()]);
        }
    }

    // Rebuild all wall
    for (GameObjectBuilding::const_iterator itr = BuildingsInZone.begin(); itr != BuildingsInZone.end(); ++itr)
    {
        if (*itr)
        {
            (*itr)->Rebuild();
            (*itr)->UpdateTurretAttack(false);
        }
    }

    SetData(BATTLEFIELD_WG_DATA_INTACT_TOWER_ATT, WG_MAX_ATTACKTOWERS);
    SetData(BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT, 0);
    SetData(BATTLEFIELD_WG_DATA_DAMAGED_TOWER_ATT, 0);

    // Update graveyard (in no war time all graveyard is to deffender, in war time, depend of base)
    for (Workshop::const_iterator itr = WorkshopsList.begin(); itr != WorkshopsList.end(); ++itr)
        if (*itr)
            (*itr)->UpdateGraveyardAndWorkshop();

    // Set Sliders capture points data to his owners when battle start
    for (BfCapturePointVector::const_iterator itr = m_capturePoints.begin(); itr != m_capturePoints.end(); ++itr)
        (*itr)->SetCapturePointData((*itr)->GetCapturePointGo(),
            (*itr)->GetCapturePointGo()->GetEntry() == GO_WINTERGRASP_FACTORY_BANNER_SE || (*itr)->GetCapturePointGo()->GetEntry() == GO_WINTERGRASP_FACTORY_BANNER_SW ? GetAttackerTeam() : GetDefenderTeam());

    for (uint8 team = 0; team < 2; ++team)
        for (GuidUnorderedSet::const_iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
        {
            // Kick player in orb room, TODO: offline player ?
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
            {
                float x, y, z;
                player->GetPosition(x, y, z);
                if (5500 > x && x > 5392 && y < 2880 && y > 2800 && z < 480)
                    player->TeleportTo(MAP_NORTHREND, 5349.8686f, 2838.481f, 409.240f, 0.046328f);
                SendInitWorldStatesTo(player);
            }
        }
    // Initialize vehicle counter
    UpdateCounterVehicle(true);
    // Send start warning to all players
    SendWarning(BATTLEFIELD_WG_TEXT_START);

    // Xinef: reset tenacity counter
    m_tenacityStack = 0;
    m_tenacityUpdateTimer = 20000;

    if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_ENABLE))
        ChatHandler(nullptr).SendWorldText(BATTLEFIELD_WG_WORLD_START_MESSAGE);
}

void BattlefieldWG::UpdateCounterVehicle(bool init)
{
    if (init)
    {
        SetData(BATTLEFIELD_WG_DATA_VEHICLE_H, 0);
        SetData(BATTLEFIELD_WG_DATA_VEHICLE_A, 0);
    }
    SetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H, 0);
    SetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A, 0);

    for (Workshop::const_iterator itr = WorkshopsList.begin(); itr != WorkshopsList.end(); ++itr)
    {
        if (WGWorkshop* workshop = (*itr))
        {
            if (workshop->teamControl == TEAM_ALLIANCE)
                UpdateData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A, 4);
            else if (workshop->teamControl == TEAM_HORDE)
                UpdateData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H, 4);
        }
    }

    UpdateVehicleCountWG();
}

// Update vehicle count WorldState to player
void BattlefieldWG::UpdateVehicleCountWG()
{
    for (uint8 i = 0; i < PVP_TEAMS_COUNT; ++i)
        for (GuidUnorderedSet::iterator itr = m_players[i].begin(); itr != m_players[i].end(); ++itr)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
            {
                player->SendUpdateWorldState(WORLD_STATE_BATTLEFIELD_WG_VEHICLE_H,     GetData(BATTLEFIELD_WG_DATA_VEHICLE_H));
                player->SendUpdateWorldState(WORLD_STATE_BATTLEFIELD_WG_MAX_VEHICLE_H, GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H));
                player->SendUpdateWorldState(WORLD_STATE_BATTLEFIELD_WG_VEHICLE_A,     GetData(BATTLEFIELD_WG_DATA_VEHICLE_A));
                player->SendUpdateWorldState(WORLD_STATE_BATTLEFIELD_WG_MAX_VEHICLE_A, GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A));
            }
}

void BattlefieldWG::CapturePointTaken(uint32 areaId)
{
    for (uint8 i = 0; i < PVP_TEAMS_COUNT; ++i)
        for (GuidUnorderedSet::iterator itr = m_players[i].begin(); itr != m_players[i].end(); ++itr)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                if (player->GetAreaId() == areaId)
                    player->UpdateAreaDependentAuras(areaId);
}

void BattlefieldWG::OnBattleEnd(bool endByTimer)
{
    // Remove relic
    if (GameObject* go = GetRelic())
        go->RemoveFromWorld();

    m_titansRelic.Clear();

    // Remove turret
    for (GuidUnorderedSet::const_iterator itr = CanonList.begin(); itr != CanonList.end(); ++itr)
    {
        if (Creature* creature = GetCreature(*itr))
        {
            if (!endByTimer)
                creature->SetFaction(WintergraspFaction[GetDefenderTeam()]);
            HideNpc(creature);
        }
    }

    // Change all npc in keep
    for (GuidUnorderedSet::const_iterator itr = KeepCreature[GetAttackerTeam()].begin(); itr != KeepCreature[GetAttackerTeam()].end(); ++itr)
        if (Creature* creature = GetCreature(*itr))
            HideNpc(creature);

    for (GuidUnorderedSet::const_iterator itr = KeepCreature[GetDefenderTeam()].begin(); itr != KeepCreature[GetDefenderTeam()].end(); ++itr)
        if (Creature* creature = GetCreature(*itr))
            ShowNpc(creature, true);

    // Change all npc out of keep
    for (GuidUnorderedSet::const_iterator itr = OutsideCreature[GetDefenderTeam()].begin(); itr != OutsideCreature[GetDefenderTeam()].end(); ++itr)
        if (Creature* creature = GetCreature(*itr))
            HideNpc(creature);

    for (GuidUnorderedSet::const_iterator itr = OutsideCreature[GetAttackerTeam()].begin(); itr != OutsideCreature[GetAttackerTeam()].end(); ++itr)
        if (Creature* creature = GetCreature(*itr))
            ShowNpc(creature, true);

    // Update all graveyard, control is to defender when no wartime
    for (uint8 i = 0; i < BATTLEFIELD_WG_GY_HORDE; i++)
        if (BfGraveyard* graveyard = GetGraveyardById(i))
            graveyard->GiveControlTo(i == BATTLEFIELD_WG_GY_WORKSHOP_SE || i == BATTLEFIELD_WG_GY_WORKSHOP_SW ? GetAttackerTeam() : GetDefenderTeam());

    for (GameObjectSet::const_iterator itr = m_KeepGameObject[GetDefenderTeam()].begin(); itr != m_KeepGameObject[GetDefenderTeam()].end(); ++itr)
        (*itr)->SetRespawnTime(RESPAWN_IMMEDIATELY);

    for (GameObjectSet::const_iterator itr = m_KeepGameObject[GetAttackerTeam()].begin(); itr != m_KeepGameObject[GetAttackerTeam()].end(); ++itr)
        (*itr)->SetRespawnTime(RESPAWN_ONE_DAY);

    // Update portal defender faction
    for (GameObjectSet::const_iterator itr = DefenderPortalList.begin(); itr != DefenderPortalList.end(); ++itr)
        (*itr)->SetUInt32Value(GAMEOBJECT_FACTION, WintergraspFaction[GetDefenderTeam()]);

    // Saving data
    for (GameObjectBuilding::const_iterator itr = BuildingsInZone.begin(); itr != BuildingsInZone.end(); ++itr)
    {
        (*itr)->Rebuild();
        (*itr)->Save();
        (*itr)->UpdateTurretAttack(true);
    }

    for (Workshop::const_iterator itr = WorkshopsList.begin(); itr != WorkshopsList.end(); ++itr)
    {
        (*itr)->GiveControlTo((*itr)->workshopId == BATTLEFIELD_WG_WORKSHOP_SE || (*itr)->workshopId == BATTLEFIELD_WG_WORKSHOP_SW ? GetAttackerTeam() : GetDefenderTeam(), true);
        (*itr)->Save();
    }

    for (uint8 team = 0; team < 2; ++team)
    {
        for (GuidUnorderedSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
            if (Creature* creature = GetCreature(*itr))
                creature->DespawnOrUnsummon(1ms);

        m_vehicles[team].clear();
    }

    uint8 damagedTowersDef = GetData(BATTLEFIELD_WG_DATA_DAMAGED_TOWER_ATT);
    uint8 brokenTowersDef = GetData(BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT);
    uint8 damagedTowersAtt = GetData(BATTLEFIELD_WG_DATA_DAMAGED_TOWER_ATT);
    uint8 brokenTowersAtt = GetData(BATTLEFIELD_WG_DATA_INTACT_TOWER_ATT);
    uint32 spellDamagedDef = SPELL_DAMAGED_TOWER;
    uint32 spellFullDef = SPELL_DESTROYED_TOWER;
    uint32 spellDamagedAtt = SPELL_DAMAGED_BUILDING;
    uint32 spellFullAtt = SPELL_INTACT_BUILDING;

    if (!endByTimer)
    {
        brokenTowersDef = GetData(BATTLEFIELD_WG_DATA_INTACT_TOWER_ATT);
        brokenTowersAtt = GetData(BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT);
        spellDamagedDef = SPELL_DAMAGED_BUILDING;
        spellFullDef = SPELL_INTACT_BUILDING;
        spellDamagedAtt = SPELL_DAMAGED_TOWER;
        spellFullAtt = SPELL_DESTROYED_TOWER;
    }

    for (GuidUnorderedSet::const_iterator itr = m_PlayersInWar[GetDefenderTeam()].begin(); itr != m_PlayersInWar[GetDefenderTeam()].end(); ++itr)
    {
        if (Player* player = ObjectAccessor::FindPlayer(*itr))
        {
            // Victory in Wintergrasp
            player->AreaExploredOrEventHappens(GetDefenderTeam() ? 13183 : 13181); // HORDE / ALLY win wg quest id

            player->CastSpell(player, SPELL_ESSENCE_OF_WINTERGRASP, true);
            player->CastSpell(player, SPELL_VICTORY_REWARD, true);
            RemoveAurasFromPlayer(player);

            for (uint8 i = 0; i < damagedTowersDef; ++i)
                player->CastSpell(player, spellDamagedDef, true);
            for (uint8 i = 0; i < brokenTowersDef; ++i)
                player->CastSpell(player, spellFullDef, true);
        }
    }

    for (GuidUnorderedSet::const_iterator itr = m_PlayersInWar[GetAttackerTeam()].begin(); itr != m_PlayersInWar[GetAttackerTeam()].end(); ++itr)
        if (Player* player = ObjectAccessor::FindPlayer(*itr))
        {
            player->CastSpell(player, SPELL_DEFEAT_REWARD, true);
            RemoveAurasFromPlayer(player);

            for (uint8 i = 0; i < damagedTowersAtt; ++i)
                player->CastSpell(player, spellDamagedAtt, true);
            for (uint8 i = 0; i < brokenTowersAtt; ++i)
                player->CastSpell(player, spellFullAtt, true);
        }

    if (!endByTimer)
    {
        for (uint8 team = 0; team < 2; ++team)
        {
            for (GuidUnorderedSet::const_iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
            {
                if (Player* player = ObjectAccessor::FindPlayer(*itr))
                {
                    player->RemoveAurasDueToSpell(m_DefenderTeam == TEAM_ALLIANCE ? SPELL_HORDE_CONTROL_PHASE_SHIFT : SPELL_ALLIANCE_CONTROL_PHASE_SHIFT, player->GetGUID());
                    player->AddAura(m_DefenderTeam == TEAM_HORDE ? SPELL_HORDE_CONTROL_PHASE_SHIFT : SPELL_ALLIANCE_CONTROL_PHASE_SHIFT, player);
                }
            }
        }
    }

    // Clear players in war list at the end.
    m_PlayersInWar[TEAM_ALLIANCE].clear();
    m_PlayersInWar[TEAM_HORDE].clear();

    if (!endByTimer) // win alli/horde
    {
        uint32 const worldStateId = GetDefenderTeam() == TEAM_ALLIANCE ? WORLD_STATE_BATTLEFIELD_WG_ALLIANCE_KEEP_CAPTURED : WORLD_STATE_BATTLEFIELD_WG_HORDE_KEEP_CAPTURED;
        sWorldState->setWorldState(worldStateId, sWorldState->getWorldState(worldStateId) + 1);

        SendWarning((GetDefenderTeam() == TEAM_ALLIANCE) ? BATTLEFIELD_WG_TEXT_WIN_KEEP : (BATTLEFIELD_WG_TEXT_WIN_KEEP + 2));
    }
    else // defend alli/horde
    {
        uint32 const worldStateId = GetDefenderTeam() == TEAM_ALLIANCE ? WORLD_STATE_BATTLEFIELD_WG_ALLIANCE_KEEP_DEFENDED : WORLD_STATE_BATTLEFIELD_WG_HORDE_KEEP_DEFENDED;
        sWorldState->setWorldState(worldStateId, sWorldState->getWorldState(worldStateId) + 1);

        SendWarning((GetDefenderTeam() == TEAM_ALLIANCE) ? BATTLEFIELD_WG_TEXT_DEFEND_KEEP : (BATTLEFIELD_WG_TEXT_DEFEND_KEEP + 2));
    }
}

// *******************************************************
// ******************* Reward System *********************
// *******************************************************

void BattlefieldWG::OnStartGrouping()
{
    if (!IsWarTime())
        SendWarning(BATTLEFIELD_WG_TEXT_WILL_START);
}

uint8 BattlefieldWG::GetSpiritGraveyardId(uint32 areaId) const
{
    switch (areaId)
    {
        case AREA_WINTERGRASP_FORTRESS:
            return BATTLEFIELD_WG_GY_KEEP;
        case AREA_THE_SUNKEN_RING:
            return BATTLEFIELD_WG_GY_WORKSHOP_NE;
        case AREA_THE_BROKEN_TEMPLE:
            return BATTLEFIELD_WG_GY_WORKSHOP_NW;
        case AREA_WESTSPARK_WORKSHOP:
            return BATTLEFIELD_WG_GY_WORKSHOP_SW;
        case AREA_EASTSPARK_WORKSHOP:
            return BATTLEFIELD_WG_GY_WORKSHOP_SE;
        case AREA_WINTERGRASP:
            return BATTLEFIELD_WG_GY_ALLIANCE;
        case AREA_THE_CHILLED_QUAGMIRE:
            return BATTLEFIELD_WG_GY_HORDE;
        default:
            LOG_ERROR("bg.battlefield", "BattlefieldWG::GetSpiritGraveyardId: Unexpected Area Id {}", areaId);
            break;
    }

    return 0;
}

uint32 BattlefieldWG::GetAreaByGraveyardId(uint8 gId) const
{
    switch (gId)
    {
        case BATTLEFIELD_WG_GY_WORKSHOP_NE:
            return AREA_THE_SUNKEN_RING;
        case BATTLEFIELD_WG_GY_WORKSHOP_NW:
            return AREA_THE_BROKEN_TEMPLE;
        case BATTLEFIELD_WG_GY_WORKSHOP_SW:
            return AREA_WESTSPARK_WORKSHOP;
        case BATTLEFIELD_WG_GY_WORKSHOP_SE:
            return AREA_EASTSPARK_WORKSHOP;
    }

    return 0;
}

void BattlefieldWG::OnCreatureCreate(Creature* creature)
{
    // Accessing to db spawned creatures
    switch (creature->GetEntry())
    {
        case NPC_DWARVEN_SPIRIT_GUIDE:
        case NPC_TAUNKA_SPIRIT_GUIDE:
            {
                TeamId teamId = (creature->GetEntry() == NPC_DWARVEN_SPIRIT_GUIDE ? TEAM_ALLIANCE : TEAM_HORDE);
                uint8 graveyardId = GetSpiritGraveyardId(creature->GetAreaId());
                // xinef: little workaround, there are 2 spirit guides in same area
                if (creature->IsWithinDist2d(5103.0f, 3461.5f, 5.0f))
                    graveyardId = BATTLEFIELD_WG_GY_WORKSHOP_NW;

                if (m_GraveyardList[graveyardId])
                    m_GraveyardList[graveyardId]->SetSpirit(creature, teamId);
                break;
            }
    }

    // untested code - not sure if it is valid.
    if (IsWarTime())
    {
        switch (creature->GetEntry())
        {
            case NPC_WINTERGRASP_SIEGE_ENGINE_ALLIANCE:
            case NPC_WINTERGRASP_SIEGE_ENGINE_HORDE:
            case NPC_WINTERGRASP_CATAPULT:
            case NPC_WINTERGRASP_DEMOLISHER:
                {
                    if (!creature->IsSummon() || !creature->ToTempSummon()->GetSummonerGUID())
                        return;

                    Player* creator = ObjectAccessor::FindPlayer(creature->ToTempSummon()->GetSummonerGUID());
                    if (!creator)
                        return;
                    TeamId team = creator->GetTeamId();

                    if (team == TEAM_HORDE)
                    {
                        if (GetData(BATTLEFIELD_WG_DATA_VEHICLE_H) < GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H))
                        {
                            UpdateData(BATTLEFIELD_WG_DATA_VEHICLE_H, 1);
                            creature->CastSpell(creature, SPELL_HORDE_FLAG, true);
                            m_vehicles[team].insert(creature->GetGUID());
                            UpdateVehicleCountWG();
                        }
                        else
                        {
                            creature->DespawnOrUnsummon();
                            return;
                        }
                    }
                    else
                    {
                        if (GetData(BATTLEFIELD_WG_DATA_VEHICLE_A) < GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A))
                        {
                            UpdateData(BATTLEFIELD_WG_DATA_VEHICLE_A, 1);
                            creature->CastSpell(creature, SPELL_ALLIANCE_FLAG, true);
                            m_vehicles[team].insert(creature->GetGUID());
                            UpdateVehicleCountWG();
                        }
                        else
                        {
                            creature->DespawnOrUnsummon();
                            return;
                        }
                    }
                    break;
                }
            case NPC_WINTERGRASP_SIEGE_ENGINE_TURRET_HORDE:
            case NPC_WINTERGRASP_SIEGE_ENGINE_TURRET_ALLIANCE:
                {
                    if (!creature->IsSummon() || !creature->ToTempSummon()->GetSummonerGUID())
                        return;

                    if (Unit* owner = creature->ToTempSummon()->GetSummonerUnit())
                        creature->SetFaction(owner->GetFaction());
                    break;
                }
        }
    }
}

void BattlefieldWG::OnCreatureRemove(Creature*  /*creature*/)
{
    /* possibly can be used later
        if (IsWarTime())
        {
            switch (creature->GetEntry())
            {
                case NPC_WINTERGRASP_SIEGE_ENGINE_ALLIANCE:
                case NPC_WINTERGRASP_SIEGE_ENGINE_HORDE:
                case NPC_WINTERGRASP_CATAPULT:
                case NPC_WINTERGRASP_DEMOLISHER:
                {
                    uint8 team;
                    if (creature->GetFaction() == WintergraspFaction[TEAM_ALLIANCE])
                        team = TEAM_ALLIANCE;
                    else if (creature->GetFaction() == WintergraspFaction[TEAM_HORDE])
                        team = TEAM_HORDE;
                    else
                        return;

                    m_vehicles[team].erase(creature->GetGUID());
                    if (team == TEAM_HORDE)
                        UpdateData(BATTLEFIELD_WG_DATA_VEHICLE_H, -1);
                    else
                        UpdateData(BATTLEFIELD_WG_DATA_VEHICLE_A, -1);
                    UpdateVehicleCountWG();

                    break;
                }
            }
        }*/
}

void BattlefieldWG::OnGameObjectCreate(GameObject* go)
{
    uint8 workshopId = 0;

    switch (go->GetEntry())
    {
        case GO_WINTERGRASP_FACTORY_BANNER_NE:
            workshopId = BATTLEFIELD_WG_WORKSHOP_NE;
            break;
        case GO_WINTERGRASP_FACTORY_BANNER_NW:
            workshopId = BATTLEFIELD_WG_WORKSHOP_NW;
            break;
        case GO_WINTERGRASP_FACTORY_BANNER_SE:
            workshopId = BATTLEFIELD_WG_WORKSHOP_SE;
            break;
        case GO_WINTERGRASP_FACTORY_BANNER_SW:
            workshopId = BATTLEFIELD_WG_WORKSHOP_SW;
            break;
        default:
            return;
    }

    for (Workshop::const_iterator itr = WorkshopsList.begin(); itr != WorkshopsList.end(); ++itr)
    {
        if (WGWorkshop* workshop = (*itr))
        {
            if (workshop->workshopId == workshopId)
            {
                WintergraspCapturePoint* capturePoint = new WintergraspCapturePoint(this, workshop->teamControl);
                //Sending neutral team at start to set normal capture points by workshop->teamControl, TEAM_NEUTRAL is ignored at first call
                capturePoint->SetCapturePointData(go, TEAM_NEUTRAL);
                capturePoint->LinkToWorkshop(workshop);
                AddCapturePoint(capturePoint);
                break;
            }
        }
    }
}

// Called when player kill a unit in wg zone
void BattlefieldWG::HandleKill(Player* killer, Unit* victim)
{
    if (killer == victim)
    {
        return;
    }

    TeamId killerTeam = killer->GetTeamId();

    // xinef: tower cannons also grant rank
    if (victim->IsPlayer() || IsKeepNpc(victim->GetEntry()) || victim->GetEntry() == NPC_WINTERGRASP_TOWER_CANNON)
    {
        if (victim->IsPlayer() && victim->HasAura(SPELL_LIEUTENANT))
        {
            // Quest - Wintergrasp - PvP Kill - Horde/Alliance
            for (auto& playerGuid : m_PlayersInWar[killerTeam])
            {
                if (Player* player = ObjectAccessor::FindPlayer(playerGuid))
                {
                    if (player->GetDistance2d(killer) < 40)
                    {
                        player->KilledMonsterCredit(killerTeam == TEAM_HORDE ? NPC_QUEST_PVP_KILL_ALLIANCE : NPC_QUEST_PVP_KILL_HORDE);
                    }
                }
            }
        }

        for (auto& playerGuid : m_PlayersInWar[killerTeam])
        {
            if (Player* player = ObjectAccessor::FindPlayer(playerGuid))
            {
                if (player->GetDistance2d(killer) < 40)
                {
                    PromotePlayer(player);
                }
            }
        }

        // Xinef: Allow to Skin non-released corpse
        if (victim->IsPlayer())
        {
            victim->SetUnitFlag(UNIT_FLAG_SKINNABLE);
        }
    }
    else if (victim->IsVehicle() && !killer->IsFriendlyTo(victim))
    {
        // Quest - Wintergrasp - PvP Kill - Vehicle
        for (auto& playerGuid : m_PlayersInWar[killerTeam])
        {
            if (Player* player = ObjectAccessor::FindPlayer(playerGuid))
            {
                if (player->GetDistance2d(killer) < 40)
                {
                    player->KilledMonsterCredit(NPC_QUEST_PVP_KILL_VEHICLE);
                }
            }
        }
    }
}

bool BattlefieldWG::FindAndRemoveVehicleFromList(Unit* vehicle)
{
    for (uint32 itr = 0; itr < 2; ++itr)
    {
        if (m_vehicles[itr].find(vehicle->GetGUID()) != m_vehicles[itr].end())
        {
            //m_vehicles[itr].erase(vehicle->GetGUID());
            if (itr == TEAM_HORDE)
                UpdateData(BATTLEFIELD_WG_DATA_VEHICLE_H, -1);
            else
                UpdateData(BATTLEFIELD_WG_DATA_VEHICLE_A, -1);
            return true;
        }
    }
    return false;
}

void BattlefieldWG::OnUnitDeath(Unit* unit)
{
    if (IsWarTime())
        if (unit->IsVehicle())
            if (FindAndRemoveVehicleFromList(unit))
                UpdateVehicleCountWG();
}

// Update rank for player
void BattlefieldWG::PromotePlayer(Player* killer)
{
    if (!m_isActive)
        return;
    // Updating rank of player
    if (Aura* recruitAura = killer->GetAura(SPELL_RECRUIT))
    {
        if (recruitAura->GetStackAmount() >= 5)
        {
            killer->RemoveAura(SPELL_RECRUIT);
            killer->CastSpell(killer, SPELL_CORPORAL, true);
            SendWarning(BATTLEFIELD_WG_TEXT_FIRSTRANK, killer);
        }
        else
        {
            killer->CastSpell(killer, SPELL_RECRUIT, true);
        }
    }
    else if (Aura* corporalAura = killer->GetAura(SPELL_CORPORAL))
    {
        if (corporalAura->GetStackAmount() >= 5)
        {
            killer->RemoveAura(SPELL_CORPORAL);
            killer->CastSpell(killer, SPELL_LIEUTENANT, true);
            SendWarning(BATTLEFIELD_WG_TEXT_SECONDRANK, killer);
        }
        else
        {
            killer->CastSpell(killer, SPELL_CORPORAL, true);
        }
    }
}

void BattlefieldWG::RemoveAurasFromPlayer(Player* player)
{
    player->RemoveAurasDueToSpell(SPELL_RECRUIT);
    player->RemoveAurasDueToSpell(SPELL_CORPORAL);
    player->RemoveAurasDueToSpell(SPELL_LIEUTENANT);
    player->RemoveAurasDueToSpell(SPELL_TOWER_CONTROL);
    player->RemoveAurasDueToSpell(SPELL_SPIRITUAL_IMMUNITY);
    player->RemoveAurasDueToSpell(SPELL_TENACITY);
    player->RemoveAurasDueToSpell(SPELL_ESSENCE_OF_WINTERGRASP);
    player->RemoveAurasDueToSpell(SPELL_WINTERGRASP_RESTRICTED_FLIGHT_AREA);
}

void BattlefieldWG::OnPlayerJoinWar(Player* player)
{
    RemoveAurasFromPlayer(player);

    player->CastSpell(player, SPELL_RECRUIT, true);
    AddUpdateTenacity(player);

    if (player->GetTeamId() == GetDefenderTeam())
        player->TeleportTo(MAP_NORTHREND, 5345, 2842, 410, 3.14f);
    else
    {
        if (player->GetTeamId() == TEAM_HORDE)
            player->TeleportTo(MAP_NORTHREND, 5025.857422f, 3674.628906f, 362.737122f, 4.135169f);
        else
            player->TeleportTo(MAP_NORTHREND, 5101.284f, 2186.564f, 365.549f, 3.812f);
    }

    if (player->GetTeamId() == GetAttackerTeam())
    {
        if (GetData(BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT) < 3)
            player->SetAuraStack(SPELL_TOWER_CONTROL, player, 3 - GetData(BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT));
    }
    else
    {
        if (GetData(BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT) > 0)
            player->SetAuraStack(SPELL_TOWER_CONTROL, player, GetData(BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT));
    }
    SendInitWorldStatesTo(player);
}

void BattlefieldWG::OnPlayerLeaveWar(Player* player)
{
    // Remove all aura from WG /// @todo: false we can go out of this zone on retail and keep Rank buff, remove on end of WG
    if (!player->GetSession()->PlayerLogout())
    {
        if (player->GetVehicle())                              // Remove vehicle of player if he go out.
            player->GetVehicle()->Dismiss();
        RemoveAurasFromPlayer(player);
    }

    RemoveUpdateTenacity(player);
}

void BattlefieldWG::OnPlayerLeaveZone(Player* player)
{
    if (!m_isActive)
        RemoveAurasFromPlayer(player);

    player->RemoveAurasDueToSpell(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(SPELL_HORDE_CONTROL_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT);
}

void BattlefieldWG::OnPlayerEnterZone(Player* player)
{
    if (!m_isActive)
        RemoveAurasFromPlayer(player);

    player->AddAura(m_DefenderTeam == TEAM_HORDE ? SPELL_HORDE_CONTROL_PHASE_SHIFT : SPELL_ALLIANCE_CONTROL_PHASE_SHIFT, player);
    // Send worldstate to player
    SendInitWorldStatesTo(player);

    // xinef: Attacker, if hidden in relic room kick him out
    if (player->GetTeamId() == GetAttackerTeam())
        if (player->GetPositionX() > 5400.0f && player->GetPositionX() < 5490.0f && player->GetPositionY() > 2803.0f && player->GetPositionY() < 2878.0f)
            KickPlayerFromBattlefield(player->GetGUID());
}

uint32 BattlefieldWG::GetData(uint32 data) const
{
    // xinef: little hack, same area for default horde graveyard
    // this graveyard is the one of broken temple!
    if (data == AREA_THE_CHILLED_QUAGMIRE)
        data = AREA_THE_BROKEN_TEMPLE;

    switch (data)
    {
        // Used to determine when the phasing spells must be casted
        // See: SpellArea::IsFitToRequirements
        case AREA_THE_SUNKEN_RING:
        case AREA_THE_BROKEN_TEMPLE:
        case AREA_WESTSPARK_WORKSHOP:
        case AREA_EASTSPARK_WORKSHOP:
            // Graveyards and Workshops are controlled by the same team.
            if (BfGraveyard const* graveyard = GetGraveyardById(GetSpiritGraveyardId(data)))
                return graveyard->GetControlTeamId();
    }

    return Battlefield::GetData(data);
}

void BattlefieldWG::FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet)
{
    uint32 timer = GetTimer() / 1000;
    bool iconActive = timer < 15 * MINUTE || IsWarTime();

    packet.Worldstates.reserve(4+4+WG_MAX_OBJ+WG_MAX_WORKSHOP);
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_ATTACKER, GetAttackerTeam());
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_DEFENDER, GetDefenderTeam());

    // Note: cleanup these two, their names look awkward
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_ACTIVE, IsWarTime() ? 0 : 1);
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_SHOW, IsWarTime() ? 1 : 0);
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_CONTROL, m_DefenderTeam == TEAM_ALLIANCE ? 2 : 1); // Alliance 2, Hord 1
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_ICON_ACTIVE, iconActive ? 1 : 0);

    for (uint32 i = 0; i < 2; ++i)
        packet.Worldstates.emplace_back(ClockWorldState[i], GameTime::GetGameTime().count() + timer);

    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_VEHICLE_H, GetData(BATTLEFIELD_WG_DATA_VEHICLE_H));
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_MAX_VEHICLE_H, GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H));
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_VEHICLE_A, GetData(BATTLEFIELD_WG_DATA_VEHICLE_A));
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_MAX_VEHICLE_A, GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A));

    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_ALLIANCE_KEEP_DEFENDED, uint32(sWorldState->getWorldState(WORLD_STATE_BATTLEFIELD_WG_ALLIANCE_KEEP_DEFENDED)));
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_HORDE_KEEP_CAPTURED, uint32(sWorldState->getWorldState(WORLD_STATE_BATTLEFIELD_WG_HORDE_KEEP_CAPTURED)));
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_HORDE_KEEP_DEFENDED, uint32(sWorldState->getWorldState(WORLD_STATE_BATTLEFIELD_WG_HORDE_KEEP_DEFENDED)));
    packet.Worldstates.emplace_back(WORLD_STATE_BATTLEFIELD_WG_ALLIANCE_KEEP_CAPTURED, uint32(sWorldState->getWorldState(WORLD_STATE_BATTLEFIELD_WG_ALLIANCE_KEEP_CAPTURED)));

    for (GameObjectBuilding::const_iterator itr = BuildingsInZone.begin(); itr != BuildingsInZone.end(); ++itr)
        packet.Worldstates.emplace_back((*itr)->m_WorldState, (*itr)->m_State);

    for (Workshop::const_iterator itr = WorkshopsList.begin(); itr != WorkshopsList.end(); ++itr)
        if (*itr)
            packet.Worldstates.emplace_back(WorkshopsData[(*itr)->workshopId].worldstate, (*itr)->state);
}

void BattlefieldWG::SendInitWorldStatesTo(Player* player)
{
    WorldPackets::WorldState::InitWorldStates packet;
    packet.MapID = m_MapId;
    packet.ZoneID = m_ZoneId;
    packet.AreaID = player->GetAreaId();
    FillInitialWorldStates(packet);

    player->SendDirectMessage(packet.Write());
}

void BattlefieldWG::SendInitWorldStatesToAll()
{
    for (uint8 team = 0; team < 2; team++)
        for (GuidUnorderedSet::iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                SendInitWorldStatesTo(player);
}

void BattlefieldWG::SendUpdateWorldStates(Player* player)
{
    uint32 timer = GetTimer() / 1000;
    bool iconActive = timer < 15 * MINUTE || IsWarTime();

    SendUpdateWorldStateMessage(WORLD_STATE_BATTLEFIELD_WG_ATTACKER, GetAttackerTeam(), player);
    SendUpdateWorldStateMessage(WORLD_STATE_BATTLEFIELD_WG_DEFENDER, GetDefenderTeam(), player);
    SendUpdateWorldStateMessage(WORLD_STATE_BATTLEFIELD_WG_ACTIVE, IsWarTime() ? 0 : 1, player);
    SendUpdateWorldStateMessage(WORLD_STATE_BATTLEFIELD_WG_SHOW, IsWarTime() ? 1 : 0, player);
    SendUpdateWorldStateMessage(WORLD_STATE_BATTLEFIELD_WG_CONTROL, GetDefenderTeam() == TEAM_ALLIANCE ? 2 : 1, player);
    SendUpdateWorldStateMessage(WORLD_STATE_BATTLEFIELD_WG_ICON_ACTIVE, iconActive ? 1 : 0, player);

    for (uint32 i = 0; i < 2; ++i)
        SendUpdateWorldStateMessage(ClockWorldState[i], uint32(GameTime::GetGameTime().count() + timer), player);
}

void BattlefieldWG::SendUpdateWorldStateMessage(uint32 variable, uint32 value, Player* player)
{
    WorldPackets::WorldState::UpdateWorldState worldState;
    worldState.VariableID = variable;
    worldState.Value = value;

    if (player)
        player->SendDirectMessage(worldState.Write());
    else
        sWorldSessionMgr->SendGlobalMessage(worldState.Write());
}

void BattlefieldWG::BrokenWallOrTower(TeamId  /*team*/)
{
    // might be some use for this in the future. old code commented out below. KL
    /*    if (team == GetDefenderTeam())
        {
            for (GuidUnorderedSet::const_iterator itr = m_PlayersInWar[GetAttackerTeam()].begin(); itr != m_PlayersInWar[GetAttackerTeam()].end(); ++itr)
            {
                if (Player* player = ObjectAccessor::FindPlayer(*itr))
                    IncrementQuest(player, WGQuest[player->GetTeamId()][2], true);
            }
        }*/
}

// Called when a tower is broke
void BattlefieldWG::UpdatedDestroyedTowerCount(TeamId team, GameObject* go)
{
    // Destroy an attack tower
    if (team == GetAttackerTeam())
    {
        // Update counter
        UpdateData(BATTLEFIELD_WG_DATA_DAMAGED_TOWER_ATT, -1);
        UpdateData(BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT, 1);

        // Remove buff stack on attackers
        for (GuidUnorderedSet::const_iterator itr = m_PlayersInWar[GetAttackerTeam()].begin(); itr != m_PlayersInWar[GetAttackerTeam()].end(); ++itr)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                player->RemoveAuraFromStack(SPELL_TOWER_CONTROL);

        // Add buff stack to defenders
        for (GuidUnorderedSet::const_iterator itr = m_PlayersInWar[GetDefenderTeam()].begin(); itr != m_PlayersInWar[GetDefenderTeam()].end(); ++itr)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
            {
                // Quest - Wintergrasp - Southern Tower Kill
                if (go && player->GetDistance2d(go) < 200.0f)
                    player->KilledMonsterCredit(NPC_QUEST_SOUTHERN_TOWER_KILL);

                player->CastSpell(player, SPELL_TOWER_CONTROL, true);
                player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_LEANING_TOWER_ACHIEVEMENT, 0, 0);
            }

        // If all three south towers are destroyed (ie. all attack towers), remove ten minutes from battle time
        if (GetData(BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT) == 3)
        {
            if (int32(m_Timer - 600000) < 0)
                m_Timer = 0;
            else
                m_Timer -= 600000;
            SendInitWorldStatesToAll();
        }
    }
    else
    {
        // Xinef: rest of structures, quest credit
        for (GuidUnorderedSet::const_iterator itr = m_PlayersInWar[GetAttackerTeam()].begin(); itr != m_PlayersInWar[GetAttackerTeam()].end(); ++itr)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
            {
                // Quest - Wintergrasp - Vehicle Protected
                if (go && player->GetDistance2d(go) < 100.0f)
                    player->KilledMonsterCredit(NPC_QUEST_VEHICLE_PROTECTED);
            }
    }
}

void BattlefieldWG::ProcessEvent(WorldObject* obj, uint32 eventId)
{
    if (!obj || !IsWarTime())
        return;

    // We handle only gameobjects here
    GameObject* go = obj->ToGameObject();
    if (!go)
        return;

    // On click on titan relic
    if (go->GetEntry() == GO_WINTERGRASP_TITAN_S_RELIC)
    {
        if (CanInteractWithRelic())
        {
            EndBattle(false);
        }
        else if (GameObject* relic = GetRelic())
        {
            relic->SetRespawnTime(RESPAWN_IMMEDIATELY);
        }
    }

    // if destroy or damage event, search the wall/tower and update worldstate/send warning message
    for (GameObjectBuilding::const_iterator itr = BuildingsInZone.begin(); itr != BuildingsInZone.end(); ++itr)
    {
        if (GameObject* build = ObjectAccessor::GetGameObject(*obj, (*itr)->m_Build))
        {
            if (go->GetEntry() == build->GetEntry())
            {
                if (build->GetGOInfo()->building.damagedEvent == eventId)
                    (*itr)->Damaged();

                if (build->GetGOInfo()->building.destroyedEvent == eventId)
                    (*itr)->Destroyed();

                break;
            }
        }
    }
}

// Called when a tower is damaged, used for honor reward calcul
void BattlefieldWG::UpdateDamagedTowerCount(TeamId team)
{
    if (team == GetAttackerTeam())
    {
        UpdateData(BATTLEFIELD_WG_DATA_DAMAGED_TOWER_ATT, 1);
        UpdateData(BATTLEFIELD_WG_DATA_INTACT_TOWER_ATT, -1);
    }
}

uint32 BattlefieldWG::GetHonorBuff(int32 stack) const
{
    if (stack < 5)
        return 0;
    if (stack < 10)
        return SPELL_GREAT_HONOR;
    if (stack < 15)
        return SPELL_GREATER_HONOR;
    return SPELL_GREATEST_HONOR;
}

void BattlefieldWG::AddUpdateTenacity(Player* player)
{
    m_updateTenacityList.insert(player->GetGUID());
}

void BattlefieldWG::RemoveUpdateTenacity(Player* player)
{
    m_updateTenacityList.erase(player->GetGUID());
    m_updateTenacityList.insert(ObjectGuid::Empty);
}

void BattlefieldWG::UpdateTenacity()
{
    TeamId team = TEAM_NEUTRAL;
    uint32 alliancePlayers = m_PlayersInWar[TEAM_ALLIANCE].size();
    uint32 hordePlayers = m_PlayersInWar[TEAM_HORDE].size();
    int32 newStack = 0;

    if (alliancePlayers && hordePlayers)
    {
        if (alliancePlayers < hordePlayers)
            newStack = int32((((float)hordePlayers / alliancePlayers) - 1.0f) * 4.0f);  // positive, should cast on alliance
        else if (alliancePlayers > hordePlayers)
            newStack = int32((1.0f - ((float)alliancePlayers / hordePlayers)) * 4.0f);  // negative, should cast on horde
    }

    // Return if no change in stack and apply tenacity to new player
    if (newStack == m_tenacityStack)
    {
        for (GuidUnorderedSet::const_iterator itr = m_updateTenacityList.begin(); itr != m_updateTenacityList.end(); ++itr)
            if (Player* newPlayer = ObjectAccessor::FindPlayer(*itr))
                if ((newPlayer->GetTeamId() == TEAM_ALLIANCE && m_tenacityStack > 0) || (newPlayer->GetTeamId() == TEAM_HORDE && m_tenacityStack < 0))
                {
                    newStack = std::min(std::abs(newStack), 20);
                    uint32 buff_honor = GetHonorBuff(newStack);
                    newPlayer->SetAuraStack(SPELL_TENACITY, newPlayer, newStack);
                    if (buff_honor)
                        newPlayer->CastSpell(newPlayer, buff_honor, true);
                }
        return;
    }

    if (m_tenacityStack != 0)
    {
        if (m_tenacityStack > 0 && newStack <= 0)               // old buff was on alliance
            team = TEAM_ALLIANCE;
        else if (m_tenacityStack < 0 && newStack >= 0)          // old buff was on horde
            team = TEAM_HORDE;
    }

    m_tenacityStack = newStack;
    // Remove old buff
    if (team != TEAM_NEUTRAL)
    {
        for (GuidUnorderedSet::const_iterator itr = m_PlayersInWar[team].begin(); itr != m_PlayersInWar[team].end(); ++itr)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                player->RemoveAurasDueToSpell(SPELL_TENACITY);

        for (GuidUnorderedSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
            if (Creature* creature = GetCreature(*itr))
                creature->RemoveAurasDueToSpell(SPELL_TENACITY_VEHICLE);
    }

    // Apply new buff
    if (newStack)
    {
        team = newStack > 0 ? TEAM_ALLIANCE : TEAM_HORDE;
        newStack = std::min(std::abs(newStack), 20);
        uint32 buff_honor = GetHonorBuff(newStack);

        for (GuidUnorderedSet::const_iterator itr = m_PlayersInWar[team].begin(); itr != m_PlayersInWar[team].end(); ++itr)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
            {
                player->SetAuraStack(SPELL_TENACITY, player, newStack);
                if (buff_honor)
                    player->CastSpell(player, buff_honor, true);
            }

        for (GuidUnorderedSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
            if (Creature* creature = GetCreature(*itr))
            {
                creature->SetAuraStack(SPELL_TENACITY_VEHICLE, creature, newStack);
                if (buff_honor)
                    creature->CastSpell(creature, buff_honor, true);
            }
    }
}

WintergraspCapturePoint::WintergraspCapturePoint(BattlefieldWG* battlefield, TeamId teamInControl) : BfCapturePoint(battlefield)
{
    m_Bf = battlefield;
    m_team = teamInControl;
    m_Workshop = nullptr;
}

void WintergraspCapturePoint::ChangeTeam(TeamId /*oldTeam*/)
{
    ASSERT(m_Workshop);
    m_Workshop->GiveControlTo(m_team, false);
}

BfGraveyardWG::BfGraveyardWG(BattlefieldWG* battlefield) : BfGraveyard(battlefield)
{
    m_Bf = battlefield;
    m_GossipTextId = 0;
}
