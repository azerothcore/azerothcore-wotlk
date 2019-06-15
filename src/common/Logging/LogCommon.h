/*
 * Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _LOG_COMMON_
#define _LOG_COMMON_

enum ColorTypes : uint8
{
    BLACK,
    RED,
    GREEN,
    BROWN,
    BLUE,
    MAGENTA,
    CYAN,
    GREY,
    YELLOW,
    LRED,
    LGREEN,
    LBLUE,
    LMAGENTA,
    LCYAN,
    WHITE,

    COLOR_TYPE_END
};

enum LogLevel
{
    LOG_LEVEL_DISABLED,
    LOG_LEVEL_FATAL,
    LOG_LEVEL_CRITICAL,
    LOG_LEVEL_ERROR,
    LOG_LEVEL_WARNING,
    LOG_LEVEL_NOTICE,
    LOG_LEVEL_INFO,
    LOG_LEVEL_DEBUG,
    LOG_LEVEL_TRACE,

    LOG_LEVEL_MAX
};

enum AppenderType : uint8
{
    APPENDER_NONE,
    APPENDER_CONSOLE,
    APPENDER_FILE,
    APPENDER_DB
};

enum AppenderFlags
{
    APPENDER_FLAGS_NONE                          = 0x00,
    APPENDER_FLAGS_PREFIX_TIMESTAMP              = 0x01,
    APPENDER_FLAGS_PREFIX_LOGLEVEL               = 0x02,
    APPENDER_FLAGS_PREFIX_LOGFILTERTYPE          = 0x04,
    APPENDER_FLAGS_USE_TIMESTAMP                 = 0x08,
    APPENDER_FLAGS_MAKE_FILE_BACKUP              = 0x10
};

// For create LogChannel
enum ChannelOptions : uint8
{
    CHANNEL_OPTIONS_TYPE,
    CHANNEL_OPTIONS_TIMES,
    CHANNEL_OPTIONS_PATTERN,
    CHANNEL_OPTIONS_OPTION_1,
    CHANNEL_OPTIONS_OPTION_2,
    CHANNEL_OPTIONS_OPTION_3,
    CHANNEL_OPTIONS_OPTION_4
};

enum ChannelOptionsType : uint8
{
    CHANNEL_OPTIONS_TYPE_CONSOLE = 1,
    CHANNEL_OPTIONS_TYPE_FILE
};

// For create Logger
enum LoggerOptions
{
    LOGGER_OPTIONS_LOG_LEVEL,
    LOGGER_OPTIONS_CHANNEL_NAME
};

#endif // _LOG_COMMON_
