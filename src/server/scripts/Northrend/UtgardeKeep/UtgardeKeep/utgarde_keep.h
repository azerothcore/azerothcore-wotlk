/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_UTGARDE_KEEP_H
#define DEF_UTGARDE_KEEP_H

#include "SpellScript.h"

enum eData
{
    DATA_KELESETH,
    DATA_DALRONN_AND_SKARVALD,
    DATA_INGVAR,
    MAX_ENCOUNTER,
    DATA_FORGE_EVENT_MASK,
    DATA_DALRONN,
    DATA_SKARVALD,
    DATA_ON_THE_ROCKS_ACHIEV,

    DATA_SPECIAL_DRAKE = 50,

    DATA_FORGE_1 = 100,
    DATA_FORGE_2,
    DATA_FORGE_3,

    DATA_UNLOCK_SKARVALD_LOOT = 200,
    DATA_UNLOCK_DALRONN_LOOT,
};

enum eGameObject
{
    GO_BELLOW_1                     = 186688,
    GO_BELLOW_2                     = 186689,
    GO_BELLOW_3                     = 186690,

    GO_FORGEFIRE_1                  = 186692,
    GO_FORGEFIRE_2                  = 186693,
    GO_FORGEFIRE_3                  = 186691,

    GO_GLOWING_ANVIL_1              = 186609,
    GO_GLOWING_ANVIL_2              = 186610,
    GO_GLOWING_ANVIL_3              = 186611,

    GO_GIANT_PORTCULLIS_1           = 186756,
    GO_GIANT_PORTCULLIS_2           = 186694,
};

enum eCreatures
{
    NPC_KELESETH                    = 23953,
    NPC_DALRONN                     = 24201,
    NPC_DALRONN_GHOST               = 27389,
    NPC_SKARVALD                    = 24200,
    NPC_SKARVALD_GHOST              = 27390,
    NPC_INGVAR                      = 23954,

    NPC_DARK_RANGER_MARRAH          = 24137,
    NPC_ENSLAVED_PROTO_DRAKE        = 24083,
};

#endif
