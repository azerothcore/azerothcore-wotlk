/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
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

#include "DatabaseEnvFwd.h"
#include "IWorld.h"
#include "LockedQueue.h"
#include "ObjectGuid.h"
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
    WUPDATE_UPTIME,
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

    /// Deny clients?
    [[nodiscard]] bool IsClosed() const override;

    /// Close world
    void SetClosed(bool val) override;

    /// Security level limitations
    [[nodiscard]] AccountTypes GetPlayerSecurityLimit() const override { return _allowedSecurityLevel; }
    void SetPlayerSecurityLimit(AccountTypes sec) override;
    void LoadDBAllowedSecurityLevel() override;

    /// \todo Actions on m_allowMovement still to be implemented
    /// Is movement allowed?
    [[nodiscard]] bool getAllowMovement() const override { return _allowMovement; }
    /// Allow/Disallow object movements
    void SetAllowMovement(bool allow) override { _allowMovement = allow; }

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

    /// Are we in the middle of a shutdown?
    [[nodiscard]] bool IsShuttingDown() const override { return _shutdownTimer > 0; }
    [[nodiscard]] uint32 GetShutDownTimeLeft() const override { return _shutdownTimer; }
    void ShutdownServ(uint32 time, uint32 options, uint8 exitcode, std::string const& reason = std::string()) override;
    void ShutdownCancel() override;
    void ShutdownMsg(bool show = false, Player* player = nullptr, std::string const& reason = std::string()) override;
    static uint8 GetExitCode() { return _exitCode; }
    static void StopNow(uint8 exitcode) { _stopEvent = true; _exitCode = exitcode; }
    static bool IsStopped() { return _stopEvent; }

    void Update(uint32 diff) override;

    void setRate(ServerConfigs index, float value) override;
    float getRate(ServerConfigs index) const override;

    void setBoolConfig(ServerConfigs index, bool value) override;
    bool getBoolConfig(ServerConfigs index) const override;

    void setFloatConfig(ServerConfigs index, float value) override;
    float getFloatConfig(ServerConfigs index) const override;

    void setIntConfig(ServerConfigs index, uint32 value) override;
    uint32 getIntConfig(ServerConfigs index) const override;

    void setStringConfig(ServerConfigs index, std::string const& value) override;
    std::string_view getStringConfig(ServerConfigs index) const override;

    /// Are we on a "Player versus Player" server?
    [[nodiscard]] bool IsPvPRealm() const override;
    [[nodiscard]] bool IsFFAPvPRealm() const override;

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

    void UpdateAreaDependentAuras() override;

    [[nodiscard]] uint32 GetCleaningFlags() const override { return _cleaningFlags; }
    void   SetCleaningFlags(uint32 flags) override { _cleaningFlags = flags; }
    void   ResetEventSeasonalQuests(uint16 event_id) override;

    [[nodiscard]] std::string const& GetRealmName() const override { return _realmName; } // pussywizard
    void SetRealmName(std::string name) override { _realmName = name; } // pussywizard

protected:
    void _UpdateGameTime();
    // callback for UpdateRealmCharacters
    void _UpdateRealmCharCount(PreparedQueryResult resultCharCount,uint32 accountId);

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
    WorldConfig _worldConfig;

    static std::atomic_long _stopEvent;
    static uint8 _exitCode;
    uint32 _shutdownTimer;
    uint32 _shutdownMask;
    std::string _shutdownReason;

    uint32 _cleaningFlags;

    bool _isClosed;

    IntervalTimer _timers[WUPDATE_COUNT];
    Seconds _mail_expire_check_timer;

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

    // used versions
    std::string _dbVersion;
    uint32 _dbClientCacheVersion;

    void ProcessQueryCallbacks();
    QueryCallbackProcessor _queryProcessor;

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
