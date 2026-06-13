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

#include "OutdoorPvPGH.h"
#include "GameEventMgr.h"
#include "MapMgr.h"
#include "OutdoorPvPMgr.h"
#include "OutdoorPvPScript.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldStateDefines.h"

OutdoorPvPGH::OutdoorPvPGH()
{
    _typeId = OUTDOOR_PVP_GH;
}

bool OutdoorPvPGH::SetupOutdoorPvP()
{
    RegisterZone(GH_ZONE);
    SetMapFromZone(GH_ZONE);

    AddCapturePoint(new OPvPCapturePointGH(this));
    return true;
}

void OutdoorPvPGH::SendRemoveWorldStates(Player* player)
{
    player->SendUpdateWorldState(WORLD_STATE_OPVP_GH_UI_SLIDER_DISPLAY, 0);
    player->SendUpdateWorldState(WORLD_STATE_OPVP_GH_UI_SLIDER_POS, 0);
    player->SendUpdateWorldState(WORLD_STATE_OPVP_GH_UI_SLIDER_N, 0);
}

void OutdoorPvPGH::HandleKill(Player* killer, Unit* killed)
{
    if (!killed->IsPlayer())
        return;

    if (!killer->isHonorOrXPTarget(killed))
        return;

    if (killer->GetTeamId() == TEAM_ALLIANCE)
        if (killer->GetQuestStatus(GH_QUEST_KICK_EM_WHILE_THEYRE_DOWN) == QUEST_STATUS_INCOMPLETE)
            killer->KilledMonsterCredit(GH_CREATURE_QUEST_BUNNY);

    if (killer->GetTeamId() == TEAM_HORDE)
        if (killer->GetQuestStatus(GH_QUEST_KEEP_EM_ON_THEIR_HEELS) == QUEST_STATUS_INCOMPLETE)
            killer->KilledMonsterCredit(GH_CREATURE_QUEST_BUNNY);
}

OPvPCapturePointGH::OPvPCapturePointGH(OutdoorPvP* pvp) : OPvPCapturePoint(pvp)
{
    SetCapturePointData(189310, MAP_NORTHREND, 2483.68f, -1873.6f, 10.6877f, -0.104719f, 0.0f, 0.0f, 0.0f, 1.0f);
}

void OPvPCapturePointGH::FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet)
{
    packet.Worldstates.reserve(3);
    packet.Worldstates.emplace_back(WORLD_STATE_OPVP_GH_UI_SLIDER_DISPLAY, 0);
    packet.Worldstates.emplace_back(WORLD_STATE_OPVP_GH_UI_SLIDER_POS, 50);
    packet.Worldstates.emplace_back(WORLD_STATE_OPVP_GH_UI_SLIDER_N, 20);
}

void OPvPCapturePointGH::SendChangePhase()
{
    // send this too, sometimes the slider disappears, dunno why :(
    SendUpdateWorldState(WORLD_STATE_OPVP_GH_UI_SLIDER_DISPLAY, 1);
    // send these updates to only the ones in this objective
    uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
    SendUpdateWorldState(WORLD_STATE_OPVP_GH_UI_SLIDER_POS, phase);
    SendUpdateWorldState(WORLD_STATE_OPVP_GH_UI_SLIDER_N, _neutralValuePct);
}

bool OPvPCapturePointGH::HandlePlayerEnter(Player* player)
{
    if (OPvPCapturePoint::HandlePlayerEnter(player))
    {
        player->SendUpdateWorldState(WORLD_STATE_OPVP_GH_UI_SLIDER_DISPLAY, 1);
        uint32 phase = (uint32)ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f);
        player->SendUpdateWorldState(WORLD_STATE_OPVP_GH_UI_SLIDER_POS, phase);
        player->SendUpdateWorldState(WORLD_STATE_OPVP_GH_UI_SLIDER_N, _neutralValuePct);
        return true;
    }
    return false;
}

void OPvPCapturePointGH::HandlePlayerLeave(Player* player)
{
    player->SendUpdateWorldState(WORLD_STATE_OPVP_GH_UI_SLIDER_DISPLAY, 0);
    OPvPCapturePoint::HandlePlayerLeave(player);
}

void OPvPCapturePointGH::ChangeState()
{
    uint32 artkit = 21;
    switch (_state)
    {
        case OBJECTIVESTATE_ALLIANCE:
            sGameEventMgr->StopEvent(GH_ALLIANCE_DEFENSE_EVENT);
            sGameEventMgr->StopEvent(GH_HORDE_DEFENSE_EVENT);
            sGameEventMgr->StartEvent(GH_ALLIANCE_DEFENSE_EVENT);
            artkit = 2;
            break;
        case OBJECTIVESTATE_HORDE:
            sGameEventMgr->StopEvent(GH_ALLIANCE_DEFENSE_EVENT);
            sGameEventMgr->StopEvent(GH_HORDE_DEFENSE_EVENT);
            sGameEventMgr->StartEvent(GH_HORDE_DEFENSE_EVENT);
            artkit = 1;
            break;
        default:
            break;
    }

    Map* map = sMapMgr->FindMap(MAP_NORTHREND, 0);
    auto bounds = map->GetGameObjectBySpawnIdStore().equal_range(m_capturePointSpawnId);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
        itr->second->SetGoArtKit(artkit);
}

class OutdoorPvP_grizzly_hills : public OutdoorPvPScript
{
public:
    OutdoorPvP_grizzly_hills()
        : OutdoorPvPScript("outdoorpvp_gh")
    {
    }

    OutdoorPvP* GetOutdoorPvP() const override
    {
        return new OutdoorPvPGH();
    }
};

void AddSC_outdoorpvp_gh()
{
    new OutdoorPvP_grizzly_hills();
}
