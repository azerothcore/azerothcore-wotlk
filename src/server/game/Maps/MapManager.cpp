/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "MapManager.h"
#include "InstanceSaveMgr.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Transport.h"
#include "GridDefines.h"
#include "MapInstanced.h"
#include "InstanceScript.h"
#include "Config.h"
#include "World.h"
#include "CellImpl.h"
#include "Corpse.h"
#include "ObjectMgr.h"
#include "Language.h"
#include "WorldPacket.h"
#include "Group.h"
#include "Player.h"
#include "WorldSession.h"
#include "Opcodes.h"
#include "LFGMgr.h"
#include "Chat.h"
#include "AvgDiffTracker.h"
#ifdef ELUNA
#include "LuaEngine.h"
#endif

MapManager::MapManager()
{
    i_timer[3].SetInterval(sWorld->getIntConfig(CONFIG_INTERVAL_MAPUPDATE));
    mapUpdateStep = 0;
    _nextInstanceId = 0;
}

MapManager::~MapManager()
{
}

MapManager* MapManager::instance()
{
    static MapManager instance;
    return &instance;
}

void MapManager::Initialize()
{
    int num_threads(sWorld->getIntConfig(CONFIG_NUMTHREADS));

    // Start mtmaps if needed.
    if (num_threads > 0 && m_updater.activate(num_threads) == -1)
        abort();
}

void MapManager::InitializeVisibilityDistanceInfo()
{
    for (MapMapType::iterator iter=i_maps.begin(); iter != i_maps.end(); ++iter)
        (*iter).second->InitVisibilityDistance();
}

Map* MapManager::CreateBaseMap(uint32 id)
{
    Map* map = FindBaseMap(id);

    if (map == nullptr)
    {
        ACORE_GUARD(ACE_Thread_Mutex, Lock);

        map = FindBaseMap(id);
        if (map == nullptr) // pussywizard: check again after acquiring mutex
        {
            MapEntry const* entry = sMapStore.LookupEntry(id);
            ASSERT(entry);

            if (entry->Instanceable())
                map = new MapInstanced(id);
            else
            {
                map = new Map(id, 0, REGULAR_DIFFICULTY);
                map->LoadRespawnTimes();
            }

            i_maps[id] = map;
        }
    }

    ASSERT(map);
    return map;
}

Map* MapManager::FindBaseNonInstanceMap(uint32 mapId) const
{
    Map* map = FindBaseMap(mapId);
    if (map && map->Instanceable())
        return nullptr;
    return map;
}

Map* MapManager::CreateMap(uint32 id, Player* player)
{
    Map* m = CreateBaseMap(id);

    if (m && m->Instanceable())
        m = ((MapInstanced*)m)->CreateInstanceForPlayer(id, player);

    return m;
}

Map* MapManager::FindMap(uint32 mapid, uint32 instanceId) const
{
    Map* map = FindBaseMap(mapid);
    if (!map)
        return nullptr;

    if (!map->Instanceable())
        return instanceId == 0 ? map : nullptr;

    return ((MapInstanced*)map)->FindInstanceMap(instanceId);
}

bool MapManager::CanPlayerEnter(uint32 mapid, Player* player, bool loginCheck)
{
    MapEntry const* entry = sMapStore.LookupEntry(mapid);
    if (!entry)
       return false;

    if (!entry->IsDungeon())
        return true;

    InstanceTemplate const* instance = sObjectMgr->GetInstanceTemplate(mapid);
    if (!instance)
        return false;

    Difficulty targetDifficulty, requestedDifficulty;
    targetDifficulty = requestedDifficulty = player->GetDifficulty(entry->IsRaid());
    // Get the highest available difficulty if current setting is higher than the instance allows
    MapDifficulty const* mapDiff = GetDownscaledMapDifficultyData(entry->MapID, targetDifficulty);
    if (!mapDiff)
    {
        player->SendTransferAborted(mapid, TRANSFER_ABORT_DIFFICULTY, requestedDifficulty);
        return false;
    }

    //Bypass checks for GMs
    if (player->IsGameMaster())
        return true;

    char const* mapName = entry->name[player->GetSession()->GetSessionDbcLocale()];

    Group* group = player->GetGroup();
    if (entry->IsRaid())
    {
        // can only enter in a raid group
        if ((!group || !group->isRaidGroup()) && !sWorld->getBoolConfig(CONFIG_INSTANCE_IGNORE_RAID))
        {
            // probably there must be special opcode, because client has this string constant in GlobalStrings.lua
            // TODO: this is not a good place to send the message
            player->GetSession()->SendAreaTriggerMessage(player->GetSession()->GetAcoreString(LANG_INSTANCE_RAID_GROUP_ONLY), mapName);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_MAPS, "MAP: Player '%s' must be in a raid group to enter instance '%s'", player->GetName().c_str(), mapName);
#endif
            return false;
        }
    }

    // xinef: dont allow LFG Group to enter other instance that is selected
    if (group)
        if (group->isLFGGroup())
            if (!sLFGMgr->inLfgDungeonMap(group->GetGUID(), mapid, targetDifficulty))
            {
                player->SendTransferAborted(mapid, TRANSFER_ABORT_MAP_NOT_ALLOWED);
                return false;
            }

    if (!player->IsAlive())
    {
        if (Corpse* corpse = player->GetCorpse())
        {
            // let enter in ghost mode in instance that connected to inner instance with corpse
            uint32 corpseMap = corpse->GetMapId();
            do
            {
                if (corpseMap == mapid)
                    break;

                InstanceTemplate const* corpseInstance = sObjectMgr->GetInstanceTemplate(corpseMap);
                corpseMap = corpseInstance ? corpseInstance->Parent : 0;
            } while (corpseMap);

            if (!corpseMap)
            {
                WorldPacket data(SMSG_CORPSE_NOT_IN_INSTANCE, 0);
                player->GetSession()->SendPacket(&data);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_MAPS, "MAP: Player '%s' does not have a corpse in instance '%s' and cannot enter.", player->GetName().c_str(), mapName);
#endif
                return false;
            }
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_MAPS, "MAP: Player '%s' has corpse in instance '%s' and can enter.", player->GetName().c_str(), mapName);
#endif
            player->ResurrectPlayer(0.5f, false);
            player->SpawnCorpseBones();
        }
        else {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_MAPS, "Map::CanPlayerEnter - player '%s' is dead but does not have a corpse!", player->GetName().c_str());
#endif
        }
    }

    // if map exists - check for being full, etc.
    if (!loginCheck) // for login this is done by the calling function
    {
        uint32 destInstId = sInstanceSaveMgr->PlayerGetDestinationInstanceId(player, mapid, targetDifficulty);
        if (destInstId)
            if (Map* boundMap = sMapMgr->FindMap(mapid, destInstId))
                if (!boundMap->CanEnter(player, loginCheck))
                    return false;
    }

    // players are only allowed to enter 5 instances per hour
    if (entry->IsDungeon() && (!group || !group->isLFGGroup() || !group->IsLfgRandomInstance()))
    {
        uint32 instaceIdToCheck = 0;
        if (InstanceSave* save = sInstanceSaveMgr->PlayerGetInstanceSave(player->GetGUIDLow(), mapid, player->GetDifficulty(entry->IsRaid())))
            instaceIdToCheck = save->GetInstanceId();

        // instaceIdToCheck can be 0 if save not found - means no bind so the instance is new
        if (!player->CheckInstanceCount(instaceIdToCheck) && !player->isDead())
        {
            player->SendTransferAborted(mapid, TRANSFER_ABORT_TOO_MANY_INSTANCES);
            return false;
        }
    }

    //Other requirements
    return player->Satisfy(sObjectMgr->GetAccessRequirement(mapid, targetDifficulty), mapid, true);
}

void MapManager::Update(uint32 diff)
{
    for (uint8 i=0; i<4; ++i)
        i_timer[i].Update(diff);

    // pussywizard: lfg compatibles update, schedule before maps so it is processed from the very beginning
    //if (mapUpdateStep == 0)
    {
        if (m_updater.activated())
            m_updater.schedule_lfg_update(diff);
        else
        {
            uint32 startTime = getMSTime();
            sLFGMgr->Update(diff, 1);
            uint32 totalTime = getMSTimeDiff(startTime, getMSTime());
            lfgDiffTracker.Update(10000+totalTime); // +10k to mark it was NOT multithreaded
        }
    }

    MapMapType::iterator iter = i_maps.begin();
    for (; iter != i_maps.end(); ++iter)
    {
        bool full = mapUpdateStep<3 && ((mapUpdateStep==0 && !iter->second->IsBattlegroundOrArena() && !iter->second->IsDungeon()) || (mapUpdateStep==1 && iter->second->IsBattlegroundOrArena()) || (mapUpdateStep==2 && iter->second->IsDungeon()));
        if (m_updater.activated())
            m_updater.schedule_update(*iter->second, uint32(full ? i_timer[mapUpdateStep].GetCurrent() : 0), diff);
        else
            iter->second->Update(uint32(full ? i_timer[mapUpdateStep].GetCurrent() : 0), diff);
    }

    if (m_updater.activated())
        m_updater.wait();

    sObjectAccessor->ProcessDelayedCorpseActions();

    if (mapUpdateStep<3)
    {
        for (iter = i_maps.begin(); iter != i_maps.end(); ++iter)
        {
            bool full = ((mapUpdateStep==0 && !iter->second->IsBattlegroundOrArena() && !iter->second->IsDungeon()) || (mapUpdateStep==1 && iter->second->IsBattlegroundOrArena()) || (mapUpdateStep==2 && iter->second->IsDungeon()));
            if (full)
                iter->second->DelayedUpdate(uint32(i_timer[mapUpdateStep].GetCurrent()));
        }

        i_timer[mapUpdateStep].SetCurrent(0);
        ++mapUpdateStep;
    }

    sObjectAccessor->Update(0);

    if (mapUpdateStep == 3 && i_timer[3].Passed())
    {
        mapUpdateStep = 0;
        i_timer[3].SetCurrent(0);
    }
}

void MapManager::DoDelayedMovesAndRemoves()
{
}

bool MapManager::ExistMapAndVMap(uint32 mapid, float x, float y)
{
    GridCoord p = acore::ComputeGridCoord(x, y);

    int gx=63-p.x_coord;
    int gy=63-p.y_coord;

    return Map::ExistMap(mapid, gx, gy) && Map::ExistVMap(mapid, gx, gy);
}

bool MapManager::IsValidMAP(uint32 mapid, bool startUp)
{
    MapEntry const* mEntry = sMapStore.LookupEntry(mapid);

    if (startUp)
        return !!mEntry;
    else
        return mEntry && (!mEntry->IsDungeon() || sObjectMgr->GetInstanceTemplate(mapid));

    // TODO: add check for battleground template
}

void MapManager::UnloadAll()
{
    for (MapMapType::iterator iter = i_maps.begin(); iter != i_maps.end();)
    {
        iter->second->UnloadAll();
        delete iter->second;
        i_maps.erase(iter++);
    }

    if (m_updater.activated())
        m_updater.deactivate();
}

void MapManager::GetNumInstances(uint32& dungeons, uint32& battlegrounds, uint32& arenas)
{
    for (MapMapType::iterator itr = i_maps.begin(); itr != i_maps.end(); ++itr)
    {
        Map* map = itr->second;
        if (!map->Instanceable())
            continue;
        MapInstanced::InstancedMaps &maps = ((MapInstanced*)map)->GetInstancedMaps();
        for (MapInstanced::InstancedMaps::iterator mitr = maps.begin(); mitr != maps.end(); ++mitr)
        {
            if (mitr->second->IsDungeon()) dungeons++;
            else if (mitr->second->IsBattleground()) battlegrounds++;
            else if (mitr->second->IsBattleArena()) arenas++;
        }
    }
}

void MapManager::GetNumPlayersInInstances(uint32& dungeons, uint32& battlegrounds, uint32& arenas, uint32& spectators)
{
    for (MapMapType::iterator itr = i_maps.begin(); itr != i_maps.end(); ++itr)
    {
        Map* map = itr->second;
        if (!map->Instanceable())
            continue;
        MapInstanced::InstancedMaps &maps = ((MapInstanced*)map)->GetInstancedMaps();
        for (MapInstanced::InstancedMaps::iterator mitr = maps.begin(); mitr != maps.end(); ++mitr)
        {
            if (mitr->second->IsDungeon()) dungeons += ((InstanceMap*)mitr->second)->GetPlayers().getSize();
            else if (mitr->second->IsBattleground()) battlegrounds += ((InstanceMap*)mitr->second)->GetPlayers().getSize();
            else if (mitr->second->IsBattleArena())
            {
                uint32 spect = 0;
                if (BattlegroundMap* bgmap = mitr->second->ToBattlegroundMap())
                    if (Battleground* bg = bgmap->GetBG())
                        spect = bg->GetSpectators().size();

                arenas += ((InstanceMap*)mitr->second)->GetPlayers().getSize() - spect;
                spectators += spect;
            }
        }
    }
}

void MapManager::InitInstanceIds()
{
    _nextInstanceId = 1;

    QueryResult result = CharacterDatabase.Query("SELECT MAX(id) FROM instance");
    if (result)
    {
        uint32 maxId = (*result)[0].GetUInt32();
        _instanceIds.resize(maxId+1);
    }
}

void MapManager::RegisterInstanceId(uint32 instanceId)
{
    // Allocation was done in InitInstanceIds()
    _instanceIds[instanceId] = true;

    // Instances are pulled in ascending order from db and _nextInstanceId is initialized with 1,
    // so if the instance id is used, increment
    if (_nextInstanceId == instanceId)
        ++_nextInstanceId;
}

uint32 MapManager::GenerateInstanceId()
{
    uint32 newInstanceId = _nextInstanceId;

    // find the lowest available id starting from the current _nextInstanceId
    while (_nextInstanceId < 0xFFFFFFFF && ++_nextInstanceId < _instanceIds.size() && _instanceIds[_nextInstanceId]);

    if (_nextInstanceId == 0xFFFFFFFF)
    {
        sLog->outError("Instance ID overflow!! Can't continue, shutting down server. ");
        World::StopNow(ERROR_EXIT_CODE);
    }

    return newInstanceId;
}
