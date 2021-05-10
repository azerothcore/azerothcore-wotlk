/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
 */

#ifndef the_underbog_h__
#define the_underbog_h__

#include "CreatureAIImpl.h"

#define TheUnderbogScriptName "instance_the_underbog"

template <class AI, class T>
inline AI* GetTheUnderbogAI(T* obj)
{
    return GetInstanceAI<AI>(obj, TheUnderbogScriptName);
}

#endif // the_underbog_h__
