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

#include "GameEventMgr.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "DisableMgr.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "Language.h"
#include "Log.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "PoolMgr.h"
#include "ScriptMgr.h"
#include "Transport.h"
#include "UnitAI.h"
#include "World.h"
#include "WorldSessionMgr.h"
#include "WorldStatePackets.h"
#include <time.h>

GameEventMgr* GameEventMgr::instance()
{
    static GameEventMgr instance;
    return &instance;
}

bool GameEventMgr::CheckOneGameEvent(uint16 entry) const
{
    switch (_gameEvent[entry].State)
    {
        default:
        case GAMEEVENT_NORMAL:
            {
                time_t currenttime = GameTime::GetGameTime().count();
                // Get the event information
                return _gameEvent[entry].Start < currenttime
                       && currenttime < _gameEvent[entry].End
                       && (currenttime - _gameEvent[entry].Start) % (_gameEvent[entry].Occurence * MINUTE) < _gameEvent[entry].Length * MINUTE;
            }
        // if the state is conditions or nextphase, then the event should be active
        case GAMEEVENT_WORLD_CONDITIONS:
        case GAMEEVENT_WORLD_NEXTPHASE:
            return true;
        // finished world events are inactive
        case GAMEEVENT_WORLD_FINISHED:
        case GAMEEVENT_INTERNAL:
            return false;
        // if inactive world event, check the prerequisite events
        case GAMEEVENT_WORLD_INACTIVE:
            {
                time_t currenttime = GameTime::GetGameTime().count();
                for (std::set<uint16>::const_iterator itr = _gameEvent[entry].PrerequisiteEvents.begin(); itr != _gameEvent[entry].PrerequisiteEvents.end(); ++itr)
                {
                    if ((_gameEvent[*itr].State != GAMEEVENT_WORLD_NEXTPHASE && _gameEvent[*itr].State != GAMEEVENT_WORLD_FINISHED) ||   // if prereq not in nextphase or finished state, then can't start this one
                            _gameEvent[*itr].NextStart > currenttime)               // if not in nextphase state for long enough, can't start this one
                        return false;
                }
                // all prerequisite events are met
                // but if there are no prerequisites, this can be only activated through gm command
                return !(_gameEvent[entry].PrerequisiteEvents.empty());
            }
    }
}

uint32 GameEventMgr::NextCheck(uint16 entry) const
{
    time_t currenttime = GameTime::GetGameTime().count();

    // for NEXTPHASE state world events, return the delay to start the next event, so the followup event will be checked correctly
    if ((_gameEvent[entry].State == GAMEEVENT_WORLD_NEXTPHASE || _gameEvent[entry].State == GAMEEVENT_WORLD_FINISHED) && _gameEvent[entry].NextStart >= currenttime)
        return uint32(_gameEvent[entry].NextStart - currenttime);

    // for CONDITIONS state world events, return the length of the wait period, so if the conditions are met, this check will be called again to set the timer as NEXTPHASE event
    if (_gameEvent[entry].State == GAMEEVENT_WORLD_CONDITIONS)
    {
        if (_gameEvent[entry].Length)
            return _gameEvent[entry].Length * 60;
        else
            return max_ge_check_delay;
    }

    // outdated event: we return max
    if (currenttime > _gameEvent[entry].End)
        return max_ge_check_delay;

    // never started event, we return delay before start
    if (_gameEvent[entry].Start > currenttime)
        return uint32(_gameEvent[entry].Start - currenttime);

    uint32 delay;
    // in event, we return the end of it
    if ((((currenttime - _gameEvent[entry].Start) % (_gameEvent[entry].Occurence * 60)) < (_gameEvent[entry].Length * 60)))
        // we return the delay before it ends
        delay = (_gameEvent[entry].Length * MINUTE) - ((currenttime - _gameEvent[entry].Start) % (_gameEvent[entry].Occurence * MINUTE));
    else                                                    // not in window, we return the delay before next start
        delay = (_gameEvent[entry].Occurence * MINUTE) - ((currenttime - _gameEvent[entry].Start) % (_gameEvent[entry].Occurence * MINUTE));
    // In case the end is before next check
    if (_gameEvent[entry].End < time_t(currenttime + delay))
        return uint32(_gameEvent[entry].End - currenttime);
    else
        return delay;
}

void GameEventMgr::StartInternalEvent(uint16 eventId)
{
    if (eventId < 1 || eventId >= _gameEvent.size())
        return;

    if (!_gameEvent[eventId].isValid())
        return;

    if (_activeEvents.find(eventId) != _activeEvents.end())
        return;

    StartEvent(eventId);
}

bool GameEventMgr::StartEvent(uint16 eventId, bool overwrite)
{
    if (sDisableMgr->IsDisabledFor(DISABLE_TYPE_GAME_EVENT, eventId, nullptr) && !overwrite)
        return false;

    GameEventData& data = _gameEvent[eventId];
    if (data.State == GAMEEVENT_NORMAL || data.State == GAMEEVENT_INTERNAL)
    {
        AddActiveEvent(eventId);
        ApplyNewEvent(eventId);
        if (overwrite)
        {
            _gameEvent[eventId].Start = GameTime::GetGameTime().count();
            if (data.End <= data.Start)
                data.End = data.Start + data.Length;
        }

        if (IsActiveEvent(eventId))
            sScriptMgr->OnGameEventStart(eventId);

        // When event is started, set its worldstate to current time
        auto itr = _gameEventSeasonalQuestsMap.find(eventId);
        if (itr != _gameEventSeasonalQuestsMap.end() && !itr->second.empty())
        {
            sWorld->setWorldState(eventId, GameTime::GetGameTime().count());
        }

        return false;
    }
    else
    {
        if (data.State == GAMEEVENT_WORLD_INACTIVE)
            // set to conditions phase
            data.State = GAMEEVENT_WORLD_CONDITIONS;

        // add to active events
        AddActiveEvent(eventId);
        // add spawns
        ApplyNewEvent(eventId);

        // check if can go to next state
        bool conditions_met = CheckOneGameEventConditions(eventId);
        // save to db
        SaveWorldEventStateToDB(eventId);
        // force game event update to set the update timer if conditions were met from a command
        // this update is needed to possibly start events dependent on the started one
        // or to scedule another update where the next event will be started
        if (overwrite && conditions_met)
            sWorld->ForceGameEventUpdate();

        if (IsActiveEvent(eventId))
            sScriptMgr->OnGameEventStart(eventId);

        return conditions_met;
    }
}

void GameEventMgr::StopEvent(uint16 eventId, bool overwrite)
{
    GameEventData& data = _gameEvent[eventId];
    bool serverwide_evt = data.State != GAMEEVENT_NORMAL && data.State != GAMEEVENT_INTERNAL;

    RemoveActiveEvent(eventId);
    UnApplyEvent(eventId);

     // When event is stopped, clean up its worldstate
    sWorld->setWorldState(eventId, 0);

    if (overwrite && !serverwide_evt)
    {
        data.Start = GameTime::GetGameTime().count() - data.Length * MINUTE;
        if (data.End <= data.Start)
            data.End = data.Start + data.Length;
    }
    else if (serverwide_evt)
    {
        // if finished world event, then only gm command can stop it
        if (overwrite || data.State != GAMEEVENT_WORLD_FINISHED)
        {
            // reset conditions
            data.NextStart = 0;
            data.State = GAMEEVENT_WORLD_INACTIVE;
            GameEventConditionMap::iterator itr;
            for (itr = data.Conditions.begin(); itr != data.Conditions.end(); ++itr)
                itr->second.Done = 0;

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ALL_GAME_EVENT_CONDITION_SAVE);
            stmt->SetData(0, uint8(eventId));
            trans->Append(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GAME_EVENT_SAVE);
            stmt->SetData(0, uint8(eventId));
            trans->Append(stmt);

            CharacterDatabase.CommitTransaction(trans);
        }
    }

    if (!IsActiveEvent(eventId))
        sScriptMgr->OnGameEventStop(eventId);
}

void GameEventMgr::LoadEventVendors()
{
    LOG_INFO("server.loading", "Loading Game Event Vendor Additions Data...");
    uint32 oldMSTime = getMSTime();
    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_NPC_VENDOR);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Vendor Additions In Game Events. DB Table `game_event_npc_vendor` Is Empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    std::unordered_set<uint8> processedEvents;

    do
    {
        Field* fields = result->Fetch();
        uint8 eventId = fields[0].Get<uint8>();
        ObjectGuid::LowType guid = fields[1].Get<uint32>();

        if (eventId >= _gameEventVendors.size())
        {
            LOG_ERROR("sql.sql", "Table `game_event_npc_vendor` has invalid eventEntry ({}) for GUID ({}), skipped.", eventId, guid);
            continue;
        }

        // Clear existing vendors for this event only once
        if (processedEvents.find(eventId) == processedEvents.end())
        {
            // Remove vendor items from in-memory data
            for (auto& entry : _gameEventVendors[eventId])
            {
                sObjectMgr->RemoveVendorItem(entry.Entry, entry.Item, false);
            }
            _gameEventVendors[eventId].clear();
            processedEvents.insert(eventId);
        }

        NPCVendorList& vendors = _gameEventVendors[eventId];
        NPCVendorEntry newEntry;
        newEntry.Item = fields[2].Get<uint32>();
        newEntry.MaxCount = fields[3].Get<uint32>();
        newEntry.Incrtime = fields[4].Get<uint32>();
        newEntry.ExtendedCost = fields[5].Get<uint32>();

        // Get the event NPC flag for validity check
        uint32 event_npc_flag = 0;
        NPCFlagList& flist = _gameEventNPCFlags[eventId];
        for (NPCFlagList::const_iterator itr = flist.begin(); itr != flist.end(); ++itr)
        {
            if (itr->first == guid)
            {
                event_npc_flag = itr->second;
                break;
            }
        }

        // Get creature entry
        newEntry.Entry = 0;
        if (CreatureData const* data = sObjectMgr->GetCreatureData(guid))
            newEntry.Entry = data->id1;

        // Validate vendor item
        if (!sObjectMgr->IsVendorItemValid(newEntry.Entry, newEntry.Item, newEntry.MaxCount, newEntry.Incrtime, newEntry.ExtendedCost, nullptr, nullptr, event_npc_flag))
        {
            LOG_ERROR("sql.sql", "Table `game_event_npc_vendor` has invalid item ({}) for guid ({}) for event ({}), skipped.",
                newEntry.Item, newEntry.Entry, eventId);
            continue;
        }

        // Add the item to the vendor if event is active
        if (IsEventActive(eventId))
            sObjectMgr->AddVendorItem(newEntry.Entry, newEntry.Item, newEntry.MaxCount, newEntry.Incrtime, newEntry.ExtendedCost, false);

        vendors.push_back(newEntry);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Vendor Additions In Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");

}

void GameEventMgr::LoadEvents()
{
    LOG_INFO("server.loading", "Loading Game Events...");
    uint32 oldMSTime = getMSTime();
    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENTS);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        _gameEvent.clear();
        LOG_WARN("server.loading", ">> Loaded 0 game events. DB table `game_event` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint8 eventId = fields[0].Get<uint8>();
        if (eventId == 0)
        {
            LOG_ERROR("sql.sql", "`game_event` game event entry 0 is reserved and can't be used.");
            continue;
        }

        GameEventData& pGameEvent = _gameEvent[eventId];
        pGameEvent.EventId      = fields[0].Get<uint32>();
        uint64 starttime        = fields[1].Get<uint64>();
        pGameEvent.Start        = time_t(starttime);
        uint64 endtime          = fields[2].Get<uint64>();
        if (fields[2].IsNull())
            endtime             = GameTime::GetGameTime().count() + 63072000; // add 2 years to current date
        pGameEvent.End          = time_t(endtime);
        pGameEvent.Occurence    = fields[3].Get<uint64>();
        pGameEvent.Length       = fields[4].Get<uint64>();
        pGameEvent.HolidayId    = HolidayIds(fields[5].Get<uint32>());
        pGameEvent.HolidayStage = fields[6].Get<uint8>();
        pGameEvent.Description  = fields[7].Get<std::string>();
        pGameEvent.State        = (GameEventState)(fields[8].Get<uint8>());
        pGameEvent.Announce     = fields[9].Get<uint8>();
        pGameEvent.NextStart    = 0;

        ++count;

        if (pGameEvent.Length == 0 && pGameEvent.State == GAMEEVENT_NORMAL)                            // length>0 is validity check
        {
            LOG_ERROR("sql.sql", "`game_event` game event id ({}) isn't a world event and has length = 0, thus it can't be used.", eventId);
            continue;
        }

        if (pGameEvent.HolidayId != HOLIDAY_NONE)
        {
            if (!sHolidaysStore.LookupEntry(pGameEvent.HolidayId))
            {
                LOG_ERROR("sql.sql", "`game_event` game event id ({}) have not existed holiday id {}.", eventId, pGameEvent.HolidayId);
                pGameEvent.HolidayId = HOLIDAY_NONE;
            }

            SetHolidayEventTime(pGameEvent);
        }
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void GameEventMgr::LoadEventSaveData()
{
    uint32 oldMSTime = getMSTime();
    LOG_INFO("server.loading", "Loading Game Event Saves Data...");
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_GAME_EVENT_SAVE_DATA);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Game Event Saves In Game Events. DB Table `game_event_save` Is Empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            uint8 eventId = fields[0].Get<uint8>();

            if (eventId >= _gameEvent.size())
            {
                LOG_ERROR("sql.sql", "`game_event_save` game event entry ({}) is out of range compared to max event entry in `game_event`", eventId);
                continue;
            }

            if (_gameEvent[eventId].State != GAMEEVENT_NORMAL && _gameEvent[eventId].State != GAMEEVENT_INTERNAL)
            {
                _gameEvent[eventId].State = (GameEventState)(fields[1].Get<uint8>());
                _gameEvent[eventId].NextStart = time_t(fields[2].Get<uint32>());
            }
            else
            {
                LOG_ERROR("sql.sql", "game_event_save includes event save for non-worldevent id {}", eventId);
                continue;
            }

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Game Event Saves In Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventPrerequisiteData()
{
    LOG_INFO("server.loading", "Loading Game Event Prerequisite Data...");

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_PREREQUISITE_DATA);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Game Rvent Prerequisites in Game Events. DB Table `game_event_prerequisite` Is Empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            uint16 eventId = fields[0].Get<uint8>();

            if (eventId >= _gameEvent.size())
            {
                LOG_ERROR("sql.sql", "`game_event_prerequisite` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            if (_gameEvent[eventId].State != GAMEEVENT_NORMAL && _gameEvent[eventId].State != GAMEEVENT_INTERNAL)
            {
                uint16 prerequisite_event = fields[1].Get<uint32>();
                if (prerequisite_event >= _gameEvent.size())
                {
                    LOG_ERROR("sql.sql", "`game_event_prerequisite` game event prerequisite id ({}) is out of range compared to max event id in `game_event`", prerequisite_event);
                    continue;
                }
                _gameEvent[eventId].PrerequisiteEvents.insert(prerequisite_event);
            }
            else
            {
                LOG_ERROR("sql.sql", "game_event_prerequisiste includes event entry for non-worldevent id {}", eventId);
                continue;
            }

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} game event prerequisites in Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventCreatureData()
{
    LOG_INFO("server.loading", "Loading Game Event Creature Data...");

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_CREATURE_DATA);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 creatures in game events. DB table `game_event_creature` is empty");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            ObjectGuid::LowType guid = fields[0].Get<uint32>();
            int16 eventId = fields[1].Get<int8>();

            CreatureData const* data = sObjectMgr->GetCreatureData(guid);
            if (!data)
            {
                LOG_ERROR("sql.sql", "`game_event_creature` contains creature (GUID: {}) not found in `creature` table.", guid);
                continue;
            }

            int32 internal_event_id = _gameEvent.size() + eventId - 1;

            if (internal_event_id < 0 || internal_event_id >= int32(GameEventCreatureGuids.size()))
            {
                LOG_ERROR("sql.sql", "`game_event_creature` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            GuidLowList& crelist = GameEventCreatureGuids[internal_event_id];
            crelist.push_back(guid);

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Creatures In Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventGameObjectData()
{
    LOG_INFO("server.loading", "Loading Game Event GO Data...");

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_GAMEOBJECT_DATA);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 gameobjects in game events. DB table `game_event_gameobject` is empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            ObjectGuid::LowType guid = fields[0].Get<uint32>();
            int16 eventId = fields[1].Get<int8>();

            int32 internal_event_id = _gameEvent.size() + eventId - 1;

            GameObjectData const* data = sObjectMgr->GetGameObjectData(guid);
            if (!data)
            {
                LOG_ERROR("sql.sql", "`game_event_gameobject` contains gameobject (GUID: {}) not found in `gameobject` table.", guid);
                continue;
            }

            if (internal_event_id < 0 || internal_event_id >= int32(GameEventGameobjectGuids.size()))
            {
                LOG_ERROR("sql.sql", "`game_event_gameobject` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            GuidLowList& golist = GameEventGameobjectGuids[internal_event_id];
            golist.push_back(guid);

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Gameobjects In Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventModelEquipmentChangeData()
{
    LOG_INFO("server.loading", "Loading Game Event Model/Equipment Change Data...");

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_MODEL_EQUIPMENT_DATA);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Model/Equipment Changes In Game Events. DB Table `game_event_model_equip` Is Empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            ObjectGuid::LowType guid = fields[0].Get<uint32>();
            uint32 entry = fields[1].Get<uint32>();
            uint32 entry2 = fields[2].Get<uint32>();
            uint32 entry3 = fields[3].Get<uint32>();
            uint16 eventId = fields[4].Get<uint8>();

            if (eventId >= _gameEventModelEquip.size())
            {
                LOG_ERROR("sql.sql", "`game_event_model_equip` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            ModelEquipList& equiplist = _gameEventModelEquip[eventId];
            ModelEquip newModelEquipSet;
            newModelEquipSet.ModelId = fields[5].Get<uint32>();
            newModelEquipSet.EquipmentId = fields[6].Get<uint8>();
            newModelEquipSet.EquipementIdPrev = 0;
            newModelEquipSet.ModelIdPrev = 0;

            if (newModelEquipSet.EquipmentId > 0)
            {
                int8 equipId = static_cast<int8>(newModelEquipSet.EquipmentId);
                if ((!sObjectMgr->GetEquipmentInfo(entry, equipId)) || (entry2 && !sObjectMgr->GetEquipmentInfo(entry2, equipId)) || (entry3 && !sObjectMgr->GetEquipmentInfo(entry3, equipId)))
                {
                    LOG_ERROR("sql.sql", "Table `game_event_model_equip` have creature (Guid: {}) with equipment_id {} not found in table `creature_equip_template`, set to no equipment.",
                        guid, newModelEquipSet.EquipmentId);
                    continue;
                }
            }

            equiplist.push_back(std::pair<ObjectGuid::LowType, ModelEquip>(guid, newModelEquipSet));

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Model/Equipment Changes In Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventQuestData()
{
    LOG_INFO("server.loading", "Loading Game Event Quest Data...");

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_QUEST_DATA);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Quests Additions In Game Events. DB Table `game_event_creature_quest` Is Empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            uint32 id = fields[0].Get<uint32>();
            uint32 quest = fields[1].Get<uint32>();
            uint16 eventId = fields[2].Get<uint8>();

            if (eventId >= _gameEventCreatureQuests.size())
            {
                LOG_ERROR("sql.sql", "`game_event_creature_quest` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            QuestRelList& questlist = _gameEventCreatureQuests[eventId];
            questlist.push_back(QuestRelation(id, quest));

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Quests Additions In Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventGameObjectQuestData()
{
    LOG_INFO("server.loading", "Loading Game Event GO Quest Data...");

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_GAMEOBJECT_QUEST_DATA);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 go Quests Additions In Game Events. DB Table `game_event_gameobject_quest` Is Empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            uint32 id = fields[0].Get<uint32>();
            uint32 quest = fields[1].Get<uint32>();
            uint16 eventId = fields[2].Get<uint8>();

            if (eventId >= _gameEventGameObjectQuests.size())
            {
                LOG_ERROR("sql.sql", "`game_event_gameobject_quest` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            QuestRelList& questlist = _gameEventGameObjectQuests[eventId];
            questlist.push_back(QuestRelation(id, quest));

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Quests Additions In Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventQuestConditionData()
{
    LOG_INFO("server.loading", "Loading Game Event Quest Condition Data...");

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_QUEST_CONDITION_DATA);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 quest event Conditions In Game Events. DB Table `game_event_quest_condition` Is Empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            uint32 quest = fields[0].Get<uint32>();
            uint16 eventId = fields[1].Get<uint8>();
            uint32 condition = fields[2].Get<uint32>();
            float num = fields[3].Get<float>();

            if (eventId >= _gameEvent.size())
            {
                LOG_ERROR("sql.sql", "`game_event_quest_condition` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            _questToEventConditions[quest].EventId = eventId;
            _questToEventConditions[quest].Condition = condition;
            _questToEventConditions[quest].Num = num;

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} quest event conditions in Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventConditionData()
{
    LOG_INFO("server.loading", "Loading Game Event Condition Data...");

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_CONDITION_DATA);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Conditions In Game Events. DB table `game_event_condition` Is Empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            uint16 eventId = fields[0].Get<uint8>();
            uint32 condition = fields[1].Get<uint32>();

            if (eventId >= _gameEvent.size())
            {
                LOG_ERROR("sql.sql", "`game_event_condition` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            _gameEvent[eventId].Conditions[condition].ReqNum = fields[2].Get<float>();
            _gameEvent[eventId].Conditions[condition].Done = 0;
            _gameEvent[eventId].Conditions[condition].MaxWorldState = fields[3].Get<uint16>();
            _gameEvent[eventId].Conditions[condition].DoneWorldState = fields[4].Get<uint16>();

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} conditions in Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventConditionSaveData()
{
    LOG_INFO("server.loading", "Loading Game Event Condition Save Data...");

    uint32 oldMSTime = getMSTime();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_GAME_EVENT_CONDITION_SAVE_DATA);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Condition Saves In Game Events. DB Table `game_event_condition_save` Is Empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            uint16 eventId = fields[0].Get<uint8>();
            uint32 condition = fields[1].Get<uint32>();

            if (eventId >= _gameEvent.size())
            {
                LOG_ERROR("sql.sql", "`game_event_condition_save` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            GameEventConditionMap::iterator itr = _gameEvent[eventId].Conditions.find(condition);
            if (itr != _gameEvent[eventId].Conditions.end())
            {
                itr->second.Done = fields[2].Get<float>();
            }
            else
            {
                LOG_ERROR("sql.sql", "game_event_condition_save contains not present condition evt id {} cond id {}", eventId, condition);
                continue;
            }

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Condition Saves In Game Events In {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventNPCFlags()
{
    LOG_INFO("server.loading", "Loading Game Event NPCflag Data...");

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement * stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_NPC_FLAGS);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Npcflags In Game Events. DB Table `game_event_npcflag` Is Empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            ObjectGuid::LowType guid = fields[0].Get<uint32>();
            uint16 eventId = fields[1].Get<uint8>();
            uint32 npcflag = fields[2].Get<uint32>();

            if (eventId >= _gameEvent.size())
            {
                LOG_ERROR("sql.sql", "`game_event_npcflag` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            _gameEventNPCFlags[eventId].push_back(GuidNPCFlagPair(guid, npcflag));

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Npcflags In Game Events In {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventSeasonalQuestRelations()
{
    LOG_INFO("server.loading", "Loading Game Event Seasonal Quest Relations...");
    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_QUEST_SEASONAL_RELATIONS);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Seasonal Quests Additions In Game Events. DB Table `game_event_seasonal_questrelation` Is Empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            uint32 questId = fields[0].Get<uint32>();
            uint32 eventEntry = fields[1].Get<uint32>(); /// @todo: Change to uint8

            Quest* questTemplate = const_cast<Quest*>(sObjectMgr->GetQuestTemplate(questId));

            if (!questTemplate)
            {
                LOG_ERROR("sql.sql", "`game_event_seasonal_questrelation` quest id ({}) does not exist in `quest_template`", questId);
                continue;
            }

            if (eventEntry >= _gameEvent.size())
            {
                LOG_ERROR("sql.sql", "`game_event_seasonal_questrelation` event id ({}) is out of range compared to max event in `game_event`", eventEntry);
                continue;
            }

            questTemplate->SetEventIdForQuest((uint16)eventEntry);
            _gameEventSeasonalQuestsMap[eventEntry].push_back(questId);
            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Quests Additions In Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventBattlegroundData()
{
    LOG_INFO("server.loading", "Loading Game Event Battleground Data...");

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_BATTLEGROUND_DATA);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Battleground Holidays In Game Events. DB table `game_event_battleground_holiday` is empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            uint16 eventId = fields[0].Get<uint8>();

            if (eventId >= _gameEvent.size())
            {
                LOG_ERROR("sql.sql", "`game_event_battleground_holiday` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            _gameEventBattlegroundHolidays[eventId] = fields[1].Get<uint32>();

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Battleground Holidays In Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadEventPoolData()
{
    LOG_INFO("server.loading", "Loading Game Event Pool Data...");

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_POOL_DATA);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Pools For Game Events. DB Table `game_event_pool` Is Empty.");
        LOG_INFO("server.loading", " ");
    }
    else
    {
        uint32 count = 0;
        do
        {
            Field* fields = result->Fetch();

            uint32 entry = fields[0].Get<uint32>();
            int16 eventId = fields[1].Get<int8>();

            int32 internal_event_id = _gameEvent.size() + eventId - 1;

            if (internal_event_id < 0 || internal_event_id >= int32(_gameEventPoolIds.size()))
            {
                LOG_ERROR("sql.sql", "`game_event_pool` game event id ({}) is out of range compared to max event id in `game_event`", eventId);
                continue;
            }

            if (!sPoolMgr->CheckPool(entry))
            {
                LOG_ERROR("sql.sql", "Pool Id ({}) has all creatures or gameobjects with explicit chance sum <>100 and no equal chance defined. The pool system cannot pick one to spawn.", entry);
                continue;
            }

            IdList& poollist = _gameEventPoolIds[internal_event_id];
            poollist.push_back(entry);

            ++count;
        } while (result->NextRow());

        LOG_INFO("server.loading", ">> Loaded {} Pools For Game Events in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GameEventMgr::LoadFromDB()
{
    // The order of these functions matter. Do not change
    LoadEvents();
    LoadEventSaveData();
    LoadEventPrerequisiteData();
    LoadEventCreatureData();
    LoadEventGameObjectData();
    LoadEventModelEquipmentChangeData();
    LoadEventQuestData();
    LoadEventGameObjectQuestData();
    LoadEventQuestConditionData();
    LoadEventConditionData();
    LoadEventConditionSaveData();
    LoadEventNPCFlags();
    LoadEventSeasonalQuestRelations();
    LoadEventVendors();
    LoadEventBattlegroundData();
    LoadEventPoolData();
}

void GameEventMgr::LoadHolidayDates()
{
    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_EVENT_HOLIDAY_DATES);
    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 holiday dates. DB table `holiday_dates` is empty.");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 holidayId = fields[0].Get<uint32>();
        HolidaysEntry* entry = const_cast<HolidaysEntry*>(sHolidaysStore.LookupEntry(holidayId));
        if (!entry)
        {
            LOG_ERROR("sql.sql", "holiday_dates entry has invalid holiday id {}.", holidayId);
            continue;
        }

        uint8 dateId = fields[1].Get<uint8>();
        if (dateId >= MAX_HOLIDAY_DATES)
        {
            LOG_ERROR("sql.sql", "holiday_dates entry has out of range date_id {}.", dateId);
            continue;
        }
        entry->Date[dateId] = fields[2].Get<uint32>();

        if (uint32 duration = fields[3].Get<uint32>())
            entry->Duration[0] = duration;

        auto itr = std::lower_bound(ModifiedHolidays.begin(), ModifiedHolidays.end(), entry->Id);
        if (itr == ModifiedHolidays.end() || *itr != entry->Id)
        {
            ModifiedHolidays.insert(itr, entry->Id);
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Holiday Dates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
}

uint32 GameEventMgr::GetNPCFlag(Creature* cr)
{
    uint32 mask = 0;
    ObjectGuid::LowType spawnId = cr->GetSpawnId();

    for (ActiveEvents::iterator e_itr = _activeEvents.begin(); e_itr != _activeEvents.end(); ++e_itr)
    {
        for (NPCFlagList::iterator itr = _gameEventNPCFlags[*e_itr].begin(); itr != _gameEventNPCFlags[*e_itr].end(); ++ itr)
            if (itr->first == spawnId)
                mask |= itr->second;
    }

    return mask;
}

void GameEventMgr::Initialize()
{
    QueryResult result = WorldDatabase.Query("SELECT MAX(eventEntry) FROM game_event");
    if (result)
    {
        Field* fields = result->Fetch();

        uint32 maxEventId = fields[0].Get<uint8>();

        // Id starts with 1 and vector with 0, thus increment
        maxEventId++;

        _gameEvent.resize(maxEventId);
        GameEventCreatureGuids.resize(maxEventId * 2 - 1);
        GameEventGameobjectGuids.resize(maxEventId * 2 - 1);
        _gameEventCreatureQuests.resize(maxEventId);
        _gameEventGameObjectQuests.resize(maxEventId);
        _gameEventVendors.resize(maxEventId);
        _gameEventBattlegroundHolidays.resize(maxEventId, 0);
        _gameEventPoolIds.resize(maxEventId * 2 - 1);
        _gameEventNPCFlags.resize(maxEventId);
        _gameEventModelEquip.resize(maxEventId);
    }
}

uint32 GameEventMgr::StartSystem()                           // return the next event delay in ms
{
    _activeEvents.clear();
    uint32 delay = Update();
    _isSystemInit = true;
    return delay;
}

uint32 GameEventMgr::Update()                               // return the next event delay in ms
{
    time_t currenttime = GameTime::GetGameTime().count();
    uint32 nextEventDelay = max_ge_check_delay;             // 1 day
    uint32 calcDelay;
    std::set<uint16> activate, deactivate;
    for (uint16 itr = 1; itr < _gameEvent.size(); ++itr)
    {
        // must do the activating first, and after that the deactivating
        // so first queue it
        //LOG_ERROR("sql.sql", "Checking event {}", itr);

        sScriptMgr->OnGameEventCheck(itr);

        if (CheckOneGameEvent(itr))
        {
            // if the world event is in NEXTPHASE state, and the time has passed to finish this event, then do so
            if (_gameEvent[itr].State == GAMEEVENT_WORLD_NEXTPHASE && _gameEvent[itr].NextStart <= currenttime)
            {
                // set this event to finished, null the nextstart time
                _gameEvent[itr].State = GAMEEVENT_WORLD_FINISHED;
                _gameEvent[itr].NextStart = 0;
                // save the state of this gameevent
                SaveWorldEventStateToDB(itr);
                // queue for deactivation
                if (IsActiveEvent(itr))
                    deactivate.insert(itr);
                // go to next event, this no longer needs an event update timer
                continue;
            }
            else if (_gameEvent[itr].State == GAMEEVENT_WORLD_CONDITIONS && CheckOneGameEventConditions(itr))
                // changed, save to DB the gameevent state, will be updated in next update cycle
                SaveWorldEventStateToDB(itr);

            // queue for activation
            if (!IsActiveEvent(itr))
                activate.insert(itr);
        }
        else
        {
            // If event is inactive, periodically clean up its worldstate
            sWorld->setWorldState(itr, 0);

            if (IsActiveEvent(itr))
            {
                // Xinef: do not deactivate internal events on whim
                if (_gameEvent[itr].State != GAMEEVENT_INTERNAL)
                    deactivate.insert(itr);
            }
            else
            {
                if (!_isSystemInit)
                {
                    int16 event_nid = (-1) * (itr);
                    // spawn all negative ones for this event
                    GameEventSpawn(event_nid);
                }
            }
        }
        calcDelay = NextCheck(itr);
        if (calcDelay < nextEventDelay)
            nextEventDelay = calcDelay;
    }
    // now activate the queue
    // a now activated event can contain a spawn of a to-be-deactivated one
    // following the activate - deactivate order, deactivating the first event later will leave the spawn in (wont disappear then reappear clientside)
    for (std::set<uint16>::iterator itr = activate.begin(); itr != activate.end(); ++itr)
        // start the event
        // returns true the started event completed
        // in that case, initiate next update in 1 second
        if (StartEvent(*itr))
            nextEventDelay = 0;
    for (std::set<uint16>::iterator itr = deactivate.begin(); itr != deactivate.end(); ++itr)
        StopEvent(*itr);

    LOG_DEBUG("gameevent", "Next game event check in {} seconds.", nextEventDelay + 1);
    return (nextEventDelay + 1) * IN_MILLISECONDS;           // Add 1 second to be sure event has started/stopped at next call
}

void GameEventMgr::UnApplyEvent(uint16 eventId)
{
    LOG_DEBUG("gameevent", "GameEvent {} \"{}\" removed.", eventId, _gameEvent[eventId].Description);
    //! Run SAI scripts with SMART_EVENT_GAME_EVENT_END
    RunSmartAIScripts(eventId, false);
    // un-spawn positive event tagged objects
    GameEventUnspawn(eventId);
    // spawn negative event tagget objects
    int16 numEventId = (-1) * eventId;
    GameEventSpawn(numEventId);
    // restore equipment or model
    ChangeEquipOrModel(eventId, false);
    // Remove quests that are events only to non event npc
    UpdateEventQuests(eventId, false);
    UpdateWorldStates(eventId, false);
    // update npcflags in this event
    UpdateEventNPCFlags(eventId);
    // remove vendor items
    UpdateEventNPCVendor(eventId, false);
    // update bg holiday
    UpdateBattlegroundSettings();
}

void GameEventMgr::ApplyNewEvent(uint16 eventId)
{
    uint8 announce = _gameEvent[eventId].Announce;
    if (announce == 1 || (announce == 2 && sWorld->getIntConfig(CONFIG_EVENT_ANNOUNCE)))
        ChatHandler(nullptr).SendWorldText(LANG_EVENTMESSAGE, _gameEvent[eventId].Description);

    LOG_DEBUG("gameevent", "GameEvent {} \"{}\" started.", eventId, _gameEvent[eventId].Description);

    // spawn positive event tagget objects
    GameEventSpawn(eventId);
    // un-spawn negative event tagged objects
    int16 numEventId = (-1) * eventId;
    GameEventUnspawn(numEventId);
    // Change equipement or model
    ChangeEquipOrModel(eventId, true);
    // Add quests that are events only to non event npc
    UpdateEventQuests(eventId, true);
    UpdateWorldStates(eventId, true);
    // update npcflags in this event
    UpdateEventNPCFlags(eventId);
    // add vendor items
    UpdateEventNPCVendor(eventId, true);
    // update bg holiday
    UpdateBattlegroundSettings();

    //! Run SAI scripts with SMART_EVENT_GAME_EVENT_START
    RunSmartAIScripts(eventId, true);

    // If event's worldstate is 0, it means the event hasn't been started yet. In that case, reset seasonal quests.
    // When event ends (if it expires or if it's stopped via commands) worldstate will be set to 0 again, ready for another seasonal quest reset.
    if (sWorld->getWorldState(eventId) == 0)
    {
        sWorld->ResetEventSeasonalQuests(eventId);
    }
}

void GameEventMgr::UpdateEventNPCFlags(uint16 eventId)
{
    std::unordered_map<uint32, std::unordered_set<ObjectGuid::LowType>> creaturesByMap;

    // go through the creatures whose npcflags are changed in the event
    for (NPCFlagList::iterator itr = _gameEventNPCFlags[eventId].begin(); itr != _gameEventNPCFlags[eventId].end(); ++itr)
    {
        // get the creature data from the low guid to get the entry, to be able to find out the whole guid
        if (CreatureData const* data = sObjectMgr->GetCreatureData(itr->first))
            creaturesByMap[data->mapid].insert(itr->first);
    }

    for (auto const& p : creaturesByMap)
    {
        sMapMgr->DoForAllMapsWithMapId(p.first, [this, &p](Map* map)
        {
            for (auto& spawnId : p.second)
            {
                auto creatureBounds = map->GetCreatureBySpawnIdStore().equal_range(spawnId);
                for (auto itr = creatureBounds.first; itr != creatureBounds.second; ++itr)
                {
                    Creature* creature = itr->second;
                    uint32 npcflag = GetNPCFlag(creature);
                    if (CreatureTemplate const* creatureTemplate = creature->GetCreatureTemplate())
                        npcflag |= creatureTemplate->npcflag;

                    creature->ReplaceAllNpcFlags(NPCFlags(npcflag));
                    // reset gossip options, since the flag change might have added / removed some
                    //cr->ResetGossipOptions();
                }
            }
        });
    }
}

void GameEventMgr::UpdateBattlegroundSettings()
{
    uint32 mask = 0;
    for (ActiveEvents::const_iterator itr = _activeEvents.begin(); itr != _activeEvents.end(); ++itr)
        mask |= _gameEventBattlegroundHolidays[*itr];
    sBattlegroundMgr->SetHolidayWeekends(mask);
}

void GameEventMgr::UpdateEventNPCVendor(uint16 eventId, bool activate)
{
    for (NPCVendorList::iterator itr = _gameEventVendors[eventId].begin(); itr != _gameEventVendors[eventId].end(); ++itr)
    {
        if (activate)
            sObjectMgr->AddVendorItem(itr->Entry, itr->Item, itr->MaxCount, itr->Incrtime, itr->ExtendedCost, false);
        else
            sObjectMgr->RemoveVendorItem(itr->Entry, itr->Item, false);
    }
}

void GameEventMgr::GameEventSpawn(int16 eventId)
{
    int32 internal_event_id = _gameEvent.size() + eventId - 1;

    if (internal_event_id < 0 || internal_event_id >= int32(GameEventCreatureGuids.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventSpawn attempt access to out of range mGameEventCreatureGuids element {} (size: {})",
                       internal_event_id, GameEventCreatureGuids.size());
        return;
    }

    for (GuidLowList::iterator itr = GameEventCreatureGuids[internal_event_id].begin(); itr != GameEventCreatureGuids[internal_event_id].end(); ++itr)
    {
        // Add to correct cell
        if (CreatureData const* data = sObjectMgr->GetCreatureData(*itr))
        {
            sObjectMgr->AddCreatureToGrid(*itr, data);

            // Spawn if necessary (loaded grids only)
            Map* map = sMapMgr->CreateBaseMap(data->mapid);
            // We use spawn coords to spawn
            if (!map->Instanceable() && map->IsGridLoaded(data->posX, data->posY))
            {
                Creature* creature = new Creature;
                if (!creature->LoadCreatureFromDB(*itr, map))
                    delete creature;
            }
        }
    }

    if (internal_event_id >= int32(GameEventGameobjectGuids.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventSpawn attempt access to out of range mGameEventGameobjectGuids element {} (size: {})",
                       internal_event_id, GameEventGameobjectGuids.size());
        return;
    }

    for (GuidLowList::iterator itr = GameEventGameobjectGuids[internal_event_id].begin(); itr != GameEventGameobjectGuids[internal_event_id].end(); ++itr)
    {
        // Add to correct cell
        if (GameObjectData const* data = sObjectMgr->GetGameObjectData(*itr))
        {
            sObjectMgr->AddGameobjectToGrid(*itr, data);
            // Spawn if necessary (loaded grids only)
            // this base map checked as non-instanced and then only existed
            Map* map = sMapMgr->CreateBaseMap(data->mapid);
            // We use current coords to unspawn, not spawn coords since creature can have changed grid
            if (!map->Instanceable() && map->IsGridLoaded(data->posX, data->posY))
            {
                GameObject* pGameobject = sObjectMgr->IsGameObjectStaticTransport(data->id) ? new StaticTransport() : new GameObject();
                //TODO: find out when it is add to map
                if (!pGameobject->LoadGameObjectFromDB(*itr, map, false))
                    delete pGameobject;
                else
                {
                    if (pGameobject->isSpawnedByDefault())
                        map->AddToMap(pGameobject);
                }
            }
        }
    }

    if (internal_event_id >= int32(_gameEventPoolIds.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventSpawn attempt access to out of range _gameEventPoolIds element {} (size: {})",
                       internal_event_id, _gameEventPoolIds.size());
        return;
    }

    for (IdList::iterator itr = _gameEventPoolIds[internal_event_id].begin(); itr != _gameEventPoolIds[internal_event_id].end(); ++itr)
        sPoolMgr->SpawnPool(*itr);
}

void GameEventMgr::GameEventUnspawn(int16 eventId)
{
    int32 internal_event_id = _gameEvent.size() + eventId - 1;

    if (internal_event_id < 0 || internal_event_id >= int32(GameEventCreatureGuids.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventUnspawn attempt access to out of range GameEventCreatureGuids element {} (size: {})",
                       internal_event_id, GameEventCreatureGuids.size());
        return;
    }

    for (GuidLowList::iterator itr = GameEventCreatureGuids[internal_event_id].begin(); itr != GameEventCreatureGuids[internal_event_id].end(); ++itr)
    {
        // check if it's needed by another event, if so, don't remove
        if (eventId > 0 && HasCreatureActiveEventExcept(*itr, eventId))
            continue;

        // Remove the creature from grid
        if (CreatureData const* data = sObjectMgr->GetCreatureData(*itr))
        {
            sObjectMgr->RemoveCreatureFromGrid(*itr, data);

            sMapMgr->DoForAllMapsWithMapId(data->mapid, [&itr](Map* map)
            {
                auto creatureBounds = map->GetCreatureBySpawnIdStore().equal_range(*itr);
                for (auto itr2 = creatureBounds.first; itr2 != creatureBounds.second;)
                {
                    Creature* creature = itr2->second;
                    ++itr2;
                    creature->AddObjectToRemoveList();
                }
            });
        }
    }

    if (internal_event_id >= int32(GameEventGameobjectGuids.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventUnspawn attempt access to out of range GameEventGameobjectGuids element {} (size: {})",
                       internal_event_id, GameEventGameobjectGuids.size());
        return;
    }

    for (GuidLowList::iterator itr = GameEventGameobjectGuids[internal_event_id].begin(); itr != GameEventGameobjectGuids[internal_event_id].end(); ++itr)
    {
        // check if it's needed by another event, if so, don't remove
        if (eventId > 0 && HasGameObjectActiveEventExcept(*itr, eventId))
            continue;
        // Remove the gameobject from grid
        if (GameObjectData const* data = sObjectMgr->GetGameObjectData(*itr))
        {
            sObjectMgr->RemoveGameobjectFromGrid(*itr, data);

            sMapMgr->DoForAllMapsWithMapId(data->mapid, [&itr](Map* map)
            {
                auto gameobjectBounds = map->GetGameObjectBySpawnIdStore().equal_range(*itr);
                for (auto itr2 = gameobjectBounds.first; itr2 != gameobjectBounds.second;)
                {
                    GameObject* go = itr2->second;
                    ++itr2;
                    go->AddObjectToRemoveList();
                }
            });
        }
    }
    if (internal_event_id >= int32(_gameEventPoolIds.size()))
    {
        LOG_ERROR("gameevent", "GameEventMgr::GameEventUnspawn attempt access to out of range mGameEventPoolIds element {} (size: {})", internal_event_id, _gameEventPoolIds.size());
        return;
    }

    for (IdList::iterator itr = _gameEventPoolIds[internal_event_id].begin(); itr != _gameEventPoolIds[internal_event_id].end(); ++itr)
    {
        sPoolMgr->DespawnPool(*itr);
    }
}

void GameEventMgr::ChangeEquipOrModel(int16 eventId, bool activate)
{
    for (ModelEquipList::iterator itr = _gameEventModelEquip[eventId].begin(); itr != _gameEventModelEquip[eventId].end(); ++itr)
    {
        // Remove the creature from grid
        CreatureData const* data = sObjectMgr->GetCreatureData(itr->first);
        if (!data)
            continue;

        // Update if spawned
        sMapMgr->DoForAllMapsWithMapId(data->mapid, [&itr, activate](Map* map)
        {
            auto creatureBounds = map->GetCreatureBySpawnIdStore().equal_range(itr->first);
            for (auto itr2 = creatureBounds.first; itr2 != creatureBounds.second; ++itr2)
            {
                Creature* creature = itr2->second;
                if (activate)
                {
                    itr->second.EquipementIdPrev = creature->GetCurrentEquipmentId();
                    itr->second.ModelIdPrev = creature->GetDisplayId();
                    creature->LoadEquipment(itr->second.EquipmentId, true);
                    if (itr->second.ModelId > 0 && itr->second.ModelIdPrev != itr->second.ModelId && sObjectMgr->GetCreatureModelInfo(itr->second.ModelId))
                    {
                        creature->SetDisplayId(itr->second.ModelId);
                        creature->SetNativeDisplayId(itr->second.ModelId);
                    }
                }
                else
                {
                    creature->LoadEquipment(itr->second.EquipementIdPrev, true);
                    if (itr->second.ModelIdPrev > 0 && itr->second.ModelIdPrev != itr->second.ModelId && sObjectMgr->GetCreatureModelInfo(itr->second.ModelIdPrev))
                    {
                        creature->SetDisplayId(itr->second.ModelIdPrev);
                        creature->SetNativeDisplayId(itr->second.ModelIdPrev);
                    }
                }
            }
        });

        // now last step: put in data
        // just to have write access to it
        CreatureData& data2 = sObjectMgr->NewOrExistCreatureData(itr->first);
        if (activate)
        {
            itr->second.ModelIdPrev = data2.displayid;
            itr->second.EquipementIdPrev = data2.equipmentId;
            data2.displayid = itr->second.ModelId;
            data2.equipmentId = itr->second.EquipmentId;
        }
        else
        {
            data2.displayid = itr->second.ModelIdPrev;
            data2.equipmentId = itr->second.EquipementIdPrev;
        }
    }
}

bool GameEventMgr::HasCreatureQuestActiveEventExcept(uint32 quest_id, uint16 eventId)
{
    for (ActiveEvents::iterator e_itr = _activeEvents.begin(); e_itr != _activeEvents.end(); ++e_itr)
    {
        if ((*e_itr) != eventId)
            for (QuestRelList::iterator itr = _gameEventCreatureQuests[*e_itr].begin();
                    itr != _gameEventCreatureQuests[*e_itr].end();
                    ++ itr)
                if (itr->second == quest_id)
                    return true;
    }
    return false;
}

bool GameEventMgr::HasGameObjectQuestActiveEventExcept(uint32 quest_id, uint16 eventId)
{
    for (ActiveEvents::iterator e_itr = _activeEvents.begin(); e_itr != _activeEvents.end(); ++e_itr)
    {
        if ((*e_itr) != eventId)
            for (QuestRelList::iterator itr = _gameEventGameObjectQuests[*e_itr].begin();
                    itr != _gameEventGameObjectQuests[*e_itr].end();
                    ++ itr)
                if (itr->second == quest_id)
                    return true;
    }
    return false;
}
bool GameEventMgr::HasCreatureActiveEventExcept(ObjectGuid::LowType creature_guid, uint16 eventId)
{
    for (ActiveEvents::iterator e_itr = _activeEvents.begin(); e_itr != _activeEvents.end(); ++e_itr)
    {
        if ((*e_itr) != eventId)
        {
            int32 internal_event_id = _gameEvent.size() + (*e_itr) - 1;
            for (GuidLowList::iterator itr = GameEventCreatureGuids[internal_event_id].begin(); itr != GameEventCreatureGuids[internal_event_id].end(); ++ itr)
                if (*itr == creature_guid)
                    return true;
        }
    }
    return false;
}
bool GameEventMgr::HasGameObjectActiveEventExcept(ObjectGuid::LowType go_guid, uint16 eventId)
{
    for (ActiveEvents::iterator e_itr = _activeEvents.begin(); e_itr != _activeEvents.end(); ++e_itr)
    {
        if ((*e_itr) != eventId)
        {
            int32 internal_event_id = _gameEvent.size() + (*e_itr) - 1;
            for (GuidLowList::iterator itr = GameEventGameobjectGuids[internal_event_id].begin(); itr != GameEventGameobjectGuids[internal_event_id].end(); ++ itr)
                if (*itr == go_guid)
                    return true;
        }
    }
    return false;
}

void GameEventMgr::UpdateEventQuests(uint16 eventId, bool activate)
{
    QuestRelList::iterator itr;
    for (itr = _gameEventCreatureQuests[eventId].begin(); itr != _gameEventCreatureQuests[eventId].end(); ++itr)
    {
        QuestRelations* CreatureQuestMap = sObjectMgr->GetCreatureQuestRelationMap();
        if (activate)                                           // Add the pair(id, quest) to the multimap
            CreatureQuestMap->insert(QuestRelations::value_type(itr->first, itr->second));
        else
        {
            if (!HasCreatureQuestActiveEventExcept(itr->second, eventId))
            {
                // Remove the pair(id, quest) from the multimap
                QuestRelations::iterator qitr = CreatureQuestMap->find(itr->first);
                if (qitr == CreatureQuestMap->end())
                    continue;
                QuestRelations::iterator lastElement = CreatureQuestMap->upper_bound(itr->first);
                for (; qitr != lastElement; ++qitr)
                {
                    if (qitr->second == itr->second)
                    {
                        CreatureQuestMap->erase(qitr);          // iterator is now no more valid
                        break;                                  // but we can exit loop since the element is found
                    }
                }
            }
        }
    }
    for (itr = _gameEventGameObjectQuests[eventId].begin(); itr != _gameEventGameObjectQuests[eventId].end(); ++itr)
    {
        QuestRelations* GameObjectQuestMap = sObjectMgr->GetGOQuestRelationMap();
        if (activate)                                           // Add the pair(id, quest) to the multimap
            GameObjectQuestMap->insert(QuestRelations::value_type(itr->first, itr->second));
        else
        {
            if (!HasGameObjectQuestActiveEventExcept(itr->second, eventId))
            {
                // Remove the pair(id, quest) from the multimap
                QuestRelations::iterator qitr = GameObjectQuestMap->find(itr->first);
                if (qitr == GameObjectQuestMap->end())
                    continue;
                QuestRelations::iterator lastElement = GameObjectQuestMap->upper_bound(itr->first);
                for (; qitr != lastElement; ++qitr)
                {
                    if (qitr->second == itr->second)
                    {
                        GameObjectQuestMap->erase(qitr);        // iterator is now no more valid
                        break;                                  // but we can exit loop since the element is found
                    }
                }
            }
        }
    }
}

void GameEventMgr::UpdateWorldStates(uint16 eventId, bool Activate)
{
    GameEventData const& event = _gameEvent[eventId];
    if (event.HolidayId != HOLIDAY_NONE)
    {
        BattlegroundTypeId bgTypeId = BattlegroundMgr::WeekendHolidayIdToBGType(event.HolidayId);
        if (bgTypeId != BATTLEGROUND_TYPE_NONE)
        {
            BattlemasterListEntry const* bl = sBattlemasterListStore.LookupEntry(bgTypeId);
            if (bl && bl->HolidayWorldStateId)
            {
                WorldPackets::WorldState::UpdateWorldState worldstate;
                worldstate.VariableID = bl->HolidayWorldStateId;
                worldstate.Value = Activate ? 1 : 0;
                sWorldSessionMgr->SendGlobalMessage(worldstate.Write());
            }
        }
    }
}

GameEventMgr::GameEventMgr() : _isSystemInit(false)
{
}

void GameEventMgr::HandleQuestComplete(uint32 quest_id)
{
    // translate the quest to event and condition
    QuestIdToEventConditionMap::iterator itr = _questToEventConditions.find(quest_id);
    // quest is registered
    if (itr != _questToEventConditions.end())
    {
        uint16 eventId = itr->second.EventId;
        uint32 condition = itr->second.Condition;
        float num = itr->second.Num;

        // the event is not active, so return, don't increase condition finishes
        if (!IsActiveEvent(eventId))
            return;
        // not in correct phase, return
        if (_gameEvent[eventId].State != GAMEEVENT_WORLD_CONDITIONS)
            return;
        GameEventConditionMap::iterator citr = _gameEvent[eventId].Conditions.find(condition);
        // condition is registered
        if (citr != _gameEvent[eventId].Conditions.end())
        {
            // increase the done count, only if less then the req
            if (citr->second.Done < citr->second.ReqNum)
            {
                citr->second.Done += num;
                // check max limit
                if (citr->second.Done > citr->second.ReqNum)
                    citr->second.Done = citr->second.ReqNum;
                // save the change to db
                CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

                CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GAME_EVENT_CONDITION_SAVE);
                stmt->SetData(0, uint8(eventId));
                stmt->SetData(1, condition);
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_GAME_EVENT_CONDITION_SAVE);
                stmt->SetData(0, uint8(eventId));
                stmt->SetData(1, condition);
                stmt->SetData(2, citr->second.Done);
                trans->Append(stmt);
                CharacterDatabase.CommitTransaction(trans);
                // check if all conditions are met, if so, update the event state
                if (CheckOneGameEventConditions(eventId))
                {
                    // changed, save to DB the gameevent state
                    SaveWorldEventStateToDB(eventId);
                    // force update events to set timer
                    sWorld->ForceGameEventUpdate();
                }
            }
        }
    }
}

bool GameEventMgr::CheckOneGameEventConditions(uint16 eventId)
{
    for (GameEventConditionMap::const_iterator itr = _gameEvent[eventId].Conditions.begin(); itr != _gameEvent[eventId].Conditions.end(); ++itr)
        if (itr->second.Done < itr->second.ReqNum)
            // return false if a condition doesn't match
            return false;
    // set the phase
    _gameEvent[eventId].State = GAMEEVENT_WORLD_NEXTPHASE;
    // set the followup events' start time
    if (!_gameEvent[eventId].NextStart)
    {
        time_t currenttime = GameTime::GetGameTime().count();
        _gameEvent[eventId].NextStart = currenttime + _gameEvent[eventId].Length * 60;
    }
    return true;
}

void GameEventMgr::SaveWorldEventStateToDB(uint16 eventId)
{
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GAME_EVENT_SAVE);
    stmt->SetData(0, uint8(eventId));
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_GAME_EVENT_SAVE);
    stmt->SetData(0, uint8(eventId));
    stmt->SetData(1, _gameEvent[eventId].State);
    stmt->SetData(2, _gameEvent[eventId].NextStart ? uint32(_gameEvent[eventId].NextStart) : 0);
    trans->Append(stmt);
    CharacterDatabase.CommitTransaction(trans);
}

void GameEventMgr::SendWorldStateUpdate(Player* player, uint16 eventId)
{
    GameEventConditionMap::const_iterator itr;
    for (itr = _gameEvent[eventId].Conditions.begin(); itr != _gameEvent[eventId].Conditions.end(); ++itr)
    {
        if (itr->second.DoneWorldState)
            player->SendUpdateWorldState(itr->second.DoneWorldState, (uint32)(itr->second.Done));
        if (itr->second.MaxWorldState)
            player->SendUpdateWorldState(itr->second.MaxWorldState, (uint32)(itr->second.ReqNum));
    }
}

class GameEventAIHookWorker
{
public:
    GameEventAIHookWorker(uint16 eventId, bool activate) : _eventId(eventId), _activate(activate) { }

    void Visit(std::unordered_map<ObjectGuid, Creature*>& creatureMap)
    {
        for (auto const& p : creatureMap)
            if (p.second->IsInWorld() && !p.second->IsDuringRemoveFromWorld() && p.second->FindMap() && p.second->IsAIEnabled && p.second->AI())
                p.second->AI()->sOnGameEvent(_activate, _eventId);
    }

    void Visit(std::unordered_map<ObjectGuid, GameObject*>& gameObjectMap)
    {
        for (auto const& p : gameObjectMap)
            if (p.second->IsInWorld() && p.second->FindMap() && p.second->AI())
                p.second->AI()->OnGameEvent(_activate, _eventId);
    }

    template<class T>
    void Visit(std::unordered_map<ObjectGuid, T*>&) { }

private:
    uint16 _eventId;
    bool _activate;
};

void GameEventMgr::RunSmartAIScripts(uint16 eventId, bool activate)
{
    //! Iterate over every supported source type (creature and gameobject)
    //! Not entirely sure how this will affect units in non-loaded grids.
    sMapMgr->DoForAllMaps([eventId, activate](Map* map)
    {
        GameEventAIHookWorker worker(eventId, activate);
        TypeContainerVisitor<GameEventAIHookWorker, MapStoredObjectTypesContainer> visitor(worker);
        visitor.Visit(map->GetObjectsStore());
    });
}

void GameEventMgr::SetHolidayEventTime(GameEventData& event)
{
    if (!event.HolidayStage) // Ignore holiday
        return;

    HolidaysEntry const* holiday = sHolidaysStore.LookupEntry(event.HolidayId);

    if (!holiday->Date[0] || !holiday->Duration[0]) // Invalid definitions
    {
        LOG_ERROR("sql.sql", "Missing date or duration for holiday {}.", event.HolidayId);
        return;
    }

    uint8 stageIndex = event.HolidayStage - 1;
    event.Length = holiday->Duration[stageIndex] * HOUR / MINUTE;

    time_t stageOffset = 0;
    for (uint8 i = 0; i < stageIndex; ++i)
    {
        stageOffset += holiday->Duration[i] * HOUR;
    }

    switch (holiday->CalendarFilterType)
    {
        case -1: // Yearly
            event.Occurence = YEAR / MINUTE; // Not all too useful
            break;
        case 0: // Weekly
            event.Occurence = WEEK / MINUTE;
            break;
        case 1: // Defined dates only (Darkmoon Faire)
            break;
        case 2: // Only used for looping events (Call to Arms)
            break;
    }

    if (holiday->Looping)
    {
        event.Occurence = 0;
        for (uint8 i = 0; i < MAX_HOLIDAY_DURATIONS && holiday->Duration[i]; ++i)
        {
            event.Occurence += holiday->Duration[i] * HOUR / MINUTE;
        }
    }

    bool singleDate = ((holiday->Date[0] >> 24) & 0x1F) == 31; // Events with fixed date within year have - 1

    time_t curTime = GameTime::GetGameTime().count();
    for (uint8 i = 0; i < MAX_HOLIDAY_DATES && holiday->Date[i]; ++i)

    {
        uint32 date = holiday->Date[i];

        tm timeInfo;
        if (singleDate)
        {
            timeInfo = Acore::Time::TimeBreakdown(curTime);
            timeInfo.tm_year -= 1; // First try last year (event active through New Year)
        }
        else
        {
            timeInfo.tm_year = ((date >> 24) & 0x1F) + 100;
        }

        timeInfo.tm_mon = (date >> 20) & 0xF;
        timeInfo.tm_mday = ((date >> 14) & 0x3F) + 1;
        timeInfo.tm_hour = (date >> 6) & 0x1F;
        timeInfo.tm_min = date & 0x3F;
        timeInfo.tm_sec = 0;
        timeInfo.tm_isdst = -1;

        // try to get next start time (skip past dates)
        time_t startTime = mktime(&timeInfo);
        if (curTime < startTime + event.Length * MINUTE)
        {
            event.Start = startTime + stageOffset;
            break;
        }
        else if (singleDate)
        {
            tm tmCopy = Acore::Time::TimeBreakdown(curTime);
            int year = tmCopy.tm_year; // This year
            tmCopy = timeInfo;
            tmCopy.tm_year = year;
            event.Start = mktime(&tmCopy) + stageOffset;
            break;
        }
        else
        {
            // date is due and not a singleDate event, try with next DBC date (modified by holiday_dates)
            // if none is found we don't modify start date and use the one in game_event
        }
    }
}

uint32 GameEventMgr::GetHolidayEventId(uint32 holidayId) const
{
    auto const& events = sGameEventMgr->GetEventMap();

    for (auto const& eventEntry : events)
    {
        if (eventEntry.HolidayId == holidayId)
        {
            return eventEntry.EventId;
        }
    }

    return 0;
}

bool IsHolidayActive(HolidayIds id)
{
    if (id == HOLIDAY_NONE)
        return false;

    GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();
    GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();

    for (GameEventMgr::ActiveEvents::const_iterator itr = ae.begin(); itr != ae.end(); ++itr)
        if (events[*itr].HolidayId == id)
            return true;

    return false;
}

bool IsEventActive(uint16 eventId)
{
    GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();
    return ae.find(eventId) != ae.end();
}
