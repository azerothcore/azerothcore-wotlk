/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef AZEROTHCORE_LOG_H
#define AZEROTHCORE_LOG_H

#include "Common.h"
#include "ILog.h"
#include <ace/Task.h>

class Log : public ILog
{
private:
    Log(Log const&) = delete;
    Log(Log&&) = delete;
    Log& operator=(Log const&) = delete;
    Log& operator=(Log&&) = delete;

public:
    Log();
    ~Log();
    void Initialize();

    void ReloadConfig();

    void InitColors(const std::string& init_str);
    void SetColor(bool stdout_stream, ColorTypes color);
    void ResetColor(bool stdout_stream);

    void outDB(LogTypes type, const char* str);
    void outString(const char* str, ...)                   ATTR_PRINTF(2, 3);
    void outString();
    void outStringInLine(const char* str, ...)             ATTR_PRINTF(2, 3);
    void outError(const char* err, ...)                    ATTR_PRINTF(2, 3);
    void outCrash(const char* err, ...)                    ATTR_PRINTF(2, 3);
    void outBasic(const char* str, ...)                    ATTR_PRINTF(2, 3);
    void outDetail(const char* str, ...)                   ATTR_PRINTF(2, 3);
    void outSQLDev(const char* str, ...)                   ATTR_PRINTF(2, 3);
    void outDebug(DebugLogFilters f, const char* str, ...)  ATTR_PRINTF(3, 4);
    void outStaticDebug(const char* str, ...)              ATTR_PRINTF(2, 3);
    void outErrorDb(const char* str, ...)                  ATTR_PRINTF(2, 3);
    void outChar(const char* str, ...)                     ATTR_PRINTF(2, 3);
    void outCommand(uint32 account, const char* str, ...)  ATTR_PRINTF(3, 4);
    void outChat(const char* str, ...)                     ATTR_PRINTF(2, 3);
    void outRemote(const char* str, ...)                   ATTR_PRINTF(2, 3);
    void outSQLDriver(const char* str, ...)                 ATTR_PRINTF(2, 3);
    void outMisc(const char* str, ...)                     ATTR_PRINTF(2, 3);  // pussywizard
    void outCharDump(const char* str, uint32 account_id, uint32 guid, const char* name);

    static void outTimestamp(FILE* file);
    static std::string GetTimestampStr();

    void SetLogLevel(char* Level);
    void SetLogFileLevel(char* Level);
    void SetSQLDriverQueryLogging(bool newStatus) { m_sqlDriverQueryLogging = newStatus; }
    void SetRealmID(uint32 id) { realm = id; }

    [[nodiscard]] bool IsOutDebug() const { return m_logLevel > 2 || (m_logFileLevel > 2 && logfile); }
    [[nodiscard]] bool IsOutCharDump() const { return m_charLog_Dump; }

    [[nodiscard]] bool GetLogDB() const { return m_enableLogDB; }
    void SetLogDB(bool enable) { m_enableLogDB = enable; }
    [[nodiscard]] bool GetSQLDriverQueryLogging() const { return m_sqlDriverQueryLogging; }
private:
    FILE* openLogFile(char const* configFileName, char const* configTimeStampFlag, char const* mode);
    FILE* openGmlogPerAccount(uint32 account);

    FILE* raLogfile;
    FILE* logfile;
    FILE* gmLogfile;
    FILE* charLogfile;
    FILE* dberLogfile;
    FILE* chatLogfile;
    FILE* sqlLogFile;
    FILE* sqlDevLogFile;
    FILE* miscLogFile;

    // cache values for after initilization use (like gm log per account case)
    std::string m_logsDir;
    std::string m_logsTimestamp;

    // gm log control
    bool m_gmlog_per_account;
    std::string m_gmlog_filename_format;

    bool m_enableLogDB;
    uint32 realm;

    // log coloring
    bool m_colored;
    ColorTypes m_colors[4];

    // log levels:
    // false: errors only, true: full query logging
    bool m_sqlDriverQueryLogging;

    // log levels:
    // 0 minimum/string, 1 basic/error, 2 detail, 3 full/debug
    uint8 m_dbLogLevel;
    uint8 m_logLevel;
    uint8 m_logFileLevel;
    bool m_dbChar;
    bool m_dbRA;
    bool m_dbGM;
    bool m_dbChat;
    bool m_charLog_Dump;
    bool m_charLog_Dump_Separate;
    std::string m_dumpsDir;

    DebugLogFilters m_DebugLogMask;
};

std::unique_ptr<ILog>& getLogInstance();

#define sLog getLogInstance()

#endif

