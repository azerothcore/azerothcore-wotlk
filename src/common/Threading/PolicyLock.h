/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#ifndef POLICYLOCK_H
#define POLICYLOCK_H

#include <mutex>

#define RETURN_GUARD(mutex, retval) if (!mutex.try_lock())    \
                                        return retval;        \
                                    std::lock_guard<decltype(mutex)> guard(mutex, std::adopt_lock)

#endif
