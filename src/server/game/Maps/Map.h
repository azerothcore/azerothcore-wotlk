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

#ifndef ACORE_MAP_H
#define ACORE_MAP_H

#include "Cell.h"
#include "DBCStructure.h"
#include "DataMap.h"
#include "Define.h"
#include "DynamicTree.h"
#include "GameObjectModel.h"
#include "GridDefines.h"
#include "GridRefMgr.h"
#include "MapGridManager.h"
#include "MapRefMgr.h"
#include "ObjectDefines.h"
#include "ObjectGuid.h"
#include "PathGenerator.h"
#include "Position.h"
#include "SharedDefines.h"
#include "TaskScheduler.h"
#include "GridTerrainData.h"
#include <bitset>
#include <list>
#include <memory>
#include <shared_mutex>

class Unit;
class WorldPacket;
class InstanceScript;
class Group;
class InstanceSave;
class Object;
class WorldObject;
class TempSummon;
class Player;
class CreatureGroup;
struct ScriptInfo;
struct ScriptAction;
struct Position;
class Battleground;
class MapInstanced;
class InstanceMap;
class BattlegroundMap;
class Transport;
class StaticTransport;
class MotionTransport;
class PathGenerator;

enum WeatherState : uint32;

namespace VMAP
{
    enum class ModelIgnoreFlags : uint32;
}

namespace Acore
{
    struct ObjectUpdater;
    struct LargeObjectUpdater;
}

struct ScriptAction
{
    ObjectGuid sourceGUID;
    ObjectGuid targetGUID;
    ObjectGuid ownerGUID;                                   // owner of source if source is item
    ScriptInfo const* script;                               // pointer to static script data
};

#define DEFAULT_HEIGHT_SEARCH     50.0f                     // default search distance to find height at nearby locations
#define MIN_UNLOAD_DELAY      1                             // immediate unload

struct PositionFullTerrainStatus
{
    PositionFullTerrainStatus()  = default;
    uint32 areaId{0};
    float floorZ{INVALID_HEIGHT};
    bool outdoors{false};
    LiquidData liquidInfo;
};

enum LineOfSightChecks
{
    LINEOFSIGHT_CHECK_VMAP          = 0x1, // check static floor layout data
    LINEOFSIGHT_CHECK_GOBJECT_WMO   = 0x2, // check dynamic game object data (wmo models)
    LINEOFSIGHT_CHECK_GOBJECT_M2    = 0x4, // check dynamic game object data (m2 models)

    LINEOFSIGHT_CHECK_GOBJECT_ALL   = LINEOFSIGHT_CHECK_GOBJECT_WMO | LINEOFSIGHT_CHECK_GOBJECT_M2,

    LINEOFSIGHT_ALL_CHECKS          = LINEOFSIGHT_CHECK_VMAP | LINEOFSIGHT_CHECK_GOBJECT_ALL
};

// GCC have alternative #pragma pack(N) syntax and old gcc version not support pack(push, N), also any gcc version not support it at some platform
#if defined(__GNUC__)
#pragma pack(1)
#else
#pragma pack(push, 1)
#endif

struct InstanceTemplate
{
    uint32 Parent;
    uint32 ScriptId;
    bool AllowMount;
};

enum LevelRequirementVsMode
{
    LEVELREQUIREMENT_HEROIC = 70
};

struct ZoneDynamicInfo
{
    ZoneDynamicInfo();

    uint32 MusicId;
    WeatherState WeatherId;
    float WeatherGrade;
    uint32 OverrideLightId;
    uint32 LightFadeInTime;
};

#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

typedef std::map<uint32/*leaderDBGUID*/, CreatureGroup*>        CreatureGroupHolderType;
typedef std::unordered_map<uint32 /*zoneId*/, ZoneDynamicInfo> ZoneDynamicInfoMap;
typedef std::set<MotionTransport*> TransportsContainer;

enum EncounterCreditType : uint8
{
    ENCOUNTER_CREDIT_KILL_CREATURE  = 0,
    ENCOUNTER_CREDIT_CAST_SPELL     = 1,
};

class Map : public GridRefMgr<MapGridType>
{
    friend class MapReference;
    friend class GridObjectLoader;
public:
    Map(uint32 id, uint32 InstanceId, uint8 SpawnMode, Map* _parent = nullptr);
    ~Map() override;

    [[nodiscard]] MapEntry const* GetEntry() const { return i_mapEntry; }

    // currently unused for normal maps
    bool CanUnload(uint32 diff)
    {
        if (!m_unloadTimer)
            return false;

        if (m_unloadTimer <= diff)
            return true;

        m_unloadTimer -= diff;
        return false;
    }

    virtual bool AddPlayerToMap(Player*);
    virtual void RemovePlayerFromMap(Player*, bool);
    virtual void AfterPlayerUnlinkFromMap();
    template<class T> bool AddToMap(T*, bool checkTransport = false);
    template<class T> void RemoveFromMap(T*, bool);

    void VisitNearbyCellsOf(WorldObject* obj, TypeContainerVisitor<Acore::ObjectUpdater, GridTypeMapContainer>& gridVisitor,
                            TypeContainerVisitor<Acore::ObjectUpdater, WorldTypeMapContainer>& worldVisitor,
                            TypeContainerVisitor<Acore::ObjectUpdater, GridTypeMapContainer>& largeGridVisitor,
                            TypeContainerVisitor<Acore::ObjectUpdater, WorldTypeMapContainer>& largeWorldVisitor);
    void VisitNearbyCellsOfPlayer(Player* player, TypeContainerVisitor<Acore::ObjectUpdater, GridTypeMapContainer>& gridVisitor,
                                  TypeContainerVisitor<Acore::ObjectUpdater, WorldTypeMapContainer>& worldVisitor,
                                  TypeContainerVisitor<Acore::ObjectUpdater, GridTypeMapContainer>& largeGridVisitor,
                                  TypeContainerVisitor<Acore::ObjectUpdater, WorldTypeMapContainer>& largeWorldVisitor);

    virtual void Update(const uint32, const uint32, bool thread = true);

    [[nodiscard]] float GetVisibilityRange() const { return m_VisibleDistance; }
    void SetVisibilityRange(float range) { m_VisibleDistance = range; }
    void OnCreateMap();
    //function for setting up visibility distance for maps on per-type/per-Id basis
    virtual void InitVisibilityDistance();

    void PlayerRelocation(Player*, float x, float y, float z, float o);
    void CreatureRelocation(Creature* creature, float x, float y, float z, float o);
    void GameObjectRelocation(GameObject* go, float x, float y, float z, float o);
    void DynamicObjectRelocation(DynamicObject* go, float x, float y, float z, float o);

    template<class T, class CONTAINER> void Visit(const Cell& cell, TypeContainerVisitor<T, CONTAINER>& visitor);

    bool IsGridLoaded(GridCoord const& gridCoord) const;
    bool IsGridLoaded(float x, float y) const
    {
        return IsGridLoaded(Acore::ComputeGridCoord(x, y));
    }
    bool IsGridCreated(GridCoord const& gridCoord) const;
    bool IsGridCreated(float x, float y) const
    {
        return IsGridCreated(Acore::ComputeGridCoord(x, y));
    }

    void LoadGrid(float x, float y);
    void LoadAllGrids();
    void LoadGridsInRange(Position const& center, float radius);
    bool UnloadGrid(MapGridType& grid);
    virtual void UnloadAll();

    std::shared_ptr<GridTerrainData> GetGridTerrainDataSharedPtr(GridCoord const& gridCoord);
    GridTerrainData* GetGridTerrainData(GridCoord const& gridCoord);
    GridTerrainData* GetGridTerrainData(float x, float y);

    [[nodiscard]] uint32 GetId() const { return i_mapEntry->MapID; }

    [[nodiscard]] Map const* GetParent() const { return m_parentMap; }

    // pussywizard: movemaps, mmaps
    [[nodiscard]] std::shared_mutex& GetMMapLock() const { return *(const_cast<std::shared_mutex*>(&MMapLock)); }
    // pussywizard:
    std::unordered_set<Unit*> i_objectsForDelayedVisibility;
    void HandleDelayedVisibility();

    // some calls like isInWater should not use vmaps due to processor power
    // can return INVALID_HEIGHT if under z+2 z coord not found height
    [[nodiscard]] float GetHeight(float x, float y, float z, bool checkVMap = true, float maxSearchDist = DEFAULT_HEIGHT_SEARCH) const;
    [[nodiscard]] float GetGridHeight(float x, float y) const;
    [[nodiscard]] float GetMinHeight(float x, float y) const;
    Transport* GetTransportForPos(uint32 phase, float x, float y, float z, WorldObject* worldobject = nullptr);

    void GetFullTerrainStatusForPosition(uint32 phaseMask, float x, float y, float z, float collisionHeight, PositionFullTerrainStatus& data, uint8 reqLiquidType = MAP_ALL_LIQUIDS);
    LiquidData const GetLiquidData(uint32 phaseMask, float x, float y, float z, float collisionHeight, uint8 ReqLiquidType);

    [[nodiscard]] bool GetAreaInfo(uint32 phaseMask, float x, float y, float z, uint32& mogpflags, int32& adtId, int32& rootId, int32& groupId) const;
    [[nodiscard]] uint32 GetAreaId(uint32 phaseMask, float x, float y, float z) const;
    [[nodiscard]] uint32 GetZoneId(uint32 phaseMask, float x, float y, float z) const;
    void GetZoneAndAreaId(uint32 phaseMask, uint32& zoneid, uint32& areaid, float x, float y, float z) const;

    [[nodiscard]] float GetWaterLevel(float x, float y) const;
    [[nodiscard]] bool IsInWater(uint32 phaseMask, float x, float y, float z, float collisionHeight) const;
    [[nodiscard]] bool IsUnderWater(uint32 phaseMask, float x, float y, float z, float collisionHeight) const;
    [[nodiscard]] bool HasEnoughWater(WorldObject const* searcher, float x, float y, float z) const;
    [[nodiscard]] bool HasEnoughWater(WorldObject const* searcher, LiquidData const& liquidData) const;

    void MoveAllCreaturesInMoveList();
    void MoveAllGameObjectsInMoveList();
    void MoveAllDynamicObjectsInMoveList();
    void RemoveAllObjectsInRemoveList();
    virtual void RemoveAllPlayers();

    [[nodiscard]] uint32 GetInstanceId() const { return i_InstanceId; }
    [[nodiscard]] uint8 GetSpawnMode() const { return (i_spawnMode); }

    enum EnterState
    {
        CAN_ENTER = 0,
        CANNOT_ENTER_ALREADY_IN_MAP = 1, // Player is already in the map
        CANNOT_ENTER_NO_ENTRY, // No map entry was found for the target map ID
        CANNOT_ENTER_UNINSTANCED_DUNGEON, // No instance template was found for dungeon map
        CANNOT_ENTER_DIFFICULTY_UNAVAILABLE, // Requested instance difficulty is not available for target map
        CANNOT_ENTER_NOT_IN_RAID, // Target instance is a raid instance and the player is not in a raid group
        CANNOT_ENTER_CORPSE_IN_DIFFERENT_INSTANCE, // Player is dead and their corpse is not in target instance
        CANNOT_ENTER_INSTANCE_BIND_MISMATCH, // Player's permanent instance save is not compatible with their group's current instance bind
        CANNOT_ENTER_TOO_MANY_INSTANCES, // Player has entered too many instances recently
        CANNOT_ENTER_MAX_PLAYERS, // Target map already has the maximum number of players allowed
        CANNOT_ENTER_ZONE_IN_COMBAT, // A boss encounter is currently in progress on the target map
        CANNOT_ENTER_UNSPECIFIED_REASON
    };

    virtual EnterState CannotEnter(Player* /*player*/, bool /*loginCheck = false*/) { return CAN_ENTER; }

    [[nodiscard]] const char* GetMapName() const;

    // have meaning only for instanced map (that have set real difficulty)
    [[nodiscard]] Difficulty GetDifficulty() const { return Difficulty(GetSpawnMode()); }
    [[nodiscard]] bool IsRegularDifficulty() const { return GetDifficulty() == REGULAR_DIFFICULTY; }
    [[nodiscard]] MapDifficulty const* GetMapDifficulty() const;

    [[nodiscard]] bool Instanceable() const { return i_mapEntry && i_mapEntry->Instanceable(); }
    [[nodiscard]] bool IsDungeon() const { return i_mapEntry && i_mapEntry->IsDungeon(); }
    [[nodiscard]] bool IsNonRaidDungeon() const { return i_mapEntry && i_mapEntry->IsNonRaidDungeon(); }
    [[nodiscard]] bool IsRaid() const { return i_mapEntry && i_mapEntry->IsRaid(); }
    [[nodiscard]] bool IsRaidOrHeroicDungeon() const { return IsRaid() || i_spawnMode > DUNGEON_DIFFICULTY_NORMAL; }
    [[nodiscard]] bool IsHeroic() const { return IsRaid() ? i_spawnMode >= RAID_DIFFICULTY_10MAN_HEROIC : i_spawnMode >= DUNGEON_DIFFICULTY_HEROIC; }
    [[nodiscard]] bool Is25ManRaid() const { return IsRaid() && i_spawnMode & RAID_DIFFICULTY_MASK_25MAN; }   // since 25man difficulties are 1 and 3, we can check them like that
    [[nodiscard]] bool IsBattleground() const { return i_mapEntry && i_mapEntry->IsBattleground(); }
    [[nodiscard]] bool IsBattleArena() const { return i_mapEntry && i_mapEntry->IsBattleArena(); }
    [[nodiscard]] bool IsBattlegroundOrArena() const { return i_mapEntry && i_mapEntry->IsBattlegroundOrArena(); }
    [[nodiscard]] bool IsWorldMap() const { return i_mapEntry && i_mapEntry->IsWorldMap(); }

    bool GetEntrancePos(int32& mapid, float& x, float& y)
    {
        if (!i_mapEntry)
            return false;
        return i_mapEntry->GetEntrancePos(mapid, x, y);
    }

    void AddObjectToRemoveList(WorldObject* obj);
    void AddObjectToSwitchList(WorldObject* obj, bool on);
    virtual void DelayedUpdate(const uint32 diff);

    void resetMarkedCells() { marked_cells.reset(); }
    bool isCellMarked(uint32 pCellId) { return marked_cells.test(pCellId); }
    void markCell(uint32 pCellId) { marked_cells.set(pCellId); }
    void resetMarkedCellsLarge() { marked_cells_large.reset(); }
    bool isCellMarkedLarge(uint32 pCellId) { return marked_cells_large.test(pCellId); }
    void markCellLarge(uint32 pCellId) { marked_cells_large.set(pCellId); }

    [[nodiscard]] bool HavePlayers() const { return !m_mapRefMgr.IsEmpty(); }
    [[nodiscard]] uint32 GetPlayersCountExceptGMs() const;

    void AddWorldObject(WorldObject* obj) { i_worldObjects.insert(obj); }
    void RemoveWorldObject(WorldObject* obj) { i_worldObjects.erase(obj); }

    void SendToPlayers(WorldPacket const* data) const;

    typedef MapRefMgr PlayerList;
    [[nodiscard]] PlayerList const& GetPlayers() const { return m_mapRefMgr; }

    //per-map script storage
    void ScriptsStart(std::map<uint32, std::multimap<uint32, ScriptInfo> > const& scripts, uint32 id, Object* source, Object* target);
    void ScriptCommandStart(ScriptInfo const& script, uint32 delay, Object* source, Object* target);

    // must called with AddToWorld
    template<class T>
    void AddToActive(T* obj);

    // must called with RemoveFromWorld
    template<class T>
    void RemoveFromActive(T* obj);

    template<class T> void SwitchGridContainers(T* obj, bool on);
    CreatureGroupHolderType CreatureGroupHolder;

    void UpdateIteratorBack(Player* player);

    TempSummon* SummonCreature(uint32 entry, Position const& pos, SummonPropertiesEntry const* properties = nullptr, uint32 duration = 0, WorldObject* summoner = nullptr, uint32 spellId = 0, uint32 vehId = 0, bool visibleBySummonerOnly = false);
    GameObject* SummonGameObject(uint32 entry, float x, float y, float z, float ang, float rotation0, float rotation1, float rotation2, float rotation3, uint32 respawnTime, bool checkTransport = true);
    GameObject* SummonGameObject(uint32 entry, Position const& pos, float rotation0 = 0.0f, float rotation1 = 0.0f, float rotation2 = 0.0f, float rotation3 = 0.0f, uint32 respawnTime = 100, bool checkTransport = true);
    void SummonCreatureGroup(uint8 group, std::list<TempSummon*>* list = nullptr);

    Corpse* GetCorpse(ObjectGuid const guid);
    Creature* GetCreature(ObjectGuid const guid);
    GameObject* GetGameObject(ObjectGuid const guid);
    Transport* GetTransport(ObjectGuid const guid);
    DynamicObject* GetDynamicObject(ObjectGuid const guid);
    Pet* GetPet(ObjectGuid const guid);

    MapStoredObjectTypesContainer& GetObjectsStore() { return _objectsStore; }

    typedef std::unordered_multimap<ObjectGuid::LowType, Creature*> CreatureBySpawnIdContainer;
    CreatureBySpawnIdContainer& GetCreatureBySpawnIdStore() { return _creatureBySpawnIdStore; }

    typedef std::unordered_multimap<ObjectGuid::LowType, GameObject*> GameObjectBySpawnIdContainer;
    GameObjectBySpawnIdContainer& GetGameObjectBySpawnIdStore() { return _gameobjectBySpawnIdStore; }

    [[nodiscard]] std::unordered_set<Corpse*> const* GetCorpsesInCell(uint32 cellId) const
    {
        auto itr = _corpsesByCell.find(cellId);
        if (itr != _corpsesByCell.end())
            return &itr->second;

        return nullptr;
    }

    [[nodiscard]] Corpse* GetCorpseByPlayer(ObjectGuid const& ownerGuid) const
    {
        auto itr = _corpsesByPlayer.find(ownerGuid);
        if (itr != _corpsesByPlayer.end())
            return itr->second;

        return nullptr;
    }

    MapInstanced* ToMapInstanced() { if (Instanceable())  return reinterpret_cast<MapInstanced*>(this); else return nullptr;  }
    [[nodiscard]] MapInstanced const* ToMapInstanced() const { if (Instanceable())  return (const MapInstanced*)((MapInstanced*)this); else return nullptr;  }

    InstanceMap* ToInstanceMap() { if (IsDungeon())  return reinterpret_cast<InstanceMap*>(this); else return nullptr;  }
    [[nodiscard]] InstanceMap const* ToInstanceMap() const { if (IsDungeon())  return (const InstanceMap*)((InstanceMap*)this); else return nullptr;  }

    BattlegroundMap* ToBattlegroundMap() { if (IsBattlegroundOrArena()) return reinterpret_cast<BattlegroundMap*>(this); else return nullptr;  }
    [[nodiscard]] BattlegroundMap const* ToBattlegroundMap() const { if (IsBattlegroundOrArena()) return reinterpret_cast<BattlegroundMap const*>(this); return nullptr; }

    float GetWaterOrGroundLevel(uint32 phasemask, float x, float y, float z, float* ground = nullptr, bool swim = false, float collisionHeight = DEFAULT_COLLISION_HEIGHT) const;
    [[nodiscard]] float GetHeight(uint32 phasemask, float x, float y, float z, bool vmap = true, float maxSearchDist = DEFAULT_HEIGHT_SEARCH) const;
    [[nodiscard]] bool isInLineOfSight(float x1, float y1, float z1, float x2, float y2, float z2, uint32 phasemask, LineOfSightChecks checks, VMAP::ModelIgnoreFlags ignoreFlags) const;
    bool CanReachPositionAndGetValidCoords(WorldObject const* source, PathGenerator *path, float &destX, float &destY, float &destZ, bool failOnCollision = true, bool failOnSlopes = true) const;
    bool CanReachPositionAndGetValidCoords(WorldObject const* source, float &destX, float &destY, float &destZ, bool failOnCollision = true, bool failOnSlopes = true) const;
    bool CanReachPositionAndGetValidCoords(WorldObject const* source, float startX, float startY, float startZ, float &destX, float &destY, float &destZ, bool failOnCollision = true, bool failOnSlopes = true) const;
    bool CheckCollisionAndGetValidCoords(WorldObject const* source, float startX, float startY, float startZ, float &destX, float &destY, float &destZ, bool failOnCollision = true) const;
    void Balance() { _dynamicTree.balance(); }
    void RemoveGameObjectModel(const GameObjectModel& model) { _dynamicTree.remove(model); }
    void InsertGameObjectModel(const GameObjectModel& model) { _dynamicTree.insert(model); }
    [[nodiscard]] bool ContainsGameObjectModel(const GameObjectModel& model) const { return _dynamicTree.contains(model);}
    [[nodiscard]] DynamicMapTree const& GetDynamicMapTree() const { return _dynamicTree; }
    bool GetObjectHitPos(uint32 phasemask, float x1, float y1, float z1, float x2, float y2, float z2, float& rx, float& ry, float& rz, float modifyDist);
    [[nodiscard]] float GetGameObjectFloor(uint32 phasemask, float x, float y, float z, float maxSearchDist = DEFAULT_HEIGHT_SEARCH) const
    {
        return _dynamicTree.getHeight(x, y, z, maxSearchDist, phasemask);
    }
    /*
        RESPAWN TIMES
    */
    [[nodiscard]] time_t GetLinkedRespawnTime(ObjectGuid guid) const;
    [[nodiscard]] time_t GetCreatureRespawnTime(ObjectGuid::LowType dbGuid) const
    {
        std::unordered_map<ObjectGuid::LowType /*dbGUID*/, time_t>::const_iterator itr = _creatureRespawnTimes.find(dbGuid);
        if (itr != _creatureRespawnTimes.end())
            return itr->second;

        return time_t(0);
    }

    [[nodiscard]] time_t GetGORespawnTime(ObjectGuid::LowType dbGuid) const
    {
        std::unordered_map<ObjectGuid::LowType /*dbGUID*/, time_t>::const_iterator itr = _goRespawnTimes.find(dbGuid);
        if (itr != _goRespawnTimes.end())
            return itr->second;

        return time_t(0);
    }

    void SaveCreatureRespawnTime(ObjectGuid::LowType dbGuid, time_t& respawnTime);
    void RemoveCreatureRespawnTime(ObjectGuid::LowType dbGuid);
    void SaveGORespawnTime(ObjectGuid::LowType dbGuid, time_t& respawnTime);
    void RemoveGORespawnTime(ObjectGuid::LowType dbGuid);
    void LoadRespawnTimes();
    void DeleteRespawnTimes();
    [[nodiscard]] time_t GetInstanceResetPeriod() const { return _instanceResetPeriod; }

    void UpdatePlayerZoneStats(uint32 oldZone, uint32 newZone);
    [[nodiscard]] uint32 ApplyDynamicModeRespawnScaling(WorldObject const* obj, uint32 respawnDelay) const;

    TaskScheduler _creatureRespawnScheduler;

    void ScheduleCreatureRespawn(ObjectGuid /*creatureGuid*/, Milliseconds /*respawnTimer*/, Position pos = Position());

    void LoadCorpseData();
    void DeleteCorpseData();
    void AddCorpse(Corpse* corpse);
    void RemoveCorpse(Corpse* corpse);
    Corpse* ConvertCorpseToBones(ObjectGuid const ownerGuid, bool insignia = false);
    void RemoveOldCorpses();

    static void DeleteRespawnTimesInDB(uint16 mapId, uint32 instanceId);

    void SendInitTransports(Player* player);
    void SendRemoveTransports(Player* player);
    void SendZoneDynamicInfo(Player* player);
    void SendInitSelf(Player* player);

    void PlayDirectSoundToMap(uint32 soundId, uint32 zoneId = 0);
    void SetZoneMusic(uint32 zoneId, uint32 musicId);
    void SetZoneWeather(uint32 zoneId, WeatherState weatherId, float weatherGrade);
    void SetZoneOverrideLight(uint32 zoneId, uint32 lightId, Milliseconds fadeInTime);

    // Checks encounter state at kill/spellcast, originally in InstanceScript however not every map has instance script :(
    void UpdateEncounterState(EncounterCreditType type, uint32 creditEntry, Unit* source);
    void LogEncounterFinished(EncounterCreditType type, uint32 creditEntry);

    // Do whatever you want to all the players in map [including GameMasters], i.e.: param exec = [&](Player* p) { p->Whatever(); }
    void DoForAllPlayers(std::function<void(Player*)> exec);

    void EnsureGridCreated(GridCoord const& gridCoord);
    [[nodiscard]] bool AllTransportsEmpty() const; // pussywizard
    void AllTransportsRemovePassengers(); // pussywizard
    [[nodiscard]] TransportsContainer const& GetAllTransports() const { return _transports; }

    DataMap CustomData;

    template<HighGuid high>
    inline ObjectGuid::LowType GenerateLowGuid()
    {
        static_assert(ObjectGuidTraits<high>::MapSpecific, "Only map specific guid can be generated in Map context");
        return GetGuidSequenceGenerator<high>().Generate();
    }

    void AddUpdateObject(Object* obj)
    {
        _updateObjects.insert(obj);
    }

    void RemoveUpdateObject(Object* obj)
    {
        _updateObjects.erase(obj);
    }

    std::size_t GetActiveNonPlayersCount() const
    {
        return m_activeNonPlayers.size();
    }

    virtual std::string GetDebugInfo() const;

    uint32 GetCreatedGridsCount();
    uint32 GetLoadedGridsCount();
    uint32 GetCreatedCellsInGridCount(uint16 const x, uint16 const y);
    uint32 GetCreatedCellsInMapCount();

private:

    template<class T> void InitializeObject(T* obj);
    void AddCreatureToMoveList(Creature* c);
    void RemoveCreatureFromMoveList(Creature* c);
    void AddGameObjectToMoveList(GameObject* go);
    void RemoveGameObjectFromMoveList(GameObject* go);
    void AddDynamicObjectToMoveList(DynamicObject* go);
    void RemoveDynamicObjectFromMoveList(DynamicObject* go);

    std::vector<Creature*> _creaturesToMove;
    std::vector<GameObject*> _gameObjectsToMove;
    std::vector<DynamicObject*> _dynamicObjectsToMove;

    bool EnsureGridLoaded(Cell const& cell);
    MapGridType* GetMapGrid(uint16 const x, uint16 const y);

    void ScriptsProcess();

    void SendObjectUpdates();

protected:
    // Type specific code for add/remove to/from grid
    template<class T>
    void AddToGrid(T* object, Cell const& cell);

    std::mutex Lock;
    std::shared_mutex MMapLock;

    MapGridManager _mapGridManager;
    MapEntry const* i_mapEntry;
    uint8 i_spawnMode;
    uint32 i_InstanceId;
    uint32 m_unloadTimer;
    float m_VisibleDistance;
    DynamicMapTree _dynamicTree;
    time_t _instanceResetPeriod; // pussywizard

    MapRefMgr m_mapRefMgr;
    MapRefMgr::iterator m_mapRefIter;

    typedef std::set<WorldObject*> ActiveNonPlayers;
    ActiveNonPlayers m_activeNonPlayers;
    ActiveNonPlayers::iterator m_activeNonPlayersIter;

    // Objects that must update even in inactive grids without activating them
    TransportsContainer _transports;
    TransportsContainer::iterator _transportsUpdateIter;

private:
    Player* _GetScriptPlayerSourceOrTarget(Object* source, Object* target, const ScriptInfo* scriptInfo) const;
    Creature* _GetScriptCreatureSourceOrTarget(Object* source, Object* target, const ScriptInfo* scriptInfo, bool bReverse = false) const;
    Unit* _GetScriptUnit(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const;
    Player* _GetScriptPlayer(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const;
    Creature* _GetScriptCreature(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const;
    WorldObject* _GetScriptWorldObject(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const;
    void _ScriptProcessDoor(Object* source, Object* target, const ScriptInfo* scriptInfo) const;
    GameObject* _FindGameObject(WorldObject* pWorldObject, ObjectGuid::LowType guid) const;

    //used for fast base_map (e.g. MapInstanced class object) search for
    //InstanceMaps and BattlegroundMaps...
    Map* m_parentMap;

    std::bitset<TOTAL_NUMBER_OF_CELLS_PER_MAP * TOTAL_NUMBER_OF_CELLS_PER_MAP> marked_cells;
    std::bitset<TOTAL_NUMBER_OF_CELLS_PER_MAP * TOTAL_NUMBER_OF_CELLS_PER_MAP> marked_cells_large;

    bool i_scriptLock;
    std::unordered_set<WorldObject*> i_objectsToRemove;
    std::map<WorldObject*, bool> i_objectsToSwitch;
    std::unordered_set<WorldObject*> i_worldObjects;

    typedef std::multimap<time_t, ScriptAction> ScriptScheduleMap;
    ScriptScheduleMap m_scriptSchedule;

    template<class T>
    void DeleteFromWorld(T*);

    void AddToActiveHelper(WorldObject* obj)
    {
        m_activeNonPlayers.insert(obj);
    }

    void RemoveFromActiveHelper(WorldObject* obj)
    {
        // Map::Update for active object in proccess
        if (m_activeNonPlayersIter != m_activeNonPlayers.end())
        {
            ActiveNonPlayers::iterator itr = m_activeNonPlayers.find(obj);
            if (itr == m_activeNonPlayers.end())
                return;
            if (itr == m_activeNonPlayersIter)
                ++m_activeNonPlayersIter;
            m_activeNonPlayers.erase(itr);
        }
        else
            m_activeNonPlayers.erase(obj);
    }

    std::unordered_map<ObjectGuid::LowType /*dbGUID*/, time_t> _creatureRespawnTimes;
    std::unordered_map<ObjectGuid::LowType /*dbGUID*/, time_t> _goRespawnTimes;

    std::unordered_map<uint32, uint32> _zonePlayerCountMap;

    ZoneDynamicInfoMap _zoneDynamicInfo;
    uint32 _defaultLight;

    template<HighGuid high>
    inline ObjectGuidGeneratorBase& GetGuidSequenceGenerator()
    {
        auto itr = _guidGenerators.find(high);
        if (itr == _guidGenerators.end())
            itr = _guidGenerators.insert(std::make_pair(high, std::unique_ptr<ObjectGuidGenerator<high>>(new ObjectGuidGenerator<high>()))).first;

        return *itr->second;
    }

    std::map<HighGuid, std::unique_ptr<ObjectGuidGeneratorBase>> _guidGenerators;
    MapStoredObjectTypesContainer _objectsStore;
    CreatureBySpawnIdContainer _creatureBySpawnIdStore;
    GameObjectBySpawnIdContainer _gameobjectBySpawnIdStore;
    std::unordered_map<uint32/*cellId*/, std::unordered_set<Corpse*>> _corpsesByCell;
    std::unordered_map<ObjectGuid, Corpse*> _corpsesByPlayer;
    std::unordered_set<Corpse*> _corpseBones;

    std::unordered_set<Object*> _updateObjects;
};

enum InstanceResetMethod
{
    INSTANCE_RESET_ALL,                 // reset all option under portrait, resets only normal 5-mans
    INSTANCE_RESET_CHANGE_DIFFICULTY,   // on changing difficulty
    INSTANCE_RESET_GLOBAL,              // global id reset
    INSTANCE_RESET_GROUP_JOIN,          // on joining group
    INSTANCE_RESET_GROUP_LEAVE          // on leaving group
};

class InstanceMap : public Map
{
public:
    InstanceMap(uint32 id, uint32 InstanceId, uint8 SpawnMode, Map* _parent);
    ~InstanceMap() override;
    bool AddPlayerToMap(Player*) override;
    void RemovePlayerFromMap(Player*, bool) override;
    void AfterPlayerUnlinkFromMap() override;
    void Update(const uint32, const uint32, bool thread = true) override;
    void CreateInstanceScript(bool load, std::string data, uint32 completedEncounterMask);
    bool Reset(uint8 method, GuidList* globalSkipList = nullptr);
    [[nodiscard]] uint32 GetScriptId() const { return i_script_id; }
    [[nodiscard]] std::string const& GetScriptName() const;
    [[nodiscard]] InstanceScript* GetInstanceScript() { return instance_data; }
    [[nodiscard]] InstanceScript const* GetInstanceScript() const { return instance_data; }
    void PermBindAllPlayers();
    void UnloadAll() override;
    EnterState CannotEnter(Player* player, bool loginCheck = false) override;
    void SendResetWarnings(uint32 timeLeft) const;

    [[nodiscard]] uint32 GetMaxPlayers() const;
    [[nodiscard]] uint32 GetMaxResetDelay() const;

    void InitVisibilityDistance() override;

    std::string GetDebugInfo() const override;

private:
    bool m_resetAfterUnload;
    bool m_unloadWhenEmpty;
    InstanceScript* instance_data;
    uint32 i_script_id;
};

class BattlegroundMap : public Map
{
public:
    BattlegroundMap(uint32 id, uint32 InstanceId, Map* _parent, uint8 spawnMode);
    ~BattlegroundMap() override;

    bool AddPlayerToMap(Player*) override;
    void RemovePlayerFromMap(Player*, bool) override;
    EnterState CannotEnter(Player* player, bool loginCheck = false) override;
    void SetUnload();
    //void UnloadAll(bool pForce);
    void RemoveAllPlayers() override;

    void InitVisibilityDistance() override;
    Battleground* GetBG() { return m_bg; }
    void SetBG(Battleground* bg) { m_bg = bg; }
private:
    Battleground* m_bg;
};

template<class T, class CONTAINER>
inline void Map::Visit(Cell const& cell, TypeContainerVisitor<T, CONTAINER>& visitor)
{
    uint32 const grid_x = cell.GridX();
    uint32 const grid_y = cell.GridY();

    // If grid is not loaded, nothing to visit.
    if (!IsGridLoaded(GridCoord(grid_x, grid_y)))
        return;

    GetMapGrid(grid_x, grid_y)->VisitCell(cell.CellX(), cell.CellY(), visitor);
}

#endif
