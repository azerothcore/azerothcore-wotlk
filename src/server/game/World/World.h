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

/// \addtogroup world The World
/// @{
/// \file

#ifndef __WORLD_H
#define __WORLD_H

#include "IWorld.h"
#include "LockedQueue.h"
#include "ObjectGuid.h"
#include "QueryResult.h"
#include "SharedDefines.h"
#include "Timer.h"
#include <atomic>
#include <list>
#include <map>
#include <set>
#include <unordered_map>

class Object;
class WorldPacket;
class WorldSocket;
class SystemMgr;

struct Realm;

AC_GAME_API extern Realm realm;

enum ShutdownMask
{
    SHUTDOWN_MASK_RESTART = 1,
    SHUTDOWN_MASK_IDLE    = 2,
};

enum ShutdownExitCode
{
    SHUTDOWN_EXIT_CODE = 0,
    ERROR_EXIT_CODE    = 1,
    RESTART_EXIT_CODE  = 2,
};

/// Timers for different object refresh rates
enum WorldTimers
{
    WUPDATE_AUCTIONS,
    WUPDATE_WEATHERS,
    WUPDATE_UPTIME,
    WUPDATE_CORPSES,
    WUPDATE_EVENTS,
    WUPDATE_CLEANDB,
    WUPDATE_AUTOBROADCAST,
    WUPDATE_MAILBOXQUEUE,
    WUPDATE_PINGDB,
    WUPDATE_5_SECS,
    WUPDATE_WHO_LIST,
    WUPDATE_COUNT
};

/// Can be used in SMSG_AUTH_RESPONSE packet
enum BillingPlanFlags
{
    SESSION_NONE            = 0x00,
    SESSION_UNUSED          = 0x01,
    SESSION_RECURRING_BILL  = 0x02,
    SESSION_FREE_TRIAL      = 0x04,
    SESSION_IGR             = 0x08,
    SESSION_USAGE           = 0x10,
    SESSION_TIME_MIXTURE    = 0x20,
    SESSION_RESTRICTED      = 0x40,
    SESSION_ENABLE_CAIS     = 0x80,
};

enum RealmZone
{
    REALM_ZONE_UNKNOWN       = 0,                           // any language
    REALM_ZONE_DEVELOPMENT   = 1,                           // any language
    REALM_ZONE_UNITED_STATES = 2,                           // extended-Latin
    REALM_ZONE_OCEANIC       = 3,                           // extended-Latin
    REALM_ZONE_LATIN_AMERICA = 4,                           // extended-Latin
    REALM_ZONE_TOURNAMENT_5  = 5,                           // basic-Latin at create, any at login
    REALM_ZONE_KOREA         = 6,                           // East-Asian
    REALM_ZONE_TOURNAMENT_7  = 7,                           // basic-Latin at create, any at login
    REALM_ZONE_ENGLISH       = 8,                           // extended-Latin
    REALM_ZONE_GERMAN        = 9,                           // extended-Latin
    REALM_ZONE_FRENCH        = 10,                          // extended-Latin
    REALM_ZONE_SPANISH       = 11,                          // extended-Latin
    REALM_ZONE_RUSSIAN       = 12,                          // Cyrillic
    REALM_ZONE_TOURNAMENT_13 = 13,                          // basic-Latin at create, any at login
    REALM_ZONE_TAIWAN        = 14,                          // East-Asian
    REALM_ZONE_TOURNAMENT_15 = 15,                          // basic-Latin at create, any at login
    REALM_ZONE_CHINA         = 16,                          // East-Asian
    REALM_ZONE_CN1           = 17,                          // basic-Latin at create, any at login
    REALM_ZONE_CN2           = 18,                          // basic-Latin at create, any at login
    REALM_ZONE_CN3           = 19,                          // basic-Latin at create, any at login
    REALM_ZONE_CN4           = 20,                          // basic-Latin at create, any at login
    REALM_ZONE_CN5           = 21,                          // basic-Latin at create, any at login
    REALM_ZONE_CN6           = 22,                          // basic-Latin at create, any at login
    REALM_ZONE_CN7           = 23,                          // basic-Latin at create, any at login
    REALM_ZONE_CN8           = 24,                          // basic-Latin at create, any at login
    REALM_ZONE_TOURNAMENT_25 = 25,                          // basic-Latin at create, any at login
    REALM_ZONE_TEST_SERVER   = 26,                          // any language
    REALM_ZONE_TOURNAMENT_27 = 27,                          // basic-Latin at create, any at login
    REALM_ZONE_QA_SERVER     = 28,                          // any language
    REALM_ZONE_CN9           = 29,                          // basic-Latin at create, any at login
    REALM_ZONE_TEST_SERVER_2 = 30,                          // any language
    REALM_ZONE_CN10          = 31,                          // basic-Latin at create, any at login
    REALM_ZONE_CTC           = 32,
    REALM_ZONE_CNC           = 33,
    REALM_ZONE_CN1_4         = 34,                          // basic-Latin at create, any at login
    REALM_ZONE_CN2_6_9       = 35,                          // basic-Latin at create, any at login
    REALM_ZONE_CN3_7         = 36,                          // basic-Latin at create, any at login
    REALM_ZONE_CN5_8         = 37                           // basic-Latin at create, any at login
};

enum WorldStates
{
    WS_ARENA_DISTRIBUTION_TIME                 = 20001,                     // Next arena distribution time
    WS_WEEKLY_QUEST_RESET_TIME                 = 20002,                     // Next weekly reset time
    WS_BG_DAILY_RESET_TIME                     = 20003,                     // Next daily BG reset time
    WS_CLEANING_FLAGS                          = 20004,                     // Cleaning Flags
    WS_DAILY_QUEST_RESET_TIME                  = 20005,                     // Next daily reset time
    WS_GUILD_DAILY_RESET_TIME                  = 20006,                     // Next guild cap reset time
    WS_MONTHLY_QUEST_RESET_TIME                = 20007,                     // Next monthly reset time
    WS_DAILY_CALENDAR_DELETION_OLD_EVENTS_TIME = 20008                      // Next daily calendar deletions of old events time
};

#define WORLD_SLEEP_CONST 10

// xinef: petitions storage
struct PetitionData
{
};

/// The World
class World: public IWorld
{
public:
    World();
    ~World() override;

    static auto instance() -> World*;

    static uint32 m_worldLoopCounter;

    [[nodiscard]] auto FindSession(uint32 id) const -> WorldSession* override;
    [[nodiscard]] auto FindOfflineSession(uint32 id) const -> WorldSession* override;
    [[nodiscard]] auto FindOfflineSessionForCharacterGUID(ObjectGuid::LowType guidLow) const -> WorldSession* override;
    void AddSession(WorldSession* s) override;
    void SendAutoBroadcast() override;
    auto KickSession(uint32 id) -> bool override;
    /// Get the number of current active sessions
    void UpdateMaxSessionCounters() override;
    [[nodiscard]] auto GetAllSessions() const -> const SessionMap& override { return m_sessions; }
    [[nodiscard]] auto GetActiveAndQueuedSessionCount() const -> uint32 override { return m_sessions.size(); }
    [[nodiscard]] auto GetActiveSessionCount() const -> uint32 override { return m_sessions.size() - m_QueuedPlayer.size(); }
    [[nodiscard]] auto GetQueuedSessionCount() const -> uint32 override { return m_QueuedPlayer.size(); }
    /// Get the maximum number of parallel sessions on the server since last reboot
    [[nodiscard]] auto GetMaxQueuedSessionCount() const -> uint32 override { return m_maxQueuedSessionCount; }
    [[nodiscard]] auto GetMaxActiveSessionCount() const -> uint32 override { return m_maxActiveSessionCount; }
    /// Get number of players
    [[nodiscard]] inline auto GetPlayerCount() const -> uint32 override { return m_PlayerCount; }
    [[nodiscard]] inline auto GetMaxPlayerCount() const -> uint32 override { return m_MaxPlayerCount; }

    /// Increase/Decrease number of players
    inline void IncreasePlayerCount() override
    {
        m_PlayerCount++;
        m_MaxPlayerCount = std::max(m_MaxPlayerCount, m_PlayerCount);
    }
    inline void DecreasePlayerCount() override { m_PlayerCount--; }

    auto FindPlayerInZone(uint32 zone) -> Player* override;

    /// Deny clients?
    [[nodiscard]] auto IsClosed() const -> bool override;

    /// Close world
    void SetClosed(bool val) override;

    /// Security level limitations
    [[nodiscard]] auto GetPlayerSecurityLimit() const -> AccountTypes override { return m_allowedSecurityLevel; }
    void SetPlayerSecurityLimit(AccountTypes sec) override;
    void LoadDBAllowedSecurityLevel() override;

    /// Active session server limit
    void SetPlayerAmountLimit(uint32 limit) override { m_playerLimit = limit; }
    [[nodiscard]] auto GetPlayerAmountLimit() const -> uint32 override { return m_playerLimit; }

    //player Queue
    typedef std::list<WorldSession*> Queue;
    void AddQueuedPlayer(WorldSession*) override;
    auto RemoveQueuedPlayer(WorldSession* session) -> bool override;
    auto GetQueuePos(WorldSession*) -> int32 override;
    auto HasRecentlyDisconnected(WorldSession*) -> bool override;

    /// \todo Actions on m_allowMovement still to be implemented
    /// Is movement allowed?
    [[nodiscard]] auto getAllowMovement() const -> bool override { return m_allowMovement; }
    /// Allow/Disallow object movements
    void SetAllowMovement(bool allow) override { m_allowMovement = allow; }

    /// Set the string for new characters (first login)
    void SetNewCharString(std::string const& str) override { m_newCharString = str; }
    /// Get the string for new characters (first login)
    [[nodiscard]] auto GetNewCharString() const -> std::string const& override { return m_newCharString; }

    [[nodiscard]] auto GetDefaultDbcLocale() const -> LocaleConstant override { return m_defaultDbcLocale; }

    /// Get the path where data (dbc, maps) are stored on disk
    [[nodiscard]] auto GetDataPath() const -> std::string const& override { return m_dataPath; }

    /// When server started?
    [[nodiscard]] auto GetStartTime() const -> time_t const& override { return m_startTime; }
    /// What time is it?
    [[nodiscard]] auto GetGameTime() const -> time_t const& override { return m_gameTime; }
    /// What time is it? in ms
    static auto GetGameTimeMS() -> uint32 { return m_gameMSTime; }
    /// Uptime (in secs)
    [[nodiscard]] auto GetUptime() const -> uint32 override { return uint32(m_gameTime - m_startTime); }
    /// Update time
    [[nodiscard]] auto GetUpdateTime() const -> uint32 override { return m_updateTime; }
    void SetRecordDiffInterval(int32 t) override { if (t >= 0) m_int_configs[CONFIG_INTERVAL_LOG_UPDATE] = (uint32)t; }

    /// Next daily quests and random bg reset time
    [[nodiscard]] auto GetNextDailyQuestsResetTime() const -> time_t override { return m_NextDailyQuestReset; }
    [[nodiscard]] auto GetNextWeeklyQuestsResetTime() const -> time_t override { return m_NextWeeklyQuestReset; }
    [[nodiscard]] auto GetNextRandomBGResetTime() const -> time_t override { return m_NextRandomBGReset; }

    /// Get the maximum skill level a player can reach
    [[nodiscard]] auto GetConfigMaxSkillValue() const -> uint16 override
    {
        uint16 lvl = uint16(getIntConfig(CONFIG_MAX_PLAYER_LEVEL));
        return lvl > 60 ? 300 + ((lvl - 60) * 75) / 10 : lvl * 5;
    }

    void SetInitialWorldSettings() override;
    void LoadConfigSettings(bool reload = false) override;

    void SendWorldText(uint32 string_id, ...) override;
    void SendGlobalText(const char* text, WorldSession* self) override;
    void SendGMText(uint32 string_id, ...) override;
    void SendGlobalMessage(WorldPacket* packet, WorldSession* self = nullptr, TeamId teamId = TEAM_NEUTRAL) override;
    void SendGlobalGMMessage(WorldPacket* packet, WorldSession* self = nullptr, TeamId teamId = TEAM_NEUTRAL) override;
    auto SendZoneMessage(uint32 zone, WorldPacket* packet, WorldSession* self = nullptr, TeamId teamId = TEAM_NEUTRAL) -> bool override;
    void SendZoneText(uint32 zone, const char* text, WorldSession* self = nullptr, TeamId teamId = TEAM_NEUTRAL) override;
    void SendServerMessage(ServerMessageType type, const char* text = "", Player* player = nullptr) override;

    void SendWorldTextOptional(uint32 string_id, uint32 flag, ...) override;

    /// Are we in the middle of a shutdown?
    [[nodiscard]] auto IsShuttingDown() const -> bool override { return m_ShutdownTimer > 0; }
    [[nodiscard]] auto GetShutDownTimeLeft() const -> uint32 override { return m_ShutdownTimer; }
    void ShutdownServ(uint32 time, uint32 options, uint8 exitcode, const std::string& reason = std::string()) override;
    void ShutdownCancel() override;
    void ShutdownMsg(bool show = false, Player* player = nullptr, const std::string& reason = std::string()) override;
    static auto GetExitCode() -> uint8 { return m_ExitCode; }
    static void StopNow(uint8 exitcode) { m_stopEvent = true; m_ExitCode = exitcode; }
    static auto IsStopped() -> bool { return m_stopEvent; }

    void Update(uint32 diff) override;

    void UpdateSessions(uint32 diff) override;
    /// Set a server rate (see #Rates)
    void setRate(Rates rate, float value) override { rate_values[rate] = value; }
    /// Get a server rate (see #Rates)
    [[nodiscard]] auto getRate(Rates rate) const -> float override { return rate_values[rate]; }

    /// Set a server configuration element (see #WorldConfigs)
    void setBoolConfig(WorldBoolConfigs index, bool value) override
    {
        if (index < BOOL_CONFIG_VALUE_COUNT)
            m_bool_configs[index] = value;
    }

    /// Get a server configuration element (see #WorldConfigs)
    [[nodiscard]] auto getBoolConfig(WorldBoolConfigs index) const -> bool override
    {
        return index < BOOL_CONFIG_VALUE_COUNT ? m_bool_configs[index] : false;
    }

    /// Set a server configuration element (see #WorldConfigs)
    void setFloatConfig(WorldFloatConfigs index, float value) override
    {
        if (index < FLOAT_CONFIG_VALUE_COUNT)
            m_float_configs[index] = value;
    }

    /// Get a server configuration element (see #WorldConfigs)
    [[nodiscard]] auto getFloatConfig(WorldFloatConfigs index) const -> float override
    {
        return index < FLOAT_CONFIG_VALUE_COUNT ? m_float_configs[index] : 0;
    }

    /// Set a server configuration element (see #WorldConfigs)
    void setIntConfig(WorldIntConfigs index, uint32 value) override
    {
        if (index < INT_CONFIG_VALUE_COUNT)
            m_int_configs[index] = value;
    }

    /// Get a server configuration element (see #WorldConfigs)
    [[nodiscard]] auto getIntConfig(WorldIntConfigs index) const -> uint32 override
    {
        return index < INT_CONFIG_VALUE_COUNT ? m_int_configs[index] : 0;
    }

    void setWorldState(uint32 index, uint64 value) override;
    [[nodiscard]] auto getWorldState(uint32 index) const -> uint64 override;
    void LoadWorldStates() override;

    /// Are we on a "Player versus Player" server?
    [[nodiscard]] auto IsPvPRealm() const -> bool override;
    [[nodiscard]] auto IsFFAPvPRealm() const -> bool override;

    void KickAll() override;
    void KickAllLess(AccountTypes sec) override;

    // for max speed access
    static auto GetMaxVisibleDistanceOnContinents() -> float    { return m_MaxVisibleDistanceOnContinents; }
    static auto GetMaxVisibleDistanceInInstances() -> float     { return m_MaxVisibleDistanceInInstances;  }
    static auto GetMaxVisibleDistanceInBGArenas() -> float      { return m_MaxVisibleDistanceInBGArenas;   }

    // our: needed for arena spectator subscriptions
    auto GetNextWhoListUpdateDelaySecs() -> uint32 override;

    void ProcessCliCommands() override;
    void QueueCliCommand(CliCommandHolder* commandHolder) override { cliCmdQueue.add(commandHolder); }

    void ForceGameEventUpdate() override;

    void UpdateRealmCharCount(uint32 accid) override;

    [[nodiscard]] auto GetAvailableDbcLocale(LocaleConstant locale) const -> LocaleConstant override { if (m_availableDbcLocaleMask & (1 << locale)) return locale; else return m_defaultDbcLocale; }

    // used World DB version
    void LoadDBVersion() override;
    void LoadDBRevision() override;
    [[nodiscard]] auto GetDBVersion() const -> char const* override { return m_DBVersion.c_str(); }
    [[nodiscard]] auto GetWorldDBRevision() const -> char const* override { return m_WorldDBRevision.c_str(); }
    [[nodiscard]] auto GetCharacterDBRevision() const -> char const* override { return m_CharacterDBRevision.c_str(); }
    [[nodiscard]] auto GetAuthDBRevision() const -> char const* override { return m_AuthDBRevision.c_str(); }

    void LoadAutobroadcasts() override;

    void UpdateAreaDependentAuras() override;

    [[nodiscard]] auto GetCleaningFlags() const -> uint32 override { return m_CleaningFlags; }
    void   SetCleaningFlags(uint32 flags) override { m_CleaningFlags = flags; }
    void   ResetEventSeasonalQuests(uint16 event_id) override;

    auto GetNextTimeWithDayAndHour(int8 dayOfWeek, int8 hour) -> time_t override; // pussywizard
    auto GetNextTimeWithMonthAndHour(int8 month, int8 hour) -> time_t override; // pussywizard

    [[nodiscard]] auto GetRealmName() const -> std::string const& override { return _realmName; } // pussywizard
    void SetRealmName(std::string name) override { _realmName = name; } // pussywizard

    void RemoveOldCorpses() override;

protected:
    void _UpdateGameTime();
    // callback for UpdateRealmCharacters
    void _UpdateRealmCharCount(PreparedQueryResult resultCharCount);

    void InitDailyQuestResetTime();
    void InitWeeklyQuestResetTime();
    void InitMonthlyQuestResetTime();
    void InitRandomBGResetTime();
    void InitCalendarOldEventsDeletionTime();
    void InitGuildResetTime();
    void ResetDailyQuests();
    void ResetWeeklyQuests();
    void ResetMonthlyQuests();
    void ResetRandomBG();
    void CalendarDeleteOldEvents();
    void ResetGuildCap();
private:
    static std::atomic_long m_stopEvent;
    static uint8 m_ExitCode;
    uint32 m_ShutdownTimer;
    uint32 m_ShutdownMask;

    uint32 m_CleaningFlags;

    bool m_isClosed;

    time_t m_startTime;
    time_t m_gameTime;
    IntervalTimer m_timers[WUPDATE_COUNT];
    time_t mail_expire_check_timer;
    uint32 m_updateTime, m_updateTimeSum;
    static uint32 m_gameMSTime;

    SessionMap m_sessions;
    SessionMap m_offlineSessions;
    typedef std::unordered_map<uint32, time_t> DisconnectMap;
    DisconnectMap m_disconnects;
    uint32 m_maxActiveSessionCount;
    uint32 m_maxQueuedSessionCount;
    uint32 m_PlayerCount;
    uint32 m_MaxPlayerCount;

    std::string m_newCharString;

    float rate_values[MAX_RATES];
    uint32 m_int_configs[INT_CONFIG_VALUE_COUNT];
    bool m_bool_configs[BOOL_CONFIG_VALUE_COUNT];
    float m_float_configs[FLOAT_CONFIG_VALUE_COUNT];
    typedef std::map<uint32, uint64> WorldStatesMap;
    WorldStatesMap m_worldstates;
    uint32 m_playerLimit;
    AccountTypes m_allowedSecurityLevel;
    LocaleConstant m_defaultDbcLocale;                     // from config for one from loaded DBC locales
    uint32 m_availableDbcLocaleMask;                       // by loaded DBC
    void DetectDBCLang();
    bool m_allowMovement;
    std::string m_dataPath;

    // for max speed access
    static float m_MaxVisibleDistanceOnContinents;
    static float m_MaxVisibleDistanceInInstances;
    static float m_MaxVisibleDistanceInBGArenas;

    std::string _realmName;

    // CLI command holder to be thread safe
    LockedQueue<CliCommandHolder*> cliCmdQueue;

    // next daily quests and random bg reset time
    time_t m_NextDailyQuestReset;
    time_t m_NextWeeklyQuestReset;
    time_t m_NextMonthlyQuestReset;
    time_t m_NextRandomBGReset;
    time_t m_NextCalendarOldEventsDeletionTime;
    time_t m_NextGuildReset;

    //Player Queue
    Queue m_QueuedPlayer;

    // sessions that are added async
    void AddSession_(WorldSession* s);
    LockedQueue<WorldSession*> addSessQueue;

    // used versions
    std::string m_DBVersion;
    std::string m_WorldDBRevision;
    std::string m_CharacterDBRevision;
    std::string m_AuthDBRevision;

    typedef std::map<uint8, std::string> AutobroadcastsMap;
    AutobroadcastsMap m_Autobroadcasts;

    typedef std::map<uint8, uint8> AutobroadcastsWeightMap;
    AutobroadcastsWeightMap m_AutobroadcastsWeights;

    void ProcessQueryCallbacks();
    QueryCallbackProcessor _queryProcessor;

    /**
     * @brief Executed when a World Session is being finalized. Be it from a normal login or via queue popping.
     *
     * @param session The World Session that we are finalizing.
     */
    inline void FinalizePlayerWorldSession(WorldSession* session);
};

auto getWorldInstance() -> std::unique_ptr<IWorld>&;
#define sWorld getWorldInstance()

#endif
/// @}
