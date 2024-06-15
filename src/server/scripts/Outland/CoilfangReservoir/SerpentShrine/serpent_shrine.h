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

#ifndef DEF_SERPENT_SHRINE_H
#define DEF_SERPENT_SHRINE_H

#include "CreatureAI.h"
#include "CreatureAIImpl.h"
#include "GridNotifiers.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

#define DataHeader "SS"

#define SerpentShrineScriptName "instance_serpent_shrine"

enum DataTypes
{
    DATA_HYDROSS_THE_UNSTABLE               = 0,
    DATA_THE_LURKER_BELOW                   = 1,
    DATA_LEOTHERAS_THE_BLIND                = 2,
    DATA_FATHOM_LORD_KARATHRESS             = 3,
    DATA_MOROGRIM_TIDEWALKER                = 4,
    DATA_BRIDGE_EMERGED                     = 5,
    DATA_LADY_VASHJ                         = 6,
    MAX_ENCOUNTERS                          = 7,

    DATA_PLATFORM_KEEPER_RESPAWNED          = 20,
    DATA_PLATFORM_KEEPER_DIED               = 21,
    DATA_ALIVE_KEEPERS                      = 22,
    DATA_BRIDGE_ACTIVATED                   = 23,
    DATA_ACTIVATE_SHIELD                    = 24,
    DATA_STRANGE_POOL                       = 25,
    DATA_SEER_OLUM                          = 26
};

enum SSNPCs
{
    NPC_HYDROSS_THE_UNSTABLE                = 21216,
    NPC_THE_LURKER_BELOW                    = 21217,
    NPC_LEOTHERAS_THE_BLIND                 = 21215,
    NPC_CYCLONE_KARATHRESS                  = 22104,
    NPC_FATHOM_LORD_KARATHRESS              = 21214,
    NPC_LADY_VASHJ                          = 21212,

    NPC_FATHOM_GUARD_SHARKKIS               = 21966,
    NPC_FATHOM_GUARD_TIDALVESS              = 21965,
    NPC_FATHOM_GUARD_CARIBDIS               = 21964,

    NPC_SEER_OLUM                           = 22820,

    NPC_COILFANG_SHATTERER                  = 21301,
    NPC_COILFANG_PRIESTESS                  = 21220,

    NPC_ENCHANTED_ELEMENTAL                 = 21958,
    NPC_COILFANG_ELITE                      = 22055,
    NPC_COILFANG_STRIDER                    = 22056,
    NPC_TAINTED_ELEMENTAL                   = 22009,
    NPC_TOXIC_SPOREBAT                      = 22140,

    GO_LADY_VASHJ_BRIDGE_CONSOLE            = 184568,
    GO_COILFANG_BRIDGE1                     = 184203,
    GO_COILFANG_BRIDGE2                     = 184204,
    GO_COILFANG_BRIDGE3                     = 184205,

    GO_SHIELD_GENERATOR1                    = 185051,
    GO_SHIELD_GENERATOR2                    = 185052,
    GO_SHIELD_GENERATOR3                    = 185053,
    GO_SHIELD_GENERATOR4                    = 185054,

    GO_STRANGE_POOL                         = 184956
};

enum SSSpells
{
    SPELL_SUMMON_SERPENTSHRINE_PARASITE     = 39045,
    SPELL_RAMPART_INFECTION                 = 39042,
    SPELL_SCALDING_WATER                    = 37284,
    SPELL_FRENZY_WATER                      = 37026
};

enum KeeperCount
{
  MIN_KEEPER_COUNT = 0,
  MAX_KEEPER_COUNT = 24
};

template <class AI, class T>
inline AI* GetSerpentShrineAI(T* obj)
{
    return GetInstanceAI<AI>(obj, SerpentShrineScriptName);
}

#define RegisterSerpentShrineAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetSerpentShrineAI)

#endif
