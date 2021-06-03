/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef AZEROTHCORE_WORLDMOCK_H
#define AZEROTHCORE_WORLDMOCK_H

#include "ArenaSpectator.h"
#include "gmock/gmock.h"
#include "IWorld.h"

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

void AddScripts() {}
bool ArenaSpectator::HandleSpectatorSpectateCommand(ChatHandler* handler, char const* args) { return false; }

class WorldMock: public IWorld {
public:
    ~WorldMock() override {}
    MOCK_METHOD(WorldSession*, FindSession, (uint32 id), (const));
    MOCK_METHOD(WorldSession*, FindOfflineSession, (uint32 id), (const));
    MOCK_METHOD(WorldSession*, FindOfflineSessionForCharacterGUID, (ObjectGuid::LowType guidLow),(const));
    MOCK_METHOD(void, AddSession, (WorldSession* s), ());
    MOCK_METHOD(void, SendAutoBroadcast, ());
    MOCK_METHOD(bool, KickSession, (uint32 id), ());
    MOCK_METHOD(void, UpdateMaxSessionCounters, ());
    MOCK_METHOD(const SessionMap&, GetAllSessions, (), (const));
    MOCK_METHOD(uint32, GetActiveAndQueuedSessionCount, (), (const));
    MOCK_METHOD(uint32, GetActiveSessionCount, (), (const));
    MOCK_METHOD(uint32, GetQueuedSessionCount, (), (const));
    MOCK_METHOD(uint32, GetMaxQueuedSessionCount, (), (const));
    MOCK_METHOD(uint32, GetMaxActiveSessionCount, (), (const));
    MOCK_METHOD(uint32, GetPlayerCount, (), (const));
    MOCK_METHOD(uint32, GetMaxPlayerCount, (), (const));
    MOCK_METHOD(void, IncreasePlayerCount, ());
    MOCK_METHOD(void, DecreasePlayerCount, ());
    MOCK_METHOD(Player*, FindPlayerInZone, (uint32 zone), ());
    MOCK_METHOD(bool, IsClosed, (), (const));
    MOCK_METHOD(void, SetClosed, (bool val), ());
    MOCK_METHOD(AccountTypes, GetPlayerSecurityLimit, (), (const));
    MOCK_METHOD(void, SetPlayerSecurityLimit, (AccountTypes sec), ());
    MOCK_METHOD(void, LoadDBAllowedSecurityLevel, ());
    MOCK_METHOD(void, SetPlayerAmountLimit, (uint32 limit), ());
    MOCK_METHOD(uint32, GetPlayerAmountLimit, (), (const));
    MOCK_METHOD(void, AddQueuedPlayer, (WorldSession*), ());
    MOCK_METHOD(bool, RemoveQueuedPlayer, (WorldSession* session), ());
    MOCK_METHOD(int32, GetQueuePos, (WorldSession*), ());
    MOCK_METHOD(bool, HasRecentlyDisconnected, (WorldSession*), ());
    MOCK_METHOD(bool, getAllowMovement, (), (const));
    MOCK_METHOD(void, SetAllowMovement, (bool allow), ());
    MOCK_METHOD(void, SetNewCharString, (std::string const& str), ());
    MOCK_METHOD(std::string const&, GetNewCharString, (), (const));
    MOCK_METHOD(LocaleConstant, GetDefaultDbcLocale, (), (const));
    MOCK_METHOD(std::string const&, GetDataPath, (), (const));
    MOCK_METHOD(time_t const&, GetStartTime, (), (const));
    MOCK_METHOD(time_t const&, GetGameTime, (), (const));
    MOCK_METHOD(uint32, GetUptime, (), (const));
    MOCK_METHOD(uint32, GetUpdateTime, (), (const));
    MOCK_METHOD(void, SetRecordDiffInterval, (int32 t));
    MOCK_METHOD(time_t, GetNextDailyQuestsResetTime, (), (const));
    MOCK_METHOD(time_t, GetNextWeeklyQuestsResetTime, (), (const));
    MOCK_METHOD(time_t, GetNextRandomBGResetTime, (), (const));
    MOCK_METHOD(uint16, GetConfigMaxSkillValue, (), (const));
    MOCK_METHOD(void, SetInitialWorldSettings, ());
    MOCK_METHOD(void, LoadConfigSettings, (bool reload), ());
    void SendWorldText(uint32 string_id, ...) override {}
    MOCK_METHOD(void, SendGlobalText, (const char* text, WorldSession* self), ());
    void SendGMText(uint32 string_id, ...) override {}
    MOCK_METHOD(void, SendGlobalMessage, (WorldPacket* packet, WorldSession* self, TeamId teamId), ());
    MOCK_METHOD(void, SendGlobalGMMessage, (WorldPacket* packet, WorldSession* self, TeamId teamId), ());
    MOCK_METHOD(bool, SendZoneMessage, (uint32 zone, WorldPacket* packet, WorldSession* self, TeamId teamId), ());
    MOCK_METHOD(void, SendZoneText, (uint32 zone, const char* text, WorldSession* self, TeamId teamId), ());
    MOCK_METHOD(void, SendServerMessage, (ServerMessageType type, const char* text, Player* player));
    MOCK_METHOD(bool, IsShuttingDown, (), (const));
    MOCK_METHOD(uint32, GetShutDownTimeLeft, (), (const));
    MOCK_METHOD(void, ShutdownServ, (uint32 time, uint32 options, uint8 exitcode), ());
    MOCK_METHOD(void, ShutdownCancel, ());
    MOCK_METHOD(void, ShutdownMsg, (bool show, Player* player), ());
    MOCK_METHOD(void, Update, (uint32 diff), ());
    MOCK_METHOD(void, UpdateSessions, (uint32 diff), ());
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
    MOCK_METHOD(void, KickAll, ());
    MOCK_METHOD(void, KickAllLess, (AccountTypes sec), ());
    MOCK_METHOD(uint32, GetNextWhoListUpdateDelaySecs, ());
    MOCK_METHOD(void, LoadGlobalPlayerDataStore, ());
    MOCK_METHOD(ObjectGuid, GetGlobalPlayerGUID, (std::string const& name), (const));
    MOCK_METHOD(GlobalPlayerData const*, GetGlobalPlayerData, (ObjectGuid::LowType guid), (const));
    MOCK_METHOD(void, AddGlobalPlayerData, (ObjectGuid::LowType guid, uint32 accountId, std::string const& name, uint8 gender, uint8 race, uint8 playerClass, uint8 level, uint16 mailCount, uint32 guildId), ());
    MOCK_METHOD(void, UpdateGlobalPlayerData, (ObjectGuid::LowType guid, uint8 mask, std::string const& name, uint8 level, uint8 gender, uint8 race, uint8 playerClass), ());
    MOCK_METHOD(void, UpdateGlobalPlayerMails, (ObjectGuid::LowType guid, int16 count, bool add), ());
    MOCK_METHOD(void, UpdateGlobalPlayerGuild, (ObjectGuid::LowType guid, uint32 guildId), ());
    MOCK_METHOD(void, UpdateGlobalPlayerGroup, (ObjectGuid::LowType guid, uint32 groupId), ());
    MOCK_METHOD(void, UpdateGlobalPlayerArenaTeam, (ObjectGuid::LowType guid, uint8 slot, uint32 arenaTeamId), ());
    MOCK_METHOD(void, UpdateGlobalNameData, (ObjectGuid::LowType guidLow, std::string const& oldName, std::string const& newName), ());
    MOCK_METHOD(void, DeleteGlobalPlayerData, (ObjectGuid::LowType guid, std::string const& name), ());
    MOCK_METHOD(void, ProcessCliCommands, ());
    MOCK_METHOD(void, QueueCliCommand, (CliCommandHolder* commandHolder), ());
    MOCK_METHOD(void, ForceGameEventUpdate, ());
    MOCK_METHOD(void, UpdateRealmCharCount, (uint32 accid), ());
    MOCK_METHOD(LocaleConstant, GetAvailableDbcLocale, (LocaleConstant locale), (const));
    MOCK_METHOD(void, LoadDBVersion, ());
    MOCK_METHOD(void, LoadDBRevision, ());
    MOCK_METHOD(char const *, GetDBVersion, (), (const));
    MOCK_METHOD(char const *, GetWorldDBRevision, (), (const));
    MOCK_METHOD(char const *, GetCharacterDBRevision, (), (const));
    MOCK_METHOD(char const *, GetAuthDBRevision, (), (const));
    MOCK_METHOD(void, LoadAutobroadcasts, ());
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
