/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef GRUULS_LAIR_H_
#define GRUULS_LAIR_H_

#include "CreatureAI.h"
#include "CreatureAIImpl.h"
#include "SpellAuraEffects.h"

#define GruulsLairScriptName "instance_gruuls_lair"

enum DataTypes
{
    DATA_MAULGAR                = 0,
    DATA_GRUUL                  = 1,
    MAX_ENCOUNTER               = 2,

    DATA_ADDS_KILLED            = 10,
    MAX_ADD_NUMBER              = 4
};

enum CreatureIds
{
    NPC_MAULGAR                 = 18831,
    NPC_KROSH_FIREHAND          = 18832,
    NPC_OLM_THE_SUMMONER        = 18834,
    NPC_KIGGLER_THE_CRAZED      = 18835,
    NPC_BLINDEYE_THE_SEER       = 18836
};

enum GameObjectIds
{
    GO_MAULGAR_DOOR             = 184468,
    GO_GRUUL_DOOR               = 184662
};

template <class AI, class T>
inline AI* GetGruulsLairAI(T* obj)
{
    return GetInstanceAI<AI>(obj, GruulsLairScriptName);
}

#endif // GRUULS_LAIR_H_
