/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef DEF_THE_BOTANICA_H
#define DEF_THE_BOTANICA_H

#include "SpellScript.h"

enum DataTypes
{
    DATA_COMMANDER_SARANNIS             = 0,
    DATA_HIGH_BOTANIST_FREYWINN         = 1,
    DATA_THORNGRIN_THE_TENDER           = 2,
    DATA_LAJ                            = 3,
    DATA_WARP_SPLINTER                  = 4,
    MAX_ENCOUNTER                       = 5
};

enum CreatureIds
{
    NPC_COMMANDER_SARANNIS              = 17976,
    NPC_HIGH_BOTANIST_FREYWINN          = 17975,
    NPC_THORNGRIN_THE_TENDER            = 17978,
    NPC_LAJ                             = 17980,
    NPC_WARP_SPLINTER                   = 17977,

    NPC_BLOODFALCON                     = 18155
};

enum SpellIds
{
    SPELL_ARCANE_FORM                   = 34204,
    SPELL_FIRE_FORM                     = 34203,
    SPELL_FROST_FORM                    = 34202,
    SPELL_SHADOW_FORM                   = 34205
};

#endif
