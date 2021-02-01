/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef BFD_H_
#define BFD_H_

enum Data
{
    TYPE_GELIHAST               = 0,
    TYPE_FIRE1                  = 1,
    TYPE_FIRE2                  = 2,
    TYPE_FIRE3                  = 3,
    TYPE_FIRE4                  = 4,
    TYPE_AKU_MAI                = 5,
    MAX_ENCOUNTERS              = 6
};

enum CreatureIds
{
    NPC_AKU_MAI_SNAPJAW                                    = 4825,
    NPC_MURKSHALLOW_SOFTSHELL                              = 4977,
    NPC_AKU_MAI_SERVANT                                    = 4978,
    NPC_BARBED_CRUSTACEAN                                  = 4823
};

enum GameObjectIds
{
    GO_SHRINE_OF_GELIHAST                                  = 103015,
    GO_FIRE_OF_AKU_MAI_1                                   = 21118,
    GO_FIRE_OF_AKU_MAI_2                                   = 21119,
    GO_FIRE_OF_AKU_MAI_3                                   = 21120,
    GO_FIRE_OF_AKU_MAI_4                                   = 21121,
    GO_AKU_MAI_DOOR                                        = 21117,
    GO_ALTAR_OF_THE_DEEPS                                  = 103016
};

#endif
