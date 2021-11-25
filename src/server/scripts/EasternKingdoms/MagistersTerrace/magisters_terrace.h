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

#include "CreatureAI.h"
#include "CreatureAIImpl.h"
#include "Player.h"
#include "SpellScript.h"

#define MTScriptName "instance_magisters_terrace"

enum MTData
{
    DATA_SELIN_EVENT            = 0,
    DATA_VEXALLUS_EVENT         = 1,
    DATA_DELRISSA_EVENT         = 2,
    DATA_KAELTHAS_EVENT         = 3,
    MAX_ENCOUNTER               = 4
};

enum MTCreatures
{
    NPC_DELRISSA                = 24560,
    NPC_FEL_CRYSTAL             = 24722,
    NPC_KAEL_THAS               = 24664,
    NPC_PHOENIX                 = 21362,
    NPC_PHOENIX_EGG             = 21364
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

template <class AI, class T>
inline AI* GetMagistersTerraceAI(T* obj)
{
    return GetInstanceAI<AI>(obj, MTScriptName);
}

#endif
