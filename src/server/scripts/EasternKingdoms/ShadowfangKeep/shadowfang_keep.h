/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_SHADOWFANG_H
#define DEF_SHADOWFANG_H

#include "SpellAuraEffects.h"
#include "SpellScript.h"

enum DataTypes
{
    TYPE_COURTYARD              = 0,
    TYPE_FENRUS_THE_DEVOURER    = 1,
    TYPE_WOLF_MASTER_NANDOS     = 2,
    MAX_ENCOUNTERS              = 3
};

enum GameObjects
{
    GO_COURTYARD_DOOR           = 18895,
    GO_SORCERER_DOOR            = 18972,
    GO_ARUGAL_DOOR              = 18971
};

#endif
