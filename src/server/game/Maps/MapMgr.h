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

#ifndef ACORE_MAPMANAGER_H
#define ACORE_MAPMANAGER_H

#include "Common.h"
#include "Define.h"
#include "Map.h"
#include "MapInstanced.h"
#include "MapUpdater.h"
#include "Object.h"

class Transport;
class StaticTransport;
class MotionTransport;
struct TransportCreatureProto;

class MapMgr
{
public:
    static MapMgr* instance();

    Map* CreateBaseMap(uint32 mapId);
    Map* FindBaseNonInstanceMap(uint32 mapId) const;
    Map* CreateMap(uint32 mapId, Player* player);
    Map* FindMap(uint32 mapId, uint32 instanceId) const;

    Map* FindBaseMap(uint32 mapId) const // pussywizard: need this public for movemaps (mmaps)
    {
        MapMapType::const_iterator iter = i_maps.find(mapId);
        return (iter == i_maps.end() ? nullptr : iter->second);
    }

    [[nodiscard]] uint32 GetAreaId(uint32 phaseMask, uint32 mapid, float x, float y, float z) const
    {
        Map const* m = const_cast<MapMgr*>(this)->CreateBaseMap(mapid);
        return m->GetAreaId(phaseMask, x, y, z);
    }
    [[nodiscard]] uint32 GetAreaId(uint32 phaseMask, uint32 mapid, Position const& pos) const { return GetAreaId(phaseMask, mapid, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ()); }
    [[nodiscard]] uint32 GetAreaId(uint32 phaseMask, WorldLocation const& loc) const { return GetAreaId(phaseMask, loc.GetMapId(), loc); }

    [[nodiscard]] uint32 GetZoneId(uint32 phaseMask, uint32 mapid, float x, float y, float z) const
    {
        Map const* m = const_cast<MapMgr*>(this)->CreateBaseMap(mapid);
        return m->GetZoneId(phaseMask, x, y, z);
    }
    [[nodiscard]] uint32 GetZoneId(uint32 phaseMask, uint32 mapid, Position const& pos) const { return GetZoneId(phaseMask, mapid, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ()); }
    [[nodiscard]] uint32 GetZoneId(uint32 phaseMask, WorldLocation const& loc) const { return GetZoneId(phaseMask, loc.GetMapId(), loc); }

    void GetZoneAndAreaId(uint32 phaseMask, uint32& zoneid, uint32& areaid, uint32 mapid, float x, float y, float z)
    {
        Map const* m = const_cast<MapMgr*>(this)->CreateBaseMap(mapid);
        m->GetZoneAndAreaId(phaseMask, zoneid, areaid, x, y, z);
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

    //void LoadGrid(int mapid, int instId, float x, float y, WorldObject const* obj, bool no_unload = false);
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
            mod = std::fmod(mod, 2.0f * static_cast<float>(M_PI));
            mod = -mod + 2.0f * static_cast<float>(M_PI);
            return mod;
        }
        return std::fmod(o, 2.0f * static_cast<float>(M_PI));
    }

    /**
    * @name GetInstanceIDs
    * @return vector of instance IDs
    */
    std::vector<bool> GetInstanceIDs()
    {
        return _instanceIds;
    }

    void DoDelayedMovesAndRemoves();

    Map::EnterState PlayerCannotEnter(uint32 mapid, Player* player, bool loginCheck = false);
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

    MapMgr();
    ~MapMgr();

    MapMgr(const MapMgr&);
    MapMgr& operator=(const MapMgr&);

    std::mutex Lock;
    MapMapType i_maps;
    IntervalTimer i_timer[4]; // continents, bgs/arenas, instances, total from the beginning
    uint8 mapUpdateStep;

    InstanceIds _instanceIds;
    uint32 _nextInstanceId;
    MapUpdater m_updater;
};

template<typename Worker>
void MapMgr::DoForAllMaps(Worker&& worker)
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
inline void MapMgr::DoForAllMapsWithMapId(uint32 mapId, Worker&& worker)
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

#define sMapMgr MapMgr::instance()

#endif
