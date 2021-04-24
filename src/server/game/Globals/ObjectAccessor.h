/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_OBJECTACCESSOR_H
#define ACORE_OBJECTACCESSOR_H

#include "Define.h"
#include "GridDefines.h"
#include "Object.h"
#include "UpdateData.h"
#include <mutex>
#include <set>
#include <shared_mutex>
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
    typedef std::unordered_map<uint64, T*> MapType;

    static void Insert(T* o);
    static void Remove(T* o);
    static T* Find(uint64 guid);

    static MapType& GetContainer() { return m_objectMap; }
    static std::shared_mutex* GetLock();

private:
    //Non instanceable only static
    HashMapHolder() = default;

    static MapType m_objectMap;
};

/// Define the static members of HashMapHolder

template <class T> std::unordered_map< uint64, T* > HashMapHolder<T>::m_objectMap;

// pussywizard:
class DelayedCorpseAction
{
public:
    DelayedCorpseAction(Corpse* corpse, uint8 action, uint32 mapId, uint32 instanceId) : _corpse(corpse), _action(action), _mapId(mapId), _instanceId(instanceId) {}
    Corpse* _corpse;
    uint8 _action;
    uint32 _mapId;
    uint32 _instanceId;
};

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

    template<class T> static T* GetObjectInOrOutOfWorld(uint64 guid, T* /*typeSpecifier*/)
    {
        return HashMapHolder<T>::Find(guid);
    }

    static Unit* GetObjectInOrOutOfWorld(uint64 guid, Unit* /*typeSpecifier*/)
    {
        if (IS_PLAYER_GUID(guid))
            return (Unit*)GetObjectInOrOutOfWorld(guid, (Player*)nullptr);

        if (IS_PET_GUID(guid))
            return (Unit*)GetObjectInOrOutOfWorld(guid, (Pet*)nullptr);

        return (Unit*)GetObjectInOrOutOfWorld(guid, (Creature*)nullptr);
    }

    // returns object if is in world
    template<class T> static T* GetObjectInWorld(uint64 guid, T* /*typeSpecifier*/)
    {
        return HashMapHolder<T>::Find(guid);
    }

    // Player may be not in world while in ObjectAccessor
    static Player* GetObjectInWorld(uint64 guid, Player* /*typeSpecifier*/);

    static Unit* GetObjectInWorld(uint64 guid, Unit* /*typeSpecifier*/)
    {
        if (IS_PLAYER_GUID(guid))
            return (Unit*)GetObjectInWorld(guid, (Player*)nullptr);

        if (IS_PET_GUID(guid))
            return (Unit*)GetObjectInWorld(guid, (Pet*)nullptr);

        return (Unit*)GetObjectInWorld(guid, (Creature*)nullptr);
    }

    // returns object if is in map
    template<class T> static T* GetObjectInMap(uint64 guid, Map* map, T* /*typeSpecifier*/)
    {
        ASSERT(map);
        if (T* obj = GetObjectInWorld(guid, (T*)nullptr))
            if (obj->GetMap() == map)
                return obj;
        return nullptr;
    }

    template<class T>
    static T* GetObjectInWorld(uint32 mapid, float x, float y, uint64 guid, T* /*fake*/);

    // these functions return objects only if in map of specified object
    static WorldObject* GetWorldObject(WorldObject const&, uint64);
    static Object* GetObjectByTypeMask(WorldObject const&, uint64, uint32 typemask);
    static Corpse* GetCorpse(WorldObject const& u, uint64 guid);
    static GameObject* GetGameObject(WorldObject const& u, uint64 guid);
    static Transport* GetTransport(WorldObject const& u, uint64 guid);
    static DynamicObject* GetDynamicObject(WorldObject const& u, uint64 guid);
    static Unit* GetUnit(WorldObject const&, uint64 guid);
    static Creature* GetCreature(WorldObject const& u, uint64 guid);
    static Pet* GetPet(WorldObject const&, uint64 guid);
    static Player* GetPlayer(WorldObject const&, uint64 guid);
    static Creature* GetCreatureOrPetOrVehicle(WorldObject const&, uint64);

    // these functions return objects if found in whole world
    // ACCESS LIKE THAT IS NOT THREAD SAFE
    static Pet* FindPet(uint64);
    static Player* FindPlayer(uint64);
    static Player* FindPlayerInOrOutOfWorld(uint64 m_guid);

    static Unit* FindUnit(uint64);
    static Player* FindConnectedPlayer(uint64 const&);
    static Player* FindPlayerByName(std::string const& name, bool checkInWorld = true);
    static std::map<std::string, Player*> playerNameToPlayerPointer; // pussywizard: optimization

    // when using this, you must use the hashmapholder's lock
    static HashMapHolder<Player>::MapType const& GetPlayers()
    {
        return HashMapHolder<Player>::GetContainer();
    }

    // when using this, you must use the hashmapholder's lock
    static HashMapHolder<Creature>::MapType const& GetCreatures()
    {
        return HashMapHolder<Creature>::GetContainer();
    }

    // when using this, you must use the hashmapholder's lock
    static HashMapHolder<GameObject>::MapType const& GetGameObjects()
    {
        return HashMapHolder<GameObject>::GetContainer();
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

    //non-static functions
    void AddUpdateObject(Object* obj)
    {
        std::lock_guard<std::mutex> guard(i_objectLock);
        if (obj->GetTypeId() < TYPEID_UNIT) // these are not in map: TYPEID_OBJECT, TYPEID_ITEM, TYPEID_CONTAINER
            i_objects.insert(obj);
        else
            ((WorldObject*)obj)->FindMap()->i_objectsToUpdate.insert(obj);
    }

    void RemoveUpdateObject(Object* obj)
    {
        std::lock_guard<std::mutex> guard(i_objectLock);
        if (obj->GetTypeId() < TYPEID_UNIT) // these are not in map: TYPEID_OBJECT, TYPEID_ITEM, TYPEID_CONTAINER
            i_objects.erase(obj);
        else
            ((WorldObject*)obj)->FindMap()->i_objectsToUpdate.erase(obj);
    }

    //Thread safe
    Corpse* GetCorpseForPlayerGUID(uint64 guid);
    void RemoveCorpse(Corpse* corpse, bool final = false);
    void AddCorpse(Corpse* corpse);
    void AddCorpsesToGrid(GridCoord const& gridpair, GridType& grid, Map* map);
    Corpse* ConvertCorpseForPlayer(uint64 player_guid, bool insignia = false);

    //Thread unsafe
    void Update(uint32 diff);
    void RemoveOldCorpses();
    void UnloadAll();

    // pussywizard: crashfix for corpses
    void AddDelayedCorpseAction(Corpse* corpse, uint8 action, uint32 mapId = 0, uint32 instanceId = 0);
    void ProcessDelayedCorpseActions();

private:
    static void _buildChangeObjectForPlayer(WorldObject*, UpdateDataMapType&);
    static void _buildPacket(Player*, Object*, UpdateDataMapType&);
    void _update();

    typedef std::unordered_map<uint64, Corpse*> Player2CorpsesMapType;
    typedef std::unordered_map<Player*, UpdateData>::value_type UpdateDataValueType;

    std::unordered_set<Object*> i_objects;
    Player2CorpsesMapType i_player2corpse;
    std::list<uint64> i_playerBones;

    std::mutex i_objectLock;
    std::shared_mutex i_corpseLock;
    std::list<DelayedCorpseAction> i_delayedCorpseActions;
    mutable std::mutex DelayedCorpseLock;
};

#define sObjectAccessor ObjectAccessor::instance()

#endif
