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

#ifndef DEF_DIRE_MAUL_H
#define DEF_DIRE_MAUL_H

#include "CreatureAIImpl.h"

#define DataHeader "DML"

constexpr auto DMScriptName = "instance_dire_maul";

enum DataTypes
{
    TYPE_EAST_WING_PROGRESS         = 0,
    TYPE_WEST_WING_PROGRESS         = 1,
    TYPE_PYLONS_STATE               = 2,
    TYPE_NORTH_WING_PROGRESS        = 3,
    TYPE_NORTH_WING_BOSSES          = 4,
    DATA_ISALIEN                    = 32,

    ALL_PYLONS_OFF                  = 0x1F
};

enum GoIds
{
    GO_DIRE_MAUL_FORCE_FIELD        = 179503,
    GO_GORDOK_TRIBUTE               = 179564
};

enum NpcIds
{
    NPC_IMMOL_THAR                  = 11496,
    NPC_HIGHBORNE_SUMMONER          = 11466
};

template <class AI, class T>
inline AI* GetDireMaulAI(T* obj)
{
    return GetInstanceAI<AI>(obj, DMScriptName);
}

#define RegisterDireMaulCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetDireMaulAI)

#endif
