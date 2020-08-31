/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
----- Opcodes Not Used yet -----

SMSG_CALENDAR_EVENT_INVITE_NOTES        [ packguid(Invitee), uint64(inviteId), string(Text), Boolean(Unk) ]
?CMSG_CALENDAR_EVENT_INVITE_NOTES       [ uint32(unk1), uint32(unk2), uint32(unk3), uint32(unk4), uint32(unk5) ]
SMSG_CALENDAR_EVENT_INVITE_NOTES_ALERT  [ uint64(inviteId), string(Text) ]
SMSG_CALENDAR_EVENT_INVITE_STATUS_ALERT [ uint64(eventId), uint32(eventTime), uint32(unkFlag), uint8(deletePending) ]

----- TODO -----

Finish complains' handling - what to do with received complains and how to respond?
Find out what to do with all "not used yet" opcodes
Correct errors sending (event/invite not found, invites exceeded, event already passed, permissions etc.)
Fix locked events to be displayed properly and response time shouldn't be shown for people that haven't respond yet
Copied events should probably have a new owner

*/

#include "InstanceSaveMgr.h"
#include "Log.h"
#include "Opcodes.h"
#include "Player.h"
#include "SocialMgr.h"
#include "CalendarMgr.h"
#include "ObjectAccessor.h"
#include "DatabaseEnv.h"
#include "GuildMgr.h"
#include "ArenaTeamMgr.h"
#include "WorldSession.h"
#include "GameEventMgr.h"
#include "utf8.h"

void WorldSession::HandleCalendarGetCalendar(WorldPacket& /*recvData*/)
{
    uint64 guid = _player->GetGUID();
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_GET_CALENDAR [" UI64FMTD "]", guid);

    time_t currTime = time(nullptr);

    WorldPacket data(SMSG_CALENDAR_SEND_CALENDAR, 1000); // Average size if no instance

    CalendarInviteStore invites = sCalendarMgr->GetPlayerInvites(guid);
    data << uint32(invites.size());
    for (CalendarInviteStore::const_iterator itr = invites.begin(); itr != invites.end(); ++itr)
    {
        data << uint64((*itr)->GetEventId());
        data << uint64((*itr)->GetInviteId());
        data << uint8((*itr)->GetStatus());
        data << uint8((*itr)->GetRank());

        if (CalendarEvent* calendarEvent = sCalendarMgr->GetEvent((*itr)->GetEventId()))
        {
            data << uint8(calendarEvent->IsGuildEvent());
            data.appendPackGUID(calendarEvent->GetCreatorGUID());
        }
        else
        {
            data << uint8(0);
            data.appendPackGUID((*itr)->GetSenderGUID());
        }
    }

    CalendarEventStore playerEvents = sCalendarMgr->GetPlayerEvents(guid);
    data << uint32(playerEvents.size());
    for (CalendarEventStore::const_iterator itr = playerEvents.begin(); itr != playerEvents.end(); ++itr)
    {
        CalendarEvent* calendarEvent = *itr;

        data << uint64(calendarEvent->GetEventId());
        data << calendarEvent->GetTitle();
        data << uint32(calendarEvent->GetType());
        data.AppendPackedTime(calendarEvent->GetEventTime());
        data << uint32(calendarEvent->GetFlags());
        data << int32(calendarEvent->GetDungeonId());
        data.appendPackGUID(calendarEvent->GetCreatorGUID());
    }

    data << uint32(currTime);                              // server time
    data.AppendPackedTime(currTime);                       // zone time

    ByteBuffer dataBuffer;
    uint32 boundCounter = 0;
    for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
    {
        BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(_player->GetGUIDLow(), Difficulty(i));
        for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
        {
            if (itr->second.perm)
            {
                InstanceSave const* save = itr->second.save;
                time_t resetTime = itr->second.extended ? save->GetExtendedResetTime() : save->GetResetTime();
                dataBuffer << uint32(save->GetMapId());
                dataBuffer << uint32(save->GetDifficulty());
                dataBuffer << uint32(resetTime >= currTime ? resetTime-currTime : 0);
                dataBuffer << uint64(MAKE_NEW_GUID(save->GetInstanceId(), 0, HIGHGUID_INSTANCE));     // instance save id as unique instance copy id
                ++boundCounter;
            }
        }
    }

    data << uint32(boundCounter);
    data.append(dataBuffer);

    // pussywizard
    uint32 relationTime = sWorld->getIntConfig(CONFIG_INSTANCE_RESET_TIME_RELATIVE_TIMESTAMP) + sWorld->getIntConfig(CONFIG_INSTANCE_RESET_TIME_HOUR) * HOUR; // set point in time (default 29.12.2005) + X hours
    data << uint32(relationTime);

    // Reuse variables
    boundCounter = 0;
    std::set<uint32> sentMaps;
    dataBuffer.clear();

    ResetTimeByMapDifficultyMap const& resets = sInstanceSaveMgr->GetResetTimeMap();
    for (ResetTimeByMapDifficultyMap::const_iterator itr = resets.begin(); itr != resets.end(); ++itr)
    {
        uint32 mapId = PAIR32_LOPART(itr->first);
        if (sentMaps.find(mapId) != sentMaps.end())
            continue;

        MapEntry const* mapEntry = sMapStore.LookupEntry(mapId);
        if (!mapEntry || !mapEntry->IsRaid())
            continue;

        sentMaps.insert(mapId);

        dataBuffer << int32(mapId);
        time_t period = sInstanceSaveMgr->GetExtendedResetTimeFor(mapId, (Difficulty)PAIR32_HIPART(itr->first)) - itr->second;
        dataBuffer << int32(period); // pussywizard: reset time period
        dataBuffer << int32(0); // pussywizard: reset time offset, needed for other than 7-day periods if not aligned with relationTime
        ++boundCounter;
    }

    data << uint32(boundCounter);
    data.append(dataBuffer);

    // TODO: Fix this, how we do know how many and what holidays to send?
    data << uint32(sGameEventMgr->modifiedHolidays.size());
    for (uint32 entry : sGameEventMgr->modifiedHolidays)
    {
        HolidaysEntry const* holiday = sHolidaysStore.LookupEntry(entry);

        data << uint32(holiday->Id);                        // m_ID
        data << uint32(holiday->Region);                    // m_region, might be looping
        data << uint32(holiday->Looping);                   // m_looping, might be region
        data << uint32(holiday->Priority);                  // m_priority
        data << uint32(holiday->CalendarFilterType);        // m_calendarFilterType

        for (uint8 j = 0; j < MAX_HOLIDAY_DATES; ++j)
            data << uint32(holiday->Date[j]);               // 26 * m_date -- WritePackedTime ?

        for (uint8 j = 0; j < MAX_HOLIDAY_DURATIONS; ++j)
            data << uint32(holiday->Duration[j]);           // 10 * m_duration

        for (uint8 j = 0; j < MAX_HOLIDAY_FLAGS; ++j)
            data << uint32(holiday->CalendarFlags[j]);      // 10 * m_calendarFlags

        data << holiday->TextureFilename;                   // m_textureFilename (holiday name)
    }

    SendPacket(&data);
}

void WorldSession::HandleCalendarGetEvent(WorldPacket& recvData)
{
    uint64 eventId;
    recvData >> eventId;

    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_GET_EVENT. Player ["
        UI64FMTD "] Event [" UI64FMTD "]", _player->GetGUID(), eventId);

    if (CalendarEvent* calendarEvent = sCalendarMgr->GetEvent(eventId))
        sCalendarMgr->SendCalendarEvent(_player->GetGUID(), *calendarEvent, CALENDAR_SENDTYPE_GET);
    else
        sCalendarMgr->SendCalendarCommandResult(_player->GetGUID(), CALENDAR_ERROR_EVENT_INVALID);
}

void WorldSession::HandleCalendarGuildFilter(WorldPacket& recvData)
{
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_GUILD_FILTER [" UI64FMTD "]", _player->GetGUID());

    uint32 minLevel;
    uint32 maxLevel;
    uint32 minRank;

    recvData >> minLevel >> maxLevel >> minRank;

    if (Guild* guild = sGuildMgr->GetGuildById(_player->GetGuildId()))
        guild->MassInviteToEvent(this, minLevel, maxLevel, minRank);

    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_GUILD_FILTER: Min level [%d], Max level [%d], Min rank [%d]", minLevel, maxLevel, minRank);
}

void WorldSession::HandleCalendarArenaTeam(WorldPacket& recvData)
{
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_ARENA_TEAM [" UI64FMTD "]", _player->GetGUID());

    uint32 arenaTeamId;
    recvData >> arenaTeamId;

    if (ArenaTeam* team = sArenaTeamMgr->GetArenaTeamById(arenaTeamId))
        team->MassInviteToEvent(this);
}

bool validUtf8String(WorldPacket& recvData, std::string& s, std::string action, uint64 playerGUID)
{
    if (!utf8::is_valid(s.begin(), s.end()))
    {
        sLog->outString("CalendarHandler: Player with guid %llu attempt to %s an event with invalid name or description (packet modification)", (unsigned long long)playerGUID, action.c_str());
        recvData.rfinish();
        return false;
    }
    return true;
}

void WorldSession::HandleCalendarAddEvent(WorldPacket& recvData)
{
    uint64 guid = _player->GetGUID();

    std::string title;
    std::string description;
    uint8 type;
    uint8 repeatable;
    uint32 maxInvites;
    int32 dungeonId;
    uint32 eventPackedTime;
    uint32 unkPackedTime;
    uint32 flags;

    recvData >> title >> description >> type >> repeatable >> maxInvites >> dungeonId;
    recvData.ReadPackedTime(eventPackedTime);
    recvData.ReadPackedTime(unkPackedTime);
    recvData >> flags;

    // prevent attacks with non-utf8 chars -> with multiple packets it will hang up the db due to errors.
    if (!validUtf8String(recvData, title, "create", guid) || title.size() > 31 || !validUtf8String(recvData, description, "create", guid) || description.size() > 255)
        return;

    // prevent events in the past
    // To Do: properly handle timezones and remove the "- time_t(86400L)" hack
    if (time_t(eventPackedTime) < (time(nullptr) - time_t(86400L)))
    {
        recvData.rfinish();
        sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENT_PASSED);
        return;
    }

    // If the event is a guild event, check if the player is in a guild
    if (CalendarEvent::IsGuildEvent(flags) || CalendarEvent::IsGuildAnnouncement(flags))
    {
        if (!_player->GetGuildId())
        {
            recvData.rfinish();
            sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_GUILD_PLAYER_NOT_IN_GUILD);
            return;
        }
    }

    // Check if the player reached the max number of events allowed to create
    if (CalendarEvent::IsGuildEvent(flags) || CalendarEvent::IsGuildAnnouncement(flags))
    {
        if (sCalendarMgr->GetGuildEvents(_player->GetGuildId()).size() >= CALENDAR_MAX_GUILD_EVENTS)
        {
            recvData.rfinish();
            sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_GUILD_EVENTS_EXCEEDED);
            return;
        }
    }
    else
    {
        if (sCalendarMgr->GetEventsCreatedBy(guid).size() >= CALENDAR_MAX_EVENTS)
        {
            recvData.rfinish();
            sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENTS_EXCEEDED);
            return;
        }
    }

    if (GetCalendarEventCreationCooldown() > time(nullptr))
    {
        recvData.rfinish();
        sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_INTERNAL);
        return;
    }
    SetCalendarEventCreationCooldown(time(nullptr) + CALENDAR_CREATE_EVENT_COOLDOWN);

    CalendarEvent* calendarEvent = new CalendarEvent(sCalendarMgr->GetFreeEventId(), guid, 0, CalendarEventType(type), dungeonId,
        time_t(eventPackedTime), flags, time_t(unkPackedTime), title, description);

    if (calendarEvent->IsGuildEvent() || calendarEvent->IsGuildAnnouncement())
        if (Player* creator = ObjectAccessor::FindPlayerInOrOutOfWorld(guid))
            calendarEvent->SetGuildId(creator->GetGuildId());

    if (calendarEvent->IsGuildAnnouncement())
    {
        // 946684800 is 01/01/2000 00:00:00 - default response time
        CalendarInvite* invite = new CalendarInvite(0, calendarEvent->GetEventId(), 0, guid, 946684800, CALENDAR_STATUS_NOT_SIGNED_UP, CALENDAR_RANK_PLAYER, "");
        sCalendarMgr->AddInvite(calendarEvent, invite);
    }
    else
    {
        uint32 inviteCount;
        uint64 invitee[CALENDAR_MAX_INVITES];
        uint8 status[CALENDAR_MAX_INVITES];
        uint8 rank[CALENDAR_MAX_INVITES];

        memset(invitee, 0, sizeof(invitee));
        memset(status, 0, sizeof(status));
        memset(rank, 0, sizeof(rank));

        try
        {
            recvData >> inviteCount;

            for (uint32 i = 0; i < inviteCount && i < CALENDAR_MAX_INVITES; ++i)
            {
                recvData.readPackGUID(invitee[i]);
                recvData >> status[i] >> rank[i];
            }
        }
        catch (ByteBufferException const&)
        {
            delete calendarEvent;
            calendarEvent = nullptr;
            throw;
        }

        SQLTransaction trans;
        if (inviteCount > 1)
            trans = CharacterDatabase.BeginTransaction();

        for (uint32 i = 0; i < inviteCount && i < CALENDAR_MAX_INVITES; ++i)
        {
            // 946684800 is 01/01/2000 00:00:00 - default response time
            CalendarInvite* invite = new CalendarInvite(sCalendarMgr->GetFreeInviteId(), calendarEvent->GetEventId(), invitee[i], guid, 946684800, CalendarInviteStatus(status[i]), CalendarModerationRank(rank[i]), "");
            sCalendarMgr->AddInvite(calendarEvent, invite, trans);
        }

        if (inviteCount > 1)
            CharacterDatabase.CommitTransaction(trans);
    }

    sCalendarMgr->AddEvent(calendarEvent, CALENDAR_SENDTYPE_ADD);
}

void WorldSession::HandleCalendarUpdateEvent(WorldPacket& recvData)
{
    uint64 guid = _player->GetGUID();
    time_t oldEventTime;

    uint64 eventId;
    uint64 inviteId;
    std::string title;
    std::string description;
    uint8 type;
    uint8 repetitionType;
    uint32 maxInvites;
    int32 dungeonId;
    uint32 eventPackedTime;
    uint32 timeZoneTime;
    uint32 flags;

    recvData >> eventId >> inviteId >> title >> description >> type >> repetitionType >> maxInvites >> dungeonId;
    recvData.ReadPackedTime(eventPackedTime);
    recvData.ReadPackedTime(timeZoneTime);
    recvData >> flags;

    // prevent attacks with non-utf8 chars -> with multiple packets it will hang up the db due to errors.
    if (!validUtf8String(recvData, title, "update", guid) || title.size() > 31 || !validUtf8String(recvData, description, "update", guid) || description.size() > 255)
        return;

    // prevent events in the past
    // To Do: properly handle timezones and remove the "- time_t(86400L)" hack
    if (time_t(eventPackedTime) < (time(nullptr) - time_t(86400L)))
    {
        recvData.rfinish();
        return;
    }

    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_UPDATE_EVENT [" UI64FMTD "] EventId [" UI64FMTD
        "], InviteId [" UI64FMTD "] Title %s, Description %s, type %u "
        "Repeatable %u, MaxInvites %u, Dungeon ID %d, Time %u "
        "Time2 %u, Flags %u", guid, eventId, inviteId, title.c_str(),
        description.c_str(), type, repetitionType, maxInvites, dungeonId,
        eventPackedTime, timeZoneTime, flags);

    if (CalendarEvent* calendarEvent = sCalendarMgr->GetEvent(eventId))
    {
        oldEventTime = calendarEvent->GetEventTime();

        calendarEvent->SetType(CalendarEventType(type));
        calendarEvent->SetFlags(flags);
        calendarEvent->SetEventTime(time_t(eventPackedTime));
        calendarEvent->SetTimeZoneTime(time_t(timeZoneTime)); // Not sure, seems constant from the little sniffs we have
        calendarEvent->SetDungeonId(dungeonId);
        calendarEvent->SetTitle(title);
        calendarEvent->SetDescription(description);

        sCalendarMgr->UpdateEvent(calendarEvent);
        sCalendarMgr->SendCalendarEventUpdateAlert(*calendarEvent, oldEventTime);
    }
    else
        sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENT_INVALID);
}

void WorldSession::HandleCalendarRemoveEvent(WorldPacket& recvData)
{
    uint64 guid = _player->GetGUID();
    uint64 eventId;

    recvData >> eventId;
    recvData.rfinish(); // Skip flags & invite ID, we don't use them

    sCalendarMgr->RemoveEvent(eventId, guid);
}

void WorldSession::HandleCalendarCopyEvent(WorldPacket& recvData)
{
    uint64 guid = _player->GetGUID();
    uint64 eventId;
    uint64 inviteId;
    uint32 eventTime;

    recvData >> eventId >> inviteId;
    recvData.ReadPackedTime(eventTime);
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_COPY_EVENT [" UI64FMTD "], EventId [" UI64FMTD
        "] inviteId [" UI64FMTD "] Time: %u", guid, eventId, inviteId, eventTime);

    // prevent events in the past
    // To Do: properly handle timezones and remove the "- time_t(86400L)" hack
    if (time_t(eventTime) < (time(nullptr) - time_t(86400L)))
    {
        recvData.rfinish();
        sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENT_PASSED);
        return;
    }

    if (CalendarEvent* oldEvent = sCalendarMgr->GetEvent(eventId))
    {
        // Ensure that the player has access to the event
        if (oldEvent->IsGuildEvent() || oldEvent->IsGuildAnnouncement())
        {
            if (oldEvent->GetGuildId() != _player->GetGuildId())
            {
                sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENT_INVALID);
                return;
            }
        }
        else
        {
            if (oldEvent->GetCreatorGUID() != guid)
            {
                sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENT_INVALID);
                return;
            }
        }

        // Check if the player reached the max number of events allowed to create
        if (oldEvent->IsGuildEvent() || oldEvent->IsGuildAnnouncement())
        {
            if (sCalendarMgr->GetGuildEvents(_player->GetGuildId()).size() >= CALENDAR_MAX_GUILD_EVENTS)
            {
                sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_GUILD_EVENTS_EXCEEDED);
                return;
            }
        }
        else
        {
            if (sCalendarMgr->GetEventsCreatedBy(guid).size() >= CALENDAR_MAX_EVENTS)
            {
                sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENTS_EXCEEDED);
                return;
            }
        }

        if (GetCalendarEventCreationCooldown() > time(nullptr))
        {
            sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_INTERNAL);
            return;
        }
        SetCalendarEventCreationCooldown(time(nullptr) + CALENDAR_CREATE_EVENT_COOLDOWN);

        CalendarEvent* newEvent = new CalendarEvent(*oldEvent, sCalendarMgr->GetFreeEventId());
        newEvent->SetEventTime(time_t(eventTime));
        sCalendarMgr->AddEvent(newEvent, CALENDAR_SENDTYPE_COPY);

        CalendarInviteStore invites = sCalendarMgr->GetEventInvites(eventId);
        SQLTransaction trans;
        if (invites.size() > 1)
            trans = CharacterDatabase.BeginTransaction();

        for (CalendarInviteStore::const_iterator itr = invites.begin(); itr != invites.end(); ++itr)
            sCalendarMgr->AddInvite(newEvent, new CalendarInvite(**itr, sCalendarMgr->GetFreeInviteId(), newEvent->GetEventId()), trans);

        if (invites.size() > 1)
            CharacterDatabase.CommitTransaction(trans);
        // should we change owner when somebody makes a copy of event owned by another person?
    }
    else
        sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENT_INVALID);
}

void WorldSession::HandleCalendarEventInvite(WorldPacket& recvData)
{
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_EVENT_INVITE");

    uint64 playerGuid = _player->GetGUID();

    uint64 eventId;
    uint64 inviteId;
    std::string name;
    bool isPreInvite;
    bool isGuildEvent;

    uint64 inviteeGuid = 0;
    uint32 inviteeTeamId = TEAM_NEUTRAL;
    uint32 inviteeGuildId = 0;

    recvData >> eventId >> inviteId >> name >> isPreInvite >> isGuildEvent;

    if (Player* player = ObjectAccessor::FindPlayerByName(name.c_str(), false))
    {
        // Invitee is online
        inviteeGuid = player->GetGUID();
        inviteeTeamId = player->GetTeamId();
        inviteeGuildId = player->GetGuildId();
    }
    else
    {
        // xinef: Get Data From global storage
        if (uint32 guidLow = sWorld->GetGlobalPlayerGUID(name))
        {
            if (GlobalPlayerData const* playerData = sWorld->GetGlobalPlayerData(guidLow))
            {
                inviteeGuid = MAKE_NEW_GUID(guidLow, 0, HIGHGUID_PLAYER);
                inviteeTeamId = Player::TeamIdForRace(playerData->race);
                inviteeGuildId = playerData->guildId;
            }
        }
    }

    if (!inviteeGuid)
    {
        sCalendarMgr->SendCalendarCommandResult(playerGuid, CALENDAR_ERROR_PLAYER_NOT_FOUND);
        return;
    }

    if (_player->GetTeamId() != inviteeTeamId && !sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CALENDAR))
    {
        sCalendarMgr->SendCalendarCommandResult(playerGuid, CALENDAR_ERROR_NOT_ALLIED);
        return;
    }

    // xinef: zomg! sync query
    if (QueryResult result = CharacterDatabase.PQuery("SELECT flags FROM character_social WHERE guid = " UI64FMTD " AND friend = " UI64FMTD, inviteeGuid, playerGuid))
    {
        Field* fields = result->Fetch();
        if (fields[0].GetUInt8() & SOCIAL_FLAG_IGNORED)
        {
            sCalendarMgr->SendCalendarCommandResult(playerGuid, CALENDAR_ERROR_IGNORING_YOU_S, name.c_str());
            return;
        }
    }

    if (!isPreInvite)
    {
        if (CalendarEvent* calendarEvent = sCalendarMgr->GetEvent(eventId))
        {
            if (calendarEvent->IsGuildEvent() && calendarEvent->GetGuildId() == inviteeGuildId)
            {
                // we can't invite guild members to guild events
                sCalendarMgr->SendCalendarCommandResult(playerGuid, CALENDAR_ERROR_NO_GUILD_INVITES);
                return;
            }

            // 946684800 is 01/01/2000 00:00:00 - default response time
            CalendarInvite* invite = new CalendarInvite(sCalendarMgr->GetFreeInviteId(), eventId, inviteeGuid, playerGuid, 946684800, CALENDAR_STATUS_INVITED, CALENDAR_RANK_PLAYER, "");
            sCalendarMgr->AddInvite(calendarEvent, invite);
        }
        else
            sCalendarMgr->SendCalendarCommandResult(playerGuid, CALENDAR_ERROR_EVENT_INVALID);
    }
    else
    {
        if (isGuildEvent && inviteeGuildId == _player->GetGuildId())
        {
            sCalendarMgr->SendCalendarCommandResult(playerGuid, CALENDAR_ERROR_NO_GUILD_INVITES);
            return;
        }

        // 946684800 is 01/01/2000 00:00:00 - default response time
        CalendarInvite* invite = new CalendarInvite(inviteId, 0, inviteeGuid, playerGuid, 946684800, CALENDAR_STATUS_INVITED, CALENDAR_RANK_PLAYER, "");
        sCalendarMgr->SendCalendarEventInvite(*invite);
    }
}

void WorldSession::HandleCalendarEventSignup(WorldPacket& recvData)
{
    uint64 guid = _player->GetGUID();
    uint64 eventId;
    bool tentative;

    recvData >> eventId >> tentative;
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_EVENT_SIGNUP [" UI64FMTD "] EventId [" UI64FMTD "] Tentative %u", guid, eventId, tentative);

    if (CalendarEvent* calendarEvent = sCalendarMgr->GetEvent(eventId))
    {
        if (calendarEvent->IsGuildEvent() && calendarEvent->GetGuildId() != _player->GetGuildId())
        {
            sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_GUILD_PLAYER_NOT_IN_GUILD);
            return;
        }

        CalendarInviteStatus status = tentative ? CALENDAR_STATUS_TENTATIVE : CALENDAR_STATUS_SIGNED_UP;
        CalendarInvite* invite = new CalendarInvite(sCalendarMgr->GetFreeInviteId(), eventId, guid, guid, time(nullptr), status, CALENDAR_RANK_PLAYER, "");
        sCalendarMgr->AddInvite(calendarEvent, invite);
        sCalendarMgr->SendCalendarClearPendingAction(guid);
    }
    else
        sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENT_INVALID);
}

void WorldSession::HandleCalendarEventRsvp(WorldPacket& recvData)
{
    uint64 guid = _player->GetGUID();
    uint64 eventId;
    uint64 inviteId;
    uint32 status;

    recvData >> eventId >> inviteId >> status;
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_EVENT_RSVP [" UI64FMTD"] EventId ["
        UI64FMTD "], InviteId [" UI64FMTD "], status %u", guid, eventId,
        inviteId, status);

    if (CalendarEvent* calendarEvent = sCalendarMgr->GetEvent(eventId))
    {
        // i think we still should be able to remove self from locked events
        if (status != CALENDAR_STATUS_REMOVED && calendarEvent->GetFlags() & CALENDAR_FLAG_INVITES_LOCKED)
        {
            sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENT_LOCKED);
            return;
        }

        if (CalendarInvite* invite = sCalendarMgr->GetInvite(inviteId))
        {
            invite->SetStatus(CalendarInviteStatus(status));
            invite->SetStatusTime(time(nullptr));

            sCalendarMgr->UpdateInvite(invite);
            sCalendarMgr->SendCalendarEventStatus(*calendarEvent, *invite);
            sCalendarMgr->SendCalendarClearPendingAction(guid);
        }
        else
            sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_NO_INVITE); // correct?
    }
    else
        sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENT_INVALID);
}

void WorldSession::HandleCalendarEventRemoveInvite(WorldPacket& recvData)
{
    uint64 guid = _player->GetGUID();
    uint64 invitee;
    uint64 eventId;
    uint64 ownerInviteId; // isn't it sender's inviteId?
    uint64 inviteId;

    recvData.readPackGUID(invitee);
    recvData >> inviteId >> ownerInviteId >> eventId;

    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_EVENT_REMOVE_INVITE ["
        UI64FMTD "] EventId [" UI64FMTD "], ownerInviteId ["
        UI64FMTD "], Invitee ([" UI64FMTD "] id: [" UI64FMTD "])",
        guid, eventId, ownerInviteId, invitee, inviteId);

    if (CalendarEvent* calendarEvent = sCalendarMgr->GetEvent(eventId))
    {
        if (calendarEvent->GetCreatorGUID() == invitee)
        {
            sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_DELETE_CREATOR_FAILED);
            return;
        }

        sCalendarMgr->RemoveInvite(inviteId, eventId, guid);
    }
    else
        sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_NO_INVITE);
}

void WorldSession::HandleCalendarEventStatus(WorldPacket& recvData)
{
    uint64 guid = _player->GetGUID();
    uint64 invitee;
    uint64 eventId;
    uint64 inviteId;
    uint64 ownerInviteId; // isn't it sender's inviteId?
    uint8 status;

    recvData.readPackGUID(invitee);
    recvData >> eventId >> inviteId >> ownerInviteId >> status;
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_EVENT_STATUS [" UI64FMTD"] EventId ["
        UI64FMTD "] ownerInviteId [" UI64FMTD "], Invitee ([" UI64FMTD "] id: ["
        UI64FMTD "], status %u", guid, eventId, ownerInviteId, invitee, inviteId, status);

    if (CalendarEvent* calendarEvent = sCalendarMgr->GetEvent(eventId))
    {
        if (CalendarInvite* invite = sCalendarMgr->GetInvite(inviteId))
        {
            invite->SetStatus((CalendarInviteStatus)status);
            // not sure if we should set response time when moderator changes invite status
            //invite->SetStatusTime(time(nullptr));

            sCalendarMgr->UpdateInvite(invite);
            sCalendarMgr->SendCalendarEventStatus(*calendarEvent, *invite);
            sCalendarMgr->SendCalendarClearPendingAction(invitee);
        }
        else
            sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_NO_INVITE); // correct?
    }
    else
        sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENT_INVALID);
}

void WorldSession::HandleCalendarEventModeratorStatus(WorldPacket& recvData)
{
    uint64 guid = _player->GetGUID();
    uint64 invitee;
    uint64 eventId;
    uint64 inviteId;
    uint64 ownerInviteId; // isn't it sender's inviteId?
    uint8 rank;

    recvData.readPackGUID(invitee);
    recvData >> eventId >>  inviteId >> ownerInviteId >> rank;
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_EVENT_MODERATOR_STATUS [" UI64FMTD "] EventId ["
        UI64FMTD "] ownerInviteId [" UI64FMTD "], Invitee ([" UI64FMTD "] id: ["
        UI64FMTD "], rank %u", guid, eventId, ownerInviteId, invitee, inviteId, rank);

    if (CalendarEvent* calendarEvent = sCalendarMgr->GetEvent(eventId))
    {
        if (CalendarInvite* invite = sCalendarMgr->GetInvite(inviteId))
        {
            invite->SetRank(CalendarModerationRank(rank));
            sCalendarMgr->UpdateInvite(invite);
            sCalendarMgr->SendCalendarEventModeratorStatusAlert(*calendarEvent, *invite);
        }
        else
            sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_NO_INVITE); // correct?
    }
    else
        sCalendarMgr->SendCalendarCommandResult(guid, CALENDAR_ERROR_EVENT_INVALID);
}

void WorldSession::HandleCalendarComplain(WorldPacket& recvData)
{
    uint64 guid = _player->GetGUID();
    uint64 eventId;
    uint64 complainGUID;

    recvData >> eventId >> complainGUID;
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_COMPLAIN [" UI64FMTD "] EventId ["
        UI64FMTD "] guid [" UI64FMTD "]", guid, eventId, complainGUID);

    // what to do with complains?
}

void WorldSession::HandleCalendarGetNumPending(WorldPacket& /*recvData*/)
{
    uint64 guid = _player->GetGUID();
    uint32 pending = sCalendarMgr->GetPlayerNumPending(guid);

    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_CALENDAR_GET_NUM_PENDING: [" UI64FMTD
        "] Pending: %u", guid, pending);

    WorldPacket data(SMSG_CALENDAR_SEND_NUM_PENDING, 4);
    data << uint32(pending);
    SendPacket(&data);
}

void WorldSession::HandleSetSavedInstanceExtend(WorldPacket& recvData)
{
    uint32 mapId, difficulty;
    uint8 toggleExtendOn;
    recvData >> mapId >> difficulty>> toggleExtendOn;

    const MapEntry* entry = sMapStore.LookupEntry(mapId);
    if (!entry || !entry->IsRaid())
        return;

    InstancePlayerBind* instanceBind = sInstanceSaveMgr->PlayerGetBoundInstance(GetPlayer()->GetGUIDLow(), mapId, Difficulty(difficulty));
    if (!instanceBind || !instanceBind->perm || (bool)toggleExtendOn == instanceBind->extended)
        return;

    instanceBind->extended = (bool)toggleExtendOn;

    // update in db
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_INSTANCE_EXTENDED);
    stmt->setUInt8(0, toggleExtendOn ? 1 : 0);
    stmt->setUInt32(1, GetPlayer()->GetGUIDLow());
    stmt->setUInt32(2, instanceBind->save->GetInstanceId());
    CharacterDatabase.Execute(stmt);

    SendCalendarRaidLockoutUpdated(instanceBind->save, (bool)toggleExtendOn);
}

// ----------------------------------- SEND ------------------------------------

void WorldSession::SendCalendarRaidLockout(InstanceSave const* save, bool add)
{
    sLog->outDebug(LOG_FILTER_NETWORKIO, "%s", add ? "SMSG_CALENDAR_RAID_LOCKOUT_ADDED" : "SMSG_CALENDAR_RAID_LOCKOUT_REMOVED");
    time_t currTime = time(nullptr);

    WorldPacket data(SMSG_CALENDAR_RAID_LOCKOUT_REMOVED, (add ? 4 : 0) + 4 + 4 + 4 + 8);
    if (add)
    {
        data.SetOpcode(SMSG_CALENDAR_RAID_LOCKOUT_ADDED);
        data.AppendPackedTime(currTime);
    }

    data << uint32(save->GetMapId());
    data << uint32(save->GetDifficulty());
    data << uint32(save->GetResetTime() >= currTime ? save->GetResetTime()-currTime : 0);
    data << uint64(MAKE_NEW_GUID(save->GetInstanceId(), 0, HIGHGUID_INSTANCE));
    SendPacket(&data);
}

void WorldSession::SendCalendarRaidLockoutUpdated(InstanceSave const* save, bool isExtended)
{
    time_t currTime = time(nullptr);
    time_t resetTime = isExtended ? save->GetExtendedResetTime() : save->GetResetTime();
    time_t resetTimeOp = isExtended ? save->GetResetTime() : save->GetExtendedResetTime();
    WorldPacket data(SMSG_CALENDAR_RAID_LOCKOUT_UPDATED, 4 + 4 + 4 + 4 + 8);
    data.AppendPackedTime(currTime);
    data << uint32(save->GetMapId());
    data << uint32(save->GetDifficulty());
    data << uint32(resetTimeOp >= currTime ? resetTimeOp-currTime : resetTimeOp); // pussywizard: old time in secs to reset
    data << uint32(resetTime >= currTime ? resetTime-currTime : 0); // pussywizard: new time in secs to reset
    SendPacket(&data);
}
