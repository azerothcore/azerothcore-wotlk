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

#ifndef DEF_BLOOD_FURNACE_H
#define DEF_BLOOD_FURNACE_H

#include "CreatureAIImpl.h"
#include "Player.h"

#define BloodFurnaceScriptName "instance_blood_furnace"

enum bloodFurnace
{
    DATA_THE_MAKER                      = 0,
    DATA_BROGGOK                        = 1,
    DATA_KELIDAN                        = 2,
    MAX_ENCOUNTER                       = 3,

    DATA_DOOR1                          = 10,
    DATA_DOOR2                          = 11,
    DATA_DOOR3                          = 12,
    DATA_DOOR4                          = 13,
    DATA_DOOR5                          = 14,
    DATA_DOOR6                          = 15,

    DATA_PRISON_CELL1                   = 20,
    DATA_PRISON_CELL2                   = 21,
    DATA_PRISON_CELL3                   = 22,
    DATA_PRISON_CELL4                   = 23,

    ACTION_ACTIVATE_BROGGOK             = 30,
    ACTION_PREPARE_BROGGOK              = 31
};

enum bloodFurnaceNPC
{
    NPC_THE_MAKER                       = 17381,
    NPC_BROGGOK                         = 17380,
    NPC_KELIDAN                         = 17377,
    NPC_NASCENT_FEL_ORC                 = 17398,
    NPC_CHANNELER                       = 17653
};

template <class AI, class T>
inline AI* GetBloodFurnaceAI(T* obj)
{
    return GetInstanceAI<AI>(obj, BloodFurnaceScriptName);
}

#endif
