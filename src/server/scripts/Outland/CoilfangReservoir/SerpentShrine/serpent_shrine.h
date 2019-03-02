/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef DEF_SERPENT_SHRINE_H
#define DEF_SERPENT_SHRINE_H

#include "Player.h"
#include "SpellScript.h"
#include "CreatureAI.h"
#include "SpellAuraEffects.h"
#include "GridNotifiers.h"

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


};

enum SSNPCs
{
    NPC_HYDROSS_THE_UNSTABLE                = 21216,
    NPC_THE_LURKER_BELOW                    = 21217,
    NPC_LEOTHERAS_THE_BLIND                 = 21215,
    NPC_CYCLONE_KARATHRESS                  = 22104,
    NPC_LADY_VASHJ                          = 21212,

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
    GO_SHIELD_GENERATOR4                    = 185054
};

enum SSSpells
{
    SPELL_SUMMON_SERPENTSHRINE_PARASITE     = 39045,
    SPELL_RAMPART_INFECTION                 = 39042,
    SPELL_SCALDING_WATER                    = 37284,
    SPELL_FRENZY_WATER                      = 37026
};

#endif

