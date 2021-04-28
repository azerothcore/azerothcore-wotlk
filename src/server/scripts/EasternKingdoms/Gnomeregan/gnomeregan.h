/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef DEF_GNOMEREGAN_H
#define DEF_GNOMEREGAN_H

#include "CreatureAIImpl.h"

#define GnomereganScriptName "instance_gnomeregan"

template <class AI, class T>
inline AI* GetGnomereganAI(T* obj)
{
    return GetInstanceAI<AI>(obj, GnomereganScriptName);
}

#endif
