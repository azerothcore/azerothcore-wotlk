/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef AZEROTHCORE_ILOG_H
#define AZEROTHCORE_ILOG_H

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
    LOG_TYPE_MULTITH = 12,
    MAX_LOG_TYPES
};

enum LogLevel
{
    LOGL_NORMAL = 0,
    LOGL_BASIC,
    LOGL_DETAIL,
    LOGL_DEBUG
};

const int LogLevels = int(LOGL_DEBUG) + 1;

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

const int Colors = int(WHITE) + 1;

class ILog
{
public:
    virtual ~ILog() {}
    virtual void Initialize() = 0;
    virtual void ReloadConfig() = 0;
    virtual void InitColors(const std::string& init_str) = 0;
    virtual void SetColor(bool stdout_stream, ColorTypes color) = 0;
    virtual void ResetColor(bool stdout_stream) = 0;
    virtual void outDB(LogTypes type, const char* str) = 0;
    virtual void outString(const char* str, ...)                  = 0;
    virtual void outString() = 0;
    virtual void outStringInLine(const char* str, ...)            = 0;
    virtual void outError(const char* err, ...)                   = 0;
    virtual void outCrash(const char* err, ...)                   = 0;
    virtual void outBasic(const char* str, ...)                   = 0;
    virtual void outDetail(const char* str, ...)                  = 0;
    virtual void outSQLDev(const char* str, ...)                  = 0;
    virtual void outDebug(DebugLogFilters f, const char* str, ...) = 0;
    virtual void outStaticDebug(const char* str, ...)             = 0;
    virtual void outErrorDb(const char* str, ...)                 = 0;
    virtual void outChar(const char* str, ...)                    = 0;
    virtual void outCommand(uint32 account, const char* str, ...) = 0;
    virtual void outChat(const char* str, ...)                    = 0;
    virtual void outRemote(const char* str, ...)                  = 0;
    virtual void outSQLDriver(const char* str, ...)               = 0;
    virtual void outMisc(const char* str, ...)                    = 0;
    virtual void outCharDump(const char* str, uint32 account_id, uint32 guid, const char* name) = 0;
    virtual void SetLogLevel(char* Level) = 0;
    virtual void SetLogFileLevel(char* Level) = 0;
    virtual void SetSQLDriverQueryLogging(bool newStatus) = 0;
    virtual void SetRealmID(uint32 id) = 0;
    virtual bool IsOutDebug() const = 0;
    virtual bool IsOutCharDump() const = 0;
    virtual bool GetLogDB() const = 0;
    virtual void SetLogDB(bool enable) = 0;
    virtual bool GetSQLDriverQueryLogging() const = 0;
};


#endif //AZEROTHCORE_ILOG_H
