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

#ifndef DEF_MECHANAR_H
#define DEF_MECHANAR_H

#include "CreatureAI.h"
#include "CreatureAIImpl.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

#define MechanarScriptName "instance_mechanar"

enum DataTypes
{
    DATA_GATEWATCHER_GYROKILL           = 0,
    DATA_GATEWATCHER_IRON_HAND          = 1,
    DATA_MECHANOLORD_CAPACITUS          = 2,
    DATA_NETHERMANCER_SEPRETHREA        = 3,
    DATA_PATHALEON_THE_CALCULATOR       = 4,
    MAX_ENCOUNTER                       = 5,

    ENCOUNTER_PASSAGE_NOT_STARTED       = 0,
    ENCOUNTER_PASSAGE_PHASE1            = 1,
    ENCOUNTER_PASSAGE_PHASE2            = 2,
    ENCOUNTER_PASSAGE_PHASE3            = 3,
    ENCOUNTER_PASSAGE_PHASE4            = 4,
    ENCOUNTER_PASSAGE_PHASE5            = 5,
    ENCOUNTER_PASSAGE_PHASE6            = 6,
    ENCOUNTER_PASSAGE_DONE              = 7,
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
    SPELL_TELEPORT_VISUAL               = 35517
};

template <class AI, class T>
inline AI* GetMechanarAI(T* obj)
{
    return GetInstanceAI<AI>(obj, MechanarScriptName);
}

#endif
