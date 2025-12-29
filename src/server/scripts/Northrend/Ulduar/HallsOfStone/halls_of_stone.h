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

#ifndef DEF_HALLS_OF_STONE_H
#define DEF_HALLS_OF_STONE_H

#include "CreatureAIImpl.h"

#define DataHeader "HOS"

#define HallsOfStoneScriptName "instance_halls_of_stone"

enum Texts
{
    SAY_BRANN_KILL                = 0,
    SAY_BRANN_LOW_HEALTH          = 1,
    SAY_BRANN_DEATH               = 2,
    SAY_BRANN_PLAYER_DEATH        = 3,
    SAY_BRANN_ESCORT_START        = 4,
    SAY_BRANN_FRONT_OF_SJONNIR    = 5,
    SAY_BRANN_SPAWN_TROGG         = 6,
    SAY_BRANN_SPAWN_OOZE          = 7,
    SAY_BRANN_SPAWN_EARTHEN       = 8,
    SAY_BRANN_EVENT_INTRO_1       = 9,
    SAY_BRANN_VICTORY_SJONNIR_1   = 30,
    SAY_BRANN_VICTORY_SJONNIR_2   = 31,
    SAY_BRANN_ENTRANCE_MEET       = 32,
};

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
    NPC_IRON_SLUDGE             = 28165,

    ACTION_START_ESCORT_EVENT       = 0,
    ACTION_START_TRIBUNAL           = 1,
    ACTION_TRIBUNAL_WIPE_START      = 2,
    ACTION_GO_TO_SJONNIR            = 3,
    ACTION_OPEN_DOOR                = 4,
    ACTION_START_SJONNIR_FIGHT      = 5,
    ACTION_SJONNIR_DEAD             = 6,
    ACTION_SJONNIR_WIPE_START       = 7,
};

template <class AI, class T>
inline AI* GetHallsOfStoneAI(T* obj)
{
    return GetInstanceAI<AI>(obj, HallsOfStoneScriptName);
}

#endif
