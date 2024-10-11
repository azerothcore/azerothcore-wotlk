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

#ifndef DEF_MECHANAR_H
#define DEF_MECHANAR_H

#include "CreatureAIImpl.h"

#define DataHeader "MR"

#define MechanarScriptName "instance_mechanar"

enum DataTypes
{
    DATA_GATEWATCHER_GYROKILL           = 0,
    DATA_GATEWATCHER_IRON_HAND          = 1,
    DATA_MECHANOLORD_CAPACITUS          = 2,
    DATA_NETHERMANCER_SEPRETHREA        = 3,
    DATA_PATHALEON_THE_CALCULATOR       = 4,
    MAX_ENCOUNTER                       = 5,
};

enum NpcIds
{
    NPC_SUNSEEKER_ASTROMAGE             = 19168,
    NPC_SUNSEEKER_ENGINEER              = 20988,
    NPC_BLOODWARDER_CENTURION           = 19510,
    NPC_BLOODWARDER_PHYSICIAN           = 20990,
    NPC_TEMPEST_KEEPER_DESTROYER        = 19735,

    NPC_PATHALEON_THE_CALCULATOR        = 19220
};

enum GameobjectIds
{
    GO_DOOR_MOARG_1                     = 184632,
    GO_DOOR_MOARG_2                     = 184322,
    GO_DOOR_NETHERMANCER                = 184449
};

enum SpellIds
{
    SPELL_TELEPORT_VISUAL               = 34427
};

enum DataIndex
{
    DATA_BRIDGE_MOB_DEATH_COUNT,
    MAX_DATA_INDEXES
};

template <class AI, class T>
inline AI* GetMechanarAI(T* obj)
{
    return GetInstanceAI<AI>(obj, MechanarScriptName);
}

#define RegisterMechanarCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetMechanarAI)

#endif
