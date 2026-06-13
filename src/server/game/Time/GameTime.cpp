/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "GameTime.h"
#include "Timer.h"

namespace GameTime
{
    using namespace std::chrono;

    Seconds const StartTime = GetEpochTime();

    Seconds GameTime = GetEpochTime();
    Milliseconds GameMSTime = 0ms;

    SystemTimePoint GameTimeSystemPoint = SystemTimePoint::min();
    TimePoint GameTimeSteadyPoint = TimePoint::min();

    Seconds GetStartTime()
    {
        return StartTime;
    }

    Seconds GetGameTime()
    {
        return GameTime;
    }

    Milliseconds GetGameTimeMS()
    {
        return GameMSTime;
    }

    SystemTimePoint GetSystemTime()
    {
        return GameTimeSystemPoint;
    }

    TimePoint Now()
    {
        return GameTimeSteadyPoint;
    }

    Seconds GetUptime()
    {
        return GameTime - StartTime;
    }

    void UpdateGameTimers()
    {
        GameTime = GetEpochTime();
        GameMSTime = GetTimeMS();
        GameTimeSystemPoint = system_clock::now();
        GameTimeSteadyPoint = steady_clock::now();
    }
}
