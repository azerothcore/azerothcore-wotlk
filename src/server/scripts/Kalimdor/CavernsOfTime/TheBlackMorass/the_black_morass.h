/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef DEF_THEBLACKMORASS_H
#define DEF_THEBLACKMORASS_H

#include "SpellScript.h"
#include "PassiveAI.h"

enum DataTypes
{
    TYPE_CHRONO_LORD_DEJA               = 0,
    TYPE_TEMPORUS                       = 1,
    TYPE_AEONUS                         = 2,
    MAX_ENCOUNTER                       = 3,

    DATA_MEDIVH                         = 10,
    DATA_RIFT_KILLED                    = 11,
    DATA_DAMAGE_SHIELD                  = 12,
    DATA_SHIELD_PERCENT                 = 13,
    DATA_RIFT_NUMBER                    = 14,

    DATA_SUMMONED_NPC                   = 20,
    DATA_DELETED_NPC                    = 21,
};

enum WorldStateIds
{
    WORLD_STATE_BM                      = 2541,
    WORLD_STATE_BM_SHIELD               = 2540,
    WORLD_STATE_BM_RIFT                 = 2784
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

    NPC_INFINITE_ASSASIN                = 17835,
    NPC_INFINITE_WHELP                  = 21818,
    NPC_INFINITE_CRONOMANCER            = 17892,
    NPC_INFINITE_EXECUTIONER            = 18994,
    NPC_INFINITE_VANQUISHER             = 18995
};

enum Misc
{   
    SPELL_RIFT_CHANNEL                  = 31387,

    EVENT_NEXT_PORTAL                   = 1,
    EVENT_SUMMON_KEEPER                 = 2,

    ACTION_OUTRO                        = 1
};

#endif
