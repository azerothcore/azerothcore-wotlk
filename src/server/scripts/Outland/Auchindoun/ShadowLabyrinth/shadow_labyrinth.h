/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef DEF_SHADOW_LABYRINTH_H
#define DEF_SHADOW_LABYRINTH_H

#include "SpellScript.h"
#include "CreatureAI.h"
#include "GridNotifiers.h"

enum slData
{
    TYPE_OVERSEER                   = 0,
    TYPE_HELLMAW                    = 1,
    DATA_BLACKHEARTTHEINCITEREVENT  = 2,
    DATA_GRANDMASTERVORPILEVENT     = 3,
    DATA_MURMUREVENT                = 4,
    MAX_ENCOUNTER                   = 5
};

enum slNPCandGO
{
    NPC_FEL_OVERSEER            = 18796,
    NPC_HELLMAW                 = 18731,

    REFECTORY_DOOR              = 183296,                     //door opened when blackheart the inciter dies
    SCREAMING_HALL_DOOR         = 183295                      //door opened when grandmaster vorpil dies
};

#endif

