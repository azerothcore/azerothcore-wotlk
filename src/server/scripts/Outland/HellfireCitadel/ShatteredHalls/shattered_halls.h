/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_SHATTERED_H
#define DEF_SHATTERED_H

#include "SpellScript.h"
#include "PassiveAI.h"

enum DataTypes
{
    DATA_NETHEKURSE                 = 0,
    DATA_OMROGG                     = 1,
    DATA_KARGATH                    = 2,
    ENCOUNTER_COUNT                 = 3,

    DATA_ENTERED_ROOM               = 10,
    DATA_PRISONER_1                 = 11,
    DATA_PRISONER_2                 = 12,
    DATA_PRISONER_3                 = 13,
    DATA_EXECUTIONER                = 14
};

enum CreatureIds
{
    NPC_GRAND_WARLOCK_NETHEKURSE    = 16807,
    NPC_WARCHIEF_KARGATH            = 16808,
    NPC_FEL_ORC_CONVERT             = 17083,

    // Trial of the Naaru: Mercy
    NPC_SHATTERED_EXECUTIONER       = 17301,
    NPC_RIFLEMAN_BROWNBEARD         = 17289,
    NPC_CAPTAIN_ALINA               = 17290,
    NPC_PRIVATE_JACINT              = 17292,
    NPC_KORAG_PROUDMANE             = 17295,
    NPC_CAPTAIN_BONESHATTER         = 17296,
    NPC_SCOUT_ORGARR                = 17297,
};

enum GameobjectIds
{
    GO_GRAND_WARLOCK_CHAMBER_DOOR_1 = 182539,
    GO_GRAND_WARLOCK_CHAMBER_DOOR_2 = 182540
};

enum SpellIds
{
    SPELL_KARGATHS_EXECUTIONER_1    = 39288,
    SPELL_KARGATHS_EXECUTIONER_2    = 39289,
    SPELL_KARGATHS_EXECUTIONER_3    = 39290
};

#endif
