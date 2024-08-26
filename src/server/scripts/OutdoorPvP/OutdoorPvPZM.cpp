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

#include "OutdoorPvPZM.h"
#include "Creature.h"
#include "GameGraveyard.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "OutdoorPvPScript.h"
#include "Player.h"
#include "World.h"
#include "WorldPacket.h"

OPvPCapturePointZM_Beacon::OPvPCapturePointZM_Beacon(OutdoorPvP* pvp, ZM_BeaconType type)
    : OPvPCapturePoint(pvp), m_TowerType(type), m_TowerState(ZM_TOWERSTATE_N)
{
    SetCapturePointData(ZMCapturePoints[type].entry, ZMCapturePoints[type].map, ZMCapturePoints[type].x, ZMCapturePoints[type].y, ZMCapturePoints[type].z, ZMCapturePoints[type].o, ZMCapturePoints[type].rot0, ZMCapturePoints[type].rot1, ZMCapturePoints[type].rot2, ZMCapturePoints[type].rot3);
}

void OPvPCapturePointZM_Beacon::FillInitialWorldStates(WorldPacket& data)
{
    data << uint32(ZMBeaconInfo[m_TowerType].ui_tower_n) << uint32(bool(m_TowerState & ZM_TOWERSTATE_N));
    data << uint32(ZMBeaconInfo[m_TowerType].map_tower_n) << uint32(bool(m_TowerState & ZM_TOWERSTATE_N));
    data << uint32(ZMBeaconInfo[m_TowerType].ui_tower_a) << uint32(bool(m_TowerState & ZM_TOWERSTATE_A));
    data << uint32(ZMBeaconInfo[m_TowerType].map_tower_a) << uint32(bool(m_TowerState & ZM_TOWERSTATE_A));
    data << uint32(ZMBeaconInfo[m_TowerType].ui_tower_h) << uint32(bool(m_TowerState & ZM_TOWERSTATE_H));
    data << uint32(ZMBeaconInfo[m_TowerType].map_tower_h) << uint32(bool(m_TowerState & ZM_TOWERSTATE_H));
}

void OPvPCapturePointZM_Beacon::UpdateTowerState()
{
    _pvp->SendUpdateWorldState(uint32(ZMBeaconInfo[m_TowerType].ui_tower_n), uint32(bool(m_TowerState & ZM_TOWERSTATE_N)));
    _pvp->SendUpdateWorldState(uint32(ZMBeaconInfo[m_TowerType].map_tower_n), uint32(bool(m_TowerState & ZM_TOWERSTATE_N)));
    _pvp->SendUpdateWorldState(uint32(ZMBeaconInfo[m_TowerType].ui_tower_a), uint32(bool(m_TowerState & ZM_TOWERSTATE_A)));
    _pvp->SendUpdateWorldState(uint32(ZMBeaconInfo[m_TowerType].map_tower_a), uint32(bool(m_TowerState & ZM_TOWERSTATE_A)));
    _pvp->SendUpdateWorldState(uint32(ZMBeaconInfo[m_TowerType].ui_tower_h), uint32(bool(m_TowerState & ZM_TOWERSTATE_H)));
    _pvp->SendUpdateWorldState(uint32(ZMBeaconInfo[m_TowerType].map_tower_h), uint32(bool(m_TowerState & ZM_TOWERSTATE_H)));
}

bool OPvPCapturePointZM_Beacon::HandlePlayerEnter(Player* player)
{
    if (OPvPCapturePoint::HandlePlayerEnter(player))
    {
        player->SendUpdateWorldState(ZMBeaconInfo[m_TowerType].slider_disp, 1);
        uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
        player->SendUpdateWorldState(ZMBeaconInfo[m_TowerType].slider_pos, phase);
        player->SendUpdateWorldState(ZMBeaconInfo[m_TowerType].slider_n, _neutralValuePct);
        return true;
    }
    return false;
}

void OPvPCapturePointZM_Beacon::HandlePlayerLeave(Player* player)
{
    player->SendUpdateWorldState(ZMBeaconInfo[m_TowerType].slider_disp, 0);
    OPvPCapturePoint::HandlePlayerLeave(player);
}

void OPvPCapturePointZM_Beacon::ChangeState()
{
    // if changing from controlling alliance to horde
    if (_oldState == OBJECTIVESTATE_ALLIANCE)
    {
        if (uint32 alliance_towers = ((OutdoorPvPZM*)_pvp)->GetAllianceTowersControlled())
            ((OutdoorPvPZM*)_pvp)->SetAllianceTowersControlled(--alliance_towers);
        sWorld->SendZoneText(ZM_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(ZMBeaconLoseA[m_TowerType]));
    }
    // if changing from controlling horde to alliance
    else if (_oldState == OBJECTIVESTATE_HORDE)
    {
        if (uint32 horde_towers = ((OutdoorPvPZM*)_pvp)->GetHordeTowersControlled())
            ((OutdoorPvPZM*)_pvp)->SetHordeTowersControlled(--horde_towers);
        sWorld->SendZoneText(ZM_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(ZMBeaconLoseH[m_TowerType]));
    }

    switch (_state)
    {
        case OBJECTIVESTATE_ALLIANCE:
            {
                m_TowerState = ZM_TOWERSTATE_A;
                uint32 alliance_towers = ((OutdoorPvPZM*)_pvp)->GetAllianceTowersControlled();
                if (alliance_towers < ZM_NUM_BEACONS)
                    ((OutdoorPvPZM*)_pvp)->SetAllianceTowersControlled(++alliance_towers);
                sWorld->SendZoneText(ZM_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(ZMBeaconCaptureA[m_TowerType]));
                break;
            }
        case OBJECTIVESTATE_HORDE:
            {
                m_TowerState = ZM_TOWERSTATE_H;
                uint32 horde_towers = ((OutdoorPvPZM*)_pvp)->GetHordeTowersControlled();
                if (horde_towers < ZM_NUM_BEACONS)
                    ((OutdoorPvPZM*)_pvp)->SetHordeTowersControlled(++horde_towers);
                sWorld->SendZoneText(ZM_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(ZMBeaconCaptureH[m_TowerType]));
                break;
            }
        case OBJECTIVESTATE_NEUTRAL:
        case OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE:
        case OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE:
        case OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE:
        case OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE:
            m_TowerState = ZM_TOWERSTATE_N;
            break;
    }

    UpdateTowerState();
}

void OPvPCapturePointZM_Beacon::SendChangePhase()
{
    // send this too, sometimes the slider disappears, dunno why :(
    SendUpdateWorldState(ZMBeaconInfo[m_TowerType].slider_disp, 1);
    // send these updates to only the ones in this objective
    uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
    SendUpdateWorldState(ZMBeaconInfo[m_TowerType].slider_pos, phase);
    SendUpdateWorldState(ZMBeaconInfo[m_TowerType].slider_n, _neutralValuePct);
}

bool OutdoorPvPZM::Update(uint32 diff)
{
    bool changed = OutdoorPvP::Update(diff);
    if (changed)
    {
        if (m_AllianceTowersControlled == ZM_NUM_BEACONS)
            m_GraveYard->SetBeaconState(TEAM_ALLIANCE);
        else if (m_HordeTowersControlled == ZM_NUM_BEACONS)
            m_GraveYard->SetBeaconState(TEAM_HORDE);
        else
            m_GraveYard->SetBeaconState(TEAM_NEUTRAL);
    }
    return changed;
}

void OutdoorPvPZM::HandlePlayerEnterZone(Player* player, uint32 zone)
{
    if (player->GetTeamId() == TEAM_ALLIANCE)
    {
        if (m_GraveYard->GetGraveYardState() & ZM_GRAVEYARD_A)
            player->CastSpell(player, ZM_CAPTURE_BUFF, true);
    }
    else
    {
        if (m_GraveYard->GetGraveYardState() & ZM_GRAVEYARD_H)
            player->CastSpell(player, ZM_CAPTURE_BUFF, true);
    }
    OutdoorPvP::HandlePlayerEnterZone(player, zone);
}

void OutdoorPvPZM::HandlePlayerLeaveZone(Player* player, uint32 zone)
{
    // remove buffs
    player->RemoveAurasDueToSpell(ZM_CAPTURE_BUFF);
    // remove flag
    player->RemoveAurasDueToSpell(ZM_BATTLE_STANDARD_A);
    player->RemoveAurasDueToSpell(ZM_BATTLE_STANDARD_H);
    OutdoorPvP::HandlePlayerLeaveZone(player, zone);
}

OutdoorPvPZM::OutdoorPvPZM()
{
    _typeId = OUTDOOR_PVP_ZM;
    m_GraveYard = nullptr;
    m_AllianceTowersControlled = 0;
    m_HordeTowersControlled = 0;
}

bool OutdoorPvPZM::SetupOutdoorPvP()
{
    m_AllianceTowersControlled = 0;
    m_HordeTowersControlled = 0;

    // add the zones affected by the pvp buff
    for (uint8 i = 0; i < OutdoorPvPZMBuffZonesNum; ++i)
        RegisterZone(OutdoorPvPZMBuffZones[i]);

    SetMapFromZone(OutdoorPvPZMBuffZones[0]);

    AddCapturePoint(new OPvPCapturePointZM_Beacon(this, ZM_BEACON_WEST));
    AddCapturePoint(new OPvPCapturePointZM_Beacon(this, ZM_BEACON_EAST));
    m_GraveYard = new OPvPCapturePointZM_GraveYard(this);
    AddCapturePoint(m_GraveYard); // though the update function isn't used, the handleusego is!

    return true;
}

void OutdoorPvPZM::HandleKillImpl(Player* player, Unit* killed)
{
    if (killed->GetTypeId() != TYPEID_PLAYER)
        return;

    if (player->GetTeamId() == TEAM_ALLIANCE && killed->ToPlayer()->GetTeamId() != TEAM_ALLIANCE)
        player->CastSpell(player, ZM_AlliancePlayerKillReward, true);
    else if (player->GetTeamId() == TEAM_HORDE && killed->ToPlayer()->GetTeamId() != TEAM_HORDE)
        player->CastSpell(player, ZM_HordePlayerKillReward, true);
}

bool OPvPCapturePointZM_GraveYard::Update(uint32 /*diff*/)
{
    bool retval = _state != _oldState;
    _state = _oldState;
    return retval;
}

int32 OPvPCapturePointZM_GraveYard::HandleOpenGo(Player* player, GameObject* go)
{
    int32 retval = OPvPCapturePoint::HandleOpenGo(player, go);
    if (retval >= 0)
    {
        if (player->HasAura(ZM_BATTLE_STANDARD_A) && m_GraveYardState != ZM_GRAVEYARD_A)
        {
            if (m_GraveYardState == ZM_GRAVEYARD_H)
                sWorld->SendZoneText(ZM_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_ZM_LOSE_GY_H));
            m_GraveYardState = ZM_GRAVEYARD_A;
            DelObject(0);   // only one gotype is used in the whole outdoor pvp, no need to call it a constant
            AddObject(0, ZM_Banner_A.entry, ZM_Banner_A.map, ZM_Banner_A.x, ZM_Banner_A.y, ZM_Banner_A.z, ZM_Banner_A.o, ZM_Banner_A.rot0, ZM_Banner_A.rot1, ZM_Banner_A.rot2, ZM_Banner_A.rot3);
            sGraveyard->RemoveGraveyardLink(ZM_GRAVEYARD_ID, ZM_GRAVEYARD_ZONE, TEAM_HORDE);          // rem gy
            sGraveyard->AddGraveyardLink(ZM_GRAVEYARD_ID, ZM_GRAVEYARD_ZONE, TEAM_ALLIANCE, false);   // add gy
            _pvp->TeamApplyBuff(TEAM_ALLIANCE, ZM_CAPTURE_BUFF, 0, player);
            player->RemoveAurasDueToSpell(ZM_BATTLE_STANDARD_A);
            sWorld->SendZoneText(ZM_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_ZM_CAPTURE_GY_A));
        }
        else if (player->HasAura(ZM_BATTLE_STANDARD_H) && m_GraveYardState != ZM_GRAVEYARD_H)
        {
            if (m_GraveYardState == ZM_GRAVEYARD_A)
                sWorld->SendZoneText(ZM_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_ZM_LOSE_GY_A));
            m_GraveYardState = ZM_GRAVEYARD_H;
            DelObject(0);   // only one gotype is used in the whole outdoor pvp, no need to call it a constant
            AddObject(0, ZM_Banner_H.entry, ZM_Banner_H.map, ZM_Banner_H.x, ZM_Banner_H.y, ZM_Banner_H.z, ZM_Banner_H.o, ZM_Banner_H.rot0, ZM_Banner_H.rot1, ZM_Banner_H.rot2, ZM_Banner_H.rot3);
            sGraveyard->RemoveGraveyardLink(ZM_GRAVEYARD_ID, ZM_GRAVEYARD_ZONE, TEAM_ALLIANCE);          // rem gy
            sGraveyard->AddGraveyardLink(ZM_GRAVEYARD_ID, ZM_GRAVEYARD_ZONE, TEAM_HORDE, false);   // add gy
            _pvp->TeamApplyBuff(TEAM_HORDE, ZM_CAPTURE_BUFF, 0, player);
            player->RemoveAurasDueToSpell(ZM_BATTLE_STANDARD_H);
            sWorld->SendZoneText(ZM_GRAVEYARD_ZONE, sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_ZM_CAPTURE_GY_H));
        }
        UpdateTowerState();
    }
    return retval;
}

OPvPCapturePointZM_GraveYard::OPvPCapturePointZM_GraveYard(OutdoorPvP* pvp)
    : OPvPCapturePoint(pvp)
{
    m_BothControllingFactionId = TEAM_NEUTRAL;
    m_GraveYardState = ZM_GRAVEYARD_N;
    m_FlagCarrierGUID.Clear();
    // add field scouts here
    AddCreature(ZM_ALLIANCE_FIELD_SCOUT, ZM_AllianceFieldScout.entry, ZM_AllianceFieldScout.map, ZM_AllianceFieldScout.x, ZM_AllianceFieldScout.y, ZM_AllianceFieldScout.z, ZM_AllianceFieldScout.o);
    AddCreature(ZM_HORDE_FIELD_SCOUT, ZM_HordeFieldScout.entry, ZM_HordeFieldScout.map, ZM_HordeFieldScout.x, ZM_HordeFieldScout.y, ZM_HordeFieldScout.z, ZM_HordeFieldScout.o);
    // add neutral banner
    AddObject(0, ZM_Banner_N.entry, ZM_Banner_N.map, ZM_Banner_N.x, ZM_Banner_N.y, ZM_Banner_N.z, ZM_Banner_N.o, ZM_Banner_N.rot0, ZM_Banner_N.rot1, ZM_Banner_N.rot2, ZM_Banner_N.rot3);
}

void OPvPCapturePointZM_GraveYard::UpdateTowerState()
{
    _pvp->SendUpdateWorldState(ZM_MAP_GRAVEYARD_N, uint32(bool(m_GraveYardState & ZM_GRAVEYARD_N)));
    _pvp->SendUpdateWorldState(ZM_MAP_GRAVEYARD_H, uint32(bool(m_GraveYardState & ZM_GRAVEYARD_H)));
    _pvp->SendUpdateWorldState(ZM_MAP_GRAVEYARD_A, uint32(bool(m_GraveYardState & ZM_GRAVEYARD_A)));

    _pvp->SendUpdateWorldState(ZM_MAP_ALLIANCE_FLAG_READY, uint32(m_BothControllingFactionId == TEAM_ALLIANCE));
    _pvp->SendUpdateWorldState(ZM_MAP_ALLIANCE_FLAG_NOT_READY, uint32(m_BothControllingFactionId != TEAM_ALLIANCE));
    _pvp->SendUpdateWorldState(ZM_MAP_HORDE_FLAG_READY, uint32(m_BothControllingFactionId == TEAM_HORDE));
    _pvp->SendUpdateWorldState(ZM_MAP_HORDE_FLAG_NOT_READY, uint32(m_BothControllingFactionId != TEAM_HORDE));
}

void OPvPCapturePointZM_GraveYard::FillInitialWorldStates(WorldPacket& data)
{
    data << ZM_MAP_GRAVEYARD_N  << uint32(bool(m_GraveYardState & ZM_GRAVEYARD_N));
    data << ZM_MAP_GRAVEYARD_H  << uint32(bool(m_GraveYardState & ZM_GRAVEYARD_H));
    data << ZM_MAP_GRAVEYARD_A  << uint32(bool(m_GraveYardState & ZM_GRAVEYARD_A));

    data << ZM_MAP_ALLIANCE_FLAG_READY  << uint32(m_BothControllingFactionId == TEAM_ALLIANCE);
    data << ZM_MAP_ALLIANCE_FLAG_NOT_READY  << uint32(m_BothControllingFactionId != TEAM_ALLIANCE);
    data << ZM_MAP_HORDE_FLAG_READY  << uint32(m_BothControllingFactionId == TEAM_HORDE);
    data << ZM_MAP_HORDE_FLAG_NOT_READY  << uint32(m_BothControllingFactionId != TEAM_HORDE);
}

void OPvPCapturePointZM_GraveYard::SetBeaconState(TeamId controlling_factionId)
{
    // nothing to do here
    if (m_BothControllingFactionId == controlling_factionId)
        return;
    m_BothControllingFactionId = controlling_factionId;

    switch (controlling_factionId)
    {
        case TEAM_ALLIANCE:
            // if ally already controls the gy and taken back both beacons, return, nothing to do for us
            if (m_GraveYardState & ZM_GRAVEYARD_A)
                return;
            // ally doesn't control the gy, but controls the side beacons -> add gossip option, add neutral banner
            break;
        case TEAM_HORDE:
            // if horde already controls the gy and taken back both beacons, return, nothing to do for us
            if (m_GraveYardState & ZM_GRAVEYARD_H)
                return;
            // horde doesn't control the gy, but controls the side beacons -> add gossip option, add neutral banner
            break;
        default:
            // if the graveyard is not neutral, then leave it that way
            // if the graveyard is neutral, then we have to dispel the buff from the flag carrier
            if (m_GraveYardState & ZM_GRAVEYARD_N)
            {
                // gy was neutral, thus neutral banner was spawned, it is possible that someone was taking the flag to the gy
                if (m_FlagCarrierGUID)
                {
                    // remove flag from carrier, reset flag carrier guid
                    Player* p = ObjectAccessor::FindPlayer(m_FlagCarrierGUID);
                    if (p)
                    {
                        p->RemoveAurasDueToSpell(ZM_BATTLE_STANDARD_A);
                        p->RemoveAurasDueToSpell(ZM_BATTLE_STANDARD_H);
                    }
                    m_FlagCarrierGUID.Clear();
                }
            }
            break;
    }
    // send worldstateupdate
    UpdateTowerState();
}

bool OPvPCapturePointZM_GraveYard::CanTalkTo(Player* player, Creature* c, GossipMenuItems const& /*gso*/)
{
    ObjectGuid guid = c->GetGUID();
    auto itr = _creatureTypes.find(guid.GetCounter());
    if (itr != _creatureTypes.end())
    {
        if (itr->second == ZM_ALLIANCE_FIELD_SCOUT && player->GetTeamId() == TEAM_ALLIANCE && m_BothControllingFactionId == TEAM_ALLIANCE && !m_FlagCarrierGUID && m_GraveYardState != ZM_GRAVEYARD_A)
            return true;
        else if (itr->second == ZM_HORDE_FIELD_SCOUT && player->GetTeamId() == TEAM_HORDE && m_BothControllingFactionId == TEAM_HORDE && !m_FlagCarrierGUID && m_GraveYardState != ZM_GRAVEYARD_H)
            return true;
    }
    return false;
}

bool OPvPCapturePointZM_GraveYard::HandleGossipOption(Player* player, Creature* creature, uint32 /*gossipid*/)
{
    auto itr = _creatureTypes.find(creature->GetSpawnId());
    if (itr != _creatureTypes.end())
    {
        // if the flag is already taken, then return
        if (m_FlagCarrierGUID)
            return true;

        if (itr->second == ZM_ALLIANCE_FIELD_SCOUT)
        {
            creature->CastSpell(player, ZM_BATTLE_STANDARD_A, true);
            m_FlagCarrierGUID = player->GetGUID();
        }
        else if (itr->second == ZM_HORDE_FIELD_SCOUT)
        {
            creature->CastSpell(player, ZM_BATTLE_STANDARD_H, true);
            m_FlagCarrierGUID = player->GetGUID();
        }

        UpdateTowerState();
        player->PlayerTalkClass->SendCloseGossip();
        return true;
    }
    return false;
}

bool OPvPCapturePointZM_GraveYard::HandleDropFlag(Player* /*player*/, uint32 spellId)
{
    switch (spellId)
    {
        case ZM_BATTLE_STANDARD_A:
            m_FlagCarrierGUID.Clear();
            return true;
        case ZM_BATTLE_STANDARD_H:
            m_FlagCarrierGUID.Clear();
            return true;
    }
    return false;
}

uint32 OPvPCapturePointZM_GraveYard::GetGraveYardState() const
{
    return m_GraveYardState;
}

uint32 OutdoorPvPZM::GetAllianceTowersControlled() const
{
    return m_AllianceTowersControlled;
}

void OutdoorPvPZM::SetAllianceTowersControlled(uint32 count)
{
    m_AllianceTowersControlled = count;
}

uint32 OutdoorPvPZM::GetHordeTowersControlled() const
{
    return m_HordeTowersControlled;
}

void OutdoorPvPZM::SetHordeTowersControlled(uint32 count)
{
    m_HordeTowersControlled = count;
}

void OutdoorPvPZM::FillInitialWorldStates(WorldPacket& data)
{
    data << ZM_WORLDSTATE_UNK_1 << uint32(1);
    for (OPvPCapturePointMap::iterator itr = _capturePoints.begin(); itr != _capturePoints.end(); ++itr)
    {
        itr->second->FillInitialWorldStates(data);
    }
}

void OutdoorPvPZM::SendRemoveWorldStates(Player* player)
{
    player->SendUpdateWorldState(ZM_UI_TOWER_SLIDER_N_W, 0);
    player->SendUpdateWorldState(ZM_UI_TOWER_SLIDER_POS_W, 0);
    player->SendUpdateWorldState(ZM_UI_TOWER_SLIDER_DISPLAY_W, 0);
    player->SendUpdateWorldState(ZM_UI_TOWER_SLIDER_N_E, 0);
    player->SendUpdateWorldState(ZM_UI_TOWER_SLIDER_POS_E, 0);
    player->SendUpdateWorldState(ZM_UI_TOWER_SLIDER_DISPLAY_E, 0);
    player->SendUpdateWorldState(ZM_WORLDSTATE_UNK_1, 1);
    player->SendUpdateWorldState(ZM_UI_TOWER_EAST_N, 0);
    player->SendUpdateWorldState(ZM_UI_TOWER_EAST_H, 0);
    player->SendUpdateWorldState(ZM_UI_TOWER_EAST_A, 0);
    player->SendUpdateWorldState(ZM_UI_TOWER_WEST_N, 0);
    player->SendUpdateWorldState(ZM_UI_TOWER_WEST_H, 0);
    player->SendUpdateWorldState(ZM_UI_TOWER_WEST_A, 0);
    player->SendUpdateWorldState(ZM_MAP_TOWER_EAST_N, 0);
    player->SendUpdateWorldState(ZM_MAP_TOWER_EAST_H, 0);
    player->SendUpdateWorldState(ZM_MAP_TOWER_EAST_A, 0);
    player->SendUpdateWorldState(ZM_MAP_GRAVEYARD_H, 0);
    player->SendUpdateWorldState(ZM_MAP_GRAVEYARD_A, 0);
    player->SendUpdateWorldState(ZM_MAP_GRAVEYARD_N, 0);
    player->SendUpdateWorldState(ZM_MAP_TOWER_WEST_N, 0);
    player->SendUpdateWorldState(ZM_MAP_TOWER_WEST_H, 0);
    player->SendUpdateWorldState(ZM_MAP_TOWER_WEST_A, 0);
    player->SendUpdateWorldState(ZM_MAP_HORDE_FLAG_READY, 0);
    player->SendUpdateWorldState(ZM_MAP_HORDE_FLAG_NOT_READY, 0);
    player->SendUpdateWorldState(ZM_MAP_ALLIANCE_FLAG_NOT_READY, 0);
    player->SendUpdateWorldState(ZM_MAP_ALLIANCE_FLAG_READY, 0);
}

class OutdoorPvP_zangarmarsh : public OutdoorPvPScript
{
public:
    OutdoorPvP_zangarmarsh()
        : OutdoorPvPScript("outdoorpvp_zm")
    {
    }

    OutdoorPvP* GetOutdoorPvP() const override
    {
        return new OutdoorPvPZM();
    }
};

void AddSC_outdoorpvp_zm()
{
    new OutdoorPvP_zangarmarsh();
}
