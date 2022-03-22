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

#ifndef __BATTLEGROUNDBE_H
#define __BATTLEGROUNDBE_H

#include "Arena.h"

enum BattlegroundBEObjectTypes
{
    BG_BE_OBJECT_DOOR_1         = 0,
    BG_BE_OBJECT_DOOR_2         = 1,
    BG_BE_OBJECT_DOOR_3         = 2,
    BG_BE_OBJECT_DOOR_4         = 3,
    BG_BE_OBJECT_BUFF_1         = 4,
    BG_BE_OBJECT_BUFF_2         = 5,
    BG_BE_OBJECT_READY_MARKER_1 = 6,
    BG_BE_OBJECT_READY_MARKER_2 = 7,
    BG_BE_OBJECT_MAX            = 8
};

enum BattlegroundBEGameObjects
{
    BG_BE_OBJECT_TYPE_DOOR_1    = 183971,
    BG_BE_OBJECT_TYPE_DOOR_2    = 183973,
    BG_BE_OBJECT_TYPE_DOOR_3    = 183970,
    BG_BE_OBJECT_TYPE_DOOR_4    = 183972,
    BG_BE_OBJECT_TYPE_BUFF_1    = 184663,
    BG_BE_OBJECT_TYPE_BUFF_2    = 184664
};

class AC_GAME_API BattlegroundBE : public Arena
{
public:
    BattlegroundBE();

    /* inherited from BattlegroundClass */
    void StartingEventCloseDoors() override;
    void StartingEventOpenDoors() override;

    void HandleAreaTrigger(Player* player, uint32 trigger) override;
    bool SetupBattleground() override;
    void FillInitialWorldStates(WorldPacket& d) override;
    bool HandlePlayerUnderMap(Player* player) override;
};

#endif
