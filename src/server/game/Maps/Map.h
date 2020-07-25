/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_MAP_H
#define ACORE_MAP_H

// Pathfinding
#include "DetourAlloc.h"
#include "DetourNavMesh.h"
#include "DetourNavMeshQuery.h"

#include "Define.h"
#include <ace/RW_Thread_Mutex.h>
#include <ace/Thread_Mutex.h>

#include "DBCStructure.h"
#include "GridDefines.h"
#include "Cell.h"
#include "Timer.h"
#include "SharedDefines.h"
#include "GridRefManager.h"
#include "MapRefManager.h"
#include "DynamicTree.h"
#include "GameObjectModel.h"
#include "Log.h"
#include "DataMap.h"
#include <bitset>
#include <list>

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
namespace acore
{
    struct ObjectUpdater;
    struct LargeObjectUpdater;
}

struct ScriptAction
{
    uint64 sourceGUID;
    uint64 targetGUID;
    uint64 ownerGUID;                                       // owner of source if source is item
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

enum ZLiquidStatus
{
    LIQUID_MAP_NO_WATER     = 0x00000000,
    LIQUID_MAP_ABOVE_WATER  = 0x00000001,
    LIQUID_MAP_WATER_WALK   = 0x00000002,
    LIQUID_MAP_IN_WATER     = 0x00000004,
    LIQUID_MAP_UNDER_WATER  = 0x00000008
};

#define MAP_LIQUID_TYPE_NO_WATER    0x00
#define MAP_LIQUID_TYPE_WATER       0x01
#define MAP_LIQUID_TYPE_OCEAN       0x02
#define MAP_LIQUID_TYPE_MAGMA       0x04
#define MAP_LIQUID_TYPE_SLIME       0x08

#define MAP_ALL_LIQUIDS   (MAP_LIQUID_TYPE_WATER | MAP_LIQUID_TYPE_OCEAN | MAP_LIQUID_TYPE_MAGMA | MAP_LIQUID_TYPE_SLIME)

#define MAP_LIQUID_TYPE_DARK_WATER  0x10
#define MAP_LIQUID_TYPE_WMO_WATER   0x20

struct LiquidData
{
    uint32 type_flags;
    uint32 entry;
    float  level;
    float  depth_level;
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
    union{
        float* m_V9;
        uint16* m_uint16_V9;
        uint8* m_uint8_V9;
    };
    union{
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


    bool loadAreaData(FILE* in, uint32 offset, uint32 size);
    bool loadHeightData(FILE* in, uint32 offset, uint32 size);
    bool loadLiquidData(FILE* in, uint32 offset, uint32 size);

    // Get height functions and pointers
    typedef float (GridMap::*GetHeightPtr) (float x, float y) const;
    GetHeightPtr _gridGetHeight;
    float getHeightFromFloat(float x, float y) const;
    float getHeightFromUint16(float x, float y) const;
    float getHeightFromUint8(float x, float y) const;
    float getHeightFromFlat(float x, float y) const;

public:
    GridMap();
    ~GridMap();
    bool loadData(char* filaname);
    void unloadData();

    uint16 getArea(float x, float y) const;
    inline float getHeight(float x, float y) const {return (this->*_gridGetHeight)(x, y);}
    float getMinHeight(float x, float y) const;
    float getLiquidLevel(float x, float y) const;
    uint8 getTerrainType(float x, float y) const;
    ZLiquidStatus getLiquidStatus(float x, float y, float z, uint8 ReqLiquidType, LiquidData* data = 0);
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
    ZoneDynamicInfo() : MusicId(0), WeatherId(0), WeatherGrade(0.0f),
        OverrideLightId(0), LightFadeInTime(0) { }

    uint32 MusicId;
    uint32 WeatherId;
    float WeatherGrade;
    uint32 OverrideLightId;
    uint32 LightFadeInTime;
};

#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

#define MAX_HEIGHT            100000.0f                     // can be use for find ground height at surface
#define INVALID_HEIGHT       -100000.0f                     // for check, must be equal to VMAP_INVALID_HEIGHT, real value for unknown height is VMAP_INVALID_HEIGHT_VALUE
#define MAX_FALL_DISTANCE     250000.0f                     // "unlimited fall" to find VMap ground if it is available, just larger than MAX_HEIGHT - INVALID_HEIGHT
#define DEFAULT_HEIGHT_SEARCH     70.0f                     // default search distance to find height at nearby locations
#define MIN_UNLOAD_DELAY      1                             // immediate unload

typedef std::map<uint32/*leaderDBGUID*/, CreatureGroup*>        CreatureGroupHolderType;
typedef std::unordered_map<uint32 /*zoneId*/, ZoneDynamicInfo> ZoneDynamicInfoMap;
typedef std::set<MotionTransport*> TransportsContainer;

enum EncounterCreditType
{
    ENCOUNTER_CREDIT_KILL_CREATURE  = 0,
    ENCOUNTER_CREDIT_CAST_SPELL     = 1,
};

class Map : public GridRefManager<NGridType>
{
    friend class MapReference;
    public:
        Map(uint32 id, uint32 InstanceId, uint8 SpawnMode, Map* _parent = NULL);
        virtual ~Map();

        MapEntry const* GetEntry() const { return i_mapEntry; }

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
        template<class T> bool AddToMap(T *, bool checkTransport = false);
        template<class T> void RemoveFromMap(T *, bool);

        void VisitNearbyCellsOf(WorldObject* obj, TypeContainerVisitor<acore::ObjectUpdater, GridTypeMapContainer> &gridVisitor,
            TypeContainerVisitor<acore::ObjectUpdater, WorldTypeMapContainer> &worldVisitor,
            TypeContainerVisitor<acore::ObjectUpdater, GridTypeMapContainer> &largeGridVisitor,
            TypeContainerVisitor<acore::ObjectUpdater, WorldTypeMapContainer> &largeWorldVisitor);
        void VisitNearbyCellsOfPlayer(Player* player, TypeContainerVisitor<acore::ObjectUpdater, GridTypeMapContainer> &gridVisitor,
            TypeContainerVisitor<acore::ObjectUpdater, WorldTypeMapContainer> &worldVisitor,
            TypeContainerVisitor<acore::ObjectUpdater, GridTypeMapContainer> &largeGridVisitor,
            TypeContainerVisitor<acore::ObjectUpdater, WorldTypeMapContainer> &largeWorldVisitor);
            
        virtual void Update(const uint32, const uint32, bool thread = true);

        float GetVisibilityRange() const { return m_VisibleDistance; }
        void SetVisibilityRange(float range) { m_VisibleDistance = range; }
        //function for setting up visibility distance for maps on per-type/per-Id basis
        virtual void InitVisibilityDistance();

        void PlayerRelocation(Player*, float x, float y, float z, float o);
        void CreatureRelocation(Creature* creature, float x, float y, float z, float o);
        void GameObjectRelocation(GameObject* go, float x, float y, float z, float o);
        void DynamicObjectRelocation(DynamicObject* go, float x, float y, float z, float o);

        template<class T, class CONTAINER> void Visit(const Cell& cell, TypeContainerVisitor<T, CONTAINER> &visitor);

        bool IsRemovalGrid(float x, float y) const
        {
            GridCoord p = acore::ComputeGridCoord(x, y);
            return !getNGrid(p.x_coord, p.y_coord);
        }

        bool IsGridLoaded(float x, float y) const
        {
            return IsGridLoaded(acore::ComputeGridCoord(x, y));
        }

        void LoadGrid(float x, float y);
        void LoadAllCells();
        bool UnloadGrid(NGridType& ngrid);
        virtual void UnloadAll();

        uint32 GetId(void) const { return i_mapEntry->MapID; }

        static bool ExistMap(uint32 mapid, int gx, int gy);
        static bool ExistVMap(uint32 mapid, int gx, int gy);

        Map const* GetParent() const { return m_parentMap; }

        // pussywizard: movemaps, mmaps
        ACE_RW_Thread_Mutex& GetMMapLock() const { return *(const_cast<ACE_RW_Thread_Mutex*>(&MMapLock)); }
        // pussywizard:
        std::unordered_set<Object*> i_objectsToUpdate;
        void BuildAndSendUpdateForObjects(); // definition in ObjectAccessor.cpp, below ObjectAccessor::Update, because it does the same for a map
        std::unordered_set<Unit*> i_objectsForDelayedVisibility;
        void HandleDelayedVisibility();

        // some calls like isInWater should not use vmaps due to processor power
        // can return INVALID_HEIGHT if under z+2 z coord not found height
        float GetHeight(float x, float y, float z, bool checkVMap = true, float maxSearchDist = DEFAULT_HEIGHT_SEARCH) const;
        float GetMinHeight(float x, float y) const;
        Transport* GetTransportForPos(uint32 phase, float x, float y, float z, WorldObject* worldobject = NULL);

        ZLiquidStatus getLiquidStatus(float x, float y, float z, uint8 ReqLiquidType, LiquidData* data = 0) const;

        uint32 GetAreaId(float x, float y, float z, bool *isOutdoors) const;
        bool GetAreaInfo(float x, float y, float z, uint32& mogpflags, int32& adtId, int32& rootId, int32& groupId) const;
        uint32 GetAreaId(float x, float y, float z) const;
        uint32 GetZoneId(float x, float y, float z) const;
        void GetZoneAndAreaId(uint32& zoneid, uint32& areaid, float x, float y, float z) const;

        bool IsOutdoors(float x, float y, float z) const;

        uint8 GetTerrainType(float x, float y) const;
        float GetWaterLevel(float x, float y) const;
        bool IsInWater(float x, float y, float z, LiquidData* data = 0) const;
        bool IsUnderWater(float x, float y, float z) const;

        void MoveAllCreaturesInMoveList();
        void MoveAllGameObjectsInMoveList();
        void MoveAllDynamicObjectsInMoveList();
        void RemoveAllObjectsInRemoveList();
        virtual void RemoveAllPlayers();

        uint32 GetInstanceId() const { return i_InstanceId; }
        uint8 GetSpawnMode() const { return (i_spawnMode); }
        virtual bool CanEnter(Player* /*player*/, bool /*loginCheck = false*/) { return true; }
        const char* GetMapName() const;

        // have meaning only for instanced map (that have set real difficulty)
        Difficulty GetDifficulty() const { return Difficulty(GetSpawnMode()); }
        bool IsRegularDifficulty() const { return GetDifficulty() == REGULAR_DIFFICULTY; }
        MapDifficulty const* GetMapDifficulty() const;

        bool Instanceable() const { return i_mapEntry && i_mapEntry->Instanceable(); }
        bool IsDungeon() const { return i_mapEntry && i_mapEntry->IsDungeon(); }
        bool IsNonRaidDungeon() const { return i_mapEntry && i_mapEntry->IsNonRaidDungeon(); }
        bool IsRaid() const { return i_mapEntry && i_mapEntry->IsRaid(); }
        bool IsRaidOrHeroicDungeon() const { return IsRaid() || i_spawnMode > DUNGEON_DIFFICULTY_NORMAL; }
        bool IsHeroic() const { return IsRaid() ? i_spawnMode >= RAID_DIFFICULTY_10MAN_HEROIC : i_spawnMode >= DUNGEON_DIFFICULTY_HEROIC; }
        bool Is25ManRaid() const { return IsRaid() && i_spawnMode & RAID_DIFFICULTY_MASK_25MAN; }   // since 25man difficulties are 1 and 3, we can check them like that
        bool IsBattleground() const { return i_mapEntry && i_mapEntry->IsBattleground(); }
        bool IsBattleArena() const { return i_mapEntry && i_mapEntry->IsBattleArena(); }
        bool IsBattlegroundOrArena() const { return i_mapEntry && i_mapEntry->IsBattlegroundOrArena(); }
        bool GetEntrancePos(int32 &mapid, float &x, float &y)
        {
            if (!i_mapEntry)
                return false;
            return i_mapEntry->GetEntrancePos(mapid, x, y);
        }

        void AddObjectToRemoveList(WorldObject* obj);
        void AddObjectToSwitchList(WorldObject* obj, bool on);
        virtual void DelayedUpdate(const uint32 diff);

        //void UpdateObjectVisibility(WorldObject* obj, Cell cell, CellCoord cellpair);
        //void UpdateObjectsVisibilityFor(Player* player, Cell cell, CellCoord cellpair);

        void resetMarkedCells() { marked_cells.reset(); }
        bool isCellMarked(uint32 pCellId) { return marked_cells.test(pCellId); }
        void markCell(uint32 pCellId) { marked_cells.set(pCellId); }
        void resetMarkedCellsLarge() { marked_cells_large.reset(); }
        bool isCellMarkedLarge(uint32 pCellId) { return marked_cells_large.test(pCellId); }
        void markCellLarge(uint32 pCellId) { marked_cells_large.set(pCellId); }

        bool HavePlayers() const { return !m_mapRefManager.isEmpty(); }
        uint32 GetPlayersCountExceptGMs() const;

        void AddWorldObject(WorldObject* obj) { i_worldObjects.insert(obj); }
        void RemoveWorldObject(WorldObject* obj) { i_worldObjects.erase(obj); }

        void SendToPlayers(WorldPacket const* data) const;

        typedef MapRefManager PlayerList;
        PlayerList const& GetPlayers() const { return m_mapRefManager; }

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
        template<class NOTIFIER> void VisitAll(const float &x, const float &y, float radius, NOTIFIER &notifier);
        template<class NOTIFIER> void VisitFirstFound(const float &x, const float &y, float radius, NOTIFIER &notifier);
        template<class NOTIFIER> void VisitWorld(const float &x, const float &y, float radius, NOTIFIER &notifier);
        template<class NOTIFIER> void VisitGrid(const float &x, const float &y, float radius, NOTIFIER &notifier);
        CreatureGroupHolderType CreatureGroupHolder;

        void UpdateIteratorBack(Player* player);

        TempSummon* SummonCreature(uint32 entry, Position const& pos, SummonPropertiesEntry const* properties = NULL, uint32 duration = 0, Unit* summoner = NULL, uint32 spellId = 0, uint32 vehId = 0);
        GameObject* SummonGameObject(uint32 entry, float x, float y, float z, float ang, float rotation0, float rotation1, float rotation2, float rotation3, uint32 respawnTime, bool checkTransport = true);
        void SummonCreatureGroup(uint8 group, std::list<TempSummon*>* list = NULL);
        Player* GetPlayer(uint64 guid);
        Creature* GetCreature(uint64 guid);
        GameObject* GetGameObject(uint64 guid);
        Transport* GetTransport(uint64 guid);
        DynamicObject* GetDynamicObject(uint64 guid);
        Pet* GetPet(uint64 guid);
        Corpse* GetCorpse(uint64 guid);

        MapInstanced* ToMapInstanced(){ if (Instanceable())  return reinterpret_cast<MapInstanced*>(this); else return NULL;  }
        const MapInstanced* ToMapInstanced() const { if (Instanceable())  return (const MapInstanced*)((MapInstanced*)this); else return NULL;  }

        InstanceMap* ToInstanceMap(){ if (IsDungeon())  return reinterpret_cast<InstanceMap*>(this); else return NULL;  }
        const InstanceMap* ToInstanceMap() const { if (IsDungeon())  return (const InstanceMap*)((InstanceMap*)this); else return NULL;  }

        BattlegroundMap* ToBattlegroundMap() { if (IsBattlegroundOrArena()) return reinterpret_cast<BattlegroundMap*>(this); else return NULL;  }
        const BattlegroundMap* ToBattlegroundMap() const { if (IsBattlegroundOrArena()) return reinterpret_cast<BattlegroundMap const*>(this); return NULL; }

        float GetWaterOrGroundLevel(uint32 phasemask,float x, float y, float z, float* ground = NULL, bool swim = false, float maxSearchDist = 50.0f) const;
        float GetHeight(uint32 phasemask, float x, float y, float z, bool vmap = true, float maxSearchDist = DEFAULT_HEIGHT_SEARCH) const;
        bool isInLineOfSight(float x1, float y1, float z1, float x2, float y2, float z2, uint32 phasemask, LineOfSightChecks checks) const;
        void Balance() { _dynamicTree.balance(); }
        void RemoveGameObjectModel(const GameObjectModel& model) { _dynamicTree.remove(model); }
        void InsertGameObjectModel(const GameObjectModel& model) { _dynamicTree.insert(model); }
        bool ContainsGameObjectModel(const GameObjectModel& model) const { return _dynamicTree.contains(model);}
        DynamicMapTree const& GetDynamicMapTree() const { return _dynamicTree; }
        bool getObjectHitPos(uint32 phasemask, float x1, float y1, float z1, float x2, float y2, float z2, float& rx, float &ry, float& rz, float modifyDist);

        /*
            RESPAWN TIMES
        */
        time_t GetLinkedRespawnTime(uint64 guid) const;
        time_t GetCreatureRespawnTime(uint32 dbGuid) const
        {
            std::unordered_map<uint32 /*dbGUID*/, time_t>::const_iterator itr = _creatureRespawnTimes.find(dbGuid);
            if (itr != _creatureRespawnTimes.end())
                return itr->second;

            return time_t(0);
        }

        time_t GetGORespawnTime(uint32 dbGuid) const
        {
            std::unordered_map<uint32 /*dbGUID*/, time_t>::const_iterator itr = _goRespawnTimes.find(dbGuid);
            if (itr != _goRespawnTimes.end())
                return itr->second;

            return time_t(0);
        }

        void SaveCreatureRespawnTime(uint32 dbGuid, time_t& respawnTime);
        void RemoveCreatureRespawnTime(uint32 dbGuid);
        void SaveGORespawnTime(uint32 dbGuid, time_t& respawnTime);
        void RemoveGORespawnTime(uint32 dbGuid);
        void LoadRespawnTimes();
        void DeleteRespawnTimes();
        time_t GetInstanceResetPeriod() const { return _instanceResetPeriod; }

        static void DeleteRespawnTimesInDB(uint16 mapId, uint32 instanceId);

        void SendInitTransports(Player* player);
        void SendRemoveTransports(Player* player);
        void SendZoneDynamicInfo(Player* player);
        void SendInitSelf(Player* player);

        void PlayDirectSoundToMap(uint32 soundId, uint32 zoneId = 0);
        void SetZoneMusic(uint32 zoneId, uint32 musicId);
        void SetZoneWeather(uint32 zoneId, uint32 weatherId, float weatherGrade);
        void SetZoneOverrideLight(uint32 zoneId, uint32 lightId, uint32 fadeInTime);
  
        // Checks encounter state at kill/spellcast, originally in InstanceScript however not every map has instance script :(
        void UpdateEncounterState(EncounterCreditType type, uint32 creditEntry, Unit* source);
        void LogEncounterFinished(EncounterCreditType type, uint32 creditEntry);

        GridMap* GetGrid(float x, float y);
        void EnsureGridCreated(const GridCoord &);
        bool AllTransportsEmpty() const; // pussywizard
        void AllTransportsRemovePassengers(); // pussywizard
        TransportsContainer const& GetAllTransports() const { return _transports; }

        DataMap CustomData;

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

        bool IsGridLoaded(const GridCoord &) const;
        void EnsureGridCreated_i(const GridCoord &);

        void buildNGridLinkage(NGridType* pNGridType) { pNGridType->link(this); }

        NGridType* getNGrid(uint32 x, uint32 y) const
        {
            ASSERT(x < MAX_NUMBER_OF_GRIDS && y < MAX_NUMBER_OF_GRIDS);
            return i_grids[x][y];
        }

        bool EnsureGridLoaded(Cell const&);
        bool isGridObjectDataLoaded(uint32 x, uint32 y) const { return getNGrid(x, y)->isGridObjectDataLoaded(); }
        void setGridObjectDataLoaded(bool pLoaded, uint32 x, uint32 y) { getNGrid(x, y)->setGridObjectDataLoaded(pLoaded); }

        void setNGrid(NGridType* grid, uint32 x, uint32 y);
        void ScriptsProcess();

        void UpdateActiveCells(const float &x, const float &y, const uint32 t_diff);

    protected:

        ACE_Thread_Mutex Lock;
        ACE_Thread_Mutex GridLock;
        ACE_RW_Thread_Mutex MMapLock;

        MapEntry const* i_mapEntry;
        uint8 i_spawnMode;
        uint32 i_InstanceId;
        uint32 m_unloadTimer;
        float m_VisibleDistance;
        DynamicMapTree _dynamicTree;
        time_t _instanceResetPeriod; // pussywizard

        MapRefManager m_mapRefManager;
        MapRefManager::iterator m_mapRefIter;

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
        GameObject* _FindGameObject(WorldObject* pWorldObject, uint32 guid) const;

        //used for fast base_map (e.g. MapInstanced class object) search for
        //InstanceMaps and BattlegroundMaps...
        Map* m_parentMap;

        NGridType* i_grids[MAX_NUMBER_OF_GRIDS][MAX_NUMBER_OF_GRIDS];
        GridMap* GridMaps[MAX_NUMBER_OF_GRIDS][MAX_NUMBER_OF_GRIDS];
        std::bitset<TOTAL_NUMBER_OF_CELLS_PER_MAP*TOTAL_NUMBER_OF_CELLS_PER_MAP> marked_cells;
        std::bitset<TOTAL_NUMBER_OF_CELLS_PER_MAP*TOTAL_NUMBER_OF_CELLS_PER_MAP> marked_cells_large;

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

        std::unordered_map<uint32 /*dbGUID*/, time_t> _creatureRespawnTimes;
        std::unordered_map<uint32 /*dbGUID*/, time_t> _goRespawnTimes;

        ZoneDynamicInfoMap _zoneDynamicInfo;
        uint32 _defaultLight;
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
        ~InstanceMap();
        bool AddPlayerToMap(Player*);
        void RemovePlayerFromMap(Player*, bool);
        void AfterPlayerUnlinkFromMap();
        void Update(const uint32, const uint32, bool thread = true);
        void CreateInstanceScript(bool load, std::string data, uint32 completedEncounterMask);
        bool Reset(uint8 method, std::list<uint32>* globalSkipList = NULL);
        uint32 GetScriptId() { return i_script_id; }
        InstanceScript* GetInstanceScript() { return instance_script; }
        void PermBindAllPlayers();
        void UnloadAll();
        bool CanEnter(Player* player, bool loginCheck = false);
        void SendResetWarnings(uint32 timeLeft) const;

        uint32 GetMaxPlayers() const;
        uint32 GetMaxResetDelay() const;

        virtual void InitVisibilityDistance();
    private:
        bool m_resetAfterUnload;
        bool m_unloadWhenEmpty;
        InstanceScript* instance_script;
        uint32 i_script_id;
};

class BattlegroundMap : public Map
{
    public:
        BattlegroundMap(uint32 id, uint32 InstanceId, Map* _parent, uint8 spawnMode);
        ~BattlegroundMap();

        bool AddPlayerToMap(Player*);
        void RemovePlayerFromMap(Player*, bool);
        bool CanEnter(Player* player, bool loginCheck = false);
        void SetUnload();
        //void UnloadAll(bool pForce);
        void RemoveAllPlayers();

        virtual void InitVisibilityDistance();
        Battleground* GetBG() { return m_bg; }
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

template<class NOTIFIER>
inline void Map::VisitAll(float const& x, float const& y, float radius, NOTIFIER& notifier)
{ 
    CellCoord p(acore::ComputeCellCoord(x, y));
    Cell cell(p);
    cell.SetNoCreate();

    TypeContainerVisitor<NOTIFIER, WorldTypeMapContainer> world_object_notifier(notifier);
    cell.Visit(p, world_object_notifier, *this, radius, x, y);
    TypeContainerVisitor<NOTIFIER, GridTypeMapContainer >  grid_object_notifier(notifier);
    cell.Visit(p, grid_object_notifier, *this, radius, x, y);
}

// should be used with Searcher notifiers, tries to search world if nothing found in grid
template<class NOTIFIER>
inline void Map::VisitFirstFound(const float &x, const float &y, float radius, NOTIFIER &notifier)
{ 
    CellCoord p(acore::ComputeCellCoord(x, y));
    Cell cell(p);
    cell.SetNoCreate();

    TypeContainerVisitor<NOTIFIER, WorldTypeMapContainer> world_object_notifier(notifier);
    cell.Visit(p, world_object_notifier, *this, radius, x, y);
    if (!notifier.i_object)
    {
        TypeContainerVisitor<NOTIFIER, GridTypeMapContainer >  grid_object_notifier(notifier);
        cell.Visit(p, grid_object_notifier, *this, radius, x, y);
    }
}

template<class NOTIFIER>
inline void Map::VisitWorld(const float &x, const float &y, float radius, NOTIFIER &notifier)
{ 
    CellCoord p(acore::ComputeCellCoord(x, y));
    Cell cell(p);
    cell.SetNoCreate();

    TypeContainerVisitor<NOTIFIER, WorldTypeMapContainer> world_object_notifier(notifier);
    cell.Visit(p, world_object_notifier, *this, radius, x, y);
}

template<class NOTIFIER>
inline void Map::VisitGrid(const float &x, const float &y, float radius, NOTIFIER &notifier)
{ 
    CellCoord p(acore::ComputeCellCoord(x, y));
    Cell cell(p);
    cell.SetNoCreate();

    TypeContainerVisitor<NOTIFIER, GridTypeMapContainer >  grid_object_notifier(notifier);
    cell.Visit(p, grid_object_notifier, *this, radius, x, y);
}
#endif
