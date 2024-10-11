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

#ifndef DEF_MAGISTERS_TERRACE_H
#define DEF_MAGISTERS_TERRACE_H

#include "CreatureAIImpl.h"

#define DataHeader "MT"
#define MTScriptName "instance_magisters_terrace"

enum MTData
{
    DATA_SELIN_FIREHEART        = 0,
    DATA_VEXALLUS               = 1,
    DATA_DELRISSA               = 2,
    DATA_KAELTHAS               = 3,
    MAX_ENCOUNTER               = 4,

    DATA_KALECGOS               = 5,
    DATA_ESCAPE_ORB             = 6
};

enum MTCreatures
{
    NPC_DELRISSA                = 24560,
    NPC_FEL_CRYSTAL             = 24722,
    NPC_KAEL_THAS               = 24664,
    NPC_PHOENIX                 = 21362,
    NPC_PHOENIX_EGG             = 21364,
    NPC_KALECGOS                = 24844,
    NPC_HUMAN_KALECGOS          = 24848
};

enum MTGameObjects
{
    GO_VEXALLUS_DOOR            = 187896,
    GO_SELIN_DOOR               = 187979,
    GO_SELIN_ENCOUNTER_DOOR     = 188065,
    GO_DELRISSA_DOOR            = 187770,
    GO_KAEL_DOOR                = 188064,
    GO_ESCAPE_ORB               = 188173
};

enum InstanceEventIds
{
    EVENT_SPAWN_KALECGOS = 16547
};

enum InstanceText
{
    SAY_KALECGOS_SPAWN = 0
};

enum MovementData
{
    PATH_KALECGOS_FLIGHT = 248440
};

template <class AI, class T>
inline AI* GetMagistersTerraceAI(T* obj)
{
    return GetInstanceAI<AI>(obj, MTScriptName);
}

#define RegisterMagistersTerraceCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetMagistersTerraceAI)

#endif
