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
#include <unordered_map>

class Object;
class WorldPacket;
class WorldSocket;
class SystemMgr;

struct Realm;

AC_GAME_API extern Realm realm;

enum ShutdownMask : uint8
{
    SHUTDOWN_MASK_RESTART = 1,
    SHUTDOWN_MASK_IDLE    = 2,
};

enum ShutdownExitCode : uint8
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

    static World* instance();

    static uint32 m_worldLoopCounter;

    [[nodiscard]] WorldSession* FindSession(uint32 id) const override;
    [[nodiscard]] WorldSession* FindOfflineSession(uint32 id) const override;
    [[nodiscard]] WorldSession* FindOfflineSessionForCharacterGUID(ObjectGuid::LowType guidLow) const override;
    void AddSession(WorldSession* s) override;
    bool KickSession(uint32 id) override;
    /// Get the number of current active sessions
    void UpdateMaxSessionCounters() override;
    [[nodiscard]] const SessionMap& GetAllSessions() const override { return _sessions; }
    [[nodiscard]] uint32 GetActiveAndQueuedSessionCount() const override { return _sessions.size(); }
    [[nodiscard]] uint32 GetActiveSessionCount() const override { return _sessions.size() - _queuedPlayer.size(); }
    [[nodiscard]] uint32 GetQueuedSessionCount() const override { return _queuedPlayer.size(); }
    /// Get the maximum number of parallel sessions on the server since last reboot
    [[nodiscard]] uint32 GetMaxQueuedSessionCount() const override { return _maxQueuedSessionCount; }
    [[nodiscard]] uint32 GetMaxActiveSessionCount() const override { return _maxActiveSessionCount; }
    /// Get number of players
    [[nodiscard]] inline uint32 GetPlayerCount() const override { return _playerCount; }
    [[nodiscard]] inline uint32 GetMaxPlayerCount() const override { return _maxPlayerCount; }

    /// Increase/Decrease number of players
    inline void IncreasePlayerCount() override
    {
        _playerCount++;
        _maxPlayerCount = std::max(_maxPlayerCount, _playerCount);
    }
    inline void DecreasePlayerCount() override { _playerCount--; }

    Player* FindPlayerInZone(uint32 zone) override;

    /// Deny clients?
    [[nodiscard]] bool IsClosed() const override;

    /// Close world
    void SetClosed(bool val) override;

    /// Security level limitations
    [[nodiscard]] AccountTypes GetPlayerSecurityLimit() const override { return _allowedSecurityLevel; }
    void SetPlayerSecurityLimit(AccountTypes sec) override;
    void LoadDBAllowedSecurityLevel() override;

    /// Active session server limit
    void SetPlayerAmountLimit(uint32 limit) override { _playerLimit = limit; }
    [[nodiscard]] uint32 GetPlayerAmountLimit() const override { return _playerLimit; }

    //player Queue
    typedef std::list<WorldSession*> Queue;
    void AddQueuedPlayer(WorldSession*) override;
    bool RemoveQueuedPlayer(WorldSession* session) override;
    int32 GetQueuePos(WorldSession*) override;
    bool HasRecentlyDisconnected(WorldSession*) override;

    /// \todo Actions on m_allowMovement still to be implemented
    /// Is movement allowed?
    [[nodiscard]] bool getAllowMovement() const override { return _allowMovement; }
    /// Allow/Disallow object movements
    void SetAllowMovement(bool allow) override { _allowMovement = allow; }

    /// Set the string for new characters (first login)
    void SetNewCharString(std::string const& str) override { _newCharString = str; }
    /// Get the string for new characters (first login)
    [[nodiscard]] std::string const& GetNewCharString() const override { return _newCharString; }

    [[nodiscard]] LocaleConstant GetDefaultDbcLocale() const override { return _defaultDbcLocale; }

    /// Get the path where data (dbc, maps) are stored on disk
    [[nodiscard]] std::string const& GetDataPath() const override { return _dataPath; }

    /// Next daily quests and random bg reset time
    [[nodiscard]] Seconds GetNextDailyQuestsResetTime() const override { return _nextDailyQuestReset; }
    [[nodiscard]] Seconds GetNextWeeklyQuestsResetTime() const override { return _nextWeeklyQuestReset; }
    [[nodiscard]] Seconds GetNextRandomBGResetTime() const override { return _nextRandomBGReset; }

    /// Get the maximum skill level a player can reach
    [[nodiscard]] uint16 GetConfigMaxSkillValue() const override
    {
        uint16 lvl = uint16(getIntConfig(CONFIG_MAX_PLAYER_LEVEL));
        return lvl > 60 ? 300 + ((lvl - 60) * 75) / 10 : lvl * 5;
    }

    void SetInitialWorldSettings() override;
    void LoadConfigSettings(bool reload = false) override;

    void SendGlobalMessage(WorldPacket const* packet, WorldSession* self = nullptr, TeamId teamId = TEAM_NEUTRAL) override;
    void SendGlobalGMMessage(WorldPacket const* packet, WorldSession* self = nullptr, TeamId teamId = TEAM_NEUTRAL) override;
    bool SendZoneMessage(uint32 zone, WorldPacket const* packet, WorldSession* self = nullptr, TeamId teamId = TEAM_NEUTRAL) override;
    void SendZoneText(uint32 zone, const char* text, WorldSession* self = nullptr, TeamId teamId = TEAM_NEUTRAL) override;
    void SendServerMessage(ServerMessageType messageID, std::string stringParam = "", Player* player = nullptr) override;

    /// Are we in the middle of a shutdown?
    [[nodiscard]] bool IsShuttingDown() const override { return _shutdownTimer > 0; }
    [[nodiscard]] uint32 GetShutDownTimeLeft() const override { return _shutdownTimer; }
    void ShutdownServ(uint32 time, uint32 options, uint8 exitcode, const std::string& reason = std::string()) override;
    void ShutdownCancel() override;
    void ShutdownMsg(bool show = false, Player* player = nullptr, const std::string& reason = std::string()) override;
    static uint8 GetExitCode() { return _exitCode; }
    static void StopNow(uint8 exitcode) { _stopEvent = true; _exitCode = exitcode; }
    static bool IsStopped() { return _stopEvent; }

    void Update(uint32 diff) override;

    void UpdateSessions(uint32 diff) override;
    /// Set a server rate (see #Rates)
    void setRate(Rates rate, float value) override { _rate_values[rate] = value; }
    /// Get a server rate (see #Rates)
    [[nodiscard]] float getRate(Rates rate) const override { return _rate_values[rate]; }

    /// Set a server configuration element (see #WorldConfigs)
    void setBoolConfig(WorldBoolConfigs index, bool value) override
    {
        if (index < BOOL_CONFIG_VALUE_COUNT)
            _bool_configs[index] = value;
    }

    /// Get a server configuration element (see #WorldConfigs)
    [[nodiscard]] bool getBoolConfig(WorldBoolConfigs index) const override
    {
        return index < BOOL_CONFIG_VALUE_COUNT ? _bool_configs[index] : false;
    }

    /// Set a server configuration element (see #WorldConfigs)
    void setFloatConfig(WorldFloatConfigs index, float value) override
    {
        if (index < FLOAT_CONFIG_VALUE_COUNT)
            _float_configs[index] = value;
    }

    /// Get a server configuration element (see #WorldConfigs)
    [[nodiscard]] float getFloatConfig(WorldFloatConfigs index) const override
    {
        return index < FLOAT_CONFIG_VALUE_COUNT ? _float_configs[index] : 0;
    }

    /// Set a server configuration element (see #WorldConfigs)
    void setIntConfig(WorldIntConfigs index, uint32 value) override
    {
        if (index < INT_CONFIG_VALUE_COUNT)
            _int_configs[index] = value;
    }

    /// Get a server configuration element (see #WorldConfigs)
    [[nodiscard]] uint32 getIntConfig(WorldIntConfigs index) const override
    {
        return index < INT_CONFIG_VALUE_COUNT ? _int_configs[index] : 0;
    }

    void setWorldState(uint32 index, uint64 value) override;
    [[nodiscard]] uint64 getWorldState(uint32 index) const override;
    void LoadWorldStates() override;

    /// Are we on a "Player versus Player" server?
    [[nodiscard]] bool IsPvPRealm() const override;
    [[nodiscard]] bool IsFFAPvPRealm() const override;

    void KickAll() override;
    void KickAllLess(AccountTypes sec) override;

    // for max speed access
    static float GetMaxVisibleDistanceOnContinents()    { return _maxVisibleDistanceOnContinents; }
    static float GetMaxVisibleDistanceInInstances()     { return _maxVisibleDistanceInInstances;  }
    static float GetMaxVisibleDistanceInBGArenas()      { return _maxVisibleDistanceInBGArenas;   }

    // our: needed for arena spectator subscriptions
    uint32 GetNextWhoListUpdateDelaySecs() override;

    void ProcessCliCommands() override;
    void QueueCliCommand(CliCommandHolder* commandHolder) override { _cliCmdQueue.add(commandHolder); }

    void ForceGameEventUpdate() override;

    void UpdateRealmCharCount(uint32 accid) override;

    [[nodiscard]] LocaleConstant GetAvailableDbcLocale(LocaleConstant locale) const override { if (_availableDbcLocaleMask & (1 << locale)) return locale; else return _defaultDbcLocale; }

    // used World DB version
    void LoadDBVersion() override;
    [[nodiscard]] char const* GetDBVersion() const override { return _dbVersion.c_str(); }
#ifdef MOD_PLAYERBOTS
    [[nodiscard]] char const* GetPlayerbotsDBRevision() const override { return m_PlayerbotsDBRevision.c_str(); }
#endif

    void UpdateAreaDependentAuras() override;

    [[nodiscard]] uint32 GetCleaningFlags() const override { return _cleaningFlags; }
    void   SetCleaningFlags(uint32 flags) override { _cleaningFlags = flags; }
    void   ResetEventSeasonalQuests(uint16 event_id) override;

    [[nodiscard]] std::string const& GetRealmName() const override { return _realmName; } // pussywizard
    void SetRealmName(std::string name) override { _realmName = name; } // pussywizard

    void RemoveOldCorpses() override;

    void DoForAllOnlinePlayers(std::function<void(Player*)> exec) override;

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

    SQLQueryHolderCallback& AddQueryHolderCallback(SQLQueryHolderCallback&& callback) override;

private:
    static std::atomic_long _stopEvent;
    static uint8 _exitCode;
    uint32 _shutdownTimer;
    uint32 _shutdownMask;

    uint32 _cleaningFlags;

    bool _isClosed;

    IntervalTimer _timers[WUPDATE_COUNT];
    Seconds _mail_expire_check_timer;

    SessionMap _sessions;
    SessionMap _offlineSessions;
    typedef std::unordered_map<uint32, time_t> DisconnectMap;
    DisconnectMap _disconnects;
    uint32 _maxActiveSessionCount;
    uint32 _maxQueuedSessionCount;
    uint32 _playerCount;
    uint32 _maxPlayerCount;

    std::string _newCharString;

    float _rate_values[MAX_RATES];
    uint32 _int_configs[INT_CONFIG_VALUE_COUNT];
    bool _bool_configs[BOOL_CONFIG_VALUE_COUNT];
    float _float_configs[FLOAT_CONFIG_VALUE_COUNT];
    typedef std::map<uint32, uint64> WorldStatesMap;
    WorldStatesMap _worldstates;
    uint32 _playerLimit;
    AccountTypes _allowedSecurityLevel;
    LocaleConstant _defaultDbcLocale;                     // from config for one from loaded DBC locales
    uint32 _availableDbcLocaleMask;                       // by loaded DBC
    void DetectDBCLang();
    bool _allowMovement;
    std::string _dataPath;

    // for max speed access
    static float _maxVisibleDistanceOnContinents;
    static float _maxVisibleDistanceInInstances;
    static float _maxVisibleDistanceInBGArenas;

    std::string _realmName;

    // CLI command holder to be thread safe
    LockedQueue<CliCommandHolder*> _cliCmdQueue;

    // next daily quests and random bg reset time
    Seconds _nextDailyQuestReset;
    Seconds _nextWeeklyQuestReset;
    Seconds _nextMonthlyQuestReset;
    Seconds _nextRandomBGReset;
    Seconds _nextCalendarOldEventsDeletionTime;
    Seconds _nextGuildReset;

    //Player Queue
    Queue _queuedPlayer;

    // sessions that are added async
    void AddSession_(WorldSession* s);
    LockedQueue<WorldSession*> _addSessQueue;

    // used versions
    std::string _dbVersion;
#ifdef MOD_PLAYERBOTS
    std::string m_PlayerbotsDBRevision;
#endif

    void ProcessQueryCallbacks();
    QueryCallbackProcessor _queryProcessor;
    AsyncCallbackProcessor<SQLQueryHolderCallback> _queryHolderProcessor;

    /**
     * @brief Executed when a World Session is being finalized. Be it from a normal login or via queue popping.
     *
     * @param session The World Session that we are finalizing.
     */
    inline void FinalizePlayerWorldSession(WorldSession* session);
};

std::unique_ptr<IWorld>& getWorldInstance();
#define sWorld getWorldInstance()

#endif
/// @}
