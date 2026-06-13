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

#ifndef DEF_SHADOW_LABYRINTH_H
#define DEF_SHADOW_LABYRINTH_H

#include "CreatureAIImpl.h"
#include "GridNotifiers.h"

#define ShadowLabyrinthScriptName "instance_shadow_labyrinth"

enum slData
{
    TYPE_RITUALISTS                 = 0,
    TYPE_HELLMAW                    = 1,
    DATA_BLACKHEARTTHEINCITEREVENT  = 2,
    DATA_GRANDMASTER_VORPIL         = 3,
    DATA_GRANDMASTER_VORPIL_EVENT   = 4,
    DATA_MURMUR                     = 5,
    DATA_MURMUREVENT                = 6,
    MAX_ENCOUNTER                   = 7
};

enum slNPCandGO
{
    NPC_CABAL_RITUALIST         = 18794,
    NPC_HELLMAW                 = 18731,

    GO_REFECTORY_DOOR           = 183296,                     //door opened when blackheart the inciter dies
    GO_SCREAMING_HALL_DOOR      = 183295                      //door opened when grandmaster vorpil dies
};

uint32 constexpr EncounterCount = 4;
uint32 constexpr PersistentDataCount = 1;

template <class AI, class T>
inline AI* GetShadowLabyrinthAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ShadowLabyrinthScriptName);
}

#define RegisterShadowLabyrinthCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetShadowLabyrinthAI)

#endif
