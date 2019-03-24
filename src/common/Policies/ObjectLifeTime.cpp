/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include <cstdlib>
#include "ObjectLifeTime.h"

namespace ACORE
{
    extern "C" void external_wrapper(void* p)
    {
        std::atexit((void (*)())p);
    }

    void MANGOS_DLL_SPEC at_exit(void (*func)())
    {
        external_wrapper((void*)func);
    }
}