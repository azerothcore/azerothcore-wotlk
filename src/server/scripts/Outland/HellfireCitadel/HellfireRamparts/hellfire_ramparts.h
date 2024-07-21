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

#ifndef DEF_RAMPARTS_H
#define DEF_RAMPARTS_H

#include "CreatureAIImpl.h"

#define DataHeader "HR"
#define HellfireRampartsScriptName "instance_hellfire_ramparts"

enum DataTypes
{
    DATA_WATCHKEEPER_GARGOLMAR  = 0,
    DATA_OMOR_THE_UNSCARRED     = 1,
    DATA_VAZRUDEN               = 2,
    MAX_ENCOUNTERS              = 3
};

enum CreatureIds
{
    NPC_HELLFIRE_SENTRY         = 17517,
    NPC_VAZRUDEN_HERALD         = 17307,
    NPC_VAZRUDEN                = 17537,
    NPC_NAZAN                   = 17536
};

enum GameobjectIds
{
    GO_FEL_IRON_CHEST_NORMAL    = 185168,
    GO_FEL_IRON_CHECT_HEROIC    = 185169
};

template <class AI, class T>
inline AI* GetHellfireRampartsAI(T* obj)
{
    return GetInstanceAI<AI>(obj, HellfireRampartsScriptName);
}

#define RegisterHellfireRampartsCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetHellfireRampartsAI)

#endif
