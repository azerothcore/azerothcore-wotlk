/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_OBJECTLIFETIME_H
#define ACORE_OBJECTLIFETIME_H

#include <stdexcept>
#include "Define.h"

typedef void (* Destroyer)(void);

namespace ACORE
{
    void ACORE_DLL_SPEC at_exit(void (*func)());

    template<class T>
    class ObjectLifeTime
    {
        public:

            static void ScheduleCall(void (*destroyer)())
            {
                at_exit(destroyer);
            }

            DECLSPEC_NORETURN static void OnDeadReference() ATTR_NORETURN;
    };

    template <class T>
    void ObjectLifeTime<T>::OnDeadReference()           // We don't handle Dead Reference for now
    {
        throw std::runtime_error("Dead Reference");
    }
}

#endif