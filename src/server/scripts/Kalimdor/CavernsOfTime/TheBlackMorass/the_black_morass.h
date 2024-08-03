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

#ifndef DEF_THEBLACKMORASS_H
#define DEF_THEBLACKMORASS_H

#include "CreatureAIImpl.h"

#define DataHeader "TBM"

uint32 const EncounterCount = 3;

#define TheBlackMorassScriptName "instance_the_black_morass"

enum DataTypes
{
    DATA_CHRONO_LORD_DEJA               = 0,
    DATA_TEMPORUS                       = 1,
    DATA_AEONUS                         = 2,
    MAX_ENCOUNTER                       = 3,

    DATA_MEDIVH                         = 10,

    DATA_DAMAGE_SHIELD                  = 12,
    DATA_SHIELD_PERCENT                 = 13,
    DATA_RIFT_NUMBER                    = 14
};

enum WorldStateIds
{
    WORLD_STATE_BM                      = 2541,
    WORLD_STATE_BM_SHIELD               = 2540,
    WORLD_STATE_BM_RIFT                 = 2784
};

enum EventStatus
{
    EVENT_PREPARE                       = 0,
    EVENT_IN_PROGRESS                   = 1
};

enum QuestIds
{
    QUEST_OPENING_PORTAL                = 10297,
    QUEST_MASTER_TOUCH                  = 9836
};

enum CreatureIds
{
    NPC_MEDIVH                          = 15608,
    NPC_TIME_RIFT                       = 17838,
    NPC_TIME_KEEPER                     = 17918,

    NPC_RIFT_KEEPER_WARLOCK             = 21104,
    NPC_RIFT_KEEPER_MAGE                = 21148,
    NPC_RIFT_LORD                       = 17839,
    NPC_RIFT_LORD_2                     = 21140,

    NPC_CHRONO_LORD_DEJA                = 17879,
    NPC_INFINITE_CHRONO_LORD            = 21697,
    NPC_TEMPORUS                        = 17880,
    NPC_INFINITE_TIMEREAVER             = 21698,
    NPC_AEONUS                          = 17881,

    NPC_INFINITE_ASSASSIN               = 17835,
    NPC_INFINITE_WHELP                  = 21818,
    NPC_INFINITE_CHRONOMANCER           = 17892,
    NPC_INFINITE_EXECUTIONER            = 18994,
    NPC_INFINITE_VANQUISHER             = 18995,

    NPC_INFINITE_ASSASSIN_2             = 21137,
    NPC_INFINITE_CHRONOMANCER_2         = 21136,
    NPC_INFINITE_EXECUTIONER_2          = 21138,
    NPC_INFINITE_VANQUISHER_2           = 21139,

    NPC_DP_EMITTER_STALKER              = 18582,
    NPC_DP_CRYSTAL_STALKER              = 18553,
    NPC_DP_BEAM_STALKER                 = 18555
};

enum Misc
{
    SPELL_RIFT_CHANNEL                  = 31387,
    SPELL_TELEPORT_VISUAL               = 7791,

    ACTION_OUTRO                        = 1,

    CONTEXT_GROUP_RIFTS                 = 1
};

enum medivhSays
{
    SAY_MEDIVH_ENTER                    = 0,
    SAY_MEDIVH_DEATH                    = 5,
    SAY_MEDIVH_WIN                      = 6,
    SAY_MEDIVH_ORCS_ENTER               = 7,

    SAY_MEDIVH_ORCS_ANSWER              = 0
};

enum medivhSpells
{
    SPELL_MANA_SHIELD           = 31635,
    SPELL_MEDIVH_CHANNEL        = 31556,
    SPELL_BLACK_CRYSTAL         = 32563,
    SPELL_PORTAL_CRYSTALS       = 32564,
    SPELL_BANISH_PURPLE         = 32566,
    SPELL_BANISH_GREEN          = 32567,

    SPELL_CORRUPT               = 31326,
    SPELL_CORRUPT_AEONUS        = 37853,
};

template <class AI, class T>
inline AI* GetTheBlackMorassAI(T* obj)
{
    return GetInstanceAI<AI>(obj, TheBlackMorassScriptName);
}

#define RegisterTheBlackMorassCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetTheBlackMorassAI)

#endif
