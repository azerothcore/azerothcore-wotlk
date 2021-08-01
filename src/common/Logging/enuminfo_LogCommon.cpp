/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "Define.h"
#include "LogCommon.h"
#include "SmartEnum.h"
#include <stdexcept>

namespace Acore::Impl::EnumUtilsImpl
{

/************************************************************\
|* data for enum 'LogLevel' in 'LogCommon.h' auto-generated *|
\************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<LogLevel>::ToString(LogLevel value)
{
    switch (value)
    {
        case LOG_LEVEL_DISABLED: return { "LOG_LEVEL_DISABLED", "LOG_LEVEL_DISABLED", "" };
        case LOG_LEVEL_FATAL: return { "LOG_LEVEL_FATAL", "LOG_LEVEL_FATAL", "" };
        case LOG_LEVEL_ERROR: return { "LOG_LEVEL_ERROR", "LOG_LEVEL_ERROR", "" };
        case LOG_LEVEL_WARN: return { "LOG_LEVEL_WARN", "LOG_LEVEL_WARN", "" };
        case LOG_LEVEL_INFO: return { "LOG_LEVEL_INFO", "LOG_LEVEL_INFO", "" };
        case LOG_LEVEL_DEBUG: return { "LOG_LEVEL_DEBUG", "LOG_LEVEL_DEBUG", "" };
        case LOG_LEVEL_TRACE: return { "LOG_LEVEL_TRACE", "LOG_LEVEL_TRACE", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<LogLevel>::Count() { return 7; }

template <>
AC_API_EXPORT LogLevel EnumUtils<LogLevel>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return LOG_LEVEL_DISABLED;
        case 1: return LOG_LEVEL_FATAL;
        case 2: return LOG_LEVEL_ERROR;
        case 3: return LOG_LEVEL_WARN;
        case 4: return LOG_LEVEL_INFO;
        case 5: return LOG_LEVEL_DEBUG;
        case 6: return LOG_LEVEL_TRACE;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<LogLevel>::ToIndex(LogLevel value)
{
    switch (value)
    {
        case LOG_LEVEL_DISABLED: return 0;
        case LOG_LEVEL_FATAL: return 1;
        case LOG_LEVEL_ERROR: return 2;
        case LOG_LEVEL_WARN: return 3;
        case LOG_LEVEL_INFO: return 4;
        case LOG_LEVEL_DEBUG: return 5;
        case LOG_LEVEL_TRACE: return 6;
        default: throw std::out_of_range("value");
    }
}

/****************************************************************\
|* data for enum 'AppenderType' in 'LogCommon.h' auto-generated *|
\****************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<AppenderType>::ToString(AppenderType value)
{
    switch (value)
    {
        case APPENDER_NONE: return { "APPENDER_NONE", "APPENDER_NONE", "" };
        case APPENDER_CONSOLE: return { "APPENDER_CONSOLE", "APPENDER_CONSOLE", "" };
        case APPENDER_FILE: return { "APPENDER_FILE", "APPENDER_FILE", "" };
        case APPENDER_DB: return { "APPENDER_DB", "APPENDER_DB", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<AppenderType>::Count() { return 4; }

template <>
AC_API_EXPORT AppenderType EnumUtils<AppenderType>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return APPENDER_NONE;
        case 1: return APPENDER_CONSOLE;
        case 2: return APPENDER_FILE;
        case 3: return APPENDER_DB;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<AppenderType>::ToIndex(AppenderType value)
{
    switch (value)
    {
        case APPENDER_NONE: return 0;
        case APPENDER_CONSOLE: return 1;
        case APPENDER_FILE: return 2;
        case APPENDER_DB: return 3;
        default: throw std::out_of_range("value");
    }
}
}
