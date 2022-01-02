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
    //Non instanceable only static
    HashMapHolder() = default;

public:

    typedef std::unordered_map<ObjectGuid, T*> MapType;

    static void Insert(T* o);

    static void Remove(T* o);

    static auto Find(ObjectGuid guid) -> T*;

    static auto GetContainer() -> MapType&;

    static auto GetLock() -> std::shared_mutex*;
};

namespace ObjectAccessor
{
    // these functions return objects only if in map of specified object
    auto GetWorldObject(WorldObject const&, ObjectGuid const guid) -> WorldObject*;
    auto GetObjectByTypeMask(WorldObject const&, ObjectGuid const guid, uint32 typemask) -> Object*;
    auto GetCorpse(WorldObject const& u, ObjectGuid const guid) -> Corpse*;
    auto GetGameObject(WorldObject const& u, ObjectGuid const guid) -> GameObject*;
    auto GetTransport(WorldObject const& u, ObjectGuid const guid) -> Transport*;
    auto GetDynamicObject(WorldObject const& u, ObjectGuid const guid) -> DynamicObject*;
    auto GetUnit(WorldObject const&, ObjectGuid const guid) -> Unit*;
    auto GetCreature(WorldObject const& u, ObjectGuid const guid) -> Creature*;
    auto GetPet(WorldObject const&, ObjectGuid const guid) -> Pet*;
    auto GetPlayer(Map const*, ObjectGuid const guid) -> Player*;
    auto GetPlayer(WorldObject const&, ObjectGuid const guid) -> Player*;
    auto GetCreatureOrPetOrVehicle(WorldObject const&, ObjectGuid const) -> Creature*;

    // these functions return objects if found in whole world
    // ACCESS LIKE THAT IS NOT THREAD SAFE
    auto FindPlayer(ObjectGuid const guid) -> Player*;
    auto FindPlayerByLowGUID(ObjectGuid::LowType lowguid) -> Player*;
    auto FindConnectedPlayer(ObjectGuid const guid) -> Player*;
    auto FindPlayerByName(std::string const& name, bool checkInWorld = true) -> Player*;

    // when using this, you must use the hashmapholder's lock
    auto GetPlayers() -> HashMapHolder<Player>::MapType const&;

    template<class T>
    void AddObject(T* object)
    {
        HashMapHolder<T>::Insert(object);
    }

    template<class T>
    void RemoveObject(T* object)
    {
        HashMapHolder<T>::Remove(object);
    }

    void SaveAllPlayers();

    template<>
    void AddObject(Player* player);

    template<>
    void RemoveObject(Player* player);
}

#endif
