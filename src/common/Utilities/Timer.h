/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_TIMER_H
#define ACORE_TIMER_H

#include "ace/OS_NS_sys_time.h"
#include "Common.h"

inline uint32 getMSTime()
{
    static const ACE_Time_Value ApplicationStartTime = ACE_OS::gettimeofday();
    return (ACE_OS::gettimeofday() - ApplicationStartTime).msec();
}

inline uint32 getMSTimeDiff(uint32 oldMSTime, uint32 newMSTime)
{
    // getMSTime() have limited data range and this is case when it overflow in this tick
    if (oldMSTime > newMSTime)
        return (0xFFFFFFFF - oldMSTime) + newMSTime;
    else
        return newMSTime - oldMSTime;
}

inline uint32 GetMSTimeDiffToNow(uint32 oldMSTime)
{
    return getMSTimeDiff(oldMSTime, getMSTime());
}

struct IntervalTimer
{
    public:

        IntervalTimer()
            : _interval(0), _current(0)
        {
        }

        void Update(time_t diff)
        {
            _current += diff;
            if (_current < 0)
                _current = 0;
        }

        bool Passed()
        {
            return _current >= _interval;
        }

        void Reset()
        {
            if (_current >= _interval)
                _current %= _interval;
        }

        void SetCurrent(time_t current)
        {
            _current = current;
        }

        void SetInterval(time_t interval)
        {
            _interval = interval;
        }

        time_t GetInterval() const
        {
            return _interval;
        }

        time_t GetCurrent() const
        {
            return _current;
        }

    private:

        time_t _interval;
        time_t _current;
};

struct TimeTracker
{
    public:

        TimeTracker(time_t expiry)
            : i_expiryTime(expiry)
        {
        }

        void Update(time_t diff)
        {
            i_expiryTime -= diff;
        }

        bool Passed() const
        {
            return i_expiryTime <= 0;
        }

        void Reset(time_t interval)
        {
            i_expiryTime = interval;
        }

        time_t GetExpiry() const
        {
            return i_expiryTime;
        }

    private:

        time_t i_expiryTime;
};

struct TimeTrackerSmall
{
    public:

        TimeTrackerSmall(uint32 expiry = 0)
            : i_expiryTime(expiry)
        {
        }

        void Update(int32 diff)
        {
            i_expiryTime -= diff;
        }

        bool Passed() const
        {
            return i_expiryTime <= 0;
        }

        void Reset(uint32 interval)
        {
            i_expiryTime = interval;
        }

        int32 GetExpiry() const
        {
            return i_expiryTime;
        }

    private:

        int32 i_expiryTime;
};

struct PeriodicTimer
{
    public:

        PeriodicTimer(int32 period, int32 start_time)
            : i_period(period), i_expireTime(start_time)
        {
        }

        bool Update(const uint32 diff)
        {
            if ((i_expireTime -= diff) > 0)
                return false;

            i_expireTime += i_period > int32(diff) ? i_period : diff;
            return true;
        }

        void SetPeriodic(int32 period, int32 start_time)
        {
            i_expireTime = start_time;
            i_period = period;
        }

        // Tracker interface
        void TUpdate(int32 diff) { i_expireTime -= diff; }
        bool TPassed() const { return i_expireTime <= 0; }
        void TReset(int32 diff, int32 period)  { i_expireTime += period > diff ? period : diff; }

    private:

        int32 i_period;
        int32 i_expireTime;
};

#endif
