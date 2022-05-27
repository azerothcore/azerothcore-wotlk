/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DEF_SHATTERED_H
#define DEF_SHATTERED_H

#include "CreatureAIImpl.h"
#include "PassiveAI.h"
#include "SpellScript.h"

#define ShatteredHallsLairScriptName "instance_shattered_halls"

enum DataTypes
{
    DATA_NETHEKURSE                 = 0,
    DATA_OMROGG                     = 1,
    DATA_KARGATH                    = 2,
    ENCOUNTER_COUNT                 = 3,

    DATA_ENTERED_ROOM               = 10,
    DATA_PRISONER_1                 = 11,
    DATA_PRISONER_2                 = 12,
    DATA_PRISONER_3                 = 13,
    DATA_EXECUTIONER                = 14
};

enum CreatureIds
{
    NPC_GRAND_WARLOCK_NETHEKURSE    = 16807,
    NPC_WARCHIEF_KARGATH            = 16808,
    NPC_FEL_ORC_CONVERT             = 17083,

    // Trial of the Naaru: Mercy
    NPC_SHATTERED_EXECUTIONER       = 17301,
    NPC_RIFLEMAN_BROWNBEARD         = 17289,
    NPC_CAPTAIN_ALINA               = 17290,
    NPC_PRIVATE_JACINT              = 17292,
    NPC_KORAG_PROUDMANE             = 17295,
    NPC_CAPTAIN_BONESHATTER         = 17296,
    NPC_SCOUT_ORGARR                = 17297,
};

enum GameobjectIds
{
    GO_GRAND_WARLOCK_CHAMBER_DOOR_1 = 182539,
    GO_GRAND_WARLOCK_CHAMBER_DOOR_2 = 182540
};

enum SpellIds
{
    SPELL_KARGATHS_EXECUTIONER_1    = 39288,
    SPELL_KARGATHS_EXECUTIONER_2    = 39289,
    SPELL_KARGATHS_EXECUTIONER_3    = 39290
};

template <class AI, class T>
inline AI* GetShatteredHallsAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ShatteredHallsLairScriptName);
}

#endif
