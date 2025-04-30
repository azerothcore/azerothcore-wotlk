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

#ifndef OUTDOOR_PVP_GH_
#define OUTDOOR_PVP_GH_

#include "OutdoorPvP.h"

enum OutdoorPvPGHenum
{
    GH_ALLIANCE_DEFENSE_EVENT           = 65,
    GH_HORDE_DEFENSE_EVENT              = 66,

    GH_ZONE                             = 394,

    GH_UI_SLIDER_DISPLAY                = 3466,
    GH_UI_SLIDER_POS                    = 3467,
    GH_UI_SLIDER_N                      = 3468,
};

class Unit;
class Creature;
class OPvPCapturePointGH;

class OutdoorPvPGH : public OutdoorPvP
{
public:
    OutdoorPvPGH();
    bool SetupOutdoorPvP() override;
    void SendRemoveWorldStates(Player* player) override;
};

class OPvPCapturePointGH : public OPvPCapturePoint
{
public:
    OPvPCapturePointGH(OutdoorPvP* pvp);

    void ChangeState() override;
    void SendChangePhase() override;

    void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override;

    bool HandlePlayerEnter(Player* player) override;
    void HandlePlayerLeave(Player* player) override;
};

#endif
