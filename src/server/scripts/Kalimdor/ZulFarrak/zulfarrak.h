/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_ZULFARRACK_H
#define DEF_ZULFARRACK_H

#include "CreatureAIImpl.h"
#include "CellImpl.h"
#include "SpellScript.h"

#define ZFScriptName "instance_zulfarrak"

enum ZulFarrakCreatures
{
    NPC_SANDFURY_CRETIN         = 7789,
    NPC_SANDFURY_SLAVE          = 7787,
    NPC_SANDFURY_ACOLYTE        = 8876,
    NPC_SANDFURY_DRUDGE         = 7788,
    NPC_SANDFURY_ZEALOT         = 8877,
    NPC_SHADOWPRIEST_SEZZZIZ    = 7275,
    NPC_NEKRUM_GUTCHEWER        = 7796,

    NPC_BLY                     = 7604,
    NPC_RAVEN                   = 7605,
    NPC_ORO                     = 7606,
    NPC_WEEGLI                  = 7607,
    NPC_MURTA                   = 7608
};

enum ZulFarrakGameobjects
{
    GO_END_DOOR                 = 146084
};

enum ZulFarrakData
{
    DATA_PYRAMID                = 0,
    DATA_GAHZRILLA              = 1
};

enum ZFPyramidPhases
{
    PYRAMID_NOT_STARTED, //default
    PYRAMID_CAGES_OPEN, //happens in GO hello for cages
    PYRAMID_ARRIVED_AT_STAIR, //happens in Weegli's movementinform
    PYRAMID_WAVE_1,
    PYRAMID_PRE_WAVE_2,
    PYRAMID_WAVE_2,
    PYRAMID_PRE_WAVE_3,
    PYRAMID_WAVE_3,
    PYRAMID_KILLED_ALL_TROLLS,
    PYRAMID_MOVED_DOWNSTAIRS,
    PYRAMID_DESTROY_GATES,
    PYRAMID_DONE
};

template <class AI, class T>
inline AI* GetZulFarrakAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ZFScriptName);
}

#endif
