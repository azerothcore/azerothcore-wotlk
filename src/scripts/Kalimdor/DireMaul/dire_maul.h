/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-AGPL
*/

#ifndef DEF_DIRE_MAUL_H
#define DEF_DIRE_MAUL_H

#include "ScriptPCH.h"

enum DataTypes
{
    TYPE_EAST_WING_PROGRESS         = 0,
    TYPE_WEST_WING_PROGRESS         = 1,
    TYPE_PYLONS_STATE               = 2,
    TYPE_NORTH_WING_PROGRESS        = 3,
    TYPE_NORTH_WING_BOSSES          = 4,

    ALL_PYLONS_OFF                  = 0x1F
};

enum GoIds
{
    GO_DIRE_MAUL_FORCE_FIELD        = 179503,
    GO_GORDOK_TRIBUTE               = 179564
};

enum NpcIds
{
    NPC_IMMOL_THAR                  = 11496,
    NPC_HIGHBORNE_SUMMONER          = 11466
};

#endif
