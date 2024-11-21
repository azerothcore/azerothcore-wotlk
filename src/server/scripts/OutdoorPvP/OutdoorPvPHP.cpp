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

#include "OutdoorPvPHP.h"
#include "CreatureScript.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "OutdoorPvP.h"
#include "OutdoorPvPScript.h"
#include "Player.h"
#include "World.h"
#include "WorldPacket.h"

const uint32 HP_LANG_LOSE_A[HP_TOWER_NUM] = {LANG_OPVP_HP_LOSE_BROKENHILL_A, LANG_OPVP_HP_LOSE_OVERLOOK_A, LANG_OPVP_HP_LOSE_STADIUM_A};

const uint32 HP_LANG_LOSE_H[HP_TOWER_NUM] = {LANG_OPVP_HP_LOSE_BROKENHILL_H, LANG_OPVP_HP_LOSE_OVERLOOK_H, LANG_OPVP_HP_LOSE_STADIUM_H};

const uint32 HP_LANG_CAPTURE_A[HP_TOWER_NUM] = {LANG_OPVP_HP_CAPTURE_BROKENHILL_A, LANG_OPVP_HP_CAPTURE_OVERLOOK_A, LANG_OPVP_HP_CAPTURE_STADIUM_A};

const uint32 HP_LANG_CAPTURE_H[HP_TOWER_NUM] = {LANG_OPVP_HP_CAPTURE_BROKENHILL_H, LANG_OPVP_HP_CAPTURE_OVERLOOK_H, LANG_OPVP_HP_CAPTURE_STADIUM_H};

OPvPCapturePointHP::OPvPCapturePointHP(OutdoorPvP* pvp, OutdoorPvPHPTowerType type)
    : OPvPCapturePoint(pvp), m_TowerType(type)
{
    SetCapturePointData(HPCapturePoints[type].entry,
                        HPCapturePoints[type].map,
                        HPCapturePoints[type].x,
                        HPCapturePoints[type].y,
                        HPCapturePoints[type].z,
                        HPCapturePoints[type].o,
                        HPCapturePoints[type].rot0,
                        HPCapturePoints[type].rot1,
                        HPCapturePoints[type].rot2,
                        HPCapturePoints[type].rot3);
    AddObject(type,
              HPTowerFlags[type].entry,
              HPTowerFlags[type].map,
              HPTowerFlags[type].x,
              HPTowerFlags[type].y,
              HPTowerFlags[type].z,
              HPTowerFlags[type].o,
              HPTowerFlags[type].rot0,
              HPTowerFlags[type].rot1,
              HPTowerFlags[type].rot2,
              HPTowerFlags[type].rot3);
}

OutdoorPvPHP::OutdoorPvPHP()
{
    _typeId = OUTDOOR_PVP_HP;
    m_AllianceTowersControlled = 0;
    m_HordeTowersControlled = 0;
}

bool OutdoorPvPHP::SetupOutdoorPvP()
{
    m_AllianceTowersControlled = 0;
    m_HordeTowersControlled = 0;
    // add the zones affected by the pvp buff
    for (int i = 0; i < OutdoorPvPHPBuffZonesNum; ++i)
        RegisterZone(OutdoorPvPHPBuffZones[i]);

    SetMapFromZone(OutdoorPvPHPBuffZones[0]);

    AddCapturePoint(new OPvPCapturePointHP(this, HP_TOWER_BROKEN_HILL));

    AddCapturePoint(new OPvPCapturePointHP(this, HP_TOWER_OVERLOOK));

    AddCapturePoint(new OPvPCapturePointHP(this, HP_TOWER_STADIUM));

    return true;
}

void OutdoorPvPHP::HandlePlayerEnterZone(Player* player, uint32 zone)
{
    // add buffs
    if (player->GetTeamId() == TEAM_ALLIANCE)
    {
        if (m_AllianceTowersControlled >= 3)
            player->CastSpell(player, AllianceBuff, true);
    }
    else
    {
        if (m_HordeTowersControlled >= 3)
            player->CastSpell(player, HordeBuff, true);
    }
    OutdoorPvP::HandlePlayerEnterZone(player, zone);
}

void OutdoorPvPHP::HandlePlayerLeaveZone(Player* player, uint32 zone)
{
    // remove buffs
    if (player->GetTeamId() == TEAM_ALLIANCE)
    {
        player->RemoveAurasDueToSpell(AllianceBuff);
    }
    else
    {
        player->RemoveAurasDueToSpell(HordeBuff);
    }
    OutdoorPvP::HandlePlayerLeaveZone(player, zone);
}

bool OutdoorPvPHP::Update(uint32 diff)
{
    bool changed = OutdoorPvP::Update(diff);
    if (changed)
    {
        if (m_AllianceTowersControlled == 3)
            TeamApplyBuff(TEAM_ALLIANCE, AllianceBuff, HordeBuff);
        else if (m_HordeTowersControlled == 3)
            TeamApplyBuff(TEAM_HORDE, HordeBuff, AllianceBuff);
        else
        {
            TeamCastSpell(TEAM_ALLIANCE, -AllianceBuff);
            TeamCastSpell(TEAM_HORDE, -HordeBuff);
        }
        SendUpdateWorldState(HP_UI_TOWER_COUNT_A, m_AllianceTowersControlled);
        SendUpdateWorldState(HP_UI_TOWER_COUNT_H, m_HordeTowersControlled);
    }
    return changed;
}

void OutdoorPvPHP::SendRemoveWorldStates(Player* player)
{
    player->SendUpdateWorldState(HP_UI_TOWER_DISPLAY_A, 0);
    player->SendUpdateWorldState(HP_UI_TOWER_DISPLAY_H, 0);
    player->SendUpdateWorldState(HP_UI_TOWER_COUNT_H, 0);
    player->SendUpdateWorldState(HP_UI_TOWER_COUNT_A, 0);
    player->SendUpdateWorldState(HP_UI_TOWER_SLIDER_N, 0);
    player->SendUpdateWorldState(HP_UI_TOWER_SLIDER_POS, 0);
    player->SendUpdateWorldState(HP_UI_TOWER_SLIDER_DISPLAY, 0);
    for (int i = 0; i < HP_TOWER_NUM; ++i)
    {
        player->SendUpdateWorldState(HP_MAP_N[i], 0);
        player->SendUpdateWorldState(HP_MAP_A[i], 0);
        player->SendUpdateWorldState(HP_MAP_H[i], 0);
    }
}

void OutdoorPvPHP::FillInitialWorldStates(WorldPacket& data)
{
    data << uint32(HP_UI_TOWER_DISPLAY_A) << uint32(1);
    data << uint32(HP_UI_TOWER_DISPLAY_H) << uint32(1);
    data << uint32(HP_UI_TOWER_COUNT_A) << uint32(m_AllianceTowersControlled);
    data << uint32(HP_UI_TOWER_COUNT_H) << uint32(m_HordeTowersControlled);
    data << uint32(HP_UI_TOWER_SLIDER_DISPLAY) << uint32(0);
    data << uint32(HP_UI_TOWER_SLIDER_POS) << uint32(50);
    data << uint32(HP_UI_TOWER_SLIDER_N) << uint32(100);
    for (OPvPCapturePointMap::iterator itr = _capturePoints.begin(); itr != _capturePoints.end(); ++itr)
    {
        itr->second->FillInitialWorldStates(data);
    }
}

void OPvPCapturePointHP::ChangeState()
{
    uint32 field = 0;
    switch (_oldState)
    {
        case OBJECTIVESTATE_NEUTRAL:
            field = HP_MAP_N[m_TowerType];
            break;
        case OBJECTIVESTATE_ALLIANCE:
            field = HP_MAP_A[m_TowerType];
            if (uint32 alliance_towers = ((OutdoorPvPHP*)_pvp)->GetAllianceTowersControlled())
                ((OutdoorPvPHP*)_pvp)->SetAllianceTowersControlled(--alliance_towers);
            sWorld->SendZoneText(OutdoorPvPHPBuffZones[0], sObjectMgr->GetAcoreStringForDBCLocale(HP_LANG_LOSE_A[m_TowerType]));
            break;
        case OBJECTIVESTATE_HORDE:
            field = HP_MAP_H[m_TowerType];
            if (uint32 horde_towers = ((OutdoorPvPHP*)_pvp)->GetHordeTowersControlled())
                ((OutdoorPvPHP*)_pvp)->SetHordeTowersControlled(--horde_towers);
            sWorld->SendZoneText(OutdoorPvPHPBuffZones[0], sObjectMgr->GetAcoreStringForDBCLocale(HP_LANG_LOSE_H[m_TowerType]));
            break;
        case OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE:
            field = HP_MAP_N[m_TowerType];
            break;
        case OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE:
            field = HP_MAP_N[m_TowerType];
            break;
        case OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE:
            field = HP_MAP_A[m_TowerType];
            break;
        case OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE:
            field = HP_MAP_H[m_TowerType];
            break;
    }

    // send world state update
    if (field)
    {
        _pvp->SendUpdateWorldState(field, 0);
        field = 0;
    }
    uint32 artkit = 21;
    uint32 artkit2 = HP_TowerArtKit_N[m_TowerType];
    switch (_state)
    {
        case OBJECTIVESTATE_NEUTRAL:
            field = HP_MAP_N[m_TowerType];
            break;
        case OBJECTIVESTATE_ALLIANCE:
            {
                field = HP_MAP_A[m_TowerType];
                artkit = 2;
                artkit2 = HP_TowerArtKit_A[m_TowerType];
                uint32 alliance_towers = ((OutdoorPvPHP*)_pvp)->GetAllianceTowersControlled();
                if (alliance_towers < 3)
                    ((OutdoorPvPHP*)_pvp)->SetAllianceTowersControlled(++alliance_towers);
                sWorld->SendZoneText(OutdoorPvPHPBuffZones[0], sObjectMgr->GetAcoreStringForDBCLocale(HP_LANG_CAPTURE_A[m_TowerType]));
                break;
            }
        case OBJECTIVESTATE_HORDE:
            {
                field = HP_MAP_H[m_TowerType];
                artkit = 1;
                artkit2 = HP_TowerArtKit_H[m_TowerType];
                uint32 horde_towers = ((OutdoorPvPHP*)_pvp)->GetHordeTowersControlled();
                if (horde_towers < 3)
                    ((OutdoorPvPHP*)_pvp)->SetHordeTowersControlled(++horde_towers);
                sWorld->SendZoneText(OutdoorPvPHPBuffZones[0], sObjectMgr->GetAcoreStringForDBCLocale(HP_LANG_CAPTURE_H[m_TowerType]));
                break;
            }
        case OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE:
        case OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE:
        case OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE:
        case OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE:
            field = HP_MAP_N[m_TowerType];
            break;
    }

    Map* map = sMapMgr->FindMap(530, 0);
    auto bounds = map->GetGameObjectBySpawnIdStore().equal_range(m_capturePointSpawnId);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);

    bounds = map->GetGameObjectBySpawnIdStore().equal_range(_objects[m_TowerType]);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit2);

    // send world state update
    if (field)
        _pvp->SendUpdateWorldState(field, 1);

    // complete quest objective
    if (_state == OBJECTIVESTATE_ALLIANCE || _state == OBJECTIVESTATE_HORDE)
        SendObjectiveComplete(HP_CREDITMARKER[m_TowerType]);
}

void OPvPCapturePointHP::SendChangePhase()
{
    SendUpdateWorldState(HP_UI_TOWER_SLIDER_N, _neutralValuePct);
    // send these updates to only the ones in this objective
    uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
    SendUpdateWorldState(HP_UI_TOWER_SLIDER_POS, phase);
    // send this too, sometimes the slider disappears, dunno why :(
    SendUpdateWorldState(HP_UI_TOWER_SLIDER_DISPLAY, 1);
}

void OPvPCapturePointHP::FillInitialWorldStates(WorldPacket& data)
{
    switch (_state)
    {
        case OBJECTIVESTATE_ALLIANCE:
        case OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE:
            data << uint32(HP_MAP_N[m_TowerType]) << uint32(0);
            data << uint32(HP_MAP_A[m_TowerType]) << uint32(1);
            data << uint32(HP_MAP_H[m_TowerType]) << uint32(0);
            break;
        case OBJECTIVESTATE_HORDE:
        case OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE:
            data << uint32(HP_MAP_N[m_TowerType]) << uint32(0);
            data << uint32(HP_MAP_A[m_TowerType]) << uint32(0);
            data << uint32(HP_MAP_H[m_TowerType]) << uint32(1);
            break;
        case OBJECTIVESTATE_NEUTRAL:
        case OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE:
        case OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE:
        default:
            data << uint32(HP_MAP_N[m_TowerType]) << uint32(1);
            data << uint32(HP_MAP_A[m_TowerType]) << uint32(0);
            data << uint32(HP_MAP_H[m_TowerType]) << uint32(0);
            break;
    }
}

bool OPvPCapturePointHP::HandlePlayerEnter(Player* player)
{
    if (OPvPCapturePoint::HandlePlayerEnter(player))
    {
        player->SendUpdateWorldState(HP_UI_TOWER_SLIDER_DISPLAY, 1);
        uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
        player->SendUpdateWorldState(HP_UI_TOWER_SLIDER_POS, phase);
        player->SendUpdateWorldState(HP_UI_TOWER_SLIDER_N, _neutralValuePct);
        return true;
    }
    return false;
}

void OPvPCapturePointHP::HandlePlayerLeave(Player* player)
{
    player->SendUpdateWorldState(HP_UI_TOWER_SLIDER_DISPLAY, 0);
    OPvPCapturePoint::HandlePlayerLeave(player);
}

void OutdoorPvPHP::HandleKillImpl(Player* player, Unit* killed)
{
    if (!killed->IsPlayer())
        return;

    if (player->GetTeamId() == TEAM_ALLIANCE && killed->ToPlayer()->GetTeamId() != TEAM_ALLIANCE)
        player->CastSpell(player, AlliancePlayerKillReward, true);
    else if (player->GetTeamId() == TEAM_HORDE && killed->ToPlayer()->GetTeamId() != TEAM_HORDE)
        player->CastSpell(player, HordePlayerKillReward, true);
}

uint32 OutdoorPvPHP::GetAllianceTowersControlled() const
{
    return m_AllianceTowersControlled;
}

void OutdoorPvPHP::SetAllianceTowersControlled(uint32 count)
{
    m_AllianceTowersControlled = count;
}

uint32 OutdoorPvPHP::GetHordeTowersControlled() const
{
    return m_HordeTowersControlled;
}

void OutdoorPvPHP::SetHordeTowersControlled(uint32 count)
{
    m_HordeTowersControlled = count;
}

class OutdoorPvP_hellfire_peninsula : public OutdoorPvPScript
{
public:
    OutdoorPvP_hellfire_peninsula()
        : OutdoorPvPScript("outdoorpvp_hp")
    {
    }

    OutdoorPvP* GetOutdoorPvP() const override
    {
        return new OutdoorPvPHP();
    }
};

void AddSC_outdoorpvp_hp()
{
    new OutdoorPvP_hellfire_peninsula();
}
