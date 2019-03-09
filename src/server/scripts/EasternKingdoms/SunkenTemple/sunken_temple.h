/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_SUNKEN_TEMPLE_H
#define DEF_SUNKEN_TEMPLE_H

enum DataTypes
{
    DATA_STATUES                = 10,
    DATA_DEFENDER_KILLED        = 11,
    DATA_ERANIKUS_FIGHT         = 12,
    MAX_STATUE_PHASE            = 6,
    DEFENDERS_COUNT             = 6,

    TYPE_ATAL_ALARION           = 0,
    TYPE_JAMMAL_AN              = 1,
    TYPE_HAKKAR_EVENT           = 2,
    MAX_ENCOUNTERS              = 3
};

enum GoIds
{
    GO_ATALAI_STATUE1           = 148830,
    GO_ATALAI_STATUE2           = 148831,
    GO_ATALAI_STATUE3           = 148832,
    GO_ATALAI_STATUE4           = 148833,
    GO_ATALAI_STATUE5           = 148834,
    GO_ATALAI_STATUE6           = 148835,
    GO_ATALAI_IDOL              = 148836,
    GO_IDOL_OF_HAKKAR           = 148838,
    GO_ATALAI_LIGHT2            = 148937,
    GO_FORCEFIELD               = 149431
};

enum CreatureIds
{
    NPC_MALFURION_STORMRAGE     = 15362,
    NPC_JAMMAL_AN_THE_PROPHET   = 5710,
    NPC_SHADE_OF_ERANIKUS       = 5709,
    NPC_SHADE_OF_HAKKAR         = 8440,
};

enum SpellIds
{
    HEX_OF_JAMMAL_AN            = 12480,
    HEX_OF_JAMMAL_AN_CHARM      = 12483
};

#endif
