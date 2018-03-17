/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "OutdoorPvPGH.h"
#include "Player.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "WorldPacket.h"
#include "Language.h"
#include "World.h"
#include "GameEventMgr.h"

OutdoorPvPGH::OutdoorPvPGH()
{
    m_TypeId = OUTDOOR_PVP_GH;
}

bool OutdoorPvPGH::SetupOutdoorPvP()
{
    RegisterZone(GH_ZONE);
    if ((m_obj = new OPvPCapturePointGH(this)))
    {
        AddCapturePoint(m_obj);
        return true;
    }
    return false;
}

void OutdoorPvPGH::SendRemoveWorldStates(Player* player)
{
    player->SendUpdateWorldState(GH_UI_SLIDER_DISPLAY, 0);
    player->SendUpdateWorldState(GH_UI_SLIDER_POS, 0);
    player->SendUpdateWorldState(GH_UI_SLIDER_N, 0);
}

OPvPCapturePointGH::OPvPCapturePointGH(OutdoorPvP* pvp) : OPvPCapturePoint(pvp)
{
    SetCapturePointData(189310, 571, 2483.68f, -1873.6f, 10.6877f, -0.104719f, 0.0f, 0.0f, 0.0f, 1.0f);
}

void OPvPCapturePointGH::FillInitialWorldStates(WorldPacket &data)
{
    data << GH_UI_SLIDER_DISPLAY << uint32(0);
    data << GH_UI_SLIDER_POS << uint32(50);
    data << GH_UI_SLIDER_N << uint32(20);
}

void OPvPCapturePointGH::SendChangePhase()
{
    // send this too, sometimes the slider disappears, dunno why :(
    SendUpdateWorldState(GH_UI_SLIDER_DISPLAY, 1);
    // send these updates to only the ones in this objective
    uint32 phase = (uint32)ceil((m_value + m_maxValue) / (2 * m_maxValue) * 100.0f);
    SendUpdateWorldState(GH_UI_SLIDER_POS, phase);
    SendUpdateWorldState(GH_UI_SLIDER_N, m_neutralValuePct);
}

bool OPvPCapturePointGH::HandlePlayerEnter(Player* player)
{
    if (OPvPCapturePoint::HandlePlayerEnter(player))
    {
        player->SendUpdateWorldState(GH_UI_SLIDER_DISPLAY, 1);
        uint32 phase = (uint32)ceil((m_value + m_maxValue) / (2 * m_maxValue) * 100.0f);
        player->SendUpdateWorldState(GH_UI_SLIDER_POS, phase);
        player->SendUpdateWorldState(GH_UI_SLIDER_N, m_neutralValuePct);
        return true;
    }
    return false;
}

void OPvPCapturePointGH::HandlePlayerLeave(Player* player)
{
    player->SendUpdateWorldState(GH_UI_SLIDER_DISPLAY, 0);
    OPvPCapturePoint::HandlePlayerLeave(player);
}

void OPvPCapturePointGH::ChangeState()
{
    uint32 artkit = 21;
    switch (m_State)
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

    if (GameObject* flag = HashMapHolder<GameObject>::Find(m_capturePointGUID))
        flag->SetGoArtKit(artkit);
}

class OutdoorPvP_grizzly_hills : public OutdoorPvPScript
{
    public:

        OutdoorPvP_grizzly_hills()
            : OutdoorPvPScript("outdoorpvp_gh")
        {
        }

        OutdoorPvP* GetOutdoorPvP() const
        {
            return new OutdoorPvPGH();
        }
};

void AddSC_outdoorpvp_gh()
{
    new OutdoorPvP_grizzly_hills();
}
