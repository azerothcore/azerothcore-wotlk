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

#ifndef GRUULS_LAIR_H_
#define GRUULS_LAIR_H_

#include "CreatureAI.h"
#include "CreatureAIImpl.h"
#include "SpellAuraEffects.h"

#define GruulsLairScriptName "instance_gruuls_lair"

enum DataTypes
{
    DATA_MAULGAR                = 0,
    DATA_GRUUL                  = 1,
    MAX_ENCOUNTER               = 2,

    DATA_ADDS_KILLED            = 10,
    MAX_ADD_NUMBER              = 4
};

enum CreatureIds
{
    NPC_MAULGAR                 = 18831,
    NPC_KROSH_FIREHAND          = 18832,
    NPC_OLM_THE_SUMMONER        = 18834,
    NPC_KIGGLER_THE_CRAZED      = 18835,
    NPC_BLINDEYE_THE_SEER       = 18836
};

enum GameObjectIds
{
    GO_MAULGAR_DOOR             = 184468,
    GO_GRUUL_DOOR               = 184662
};

template <class AI, class T>
inline AI* GetGruulsLairAI(T* obj)
{
    return GetInstanceAI<AI>(obj, GruulsLairScriptName);
}

#endif // GRUULS_LAIR_H_
