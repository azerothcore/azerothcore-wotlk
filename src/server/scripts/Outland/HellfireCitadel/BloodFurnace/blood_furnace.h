/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_BLOOD_FURNACE_H
#define DEF_BLOOD_FURNACE_H

#include "Player.h"

enum bloodFurnace
{
    DATA_THE_MAKER                      = 0,
    DATA_BROGGOK                        = 1,
    DATA_KELIDAN                        = 2,
    MAX_ENCOUNTER                       = 3,

    DATA_DOOR1                          = 10,
    DATA_DOOR2                          = 11,
    DATA_DOOR3                          = 12,
    DATA_DOOR4                          = 13,
    DATA_DOOR5                          = 14,
    DATA_DOOR6                          = 15,

    DATA_PRISON_CELL1                   = 20,
    DATA_PRISON_CELL2                   = 21,
    DATA_PRISON_CELL3                   = 22,
    DATA_PRISON_CELL4                   = 23,

    ACTION_ACTIVATE_BROGGOK             = 30,
    ACTION_PREPARE_BROGGOK              = 31
};

enum bloodFurnaceNPC
{
    NPC_THE_MAKER                       = 17381,
    NPC_BROGGOK                         = 17380,
    NPC_KELIDAN                         = 17377,
    NPC_NASCENT_FEL_ORC                 = 17398,
    NPC_CHANNELER                       = 17653
};

#endif

