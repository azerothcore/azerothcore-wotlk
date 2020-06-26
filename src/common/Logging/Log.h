/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef AZEROTHCORE_LOG_H
#define AZEROTHCORE_LOG_H

#include "Common.h"
#include <ace/Task.h>

class WorldPacket;

enum DebugLogFilters
{
    LOG_FILTER_NONE                     = 0x00000000,
    LOG_FILTER_UNITS                    = 0x00000001,   // Anything related to units that doesn't fit in other categories. ie. creature formations
    LOG_FILTER_PETS                     = 0x00000002,
    LOG_FILTER_VEHICLES                 = 0x00000004,
    LOG_FILTER_TSCR                     = 0x00000008,   // C++ AI, instance scripts, etc.
    LOG_FILTER_DATABASE_AI              = 0x00000010,   // SmartAI, EventAI, CreatureAI
    LOG_FILTER_MAPSCRIPTS               = 0x00000020,
    LOG_FILTER_NETWORKIO                = 0x00000040,   // Anything packet/netcode related
    LOG_FILTER_SPELLS_AURAS             = 0x00000080,
    LOG_FILTER_ACHIEVEMENTSYS           = 0x00000100,
    LOG_FILTER_CONDITIONSYS             = 0x00000200,
    LOG_FILTER_POOLSYS                  = 0x00000400,
    LOG_FILTER_AUCTIONHOUSE             = 0x00000800,
    LOG_FILTER_BATTLEGROUND             = 0x00001000,   // Anything related to arena's and battlegrounds
    LOG_FILTER_OUTDOORPVP               = 0x00002000,
    LOG_FILTER_CHATSYS                  = 0x00004000,
    LOG_FILTER_LFG                      = 0x00008000,
    LOG_FILTER_MAPS                     = 0x00010000,   // Maps, instances, grids, cells, visibility
    LOG_FILTER_PLAYER_LOADING           = 0x00020000,   // Debug output from Player::_Load functions
    LOG_FILTER_PLAYER_ITEMS             = 0x00040000,   // Anything item related
    LOG_FILTER_PLAYER_SKILLS            = 0x00080000,   // Skills related
    LOG_FILTER_LOOT                     = 0x00100000,   // Loot related
    LOG_FILTER_GUILD                    = 0x00200000,   // Guild related
    LOG_FILTER_TRANSPORTS               = 0x00400000,   // Transport related
    LOG_FILTER_WARDEN                   = 0x00800000,   // Warden related
    LOG_FILTER_BATTLEFIELD              = 0x01000000,   // Battlefield related
    LOG_FILTER_MODULES                  = 0x02000000,   // Modules debug
    LOG_FILTER_CLOSE_SOCKET             = 0x04000000,   // Whenever KickPlayer() or CloseSocket() are called
};

enum LogTypes
{
    LOG_TYPE_STRING = 0,
    LOG_TYPE_ERROR  = 1,
    LOG_TYPE_BASIC  = 2,
    LOG_TYPE_DETAIL = 3,
    LOG_TYPE_DEBUG  = 4,
    LOG_TYPE_CHAR   = 5,
    LOG_TYPE_WORLD  = 6,
    LOG_TYPE_RA     = 7,
    LOG_TYPE_GM     = 8,
    LOG_TYPE_CRASH  = 9,
    LOG_TYPE_CHAT   = 10,
    LOG_TYPE_PERF   = 11,
    LOG_TYPE_MULTITH= 12,
    MAX_LOG_TYPES
};

enum LogLevel
{
    LOGL_NORMAL = 0,
    LOGL_BASIC,
    LOGL_DETAIL,
    LOGL_DEBUG
};

const int LogLevels = int(LOGL_DEBUG)+1;

enum ColorTypes
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
    WHITE
};

const int Colors = int(WHITE)+1;

class Log
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

        void ReloadConfig();

        void InitColors(const std::string& init_str);
        void SetColor(bool stdout_stream, ColorTypes color);
        void ResetColor(bool stdout_stream);

        void outDB(LogTypes type, const char * str);
        void outString(const char * str, ...)                   ATTR_PRINTF(2, 3);
        void outString();
        void outStringInLine(const char * str, ...)             ATTR_PRINTF(2, 3);
        void outError(const char * err, ...)                    ATTR_PRINTF(2, 3);
        void outCrash(const char * err, ...)                    ATTR_PRINTF(2, 3);
        void outBasic(const char * str, ...)                    ATTR_PRINTF(2, 3);
        void outDetail(const char * str, ...)                   ATTR_PRINTF(2, 3);
        void outSQLDev(const char * str, ...)                   ATTR_PRINTF(2, 3);
        void outDebug(DebugLogFilters f, const char* str, ...)  ATTR_PRINTF(3, 4);
        void outStaticDebug(const char * str, ...)              ATTR_PRINTF(2, 3);
        void outErrorDb(const char * str, ...)                  ATTR_PRINTF(2, 3);
        void outChar(const char * str, ...)                     ATTR_PRINTF(2, 3);
        void outCommand(uint32 account, const char * str, ...)  ATTR_PRINTF(3, 4);
        void outChat(const char * str, ...)                     ATTR_PRINTF(2, 3);
        void outRemote(const char * str, ...)                   ATTR_PRINTF(2, 3);
        void outSQLDriver(const char* str, ...)                 ATTR_PRINTF(2, 3);
        void outMisc(const char * str, ...)                     ATTR_PRINTF(2, 3); // pussywizard
        void outCharDump(const char * str, uint32 account_id, uint32 guid, const char * name);

        static void outTimestamp(FILE* file);
        static std::string GetTimestampStr();

        void SetLogLevel(char * Level);
        void SetLogFileLevel(char * Level);
        void SetSQLDriverQueryLogging(bool newStatus) { m_sqlDriverQueryLogging = newStatus; }
        void SetRealmID(uint32 id) { realm = id; }

        bool IsOutDebug() const { return m_logLevel > 2 || (m_logFileLevel > 2 && logfile); }
        bool IsOutCharDump() const { return m_charLog_Dump; }

        bool GetLogDB() const { return m_enableLogDB; }
        void SetLogDB(bool enable) { m_enableLogDB = enable; }
        bool GetSQLDriverQueryLogging() const { return m_sqlDriverQueryLogging; }
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

#define sLog Log::instance()

#endif

