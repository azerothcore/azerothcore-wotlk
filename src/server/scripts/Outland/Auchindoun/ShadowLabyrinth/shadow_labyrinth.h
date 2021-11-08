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

#ifndef DEF_SHADOW_LABYRINTH_H
#define DEF_SHADOW_LABYRINTH_H

#include "CreatureAI.h"
#include "CreatureAIImpl.h"
#include "GridNotifiers.h"
#include "SpellScript.h"

#define ShadowLabyrinthScriptName "instance_shadow_labyrinth"

enum slData
{
    TYPE_OVERSEER                   = 0,
    TYPE_HELLMAW                    = 1,
    DATA_BLACKHEARTTHEINCITEREVENT  = 2,
    DATA_GRANDMASTERVORPILEVENT     = 3,
    DATA_MURMUREVENT                = 4,
    MAX_ENCOUNTER                   = 5
};

enum slNPCandGO
{
    NPC_FEL_OVERSEER            = 18796,
    NPC_HELLMAW                 = 18731,

    REFECTORY_DOOR              = 183296,                     //door opened when blackheart the inciter dies
    SCREAMING_HALL_DOOR         = 183295                      //door opened when grandmaster vorpil dies
};

template <class AI, class T>
inline AI* GetShadowLabyrinthAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ShadowLabyrinthScriptName);
}

#endif
