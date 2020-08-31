/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ObjectAccessor.h"
#include "CellImpl.h"
#include "Corpse.h"
#include "Creature.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Item.h"
#include "Map.h"
#include "MapInstanced.h"
#include "MapManager.h"
#include "ObjectDefines.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Pet.h"
#include "Player.h"
#include "Vehicle.h"
#include "World.h"
#include "WorldPacket.h"

#include <cmath>

ObjectAccessor::ObjectAccessor()
{
}

ObjectAccessor::~ObjectAccessor()
{
}

ObjectAccessor* ObjectAccessor::instance()
{
    static ObjectAccessor instance;
    return &instance;
}

Player* ObjectAccessor::GetObjectInWorld(uint64 guid, Player* /*typeSpecifier*/)
{
    Player* player = HashMapHolder<Player>::Find(guid);
    return player && player->IsInWorld() ? player : nullptr;
}

WorldObject* ObjectAccessor::GetWorldObject(WorldObject const& p, uint64 guid)
{
    switch (GUID_HIPART(guid))
    {
        case HIGHGUID_PLAYER:        return GetPlayer(p, guid);
        case HIGHGUID_TRANSPORT:
        case HIGHGUID_MO_TRANSPORT:
        case HIGHGUID_GAMEOBJECT:    return GetGameObject(p, guid);
        case HIGHGUID_VEHICLE:
        case HIGHGUID_UNIT:          return GetCreature(p, guid);
        case HIGHGUID_PET:           return GetPet(p, guid);
        case HIGHGUID_DYNAMICOBJECT: return GetDynamicObject(p, guid);
        case HIGHGUID_CORPSE:        return GetCorpse(p, guid);
        default:                     return nullptr;
    }
}

Object* ObjectAccessor::GetObjectByTypeMask(WorldObject const& p, uint64 guid, uint32 typemask)
{
    switch (GUID_HIPART(guid))
    {
        case HIGHGUID_ITEM:
            if (typemask & TYPEMASK_ITEM && p.GetTypeId() == TYPEID_PLAYER)
                return ((Player const&)p).GetItemByGuid(guid);
            break;
        case HIGHGUID_PLAYER:
            if (typemask & TYPEMASK_PLAYER)
                return GetPlayer(p, guid);
            break;
        case HIGHGUID_TRANSPORT:
        case HIGHGUID_MO_TRANSPORT:
        case HIGHGUID_GAMEOBJECT:
            if (typemask & TYPEMASK_GAMEOBJECT)
                return GetGameObject(p, guid);
            break;
        case HIGHGUID_UNIT:
        case HIGHGUID_VEHICLE:
            if (typemask & TYPEMASK_UNIT)
                return GetCreature(p, guid);
            break;
        case HIGHGUID_PET:
            if (typemask & TYPEMASK_UNIT)
                return GetPet(p, guid);
            break;
        case HIGHGUID_DYNAMICOBJECT:
            if (typemask & TYPEMASK_DYNAMICOBJECT)
                return GetDynamicObject(p, guid);
            break;
        case HIGHGUID_CORPSE:
            break;
    }

    return nullptr;
}

Corpse* ObjectAccessor::GetCorpse(WorldObject const& u, uint64 guid)
{
    return GetObjectInMap(guid, u.GetMap(), (Corpse*)NULL);
}

GameObject* ObjectAccessor::GetGameObject(WorldObject const& u, uint64 guid)
{
    return GetObjectInMap(guid, u.GetMap(), (GameObject*)NULL);
}

Transport* ObjectAccessor::GetTransport(WorldObject const& u, uint64 guid)
{
    if (GUID_HIPART(guid) != HIGHGUID_MO_TRANSPORT && GUID_HIPART(guid) != HIGHGUID_TRANSPORT)
        return nullptr;

    GameObject* go = GetGameObject(u, guid);
    return go ? go->ToTransport() : nullptr;
}

DynamicObject* ObjectAccessor::GetDynamicObject(WorldObject const& u, uint64 guid)
{
    return GetObjectInMap(guid, u.GetMap(), (DynamicObject*)NULL);
}

Unit* ObjectAccessor::GetUnit(WorldObject const& u, uint64 guid)
{
    return GetObjectInMap(guid, u.GetMap(), (Unit*)NULL);
}

Creature* ObjectAccessor::GetCreature(WorldObject const& u, uint64 guid)
{
    return GetObjectInMap(guid, u.GetMap(), (Creature*)NULL);
}

Pet* ObjectAccessor::GetPet(WorldObject const& u, uint64 guid)
{
    return GetObjectInMap(guid, u.GetMap(), (Pet*)NULL);
}

Player* ObjectAccessor::GetPlayer(WorldObject const& u, uint64 guid)
{
    return GetObjectInMap(guid, u.GetMap(), (Player*)NULL);
}

Creature* ObjectAccessor::GetCreatureOrPetOrVehicle(WorldObject const& u, uint64 guid)
{
    if (IS_PET_GUID(guid))
        return GetPet(u, guid);

    if (IS_CRE_OR_VEH_GUID(guid))
        return GetCreature(u, guid);

    return nullptr;
}

Pet* ObjectAccessor::FindPet(uint64 guid)
{
    return GetObjectInWorld(guid, (Pet*)NULL);
}

Player* ObjectAccessor::FindPlayer(uint64 guid)
{
    return GetObjectInWorld(guid, (Player*)NULL);
}

Player* ObjectAccessor::FindPlayerInOrOutOfWorld(uint64 guid)
{
    return GetObjectInOrOutOfWorld(guid, (Player*)NULL);
}

Unit* ObjectAccessor::FindUnit(uint64 guid)
{
    return GetObjectInWorld(guid, (Unit*)NULL);
}

Player* ObjectAccessor::FindConnectedPlayer(uint64 const& guid)
{
    return HashMapHolder<Player>::Find(guid);
}

Player* ObjectAccessor::FindPlayerByName(std::string const& name, bool checkInWorld)
{
    /*ACORE_READ_GUARD(HashMapHolder<Player>::LockType, *HashMapHolder<Player>::GetLock());
    std::string nameStr = name;
    std::transform(nameStr.begin(), nameStr.end(), nameStr.begin(), ::tolower);
    HashMapHolder<Player>::MapType const& m = GetPlayers();
    for (HashMapHolder<Player>::MapType::const_iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        if (!iter->second->IsInWorld())
            continue;
        std::string currentName = iter->second->GetName();
        std::transform(currentName.begin(), currentName.end(), currentName.begin(), ::tolower);
        if (nameStr.compare(currentName) == 0)
            return iter->second;
    }*/

    // pussywizard: optimization
    std::string nameStr = name;
    std::transform(nameStr.begin(), nameStr.end(), nameStr.begin(), ::tolower);
    std::map<std::string, Player*>::iterator itr = playerNameToPlayerPointer.find(nameStr);
    if (itr != playerNameToPlayerPointer.end())
        if (!checkInWorld || itr->second->IsInWorld())
            return itr->second;

    return nullptr;
}

void ObjectAccessor::SaveAllPlayers()
{
    ACORE_READ_GUARD(HashMapHolder<Player>::LockType, *HashMapHolder<Player>::GetLock());
    HashMapHolder<Player>::MapType const& m = GetPlayers();
    for (HashMapHolder<Player>::MapType::const_iterator itr = m.begin(); itr != m.end(); ++itr)
        itr->second->SaveToDB(false, false);
}

Corpse* ObjectAccessor::GetCorpseForPlayerGUID(uint64 guid)
{
    ACORE_READ_GUARD(ACE_RW_Thread_Mutex, i_corpseLock);

    Player2CorpsesMapType::iterator iter = i_player2corpse.find(guid);
    if (iter == i_player2corpse.end())
        return nullptr;

    ASSERT(iter->second->GetType() != CORPSE_BONES);

    return iter->second;
}

void ObjectAccessor::RemoveCorpse(Corpse* corpse, bool final)
{
    ASSERT(corpse && corpse->GetType() != CORPSE_BONES);

    if (!final)
    {
        ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, i_corpseLock);
        Player2CorpsesMapType::iterator iter = i_player2corpse.find(corpse->GetOwnerGUID());
        if (iter == i_player2corpse.end())
            return;
        i_player2corpse.erase(iter);
        AddDelayedCorpseAction(corpse, 0);
        return;
    }

    //TODO: more works need to be done for corpse and other world object
    if (Map* map = corpse->FindMap())
    {
        // xinef: ok, should be called in both cases
        corpse->DestroyForNearbyPlayers();
        if (corpse->IsInGrid())
            map->RemoveFromMap(corpse, false);
        else
        {
            corpse->RemoveFromWorld();
            corpse->ResetMap();
        }
    }
    else
        corpse->RemoveFromWorld();

    // Critical section
    {
        ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, i_corpseLock);

        // build mapid*cellid -> guid_set map
        CellCoord cellCoord = acore::ComputeCellCoord(corpse->GetPositionX(), corpse->GetPositionY());
        sObjectMgr->DeleteCorpseCellData(corpse->GetMapId(), cellCoord.GetId(), GUID_LOPART(corpse->GetOwnerGUID()));
    }

    delete corpse; // pussywizard: as it is delayed now, delete is moved here (previously in ConvertCorpseForPlayer)
}

void ObjectAccessor::AddCorpse(Corpse* corpse)
{
    ASSERT(corpse && corpse->GetType() != CORPSE_BONES);

    // Critical section
    {
        ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, i_corpseLock);

        ASSERT(i_player2corpse.find(corpse->GetOwnerGUID()) == i_player2corpse.end());
        i_player2corpse[corpse->GetOwnerGUID()] = corpse;

        // build mapid*cellid -> guid_set map
        CellCoord cellCoord = acore::ComputeCellCoord(corpse->GetPositionX(), corpse->GetPositionY());
        sObjectMgr->AddCorpseCellData(corpse->GetMapId(), cellCoord.GetId(), GUID_LOPART(corpse->GetOwnerGUID()), corpse->GetInstanceId());
    }
}

void ObjectAccessor::AddCorpsesToGrid(GridCoord const& gridpair, GridType& grid, Map* map)
{
    ACORE_READ_GUARD(ACE_RW_Thread_Mutex, i_corpseLock);

    for (Player2CorpsesMapType::iterator iter = i_player2corpse.begin(); iter != i_player2corpse.end(); ++iter)
    {
        // We need this check otherwise a corpose may be added to a grid twice
        if (iter->second->IsInGrid())
            continue;

        if (iter->second->GetGridCoord() == gridpair)
        {
            // verify, if the corpse in our instance (add only corpses which are)
            if (map->Instanceable())
            {
                if (iter->second->GetInstanceId() == map->GetInstanceId())
                    grid.AddWorldObject(iter->second);
            }
            else
                grid.AddWorldObject(iter->second);
        }
    }
}

Corpse* ObjectAccessor::ConvertCorpseForPlayer(uint64 player_guid, bool insignia /*=false*/)
{
    Corpse* corpse = GetCorpseForPlayerGUID(player_guid);
    if (!corpse)
    {
        //in fact this function is called from several places
        //even when player doesn't have a corpse, not an error
        return nullptr;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("Deleting Corpse and spawned bones.");
#endif

    // Map can be NULL
    Map* map = corpse->FindMap();
    bool inWorld = corpse->IsInWorld();

    // remove corpse from player_guid -> corpse map and from current map
    RemoveCorpse(corpse);

    // remove corpse from DB
    SQLTransaction trans = CharacterDatabase.BeginTransaction();
    corpse->DeleteFromDB(trans);
    CharacterDatabase.CommitTransaction(trans);

    Corpse* bones = nullptr;
    // create the bones only if the map and the grid is loaded at the corpse's location
    // ignore bones creating option in case insignia

    if (map && corpse->IsPositionValid() && inWorld && (insignia ||
        (map->IsBattlegroundOrArena() ? sWorld->getBoolConfig(CONFIG_DEATH_BONES_BG_OR_ARENA) : sWorld->getBoolConfig(CONFIG_DEATH_BONES_WORLD))) &&
        !map->IsRemovalGrid(corpse->GetPositionX(), corpse->GetPositionY()))
    {
        // Create bones, don't change Corpse
        bones = new Corpse;
        bones->Create(sObjectMgr->GenerateLowGuid(HIGHGUID_CORPSE), map);

        for (uint8 i = OBJECT_FIELD_TYPE + 1; i < CORPSE_END; ++i)                    // don't overwrite guid and object type
            bones->SetUInt32Value(i, corpse->GetUInt32Value(i));

        bones->SetGridCoord(corpse->GetGridCoord());
        // bones->m_time = m_time;                              // don't overwrite time
        // bones->m_type = m_type;                              // don't overwrite type
        bones->Relocate(corpse->GetPositionX(), corpse->GetPositionY(), corpse->GetPositionZ(), corpse->GetOrientation());
        bones->SetPhaseMask(corpse->GetPhaseMask(), false);

        bones->SetUInt32Value(CORPSE_FIELD_FLAGS, CORPSE_FLAG_UNK2 | CORPSE_FLAG_BONES);
        bones->SetUInt64Value(CORPSE_FIELD_OWNER, 0);

        for (uint8 i = 0; i < EQUIPMENT_SLOT_END; ++i)
        {
            if (corpse->GetUInt32Value(CORPSE_FIELD_ITEM + i))
                bones->SetUInt32Value(CORPSE_FIELD_ITEM + i, 0);
        }

        // add bones in grid store if grid loaded where corpse placed
        if (insignia) // pussywizard: in case of insignia we need bones right now, map is the same so not a problem
            map->AddToMap(bones);
        else
        {
            bones->ResetMap();
            sObjectAccessor->AddDelayedCorpseAction(bones, 1, map->GetId(), map->GetInstanceId());
        }

        // pussywizard: for deleting bones
        ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, i_corpseLock);
        i_playerBones.push_back(bones->GetGUID());
    }

    // all references to the corpse should be removed at this point
    //delete corpse; // pussywizard: deleting corpse is delayed (crashfix)

    return bones;
}

void ObjectAccessor::RemoveOldCorpses()
{
    time_t now = time(nullptr);
    Player2CorpsesMapType::iterator next;
    for (Player2CorpsesMapType::iterator itr = i_player2corpse.begin(); itr != i_player2corpse.end(); itr = next)
    {
        next = itr;
        ++next;

        if (!itr->second->IsExpired(now))
            continue;

        ConvertCorpseForPlayer(itr->first);
    }

    // pussywizard: for deleting bones
    std::list<uint64>::iterator next2;
    ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, i_corpseLock);
    for (std::list<uint64>::iterator itr = i_playerBones.begin(); itr != i_playerBones.end(); itr = next2)
    {
        next2 = itr;
        ++next2;

        Corpse* c = GetObjectInWorld((*itr), (Corpse*)NULL);
        if (c)
        {
            if (!c->IsExpired(now))
                continue;

            if (Map* map = c->FindMap())
            {
                if (c->IsInGrid())
                    map->RemoveFromMap(c, false);
                else
                {
                    c->DestroyForNearbyPlayers();
                    c->RemoveFromWorld();
                    c->ResetMap();
                }
            }
            else
                c->RemoveFromWorld();
        }

        i_playerBones.erase(itr);
    }
}

void ObjectAccessor::AddDelayedCorpseAction(Corpse* corpse, uint8 action, uint32 mapId, uint32 instanceId)
{
    ACORE_GUARD(ACE_Thread_Mutex, DelayedCorpseLock);
    i_delayedCorpseActions.push_back(DelayedCorpseAction(corpse, action, mapId, instanceId));
}

void ObjectAccessor::ProcessDelayedCorpseActions()
{
    ACORE_GUARD(ACE_Thread_Mutex, DelayedCorpseLock);
    for (std::list<DelayedCorpseAction>::iterator itr = i_delayedCorpseActions.begin(); itr != i_delayedCorpseActions.end(); ++itr)
    {
        DelayedCorpseAction a = (*itr);
        switch (a._action)
        {
            case 0: // remove corpse
                RemoveCorpse(a._corpse, true);
                break;
            case 1: // add bones
                if (Map* map = sMapMgr->FindMap(a._mapId, a._instanceId))
                    if (!map->IsRemovalGrid(a._corpse->GetPositionX(), a._corpse->GetPositionY()))
                    {
                        a._corpse->SetMap(map);
                        map->AddToMap(a._corpse);
                    }
                break;
        }
    }
    i_delayedCorpseActions.clear();
}

void ObjectAccessor::Update(uint32 /*diff*/)
{
    UpdateDataMapType update_players;
    UpdatePlayerSet player_set;

    while (!i_objects.empty())
    {
        Object* obj = *i_objects.begin();
        ASSERT(obj && obj->IsInWorld());
        i_objects.erase(i_objects.begin());
        obj->BuildUpdate(update_players, player_set);
    }

    WorldPacket packet;                                     // here we allocate a std::vector with a size of 0x10000
    for (UpdateDataMapType::iterator iter = update_players.begin(); iter != update_players.end(); ++iter)
    {
        iter->second.BuildPacket(&packet);
        iter->first->GetSession()->SendPacket(&packet);
        packet.clear();                                     // clean the string
    }
}

void Map::BuildAndSendUpdateForObjects()
{
    UpdateDataMapType update_players;
    UpdatePlayerSet player_set;

    while (!i_objectsToUpdate.empty())
    {
        Object* obj = *i_objectsToUpdate.begin();
        ASSERT(obj && obj->IsInWorld());
        i_objectsToUpdate.erase(i_objectsToUpdate.begin());
        obj->BuildUpdate(update_players, player_set);
    }

    WorldPacket packet;                                     // here we allocate a std::vector with a size of 0x10000
    for (UpdateDataMapType::iterator iter = update_players.begin(); iter != update_players.end(); ++iter)
    {
        iter->second.BuildPacket(&packet);
        iter->first->GetSession()->SendPacket(&packet);
        packet.clear();                                     // clean the string
    }
}

void ObjectAccessor::UnloadAll()
{
    for (Player2CorpsesMapType::const_iterator itr = i_player2corpse.begin(); itr != i_player2corpse.end(); ++itr)
    {
        itr->second->RemoveFromWorld();
        delete itr->second;
    }
}

std::map<std::string, Player*> ObjectAccessor::playerNameToPlayerPointer;


/// Global definitions for the hashmap storage

template class HashMapHolder<Player>;
template class HashMapHolder<Pet>;
template class HashMapHolder<GameObject>;
template class HashMapHolder<DynamicObject>;
template class HashMapHolder<Creature>;
template class HashMapHolder<Corpse>;

template Player* ObjectAccessor::GetObjectInWorld<Player>(uint32 mapid, float x, float y, uint64 guid, Player* /*fake*/);
template Pet* ObjectAccessor::GetObjectInWorld<Pet>(uint32 mapid, float x, float y, uint64 guid, Pet* /*fake*/);
template Creature* ObjectAccessor::GetObjectInWorld<Creature>(uint32 mapid, float x, float y, uint64 guid, Creature* /*fake*/);
template Corpse* ObjectAccessor::GetObjectInWorld<Corpse>(uint32 mapid, float x, float y, uint64 guid, Corpse* /*fake*/);
template GameObject* ObjectAccessor::GetObjectInWorld<GameObject>(uint32 mapid, float x, float y, uint64 guid, GameObject* /*fake*/);
template DynamicObject* ObjectAccessor::GetObjectInWorld<DynamicObject>(uint32 mapid, float x, float y, uint64 guid, DynamicObject* /*fake*/);
