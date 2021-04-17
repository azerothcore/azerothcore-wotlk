/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
 */

#ifndef SLAVE_PENS_H
#define SLAVE_PENS_H

#include "CreatureAIImpl.h"

uint32 const EncounterCount               = 3;

#define SPScriptName "instance_the_slave_pens"
#define DataHeader "SP"

enum SPDataTypes
{
    DATA_MENNU_THE_BETRAYER               = 1,
    DATA_ROKMAR_THE_CRACKLER              = 2,
    DATA_QUAGMIRRAN                       = 3,
    DATA_AHUNE                            = 4,
    DATA_AHUNE_BUNNY                      = 5,
    DATA_FROZEN_CORE                      = 6,
    DATA_FLAMECALLER_000                  = 7,
    DATA_FLAMECALLER_001                  = 8,
    DATA_FLAMECALLER_002                  = 9,
    DATA_BONFIRE_BUNNY_000                = 10,
    DATA_BONFIRE_BUNNY_001                = 11,
    DATA_BONFIRE_BUNNY_002                = 12,
    DATA_BEAM_BUNNY_000                   = 13,
    DATA_BEAM_BUNNY_001                   = 14,
    DATA_BEAM_BUNNY_002                   = 15,
    DATA_LUMA_SKYMOTHER                   = 16
};

enum SPCreaturesIds
{
    NPC_AHUNE                            = 25740,
    NPC_FROZEN_CORE                      = 25865,
    NPC_AHUNE_SUMMON_LOC_BUNNY           = 25745,
    NPC_TOTEM                            = 25961,
    NPC_TOTEM_BUNNY_1                    = 25971,
    NPC_TOTEM_BUNNY_2                    = 25972,
    NPC_TOTEM_BUNNY_3                    = 25973,
    NPC_LUMA_SKYMOTHER                   = 25697,
    NPC_AHUNE_LOC_BUNNY                  = 25745,
    NPC_EARTHEN_RING_FLAMECALLER         = 25754,
    NPC_SHAMAN_BONFIRE_BUNNY_000         = 25971,
    NPC_SHAMAN_BONFIRE_BUNNY_001         = 25972,
    NPC_SHAMAN_BONFIRE_BUNNY_002         = 25973,
    NPC_SHAMAN_BEAM_BUNNY_000            = 25964,
    NPC_SHAMAN_BEAM_BUNNY_001            = 25965,
    NPC_SHAMAN_BEAM_BUNNY_002            = 25966,
    NPC_WHISP_DEST_BUNNY                 = 26120,
    NPC_WHISP_SOURCE_BUNNY               = 26121
};

enum SPGameObjectIds
{
    GO_ICE_SPEAR                         = 188077,
    GO_ICE_STONE                         = 187882
};

template <class AI, class T>
inline AI* GetTheSlavePensAI(T* obj)
{
    return GetInstanceAI<AI>(obj, SPScriptName);
}

#endif // SLAVE_PENS_H
