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

#include "OutdoorPvPTF.h"
#include "GameTime.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "OutdoorPvP.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldPacket.h"

OutdoorPvPTF::OutdoorPvPTF()
{
    m_TypeId = OUTDOOR_PVP_TF;

    m_IsLocked = false;
    m_JustLocked = false;
    m_LockTimer = TF_LOCK_TIME;
    m_LockTimerUpdate = 0;

    m_AllianceTowersControlled = 0;
    m_HordeTowersControlled = 0;

    hours_left = 6;
    second_digit = 0;
    first_digit = 0;
}

OPvPCapturePointTF::OPvPCapturePointTF(OutdoorPvP* pvp, OutdoorPvPTF_TowerType type)
    : OPvPCapturePoint(pvp), m_TowerType(type), m_TowerState(TF_TOWERSTATE_N)
{
    SetCapturePointData(TFCapturePoints[type].entry, TFCapturePoints[type].map, TFCapturePoints[type].x, TFCapturePoints[type].y, TFCapturePoints[type].z, TFCapturePoints[type].o, TFCapturePoints[type].rot0, TFCapturePoints[type].rot1, TFCapturePoints[type].rot2, TFCapturePoints[type].rot3);
}

void OPvPCapturePointTF::FillInitialWorldStates(WorldPacket& data)
{
    data << uint32(TFTowerWorldStates[m_TowerType].n) << uint32(bool(m_TowerState & TF_TOWERSTATE_N));
    data << uint32(TFTowerWorldStates[m_TowerType].h) << uint32(bool(m_TowerState & TF_TOWERSTATE_H));
    data << uint32(TFTowerWorldStates[m_TowerType].a) << uint32(bool(m_TowerState & TF_TOWERSTATE_A));
}

void OutdoorPvPTF::FillInitialWorldStates(WorldPacket& data)
{
    data << TF_UI_TOWER_SLIDER_POS << uint32(50);
    data << TF_UI_TOWER_SLIDER_N << uint32(100);
    data << TF_UI_TOWER_SLIDER_DISPLAY << uint32(0);

    data << TF_UI_TOWER_COUNT_H << m_HordeTowersControlled;
    data << TF_UI_TOWER_COUNT_A << m_AllianceTowersControlled;
    data << TF_UI_TOWERS_CONTROLLED_DISPLAY << uint32(!m_IsLocked);

    data << TF_UI_LOCKED_TIME_MINUTES_FIRST_DIGIT << first_digit;
    data << TF_UI_LOCKED_TIME_MINUTES_SECOND_DIGIT << second_digit;
    data << TF_UI_LOCKED_TIME_HOURS << hours_left;

    data << TF_UI_LOCKED_DISPLAY_NEUTRAL << uint32(m_IsLocked && !m_HordeTowersControlled && !m_AllianceTowersControlled);
    data << TF_UI_LOCKED_DISPLAY_HORDE << uint32(m_IsLocked && (m_HordeTowersControlled > m_AllianceTowersControlled));
    data << TF_UI_LOCKED_DISPLAY_ALLIANCE << uint32(m_IsLocked && (m_HordeTowersControlled < m_AllianceTowersControlled));

    for (OPvPCapturePointMap::iterator itr = m_capturePoints.begin(); itr != m_capturePoints.end(); ++itr)
    {
        itr->second->FillInitialWorldStates(data);
    }
}

void OutdoorPvPTF::SendRemoveWorldStates(Player* player)
{
    player->SendUpdateWorldState(TF_UI_TOWER_SLIDER_POS, uint32(0));
    player->SendUpdateWorldState(TF_UI_TOWER_SLIDER_N, uint32(0));
    player->SendUpdateWorldState(TF_UI_TOWER_SLIDER_DISPLAY, uint32(0));

    player->SendUpdateWorldState(TF_UI_TOWER_COUNT_H, uint32(0));
    player->SendUpdateWorldState(TF_UI_TOWER_COUNT_A, uint32(0));
    player->SendUpdateWorldState(TF_UI_TOWERS_CONTROLLED_DISPLAY, uint32(0));

    player->SendUpdateWorldState(TF_UI_LOCKED_TIME_MINUTES_FIRST_DIGIT, uint32(0));
    player->SendUpdateWorldState(TF_UI_LOCKED_TIME_MINUTES_SECOND_DIGIT, uint32(0));
    player->SendUpdateWorldState(TF_UI_LOCKED_TIME_HOURS, uint32(0));

    player->SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_NEUTRAL, uint32(0));
    player->SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_HORDE, uint32(0));
    player->SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_ALLIANCE, uint32(0));

    for (int i = 0; i < TF_TOWER_NUM; ++i)
    {
        player->SendUpdateWorldState(uint32(TFTowerWorldStates[i].n), uint32(0));
        player->SendUpdateWorldState(uint32(TFTowerWorldStates[i].h), uint32(0));
        player->SendUpdateWorldState(uint32(TFTowerWorldStates[i].a), uint32(0));
    }
}

void OutdoorPvPTF::SaveRequiredWorldStates() const
{
    sWorld->setWorldState(TF_UI_TOWER_COUNT_H, m_HordeTowersControlled);
    sWorld->setWorldState(TF_UI_TOWER_COUNT_A, m_AllianceTowersControlled);

    sWorld->setWorldState(TF_UI_TOWERS_CONTROLLED_DISPLAY, m_IsLocked);

    // Save expiry as unix
    uint32 const lockExpireTime = GameTime::GetGameTime().count() + (m_LockTimer / IN_MILLISECONDS);
    sWorld->setWorldState(TF_UI_LOCKED_TIME_HOURS, lockExpireTime);
}

void OutdoorPvPTF::ResetZoneToTeamControlled(TeamId team)
{
    switch (team)
    {
    case TEAM_HORDE:
        m_HordeTowersControlled = TF_TOWER_NUM;
        m_AllianceTowersControlled = 0;
        break;
    case TEAM_ALLIANCE:
        m_HordeTowersControlled = 0;
        m_AllianceTowersControlled = TF_TOWER_NUM;
        break;
    case TEAM_NEUTRAL:
        m_HordeTowersControlled = 0;
        m_AllianceTowersControlled = 0;
        break;
    }

    for (auto& [guid, tower] : m_capturePoints)
    {
        dynamic_cast<OPvPCapturePointTF*>(tower)->ResetToTeamControlled(team);
    }

    SendUpdateWorldState(TF_UI_TOWER_COUNT_H, m_HordeTowersControlled);
    SendUpdateWorldState(TF_UI_TOWER_COUNT_A, m_AllianceTowersControlled);
}

void OPvPCapturePointTF::ResetToTeamControlled(TeamId team)
{
    switch (team)
    {
    case TEAM_HORDE:
        m_State = OBJECTIVESTATE_HORDE;
        m_OldState = OBJECTIVESTATE_HORDE;
        m_team = TEAM_HORDE;
        break;
    case TEAM_ALLIANCE:
        m_State = OBJECTIVESTATE_ALLIANCE;
        m_OldState = OBJECTIVESTATE_ALLIANCE;
        m_team = TEAM_ALLIANCE;
        break;
    case TEAM_NEUTRAL:
        m_State = OBJECTIVESTATE_NEUTRAL;
        m_OldState = OBJECTIVESTATE_NEUTRAL;
        m_team = TEAM_NEUTRAL;
        break;
    }

    m_value = 0.0f;
    ChangeState();
    SendChangePhase();
}

void OPvPCapturePointTF::UpdateTowerState()
{
    m_PvP->SendUpdateWorldState(uint32(TFTowerWorldStates[m_TowerType].n), uint32(bool(m_TowerState & TF_TOWERSTATE_N)));
    m_PvP->SendUpdateWorldState(uint32(TFTowerWorldStates[m_TowerType].h), uint32(bool(m_TowerState & TF_TOWERSTATE_H)));
    m_PvP->SendUpdateWorldState(uint32(TFTowerWorldStates[m_TowerType].a), uint32(bool(m_TowerState & TF_TOWERSTATE_A)));
}

bool OPvPCapturePointTF::HandlePlayerEnter(Player* player)
{
    if (OPvPCapturePoint::HandlePlayerEnter(player))
    {
        player->SendUpdateWorldState(TF_UI_TOWER_SLIDER_DISPLAY, 1);
        uint32 phase = (uint32)ceil((m_value + m_maxValue) / (2 * m_maxValue) * 100.0f);
        player->SendUpdateWorldState(TF_UI_TOWER_SLIDER_POS, phase);
        player->SendUpdateWorldState(TF_UI_TOWER_SLIDER_N, m_neutralValuePct);
        return true;
    }
    return false;
}

void OPvPCapturePointTF::HandlePlayerLeave(Player* player)
{
    player->SendUpdateWorldState(TF_UI_TOWER_SLIDER_DISPLAY, 0);
    OPvPCapturePoint::HandlePlayerLeave(player);
}

bool OutdoorPvPTF::Update(uint32 diff)
{
    bool changed = OutdoorPvP::Update(diff);

    if (changed)
    {
        if (m_AllianceTowersControlled == TF_TOWER_NUM)
        {
            TeamApplyBuff(TEAM_ALLIANCE, TF_CAPTURE_BUFF);
            m_IsLocked = true;
            m_JustLocked = true;
            SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_NEUTRAL, uint32(0));
            SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_HORDE, uint32(0));
            SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_ALLIANCE, uint32(1));
            SendUpdateWorldState(TF_UI_TOWERS_CONTROLLED_DISPLAY, uint32(0));
        }
        else if (m_HordeTowersControlled == TF_TOWER_NUM)
        {
            TeamApplyBuff(TEAM_HORDE, TF_CAPTURE_BUFF);
            m_IsLocked = true;
            m_JustLocked = true;
            SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_NEUTRAL, uint32(0));
            SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_HORDE, uint32(1));
            SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_ALLIANCE, uint32(0));
            SendUpdateWorldState(TF_UI_TOWERS_CONTROLLED_DISPLAY, uint32(0));
        }
        else
        {
            TeamCastSpell(TEAM_ALLIANCE, -TF_CAPTURE_BUFF);
            TeamCastSpell(TEAM_HORDE, -TF_CAPTURE_BUFF);
        }

        SendUpdateWorldState(TF_UI_TOWER_COUNT_A, m_AllianceTowersControlled);
        SendUpdateWorldState(TF_UI_TOWER_COUNT_H, m_HordeTowersControlled);
    }

    if (m_IsLocked)
    {
        if (m_JustLocked)
        {
            m_JustLocked = false;
            SaveRequiredWorldStates();
        }

        // lock timer is down, release lock
        if (m_LockTimer < diff)
        {
            m_LockTimer = TF_LOCK_TIME;
            m_LockTimerUpdate = 0;
            m_IsLocked = false;

            ResetZoneToTeamControlled(TEAM_NEUTRAL);
            SaveRequiredWorldStates();

            SendUpdateWorldState(TF_UI_TOWERS_CONTROLLED_DISPLAY, uint32(1));
            SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_NEUTRAL, uint32(0));
            SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_HORDE, uint32(0));
            SendUpdateWorldState(TF_UI_LOCKED_DISPLAY_ALLIANCE, uint32(0));
        }
        else
        {
            // worldstateui update timer is down, update ui with new time data
            if (m_LockTimerUpdate < diff)
            {
                m_LockTimerUpdate = TF_LOCK_TIME_UPDATE;
                RecalculateClientUILockTime();

                SendUpdateWorldState(TF_UI_LOCKED_TIME_MINUTES_FIRST_DIGIT, first_digit);
                SendUpdateWorldState(TF_UI_LOCKED_TIME_MINUTES_SECOND_DIGIT, second_digit);
                SendUpdateWorldState(TF_UI_LOCKED_TIME_HOURS, hours_left);
            }
            else
            {
                m_LockTimerUpdate -= diff;
            }

            m_LockTimer -= diff;
        }
    }

    return changed;
}

void OutdoorPvPTF::HandlePlayerEnterZone(Player* player, uint32 zone)
{
    if (player->GetTeamId() == TEAM_ALLIANCE)
    {
        if (m_AllianceTowersControlled >= TF_TOWER_NUM)
            player->CastSpell(player, TF_CAPTURE_BUFF, true);
    }
    else
    {
        if (m_HordeTowersControlled >= TF_TOWER_NUM)
            player->CastSpell(player, TF_CAPTURE_BUFF, true);
    }
    OutdoorPvP::HandlePlayerEnterZone(player, zone);
}

void OutdoorPvPTF::HandlePlayerLeaveZone(Player* player, uint32 zone)
{
    // remove buffs
    player->RemoveAurasDueToSpell(TF_CAPTURE_BUFF);
    OutdoorPvP::HandlePlayerLeaveZone(player, zone);
}

uint32 OutdoorPvPTF::GetAllianceTowersControlled() const
{
    return m_AllianceTowersControlled;
}

void OutdoorPvPTF::SetAllianceTowersControlled(uint32 count)
{
    m_AllianceTowersControlled = count;
}

uint32 OutdoorPvPTF::GetHordeTowersControlled() const
{
    return m_HordeTowersControlled;
}

void OutdoorPvPTF::SetHordeTowersControlled(uint32 count)
{
    m_HordeTowersControlled = count;
}

bool OutdoorPvPTF::IsLocked() const
{
    return m_IsLocked;
}

bool OutdoorPvPTF::SetupOutdoorPvP()
{
    m_AllianceTowersControlled = 0;
    m_HordeTowersControlled = 0;

    m_IsLocked = bool(sWorld->getWorldState(TF_UI_TOWERS_CONTROLLED_DISPLAY));
    m_JustLocked = false;
    m_LockTimer = TF_LOCK_TIME;
    m_LockTimerUpdate = 0;
    hours_left = 6;
    second_digit = 0;
    first_digit = 0;

    // add the zones affected by the pvp buff
    for (uint8 i = 0; i < OutdoorPvPTFBuffZonesNum; ++i)
        RegisterZone(OutdoorPvPTFBuffZones[i]);

    SetMapFromZone(OutdoorPvPTFBuffZones[0]);

    AddCapturePoint(new OPvPCapturePointTF(this, TF_TOWER_NW));
    AddCapturePoint(new OPvPCapturePointTF(this, TF_TOWER_N));
    AddCapturePoint(new OPvPCapturePointTF(this, TF_TOWER_NE));
    AddCapturePoint(new OPvPCapturePointTF(this, TF_TOWER_SE));
    AddCapturePoint(new OPvPCapturePointTF(this, TF_TOWER_S));

    if (m_IsLocked)
    {
        // Core shutdown while locked -- init from latest known data in WorldState
        // Convert from unix
        int32 const lockRemainingTime = int32((sWorld->getWorldState(TF_UI_LOCKED_TIME_HOURS) - GameTime::GetGameTime().count()) * IN_MILLISECONDS);
        if (lockRemainingTime > 0)
        {
            m_LockTimer = lockRemainingTime;
            RecalculateClientUILockTime();

            uint32 const hordeTowers = uint32(sWorld->getWorldState(TF_UI_TOWER_COUNT_H));
            uint32 const allianceTowers = uint32(sWorld->getWorldState(TF_UI_TOWER_COUNT_A));
            TeamId const controllingTeam = hordeTowers > allianceTowers ? TEAM_HORDE : TEAM_ALLIANCE;

            ResetZoneToTeamControlled(controllingTeam);
        }
        else
        {
            // Lock expired while core was offline
            m_IsLocked = false;
            SaveRequiredWorldStates();
        }
    }

    return true;
}

bool OPvPCapturePointTF::Update(uint32 diff)
{
    // can update even in locked state if gathers the controlling faction
    bool canupdate = ((((OutdoorPvPTF*)m_PvP)->GetAllianceTowersControlled() > 0) && m_activePlayers[0].size() > m_activePlayers[1].size()) ||
                     ((((OutdoorPvPTF*)m_PvP)->GetHordeTowersControlled() > 0) && m_activePlayers[0].size() < m_activePlayers[1].size());
    // if gathers the other faction, then only update if the pvp is unlocked
    canupdate = canupdate || !((OutdoorPvPTF*)m_PvP)->IsLocked();
    return canupdate && OPvPCapturePoint::Update(diff);
}

void OPvPCapturePointTF::ChangeState()
{
    // if changing from controlling alliance to horde
    if (m_OldState == OBJECTIVESTATE_ALLIANCE)
    {
        if (uint32 alliance_towers = ((OutdoorPvPTF*)m_PvP)->GetAllianceTowersControlled())
            ((OutdoorPvPTF*)m_PvP)->SetAllianceTowersControlled(--alliance_towers);
        sWorld->SendZoneText(OutdoorPvPTFBuffZones[0], sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_TF_LOSE_A));
    }
    // if changing from controlling horde to alliance
    else if (m_OldState == OBJECTIVESTATE_HORDE)
    {
        if (uint32 horde_towers = ((OutdoorPvPTF*)m_PvP)->GetHordeTowersControlled())
            ((OutdoorPvPTF*)m_PvP)->SetHordeTowersControlled(--horde_towers);
        sWorld->SendZoneText(OutdoorPvPTFBuffZones[0], sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_TF_LOSE_H));
    }

    uint32 artkit = 21;

    switch (m_State)
    {
        case OBJECTIVESTATE_ALLIANCE:
            {
                m_TowerState = TF_TOWERSTATE_A;
                artkit = 2;
                uint32 alliance_towers = ((OutdoorPvPTF*)m_PvP)->GetAllianceTowersControlled();
                if (alliance_towers < TF_TOWER_NUM)
                    ((OutdoorPvPTF*)m_PvP)->SetAllianceTowersControlled(++alliance_towers);

                sWorld->SendZoneText(OutdoorPvPTFBuffZones[0], sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_TF_CAPTURE_A));

                for (PlayerSet::iterator itr = m_activePlayers[0].begin(); itr != m_activePlayers[0].end(); ++itr)
                    if (Player* player = ObjectAccessor::FindPlayer(*itr))
                        player->AreaExploredOrEventHappens(TF_ALLY_QUEST);
                break;
            }
        case OBJECTIVESTATE_HORDE:
            {
                m_TowerState = TF_TOWERSTATE_H;
                artkit = 1;
                uint32 horde_towers = ((OutdoorPvPTF*)m_PvP)->GetHordeTowersControlled();
                if (horde_towers < TF_TOWER_NUM)
                    ((OutdoorPvPTF*)m_PvP)->SetHordeTowersControlled(++horde_towers);

                sWorld->SendZoneText(OutdoorPvPTFBuffZones[0], sObjectMgr->GetAcoreStringForDBCLocale(LANG_OPVP_TF_CAPTURE_H));

                for (PlayerSet::iterator itr = m_activePlayers[1].begin(); itr != m_activePlayers[1].end(); ++itr)
                    if (Player* player = ObjectAccessor::FindPlayer(*itr))
                        player->AreaExploredOrEventHappens(TF_HORDE_QUEST);
                break;
            }
        case OBJECTIVESTATE_NEUTRAL:
        case OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE:
        case OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE:
        case OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE:
        case OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE:
            m_TowerState = TF_TOWERSTATE_N;
            break;
    }

    auto bounds = sMapMgr->FindMap(530, 0)->GetGameObjectBySpawnIdStore().equal_range(m_capturePointSpawnId);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);

    UpdateTowerState();
}

void OPvPCapturePointTF::SendChangePhase()
{
    // send this too, sometimes the slider disappears, dunno why :(
    SendUpdateWorldState(TF_UI_TOWER_SLIDER_DISPLAY, 1);
    // send these updates to only the ones in this objective
    uint32 phase = (uint32)ceil((m_value + m_maxValue) / (2 * m_maxValue) * 100.0f);
    SendUpdateWorldState(TF_UI_TOWER_SLIDER_POS, phase);
    // send this too, sometimes it resets :S
    SendUpdateWorldState(TF_UI_TOWER_SLIDER_N, m_neutralValuePct);
}

class OutdoorPvP_terokkar_forest : public OutdoorPvPScript
{
public:
    OutdoorPvP_terokkar_forest()
        : OutdoorPvPScript("outdoorpvp_tf")
    {
    }

    OutdoorPvP* GetOutdoorPvP() const override
    {
        return new OutdoorPvPTF();
    }
};

void AddSC_outdoorpvp_tf()
{
    new OutdoorPvP_terokkar_forest();
}
