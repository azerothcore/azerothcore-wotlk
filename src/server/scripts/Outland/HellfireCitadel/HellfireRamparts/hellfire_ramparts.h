/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef DEF_RAMPARTS_H
#define DEF_RAMPARTS_H

#include "SpellScript.h"

enum DataTypes
{
    DATA_WATCHKEEPER_GARGOLMAR  = 0,
    DATA_OMOR_THE_UNSCARRED     = 1,
    DATA_VAZRUDEN               = 2,
    MAX_ENCOUNTERS              = 3
};

enum CreatureIds
{
    NPC_HELLFIRE_SENTRY         = 17517,
    NPC_VAZRUDEN_HERALD         = 17307,
    NPC_VAZRUDEN                = 17537,
    NPC_NAZAN                   = 17536
};

enum GameobjectIds
{
    GO_FEL_IRON_CHEST_NORMAL    = 185168,
    GO_FEL_IRON_CHECT_HEROIC    = 185169
};

#endif
