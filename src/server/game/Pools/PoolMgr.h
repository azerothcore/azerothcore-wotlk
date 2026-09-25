/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef ACORE_POOLHANDLER_H
#define ACORE_POOLHANDLER_H

#include "Creature.h"
#include "Define.h"
#include "GameObject.h"
#include "QuestDef.h"
#include <memory>
#include <type_traits>

class Map;

struct PoolTemplateData
{
    uint32      MaxLimit;
    int32       MapId;
    std::string Description;
};

struct PoolObject
{
    uint32  guid;
    float   chance;
    PoolObject(uint32 _guid, float _chance): guid(_guid), chance(std::fabs(_chance)) {}
};

class Pool                                                  // for Pool of Pool case
{
};

typedef std::unordered_set<uint32> SpawnedPoolObjects;
typedef std::map<uint32, uint32> SpawnedPoolPools;

class SpawnedPoolData
{
public:
    // owner is nullptr only for PoolMgr's global quest pool state
    explicit SpawnedPoolData(Map* owner) : mOwner(owner) { }

    SpawnedPoolData(SpawnedPoolData const&) = delete;
    SpawnedPoolData(SpawnedPoolData&&) = delete;
    SpawnedPoolData& operator=(SpawnedPoolData const&) = delete;
    SpawnedPoolData& operator=(SpawnedPoolData&&) = delete;

    Map* GetMap() const { return mOwner; }

    template<typename T>
    bool IsSpawnedObject(uint32 db_guid_or_pool_id) const;

    uint32 GetSpawnedObjects(uint32 pool_id) const;

    template<typename T>
    void AddSpawn(uint32 db_guid_or_pool_id, uint32 pool_id);

    template<typename T>
    void RemoveSpawn(uint32 db_guid_or_pool_id, uint32 pool_id);

    SpawnedPoolObjects GetSpawnedQuests() const { return mSpawnedQuests; } // a copy of the set
private:
    Map* mOwner;
    SpawnedPoolObjects mSpawnedCreatures;
    SpawnedPoolObjects mSpawnedGameobjects;
    SpawnedPoolObjects mSpawnedQuests;
    SpawnedPoolPools   mSpawnedPools;
};

template <class T>
class PoolGroup
{
    typedef std::vector<PoolObject> PoolObjectList;
public:
    explicit PoolGroup() : poolId(0) { }
    void SetPoolId(uint32 pool_id) { poolId = pool_id; }
    ~PoolGroup() {};
    bool IsEmpty() const { return ExplicitlyChanced.empty() && EqualChanced.empty(); }
    bool IsEmptyDeepCheck() const;
    void AddEntry(PoolObject& poolitem, uint32 maxentries);
    bool CheckPool() const;
    void DespawnObject(SpawnedPoolData& spawns, ObjectGuid::LowType guid = 0);
    void Despawn1Object(SpawnedPoolData& spawns, ObjectGuid::LowType guid);
    void SpawnObject(SpawnedPoolData& spawns, uint32 limit, uint32 triggerFrom);

    void Spawn1Object(SpawnedPoolData& spawns, PoolObject* obj);
    void ReSpawn1Object(SpawnedPoolData& spawns, PoolObject* obj);
    void RemoveOneRelation(uint32 child_pool_id);
    uint32 GetFirstEqualChancedObjectId()
    {
        if (EqualChanced.empty())
            return 0;
        return EqualChanced.front().guid;
    }
    uint32 GetPoolId() const { return poolId; }
    std::vector<PoolObject> const& GetExplicitlyChanced() const { return ExplicitlyChanced; }
    std::vector<PoolObject> const& GetEqualChanced() const { return EqualChanced; }
private:
    static bool IsSpawnableOnMap(uint32 db_guid_or_pool_id, Map* map);

    uint32 poolId;
    PoolObjectList ExplicitlyChanced;
    PoolObjectList EqualChanced;
};

typedef std::multimap<uint32, uint32> PooledQuestRelation;
typedef std::pair<PooledQuestRelation::const_iterator, PooledQuestRelation::const_iterator> PooledQuestRelationBounds;
typedef std::pair<PooledQuestRelation::iterator, PooledQuestRelation::iterator> PooledQuestRelationBoundsNC;

class PoolMgr
{
private:
    PoolMgr();
    ~PoolMgr() {};

public:
    static PoolMgr* instance();

    void LoadFromDB();
    void LoadQuestPools();
    void SaveQuestsToDB(bool daily, bool weekly, bool other);

    void Initialize();

    template<typename T>
    uint32 IsPartOfAPool(uint32 db_guid_or_pool_id) const;

    // Quest pool state is global: quests are realm-wide, not tied to a map.
    // Creature/GameObject/Pool spawn state lives on the owning Map's SpawnedPoolData.
    template<typename T>
    bool IsSpawnedObject(uint32 quest_id) const
    {
        static_assert(std::is_same_v<T, Quest>, "only quest pool state is global; query the owning Map's SpawnedPoolData instead");
        return mQuestSpawnedData.IsSpawnedObject<Quest>(quest_id);
    }

    bool IsEmpty(uint32 pool_id) const;
    bool CheckPool(uint32 pool_id) const;

    void SpawnPool(SpawnedPoolData& spawnedPoolData, uint32 pool_id);
    void DespawnPool(SpawnedPoolData& spawnedPoolData, uint32 pool_id);

    template<typename T>
    void UpdatePool(SpawnedPoolData& spawnedPoolData, uint32 pool_id, uint32 db_guid_or_pool_id);

    // Game-event pools are spawned on all live maps of the pool's map id and
    // remembered while active, so maps created mid-event (lazily created
    // continents, new instances) spawn them on creation too.
    void SpawnEventPool(uint32 pool_id);
    void DespawnEventPool(uint32 pool_id);

    std::unique_ptr<SpawnedPoolData> InitPoolsForMap(Map* map);

    void ChangeDailyQuests();
    void ChangeWeeklyQuests();
    void ReSpawnPoolQuests();

    PooledQuestRelation mQuestCreatureRelation;
    PooledQuestRelation mQuestGORelation;

    // Pool info accessors for debug commands
    PoolTemplateData const* GetPoolTemplate(uint32 poolId) const;
    PoolGroup<Creature> const* GetPoolCreatureGroup(uint32 poolId) const;
    PoolGroup<GameObject> const* GetPoolGameObjectGroup(uint32 poolId) const;
    PoolGroup<Pool> const* GetPoolPoolGroup(uint32 poolId) const;
    SpawnedPoolData const& GetQuestSpawnedData() const { return mQuestSpawnedData; }
    uint32 GetCreaturePoolId(uint32 guid) const;
    uint32 GetGameObjectPoolId(uint32 guid) const;

    friend class PoolQuestReloadFixTest;
private:
    template<typename T>
    void SpawnPool(SpawnedPoolData& spawnedPoolData, uint32 pool_id, uint32 db_guid_or_pool_id);

    typedef std::unordered_map<uint32, PoolTemplateData>      PoolTemplateDataMap;
    typedef std::unordered_map<uint32, PoolGroup<Creature>>   PoolGroupCreatureMap;
    typedef std::unordered_map<uint32, PoolGroup<GameObject>> PoolGroupGameObjectMap;
    typedef std::unordered_map<uint32, PoolGroup<Pool>>       PoolGroupPoolMap;
    typedef std::unordered_map<uint32, PoolGroup<Quest>>      PoolGroupQuestMap;
    typedef std::pair<uint32, uint32>           SearchPair;
    typedef std::map<uint32, uint32>            SearchMap;

    PoolTemplateDataMap    mPoolTemplate;
    PoolGroupCreatureMap   mPoolCreatureGroups;
    PoolGroupGameObjectMap mPoolGameobjectGroups;
    PoolGroupPoolMap       mPoolPoolGroups;
    PoolGroupQuestMap      mPoolQuestGroups;
    SearchMap mCreatureSearchMap;
    SearchMap mGameobjectSearchMap;
    SearchMap mPoolSearchMap;
    SearchMap mQuestSearchMap;

    std::unordered_map<uint32, std::vector<uint32>> mAutoSpawnPoolsPerMap;

    // World thread only: mutated on game event start/stop, read on map creation
    std::unordered_set<uint32> mActiveEventPools;

    // active state of quest pools; per-map state lives on each Map's SpawnedPoolData
    SpawnedPoolData mQuestSpawnedData;
};

#define sPoolMgr PoolMgr::instance()

template<> void PoolMgr::SpawnPool<Pool>(SpawnedPoolData& spawnedPoolData, uint32 pool_id, uint32 sub_pool_id);
template<> void PoolMgr::SpawnPool<Creature>(SpawnedPoolData& spawnedPoolData, uint32 pool_id, uint32 db_guid);
template<> void PoolMgr::SpawnPool<GameObject>(SpawnedPoolData& spawnedPoolData, uint32 pool_id, uint32 db_guid);
template<> void PoolMgr::SpawnPool<Quest>(SpawnedPoolData& spawnedPoolData, uint32 pool_id, uint32 quest_id);

// Method that tell if the creature is part of a pool and return the pool id if yes
template<>
inline uint32 PoolMgr::IsPartOfAPool<Creature>(uint32 db_guid) const
{
    SearchMap::const_iterator itr = mCreatureSearchMap.find(db_guid);
    if (itr != mCreatureSearchMap.end())
        return itr->second;

    return 0;
}

// Method that tell if the gameobject is part of a pool and return the pool id if yes
template<>
inline uint32 PoolMgr::IsPartOfAPool<GameObject>(uint32 db_guid) const
{
    SearchMap::const_iterator itr = mGameobjectSearchMap.find(db_guid);
    if (itr != mGameobjectSearchMap.end())
        return itr->second;

    return 0;
}

// Method that tell if the quest is part of another pool and return the pool id if yes
template<>
inline uint32 PoolMgr::IsPartOfAPool<Quest>(uint32 questId) const
{
    SearchMap::const_iterator itr = mQuestSearchMap.find(questId);
    if (itr != mQuestSearchMap.end())
        return itr->second;

    return 0;
}

// Method that tell if the pool is part of another pool and return the pool id if yes
template<>
inline uint32 PoolMgr::IsPartOfAPool<Pool>(uint32 pool_id) const
{
    SearchMap::const_iterator itr = mPoolSearchMap.find(pool_id);
    if (itr != mPoolSearchMap.end())
        return itr->second;

    return 0;
}

#endif
