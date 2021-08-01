/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_MAPMANAGER_H
#define ACORE_MAPMANAGER_H

#include "Common.h"
#include "Define.h"
#include "Map.h"
#include "MapUpdater.h"
#include "Object.h"
#include "MapInstanced.h"

#include <mutex>

class Transport;
class StaticTransport;
class MotionTransport;
struct TransportCreatureProto;

class MapManager
{
public:
    static MapManager* instance();

    Map* CreateBaseMap(uint32 mapId);
    Map* FindBaseNonInstanceMap(uint32 mapId) const;
    Map* CreateMap(uint32 mapId, Player* player);
    Map* FindMap(uint32 mapId, uint32 instanceId) const;

    Map* FindBaseMap(uint32 mapId) const // pussywizard: need this public for movemaps (mmaps)
    {
        MapMapType::const_iterator iter = i_maps.find(mapId);
        return (iter == i_maps.end() ? nullptr : iter->second);
    }

    [[nodiscard]] uint32 GetAreaId(uint32 mapid, float x, float y, float z) const
    {
        Map const* m = const_cast<MapManager*>(this)->CreateBaseMap(mapid);
        return m->GetAreaId(x, y, z);
    }
    [[nodiscard]] uint32 GetAreaId(uint32 mapid, Position const& pos) const { return GetAreaId(mapid, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ()); }
    [[nodiscard]] uint32 GetAreaId(WorldLocation const& loc) const { return GetAreaId(loc.GetMapId(), loc); }

    [[nodiscard]] uint32 GetZoneId(uint32 mapid, float x, float y, float z) const
    {
        Map const* m = const_cast<MapManager*>(this)->CreateBaseMap(mapid);
        return m->GetZoneId(x, y, z);
    }
    [[nodiscard]] uint32 GetZoneId(uint32 mapid, Position const& pos) const { return GetZoneId(mapid, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ()); }
    [[nodiscard]] uint32 GetZoneId(WorldLocation const& loc) const { return GetZoneId(loc.GetMapId(), loc); }

    void GetZoneAndAreaId(uint32& zoneid, uint32& areaid, uint32 mapid, float x, float y, float z)
    {
        Map const* m = const_cast<MapManager*>(this)->CreateBaseMap(mapid);
        m->GetZoneAndAreaId(zoneid, areaid, x, y, z);
    }

    void Initialize(void);
    void Update(uint32);

    void SetMapUpdateInterval(uint32 t)
    {
        if (t < MIN_MAP_UPDATE_DELAY)
            t = MIN_MAP_UPDATE_DELAY;

        i_timer[3].SetInterval(t);
        i_timer[3].Reset();
    }

    //void LoadGrid(int mapid, int instId, float x, float y, const WorldObject* obj, bool no_unload = false);
    void UnloadAll();

    static bool ExistMapAndVMap(uint32 mapid, float x, float y);
    static bool IsValidMAP(uint32 mapid, bool startUp);

    static bool IsValidMapCoord(uint32 mapid, Position const& pos)
    {
        return IsValidMapCoord(mapid, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation());
    }

    static bool IsValidMapCoord(uint32 mapid, float x, float y)
    {
        return IsValidMAP(mapid, false) && Acore::IsValidMapCoord(x, y);
    }

    static bool IsValidMapCoord(uint32 mapid, float x, float y, float z)
    {
        return IsValidMAP(mapid, false) && Acore::IsValidMapCoord(x, y, z);
    }

    static bool IsValidMapCoord(uint32 mapid, float x, float y, float z, float o)
    {
        return IsValidMAP(mapid, false) && Acore::IsValidMapCoord(x, y, z, o);
    }

    static bool IsValidMapCoord(WorldLocation const& loc)
    {
        return IsValidMapCoord(loc.GetMapId(), loc.GetPositionX(), loc.GetPositionY(), loc.GetPositionZ(), loc.GetOrientation());
    }

    // modulos a radian orientation to the range of 0..2PI
    static float NormalizeOrientation(float o)
    {
        // fmod only supports positive numbers. Thus we have
        // to emulate negative numbers
        if (o < 0)
        {
            float mod = o * -1;
            mod = fmod(mod, 2.0f * static_cast<float>(M_PI));
            mod = -mod + 2.0f * static_cast<float>(M_PI);
            return mod;
        }
        return fmod(o, 2.0f * static_cast<float>(M_PI));
    }

    void DoDelayedMovesAndRemoves();

    bool CanPlayerEnter(uint32 mapid, Player* player, bool loginCheck = false);
    void InitializeVisibilityDistanceInfo();

    /* statistics */
    void GetNumInstances(uint32& dungeons, uint32& battlegrounds, uint32& arenas);
    void GetNumPlayersInInstances(uint32& dungeons, uint32& battlegrounds, uint32& arenas, uint32& spectators);

    // Instance ID management
    void InitInstanceIds();
    void RegisterInstanceId(uint32 instanceId);
    uint32 GenerateInstanceId();

    MapUpdater* GetMapUpdater() { return &m_updater; }

    template<typename Worker>
    void DoForAllMaps(Worker&& worker);

    template<typename Worker>
    void DoForAllMapsWithMapId(uint32 mapId, Worker&& worker);

private:
    typedef std::unordered_map<uint32, Map*> MapMapType;
    typedef std::vector<bool> InstanceIds;

    MapManager();
    ~MapManager();

    MapManager(const MapManager&);
    MapManager& operator=(const MapManager&);

    std::mutex Lock;
    MapMapType i_maps;
    IntervalTimer i_timer[4]; // continents, bgs/arenas, instances, total from the beginning
    uint8 mapUpdateStep;

    InstanceIds _instanceIds;
    uint32 _nextInstanceId;
    MapUpdater m_updater;
};

template<typename Worker>
void MapManager::DoForAllMaps(Worker&& worker)
{
    std::lock_guard<std::mutex> guard(Lock);

    for (auto& mapPair : i_maps)
    {
        Map* map = mapPair.second;
        if (MapInstanced* mapInstanced = map->ToMapInstanced())
        {
            MapInstanced::InstancedMaps& instances = mapInstanced->GetInstancedMaps();
            for (auto& instancePair : instances)
                worker(instancePair.second);
        }
        else
            worker(map);
    }
}

template<typename Worker>
inline void MapManager::DoForAllMapsWithMapId(uint32 mapId, Worker&& worker)
{
    std::lock_guard<std::mutex> guard(Lock);

    auto itr = i_maps.find(mapId);
    if (itr != i_maps.end())
    {
        Map* map = itr->second;
        if (MapInstanced* mapInstanced = map->ToMapInstanced())
        {
            MapInstanced::InstancedMaps& instances = mapInstanced->GetInstancedMaps();
            for (auto& p : instances)
                worker(p.second);
        }
        else
            worker(map);
    }
}

#define sMapMgr MapManager::instance()

#endif
