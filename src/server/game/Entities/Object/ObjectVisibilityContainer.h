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

#ifndef _OBJECTVISIBILITYCONTAINER_H
#define _OBJECTVISIBILITYCONTAINER_H

#include "Common.h"
#include "ObjectGuid.h"
#include <memory>
#include <unordered_map>

class Player;
class WorldObject;

typedef std::unordered_map<ObjectGuid, WorldObject*> VisibleWorldObjectsMap;
typedef std::unordered_map<ObjectGuid, Player*> VisiblePlayersMap;

// Class that manages the visibility containers of a worldobject
class ObjectVisibilityContainer
{
public:
    ObjectVisibilityContainer(WorldObject* selfObject);
    ~ObjectVisibilityContainer();

    // Creates the _visibleWorldObjectsMap map if we are a player
    void InitForPlayer();

    // Cleans up all visibility references from other worldobjects,
    // this is used before a worldobject is deleted to prevent any dangling references
    void CleanVisibilityReferences();

    void LinkWorldObjectVisibility(WorldObject* worldObject);
    void UnlinkWorldObjectVisibility(WorldObject* worldObject);

    // These helpers aren't ideal, but needed in a few spots for cleaning up references
    VisibleWorldObjectsMap::iterator UnlinkVisibilityFromPlayer(WorldObject* worldObject, VisibleWorldObjectsMap::iterator itr);
    VisiblePlayersMap::iterator UnlinkVisibilityFromWorldObject(Player* player, VisiblePlayersMap::iterator itr);

    // Returns a list of all players who can see us
    VisiblePlayersMap& GetVisiblePlayersMap() { return _visiblePlayersMap; }
    VisiblePlayersMap const& GetVisiblePlayersMap() const { return _visiblePlayersMap; }

    // Returns a list of all worldobjects who we can see
    // Warning: This is for player objects only, all other objects will return a nullptr
    VisibleWorldObjectsMap* GetVisibleWorldObjectsMap()
    {
        if (!_visibleWorldObjectsMap)
            return nullptr;

        return _visibleWorldObjectsMap.get();
    }

    VisibleWorldObjectsMap const* GetVisibleWorldObjectsMap() const
    {
        if (!_visibleWorldObjectsMap)
            return nullptr;

        return _visibleWorldObjectsMap.get();
    }

private:

    // Directly removes visibility reference. This is to be ONLY used as
    // a more efficient method for cleaning up visibility references.
    // Warning: Improper use will leave dangling references and result in crashes.
    void DirectRemoveVisibilityReference(ObjectGuid guid);

    // Directly inserts player visibility reference.
    // Warning: Improper use will leave dangling references and result in crashes.
    void DirectInsertVisiblePlayerReference(Player* player);

    // Directly removes player visibility reference.
    // Warning: Improper use will leave dangling references and result in crashes.
    void DirectRemoveVisiblePlayerReference(ObjectGuid guid);

    WorldObject* _selfObject;

    // List of all worldobjects that are visible to us (including other players)
    // Only players contain this map, thus we will only allocate it as needed.
    std::unique_ptr<VisibleWorldObjectsMap> _visibleWorldObjectsMap;

    // List of players who are currently able to see this worldobject.
    // All worldobjects will contain this map
    VisiblePlayersMap _visiblePlayersMap;
};

#endif
