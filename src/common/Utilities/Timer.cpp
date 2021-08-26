/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "Timer.h"
#include "StringFormat.h"
#include <iomanip>
#include <sstream>

namespace Acore::TimeDiff
{
    constexpr uint64 MILLISECONDS = 1000;
    constexpr uint64 SECONDS      = 1000 * MILLISECONDS;
    constexpr uint64 MINUTES      = 60 * SECONDS;
    constexpr uint64 HOURS        = 60 * MINUTES;
    constexpr uint64 DAYS         = 24 * HOURS;
}

template<>
AC_COMMON_API uint32 Acore::Time::TimeStringTo<Seconds>(std::string_view timestring)
{
    uint32 secs = 0;
    uint32 buffer = 0;
    uint32 multiplier = 0;

    for (char itr : timestring)
    {
        if (isdigit(itr))
        {
            buffer *= 10;
            buffer += itr - '0';
        }
        else
        {
            switch (itr)
            {
            case 'd':
                multiplier = DAY;
                break;
            case 'h':
                multiplier = HOUR;
                break;
            case 'm':
                multiplier = MINUTE;
                break;
            case 's':
                multiplier = 1;
                break;
            default:
                return 0; // bad format
            }

            buffer *= multiplier;
            secs += buffer;
            buffer = 0;
        }
    }

    return secs;
}

template<>
AC_COMMON_API std::string Acore::Time::ToTimeString<Microseconds>(uint64 durationTime, TimeOutput timeOutput /*= TimeOutput::Seconds*/, TimeFormat timeFormat /*= TimeFormat::ShortText*/)
{
    uint64 microsecs = durationTime % 1000;
    uint64 millisecs = (durationTime / TimeDiff::MILLISECONDS) % 1000;
    uint64 secs      = (durationTime / TimeDiff::SECONDS) % 60;
    uint64 minutes   = (durationTime / TimeDiff::MINUTES) % 60;
    uint64 hours     = (durationTime / TimeDiff::HOURS) % 24;
    uint64 days      = durationTime / TimeDiff::DAYS;

    if (timeFormat == TimeFormat::Numeric)
    {
        if (days)
        {
            return Acore::StringFormatFmt("{}:{:02}:{:02}:{:02}:{:02}", days, hours, minutes, secs, millisecs);
        }
        else if (hours)
        {
            return Acore::StringFormatFmt("{}:{:02}:{:02}:{:02}", hours, minutes, secs, millisecs);
        }
        else if (minutes)
        {
            return Acore::StringFormatFmt("{}:{:02}:{:02}", minutes, secs, millisecs);
        }
        else if (secs)
        {
            return Acore::StringFormatFmt("{}:{:02}", secs, millisecs);
        }
        else // millisecs
        {
            return Acore::StringFormatFmt("{}", millisecs);
        }
    }

    std::ostringstream ss;
    std::string stringTime;

    auto GetStringFormat = [&](uint32 timeType, std::string_view shortText, std::string_view fullText1, std::string_view fullText)
    {
        ss << timeType;

        switch (timeFormat)
        {
            case TimeFormat::ShortText:
                ss << shortText;
                break;
            case TimeFormat::FullText:
                ss << (timeType == 1 ? fullText1 : fullText);
                break;
            default:
                ss << "<Unknown time format>";
        }
    };

    if (days)
    {
        GetStringFormat(days, "d ", " Day ", " Days ");
    }

    if (timeOutput == TimeOutput::Days)
    {
        stringTime = ss.str();
    }

    if (hours)
    {
        GetStringFormat(hours, "h ", " Hour ", " Hours ");
    }

    if (timeOutput == TimeOutput::Hours)
    {
        stringTime = ss.str();
    }

    if (minutes)
    {
        GetStringFormat(minutes, "m ", " Minute ", " Minutes ");
    }

    if (timeOutput == TimeOutput::Minutes)
    {
        stringTime = ss.str();
    }

    if (secs)
    {
        GetStringFormat(secs, "s ", " Second ", " Seconds ");
    }

    if (timeOutput == TimeOutput::Seconds)
    {
        stringTime = ss.str();
    }

    if (millisecs)
    {
        GetStringFormat(millisecs, "ms ", " Millisecond ", " Milliseconds ");
    }

    if (timeOutput == TimeOutput::Milliseconds)
    {
        stringTime = ss.str();
    }

    if (microsecs)
    {
        GetStringFormat(microsecs, "us ", " Microsecond ", " Microseconds ");
    }

    if (timeOutput == TimeOutput::Microseconds)
    {
        stringTime = ss.str();
    }

    return Acore::String::TrimRightInPlace(stringTime);
}

template<>
AC_COMMON_API std::string Acore::Time::ToTimeString<Milliseconds>(uint64 durationTime, TimeOutput timeOutput /*= TimeOutput::Seconds*/, TimeFormat timeFormat /*= TimeFormat::ShortText*/)
{
    return ToTimeString<Microseconds>(durationTime * TimeDiff::MILLISECONDS, timeOutput, timeFormat);
}

template<>
AC_COMMON_API std::string Acore::Time::ToTimeString<Seconds>(uint64 durationTime, TimeOutput timeOutput /*= TimeOutput::Seconds*/, TimeFormat timeFormat /*= TimeFormat::ShortText*/)
{
    return ToTimeString<Microseconds>(durationTime * TimeDiff::SECONDS, timeOutput, timeFormat);
}

template<>
AC_COMMON_API std::string Acore::Time::ToTimeString<Minutes>(uint64 durationTime, TimeOutput timeOutput /*= TimeOutput::Seconds*/, TimeFormat timeFormat /*= TimeFormat::ShortText*/)
{
    return ToTimeString<Microseconds>(durationTime * TimeDiff::MINUTES, timeOutput, timeFormat);
}

template<>
AC_COMMON_API std::string Acore::Time::ToTimeString<Seconds>(std::string_view durationTime, TimeOutput timeOutput /*= TimeOutput::Seconds*/, TimeFormat timeFormat /*= TimeFormat::ShortText*/)
{
    return ToTimeString<Seconds>(TimeStringTo<Seconds>(durationTime), timeOutput, timeFormat);
}

std::string Acore::Time::ToTimeString(Microseconds durationTime, TimeOutput timeOutput /*= TimeOutput::Seconds*/, TimeFormat timeFormat /*= TimeFormat::ShortText*/)
{
    return ToTimeString<Microseconds>(durationTime.count(), timeOutput, timeFormat);
}

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
struct tm* localtime_r(time_t const* time, struct tm* result)
{
    localtime_s(result, time);
    return result;
}
#endif

tm Acore::Time::TimeBreakdown(time_t time)
{
    tm timeLocal;
    localtime_r(&time, &timeLocal);
    return timeLocal;
}

time_t Acore::Time::LocalTimeToUTCTime(time_t time)
{
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    return time + _timezone;
#else
    return time + timezone;
#endif
}

time_t Acore::Time::GetLocalHourTimestamp(time_t time, uint8 hour, bool onlyAfterTime)
{
    tm timeLocal = TimeBreakdown(time);
    timeLocal.tm_hour = 0;
    timeLocal.tm_min = 0;
    timeLocal.tm_sec = 0;

    time_t midnightLocal = mktime(&timeLocal);
    time_t hourLocal = midnightLocal + hour * HOUR;

    if (onlyAfterTime && hourLocal <= time)
    {
        hourLocal += DAY;
    }

    return hourLocal;
}

std::string Acore::Time::TimeToTimestampStr(time_t t)
{
    std::stringstream ss;
    ss << std::put_time(std::localtime(&t), "%Y-%m-%d %X");
    return ss.str();
}

std::string Acore::Time::TimeToHumanReadable(time_t t)
{
    std::stringstream ss;
    ss << std::put_time(std::localtime(&t), "%a %b %d %Y %X");
    return ss.str();
}
