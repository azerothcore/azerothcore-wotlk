/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "LogCommon.h"
#include "Define.h"
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
AC_API_EXPORT std::size_t EnumUtils<LogLevel>::Count() { return 7; }

template <>
AC_API_EXPORT LogLevel EnumUtils<LogLevel>::FromIndex(std::size_t index)
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
AC_API_EXPORT std::size_t EnumUtils<LogLevel>::ToIndex(LogLevel value)
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
AC_API_EXPORT std::size_t EnumUtils<AppenderType>::Count() { return 4; }

template <>
AC_API_EXPORT AppenderType EnumUtils<AppenderType>::FromIndex(std::size_t index)
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
AC_API_EXPORT std::size_t EnumUtils<AppenderType>::ToIndex(AppenderType value)
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

/*****************************************************************\
|* data for enum 'AppenderFlags' in 'LogCommon.h' auto-generated *|
\*****************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<AppenderFlags>::ToString(AppenderFlags value)
{
    switch (value)
    {
        case APPENDER_FLAGS_NONE: return { "APPENDER_FLAGS_NONE", "APPENDER_FLAGS_NONE", "" };
        case APPENDER_FLAGS_PREFIX_TIMESTAMP: return { "APPENDER_FLAGS_PREFIX_TIMESTAMP", "APPENDER_FLAGS_PREFIX_TIMESTAMP", "" };
        case APPENDER_FLAGS_PREFIX_LOGLEVEL: return { "APPENDER_FLAGS_PREFIX_LOGLEVEL", "APPENDER_FLAGS_PREFIX_LOGLEVEL", "" };
        case APPENDER_FLAGS_PREFIX_LOGFILTERTYPE: return { "APPENDER_FLAGS_PREFIX_LOGFILTERTYPE", "APPENDER_FLAGS_PREFIX_LOGFILTERTYPE", "" };
        case APPENDER_FLAGS_USE_TIMESTAMP: return { "APPENDER_FLAGS_USE_TIMESTAMP", "APPENDER_FLAGS_USE_TIMESTAMP", "" };
        case APPENDER_FLAGS_MAKE_FILE_BACKUP: return { "APPENDER_FLAGS_MAKE_FILE_BACKUP", "APPENDER_FLAGS_MAKE_FILE_BACKUP", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT std::size_t EnumUtils<AppenderFlags>::Count() { return 6; }

template <>
AC_API_EXPORT AppenderFlags EnumUtils<AppenderFlags>::FromIndex(std::size_t index)
{
    switch (index)
    {
        case 0: return APPENDER_FLAGS_NONE;
        case 1: return APPENDER_FLAGS_PREFIX_TIMESTAMP;
        case 2: return APPENDER_FLAGS_PREFIX_LOGLEVEL;
        case 3: return APPENDER_FLAGS_PREFIX_LOGFILTERTYPE;
        case 4: return APPENDER_FLAGS_USE_TIMESTAMP;
        case 5: return APPENDER_FLAGS_MAKE_FILE_BACKUP;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT std::size_t EnumUtils<AppenderFlags>::ToIndex(AppenderFlags value)
{
    switch (value)
    {
        case APPENDER_FLAGS_NONE: return 0;
        case APPENDER_FLAGS_PREFIX_TIMESTAMP: return 1;
        case APPENDER_FLAGS_PREFIX_LOGLEVEL: return 2;
        case APPENDER_FLAGS_PREFIX_LOGFILTERTYPE: return 3;
        case APPENDER_FLAGS_USE_TIMESTAMP: return 4;
        case APPENDER_FLAGS_MAKE_FILE_BACKUP: return 5;
        default: throw std::out_of_range("value");
    }
}
}
