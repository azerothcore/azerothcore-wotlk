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

#ifndef DEF_HALLS_OF_STONE_H
#define DEF_HALLS_OF_STONE_H

#include "CreatureAIImpl.h"

#define HallsOfStoneScriptName "instance_halls_of_stone"

enum Encounter
{
    BOSS_KRYSTALLUS             = 0,
    BOSS_MAIDEN_OF_GRIEF        = 1,
    BOSS_TRIBUNAL_OF_AGES       = 2,
    BOSS_SJONNIR                = 3,
    BRANN_BRONZEBEARD           = 4,
    BRANN_DOOR                  = 5,
    MAX_ENCOUNTER               = 6,

    DATA_BRANN_ACHIEVEMENT,
    DATA_SJONNIR_ACHIEVEMENT,
};

enum gobjects
{
    GO_TRIBUNAL_CONSOLE         = 193907,
    GO_TRIBUNAL_ACCESS_DOOR     = 191295,
    GO_KADDRAK                  = 191671,
    GO_MARNAK                   = 191670,
    GO_ABEDNEUM                 = 191669,
    GO_SKY_FLOOR                = 191527,
    GO_SJONNIR_CONSOLE          = 193906,
    GO_SJONNIR_DOOR             = 191296,
    GO_TRIBUNAL_CHEST           = 190586,
    GO_TRIBUNAL_CHEST_H         = 193996,
    GO_LEFT_PIPE                = 192163,
    GO_RIGHT_PIPE               = 192164,
};

enum npcs
{
    NPC_KADDRAK                 = 30898,
    NPC_MARNAK                  = 30897,
    NPC_ABEDNEUM                = 30899,
    NPC_SJONNIR                 = 27978,
    NPC_BRANN                   = 28070,
};

template <class AI, class T>
inline AI* GetHallsOfStoneAI(T* obj)
{
    return GetInstanceAI<AI>(obj, HallsOfStoneScriptName);
}

#endif
