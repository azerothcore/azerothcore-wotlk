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

#include "OutdoorPvPEP.h"
#include "GameGraveyard.h"
#include "GameObject.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "OutdoorPvPScript.h"
#include "Player.h"
#include "World.h"
#include "WorldPacket.h"

OPvPCapturePointEP_EWT::OPvPCapturePointEP_EWT(OutdoorPvP* pvp)
    : OPvPCapturePoint(pvp), m_TowerState(EP_TS_N), m_UnitsSummonedSideId(TEAM_NEUTRAL)
{
    SetCapturePointData(EPCapturePoints[EP_EWT].entry, EPCapturePoints[EP_EWT].map, EPCapturePoints[EP_EWT].x, EPCapturePoints[EP_EWT].y, EPCapturePoints[EP_EWT].z, EPCapturePoints[EP_EWT].o, EPCapturePoints[EP_EWT].rot0, EPCapturePoints[EP_EWT].rot1, EPCapturePoints[EP_EWT].rot2, EPCapturePoints[EP_EWT].rot3);
    AddObject(EP_EWT_FLAGS, EPTowerFlags[EP_EWT].entry, EPTowerFlags[EP_EWT].map, EPTowerFlags[EP_EWT].x, EPTowerFlags[EP_EWT].y, EPTowerFlags[EP_EWT].z, EPTowerFlags[EP_EWT].o, EPTowerFlags[EP_EWT].rot0, EPTowerFlags[EP_EWT].rot1, EPTowerFlags[EP_EWT].rot2, EPTowerFlags[EP_EWT].rot3);
}

void OPvPCapturePointEP_EWT::ChangeState()
{
    // if changing from controlling alliance to horde or vice versa
    if ( _oldState == OBJECTIVESTATE_ALLIANCE && _oldState != _state )
    {
        sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_LOSE_EWT_A));
        ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_EWT, TEAM_NEUTRAL);
    }
    else if ( _oldState == OBJECTIVESTATE_HORDE && _oldState != _state )
    {
        sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_LOSE_EWT_H));
        ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_EWT, TEAM_NEUTRAL);
    }

    uint32 artkit = 21;

    switch (_state)
    {
        case OBJECTIVESTATE_ALLIANCE:
            m_TowerState = EP_TS_A;
            artkit = 2;
            SummonSupportUnitAtNorthpassTower(TEAM_ALLIANCE);
            ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_EWT, TEAM_ALLIANCE);
            if (_oldState != _state) sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_CAPTURE_EWT_A));
            break;
        case OBJECTIVESTATE_HORDE:
            m_TowerState = EP_TS_H;
            artkit = 1;
            SummonSupportUnitAtNorthpassTower(TEAM_HORDE);
            ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_EWT, TEAM_HORDE);
            if (_oldState != _state) sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_CAPTURE_EWT_H));
            break;
        case OBJECTIVESTATE_NEUTRAL:
            m_TowerState = EP_TS_N;
            break;
        case OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE:
        case OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE:
            m_TowerState = EP_TS_N_A;
            break;
        case OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE:
        case OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE:
            m_TowerState = EP_TS_N_H;
            break;
    }

    Map* map = sMapMgr->FindMap(0, 0);
    auto bounds = map->GetGameObjectBySpawnIdStore().equal_range(m_capturePointSpawnId);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);

    bounds = map->GetGameObjectBySpawnIdStore().equal_range(_objects[EP_EWT_FLAGS]);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);

    UpdateTowerState();

    // complete quest objective
    if (m_TowerState == EP_TS_A || m_TowerState == EP_TS_H)
        SendObjectiveComplete(EP_EWT_CM);
}

void OPvPCapturePointEP_EWT::SendChangePhase()
{
    // send this too, sometimes the slider disappears, dunno why :(
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 1);
    // send these updates to only the ones in this objective
    uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_POS, phase);
    // send this too, sometimes it resets :S
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_N, _neutralValuePct);
}

void OPvPCapturePointEP_EWT::FillInitialWorldStates(WorldPacket& data)
{
    data << EP_EWT_A << uint32(bool(m_TowerState & EP_TS_A));
    data << EP_EWT_H << uint32(bool(m_TowerState & EP_TS_H));
    data << EP_EWT_N_A << uint32(bool(m_TowerState & EP_TS_N_A));
    data << EP_EWT_N_H << uint32(bool(m_TowerState & EP_TS_N_H));
    data << EP_EWT_N << uint32(bool(m_TowerState & EP_TS_N));
}

void OPvPCapturePointEP_EWT::UpdateTowerState()
{
    _pvp->SendUpdateWorldState(EP_EWT_A, bool(m_TowerState & EP_TS_A));
    _pvp->SendUpdateWorldState(EP_EWT_H, bool(m_TowerState & EP_TS_H));
    _pvp->SendUpdateWorldState(EP_EWT_N_A, bool(m_TowerState & EP_TS_N_A));
    _pvp->SendUpdateWorldState(EP_EWT_N_H, bool(m_TowerState & EP_TS_N_H));
    _pvp->SendUpdateWorldState(EP_EWT_N, bool(m_TowerState & EP_TS_N));
}

bool OPvPCapturePointEP_EWT::HandlePlayerEnter(Player* player)
{
    if (OPvPCapturePoint::HandlePlayerEnter(player))
    {
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 1);
        uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_POS, phase);
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_N, _neutralValuePct);
        return true;
    }
    return false;
}

void OPvPCapturePointEP_EWT::HandlePlayerLeave(Player* player)
{
    player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 0);
    OPvPCapturePoint::HandlePlayerLeave(player);
}

void OPvPCapturePointEP_EWT::SummonSupportUnitAtNorthpassTower(TeamId teamId)
{
    if (m_UnitsSummonedSideId != teamId)
    {
        m_UnitsSummonedSideId = teamId;
        const creature_type* ct = teamId == TEAM_ALLIANCE ? EP_EWT_Summons_A : EP_EWT_Summons_H;

        for (uint8 i = 0; i < EP_EWT_NUM_CREATURES; ++i)
        {
            DelCreature(i);
            AddCreature(i, ct[i].entry, ct[i].map, ct[i].x, ct[i].y, ct[i].z, ct[i].o, 1000000);
        }
    }
}

// NPT
OPvPCapturePointEP_NPT::OPvPCapturePointEP_NPT(OutdoorPvP* pvp)
    : OPvPCapturePoint(pvp), m_TowerState(EP_TS_N), m_SummonedGOSideId(TEAM_NEUTRAL)
{
    SetCapturePointData(EPCapturePoints[EP_NPT].entry, EPCapturePoints[EP_NPT].map, EPCapturePoints[EP_NPT].x, EPCapturePoints[EP_NPT].y, EPCapturePoints[EP_NPT].z, EPCapturePoints[EP_NPT].o, EPCapturePoints[EP_NPT].rot0, EPCapturePoints[EP_NPT].rot1, EPCapturePoints[EP_NPT].rot2, EPCapturePoints[EP_NPT].rot3);
    AddObject(EP_NPT_FLAGS, EPTowerFlags[EP_NPT].entry, EPTowerFlags[EP_NPT].map, EPTowerFlags[EP_NPT].x, EPTowerFlags[EP_NPT].y, EPTowerFlags[EP_NPT].z, EPTowerFlags[EP_NPT].o, EPTowerFlags[EP_NPT].rot0, EPTowerFlags[EP_NPT].rot1, EPTowerFlags[EP_NPT].rot2, EPTowerFlags[EP_NPT].rot3);
}

void OPvPCapturePointEP_NPT::ChangeState()
{
    // if changing from controlling alliance to horde or vice versa
    if ( _oldState == OBJECTIVESTATE_ALLIANCE && _oldState != _state )
    {
        sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_LOSE_NPT_A));
        ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_NPT, TEAM_NEUTRAL);
    }
    else if ( _oldState == OBJECTIVESTATE_HORDE && _oldState != _state )
    {
        sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_LOSE_NPT_H));
        ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_NPT, TEAM_NEUTRAL);
    }

    uint32 artkit = 21;

    switch (_state)
    {
        case OBJECTIVESTATE_ALLIANCE:
            m_TowerState = EP_TS_A;
            artkit = 2;
            SummonGO(TEAM_ALLIANCE);
            ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_NPT, TEAM_ALLIANCE);
            if (_oldState != _state) sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_CAPTURE_NPT_A));
            break;
        case OBJECTIVESTATE_HORDE:
            m_TowerState = EP_TS_H;
            artkit = 1;
            SummonGO(TEAM_HORDE);
            ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_NPT, TEAM_HORDE);
            if (_oldState != _state) sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_CAPTURE_NPT_H));
            break;
        case OBJECTIVESTATE_NEUTRAL:
            m_TowerState = EP_TS_N;
            m_SummonedGOSideId = TEAM_NEUTRAL;
            DelObject(EP_NPT_BUFF);
            break;
        case OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE:
            m_TowerState = EP_TS_N_A;
            break;
        case OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE:
            m_TowerState = EP_TS_N_A;
            m_SummonedGOSideId = TEAM_NEUTRAL;
            DelObject(EP_NPT_BUFF);
            break;
        case OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE:
            m_TowerState = EP_TS_N_H;
            break;
        case OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE:
            m_TowerState = EP_TS_N_H;
            m_SummonedGOSideId = TEAM_NEUTRAL;
            DelObject(EP_NPT_BUFF);
            break;
    }

    Map* map = sMapMgr->FindMap(0, 0);
    auto bounds = map->GetGameObjectBySpawnIdStore().equal_range(m_capturePointSpawnId);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);

    bounds = map->GetGameObjectBySpawnIdStore().equal_range(_objects[EP_NPT_FLAGS]);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);

    UpdateTowerState();

    // complete quest objective
    if (m_TowerState == EP_TS_A || m_TowerState == EP_TS_H)
        SendObjectiveComplete(EP_NPT_CM);
}

void OPvPCapturePointEP_NPT::SendChangePhase()
{
    // send this too, sometimes the slider disappears, dunno why :(
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 1);
    // send these updates to only the ones in this objective
    uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_POS, phase);
    // send this too, sometimes it resets :S
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_N, _neutralValuePct);
}

void OPvPCapturePointEP_NPT::FillInitialWorldStates(WorldPacket& data)
{
    data << EP_NPT_A << uint32(bool(m_TowerState & EP_TS_A));
    data << EP_NPT_H << uint32(bool(m_TowerState & EP_TS_H));
    data << EP_NPT_N_A << uint32(bool(m_TowerState & EP_TS_N_A));
    data << EP_NPT_N_H << uint32(bool(m_TowerState & EP_TS_N_H));
    data << EP_NPT_N << uint32(bool(m_TowerState & EP_TS_N));
}

void OPvPCapturePointEP_NPT::UpdateTowerState()
{
    _pvp->SendUpdateWorldState(EP_NPT_A, bool(m_TowerState & EP_TS_A));
    _pvp->SendUpdateWorldState(EP_NPT_H, bool(m_TowerState & EP_TS_H));
    _pvp->SendUpdateWorldState(EP_NPT_N_A, bool(m_TowerState & EP_TS_N_A));
    _pvp->SendUpdateWorldState(EP_NPT_N_H, bool(m_TowerState & EP_TS_N_H));
    _pvp->SendUpdateWorldState(EP_NPT_N, bool(m_TowerState & EP_TS_N));
}

bool OPvPCapturePointEP_NPT::HandlePlayerEnter(Player* player)
{
    if (OPvPCapturePoint::HandlePlayerEnter(player))
    {
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 1);
        uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_POS, phase);
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_N, _neutralValuePct);
        return true;
    }
    return false;
}

void OPvPCapturePointEP_NPT::HandlePlayerLeave(Player* player)
{
    player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 0);
    OPvPCapturePoint::HandlePlayerLeave(player);
}

void OPvPCapturePointEP_NPT::SummonGO(TeamId teamId)
{
    if (m_SummonedGOSideId != teamId)
    {
        m_SummonedGOSideId = teamId;
        DelObject(EP_NPT_BUFF);
        AddObject(EP_NPT_BUFF, EP_NPT_LordaeronShrine.entry, EP_NPT_LordaeronShrine.map, EP_NPT_LordaeronShrine.x, EP_NPT_LordaeronShrine.y, EP_NPT_LordaeronShrine.z, EP_NPT_LordaeronShrine.o, EP_NPT_LordaeronShrine.rot0, EP_NPT_LordaeronShrine.rot1, EP_NPT_LordaeronShrine.rot2, EP_NPT_LordaeronShrine.rot3);
        Map* map = sMapMgr->FindMap(0, 0);
        auto bounds = map->GetGameObjectBySpawnIdStore().equal_range(_objects[EP_NPT_BUFF]);
        for (auto itr = bounds.first; itr != bounds.second; ++itr)
            if (GameObject* go = itr->second)
                go->SetUInt32Value(GAMEOBJECT_FACTION, (teamId == TEAM_ALLIANCE ? 84 : 83));
    }
}

// CGT
OPvPCapturePointEP_CGT::OPvPCapturePointEP_CGT(OutdoorPvP* pvp)
    : OPvPCapturePoint(pvp), m_TowerState(EP_TS_N), m_GraveyardSide(TEAM_NEUTRAL)
{
    SetCapturePointData(EPCapturePoints[EP_CGT].entry, EPCapturePoints[EP_CGT].map, EPCapturePoints[EP_CGT].x, EPCapturePoints[EP_CGT].y, EPCapturePoints[EP_CGT].z, EPCapturePoints[EP_CGT].o, EPCapturePoints[EP_CGT].rot0, EPCapturePoints[EP_CGT].rot1, EPCapturePoints[EP_CGT].rot2, EPCapturePoints[EP_CGT].rot3);
    AddObject(EP_CGT_FLAGS, EPTowerFlags[EP_CGT].entry, EPTowerFlags[EP_CGT].map, EPTowerFlags[EP_CGT].x, EPTowerFlags[EP_CGT].y, EPTowerFlags[EP_CGT].z, EPTowerFlags[EP_CGT].o, EPTowerFlags[EP_CGT].rot0, EPTowerFlags[EP_CGT].rot1, EPTowerFlags[EP_CGT].rot2, EPTowerFlags[EP_CGT].rot3);
}

void OPvPCapturePointEP_CGT::ChangeState()
{
    // if changing from controlling alliance to horde or vice versa
    if ( _oldState == OBJECTIVESTATE_ALLIANCE && _oldState != _state )
    {
        sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_LOSE_CGT_A));
        ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_CGT, TEAM_NEUTRAL);
    }
    else if ( _oldState == OBJECTIVESTATE_HORDE && _oldState != _state )
    {
        sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_LOSE_CGT_H));
        ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_CGT, TEAM_NEUTRAL);
    }

    uint32 artkit = 21;

    switch (_state)
    {
        case OBJECTIVESTATE_ALLIANCE:
            m_TowerState = EP_TS_A;
            artkit = 2;
            LinkGraveyard(TEAM_ALLIANCE);
            ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_CGT, TEAM_ALLIANCE);
            if (_oldState != _state) sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_CAPTURE_CGT_A));
            break;
        case OBJECTIVESTATE_HORDE:
            m_TowerState = EP_TS_H;
            artkit = 1;
            LinkGraveyard(TEAM_HORDE);
            ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_CGT, TEAM_HORDE);
            if (_oldState != _state) sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_CAPTURE_CGT_H));
            break;
        case OBJECTIVESTATE_NEUTRAL:
            m_TowerState = EP_TS_N;
            break;
        case OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE:
        case OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE:
            m_TowerState = EP_TS_N_A;
            break;
        case OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE:
        case OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE:
            m_TowerState = EP_TS_N_H;
            break;
    }

    Map* map = sMapMgr->FindMap(0, 0);
    auto bounds = map->GetGameObjectBySpawnIdStore().equal_range(m_capturePointSpawnId);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);

    bounds = map->GetGameObjectBySpawnIdStore().equal_range(_objects[EP_CGT_FLAGS]);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);

    UpdateTowerState();

    // complete quest objective
    if (m_TowerState == EP_TS_A || m_TowerState == EP_TS_H)
        SendObjectiveComplete(EP_CGT_CM);
}

void OPvPCapturePointEP_CGT::SendChangePhase()
{
    // send this too, sometimes the slider disappears, dunno why :(
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 1);
    // send these updates to only the ones in this objective
    uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_POS, phase);
    // send this too, sometimes it resets :S
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_N, _neutralValuePct);
}

void OPvPCapturePointEP_CGT::FillInitialWorldStates(WorldPacket& data)
{
    data << EP_CGT_A << uint32(bool(m_TowerState & EP_TS_A));
    data << EP_CGT_H << uint32(bool(m_TowerState & EP_TS_H));
    data << EP_CGT_N_A << uint32(bool(m_TowerState & EP_TS_N_A));
    data << EP_CGT_N_H << uint32(bool(m_TowerState & EP_TS_N_H));
    data << EP_CGT_N << uint32(bool(m_TowerState & EP_TS_N));
}

void OPvPCapturePointEP_CGT::UpdateTowerState()
{
    _pvp->SendUpdateWorldState(EP_CGT_A, bool(m_TowerState & EP_TS_A));
    _pvp->SendUpdateWorldState(EP_CGT_H, bool(m_TowerState & EP_TS_H));
    _pvp->SendUpdateWorldState(EP_CGT_N_A, bool(m_TowerState & EP_TS_N_A));
    _pvp->SendUpdateWorldState(EP_CGT_N_H, bool(m_TowerState & EP_TS_N_H));
    _pvp->SendUpdateWorldState(EP_CGT_N, bool(m_TowerState & EP_TS_N));
}

bool OPvPCapturePointEP_CGT::HandlePlayerEnter(Player* player)
{
    if (OPvPCapturePoint::HandlePlayerEnter(player))
    {
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 1);
        uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_POS, phase);
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_N, _neutralValuePct);
        return true;
    }
    return false;
}

void OPvPCapturePointEP_CGT::HandlePlayerLeave(Player* player)
{
    player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 0);
    OPvPCapturePoint::HandlePlayerLeave(player);
}

void OPvPCapturePointEP_CGT::LinkGraveyard(TeamId teamId)
{
    if (m_GraveyardSide != teamId)
    {
        sGraveyard->RemoveGraveyardLink(EP_GraveYardId, EP_GraveYardZone, m_GraveyardSide, false);
        sGraveyard->AddGraveyardLink(EP_GraveYardId, EP_GraveYardZone, teamId, false);
        m_GraveyardSide = teamId;
    }
}

// PWT
OPvPCapturePointEP_PWT::OPvPCapturePointEP_PWT(OutdoorPvP* pvp)
    : OPvPCapturePoint(pvp), m_FlightMasterSpawnedId(TEAM_NEUTRAL), m_TowerState(EP_TS_N)
{
    SetCapturePointData(EPCapturePoints[EP_PWT].entry, EPCapturePoints[EP_PWT].map, EPCapturePoints[EP_PWT].x, EPCapturePoints[EP_PWT].y, EPCapturePoints[EP_PWT].z, EPCapturePoints[EP_PWT].o, EPCapturePoints[EP_PWT].rot0, EPCapturePoints[EP_PWT].rot1, EPCapturePoints[EP_PWT].rot2, EPCapturePoints[EP_PWT].rot3);
    AddObject(EP_PWT_FLAGS, EPTowerFlags[EP_PWT].entry, EPTowerFlags[EP_PWT].map, EPTowerFlags[EP_PWT].x, EPTowerFlags[EP_PWT].y, EPTowerFlags[EP_PWT].z, EPTowerFlags[EP_PWT].o, EPTowerFlags[EP_PWT].rot0, EPTowerFlags[EP_PWT].rot1, EPTowerFlags[EP_PWT].rot2, EPTowerFlags[EP_PWT].rot3);
}

void OPvPCapturePointEP_PWT::ChangeState()
{
    // if changing from controlling alliance to horde or vice versa
    if ( _oldState == OBJECTIVESTATE_ALLIANCE && _oldState != _state )
    {
        sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_LOSE_PWT_A));
        ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_PWT, TEAM_NEUTRAL);
    }
    else if ( _oldState == OBJECTIVESTATE_HORDE && _oldState != _state )
    {
        sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_LOSE_PWT_H));
        ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_PWT, TEAM_NEUTRAL);
    }

    uint32 artkit = 21;

    switch (_state)
    {
        case OBJECTIVESTATE_ALLIANCE:
            m_TowerState = EP_TS_A;
            SummonFlightMaster(TEAM_ALLIANCE);
            artkit = 2;
            ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_PWT, TEAM_ALLIANCE);
            if (_oldState != _state) sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_CAPTURE_PWT_A));
            break;
        case OBJECTIVESTATE_HORDE:
            m_TowerState = EP_TS_H;
            SummonFlightMaster(TEAM_HORDE);
            artkit = 1;
            ((OutdoorPvPEP*)_pvp)->SetControlledState(EP_PWT, TEAM_HORDE);
            if (_oldState != _state) sWorld->SendZoneText(EP_GraveYardZone, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_CAPTURE_PWT_H));
            break;
        case OBJECTIVESTATE_NEUTRAL:
            m_TowerState = EP_TS_N;
            DelCreature(EP_PWT_FLIGHTMASTER);
            m_FlightMasterSpawnedId = TEAM_NEUTRAL;
            break;
        case OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE:
            m_TowerState = EP_TS_N_A;
            break;
        case OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE:
            m_TowerState = EP_TS_N_A;
            DelCreature(EP_PWT_FLIGHTMASTER);
            m_FlightMasterSpawnedId = TEAM_NEUTRAL;
            break;
        case OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE:
            m_TowerState = EP_TS_N_H;
            break;
        case OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE:
            m_TowerState = EP_TS_N_H;
            DelCreature(EP_PWT_FLIGHTMASTER);
            m_FlightMasterSpawnedId = TEAM_NEUTRAL;
            break;
    }

    Map* map = sMapMgr->FindMap(0, 0);
    auto bounds = map->GetGameObjectBySpawnIdStore().equal_range(m_capturePointSpawnId);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);

    bounds = map->GetGameObjectBySpawnIdStore().equal_range(_objects[EP_PWT_FLAGS]);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);

    UpdateTowerState();

    // complete quest objective
    if (m_TowerState == EP_TS_A || m_TowerState == EP_TS_H)
        SendObjectiveComplete(EP_PWT_CM);
}

void OPvPCapturePointEP_PWT::SendChangePhase()
{
    // send this too, sometimes the slider disappears, dunno why :(
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 1);
    // send these updates to only the ones in this objective
    uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_POS, phase);
    // send this too, sometimes it resets :S
    SendUpdateWorldState(EP_UI_TOWER_SLIDER_N, _neutralValuePct);
}

void OPvPCapturePointEP_PWT::FillInitialWorldStates(WorldPacket& data)
{
    data << EP_PWT_A << uint32(bool(m_TowerState & EP_TS_A));
    data << EP_PWT_H << uint32(bool(m_TowerState & EP_TS_H));
    data << EP_PWT_N_A << uint32(bool(m_TowerState & EP_TS_N_A));
    data << EP_PWT_N_H << uint32(bool(m_TowerState & EP_TS_N_H));
    data << EP_PWT_N << uint32(bool(m_TowerState & EP_TS_N));
}

void OPvPCapturePointEP_PWT::UpdateTowerState()
{
    _pvp->SendUpdateWorldState(EP_PWT_A, bool(m_TowerState & EP_TS_A));
    _pvp->SendUpdateWorldState(EP_PWT_H, bool(m_TowerState & EP_TS_H));
    _pvp->SendUpdateWorldState(EP_PWT_N_A, bool(m_TowerState & EP_TS_N_A));
    _pvp->SendUpdateWorldState(EP_PWT_N_H, bool(m_TowerState & EP_TS_N_H));
    _pvp->SendUpdateWorldState(EP_PWT_N, bool(m_TowerState & EP_TS_N));
}

bool OPvPCapturePointEP_PWT::HandlePlayerEnter(Player* player)
{
    if (OPvPCapturePoint::HandlePlayerEnter(player))
    {
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 1);
        uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_POS, phase);
        player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_N, _neutralValuePct);
        return true;
    }
    return false;
}

void OPvPCapturePointEP_PWT::HandlePlayerLeave(Player* player)
{
    player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 0);
    OPvPCapturePoint::HandlePlayerLeave(player);
}

void OPvPCapturePointEP_PWT::SummonFlightMaster(TeamId teamId)
{
    if (m_FlightMasterSpawnedId != teamId)
    {
        m_FlightMasterSpawnedId = teamId;
        DelCreature(EP_PWT_FLIGHTMASTER);
        AddCreature(EP_PWT_FLIGHTMASTER, EP_PWT_FlightMaster.entry, EP_PWT_FlightMaster.map, EP_PWT_FlightMaster.x, EP_PWT_FlightMaster.y, EP_PWT_FlightMaster.z, EP_PWT_FlightMaster.o);
        /*
        // sky - we need update gso code

        Creature* c = HashMapHolder<Creature>::Find(_creatures[EP_PWT_FLIGHTMASTER]);
        //Spawn flight master as friendly to capturing team
        c->SetUInt32Value(GAMEOBJECT_FACTION, (teamId == TEAM_ALLIANCE ? 55 : 68));
        if (c)
        {
            GossipOption gso;
            gso.Action = GOSSIP_OPTION_OUTDOORPVP;
            gso.GossipId = 0;
            gso.OptionText.assign(sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_FLIGHT_NPT));
            gso.Id = 50;
            gso.Icon = 0;
            gso.NpcFlag = 0;
            gso.BoxMoney = 0;
            gso.Coded = false;
            c->addGossipOption(gso);

            gso.Action = GOSSIP_OPTION_OUTDOORPVP;
            gso.GossipId = 0;
            gso.OptionText.assign(sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_FLIGHT_EWT));
            gso.Id = 50;
            gso.Icon = 0;
            gso.NpcFlag = 0;
            gso.BoxMoney = 0;
            gso.Coded = false;
            c->addGossipOption(gso);

            gso.Action = GOSSIP_OPTION_OUTDOORPVP;
            gso.GossipId = 0;
            gso.OptionText.assign(sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_EP_FLIGHT_CGT));
            gso.Id = 50;
            gso.Icon = 0;
            gso.NpcFlag = 0;
            gso.BoxMoney = 0;
            gso.Coded = false;
            c->addGossipOption(gso);
        }
        */
    }
}

// ep
OutdoorPvPEP::OutdoorPvPEP()
{
    _typeId = OUTDOOR_PVP_EP;
    memset(EP_ControlsId, TEAM_NEUTRAL, sizeof(EP_ControlsId));
    m_AllianceTowersControlled = 0;
    m_HordeTowersControlled = 0;
}

bool OutdoorPvPEP::SetupOutdoorPvP()
{
    for (uint8 i = 0; i < EPBuffZonesNum; ++i)
        RegisterZone(EPBuffZones[i]);

    SetMapFromZone(EPBuffZones[0]);

    AddCapturePoint(new OPvPCapturePointEP_EWT(this));
    AddCapturePoint(new OPvPCapturePointEP_PWT(this));
    AddCapturePoint(new OPvPCapturePointEP_CGT(this));
    AddCapturePoint(new OPvPCapturePointEP_NPT(this));

    return true;
}

bool OutdoorPvPEP::Update(uint32 diff)
{
    if (OutdoorPvP::Update(diff))
    {
        m_AllianceTowersControlled = 0;
        m_HordeTowersControlled = 0;
        for (int i = 0; i < EP_TOWER_NUM; ++i)
        {
            if (EP_ControlsId[i] == TEAM_ALLIANCE)
                ++m_AllianceTowersControlled;
            else if (EP_ControlsId[i] == TEAM_HORDE)
                ++m_HordeTowersControlled;
            SendUpdateWorldState(EP_UI_TOWER_COUNT_A, m_AllianceTowersControlled);
            SendUpdateWorldState(EP_UI_TOWER_COUNT_H, m_HordeTowersControlled);
            BuffTeams();
        }
        return true;
    }
    return false;
}

void OutdoorPvPEP::HandlePlayerEnterZone(Player* player, uint32 zone)
{
    // add buffs
    if (player->GetTeamId() == TEAM_ALLIANCE)
    {
        if (m_AllianceTowersControlled && m_AllianceTowersControlled < 5)
            player->CastSpell(player, EP_AllianceBuffs[m_AllianceTowersControlled - 1], true);
    }
    else
    {
        if (m_HordeTowersControlled && m_HordeTowersControlled < 5)
            player->CastSpell(player, EP_HordeBuffs[m_HordeTowersControlled - 1], true);
    }
    OutdoorPvP::HandlePlayerEnterZone(player, zone);
}

void OutdoorPvPEP::HandlePlayerLeaveZone(Player* player, uint32 zone)
{
    // remove buffs
    if (player->GetTeamId() == TEAM_ALLIANCE)
    {
        for (int i = 0; i < 4; ++i)
            player->RemoveAurasDueToSpell(EP_AllianceBuffs[i]);
    }
    else
    {
        for (int i = 0; i < 4; ++i)
            player->RemoveAurasDueToSpell(EP_HordeBuffs[i]);
    }
    OutdoorPvP::HandlePlayerLeaveZone(player, zone);
}

void OutdoorPvPEP::BuffTeams()
{
    for (PlayerSet::iterator itr = _players[0].begin(); itr != _players[0].end(); ++itr)
    {
        if (Player* player = ObjectAccessor::FindPlayer(*itr))
        {
            for (int i = 0; i < 4; ++i)
                player->RemoveAurasDueToSpell(EP_AllianceBuffs[i]);
            if (m_AllianceTowersControlled && m_AllianceTowersControlled < 5)
                player->CastSpell(player, EP_AllianceBuffs[m_AllianceTowersControlled - 1], true);
        }
    }
    for (PlayerSet::iterator itr = _players[1].begin(); itr != _players[1].end(); ++itr)
    {
        if (Player* player = ObjectAccessor::FindPlayer(*itr))
        {
            for (int i = 0; i < 4; ++i)
                player->RemoveAurasDueToSpell(EP_HordeBuffs[i]);
            if (m_HordeTowersControlled && m_HordeTowersControlled < 5)
                player->CastSpell(player, EP_HordeBuffs[m_HordeTowersControlled - 1], true);
        }
    }
}

void OutdoorPvPEP::SetControlledState(uint32 index, TeamId teamId)
{
    EP_ControlsId[index] = teamId;
}

void OutdoorPvPEP::FillInitialWorldStates(WorldPacket& data)
{
    data << EP_UI_TOWER_COUNT_A << m_AllianceTowersControlled;
    data << EP_UI_TOWER_COUNT_H << m_HordeTowersControlled;
    data << EP_UI_TOWER_SLIDER_DISPLAY << uint32(0);
    data << EP_UI_TOWER_SLIDER_POS << uint32(50);
    data << EP_UI_TOWER_SLIDER_N << uint32(100);
    for (OPvPCapturePointMap::iterator itr = _capturePoints.begin(); itr != _capturePoints.end(); ++itr)
    {
        itr->second->FillInitialWorldStates(data);
    }
}

void OutdoorPvPEP::SendRemoveWorldStates(Player* player)
{
    player->SendUpdateWorldState(EP_UI_TOWER_COUNT_A, 0);
    player->SendUpdateWorldState(EP_UI_TOWER_COUNT_H, 0);
    player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_DISPLAY, 0);
    player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_POS, 0);
    player->SendUpdateWorldState(EP_UI_TOWER_SLIDER_N, 0);

    player->SendUpdateWorldState(EP_EWT_A, 0);
    player->SendUpdateWorldState(EP_EWT_H, 0);
    player->SendUpdateWorldState(EP_EWT_N, 0);
    player->SendUpdateWorldState(EP_EWT_N_A, 0);
    player->SendUpdateWorldState(EP_EWT_N_H, 0);

    player->SendUpdateWorldState(EP_PWT_A, 0);
    player->SendUpdateWorldState(EP_PWT_H, 0);
    player->SendUpdateWorldState(EP_PWT_N, 0);
    player->SendUpdateWorldState(EP_PWT_N_A, 0);
    player->SendUpdateWorldState(EP_PWT_N_H, 0);

    player->SendUpdateWorldState(EP_NPT_A, 0);
    player->SendUpdateWorldState(EP_NPT_H, 0);
    player->SendUpdateWorldState(EP_NPT_N, 0);
    player->SendUpdateWorldState(EP_NPT_N_A, 0);
    player->SendUpdateWorldState(EP_NPT_N_H, 0);

    player->SendUpdateWorldState(EP_CGT_A, 0);
    player->SendUpdateWorldState(EP_CGT_H, 0);
    player->SendUpdateWorldState(EP_CGT_N, 0);
    player->SendUpdateWorldState(EP_CGT_N_A, 0);
    player->SendUpdateWorldState(EP_CGT_N_H, 0);
}

class OutdoorPvP_eastern_plaguelands : public OutdoorPvPScript
{
public:
    OutdoorPvP_eastern_plaguelands()
        : OutdoorPvPScript("outdoorpvp_ep")
    {
    }

    OutdoorPvP* GetOutdoorPvP() const override
    {
        return new OutdoorPvPEP();
    }
};

void AddSC_outdoorpvp_ep()
{
    new OutdoorPvP_eastern_plaguelands();
}
