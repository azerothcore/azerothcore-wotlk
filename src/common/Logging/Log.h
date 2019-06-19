/*
 * Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

#ifndef _LOG_H
#define _LOG_H

#include "Common.h"
#include "LogCommon.h"
#include "StringFormat.h"
#include <memory>
#include <unordered_map>
#include <vector>
#include "Poco/FormattingChannel.h"

using Poco::FormattingChannel;

class Log
{
public:
    static Log* instance();

    void Initialize();
    void LoadFromConfig();
    void InitSystemLogger();

    bool ShouldLog(std::string const& type, LogLevel level) const;
    std::string const& GetLogsDir() const { return m_logsDir; }

    void outCharDump(std::string const& str, uint32 accountId, uint64 guid, std::string const& name);    

    template<typename Format, typename... Args>
    inline void outMessage(std::string const& filter, LogLevel const level, Format&& fmt, Args&& ... args)
    {
        outMessage(filter, level, ACORE::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    void outCommand(uint32 account, Format&& fmt, Args&& ... args)
    {
        outCommand(std::to_string(account), ACORE::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    inline void outSys(LogLevel const level, Format&& fmt, Args&& ... args)
    {
        outSys(level, ACORE::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

private:
    typedef std::unordered_map<std::string, FormattingChannel*> ChannelMapFiles;
    typedef std::unordered_map<std::string, FormattingChannel*> ChannelMapConsole;

    void AddFileChannel(std::string ChannelName, FormattingChannel* channel);
    void AddConsoleChannel(std::string ChannelName, FormattingChannel* channel);
    FormattingChannel* GetFileChannel(std::string ChannelName);
    FormattingChannel* GetConsoleChannel();
    void ClearnAllChannels();

    void _Write(std::string const& filter, LogLevel const level, std::string const& message);
    void _writeCommand(std::string const message, std::string const accountid);

    void outMessage(std::string const& filter, LogLevel const level, std::string&& message);
    void outCommand(std::string&& AccountID, std::string&& message);
    void outSys(LogLevel level, std::string&& message);
    std::string GetDynamicFileName(std::string ChannelName, std::string Arg);
    
    void CreateLogger(std::string Name, LogLevel const level, std::string FileChannelName);
    void CreateLoggerFromConfig(std::string const& ConfigLoggerName);
    void CreateChannelsFromConfig(std::string const& LogChannelName);
    void ReadLoggersFromConfig();
    void ReadChannelsFromConfig();

    void InitLogsDir();

    std::string GetPositionOptions(std::string Options, uint8 Position);
    std::string GetChannelFromLogger(std::string LoggerName);

    ChannelMapFiles _ChannelMapFiles;
    ChannelMapConsole _ChannelMapConsole;

    std::string m_logsDir;

    // Const loggers name
    std::string const LOGGER_ROOT = "root";
    std::string const LOGGER_GM = "commands.gm";
    std::string const LOGGER_GM_DYNAMIC = "commands.gm.dynamic";
    std::string const LOGGER_PLAYER_DUMP = "entities.player.dump";
    std::string const LOGGER_SYSTEM = "system";

    // Prefix's
    std::string const PREFIX_LOGGER = "Logger.";
    std::string const PREFIX_CHANNEL = "LogChannel.";

    // Console channel
    std::string CONSOLE_CHANNEL = "";
};

#define sLog Log::instance()

#define LOG_EXCEPTION_FREE(filterType__, level__, ...) sLog->outMessage(filterType__, level__, __VA_ARGS__)

// Fatal - 1
#define LOG_FATAL(filterType__, ...) \
    LOG_EXCEPTION_FREE(filterType__, LOG_LEVEL_FATAL, __VA_ARGS__)

// Critical - 2
#define LOG_CRIT(filterType__, ...) \
    LOG_EXCEPTION_FREE(filterType__, LOG_LEVEL_CRITICAL, __VA_ARGS__)

// Error - 3
#define LOG_ERROR(filterType__, ...) \
    LOG_EXCEPTION_FREE(filterType__, LOG_LEVEL_ERROR, __VA_ARGS__)

// Warning - 4
#define LOG_WARN(filterType__, ...)  \
    LOG_EXCEPTION_FREE(filterType__, LOG_LEVEL_WARNING, __VA_ARGS__)

// Notice - 5
#define LOG_NOTICE(filterType__, ...)  \
    LOG_EXCEPTION_FREE(filterType__, LOG_LEVEL_NOTICE, __VA_ARGS__)

// Info - 6
#define LOG_INFO(filterType__, ...)  \
    LOG_EXCEPTION_FREE(filterType__, LOG_LEVEL_INFO, __VA_ARGS__)

// Debug - 7
#define LOG_DEBUG(filterType__, ...) \
    LOG_EXCEPTION_FREE(filterType__, LOG_LEVEL_DEBUG, __VA_ARGS__)

// Trace - 8
#define LOG_TRACE(filterType__, ...) \
    LOG_EXCEPTION_FREE(filterType__, LOG_LEVEL_TRACE, __VA_ARGS__)

#define LOG_CHAR_DUMP(message__, accountId__, guid__, name__) \
    sLog->outCharDump(message__, accountId__, guid__, name__)

#define LOG_GM(accountId__, ...) \
    sLog->outCommand(accountId__, __VA_ARGS__)

// System Error level 3
#define SYS_LOG_ERROR(...) \
    sLog->outSys(LOG_LEVEL_ERROR, __VA_ARGS__)

// System Info level 6
#define SYS_LOG_INFO(...) \
    sLog->outSys(LOG_LEVEL_INFO, __VA_ARGS__)

#endif
