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

#include "OutdoorPvPNA.h"
#include "GridNotifiers.h"
#include "ScriptedCreature.h"
#include "GameGraveyard.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldPacket.h"

OutdoorPvPNA::OutdoorPvPNA()
{
    m_TypeId = OUTDOOR_PVP_NA;
    m_obj = nullptr;
}

// SpawnIds from creatures
HalaaNPCS halaaNPCHorde;
HalaaNPCS halaaNPCAlly;

void OutdoorPvPNA::HandleKill(Player* killer, Unit* killed)
{
    if (Group* group = killer->GetGroup())
    {
        for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* groupGuy = itr->GetSource();

            if (!groupGuy)
                continue;

            // skip if too far away
            if (!groupGuy->IsAtGroupRewardDistance(killed) && killer != groupGuy)
                continue;

            // creature kills must be notified, even if not inside objective / not outdoor pvp active
            // player kills only count if active and inside objective
            if ((groupGuy->IsOutdoorPvPActive() && groupGuy->GetAreaId() == NA_HALAA_ZONE_ID) || killed->GetTypeId() == TYPEID_UNIT)
            {
                HandleKillImpl(groupGuy, killed);
            }
        }
    }
    else
    {
        // creature kills must be notified, even if not inside objective / not outdoor pvp active
        if (killer && ((killer->IsOutdoorPvPActive() && killer->ToPlayer()->GetAreaId() == NA_HALAA_ZONE_ID) || killed->GetTypeId() == TYPEID_UNIT))
        {
            HandleKillImpl(killer, killed);
        }
    }
}

void OutdoorPvPNA::HandleKillImpl(Player* player, Unit* killed)
{
    if (killed->GetTypeId() == TYPEID_PLAYER && player->GetTeamId() != killed->ToPlayer()->GetTeamId())
    {
        player->KilledMonsterCredit(NA_CREDIT_MARKER);
        player->CastSpell(player, player->GetTeamId() == TEAM_ALLIANCE ? NA_KILL_TOKEN_ALLIANCE : NA_KILL_TOKEN_HORDE, true);
    }
}

uint32 OPvPCapturePointNA::GetAliveGuardsCount()
{
    uint32 cnt = 0;
    for (std::map<uint32, ObjectGuid::LowType>::iterator itr = m_Creatures.begin(); itr != m_Creatures.end(); ++itr)
    {
        auto bounds = m_PvP->GetMap()->GetCreatureBySpawnIdStore().equal_range(itr->second);
        for (auto itr2 = bounds.first; itr2 != bounds.second; ++itr2)
            if (itr2->second->IsAlive() && (itr2->second->GetEntry() == NA_HALAANI_GUARD_A || itr2->second->GetEntry() == NA_HALAANI_GUARD_H))
                ++cnt;
    }
    return cnt;
}

TeamId OPvPCapturePointNA::GetControllingFaction() const
{
    return m_ControllingFaction;
}

void OPvPCapturePointNA::DespawnNPCs(HalaaNPCS teamNPC)
{
    for (int i = 0; i < NA_HALAA_CREATURE_TEAM_SPAWN; i++)
    {
        ObjectGuid::LowType spawnId = teamNPC[i];
        auto bounds = m_PvP->GetMap()->GetCreatureBySpawnIdStore().equal_range(spawnId);
        const CreatureData* data = sObjectMgr->GetCreatureData(spawnId);
        for (auto itr = bounds.first; itr != bounds.second;)
        {
            // can happen when closing the core
            Creature* c = itr->second;
            if (c)
            {
                ++itr;
                c->AddObjectToRemoveList();
                sObjectMgr->RemoveCreatureFromGrid(spawnId, data);
                m_Creatures[i] = 0;
                m_CreatureTypes[m_Creatures[i]] = 0;
            }
        }
    }
}

void OPvPCapturePointNA::SpawnNPCsForTeam(HalaaNPCS teamNPC)
{
    for (int i = 0; i < NA_HALAA_CREATURE_TEAM_SPAWN; i++)
    {
        ObjectGuid::LowType spawnId = teamNPC[i];
        const CreatureData* data = sObjectMgr->GetCreatureData(spawnId);
        if (data) {
            sObjectMgr->UpdateCreatureHalaa(spawnId, m_PvP->GetMap(), data->posX, data->posY);
            m_Creatures[i] = spawnId;
            m_CreatureTypes[m_Creatures[i]] = i;
        }
    }
}

void OPvPCapturePointNA::SpawnGOsForTeam(TeamId teamId)
{
    const go_type* gos = nullptr;
    if (teamId == TEAM_ALLIANCE)
        gos = AllianceControlGOs;
    else if (teamId == TEAM_HORDE)
        gos = HordeControlGOs;
    else
        return;
    for (int i = 0; i < NA_CONTROL_GO_NUM; ++i)
    {
        if (i == NA_ROOST_S ||
                i == NA_ROOST_W ||
                i == NA_ROOST_N ||
                i == NA_ROOST_E ||
                i == NA_BOMB_WAGON_S ||
                i == NA_BOMB_WAGON_W ||
                i == NA_BOMB_WAGON_N ||
                i == NA_BOMB_WAGON_E)
            continue;   // roosts and bomb wagons are spawned when someone uses the matching destroyed roost
        AddObject(i, gos[i].entry, gos[i].map, gos[i].x, gos[i].y, gos[i].z, gos[i].o, gos[i].rot0, gos[i].rot1, gos[i].rot2, gos[i].rot3);
    }
}

void OPvPCapturePointNA::DeSpawnGOs()
{
    for (int i = 0; i < NA_CONTROL_GO_NUM; ++i)
    {
        DelObject(i);
    }
}

void OPvPCapturePointNA::FactionTakeOver(TeamId teamId)
{
    if (m_ControllingFaction != TEAM_NEUTRAL)
        sGraveyard->RemoveGraveyardLink(NA_HALAA_GRAVEYARD, NA_HALAA_GRAVEYARD_ZONE, m_ControllingFaction, false);
    if (m_ControllingFaction == TEAM_ALLIANCE)
        sWorld->SendZoneText(NA_HALAA_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_NA_LOSE_A));
    else if (m_ControllingFaction == TEAM_HORDE)
        sWorld->SendZoneText(NA_HALAA_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_NA_LOSE_H));
    DespawnNPCs(GetControllingFaction() == TEAM_HORDE ? halaaNPCHorde : halaaNPCAlly);
    m_ControllingFaction = teamId;
    if (m_ControllingFaction != TEAM_NEUTRAL)
        sGraveyard->AddGraveyardLink(NA_HALAA_GRAVEYARD, NA_HALAA_GRAVEYARD_ZONE, m_ControllingFaction, false);
    DeSpawnGOs();
    SpawnGOsForTeam(teamId);
    SpawnNPCsForTeam(GetControllingFaction() == TEAM_HORDE ? halaaNPCHorde : halaaNPCAlly);
    m_GuardsAlive = NA_GUARDS_MAX;
    m_capturable = false;
    m_canRecap = false;
    this->UpdateHalaaWorldState();
    if (teamId == TEAM_ALLIANCE)
    {
        m_WyvernStateSouth = WYVERN_NEU_HORDE;
        m_WyvernStateNorth = WYVERN_NEU_HORDE;
        m_WyvernStateEast = WYVERN_NEU_HORDE;
        m_WyvernStateWest = WYVERN_NEU_HORDE;
        m_PvP->TeamApplyBuff(TEAM_ALLIANCE, NA_CAPTURE_BUFF);
        m_PvP->SendUpdateWorldState(NA_UI_HORDE_GUARDS_SHOW, 0);
        m_PvP->SendUpdateWorldState(NA_UI_ALLIANCE_GUARDS_SHOW, 1);
        m_PvP->SendUpdateWorldState(NA_UI_GUARDS_LEFT, m_GuardsAlive);
        sWorld->SendZoneText(NA_HALAA_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_NA_CAPTURE_A));
    }
    else if(teamId == TEAM_HORDE)
    {
        m_WyvernStateSouth = WYVERN_NEU_ALLIANCE;
        m_WyvernStateNorth = WYVERN_NEU_ALLIANCE;
        m_WyvernStateEast = WYVERN_NEU_ALLIANCE;
        m_WyvernStateWest = WYVERN_NEU_ALLIANCE;
        m_PvP->TeamApplyBuff(TEAM_HORDE, NA_CAPTURE_BUFF);
        m_PvP->SendUpdateWorldState(NA_UI_HORDE_GUARDS_SHOW, 1);
        m_PvP->SendUpdateWorldState(NA_UI_ALLIANCE_GUARDS_SHOW, 0);
        m_PvP->SendUpdateWorldState(NA_UI_GUARDS_LEFT, m_GuardsAlive);
        sWorld->SendZoneText(NA_HALAA_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_NA_CAPTURE_H));
    }
    UpdateWyvernRoostWorldState(NA_ROOST_S);
    UpdateWyvernRoostWorldState(NA_ROOST_N);
    UpdateWyvernRoostWorldState(NA_ROOST_W);
    UpdateWyvernRoostWorldState(NA_ROOST_E);
}

bool OPvPCapturePointNA::HandlePlayerEnter(Player* player)
{
    if (OPvPCapturePoint::HandlePlayerEnter(player))
    {
        player->SendUpdateWorldState(NA_UI_TOWER_SLIDER_DISPLAY, 1);
        uint32 phase = (uint32)ceil((m_value + m_maxValue) / (2 * m_maxValue) * 100.0f);
        player->SendUpdateWorldState(NA_UI_TOWER_SLIDER_POS, phase);
        player->SendUpdateWorldState(NA_UI_TOWER_SLIDER_N, m_neutralValuePct);
        return true;
    }
    return false;
}

void OPvPCapturePointNA::HandlePlayerLeave(Player* player)
{
    player->SendUpdateWorldState(NA_UI_TOWER_SLIDER_DISPLAY, 0);
    OPvPCapturePoint::HandlePlayerLeave(player);
}

OPvPCapturePointNA::OPvPCapturePointNA(OutdoorPvP* pvp) :
    OPvPCapturePoint(pvp), m_capturable(true), m_GuardsAlive(0), m_ControllingFaction(TEAM_NEUTRAL),
    m_WyvernStateNorth(0), m_WyvernStateSouth(0), m_WyvernStateEast(0), m_WyvernStateWest(0),
    m_HalaaState(HALAA_N), m_RespawnTimer(NA_RESPAWN_TIME), m_GuardCheckTimer(NA_GUARD_CHECK_TIME), m_canRecap(true)
{
    SetCapturePointData(182210, 530, -1572.57f, 7945.3f, -22.475f, 2.05949f, 0.0f, 0.0f, 0.857167f, 0.515038f);
}

bool OutdoorPvPNA::SetupOutdoorPvP()
{
    //    m_TypeId = OUTDOOR_PVP_NA; _MUST_ be set in ctor, because of spawns cleanup
    // add the zones affected by the pvp buff
    RegisterZone(NA_BUFF_ZONE);
    SetMapFromZone(NA_BUFF_ZONE);

    // halaa
    m_obj = new OPvPCapturePointNA(this);
    if (!m_obj)
        return false;
    AddCapturePoint(m_obj);

    //Remove linked graveyard at the server start to avoid players spawning in halaa
    sGraveyard->RemoveGraveyardLink(NA_HALAA_GRAVEYARD, NA_HALAA_GRAVEYARD_ZONE, TEAM_ALLIANCE, false);
    sGraveyard->RemoveGraveyardLink(NA_HALAA_GRAVEYARD, NA_HALAA_GRAVEYARD_ZONE, TEAM_HORDE, false);

    return true;
}

void OutdoorPvPNA::HandlePlayerEnterZone(Player* player, uint32 zone)
{
    // add buffs
    if (player->GetTeamId() == m_obj->GetControllingFaction())
        player->CastSpell(player, NA_CAPTURE_BUFF, true);
    OutdoorPvP::HandlePlayerEnterZone(player, zone);
}

void OutdoorPvPNA::HandlePlayerLeaveZone(Player* player, uint32 zone)
{
    // remove buffs
    player->RemoveAurasDueToSpell(NA_CAPTURE_BUFF);
    OutdoorPvP::HandlePlayerLeaveZone(player, zone);
}

void OutdoorPvPNA::FillInitialWorldStates(WorldPacket& data)
{
    m_obj->FillInitialWorldStates(data);
}

void OPvPCapturePointNA::FillInitialWorldStates(WorldPacket& data)
{
    if (m_ControllingFaction == TEAM_ALLIANCE)
    {
        data << NA_UI_HORDE_GUARDS_SHOW << uint32(0);
        data << NA_UI_ALLIANCE_GUARDS_SHOW << uint32(1);
    }
    else if (m_ControllingFaction == TEAM_HORDE)
    {
        data << NA_UI_HORDE_GUARDS_SHOW << uint32(1);
        data << NA_UI_ALLIANCE_GUARDS_SHOW << uint32(0);
    }
    else
    {
        data << NA_UI_HORDE_GUARDS_SHOW << uint32(0);
        data << NA_UI_ALLIANCE_GUARDS_SHOW << uint32(0);
    }

    data << NA_UI_GUARDS_MAX << NA_GUARDS_MAX;
    data << NA_UI_GUARDS_LEFT << uint32(m_GuardsAlive);

    data << NA_UI_TOWER_SLIDER_DISPLAY << uint32(0);
    data << NA_UI_TOWER_SLIDER_POS << uint32(50);
    data << NA_UI_TOWER_SLIDER_N << uint32(100);

    data << NA_MAP_WYVERN_NORTH_NEU_H << uint32(bool(m_WyvernStateNorth & WYVERN_NEU_HORDE));
    data << NA_MAP_WYVERN_NORTH_NEU_A << uint32(bool(m_WyvernStateNorth & WYVERN_NEU_ALLIANCE));
    data << NA_MAP_WYVERN_NORTH_H << uint32(bool(m_WyvernStateNorth & WYVERN_HORDE));
    data << NA_MAP_WYVERN_NORTH_A << uint32(bool(m_WyvernStateNorth & WYVERN_ALLIANCE));

    data << NA_MAP_WYVERN_SOUTH_NEU_H << uint32(bool(m_WyvernStateSouth & WYVERN_NEU_HORDE));
    data << NA_MAP_WYVERN_SOUTH_NEU_A << uint32(bool(m_WyvernStateSouth & WYVERN_NEU_ALLIANCE));
    data << NA_MAP_WYVERN_SOUTH_H << uint32(bool(m_WyvernStateSouth & WYVERN_HORDE));
    data << NA_MAP_WYVERN_SOUTH_A << uint32(bool(m_WyvernStateSouth & WYVERN_ALLIANCE));

    data << NA_MAP_WYVERN_WEST_NEU_H << uint32(bool(m_WyvernStateWest & WYVERN_NEU_HORDE));
    data << NA_MAP_WYVERN_WEST_NEU_A << uint32(bool(m_WyvernStateWest & WYVERN_NEU_ALLIANCE));
    data << NA_MAP_WYVERN_WEST_H << uint32(bool(m_WyvernStateWest & WYVERN_HORDE));
    data << NA_MAP_WYVERN_WEST_A << uint32(bool(m_WyvernStateWest & WYVERN_ALLIANCE));

    data << NA_MAP_WYVERN_EAST_NEU_H << uint32(bool(m_WyvernStateEast & WYVERN_NEU_HORDE));
    data << NA_MAP_WYVERN_EAST_NEU_A << uint32(bool(m_WyvernStateEast & WYVERN_NEU_ALLIANCE));
    data << NA_MAP_WYVERN_EAST_H << uint32(bool(m_WyvernStateEast & WYVERN_HORDE));
    data << NA_MAP_WYVERN_EAST_A << uint32(bool(m_WyvernStateEast & WYVERN_ALLIANCE));

    data << NA_MAP_HALAA_NEUTRAL << uint32(bool(m_HalaaState & HALAA_N));
    data << NA_MAP_HALAA_NEU_A << uint32(bool(m_HalaaState & HALAA_N_A));
    data << NA_MAP_HALAA_NEU_H << uint32(bool(m_HalaaState & HALAA_N_H));
    data << NA_MAP_HALAA_HORDE << uint32(bool(m_HalaaState & HALAA_H));
    data << NA_MAP_HALAA_ALLIANCE << uint32(bool(m_HalaaState & HALAA_A));
}

void OutdoorPvPNA::SendRemoveWorldStates(Player* player)
{
    player->SendUpdateWorldState(NA_UI_HORDE_GUARDS_SHOW, 0);
    player->SendUpdateWorldState(NA_UI_ALLIANCE_GUARDS_SHOW, 0);
    player->SendUpdateWorldState(NA_UI_GUARDS_MAX, 0);
    player->SendUpdateWorldState(NA_UI_GUARDS_LEFT, 0);
    player->SendUpdateWorldState(NA_UI_TOWER_SLIDER_DISPLAY, 0);
    player->SendUpdateWorldState(NA_UI_TOWER_SLIDER_POS, 0);
    player->SendUpdateWorldState(NA_UI_TOWER_SLIDER_N, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_NORTH_NEU_H, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_NORTH_NEU_A, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_NORTH_H, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_NORTH_A, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_SOUTH_NEU_H, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_SOUTH_NEU_A, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_SOUTH_H, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_SOUTH_A, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_WEST_NEU_H, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_WEST_NEU_A, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_WEST_H, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_WEST_A, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_EAST_NEU_H, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_EAST_NEU_A, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_EAST_H, 0);
    player->SendUpdateWorldState(NA_MAP_WYVERN_EAST_A, 0);
    player->SendUpdateWorldState(NA_MAP_HALAA_NEUTRAL, 0);
    player->SendUpdateWorldState(NA_MAP_HALAA_NEU_A, 0);
    player->SendUpdateWorldState(NA_MAP_HALAA_NEU_H, 0);
    player->SendUpdateWorldState(NA_MAP_HALAA_HORDE, 0);
    player->SendUpdateWorldState(NA_MAP_HALAA_ALLIANCE, 0);
}

bool OutdoorPvPNA::Update(uint32 diff)
{
    return m_obj->Update(diff);
}

void FlagPlayerPvP(Player* player)
{
    player->SetPlayerFlag(PLAYER_FLAGS_IN_PVP);
    player->UpdatePvP(true, true);
}

bool OPvPCapturePointNA::HandleCustomSpell(Player* player, uint32 spellId, GameObject* /*go*/)
{
    std::vector<uint32> nodes;
    nodes.resize(2);
    bool retval = false;
    switch (spellId)
    {
        case NA_SPELL_FLY_NORTH:
            nodes[0] = FlightPathStartNodes[NA_ROOST_N];
            nodes[1] = FlightPathEndNodes[NA_ROOST_N];
            player->ActivateTaxiPathTo(nodes);
            FlagPlayerPvP(player);
            retval = true;
            break;
        case NA_SPELL_FLY_SOUTH:
            nodes[0] = FlightPathStartNodes[NA_ROOST_S];
            nodes[1] = FlightPathEndNodes[NA_ROOST_S];
            player->ActivateTaxiPathTo(nodes);
            FlagPlayerPvP(player);
            retval = true;
            break;
        case NA_SPELL_FLY_WEST:
            nodes[0] = FlightPathStartNodes[NA_ROOST_W];
            nodes[1] = FlightPathEndNodes[NA_ROOST_W];
            player->ActivateTaxiPathTo(nodes);
            FlagPlayerPvP(player);
            retval = true;
            break;
        case NA_SPELL_FLY_EAST:
            nodes[0] = FlightPathStartNodes[NA_ROOST_E];
            nodes[1] = FlightPathEndNodes[NA_ROOST_E];
            player->ActivateTaxiPathTo(nodes);
            FlagPlayerPvP(player);
            retval = true;
            break;
        default:
            break;
    }

    if (retval)
    {
        //Adding items
        uint32 noSpaceForCount = 0;

        // check space and find places
        ItemPosCountVec dest;

        int32 count = 10;
        // bomb id count
        InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, NA_HALAA_BOMB, count, &noSpaceForCount);
        if (msg != EQUIP_ERR_OK)                               // convert to possible store amount
            count -= noSpaceForCount;

        if (count == 0 || dest.empty())                         // can't add any
        {
            return true;
        }

        Item* item = player->StoreNewItem(dest, NA_HALAA_BOMB, true);

        if (count > 0 && item)
        {
            player->SendNewItem(item, count, true, false);
        }

        return true;
    }
    return false;
}

int32 OPvPCapturePointNA::HandleOpenGo(Player* player, GameObject* go)
{
    int32 retval = OPvPCapturePoint::HandleOpenGo(player, go);
    if (retval >= 0)
    {
        const go_type* gos = nullptr;
        if (m_ControllingFaction == TEAM_ALLIANCE)
            gos = AllianceControlGOs;
        else if (m_ControllingFaction == TEAM_HORDE)
            gos = HordeControlGOs;
        else
            return -1;

        int32 del = -1;
        int32 del2 = -1;
        int32 add = -1;
        int32 add2 = -1;

        switch (retval)
        {
            case NA_DESTROYED_ROOST_S:
                del = NA_DESTROYED_ROOST_S;
                add = NA_ROOST_S;
                add2 = NA_BOMB_WAGON_S;
                if (m_ControllingFaction == TEAM_HORDE)
                    m_WyvernStateSouth = WYVERN_ALLIANCE;
                else
                    m_WyvernStateSouth = WYVERN_HORDE;
                UpdateWyvernRoostWorldState(NA_ROOST_S);
                FlagPlayerPvP(player);
                break;
            case NA_DESTROYED_ROOST_N:
                del = NA_DESTROYED_ROOST_N;
                add = NA_ROOST_N;
                add2 = NA_BOMB_WAGON_N;
                if (m_ControllingFaction == TEAM_HORDE)
                    m_WyvernStateNorth = WYVERN_ALLIANCE;
                else
                    m_WyvernStateNorth = WYVERN_HORDE;
                UpdateWyvernRoostWorldState(NA_ROOST_N);
                FlagPlayerPvP(player);
                break;
            case NA_DESTROYED_ROOST_W:
                del = NA_DESTROYED_ROOST_W;
                add = NA_ROOST_W;
                add2 = NA_BOMB_WAGON_W;
                if (m_ControllingFaction == TEAM_HORDE)
                    m_WyvernStateWest = WYVERN_ALLIANCE;
                else
                    m_WyvernStateWest = WYVERN_HORDE;
                UpdateWyvernRoostWorldState(NA_ROOST_W);
                FlagPlayerPvP(player);
                break;
            case NA_DESTROYED_ROOST_E:
                del = NA_DESTROYED_ROOST_E;
                add = NA_ROOST_E;
                add2 = NA_BOMB_WAGON_E;
                if (m_ControllingFaction == TEAM_HORDE)
                    m_WyvernStateEast = WYVERN_ALLIANCE;
                else
                    m_WyvernStateEast = WYVERN_HORDE;
                UpdateWyvernRoostWorldState(NA_ROOST_E);
                FlagPlayerPvP(player);
                break;
            case NA_BOMB_WAGON_S:
                del = NA_BOMB_WAGON_S;
                del2 = NA_ROOST_S;
                add = NA_DESTROYED_ROOST_S;
                if (m_ControllingFaction == TEAM_HORDE)
                    m_WyvernStateSouth = WYVERN_NEU_ALLIANCE;
                else
                    m_WyvernStateSouth = WYVERN_NEU_HORDE;
                UpdateWyvernRoostWorldState(NA_ROOST_S);
                FlagPlayerPvP(player);
                break;
            case NA_BOMB_WAGON_N:
                del = NA_BOMB_WAGON_N;
                del2 = NA_ROOST_N;
                add = NA_DESTROYED_ROOST_N;
                if (m_ControllingFaction == TEAM_HORDE)
                    m_WyvernStateNorth = WYVERN_NEU_ALLIANCE;
                else
                    m_WyvernStateNorth = WYVERN_NEU_HORDE;
                UpdateWyvernRoostWorldState(NA_ROOST_N);
                FlagPlayerPvP(player);
                break;
            case NA_BOMB_WAGON_W:
                del = NA_BOMB_WAGON_W;
                del2 = NA_ROOST_W;
                add = NA_DESTROYED_ROOST_W;
                if (m_ControllingFaction == TEAM_HORDE)
                    m_WyvernStateWest = WYVERN_NEU_ALLIANCE;
                else
                    m_WyvernStateWest = WYVERN_NEU_HORDE;
                UpdateWyvernRoostWorldState(NA_ROOST_W);
                FlagPlayerPvP(player);
                break;
            case NA_BOMB_WAGON_E:
                del = NA_BOMB_WAGON_E;
                del2 = NA_ROOST_E;
                add = NA_DESTROYED_ROOST_E;
                if (m_ControllingFaction == TEAM_HORDE)
                    m_WyvernStateEast = WYVERN_NEU_ALLIANCE;
                else
                    m_WyvernStateEast = WYVERN_NEU_HORDE;
                UpdateWyvernRoostWorldState(NA_ROOST_E);
                FlagPlayerPvP(player);
                break;
            default:
                return -1;
                break;
        }

        if (del > -1)
            DelObject(del);

        if (del2 > -1)
            DelObject(del2);

        if (add > -1)
            AddObject(add, gos[add].entry, gos[add].map, gos[add].x, gos[add].y, gos[add].z, gos[add].o, gos[add].rot0, gos[add].rot1, gos[add].rot2, gos[add].rot3);

        if (add2 > -1)
            AddObject(add2, gos[add2].entry, gos[add2].map, gos[add2].x, gos[add2].y, gos[add2].z, gos[add2].o, gos[add2].rot0, gos[add2].rot1, gos[add2].rot2, gos[add2].rot3);

        return retval;
    }
    return -1;
}

bool OPvPCapturePointNA::Update(uint32 diff)
{
    if (!m_capturePoint)
        return false;

    float radius = ((float)m_capturePoint->GetGOInfo()->capturePoint.radius);

    for (PlayerSet playerSet : m_activePlayers)
    {
        for (ObjectGuid playerGuid : playerSet)
        {
            if (Player* player = ObjectAccessor::FindPlayer(playerGuid))
                if (!m_capturePoint->IsWithinDistInMap(player, radius) || !player->IsOutdoorPvPActive())
                    HandlePlayerLeave(player);
        }
    }

    std::list<Player*> players;
    Acore::AnyPlayerInObjectRangeCheck checker(m_capturePoint, radius);
    Acore::PlayerListSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(m_capturePoint, players, checker);
    Cell::VisitWorldObjects(m_capturePoint, searcher, radius);

    for (Player* const player : players)
    {
        if (player->IsOutdoorPvPActive())
        {
            if (m_activePlayers[player->GetTeamId()].insert(player->GetGUID()).second)
                HandlePlayerEnter(player);
        }
    }

    if (m_GuardCheckTimer < diff)
    {
        m_GuardCheckTimer = NA_GUARD_CHECK_TIME;
        uint32 cnt = GetAliveGuardsCount();
        if (cnt != m_GuardsAlive)
        {
            m_GuardsAlive = cnt;
            if (m_GuardsAlive == 0)
            {
                m_capturable = true;
                m_RespawnTimer = NA_RESPAWN_TIME;
                sWorld->SendZoneText(NA_HALAA_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_NA_DEFENSELESS));
            }
            else
                m_capturable = false;
            // update the guard count for the players in zone
            m_PvP->SendUpdateWorldState(NA_UI_GUARDS_LEFT, m_GuardsAlive);
        }
    }
    else m_GuardCheckTimer -= diff;

    if (m_capturable) {
        if (m_RespawnTimer < diff) {
            // if the guards have been killed, then the challenger has one hour to take over halaa.
            // in case they fail to do it, the guards are respawned, and they have to start again.
            if (GetControllingFaction() == TEAM_ALLIANCE) {
                m_State = OBJECTIVESTATE_ALLIANCE;
                m_value = m_maxValue;
            }
            else
            {
                m_State = OBJECTIVESTATE_HORDE;
                m_value = -m_maxValue;
            }
            // we reset again the artkit, map icons, sliders and respawn Halaa for controller team
            SendChangePhase();
            ChangeState();
            FactionTakeOver(GetControllingFaction());
            return true;
        }
        else if (GetControllingFaction() != TEAM_NEUTRAL) // Don't decrease the respawn timer if the team is not HORDE or ALLIANCE
            m_RespawnTimer -= diff;

        // get the difference of numbers
        float fact_diff = ((float)m_activePlayers[0].size() - (float)m_activePlayers[1].size()) * diff / OUTDOORPVP_OBJECTIVE_UPDATE_INTERVAL;
        if (!fact_diff)
            return false;

        float maxDiff = m_maxSpeed * diff;

        if (fact_diff < 0)
        {
            // horde is in majority, but it's already horde-controlled -> no change
            if (m_State == OBJECTIVESTATE_HORDE && m_value <= -m_maxValue)
                return false;

            if (fact_diff < -maxDiff)
                fact_diff = -maxDiff;
        }
        else
        {
            // ally is in majority, but it's already ally-controlled -> no change
            if (m_State == OBJECTIVESTATE_ALLIANCE && m_value >= m_maxValue)
                return false;

            if (fact_diff > maxDiff)
                fact_diff = maxDiff;
        }

        float oldValue = m_value;
        TeamId oldTeam = m_team;

        m_OldState = m_State;

        m_value += fact_diff;

        if (m_value < -m_minValue) // red
        {
            if (m_value < -m_maxValue) //check if the m_value is lower than max, that means horde capped point
            {
                m_value = -m_maxValue;
                m_State = OBJECTIVESTATE_HORDE;
                m_team = TEAM_HORDE;
            }
            else //then point is still in battle between teams
            {
                if (m_OldState == OBJECTIVESTATE_NEUTRAL || m_OldState == OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE || m_OldState == OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE)
                {
                    m_State = OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE;
                }
                else
                {
                    m_State = OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE;
                }
            }
            if (GetControllingFaction() == TEAM_ALLIANCE && !m_canRecap)
            {
                //When the point goes through neutral, the same faction can recapture again to respawn the guards, still need check blizzlike
                m_canRecap = true;
                DeSpawnGOs();
                DespawnNPCs(GetControllingFaction() == TEAM_HORDE ? halaaNPCHorde : halaaNPCAlly);
            }
        }
        else //blue
        {
            if (m_value > m_maxValue) //check if the m_value is bigger than max, that means alliance capped point
            {
                m_value = m_maxValue;
                m_State = OBJECTIVESTATE_ALLIANCE;
                m_team = TEAM_ALLIANCE;
            }
            else //then point is still in battle between teams
            {
                if (m_OldState == OBJECTIVESTATE_NEUTRAL || m_OldState == OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE || m_OldState == OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE)
                {
                    m_State = OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE;
                }
                else
                {
                    m_State = OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE;
                }
            }
            if (GetControllingFaction() == TEAM_HORDE && !m_canRecap)
            {
                //When the point goes through neutral, the same faction can recapture again to respawn the guards, still need check blizzlike
                m_canRecap = true;
                DeSpawnGOs();
                DespawnNPCs(GetControllingFaction() == TEAM_HORDE ? halaaNPCHorde : halaaNPCAlly);
            }
        }

        if (m_value != oldValue)
        {
            SendChangePhase();
        }

        if (m_OldState != m_State)
        {
            if (oldTeam != m_team)
            {
                ChangeTeam(oldTeam);
            }
            ChangeState();
            return true;
        }
    }
    else
        SendUpdateWorldState(NA_UI_TOWER_SLIDER_DISPLAY, 0); //Point is not capturable so we hide the slider
    return false;
}

void OPvPCapturePointNA::ChangeState()
{
    uint32 artkit = 21;
    switch (m_State)
    {
        case OBJECTIVESTATE_NEUTRAL:
            m_HalaaState = HALAA_N;
            break;
        case OBJECTIVESTATE_ALLIANCE:
            m_HalaaState = HALAA_A;
            if(m_canRecap)
                FactionTakeOver(TEAM_ALLIANCE);
            artkit = 2;
            break;
        case OBJECTIVESTATE_HORDE:
            m_HalaaState = HALAA_H;
            if (m_canRecap)
                FactionTakeOver(TEAM_HORDE);
            artkit = 1;
            break;
        case OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE:
            m_HalaaState = HALAA_N_A;
            break;
        case OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE:
            m_HalaaState = HALAA_N_H;
            break;
        case OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE:
            m_HalaaState = HALAA_N_A;
            artkit = 2;
            break;
        case OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE:
            m_HalaaState = HALAA_N_H;
            artkit = 1;
            break;
    }

    auto bounds = sMapMgr->FindMap(530, 0)->GetGameObjectBySpawnIdStore().equal_range(m_capturePointSpawnId);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);

    UpdateHalaaWorldState();
}

void OPvPCapturePointNA::SendChangePhase()
{
    // send this too, sometimes the slider disappears, dunno why :(
    SendUpdateWorldState(NA_UI_TOWER_SLIDER_DISPLAY, 1);
    // send these updates to only the ones in this objective
    uint32 phase = (uint32)ceil((m_value + m_maxValue) / (2 * m_maxValue) * 100.0f);
    SendUpdateWorldState(NA_UI_TOWER_SLIDER_POS, phase);
    SendUpdateWorldState(NA_UI_TOWER_SLIDER_N, m_neutralValuePct);
}

void OPvPCapturePointNA::UpdateHalaaWorldState()
{
    m_PvP->SendUpdateWorldState(NA_MAP_HALAA_NEUTRAL, uint32(bool(m_HalaaState & HALAA_N)));
    m_PvP->SendUpdateWorldState(NA_MAP_HALAA_NEU_A, uint32(bool(m_HalaaState & HALAA_N_A)));
    m_PvP->SendUpdateWorldState(NA_MAP_HALAA_NEU_H, uint32(bool(m_HalaaState & HALAA_N_H)));
    m_PvP->SendUpdateWorldState(NA_MAP_HALAA_HORDE, uint32(bool(m_HalaaState & HALAA_H)));
    m_PvP->SendUpdateWorldState(NA_MAP_HALAA_ALLIANCE, uint32(bool(m_HalaaState & HALAA_A)));
}

void OPvPCapturePointNA::UpdateWyvernRoostWorldState(uint32 roost)
{
    switch (roost)
    {
        case NA_ROOST_S:
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_SOUTH_NEU_H, uint32(bool(m_WyvernStateSouth & WYVERN_NEU_HORDE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_SOUTH_NEU_A, uint32(bool(m_WyvernStateSouth & WYVERN_NEU_ALLIANCE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_SOUTH_H, uint32(bool(m_WyvernStateSouth & WYVERN_HORDE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_SOUTH_A, uint32(bool(m_WyvernStateSouth & WYVERN_ALLIANCE)));
            break;
        case NA_ROOST_N:
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_NORTH_NEU_H, uint32(bool(m_WyvernStateNorth & WYVERN_NEU_HORDE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_NORTH_NEU_A, uint32(bool(m_WyvernStateNorth & WYVERN_NEU_ALLIANCE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_NORTH_H, uint32(bool(m_WyvernStateNorth & WYVERN_HORDE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_NORTH_A, uint32(bool(m_WyvernStateNorth & WYVERN_ALLIANCE)));
            break;
        case NA_ROOST_W:
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_WEST_NEU_H, uint32(bool(m_WyvernStateWest & WYVERN_NEU_HORDE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_WEST_NEU_A, uint32(bool(m_WyvernStateWest & WYVERN_NEU_ALLIANCE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_WEST_H, uint32(bool(m_WyvernStateWest & WYVERN_HORDE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_WEST_A, uint32(bool(m_WyvernStateWest & WYVERN_ALLIANCE)));
            break;
        case NA_ROOST_E:
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_EAST_NEU_H, uint32(bool(m_WyvernStateEast & WYVERN_NEU_HORDE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_EAST_NEU_A, uint32(bool(m_WyvernStateEast & WYVERN_NEU_ALLIANCE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_EAST_H, uint32(bool(m_WyvernStateEast & WYVERN_HORDE)));
            m_PvP->SendUpdateWorldState(NA_MAP_WYVERN_EAST_A, uint32(bool(m_WyvernStateEast & WYVERN_ALLIANCE)));
            break;
    }
}

class OutdoorPvP_nagrand : public OutdoorPvPScript
{
public:
    OutdoorPvP_nagrand() : OutdoorPvPScript("outdoorpvp_na") { }

    OutdoorPvP* GetOutdoorPvP() const override
    {
        return new OutdoorPvPNA();
    }
};

struct outdoorpvp_na_halaa_creatures : public ScriptedAI
{
    outdoorpvp_na_halaa_creatures(Creature* creature) : ScriptedAI(creature) { }

    void UpdateAI(uint32 /*diff*/) override
    {
        if (halaaNPCHorde.size() != NA_HALAA_CREATURE_TEAM_SPAWN && halaaNPCAlly.size() != NA_HALAA_CREATURE_TEAM_SPAWN)
        {
            std::list<Creature*> creatures;
            uint32 entry = 0;
            for (int i = 0; i < NA_HALAA_CREATURES; i++)
            {
                me->GetCreatureListWithEntryInGrid(creatures, PatrolCreatureEntry[i].idPatrol, 250);
            }

            if (creatures.size() == NA_HALAA_MAX_CREATURE_SPAWN)
            {
                for (std::list<Creature*>::iterator itr = creatures.begin(); itr != creatures.end(); ++itr)
                {
                    Creature* const c = *itr;
                    if (entry < NA_HALAA_CREATURE_TEAM_SPAWN)
                    {
                        halaaNPCHorde[entry] = c->GetSpawnId();
                    }
                    else
                    {
                        halaaNPCAlly[entry - NA_HALAA_CREATURE_TEAM_SPAWN] = c->GetSpawnId();
                    }
                    c->AddObjectToRemoveList();
                    entry++;
                    sObjectMgr->RemoveCreatureFromGrid(c->GetSpawnId(), c->GetCreatureData());
                }
            }
        }
        DoMeleeAttackIfReady();
    }
};

void AddSC_outdoorpvp_na()
{
    new OutdoorPvP_nagrand();
    RegisterCreatureAI(outdoorpvp_na_halaa_creatures);
}
