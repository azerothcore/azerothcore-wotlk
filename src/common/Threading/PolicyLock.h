/*
* Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
* Copyright (C) 2015  CMaNGOS <www.cmangos.net>
*/

#ifndef POLICYLOCK_H
#define POLICYLOCK_H

#include <mutex>

#define GUARD_RETURN(mutex, retval) if (!mutex.try_lock())    \
                                        return retval;        \
                                    std::lock_guard<decltype(mutex)> guard(mutex, std::adopt_lock)

#endif
