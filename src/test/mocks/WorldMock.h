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

#ifndef AZEROTHCORE_WORLDMOCK_H
#define AZEROTHCORE_WORLDMOCK_H

#include "ArenaSpectator.h"
#include "Duration.h"
#include "IWorld.h"
#include "gmock/gmock.h"

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

void AddScripts() {}

class WorldMock: public IWorld
{
public:
    ~WorldMock() override { }
    MOCK_METHOD(bool, IsClosed, (), (const));
    MOCK_METHOD(void, SetClosed, (bool val), ());
    MOCK_METHOD(AccountTypes, GetPlayerSecurityLimit, (), (const));
    MOCK_METHOD(void, SetPlayerSecurityLimit, (AccountTypes sec), ());
    MOCK_METHOD(void, LoadDBAllowedSecurityLevel, ());
    MOCK_METHOD(bool, getAllowMovement, (), (const));
    MOCK_METHOD(void, SetAllowMovement, (bool allow), ());
    MOCK_METHOD(void, SetNewCharString, (std::string const& str), ());
    MOCK_METHOD(std::string const&, GetNewCharString, (), (const));
    MOCK_METHOD(LocaleConstant, GetDefaultDbcLocale, (), (const));
    MOCK_METHOD(std::string const&, GetDataPath, (), (const));
    MOCK_METHOD(Seconds, GetNextDailyQuestsResetTime, (), (const));
    MOCK_METHOD(Seconds, GetNextWeeklyQuestsResetTime, (), (const));
    MOCK_METHOD(Seconds, GetNextRandomBGResetTime, (), (const));
    MOCK_METHOD(uint16, GetConfigMaxSkillValue, (), (const));
    MOCK_METHOD(void, SetInitialWorldSettings, ());
    MOCK_METHOD(void, LoadConfigSettings, (bool reload), ());
    MOCK_METHOD(bool, IsShuttingDown, (), (const));
    MOCK_METHOD(uint32, GetShutDownTimeLeft, (), (const));
    MOCK_METHOD(void, ShutdownServ, (uint32 time, uint32 options, uint8 exitcode, const std::string& reason), ());
    MOCK_METHOD(void, ShutdownCancel, ());
    MOCK_METHOD(void, ShutdownMsg, (bool show, Player* player, const std::string& reason), ());
    MOCK_METHOD(void, Update, (uint32 diff), ());
    MOCK_METHOD(void, setRate, (Rates rate, float value), ());
    MOCK_METHOD(float, getRate, (Rates rate), (const));
    MOCK_METHOD(void, setBoolConfig, (WorldBoolConfigs index, bool value), ());
    MOCK_METHOD(bool, getBoolConfig, (WorldBoolConfigs index), (const));
    MOCK_METHOD(void, setFloatConfig, (WorldFloatConfigs index, float value), ());
    MOCK_METHOD(float, getFloatConfig, (WorldFloatConfigs index), (const));
    MOCK_METHOD(void, setIntConfig, (WorldIntConfigs index, uint32 value), ());
    MOCK_METHOD(uint32, getIntConfig, (WorldIntConfigs index), (const));
    MOCK_METHOD(void, setWorldState, (uint32 index, uint64 value), ());
    MOCK_METHOD(uint64, getWorldState, (uint32 index), (const));
    MOCK_METHOD(void, LoadWorldStates, ());
    MOCK_METHOD(bool, IsPvPRealm, (), (const));
    MOCK_METHOD(bool, IsFFAPvPRealm, (), (const));
    MOCK_METHOD(uint32, GetNextWhoListUpdateDelaySecs, ());
    MOCK_METHOD(void, ProcessCliCommands, ());
    MOCK_METHOD(void, QueueCliCommand, (CliCommandHolder* commandHolder), ());
    MOCK_METHOD(void, ForceGameEventUpdate, ());
    MOCK_METHOD(void, UpdateRealmCharCount, (uint32 accid), ());
    MOCK_METHOD(LocaleConstant, GetAvailableDbcLocale, (LocaleConstant locale), (const));
    MOCK_METHOD(void, LoadDBVersion, ());
    MOCK_METHOD(char const *, GetDBVersion, (), (const));
    MOCK_METHOD(void, UpdateAreaDependentAuras, ());
    MOCK_METHOD(uint32, GetCleaningFlags, (), (const));
    MOCK_METHOD(void, SetCleaningFlags, (uint32 flags), ());
    MOCK_METHOD(void, ResetEventSeasonalQuests, (uint16 event_id), ());
    MOCK_METHOD(time_t, GetNextTimeWithDayAndHour, (int8 dayOfWeek, int8 hour), ());
    MOCK_METHOD(time_t, GetNextTimeWithMonthAndHour, (int8 month, int8 hour), ());
    MOCK_METHOD(std::string const&, GetRealmName, (), (const));
    MOCK_METHOD(void, SetRealmName, (std::string name), ());
    MOCK_METHOD(void, RemoveOldCorpses, ());
};
#pragma GCC diagnostic pop

#endif //AZEROTHCORE_WORLDMOCK_H
