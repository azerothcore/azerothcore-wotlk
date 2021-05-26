/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
 */

#ifndef AUCHENAI_CRYPTS_H_
#define AUCHENAI_CRYPTS_H_

#include "CreatureAIImpl.h"

#define ACScriptName "instance_auchenai_crypts"
#define DataHeader   "AC"

uint32 const EncounterCount = 2;

enum ACDataTypes
{
    // Encounter States/Boss GUIDs
    DATA_SHIRRAK_THE_DEAD_WATCHER   = 0,
    DATA_EXARCH_MALADAAR            = 1
};

template <class AI, class T>
inline AI* GetAuchenaiCryptsAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ACScriptName);
}

#endif // AUCHENAI_CRYPTS_H_
