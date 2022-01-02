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
#include "MapRefMgr.h"
#include "ObjectDefines.h"
#include "ObjectGuid.h"
#include "PathGenerator.h"
#include "SharedDefines.h"
#include "Timer.h"
#include <bitset>
#include <list>
#include <memory>
#include <mutex>
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

// ******************************************
// Map file format defines
// ******************************************
struct map_fileheader
{
    uint32 mapMagic;
    uint32 versionMagic;
    uint32 buildMagic;
    uint32 areaMapOffset;
    uint32 areaMapSize;
    uint32 heightMapOffset;
    uint32 heightMapSize;
    uint32 liquidMapOffset;
    uint32 liquidMapSize;
    uint32 holesOffset;
    uint32 holesSize;
};

#define MAP_AREA_NO_AREA      0x0001

struct map_areaHeader
{
    uint32 fourcc;
    uint16 flags;
    uint16 gridArea;
};

#define MAP_HEIGHT_NO_HEIGHT            0x0001
#define MAP_HEIGHT_AS_INT16             0x0002
#define MAP_HEIGHT_AS_INT8              0x0004
#define MAP_HEIGHT_HAS_FLIGHT_BOUNDS    0x0008

struct map_heightHeader
{
    uint32 fourcc;
    uint32 flags;
    float  gridHeight;
    float  gridMaxHeight;
};

#define MAP_LIQUID_NO_TYPE    0x0001
#define MAP_LIQUID_NO_HEIGHT  0x0002

struct map_liquidHeader
{
    uint32 fourcc;
    uint16 flags;
    uint16 liquidType;
    uint8  offsetX;
    uint8  offsetY;
    uint8  width;
    uint8  height;
    float  liquidLevel;
};

enum LiquidStatus
{
    LIQUID_MAP_NO_WATER     = 0x00000000,
    LIQUID_MAP_ABOVE_WATER  = 0x00000001,
    LIQUID_MAP_WATER_WALK   = 0x00000002,
    LIQUID_MAP_IN_WATER     = 0x00000004,
    LIQUID_MAP_UNDER_WATER  = 0x00000008
};

#define MAP_LIQUID_STATUS_SWIMMING (LIQUID_MAP_IN_WATER | LIQUID_MAP_UNDER_WATER)
#define MAP_LIQUID_STATUS_IN_CONTACT (MAP_LIQUID_STATUS_SWIMMING | LIQUID_MAP_WATER_WALK)

#define MAP_LIQUID_TYPE_NO_WATER    0x00
#define MAP_LIQUID_TYPE_WATER       0x01
#define MAP_LIQUID_TYPE_OCEAN       0x02
#define MAP_LIQUID_TYPE_MAGMA       0x04
#define MAP_LIQUID_TYPE_SLIME       0x08

#define MAP_ALL_LIQUIDS   (MAP_LIQUID_TYPE_WATER | MAP_LIQUID_TYPE_OCEAN | MAP_LIQUID_TYPE_MAGMA | MAP_LIQUID_TYPE_SLIME)

#define MAP_LIQUID_TYPE_DARK_WATER  0x10
#define MAP_LIQUID_TYPE_WMO_WATER   0x20

#define MAX_HEIGHT            100000.0f                     // can be use for find ground height at surface
#define INVALID_HEIGHT       -100000.0f                     // for check, must be equal to VMAP_INVALID_HEIGHT, real value for unknown height is VMAP_INVALID_HEIGHT_VALUE
#define MAX_FALL_DISTANCE     250000.0f                     // "unlimited fall" to find VMap ground if it is available, just larger than MAX_HEIGHT - INVALID_HEIGHT
#define DEFAULT_HEIGHT_SEARCH     50.0f                     // default search distance to find height at nearby locations
#define MIN_UNLOAD_DELAY      1                             // immediate unload

struct LiquidData
{
    LiquidData()  = default;

    uint32 Entry{0};
    uint32 Flags{0};
    float  Level{INVALID_HEIGHT};
    float  DepthLevel{INVALID_HEIGHT};
    LiquidStatus Status{LIQUID_MAP_NO_WATER};
};

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
    LINEOFSIGHT_CHECK_VMAP      = 0x1, // check static floor layout data
    LINEOFSIGHT_CHECK_GOBJECT   = 0x2, // check dynamic game object data

    LINEOFSIGHT_ALL_CHECKS      = (LINEOFSIGHT_CHECK_VMAP | LINEOFSIGHT_CHECK_GOBJECT)
};

class GridMap
{
    uint32  _flags;
    union
    {
        float* m_V9;
        uint16* m_uint16_V9;
        uint8* m_uint8_V9;
    };
    union
    {
        float* m_V8;
        uint16* m_uint16_V8;
        uint8* m_uint8_V8;
    };
    int16* _maxHeight;
    int16* _minHeight;
    // Height level data
    float _gridHeight;
    float _gridIntHeightMultiplier;

    // Area data
    uint16* _areaMap;

    // Liquid data
    float _liquidLevel;
    uint16* _liquidEntry;
    uint8* _liquidFlags;
    float* _liquidMap;
    uint16 _gridArea;
    uint16 _liquidType;
    uint8 _liquidOffX;
    uint8 _liquidOffY;
    uint8 _liquidWidth;
    uint8 _liquidHeight;
    uint16* _holes;

    auto loadAreaData(FILE* in, uint32 offset, uint32 size) -> bool;
    auto loadHeightData(FILE* in, uint32 offset, uint32 size) -> bool;
    auto loadLiquidData(FILE* in, uint32 offset, uint32 size) -> bool;
    auto loadHolesData(FILE* in, uint32 offset, uint32 size) -> bool;
    [[nodiscard]] auto isHole(int row, int col) const -> bool;

    // Get height functions and pointers
    typedef float (GridMap::*GetHeightPtr) (float x, float y) const;
    GetHeightPtr _gridGetHeight;
    [[nodiscard]] auto getHeightFromFloat(float x, float y) const -> float;
    [[nodiscard]] auto getHeightFromUint16(float x, float y) const -> float;
    [[nodiscard]] auto getHeightFromUint8(float x, float y) const -> float;
    [[nodiscard]] auto getHeightFromFlat(float x, float y) const -> float;

public:
    GridMap();
    ~GridMap();
    auto loadData(char* filaname) -> bool;
    void unloadData();

    [[nodiscard]] auto getArea(float x, float y) const -> uint16;
    [[nodiscard]] inline auto getHeight(float x, float y) const -> float {return (this->*_gridGetHeight)(x, y);}
    [[nodiscard]] auto getMinHeight(float x, float y) const -> float;
    [[nodiscard]] auto getLiquidLevel(float x, float y) const -> float;
    [[nodiscard]] auto GetLiquidData(float x, float y, float z, float collisionHeight, uint8 ReqLiquidType) const -> LiquidData const;
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
    ZoneDynamicInfo()  = default;

    uint32 MusicId{0};
    uint32 WeatherId{0};
    float WeatherGrade{0.0f};
    uint32 OverrideLightId{0};
    uint32 LightFadeInTime{0};
};

#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

typedef std::map<uint32/*leaderDBGUID*/, CreatureGroup*>        CreatureGroupHolderType;
typedef std::unordered_map<uint32 /*zoneId*/, ZoneDynamicInfo> ZoneDynamicInfoMap;
typedef std::set<MotionTransport*> TransportsContainer;

enum EncounterCreditType
{
    ENCOUNTER_CREDIT_KILL_CREATURE  = 0,
    ENCOUNTER_CREDIT_CAST_SPELL     = 1,
};

class Map : public GridRefMgr<NGridType>
{
    friend class MapReference;
public:
    Map(uint32 id, uint32 InstanceId, uint8 SpawnMode, Map* _parent = nullptr);
    ~Map() override;

    [[nodiscard]] auto GetEntry() const -> MapEntry const* { return i_mapEntry; }

    // currently unused for normal maps
    auto CanUnload(uint32 diff) -> bool
    {
        if (!m_unloadTimer)
            return false;

        if (m_unloadTimer <= diff)
            return true;

        m_unloadTimer -= diff;
        return false;
    }

    virtual auto AddPlayerToMap(Player*) -> bool;
    virtual void RemovePlayerFromMap(Player*, bool);
    virtual void AfterPlayerUnlinkFromMap();
    template<class T> auto AddToMap(T*, bool checkTransport = false) -> bool;
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

    [[nodiscard]] auto GetVisibilityRange() const -> float { return m_VisibleDistance; }
    void SetVisibilityRange(float range) { m_VisibleDistance = range; }
    //function for setting up visibility distance for maps on per-type/per-Id basis
    virtual void InitVisibilityDistance();

    void PlayerRelocation(Player*, float x, float y, float z, float o);
    void CreatureRelocation(Creature* creature, float x, float y, float z, float o);
    void GameObjectRelocation(GameObject* go, float x, float y, float z, float o);
    void DynamicObjectRelocation(DynamicObject* go, float x, float y, float z, float o);

    template<class T, class CONTAINER> void Visit(const Cell& cell, TypeContainerVisitor<T, CONTAINER>& visitor);

    [[nodiscard]] auto IsRemovalGrid(float x, float y) const -> bool
    {
        GridCoord p = Acore::ComputeGridCoord(x, y);
        return !getNGrid(p.x_coord, p.y_coord);
    }

    [[nodiscard]] auto IsGridLoaded(float x, float y) const -> bool
    {
        return IsGridLoaded(Acore::ComputeGridCoord(x, y));
    }

    void LoadGrid(float x, float y);
    void LoadAllCells();
    auto UnloadGrid(NGridType& ngrid) -> bool;
    virtual void UnloadAll();

    [[nodiscard]] auto GetId() const -> uint32 { return i_mapEntry->MapID; }

    static auto ExistMap(uint32 mapid, int gx, int gy) -> bool;
    static auto ExistVMap(uint32 mapid, int gx, int gy) -> bool;

    [[nodiscard]] auto GetParent() const -> Map const* { return m_parentMap; }

    // pussywizard: movemaps, mmaps
    [[nodiscard]] auto GetMMapLock() const -> std::shared_mutex& { return *(const_cast<std::shared_mutex*>(&MMapLock)); }
    // pussywizard:
    std::unordered_set<Unit*> i_objectsForDelayedVisibility;
    void HandleDelayedVisibility();

    // some calls like isInWater should not use vmaps due to processor power
    // can return INVALID_HEIGHT if under z+2 z coord not found height
    [[nodiscard]] auto GetHeight(float x, float y, float z, bool checkVMap = true, float maxSearchDist = DEFAULT_HEIGHT_SEARCH) const -> float;
    [[nodiscard]] auto GetGridHeight(float x, float y) const -> float;
    [[nodiscard]] auto GetMinHeight(float x, float y) const -> float;
    auto GetTransportForPos(uint32 phase, float x, float y, float z, WorldObject* worldobject = nullptr) -> Transport*;

    void GetFullTerrainStatusForPosition(uint32 phaseMask, float x, float y, float z, float collisionHeight, PositionFullTerrainStatus& data, uint8 reqLiquidType = MAP_ALL_LIQUIDS);
    auto GetLiquidData(uint32 phaseMask, float x, float y, float z, float collisionHeight, uint8 ReqLiquidType) -> LiquidData const;

    [[nodiscard]] auto GetAreaInfo(uint32 phaseMask, float x, float y, float z, uint32& mogpflags, int32& adtId, int32& rootId, int32& groupId) const -> bool;
    [[nodiscard]] auto GetAreaId(uint32 phaseMask, float x, float y, float z) const -> uint32;
    [[nodiscard]] auto GetZoneId(uint32 phaseMask, float x, float y, float z) const -> uint32;
    void GetZoneAndAreaId(uint32 phaseMask, uint32& zoneid, uint32& areaid, float x, float y, float z) const;

    [[nodiscard]] auto GetWaterLevel(float x, float y) const -> float;
    [[nodiscard]] auto IsInWater(uint32 phaseMask, float x, float y, float z, float collisionHeight) const -> bool;
    [[nodiscard]] auto IsUnderWater(uint32 phaseMask, float x, float y, float z, float collisionHeight) const -> bool;
    [[nodiscard]] auto HasEnoughWater(WorldObject const* searcher, float x, float y, float z) const -> bool;
    [[nodiscard]] auto HasEnoughWater(WorldObject const* searcher, LiquidData const& liquidData) const -> bool;

    void MoveAllCreaturesInMoveList();
    void MoveAllGameObjectsInMoveList();
    void MoveAllDynamicObjectsInMoveList();
    void RemoveAllObjectsInRemoveList();
    virtual void RemoveAllPlayers();

    [[nodiscard]] auto GetInstanceId() const -> uint32 { return i_InstanceId; }
    [[nodiscard]] auto GetSpawnMode() const -> uint8 { return (i_spawnMode); }

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

    virtual auto CannotEnter(Player* /*player*/, bool /*loginCheck = false*/) -> EnterState { return CAN_ENTER; }

    [[nodiscard]] auto GetMapName() const -> const char*;

    // have meaning only for instanced map (that have set real difficulty)
    [[nodiscard]] auto GetDifficulty() const -> Difficulty { return Difficulty(GetSpawnMode()); }
    [[nodiscard]] auto IsRegularDifficulty() const -> bool { return GetDifficulty() == REGULAR_DIFFICULTY; }
    [[nodiscard]] auto GetMapDifficulty() const -> MapDifficulty const*;

    [[nodiscard]] auto Instanceable() const -> bool { return i_mapEntry && i_mapEntry->Instanceable(); }
    [[nodiscard]] auto IsDungeon() const -> bool { return i_mapEntry && i_mapEntry->IsDungeon(); }
    [[nodiscard]] auto IsNonRaidDungeon() const -> bool { return i_mapEntry && i_mapEntry->IsNonRaidDungeon(); }
    [[nodiscard]] auto IsRaid() const -> bool { return i_mapEntry && i_mapEntry->IsRaid(); }
    [[nodiscard]] auto IsRaidOrHeroicDungeon() const -> bool { return IsRaid() || i_spawnMode > DUNGEON_DIFFICULTY_NORMAL; }
    [[nodiscard]] auto IsHeroic() const -> bool { return IsRaid() ? i_spawnMode >= RAID_DIFFICULTY_10MAN_HEROIC : i_spawnMode >= DUNGEON_DIFFICULTY_HEROIC; }
    [[nodiscard]] auto Is25ManRaid() const -> bool { return IsRaid() && i_spawnMode & RAID_DIFFICULTY_MASK_25MAN; }   // since 25man difficulties are 1 and 3, we can check them like that
    [[nodiscard]] auto IsBattleground() const -> bool { return i_mapEntry && i_mapEntry->IsBattleground(); }
    [[nodiscard]] auto IsBattleArena() const -> bool { return i_mapEntry && i_mapEntry->IsBattleArena(); }
    [[nodiscard]] auto IsBattlegroundOrArena() const -> bool { return i_mapEntry && i_mapEntry->IsBattlegroundOrArena(); }

    auto GetEntrancePos(int32& mapid, float& x, float& y) -> bool
    {
        if (!i_mapEntry)
            return false;
        return i_mapEntry->GetEntrancePos(mapid, x, y);
    }

    void AddObjectToRemoveList(WorldObject* obj);
    void AddObjectToSwitchList(WorldObject* obj, bool on);
    virtual void DelayedUpdate(const uint32 diff);

    void resetMarkedCells() { marked_cells.reset(); }
    auto isCellMarked(uint32 pCellId) -> bool { return marked_cells.test(pCellId); }
    void markCell(uint32 pCellId) { marked_cells.set(pCellId); }
    void resetMarkedCellsLarge() { marked_cells_large.reset(); }
    auto isCellMarkedLarge(uint32 pCellId) -> bool { return marked_cells_large.test(pCellId); }
    void markCellLarge(uint32 pCellId) { marked_cells_large.set(pCellId); }

    [[nodiscard]] auto HavePlayers() const -> bool { return !m_mapRefMgr.isEmpty(); }
    [[nodiscard]] auto GetPlayersCountExceptGMs() const -> uint32;

    void AddWorldObject(WorldObject* obj) { i_worldObjects.insert(obj); }
    void RemoveWorldObject(WorldObject* obj) { i_worldObjects.erase(obj); }

    void SendToPlayers(WorldPacket const* data) const;

    typedef MapRefMgr PlayerList;
    [[nodiscard]] auto GetPlayers() const -> PlayerList const& { return m_mapRefMgr; }

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

    auto SummonCreature(uint32 entry, Position const& pos, SummonPropertiesEntry const* properties = nullptr, uint32 duration = 0, Unit* summoner = nullptr, uint32 spellId = 0, uint32 vehId = 0) -> TempSummon*;
    auto SummonGameObject(uint32 entry, float x, float y, float z, float ang, float rotation0, float rotation1, float rotation2, float rotation3, uint32 respawnTime, bool checkTransport = true) -> GameObject*;
    void SummonCreatureGroup(uint8 group, std::list<TempSummon*>* list = nullptr);

    auto GetCorpse(ObjectGuid const guid) -> Corpse*;
    auto GetCreature(ObjectGuid const guid) -> Creature*;
    auto GetGameObject(ObjectGuid const guid) -> GameObject*;
    auto GetTransport(ObjectGuid const guid) -> Transport*;
    auto GetDynamicObject(ObjectGuid const guid) -> DynamicObject*;
    auto GetPet(ObjectGuid const guid) -> Pet*;

    auto GetObjectsStore() -> MapStoredObjectTypesContainer& { return _objectsStore; }

    typedef std::unordered_multimap<ObjectGuid::LowType, Creature*> CreatureBySpawnIdContainer;
    auto GetCreatureBySpawnIdStore() -> CreatureBySpawnIdContainer& { return _creatureBySpawnIdStore; }

    typedef std::unordered_multimap<ObjectGuid::LowType, GameObject*> GameObjectBySpawnIdContainer;
    auto GetGameObjectBySpawnIdStore() -> GameObjectBySpawnIdContainer& { return _gameobjectBySpawnIdStore; }

    [[nodiscard]] auto GetCorpsesInCell(uint32 cellId) const -> std::unordered_set<Corpse*> const*
    {
        auto itr = _corpsesByCell.find(cellId);
        if (itr != _corpsesByCell.end())
            return &itr->second;

        return nullptr;
    }

    [[nodiscard]] auto GetCorpseByPlayer(ObjectGuid const& ownerGuid) const -> Corpse*
    {
        auto itr = _corpsesByPlayer.find(ownerGuid);
        if (itr != _corpsesByPlayer.end())
            return itr->second;

        return nullptr;
    }

    auto ToMapInstanced() -> MapInstanced* { if (Instanceable())  return reinterpret_cast<MapInstanced*>(this); else return nullptr;  }
    [[nodiscard]] auto ToMapInstanced() const -> const MapInstanced* { if (Instanceable())  return (const MapInstanced*)((MapInstanced*)this); else return nullptr;  }

    auto ToInstanceMap() -> InstanceMap* { if (IsDungeon())  return reinterpret_cast<InstanceMap*>(this); else return nullptr;  }
    [[nodiscard]] auto ToInstanceMap() const -> const InstanceMap* { if (IsDungeon())  return (const InstanceMap*)((InstanceMap*)this); else return nullptr;  }

    auto ToBattlegroundMap() -> BattlegroundMap* { if (IsBattlegroundOrArena()) return reinterpret_cast<BattlegroundMap*>(this); else return nullptr;  }
    [[nodiscard]] auto ToBattlegroundMap() const -> const BattlegroundMap* { if (IsBattlegroundOrArena()) return reinterpret_cast<BattlegroundMap const*>(this); return nullptr; }

    auto GetWaterOrGroundLevel(uint32 phasemask, float x, float y, float z, float* ground = nullptr, bool swim = false, float collisionHeight = DEFAULT_COLLISION_HEIGHT) const -> float;
    [[nodiscard]] auto GetHeight(uint32 phasemask, float x, float y, float z, bool vmap = true, float maxSearchDist = DEFAULT_HEIGHT_SEARCH) const -> float;
    [[nodiscard]] auto isInLineOfSight(float x1, float y1, float z1, float x2, float y2, float z2, uint32 phasemask, LineOfSightChecks checks) const -> bool;
    auto CanReachPositionAndGetValidCoords(const WorldObject* source, PathGenerator *path, float &destX, float &destY, float &destZ, bool failOnCollision = true, bool failOnSlopes = true) const -> bool;
    auto CanReachPositionAndGetValidCoords(const WorldObject* source, float &destX, float &destY, float &destZ, bool failOnCollision = true, bool failOnSlopes = true) const -> bool;
    auto CanReachPositionAndGetValidCoords(const WorldObject* source, float startX, float startY, float startZ, float &destX, float &destY, float &destZ, bool failOnCollision = true, bool failOnSlopes = true) const -> bool;
    auto CheckCollisionAndGetValidCoords(const WorldObject* source, float startX, float startY, float startZ, float &destX, float &destY, float &destZ, bool failOnCollision = true) const -> bool;
    void Balance() { _dynamicTree.balance(); }
    void RemoveGameObjectModel(const GameObjectModel& model) { _dynamicTree.remove(model); }
    void InsertGameObjectModel(const GameObjectModel& model) { _dynamicTree.insert(model); }
    [[nodiscard]] auto ContainsGameObjectModel(const GameObjectModel& model) const -> bool { return _dynamicTree.contains(model);}
    [[nodiscard]] auto GetDynamicMapTree() const -> DynamicMapTree const& { return _dynamicTree; }
    auto GetObjectHitPos(uint32 phasemask, float x1, float y1, float z1, float x2, float y2, float z2, float& rx, float& ry, float& rz, float modifyDist) -> bool;
    [[nodiscard]] auto GetGameObjectFloor(uint32 phasemask, float x, float y, float z, float maxSearchDist = DEFAULT_HEIGHT_SEARCH) const -> float
    {
        return _dynamicTree.getHeight(x, y, z, maxSearchDist, phasemask);
    }
    /*
        RESPAWN TIMES
    */
    [[nodiscard]] auto GetLinkedRespawnTime(ObjectGuid guid) const -> time_t;
    [[nodiscard]] auto GetCreatureRespawnTime(ObjectGuid::LowType dbGuid) const -> time_t
    {
        std::unordered_map<ObjectGuid::LowType /*dbGUID*/, time_t>::const_iterator itr = _creatureRespawnTimes.find(dbGuid);
        if (itr != _creatureRespawnTimes.end())
            return itr->second;

        return time_t(0);
    }

    [[nodiscard]] auto GetGORespawnTime(ObjectGuid::LowType dbGuid) const -> time_t
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
    [[nodiscard]] auto GetInstanceResetPeriod() const -> time_t { return _instanceResetPeriod; }

    void LoadCorpseData();
    void DeleteCorpseData();
    void AddCorpse(Corpse* corpse);
    void RemoveCorpse(Corpse* corpse);
    auto ConvertCorpseToBones(ObjectGuid const ownerGuid, bool insignia = false) -> Corpse*;
    void RemoveOldCorpses();

    static void DeleteRespawnTimesInDB(uint16 mapId, uint32 instanceId);

    void SendInitTransports(Player* player);
    void SendRemoveTransports(Player* player);
    void SendZoneDynamicInfo(Player* player);
    void SendInitSelf(Player* player);

    void PlayDirectSoundToMap(uint32 soundId, uint32 zoneId = 0);
    void SetZoneMusic(uint32 zoneId, uint32 musicId);
    void SetZoneWeather(uint32 zoneId, uint32 weatherId, float weatherGrade);
    void SetZoneOverrideLight(uint32 zoneId, uint32 lightId, Milliseconds fadeInTime);

    // Checks encounter state at kill/spellcast, originally in InstanceScript however not every map has instance script :(
    void UpdateEncounterState(EncounterCreditType type, uint32 creditEntry, Unit* source);
    void LogEncounterFinished(EncounterCreditType type, uint32 creditEntry);

    auto GetGrid(float x, float y) -> GridMap*;
    void EnsureGridCreated(const GridCoord&);
    [[nodiscard]] auto AllTransportsEmpty() const -> bool; // pussywizard
    void AllTransportsRemovePassengers(); // pussywizard
    [[nodiscard]] auto GetAllTransports() const -> TransportsContainer const& { return _transports; }

    DataMap CustomData;

    template<HighGuid high>
    inline auto GenerateLowGuid() -> ObjectGuid::LowType
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

private:
    void LoadMapAndVMap(int gx, int gy);
    void LoadVMap(int gx, int gy);
    void LoadMap(int gx, int gy, bool reload = false);

    // Load MMap Data
    void LoadMMap(int gx, int gy);

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

    [[nodiscard]] auto IsGridLoaded(const GridCoord&) const -> bool;
    void EnsureGridCreated_i(const GridCoord&);

    void buildNGridLinkage(NGridType* pNGridType) { pNGridType->link(this); }

    [[nodiscard]] auto getNGrid(uint32 x, uint32 y) const -> NGridType*
    {
        ASSERT(x < MAX_NUMBER_OF_GRIDS && y < MAX_NUMBER_OF_GRIDS);
        return i_grids[x][y];
    }

    auto EnsureGridLoaded(Cell const&) -> bool;
    [[nodiscard]] auto isGridObjectDataLoaded(uint32 x, uint32 y) const -> bool { return getNGrid(x, y)->isGridObjectDataLoaded(); }
    void setGridObjectDataLoaded(bool pLoaded, uint32 x, uint32 y) { getNGrid(x, y)->setGridObjectDataLoaded(pLoaded); }

    void setNGrid(NGridType* grid, uint32 x, uint32 y);
    void ScriptsProcess();

    void UpdateActiveCells(const float& x, const float& y, const uint32 t_diff);

    void SendObjectUpdates();

protected:
    std::mutex Lock;
    std::mutex GridLock;
    std::shared_mutex MMapLock;

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
    auto _GetScriptPlayerSourceOrTarget(Object* source, Object* target, const ScriptInfo* scriptInfo) const -> Player*;
    auto _GetScriptCreatureSourceOrTarget(Object* source, Object* target, const ScriptInfo* scriptInfo, bool bReverse = false) const -> Creature*;
    auto _GetScriptUnit(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const -> Unit*;
    auto _GetScriptPlayer(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const -> Player*;
    auto _GetScriptCreature(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const -> Creature*;
    auto _GetScriptWorldObject(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const -> WorldObject*;
    void _ScriptProcessDoor(Object* source, Object* target, const ScriptInfo* scriptInfo) const;
    auto _FindGameObject(WorldObject* pWorldObject, ObjectGuid::LowType guid) const -> GameObject*;

    //used for fast base_map (e.g. MapInstanced class object) search for
    //InstanceMaps and BattlegroundMaps...
    Map* m_parentMap;

    NGridType* i_grids[MAX_NUMBER_OF_GRIDS][MAX_NUMBER_OF_GRIDS];
    GridMap* GridMaps[MAX_NUMBER_OF_GRIDS][MAX_NUMBER_OF_GRIDS];
    std::bitset<TOTAL_NUMBER_OF_CELLS_PER_MAP* TOTAL_NUMBER_OF_CELLS_PER_MAP> marked_cells;
    std::bitset<TOTAL_NUMBER_OF_CELLS_PER_MAP* TOTAL_NUMBER_OF_CELLS_PER_MAP> marked_cells_large;

    bool i_scriptLock;
    std::unordered_set<WorldObject*> i_objectsToRemove;
    std::map<WorldObject*, bool> i_objectsToSwitch;
    std::unordered_set<WorldObject*> i_worldObjects;

    typedef std::multimap<time_t, ScriptAction> ScriptScheduleMap;
    ScriptScheduleMap m_scriptSchedule;

    // Type specific code for add/remove to/from grid
    template<class T>
    void AddToGrid(T* object, Cell const& cell);

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

    ZoneDynamicInfoMap _zoneDynamicInfo;
    uint32 _defaultLight;

    template<HighGuid high>
    inline auto GetGuidSequenceGenerator() -> ObjectGuidGeneratorBase&
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
    auto AddPlayerToMap(Player*) -> bool override;
    void RemovePlayerFromMap(Player*, bool) override;
    void AfterPlayerUnlinkFromMap() override;
    void Update(const uint32, const uint32, bool thread = true) override;
    void CreateInstanceScript(bool load, std::string data, uint32 completedEncounterMask);
    auto Reset(uint8 method, GuidList* globalSkipList = nullptr) -> bool;
    [[nodiscard]] auto GetScriptId() const -> uint32 { return i_script_id; }
    [[nodiscard]] auto GetScriptName() const -> std::string const&;
    [[nodiscard]] auto GetInstanceScript() -> InstanceScript* { return instance_data; }
    [[nodiscard]] auto GetInstanceScript() const -> InstanceScript const* { return instance_data; }
    void PermBindAllPlayers();
    void UnloadAll() override;
    auto CannotEnter(Player* player, bool loginCheck = false) -> EnterState override;
    void SendResetWarnings(uint32 timeLeft) const;

    [[nodiscard]] auto GetMaxPlayers() const -> uint32;
    [[nodiscard]] auto GetMaxResetDelay() const -> uint32;

    void InitVisibilityDistance() override;
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

    auto AddPlayerToMap(Player*) -> bool override;
    void RemovePlayerFromMap(Player*, bool) override;
    auto CannotEnter(Player* player, bool loginCheck = false) -> EnterState override;
    void SetUnload();
    //void UnloadAll(bool pForce);
    void RemoveAllPlayers() override;

    void InitVisibilityDistance() override;
    auto GetBG() -> Battleground* { return m_bg; }
    void SetBG(Battleground* bg) { m_bg = bg; }
private:
    Battleground* m_bg;
};

template<class T, class CONTAINER>
inline void Map::Visit(Cell const& cell, TypeContainerVisitor<T, CONTAINER>& visitor)
{
    const uint32 x = cell.GridX();
    const uint32 y = cell.GridY();
    const uint32 cell_x = cell.CellX();
    const uint32 cell_y = cell.CellY();

    if (!cell.NoCreate() || IsGridLoaded(GridCoord(x, y)))
    {
        EnsureGridLoaded(cell);
        getNGrid(x, y)->VisitGrid(cell_x, cell_y, visitor);
    }
}

#endif
