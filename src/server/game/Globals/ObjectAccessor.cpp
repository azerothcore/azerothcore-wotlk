/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

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
#include "ObjectAccessor.h"
#include "ObjectDefines.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Pet.h"
#include "Player.h"
#include "Transport.h"
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

WorldObject* ObjectAccessor::GetWorldObject(WorldObject const& p, ObjectGuid const guid)
{
    switch (guid.GetHigh())
    {
        case HighGuid::Player:
            return GetPlayer(p, guid);
        case HighGuid::Transport:
        case HighGuid::Mo_Transport:
        case HighGuid::GameObject:
            return GetGameObject(p, guid);
        case HighGuid::Vehicle:
        case HighGuid::Unit:
            return GetCreature(p, guid);
        case HighGuid::Pet:
            return GetPet(p, guid);
        case HighGuid::DynamicObject:
            return GetDynamicObject(p, guid);
        case HighGuid::Corpse:
            return GetCorpse(p, guid);
        default:
            return nullptr;
    }
}

Object* ObjectAccessor::GetObjectByTypeMask(WorldObject const& p, ObjectGuid const guid, uint32 typemask)
{
    switch (guid.GetHigh())
    {
        case HighGuid::Item:
            if (typemask & TYPEMASK_ITEM && p.GetTypeId() == TYPEID_PLAYER)
                return ((Player const&)p).GetItemByGuid(guid);
            break;
        case HighGuid::Player:
            if (typemask & TYPEMASK_PLAYER)
                return GetPlayer(p, guid);
            break;
        case HighGuid::Transport:
        case HighGuid::Mo_Transport:
        case HighGuid::GameObject:
            if (typemask & TYPEMASK_GAMEOBJECT)
                return GetGameObject(p, guid);
            break;
        case HighGuid::Unit:
        case HighGuid::Vehicle:
            if (typemask & TYPEMASK_UNIT)
                return GetCreature(p, guid);
            break;
        case HighGuid::Pet:
            if (typemask & TYPEMASK_UNIT)
                return GetPet(p, guid);
            break;
        case HighGuid::DynamicObject:
            if (typemask & TYPEMASK_DYNAMICOBJECT)
                return GetDynamicObject(p, guid);
            break;
        case HighGuid::Corpse:
            break;
    }

    return nullptr;
}

Corpse* ObjectAccessor::GetCorpse(WorldObject const& u, ObjectGuid const guid)
{
    return u.GetMap()->GetCorpse(guid);
}

GameObject* ObjectAccessor::GetGameObject(WorldObject const& u, ObjectGuid const guid)
{
    return u.GetMap()->GetGameObject(guid);
}

Transport* ObjectAccessor::GetTransport(WorldObject const& u, ObjectGuid const guid)
{
    return u.GetMap()->GetTransport(guid);
}

DynamicObject* ObjectAccessor::GetDynamicObject(WorldObject const& u, ObjectGuid const guid)
{
    return u.GetMap()->GetDynamicObject(guid);
}

Unit* ObjectAccessor::GetUnit(WorldObject const& u, ObjectGuid const guid)
{
    if (guid.IsPlayer())
        return GetPlayer(u, guid);

    if (guid.IsPet())
        return GetPet(u, guid);

    return GetCreature(u, guid);
}

Creature* ObjectAccessor::GetCreature(WorldObject const& u, ObjectGuid const guid)
{
    return u.GetMap()->GetCreature(guid);
}

Pet* ObjectAccessor::GetPet(WorldObject const& u, ObjectGuid const guid)
{
    return u.GetMap()->GetPet(guid);
}

Player* ObjectAccessor::GetPlayer(Map const* m, ObjectGuid const guid)
{
    if (Player * player = HashMapHolder<Player>::Find(guid))
        if (player->IsInWorld() && player->GetMap() == m)
            return player;

    return nullptr;
}

Player* ObjectAccessor::GetPlayer(WorldObject const& u, ObjectGuid const guid)
{
    return GetPlayer(u.GetMap(), guid);
}

Creature* ObjectAccessor::GetCreatureOrPetOrVehicle(WorldObject const& u, ObjectGuid const guid)
{
    if (guid.IsPet())
        return GetPet(u, guid);

    if (guid.IsCreatureOrVehicle())
        return GetCreature(u, guid);

    return nullptr;
}

Player* ObjectAccessor::FindPlayer(ObjectGuid const guid)
{
    Player* player = HashMapHolder<Player>::Find(guid);
    return player && player->IsInWorld() ? player : nullptr;
}

Player* ObjectAccessor::FindConnectedPlayer(ObjectGuid const guid)
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

Corpse* ObjectAccessor::GetCorpseForPlayerGUID(ObjectGuid const guid)
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
        sObjectMgr->DeleteCorpseCellData(corpse->GetMapId(), cellCoord.GetId(), corpse->GetOwnerGUID());
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
        sObjectMgr->AddCorpseCellData(corpse->GetMapId(), cellCoord.GetId(), corpse->GetOwnerGUID(), corpse->GetInstanceId());
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

Corpse* ObjectAccessor::ConvertCorpseForPlayer(ObjectGuid const player_guid, bool insignia /*=false*/)
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

    // Map can be nullptr
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
        bones->Create(map->GenerateLowGuid<HighGuid::Corpse>(), map);

        for (uint8 i = OBJECT_FIELD_TYPE + 1; i < CORPSE_END; ++i)                    // don't overwrite guid and object type
            bones->SetUInt32Value(i, corpse->GetUInt32Value(i));

        bones->SetGridCoord(corpse->GetGridCoord());
        // bones->m_time = m_time;                              // don't overwrite time
        // bones->m_type = m_type;                              // don't overwrite type
        bones->Relocate(corpse->GetPositionX(), corpse->GetPositionY(), corpse->GetPositionZ(), corpse->GetOrientation());
        bones->SetPhaseMask(corpse->GetPhaseMask(), false);

        bones->SetUInt32Value(CORPSE_FIELD_FLAGS, CORPSE_FLAG_UNK2 | CORPSE_FLAG_BONES);
        bones->SetGuidValue(CORPSE_FIELD_OWNER, ObjectGuid::Empty);

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
    GuidList::iterator next2;
    ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, i_corpseLock);
    for (GuidList::iterator itr = i_playerBones.begin(); itr != i_playerBones.end(); itr = next2)
    {
        next2 = itr;
        ++next2;

        Corpse* c = GetObjectInWorld((*itr), (Corpse*)nullptr);
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
template class HashMapHolder<MotionTransport>;
