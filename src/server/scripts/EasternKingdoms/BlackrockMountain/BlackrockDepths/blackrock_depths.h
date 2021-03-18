/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DEF_BRD_H
#define DEF_BRD_H

#include "CreatureAIImpl.h"
#define BRDScriptName "instance_blackrock_depths"

enum FactionIds
{
    FACTION_NEUTRAL            = 734,
    FACTION_HOSTILE            = 754,
    FACTION_FRIEND             = 35
};

enum BRDBosses
{
    BOSS_AMBASSADOR_FLAMELASH = 0,
};

enum DataTypes
{
    TYPE_RING_OF_LAW        = 1,
    TYPE_VAULT              = 2,
    TYPE_BAR                = 3,
    TYPE_TOMB_OF_SEVEN      = 4,
    TYPE_LYCEUM             = 5,
    TYPE_IRON_HALL          = 6,

    DATA_EMPEROR            = 10,
    DATA_PHALANX            = 11,

    DATA_ARENA1             = 12,
    DATA_ARENA2             = 13,
    DATA_ARENA3             = 14,
    DATA_ARENA4             = 15,

    DATA_GO_BAR_KEG         = 16,
    DATA_GO_BAR_KEG_TRAP    = 17,
    DATA_GO_BAR_DOOR        = 18,
    DATA_GO_CHALICE         = 19,

    DATA_GHOSTKILL          = 20,
    DATA_EVENSTARTER        = 21,

    DATA_GOLEM_DOOR_N       = 22,
    DATA_GOLEM_DOOR_S       = 23,

    DATA_THRONE_DOOR        = 24,

    DATA_SF_BRAZIER_N       = 25,
    DATA_SF_BRAZIER_S       = 26,
    DATA_MOIRA              = 27,

    DATA_OPEN_COFFER_DOORS  = 30
};

template <class AI, class T>
inline AI* GetBlackrockDepthsAI(T* obj)
{
    return GetInstanceAI<AI>(obj, BRDScriptName);
}

#endif
