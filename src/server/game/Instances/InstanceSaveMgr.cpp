/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "Config.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "InstanceSaveMgr.h"
#include "InstanceScript.h"
#include "Log.h"
#include "Map.h"
#include "MapInstanced.h"
#include "MapManager.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Timer.h"
#include "Transport.h"
#include "World.h"

uint16 InstanceSaveManager::ResetTimeDelay[] = {3600, 900, 300, 60, 0};
PlayerBindStorage InstanceSaveManager::playerBindStorage;
BoundInstancesMap InstanceSaveManager::emptyBoundInstancesMap;

InstanceSaveManager::~InstanceSaveManager()
{
    lock_instLists = true;
    // pussywizard: crashes on calling function in destructor (PlayerUnbindInstance), completely not needed anyway
    /*for (InstanceSaveHashMap::iterator itr = m_instanceSaveById.begin(); itr != m_instanceSaveById.end(); ++itr)
    {
        InstanceSave* save = itr->second;

        InstanceSave::PlayerListType &pList = save->m_playerList;
        while (!pList.empty())
            PlayerUnbindInstance(*(pList.begin()), save->GetMapId(), save->GetDifficulty(), false);

        delete save;
    }*/
}

InstanceSaveManager* InstanceSaveManager::instance()
{
    static InstanceSaveManager instance;
    return &instance;
}

/*
- adding instance into manager
*/
InstanceSave* InstanceSaveManager::AddInstanceSave(uint32 mapId, uint32 instanceId, Difficulty difficulty, bool startup /*=false*/)
{
    ASSERT(!GetInstanceSave(instanceId));

    const MapEntry* entry = sMapStore.LookupEntry(mapId);
    if (!entry)
    {
        LOG_ERROR("server", "InstanceSaveManager::AddInstanceSave: wrong mapid = %d, instanceid = %d!", mapId, instanceId);
        return nullptr;
    }

    if (instanceId == 0)
    {
        LOG_ERROR("server", "InstanceSaveManager::AddInstanceSave: mapid = %d, wrong instanceid = %d!", mapId, instanceId);
        return nullptr;
    }

    if (difficulty >= (entry->IsRaid() ? MAX_RAID_DIFFICULTY : MAX_DUNGEON_DIFFICULTY))
    {
        LOG_ERROR("server", "InstanceSaveManager::AddInstanceSave: mapid = %d, instanceid = %d, wrong dificalty %u!", mapId, instanceId, difficulty);
        return nullptr;
    }

    time_t resetTime, extendedResetTime;
    if (entry->map_type == MAP_RAID || difficulty > DUNGEON_DIFFICULTY_NORMAL)
    {
        resetTime = GetResetTimeFor(mapId, difficulty);
        extendedResetTime = GetExtendedResetTimeFor(mapId, difficulty);
    }
    else
    {
        resetTime = time(nullptr) + 3 * DAY; // normals expire after 3 days even if someone is still bound to them, cleared on startup
        extendedResetTime = 0;
    }
    InstanceSave* save = new InstanceSave(mapId, instanceId, difficulty, resetTime, extendedResetTime);
    if (!startup)
        save->InsertToDB();

    m_instanceSaveById[instanceId] = save;
    return save;
}

InstanceSave* InstanceSaveManager::GetInstanceSave(uint32 InstanceId)
{
    InstanceSaveHashMap::iterator itr = m_instanceSaveById.find(InstanceId);
    return itr != m_instanceSaveById.end() ? itr->second : nullptr;
}

bool InstanceSaveManager::DeleteInstanceSaveIfNeeded(uint32 InstanceId, bool skipMapCheck)
{
    return DeleteInstanceSaveIfNeeded(GetInstanceSave(InstanceId), skipMapCheck);
}

bool InstanceSaveManager::DeleteInstanceSaveIfNeeded(InstanceSave* save, bool skipMapCheck)
{
    // pussywizard: save is removed only when there are no more players bound AND the map doesn't exist
    // pussywizard: this function is called when unbinding a player and when unloading a map
    if (!lock_instLists && save && save->m_playerList.empty() && (skipMapCheck || !sMapMgr->FindMap(save->GetMapId(), save->GetInstanceId())))
    {
        // delete save from storage:
        InstanceSaveHashMap::iterator itr = m_instanceSaveById.find(save->GetInstanceId());
        ASSERT(itr != m_instanceSaveById.end() && itr->second == save);
        m_instanceSaveById.erase(itr);

        // delete save from db:
        // character_instance is deleted when unbinding a certain player
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INSTANCE_BY_INSTANCE);
        stmt->setUInt32(0, save->GetInstanceId());
        CharacterDatabase.Execute(stmt);

        // clear respawn times (if map is loaded do it just to be sure, if already unloaded it won't do it by itself)
        Map::DeleteRespawnTimesInDB(save->GetMapId(), save->GetInstanceId());

        delete save;
        return true;
    }
    return false;
}

InstanceSave::InstanceSave(uint16 MapId, uint32 InstanceId, Difficulty difficulty, time_t resetTime, time_t extendedResetTime)
    : m_resetTime(resetTime), m_extendedResetTime(extendedResetTime), m_instanceid(InstanceId), m_mapid(MapId), m_difficulty(IsSharedDifficultyMap(MapId) ? Difficulty(difficulty % 2) : difficulty), m_canReset(true), m_instanceData(""), m_completedEncounterMask(0)
{
    sScriptMgr->OnConstructInstanceSave(this);
}

InstanceSave::~InstanceSave()
{
    ASSERT(m_playerList.empty());

    sScriptMgr->OnDestructInstanceSave(this);
}

void InstanceSave::InsertToDB()
{
    std::string data;
    uint32 completedEncounters = 0;

    Map* map = sMapMgr->FindMap(GetMapId(), m_instanceid);
    if (map)
    {
        ASSERT(map->IsDungeon());
        if (InstanceScript* instanceScript = map->ToInstanceMap()->GetInstanceScript())
        {
            data = instanceScript->GetSaveData();
            completedEncounters = instanceScript->GetCompletedEncounterMask();

            // pussywizard:
            SetInstanceData(data);
            SetCompletedEncounterMask(completedEncounters);
        }
    }

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_INSTANCE_SAVE);
    stmt->setUInt32(0, m_instanceid);
    stmt->setUInt16(1, GetMapId());
    stmt->setUInt32(2, uint32(GetResetTimeForDB()));
    stmt->setUInt8(3, uint8(GetDifficulty()));
    stmt->setUInt32(4, completedEncounters);
    stmt->setString(5, data);
    CharacterDatabase.Execute(stmt);

    sScriptMgr->OnInstanceSave(this);
}

time_t InstanceSave::GetResetTimeForDB()
{
    // only save the reset time for normal instances
    const MapEntry* entry = sMapStore.LookupEntry(GetMapId());
    if (!entry || entry->map_type == MAP_RAID || GetDifficulty() == DUNGEON_DIFFICULTY_HEROIC)
        return 0;
    else
        return GetResetTime();
}

// to cache or not to cache, that is the question
InstanceTemplate const* InstanceSave::GetTemplate()
{
    return sObjectMgr->GetInstanceTemplate(m_mapid);
}

MapEntry const* InstanceSave::GetMapEntry()
{
    return sMapStore.LookupEntry(m_mapid);
}

void InstanceSave::AddPlayer(ObjectGuid guid)
{
    std::lock_guard<std::mutex> guard(_lock);
    m_playerList.push_back(guid);
}

bool InstanceSave::RemovePlayer(ObjectGuid guid, InstanceSaveManager* ism)
{
    std::lock_guard<std::mutex> guard(_lock);
    m_playerList.remove(guid);

    // ism passed as an argument to avoid calling via singleton (might result in a deadlock)
    return ism->DeleteInstanceSaveIfNeeded(this->GetInstanceId(), false);
}

void InstanceSaveManager::LoadInstances()
{
    uint32 oldMSTime = getMSTime();

    // Delete character_instance for non-existent character
    CharacterDatabase.DirectExecute("DELETE ci.* FROM character_instance AS ci LEFT JOIN characters AS c ON ci.guid = c.guid WHERE c.guid IS NULL");

    // Delete expired normal instances (normals expire after 3 days even if someone is still bound to them, cleared on startup)
    CharacterDatabase.DirectExecute("DELETE FROM instance WHERE resettime > 0 AND resettime < UNIX_TIMESTAMP()");

    // Delete instance with no binds
    CharacterDatabase.DirectExecute("DELETE i.* FROM instance AS i LEFT JOIN character_instance AS ci ON i.id = ci.instance WHERE ci.guid IS NULL");

    // Delete creature_respawn, gameobject_respawn and creature_instance for non-existent instance
    CharacterDatabase.DirectExecute("DELETE FROM creature_respawn WHERE instanceId > 0 AND instanceId NOT IN (SELECT id FROM instance)");
    CharacterDatabase.DirectExecute("DELETE FROM gameobject_respawn WHERE instanceId > 0 AND instanceId NOT IN (SELECT id FROM instance)");
    CharacterDatabase.DirectExecute("DELETE tmp.* FROM character_instance AS tmp LEFT JOIN instance ON tmp.instance = instance.id WHERE tmp.instance > 0 AND instance.id IS NULL");

    // Clean invalid references to instance
    CharacterDatabase.DirectExecute("UPDATE corpse SET instanceId = 0 WHERE instanceId > 0 AND instanceId NOT IN (SELECT id FROM instance)");
    CharacterDatabase.DirectExecute("UPDATE characters AS tmp LEFT JOIN instance ON tmp.instance_id = instance.id SET tmp.instance_id = 0 WHERE tmp.instance_id > 0 AND instance.id IS NULL");

    // Initialize instance id storage (Needs to be done after the trash has been clean out)
    sMapMgr->InitInstanceIds();

    // Load reset times and clean expired instances
    LoadResetTimes();

    // pussywizard
    LoadInstanceSaves();
    LoadCharacterBinds();

    LOG_INFO("server", ">> Loaded instances and binds in %u ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void InstanceSaveManager::LoadResetTimes()
{
    time_t now = time(nullptr);
    time_t today = (now / DAY) * DAY;

    // load the global respawn times for raid/heroic instances
    uint32 diff = sWorld->getIntConfig(CONFIG_INSTANCE_RESET_TIME_HOUR) * HOUR;
    QueryResult result = CharacterDatabase.Query("SELECT mapid, difficulty, resettime FROM instance_reset");
    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 mapid = fields[0].GetUInt16();
            Difficulty difficulty = Difficulty(fields[1].GetUInt8());
            uint64 resettime = fields[2].GetUInt32();

            MapDifficulty const* mapDiff = GetMapDifficultyData(mapid, difficulty);
            if (!mapDiff)
            {
                LOG_ERROR("server", "InstanceSaveManager::LoadResetTimes: invalid mapid(%u)/difficulty(%u) pair in instance_reset!", mapid, difficulty);
                CharacterDatabase.DirectPExecute("DELETE FROM instance_reset WHERE mapid = '%u' AND difficulty = '%u'", mapid, difficulty);
                continue;
            }

            SetResetTimeFor(mapid, difficulty, resettime);
        } while (result->NextRow());
    }

    // calculate new global reset times for expired instances and those that have never been reset yet
    // add the global reset times to the priority queue
    for (MapDifficultyMap::const_iterator itr = sMapDifficultyMap.begin(); itr != sMapDifficultyMap.end(); ++itr)
    {
        uint32 map_diff_pair = itr->first;
        uint32 mapid = PAIR32_LOPART(map_diff_pair);
        Difficulty difficulty = Difficulty(PAIR32_HIPART(map_diff_pair));
        MapDifficulty const* mapDiff = &itr->second;
        if (!mapDiff->resetTime)
            continue;

        // the reset_delay must be at least one day
        uint32 period = uint32(((mapDiff->resetTime * sWorld->getRate(RATE_INSTANCE_RESET_TIME)) / DAY) * DAY);
        if (period < DAY)
            period = DAY;

        time_t t = GetResetTimeFor(mapid, difficulty);
        if (!t)
        {
            // initialize the reset time
            t = today + period + diff;
            SetResetTimeFor(mapid, difficulty, t);
            CharacterDatabase.DirectPExecute("INSERT INTO instance_reset VALUES ('%u', '%u', '%u')", mapid, difficulty, (uint32)t);
        }

        if (t < now)
        {
            // assume that expired instances have already been cleaned
            // calculate the next reset time
            t = (t * DAY) / DAY;
            t += ((today - t) / period + 1) * period + diff;
            CharacterDatabase.DirectPExecute("UPDATE instance_reset SET resettime = '%u' WHERE mapid = '%u' AND difficulty = '%u'", (uint32)t, mapid, difficulty);
        }

        SetExtendedResetTimeFor(mapid, difficulty, t);

        // schedule the global reset/warning
        uint8 type;
        for (type = 1; type < 5; ++type)
            if (now + ResetTimeDelay[type - 1] < t)
                break;

        ScheduleReset(t - ResetTimeDelay[type - 1], InstResetEvent(type, mapid, difficulty));
    }
}

void InstanceSaveManager::LoadInstanceSaves()
{
    QueryResult result = CharacterDatabase.Query("SELECT id, map, resettime, difficulty, completedEncounters, data FROM instance ORDER BY id ASC");
    if (result)
    {
        do
        {
            Field* fields = result->Fetch();

            uint32 instanceId = fields[0].GetUInt32();
            uint32 mapId = fields[1].GetUInt16();
            time_t resettime = time_t(fields[2].GetUInt32());
            uint8 difficulty = fields[3].GetUInt8();
            uint32 completedEncounters = fields[4].GetUInt32();
            std::string instanceData = fields[5].GetString();

            // Mark instance id as being used
            sMapMgr->RegisterInstanceId(instanceId);

            InstanceSave* save = AddInstanceSave(mapId, instanceId, Difficulty(difficulty), true);
            if (save)
            {
                save->SetCompletedEncounterMask(completedEncounters);
                save->SetInstanceData(instanceData);
                if (resettime > 0)
                    save->SetResetTime(resettime);
            }
        } while (result->NextRow());
    }
}

void InstanceSaveManager::LoadCharacterBinds()
{
    lock_instLists = true;

    QueryResult result = CharacterDatabase.Query("SELECT guid, instance, permanent, extended FROM character_instance");
    if (result)
    {
        do
        {
            Field* fields = result->Fetch();

            ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(fields[0].GetUInt32());
            uint32 instanceId = fields[1].GetUInt32();
            bool perm = fields[2].GetBool();
            bool extended = fields[3].GetBool();

            if (InstanceSave* save = GetInstanceSave(instanceId))
            {
                PlayerCreateBoundInstancesMaps(guid);
                InstancePlayerBind& bind = playerBindStorage[guid]->m[save->GetDifficulty()][save->GetMapId()];
                if (bind.save) // pussywizard: another bind for the same map and difficulty! may happen because of mysql thread races
                {
                    if (bind.perm) // already loaded perm -> delete currently checked one from db
                    {
                        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INSTANCE_BY_INSTANCE_GUID);
                        stmt->setUInt32(0, guid.GetCounter());
                        stmt->setUInt32(1, instanceId);
                        CharacterDatabase.Execute(stmt);
                        continue;
                    }
                    else // override temp bind by newest one
                    {
                        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INSTANCE_BY_INSTANCE_GUID);
                        stmt->setUInt32(0, guid.GetCounter());
                        stmt->setUInt32(1, bind.save->GetInstanceId());
                        CharacterDatabase.Execute(stmt);
                        bind.save->RemovePlayer(guid, this);
                    }
                }
                bind.save = save;
                bind.perm = perm;
                bind.extended = extended;
                save->AddPlayer(guid);
                if (perm)
                    save->SetCanReset(false);
            }
        } while (result->NextRow());
    }

    lock_instLists = false;
}

void InstanceSaveManager::ScheduleReset(time_t time, InstResetEvent event)
{
    m_resetTimeQueue.insert(std::pair<time_t, InstResetEvent>(time, event));
}

void InstanceSaveManager::Update()
{
    time_t now = time(nullptr);
    time_t t;
    bool resetOccurred = false;

    while (!m_resetTimeQueue.empty())
    {
        t = m_resetTimeQueue.begin()->first;
        if (t >= now)
            break;

        InstResetEvent& event = m_resetTimeQueue.begin()->second;
        if (event.type)
        {
            // global reset/warning for a certain map
            time_t resetTime = GetResetTimeFor(event.mapid, event.difficulty);
            bool warn = event.type < 5;
            _ResetOrWarnAll(event.mapid, event.difficulty, warn, resetTime);
            if (warn)
            {
                // schedule the next warning/reset
                ++event.type;
                ScheduleReset(resetTime - ResetTimeDelay[event.type - 1], event);
            }
            else
                resetOccurred = true;
        }
        m_resetTimeQueue.erase(m_resetTimeQueue.begin());
    }

    // pussywizard: send updated calendar and raid info
    if (resetOccurred)
    {
        LOG_INFO("server", "Instance ID reset occurred, sending updated calendar and raid info to all players!");
        WorldPacket dummy;
        for (SessionMap::const_iterator itr = sWorld->GetAllSessions().begin(); itr != sWorld->GetAllSessions().end(); ++itr)
            if (Player* plr = itr->second->GetPlayer())
            {
                itr->second->HandleCalendarGetCalendar(dummy);
                plr->SendRaidInfo();
            }
    }
}

void InstanceSaveManager::_ResetSave(InstanceSaveHashMap::iterator& itr)
{
    lock_instLists = true;

    GuidList& pList = itr->second->m_playerList;
    for (GuidList::iterator iter = pList.begin(), iter2; iter != pList.end(); )
    {
        iter2 = iter++;
        PlayerUnbindInstanceNotExtended(*iter2, itr->second->GetMapId(), itr->second->GetDifficulty(), ObjectAccessor::FindConnectedPlayer(*iter2));
    }

    // delete stuff if no players left (noone extended id)
    if (pList.empty())
    {
        // delete character_instance per id, delete instance per id
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INSTANCE_BY_INSTANCE);
        stmt->setUInt32(0, itr->second->GetInstanceId());
        CharacterDatabase.Execute(stmt);
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INSTANCE_BY_INSTANCE);
        stmt->setUInt32(0, itr->second->GetInstanceId());
        CharacterDatabase.Execute(stmt);

        // clear respawn times if the map is already unloaded and won't do it by itself
        if (!sMapMgr->FindMap(itr->second->GetMapId(), itr->second->GetInstanceId()))
            Map::DeleteRespawnTimesInDB(itr->second->GetMapId(), itr->second->GetInstanceId());

        delete itr->second;
        m_instanceSaveById.erase(itr);
    }
    else
    {
        // delete character_instance per id where extended = 0, transtaction with set extended = 0, transaction is used to avoid mysql thread races
        SQLTransaction trans = CharacterDatabase.BeginTransaction();
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INSTANCE_BY_INSTANCE_NOT_EXTENDED);
        stmt->setUInt32(0, itr->second->GetInstanceId());
        trans->Append(stmt);
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_INSTANCE_SET_NOT_EXTENDED);
        stmt->setUInt32(0, itr->second->GetInstanceId());
        trans->Append(stmt);
        CharacterDatabase.CommitTransaction(trans);

        // update reset time and extended reset time for instance save
        itr->second->SetResetTime(GetResetTimeFor(itr->second->GetMapId(), itr->second->GetDifficulty()));
        itr->second->SetExtendedResetTime(GetExtendedResetTimeFor(itr->second->GetMapId(), itr->second->GetDifficulty()));
    }

    lock_instLists = false;
}

void InstanceSaveManager::_ResetOrWarnAll(uint32 mapid, Difficulty difficulty, bool warn, time_t resetTime)
{
    // global reset for all instances of the given map
    MapEntry const* mapEntry = sMapStore.LookupEntry(mapid);
    if (!mapEntry->Instanceable())
        return;

    time_t now = time(nullptr);

    if (!warn)
    {
        MapDifficulty const* mapDiff = GetMapDifficultyData(mapid, difficulty);
        if (!mapDiff || !mapDiff->resetTime)
        {
            LOG_ERROR("server", "InstanceSaveManager::ResetOrWarnAll: not valid difficulty or no reset delay for map %d", mapid);
            return;
        }

        // calculate the next reset time
        uint32 diff = sWorld->getIntConfig(CONFIG_INSTANCE_RESET_TIME_HOUR) * HOUR;

        uint32 period = uint32(((mapDiff->resetTime * sWorld->getRate(RATE_INSTANCE_RESET_TIME)) / DAY) * DAY);
        if (period < DAY)
            period = DAY;

        uint32 next_reset = uint32(((resetTime + MINUTE) / DAY * DAY) + period + diff);
        SetResetTimeFor(mapid, difficulty, next_reset);
        SetExtendedResetTimeFor(mapid, difficulty, next_reset + period);
        ScheduleReset(time_t(next_reset - 3600), InstResetEvent(1, mapid, difficulty));

        // update it in the DB
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_GLOBAL_INSTANCE_RESETTIME);
        stmt->setUInt32(0, next_reset);
        stmt->setUInt16(1, uint16(mapid));
        stmt->setUInt8(2, uint8(difficulty));
        CharacterDatabase.Execute(stmt);

        // remove all binds to instances of the given map and delete from db (delete per instance id, no mass deletion!)
        // do this after new reset time is calculated
        for (InstanceSaveHashMap::iterator itr = m_instanceSaveById.begin(), itr2; itr != m_instanceSaveById.end(); )
        {
            itr2 = itr++;
            if (itr2->second->GetMapId() == mapid && itr2->second->GetDifficulty() == difficulty)
                _ResetSave(itr2);
        }
    }

    // now loop all existing maps to warn / reset
    Map const* map = sMapMgr->CreateBaseMap(mapid);
    MapInstanced::InstancedMaps& instMaps = ((MapInstanced*)map)->GetInstancedMaps();
    MapInstanced::InstancedMaps::iterator mitr;
    uint32 timeLeft;

    for (mitr = instMaps.begin(); mitr != instMaps.end(); ++mitr)
    {
        Map* map2 = mitr->second;
        if (!map2->IsDungeon() || map2->GetDifficulty() != difficulty)
            continue;

        if (warn)
        {
            if (now >= resetTime)
                timeLeft = 0;
            else
                timeLeft = uint32(resetTime - now);

            map2->ToInstanceMap()->SendResetWarnings(timeLeft);
        }
        else
        {
            InstanceSave* save = GetInstanceSave(map2->GetInstanceId());
            map2->ToInstanceMap()->Reset(INSTANCE_RESET_GLOBAL, (save ? & (save->m_playerList) : nullptr));
        }
    }
}

InstancePlayerBind* InstanceSaveManager::PlayerBindToInstance(ObjectGuid guid, InstanceSave* save, bool permanent, Player* player /*= nullptr*/)
{
    InstancePlayerBind& bind = playerBindStorage[guid]->m[save->GetDifficulty()][save->GetMapId()];
    ASSERT(!bind.perm || permanent); // ensure there's no changing permanent to temporary, this can be done only by unbinding

    if (bind.save)
    {
        if (save != bind.save || permanent != bind.perm)
        {
            bind.extended = false;

            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_INSTANCE);
            stmt->setUInt32(0, save->GetInstanceId());
            stmt->setBool(1, permanent);
            stmt->setUInt32(2, guid.GetCounter());
            stmt->setUInt32(3, bind.save->GetInstanceId());
            CharacterDatabase.Execute(stmt);
        }
    }
    else
    {
        // pussywizard: protect against mysql thread races!
        // pussywizard: CHANGED MY MIND! DON'T SLOW DOWN THIS QUERY! HANDLE ONLY DURING LOADING FROM DB!
        // example: enter instance -> bind -> update old id to new id -> exit -> delete new id
        // if delete by new id is executed before update, then we end up with shit in db
        /*SQLTransaction trans = CharacterDatabase.BeginTransaction();
        // ensure any shit for that map+difficulty is deleted!
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INSTANCE_BY_GUID_MAP_DIFF); // DELETE ci FROM character_instance ci JOIN instance i ON ci.instance = i.id WHERE ci.guid = ? AND i.map = ? AND i.difficulty = ?
        stmt->setUInt32(0, guidLow);
        stmt->setUInt16(1, uint16(save->GetMapId()));
        stmt->setUInt8(2, uint8(save->GetDifficulty()));
        trans->Append(stmt);
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_INSTANCE);
        stmt->setUInt32(0, guidLow);
        stmt->setUInt32(1, save->GetInstanceId());
        stmt->setBool(2, permanent);
        trans->Append(stmt);
        CharacterDatabase.CommitTransaction(trans);*/

        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_INSTANCE);
        stmt->setUInt32(0, guid.GetCounter());
        stmt->setUInt32(1, save->GetInstanceId());
        stmt->setBool(2, permanent);
        CharacterDatabase.Execute(stmt);
    }

    if (bind.save != save)
    {
        if (bind.save)
            bind.save->RemovePlayer(guid, this);
        save->AddPlayer(guid);
    }

    if (permanent)
    {
        save->SetCanReset(false);
        if (!bind.perm && player) // temporary changing to permanent
            player->GetSession()->SendCalendarRaidLockout(save, true);
    }

    bind.save = save;
    bind.perm = permanent;

    if (player)
        sScriptMgr->OnPlayerBindToInstance(player, save->GetDifficulty(), save->GetMapId(), permanent);

    return &bind;
}

void InstanceSaveManager::PlayerUnbindInstance(ObjectGuid guid, uint32 mapid, Difficulty difficulty, bool deleteFromDB, Player* player /*= nullptr*/)
{
    BoundInstancesMapWrapper* w = playerBindStorage[guid];
    BoundInstancesMap::iterator itr = w->m[difficulty].find(mapid);
    if (itr != w->m[difficulty].end())
    {
        if (deleteFromDB)
        {
            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INSTANCE_BY_INSTANCE_GUID);
            stmt->setUInt32(0, guid.GetCounter());
            stmt->setUInt32(1, itr->second.save->GetInstanceId());
            CharacterDatabase.Execute(stmt);
        }

        if (itr->second.perm && player)
            player->GetSession()->SendCalendarRaidLockout(itr->second.save, false);

        InstanceSave* tmp = itr->second.save;
        w->m[difficulty].erase(itr);
        tmp->RemovePlayer(guid, this);
    }
}

void InstanceSaveManager::PlayerUnbindInstanceNotExtended(ObjectGuid guid, uint32 mapid, Difficulty difficulty, Player* player /*= nullptr*/)
{
    BoundInstancesMapWrapper* w = playerBindStorage[guid];
    BoundInstancesMap::iterator itr = w->m[difficulty].find(mapid);
    if (itr != w->m[difficulty].end())
    {
        if (itr->second.extended)
            itr->second.extended = false;
        else
        {
            if (itr->second.perm && player)
                player->GetSession()->SendCalendarRaidLockout(itr->second.save, false);

            InstanceSave* tmp = itr->second.save;
            w->m[difficulty].erase(itr);
            tmp->RemovePlayer(guid, this);
        }
    }
}

InstancePlayerBind* InstanceSaveManager::PlayerGetBoundInstance(ObjectGuid guid, uint32 mapid, Difficulty difficulty)
{
    Difficulty difficulty_fixed = ( IsSharedDifficultyMap(mapid) ? Difficulty(difficulty % 2) : difficulty);

    MapDifficulty const* mapDiff = GetDownscaledMapDifficultyData(mapid, difficulty_fixed);
    if (!mapDiff)
        return nullptr;

    BoundInstancesMapWrapper* w = nullptr;
    PlayerBindStorage::const_iterator itr = playerBindStorage.find(guid);
    if (itr != playerBindStorage.end())
        w = itr->second;
    else
        return nullptr;

    BoundInstancesMap::iterator itr2 = w->m[difficulty_fixed].find(mapid);
    if (itr2 != w->m[difficulty_fixed].end())
        return &itr2->second;
    else
        return nullptr;
}

bool InstanceSaveManager::PlayerIsPermBoundToInstance(ObjectGuid guid, uint32 mapid, Difficulty difficulty)
{
    if (InstancePlayerBind* bind = PlayerGetBoundInstance(guid, mapid, difficulty))
        if (bind->perm)
            return true;
    return false;
}

BoundInstancesMap const& InstanceSaveManager::PlayerGetBoundInstances(ObjectGuid guid, Difficulty difficulty)
{
    PlayerBindStorage::iterator itr = playerBindStorage.find(guid);
    if (itr != playerBindStorage.end())
        return itr->second->m[difficulty];
    return emptyBoundInstancesMap;
}

void InstanceSaveManager::PlayerCreateBoundInstancesMaps(ObjectGuid guid)
{
    if (playerBindStorage.find(guid) == playerBindStorage.end())
        playerBindStorage[guid] = new BoundInstancesMapWrapper;
}

InstanceSave* InstanceSaveManager::PlayerGetInstanceSave(ObjectGuid guid, uint32 mapid, Difficulty difficulty)
{
    InstancePlayerBind* pBind = PlayerGetBoundInstance(guid, mapid, difficulty);
    return (pBind ? pBind->save : nullptr);
}

uint32 InstanceSaveManager::PlayerGetDestinationInstanceId(Player* player, uint32 mapid, Difficulty difficulty)
{
    // returning 0 means a new instance will be created
    // non-zero implicates that InstanceSave exists

    InstancePlayerBind* ipb = PlayerGetBoundInstance(player->GetGUID(), mapid, difficulty);
    if (ipb && ipb->perm) // 1. self perm
        return ipb->save->GetInstanceId();
    if (Group* g = player->GetGroup())
    {
        if (InstancePlayerBind* ilb = PlayerGetBoundInstance(g->GetLeaderGUID(), mapid, difficulty)) // 2. leader temp/perm
            return ilb->save->GetInstanceId();
        return 0; // 3. in group, no leader bind
    }
    return ipb ? ipb->save->GetInstanceId() : 0; // 4. self temp
}

void InstanceSaveManager::CopyBinds(ObjectGuid from, ObjectGuid to, Player* toPlr)
{
    if (from == to)
        return;

    for (uint8 d = 0; d < MAX_DIFFICULTY; ++d)
    {
        BoundInstancesMap const& bi = PlayerGetBoundInstances(from, Difficulty(d));
        for (BoundInstancesMap::const_iterator itr = bi.begin(); itr != bi.end(); ++itr)
            if (!PlayerGetBoundInstance(to, itr->first, Difficulty(d)))
                PlayerBindToInstance(to, itr->second.save, false, toPlr);
    }
}

void InstanceSaveManager::UnbindAllFor(InstanceSave* save)
{
    GuidList& pList = save->m_playerList;
    while (!pList.empty())
        PlayerUnbindInstance(*(pList.begin()), save->GetMapId(), save->GetDifficulty(), true, ObjectAccessor::FindConnectedPlayer(*(pList.begin())));
}
