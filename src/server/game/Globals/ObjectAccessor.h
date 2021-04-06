/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_OBJECTACCESSOR_H
#define ACORE_OBJECTACCESSOR_H

#include "Define.h"
#include "GridDefines.h"
#include "Object.h"
#include "UpdateData.h"
#include <ace/Thread_Mutex.h>
#include <set>
#include <unordered_map>

class Creature;
class Corpse;
class Unit;
class GameObject;
class DynamicObject;
class WorldObject;
class Vehicle;
class Map;
class WorldRunnable;
class Transport;
class StaticTransport;
class MotionTransport;

template <class T>
class HashMapHolder
{
public:
    static_assert(std::is_same<Player, T>::value || std::is_same<MotionTransport, T>::value,
        "Only Player and Motionransport can be registered in global HashMapHolder");

    typedef std::unordered_map<ObjectGuid, T*> MapType;
    typedef ACE_RW_Thread_Mutex LockType;

    static void Insert(T* o)
    {
        ACORE_WRITE_GUARD(LockType, i_lock);
        m_objectMap[o->GetGUID()] = o;
    }

    static void Remove(T* o)
    {
        ACORE_WRITE_GUARD(LockType, i_lock);
        m_objectMap.erase(o->GetGUID());
    }

    static T* Find(ObjectGuid guid)
    {
        ACORE_READ_GUARD(LockType, i_lock);
        typename MapType::iterator itr = m_objectMap.find(guid);
        return (itr != m_objectMap.end()) ? itr->second : nullptr;
    }

    static MapType& GetContainer() { return m_objectMap; }

    static LockType* GetLock() { return &i_lock; }

private:
    //Non instanceable only static
    HashMapHolder() = default;

    static LockType i_lock;
    static MapType  m_objectMap;
};

/// Define the static members of HashMapHolder

template <class T> std::unordered_map<ObjectGuid, T*> HashMapHolder<T>::m_objectMap;
template <class T> typename HashMapHolder<T>::LockType HashMapHolder<T>::i_lock;

class ObjectAccessor
{
private:
    ObjectAccessor();
    ~ObjectAccessor();
    ObjectAccessor(const ObjectAccessor&);
    ObjectAccessor& operator=(const ObjectAccessor&);

public:
    static ObjectAccessor* instance();
    // TODO: override these template functions for each holder type and add assertions

    // these functions return objects only if in map of specified object
    static WorldObject* GetWorldObject(WorldObject const&, ObjectGuid const guid);
    static Object* GetObjectByTypeMask(WorldObject const&, ObjectGuid const guid, uint32 typemask);
    static Corpse* GetCorpse(WorldObject const& u, ObjectGuid const guid);
    static GameObject* GetGameObject(WorldObject const& u, ObjectGuid const guid);
    static Transport* GetTransport(WorldObject const& u, ObjectGuid const guid);
    static DynamicObject* GetDynamicObject(WorldObject const& u, ObjectGuid const guid);
    static Unit* GetUnit(WorldObject const&, ObjectGuid const guid);
    static Creature* GetCreature(WorldObject const& u, ObjectGuid const guid);
    static Pet* GetPet(WorldObject const&, ObjectGuid const guid);
    static Player* GetPlayer(Map const*, ObjectGuid const guid);
    static Player* GetPlayer(WorldObject const&, ObjectGuid const guid);
    static Creature* GetCreatureOrPetOrVehicle(WorldObject const&, ObjectGuid const);

    // these functions return objects if found in whole world
    // ACCESS LIKE THAT IS NOT THREAD SAFE
    static Player* FindPlayer(ObjectGuid const);
    static Player* FindConnectedPlayer(ObjectGuid const);
    static Player* FindPlayerByName(std::string const& name, bool checkInWorld = true);
    static std::map<std::string, Player*> playerNameToPlayerPointer; // pussywizard: optimization

    // when using this, you must use the hashmapholder's lock
    static HashMapHolder<Player>::MapType const& GetPlayers()
    {
        return HashMapHolder<Player>::GetContainer();
    }

    template<class T> static void AddObject(T* object)
    {
        HashMapHolder<T>::Insert(object);
    }

    template<class T> static void RemoveObject(T* object)
    {
        HashMapHolder<T>::Remove(object);
    }

    static void SaveAllPlayers();

    //Thread safe
    Corpse* GetCorpseForPlayerGUID(ObjectGuid const guid);
    void RemoveCorpse(Corpse* corpse, bool final = false);
    void AddCorpse(Corpse* corpse);
    void AddCorpsesToGrid(GridCoord const& gridpair, GridType& grid, Map* map);
    Corpse* ConvertCorpseForPlayer(ObjectGuid const player_guid, bool insignia = false);

    //Thread unsafe
    void RemoveOldCorpses();
    void UnloadAll();

    // pussywizard: crashfix for corpses
    void AddDelayedCorpseAction(Corpse* corpse, uint8 action, uint32 mapId = 0, uint32 instanceId = 0);
    void ProcessDelayedCorpseActions();

private:
    typedef std::unordered_map<ObjectGuid, Corpse*> Player2CorpsesMapType;
    typedef std::unordered_map<Player*, UpdateData>::value_type UpdateDataValueType;

    Player2CorpsesMapType i_player2corpse;
    GuidList i_playerBones;

    ACE_RW_Thread_Mutex i_corpseLock;
    mutable ACE_Thread_Mutex DelayedCorpseLock;
};

#define sObjectAccessor ObjectAccessor::instance()

#endif
