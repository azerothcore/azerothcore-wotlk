/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-AGPL
*/

#ifndef DEF_NEXUS_H
#define DEF_NEXUS_H

#include "ScriptPCH.h"

enum eTypes
{
    DATA_MAGUS_TELESTRA_EVENT       = 0,
    DATA_ANOMALUS_EVENT             = 1,
    DATA_ORMOROK_EVENT              = 2,
    DATA_KERISTRASZA_EVENT          = 3,
    DATA_COMMANDER_EVENT            = 4,
    DATA_TELESTRA_ORB               = 5,
    DATA_ANOMALUS_ORB               = 6,
    DATA_ORMOROK_ORB                = 7,
    MAX_ENCOUNTERS                  = 8
};

enum Npcs
{
    NPC_ALLIANCE_RANGER             = 26802,
    NPC_ALLIANCE_BERSERKER          = 26800,
    NPC_ALLIANCE_COMMANDER          = 27949,
    NPC_ALLIANCE_CLERIC             = 26805,
    NPC_HORDE_RANGER                = 26801,
    NPC_HORDE_BERSERKER             = 26799,
    NPC_HORDE_COMMANDER             = 27947,
    NPC_HORDE_CLERIC                = 26803,

    NPC_COMMANDER_STOUTBEARD        = 26796,
    NPC_COMMANDER_KOLURG            = 26798,

    GO_TELESTRA_SPHERE              = 188526,
    GO_ANOMALUS_SPHERE              = 188527,
    GO_ORMOROK_SPHERE               = 188528
};

#endif
