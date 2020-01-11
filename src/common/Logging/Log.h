/*
 * Copyright (C) 2019+ WarheadCore
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
#include "StringFormat.h"
#include "Poco/FormattingChannel.h"
#include <memory>
#include <unordered_map>
#include <vector>

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

// For create LogChannel
enum ChannelOptions
{
    CHANNEL_OPTIONS_TYPE,
    CHANNEL_OPTIONS_TIMES,
    CHANNEL_OPTIONS_PATTERN,
    CHANNEL_OPTIONS_OPTION_1,
    CHANNEL_OPTIONS_OPTION_2,
    CHANNEL_OPTIONS_OPTION_3,
    CHANNEL_OPTIONS_OPTION_4,
    CHANNEL_OPTIONS_OPTION_5
};

enum ChannelOptionsType
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

using Poco::FormattingChannel;

class AC_COMMON_API Log
{
private:
    Log();
    ~Log();
    Log(Log const&) = delete;
    Log(Log&&) = delete;
    Log& operator=(Log const&) = delete;
    Log& operator=(Log&&) = delete;

public:
    static Log* instance();

    void Initialize();
    void LoadFromConfig();
    void InitSystemLogger();
    void SetRealmID(uint32 RealmID, bool EnableDBLogging = true);

    bool ShouldLog(std::string const& type, LogLevel level) const;
    std::string const& GetLogsDir() const { return m_logsDir; }

    void outCharDump(std::string const& str, uint32 accountId, uint64 guid, std::string const& name);    

    template<typename Format, typename... Args>
    inline void outMessage(std::string const& filter, LogLevel const level, Format&& fmt, Args&& ... args)
    {
        outMessage(filter, level, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    void outCommand(uint32 account, Format&& fmt, Args&& ... args)
    {
        if (!ShouldLog(LOGGER_GM, LOG_LEVEL_INFO))
            return;

        outCommand(std::to_string(account), acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    void outSys(LogLevel const level, Format&& fmt, Args&& ... args)
    {
        outSys(level, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    // Support old func. Need delete later!
    template<typename Format, typename... Args>
    inline void outString(Format&& fmt, Args&& ... args)
    {
        outMessage("server", LOG_LEVEL_INFO, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }
    
    inline void outString()
    {
        outMessage("server", LOG_LEVEL_INFO, "");
    }

    template<typename Format, typename... Args>
    inline void outError(Format&& fmt, Args&& ... args)
    {
        outMessage("server", LOG_LEVEL_ERROR, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    inline void outErrorDb(Format&& fmt, Args&& ... args)
    {
        outMessage("sql.sql", LOG_LEVEL_ERROR, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    inline void outDetail(Format&& fmt, Args&& ... args)
    {
        outMessage("server", LOG_LEVEL_INFO, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    inline void outBasic(Format&& fmt, Args&& ... args)
    {
        outMessage("server", LOG_LEVEL_INFO, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    inline void outSQLDev(Format&& fmt, Args&& ... args)
    {
        outMessage("sql", LOG_LEVEL_INFO, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    inline void outSQLDriver(Format&& fmt, Args&& ... args)
    {
        outMessage("sql", LOG_LEVEL_INFO, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    inline void outCrash(Format&& fmt, Args&& ... args)
    {
        outMessage("server", LOG_LEVEL_FATAL, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    inline void outChar(Format&& fmt, Args&& ... args)
    {
        outMessage("server", LOG_LEVEL_INFO, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    inline void outRemote(Format&& fmt, Args&& ... args)
    {
        outMessage("server", LOG_LEVEL_INFO, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }

    template<typename Format, typename... Args>
    inline void outMisc(Format&& fmt, Args&& ... args)
    {
        outMessage("server", LOG_LEVEL_INFO, acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...));
    }    

private:
    typedef std::unordered_map<std::string, FormattingChannel*> ChannelMapFiles;
    typedef std::unordered_map<std::string, FormattingChannel*> ChannelMapConsole;

    void AddFileChannel(std::string ChannelName, FormattingChannel* channel);
    void AddConsoleChannel(std::string ChannelName, FormattingChannel* channel);
    FormattingChannel* GetFileChannel(std::string ChannelName);
    FormattingChannel* GetConsoleChannel();
    void ClearnAllChannels();
    std::string GetLoggerByType(std::string const& type) const;

    void _Write(std::string const& filter, LogLevel const level, std::string const& message);
    void _writeCommand(std::string const message, std::string const accountid);
    void _writeDB(std::string const& filter, LogLevel const level, std::string const& message);

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

    void Clear();

    std::string GetPositionOptions(std::string Options, uint8 Position, std::string Default = "");
    std::string GetChannelFromLogger(std::string LoggerName);

    ChannelMapFiles _ChannelMapFiles;
    ChannelMapConsole _ChannelMapConsole;

    std::string m_logsDir;    

    // Const loggers name
    std::string const LOGGER_ROOT = "root";
    std::string const LOGGER_GM = "commands.gm";
    std::string const LOGGER_GM_DYNAMIC = "commands.gm.dynamic";
    std::string const LOGGER_PLAYER_DUMP = "entities.player.dump";
    
    // Const logger used in system only
    std::string const LOGGER_SYSTEM = "system";

    // Prefix's
    std::string const PREFIX_LOGGER = "Logger.";
    std::string const PREFIX_CHANNEL = "LogChannel.";

    // Console channel
    std::string _CONSOLE_CHANNEL = "";

    // DB logging
    bool m_enableLogDB = false;
    uint32 m_realmID = 0;
};

#define sLog Log::instance()

#define LOG_EXCEPTION_FREE(filterType__, level__, ...) \
    { \
        try \
        { \
            sLog->outMessage(filterType__, level__, __VA_ARGS__); \
        } \
        catch (std::exception& e) \
        { \
            sLog->outMessage("server", LOG_LEVEL_ERROR, "Wrong format occurred (%s) at %s:%u.", \
                e.what(), __FILE__, __LINE__); \
        } \
    }

#if AC_PLATFORM != AC_PLATFORM_WINDOWS
void check_args(char const*, ...) ATTR_PRINTF(1, 2);
void check_args(std::string const&, ...);

// This will catch format errors on build time
#define LOG_MSG_BODY(filterType__, level__, ...)                        \
        do {                                                            \
            if (sLog->ShouldLog(filterType__, level__))                 \
            {                                                           \
                if (false)                                              \
                    check_args(__VA_ARGS__);                            \
                                                                        \
                LOG_EXCEPTION_FREE(filterType__, level__, __VA_ARGS__); \
            }                                                           \
        } while (0)
#else
#define LOG_MSG_BODY(filterType__, level__, ...)                        \
        __pragma(warning(push))                                         \
        __pragma(warning(disable:4127))                                 \
        do {                                                            \
            if (sLog->ShouldLog(filterType__, level__))                 \
                LOG_EXCEPTION_FREE(filterType__, level__, __VA_ARGS__); \
        } while (0)                                                     \
        __pragma(warning(pop))
#endif

// Fatal - 1
#define LOG_FATAL(filterType__, ...) \
    LOG_MSG_BODY(filterType__, LOG_LEVEL_FATAL, __VA_ARGS__)

// Critical - 2
#define LOG_CRIT(filterType__, ...) \
    LOG_MSG_BODY(filterType__, LOG_LEVEL_CRITICAL, __VA_ARGS__)

// Error - 3
#define LOG_ERROR(filterType__, ...) \
    LOG_MSG_BODY(filterType__, LOG_LEVEL_ERROR, __VA_ARGS__)

// Warning - 4
#define LOG_WARN(filterType__, ...)  \
    LOG_MSG_BODY(filterType__, LOG_LEVEL_WARNING, __VA_ARGS__)

// Notice - 5
#define LOG_NOTICE(filterType__, ...)  \
    LOG_MSG_BODY(filterType__, LOG_LEVEL_NOTICE, __VA_ARGS__)

// Info - 6
#define LOG_INFO(filterType__, ...)  \
    LOG_MSG_BODY(filterType__, LOG_LEVEL_INFO, __VA_ARGS__)

// Debug - 7
#define LOG_DEBUG(filterType__, ...) \
    LOG_MSG_BODY(filterType__, LOG_LEVEL_DEBUG, __VA_ARGS__)

// Trace - 8
#define LOG_TRACE(filterType__, ...) \
    LOG_MSG_BODY(filterType__, LOG_LEVEL_TRACE, __VA_ARGS__)

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
