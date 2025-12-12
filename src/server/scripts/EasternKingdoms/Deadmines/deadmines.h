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

#ifndef DEF_DEADMINES_H
#define DEF_DEADMINES_H

#include "CreatureAIImpl.h"

#define DataHeader "DM"
#define DeadminesScriptName "instance_deadmines"

enum DataTypes
{
    TYPE_RHAHK_ZOR              = 0,
    TYPE_CANNON                 = 1,
    MAX_ENCOUNTERS              = 2
};

enum GameObjects
{
    GO_FACTORY_DOOR             = 13965,
    GO_HEAVY_DOOR_1             = 17153,
    GO_HEAVY_DOOR_2             = 17154,
    GO_IRON_CLAD_DOOR           = 16397,
    GO_DOOR_LEVER_1             = 101831,
    GO_DOOR_LEVER_2             = 101833,
    GO_DOOR_LEVER_3             = 101834,
    GO_CANNON                   = 16398,
};

template <class AI, class T>
inline AI* GetDeadminesAI(T* obj)
{
    return GetInstanceAI<AI>(obj, DeadminesScriptName);
}

#endif
