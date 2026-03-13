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

#ifndef OUTDOOR_PVP_GH_
#define OUTDOOR_PVP_GH_

#include "OutdoorPvP.h"

enum OutdoorPvPGHenum
{
    GH_ALLIANCE_DEFENSE_EVENT           = 65,
    GH_HORDE_DEFENSE_EVENT              = 66,

    GH_ZONE                             = 394,

    GH_QUEST_KEEP_EM_ON_THEIR_HEELS     = 12284,
    GH_QUEST_KICK_EM_WHILE_THEYRE_DOWN  = 12289,
    GH_CREATURE_QUEST_BUNNY             = 27453,
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
    void HandleKill(Player* killer, Unit* killed) override;
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
