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

#include "ObjectVisibilityContainer.h"
#include "Object.h"
#include "Player.h"

/*
* Some implementation notes:
* Non-player worldobjects do not have any concept of 'visibility', thus,
* the most important and mainly used map is 'VisibleWorldObjectsMap'
* which is only accessible for player objects. The 'VisiblePlayersMap'
* map is simply for managing the references so we can use direct pointers.
*/

ObjectVisibilityContainer::ObjectVisibilityContainer(WorldObject* selfObject) :
    _selfObject(selfObject)
{
}

ObjectVisibilityContainer::~ObjectVisibilityContainer()
{
    ASSERT(_visiblePlayersMap.empty());
    if (_visibleWorldObjectsMap)
        ASSERT((*_visibleWorldObjectsMap).empty());
}

void ObjectVisibilityContainer::InitForPlayer()
{
    _visibleWorldObjectsMap = std::make_unique<VisibleWorldObjectsMap>();
}

void ObjectVisibilityContainer::CleanVisibilityReferences()
{
    for (auto const& kvPair : _visiblePlayersMap)
        kvPair.second->GetObjectVisibilityContainer().DirectRemoveVisibilityReference(_selfObject->GetGUID());

    if (_visibleWorldObjectsMap)
    {
        for (auto const& kvPair : *_visibleWorldObjectsMap)
            kvPair.second->GetObjectVisibilityContainer().DirectRemoveVisiblePlayerReference(_selfObject->GetGUID());

        (*_visibleWorldObjectsMap).clear();
    }

    _visiblePlayersMap.clear();
}

void ObjectVisibilityContainer::LinkWorldObjectVisibility(WorldObject* worldObject)
{
    // Do not link self
    if (worldObject == _selfObject)
        return;

    // Transports are special and should not be added to our visibility map
    if (worldObject->IsGameObject() && worldObject->ToGameObject()->IsTransport())
        return;

    // Only players can link visibility
    if (!_visibleWorldObjectsMap)
        return;

    (*_visibleWorldObjectsMap).insert(std::make_pair(worldObject->GetGUID(), worldObject));
    worldObject->GetObjectVisibilityContainer().DirectInsertVisiblePlayerReference(_selfObject->ToPlayer());
}

void ObjectVisibilityContainer::UnlinkWorldObjectVisibility(WorldObject* worldObject)
{
    // Only players can unlink visibility
    if (!_visibleWorldObjectsMap)
        return;

    worldObject->GetObjectVisibilityContainer().DirectRemoveVisiblePlayerReference(_selfObject->GetGUID());
    (*_visibleWorldObjectsMap).erase(worldObject->GetGUID());
}

VisibleWorldObjectsMap::iterator ObjectVisibilityContainer::UnlinkVisibilityFromPlayer(WorldObject* worldObject, VisibleWorldObjectsMap::iterator itr)
{
    ASSERT(_visibleWorldObjectsMap); // Ensure we aren't for some reason calling this as a non-player object
    worldObject->GetObjectVisibilityContainer().DirectRemoveVisiblePlayerReference(_selfObject->GetGUID());
    return (*_visibleWorldObjectsMap).erase(itr);
}

VisiblePlayersMap::iterator ObjectVisibilityContainer::UnlinkVisibilityFromWorldObject(Player* player, VisiblePlayersMap::iterator itr)
{
    player->GetObjectVisibilityContainer().DirectRemoveVisibilityReference(_selfObject->GetGUID());
    return _visiblePlayersMap.erase(itr);
}

void ObjectVisibilityContainer::DirectRemoveVisibilityReference(ObjectGuid guid)
{
    ASSERT(_visibleWorldObjectsMap);
    (*_visibleWorldObjectsMap).erase(guid);
}

void ObjectVisibilityContainer::DirectInsertVisiblePlayerReference(Player* player)
{
    _visiblePlayersMap.insert(std::make_pair(player->GetGUID(), player));
}

void ObjectVisibilityContainer::DirectRemoveVisiblePlayerReference(ObjectGuid guid)
{
    _visiblePlayersMap.erase(guid);
}
