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

#ifndef AZEROTHCORE_IWORLD_H
#define AZEROTHCORE_IWORLD_H

#include "AsyncCallbackProcessor.h"
#include "Common.h"
#include "Duration.h"
#include "ObjectGuid.h"
#include "SharedDefines.h"
#include "WorldConfig.h"
#include <unordered_map>

class WorldPacket;
class WorldSession;
class Player;

/// Storage class for commands issued for delayed execution
struct AC_GAME_API CliCommandHolder
{
    using Print = void(*)(void*, std::string_view);
    using CommandFinished = void(*)(void*, bool success);

    void* m_callbackArg;
    char* m_command;
    Print m_print;
    CommandFinished m_commandFinished;

    CliCommandHolder(void* callbackArg, char const* command, Print zprint, CommandFinished commandFinished);
    ~CliCommandHolder();

private:
    CliCommandHolder(CliCommandHolder const& right) = delete;
    CliCommandHolder& operator=(CliCommandHolder const& right) = delete;
};

// ServerMessages.dbc
enum ServerMessageType
{
    SERVER_MSG_SHUTDOWN_TIME      = 1,
    SERVER_MSG_RESTART_TIME       = 2,
    SERVER_MSG_STRING             = 3,
    SERVER_MSG_SHUTDOWN_CANCELLED = 4,
    SERVER_MSG_RESTART_CANCELLED  = 5
};

class IWorld
{
public:
    virtual ~IWorld() = default;
    [[nodiscard]] virtual bool IsClosed() const = 0;
    virtual void SetClosed(bool val) = 0;
    [[nodiscard]] virtual AccountTypes GetPlayerSecurityLimit() const = 0;
    virtual void SetPlayerSecurityLimit(AccountTypes sec) = 0;
    virtual void LoadDBAllowedSecurityLevel() = 0;
    [[nodiscard]] virtual bool getAllowMovement() const = 0;
    virtual void SetAllowMovement(bool allow) = 0;
    [[nodiscard]] virtual LocaleConstant GetDefaultDbcLocale() const = 0;
    [[nodiscard]] virtual std::string const& GetDataPath() const = 0;
    [[nodiscard]] virtual Seconds GetNextDailyQuestsResetTime() const = 0;
    [[nodiscard]] virtual Seconds GetNextWeeklyQuestsResetTime() const = 0;
    [[nodiscard]] virtual Seconds GetNextRandomBGResetTime() const = 0;
    [[nodiscard]] virtual uint16 GetConfigMaxSkillValue() const = 0;
    virtual void SetInitialWorldSettings() = 0;
    virtual void LoadConfigSettings(bool reload = false) = 0;
    [[nodiscard]] virtual bool IsShuttingDown() const = 0;
    [[nodiscard]] virtual uint32 GetShutDownTimeLeft() const = 0;
    virtual void ShutdownServ(uint32 time, uint32 options, uint8 exitcode, const std::string& reason = std::string()) = 0;
    virtual void ShutdownCancel() = 0;
    virtual void ShutdownMsg(bool show = false, Player* player = nullptr, const std::string& reason = std::string()) = 0;
    virtual void Update(uint32 diff) = 0;
    virtual void setRate(ServerConfigs index, float value) = 0;
    [[nodiscard]] virtual float getRate(ServerConfigs index) const = 0;
    virtual void setBoolConfig(ServerConfigs index, bool value) = 0;
    [[nodiscard]] virtual bool getBoolConfig(ServerConfigs index) const = 0;
    virtual void setFloatConfig(ServerConfigs index, float value) = 0;
    [[nodiscard]] virtual float getFloatConfig(ServerConfigs index) const = 0;
    virtual void setIntConfig(ServerConfigs index, uint32 value) = 0;
    [[nodiscard]] virtual uint32 getIntConfig(ServerConfigs index) const = 0;
    virtual void setStringConfig(ServerConfigs index, std::string const& value) = 0;
    virtual std::string_view getStringConfig(ServerConfigs index) const = 0;
    [[nodiscard]] virtual bool IsPvPRealm() const = 0;
    [[nodiscard]] virtual bool IsFFAPvPRealm() const = 0;
    virtual uint32 GetNextWhoListUpdateDelaySecs() = 0;
    virtual void ProcessCliCommands() = 0;
    virtual void QueueCliCommand(CliCommandHolder* commandHolder) = 0;
    virtual void ForceGameEventUpdate() = 0;
    virtual void UpdateRealmCharCount(uint32 accid) = 0;
    [[nodiscard]] virtual LocaleConstant GetAvailableDbcLocale(LocaleConstant locale) const = 0;
    virtual void LoadDBVersion() = 0;
    [[nodiscard]] virtual char const* GetDBVersion() const = 0;
    virtual void UpdateAreaDependentAuras() = 0;
    [[nodiscard]] virtual uint32 GetCleaningFlags() const = 0;
    virtual void   SetCleaningFlags(uint32 flags) = 0;
    virtual void   ResetEventSeasonalQuests(uint16 event_id) = 0;
    [[nodiscard]] virtual std::string const& GetRealmName() const = 0;
    virtual void SetRealmName(std::string name) = 0;
};

#endif //AZEROTHCORE_IWORLD_H
