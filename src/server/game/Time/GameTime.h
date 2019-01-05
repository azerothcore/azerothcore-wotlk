/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */
 
#ifndef __GAMETIME_H
#define __GAMETIME_H

#include "Define.h"

#include <chrono>

namespace GameTime
{
    // Server start time
    time_t GetStartTime();

    // Current server time (unix) in seconds
    time_t GetGameTime();

    // Milliseconds since server start
    uint32 GetGameTimeMS();

    /// Current chrono system_clock time point
    std::chrono::system_clock::time_point GetGameTimeSystemPoint();

    /// Current chrono steady_clock time point
    std::chrono::steady_clock::time_point GetGameTimeSteadyPoint();

    /// Uptime (in secs)
    uint32 GetUptime();

    void UpdateGameTimers();
};

#endif