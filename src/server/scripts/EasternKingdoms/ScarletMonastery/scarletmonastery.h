/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef DEF_SCARLETMONANSTERY_H
#define DEF_SCARLETMONANSTERY_H

#include "CreatureAIImpl.h"

#define ScarletMonasteryScriptName "instance_scarlet_monastery"

template <class AI, class T>
inline AI* GetScarletMonasteryAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ScarletMonasteryScriptName);
}

#endif
