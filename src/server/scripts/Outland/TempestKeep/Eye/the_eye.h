/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_THE_EYE_H
#define DEF_THE_EYE_H

#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Player.h"
#include "GridNotifiers.h"

enum EyeData
{
    DATA_ALAR               = 0,
    DATA_ASTROMANCER        = 1,
    DATA_REAVER             = 2,
    DATA_KAELTHAS           = 3,
    MAX_ENCOUNTER           = 4,

    DATA_KAEL_ADVISOR1      = 10,
    DATA_KAEL_ADVISOR2      = 11,
    DATA_KAEL_ADVISOR3      = 12,
    DATA_KAEL_ADVISOR4      = 13
};

enum EyeNPCs
{
    NPC_ALAR                = 19514,
    NPC_KAELTHAS            = 19622,
    NPC_THALADRED           = 20064,
    NPC_LORD_SANGUINAR      = 20060,
    NPC_CAPERNIAN           = 20062,
    NPC_TELONICUS           = 20063
};

enum EyeGOs
{
    GO_BRIDGE_WINDOW        = 184069,
    GO_KAEL_STATUE_RIGHT    = 184596,
    GO_KAEL_STATUE_LEFT     = 184597
};

#endif
