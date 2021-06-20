/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_GUNDRAK_H
#define DEF_GUNDRAK_H

#include "SpellScript.h"

enum Data
{
    DATA_SLAD_RAN                       = 0,
    DATA_MOORABI                        = 1,
    DATA_DRAKKARI_COLOSSUS              = 2,
    DATA_GAL_DARAH                      = 3,
    DATA_ECK_THE_FEROCIOUS_INIT         = 4,
    DATA_ECK_THE_FEROCIOUS              = 5,
    MAX_ENCOUNTERS                      = 6
};

enum Creatures
{
    NPC_ECK_THE_FEROCIOUS               = 29932
};

enum GameObjects
{
    GO_ALTAR_OF_SLAD_RAN                = 192518,
    GO_STATUE_OF_SLAD_RAN               = 192564,
    GO_ALTAR_OF_DRAKKARI                = 192520,
    GO_STATUE_OF_DRAKKARI               = 192567,
    GO_ALTAR_OF_MOORABI                 = 192519,
    GO_STATUE_OF_MOORABI                = 192565,
    GO_STATUE_OF_GAL_DARAH              = 192566,

    GO_GUNDRAK_BRIDGE                   = 193188,
    GO_GUNDRAK_COLLISION                = 192633,

    GO_ECK_DOORS                        = 192632,
    GO_ECK_UNDERWATER_GATE              = 192569,
    GO_GAL_DARAH_DOORS0                 = 192568,
    GO_GAL_DARAH_DOORS1                 = 193208,
    GO_GAL_DARAH_DOORS2                 = 193209
};

#endif
