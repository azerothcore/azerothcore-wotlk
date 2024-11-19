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

#ifndef DEF_THE_EYE_H
#define DEF_THE_EYE_H

#include "CreatureAIImpl.h"

#define DataHeader "TE"

#define TheEyeScriptName "instance_the_eye"

enum EyeData
{
    DATA_ALAR               = 0,
    DATA_ASTROMANCER        = 1,
    DATA_REAVER             = 2,
    DATA_KAELTHAS           = 3,
    MAX_ENCOUNTER           = 4,

    DATA_THALADRED          = 10,
    DATA_LORD_SANGUINAR     = 11,
    DATA_CAPERNIAN          = 12,
    DATA_TELONICUS          = 13,

    DATA_KAEL_DOOR_1        = 14,
    DATA_KAEL_DOOR_2        = 15
};

enum EyeNPCs
{
    NPC_ALAR                = 19514,
    NPC_KAELTHAS            = 19622,
    NPC_THALADRED           = 20064,
    NPC_LORD_SANGUINAR      = 20060,
    NPC_CAPERNIAN           = 20062,
    NPC_TELONICUS           = 20063
};

enum EyeGOs
{
    GO_BRIDGE_WINDOW        = 184069,
    GO_KAEL_STATUE_RIGHT    = 184596,
    GO_KAEL_STATUE_LEFT     = 184597,
    GO_KAEL_DOOR_1          = 184324,
    GO_KAEL_DOOR_2          = 184325
};

template <class AI, class T>
inline AI* GetTheEyeAI(T* obj)
{
    return GetInstanceAI<AI>(obj, TheEyeScriptName);
}

#define RegisterTheEyeAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetTheEyeAI)

#endif
