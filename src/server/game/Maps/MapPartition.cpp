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

#include "MapPartition.h"
#include "Map.h"
#include "Object.h"
#include <algorithm>

// Constructor: Initializes a MapPartition object with its parent map and grid boudnaries
MapPartition::MapPartition(Map* parent, uint16 minGridX, uint16 maxGridX, uint16 minGridY, uint16 maxGridY)
    : _parentMap(parent), _minX(minGridX), _maxX(maxGridX), _minY(minGridY), _maxY(maxGridY)
{
}

// Checks if a given coordinate is inside the partition
bool MapPartition::Contains(uint16 gridX, uint16 gridY) const
{
    return (gridX >= _minX && gridX <= _maxX && gridY >= _minY && gridY <= _maxY);
}

// Adds a world object to be updated by this partition
void MapPartition::AddObject(WorldObject* obj)
{
    _updatableObjects.push_back(obj);
}

// Removes a world object from being updated by this partition
void MapPartition::RemoveObject(WorldObject* obj)
{
    // Finds the objects exact index in the vector
    auto it = std::find(_updatableObjects.begin(), _updatableObjects.end(), obj);
    if (it != _updatableObjects.end())
    {
        //overwrites the deleted object with the last object in the list and shrinks the list size by 1 
        *it = _updatableObjects.back();
        _updatableObjects.pop_back();

        UpdatableMapObject* mapUpdatableObject = dynamic_cast<UpdatableMapObject*>(obj);
        if (mapUpdatableObject)
        {
            mapUpdatableObject->SetUpdateState(UpdatableMapObject::UpdateState::NotUpdating);
        }
    }
}

//Pushes a world object into the transfer queue
void MapPartition::QueueTransfer(WorldObject* obj)
{
    _transferQueue.add(obj);
}

// The core physics and AI update loop
void MapPartition::Update(uint32 const diff)
{
    //Add objects from transfer queue before starting updates
    WorldObject* incomingObj = nullptr;
    while (_transferQueue.next(incomingObj))
    {
        if (incomingObj && incomingObj->IsInWorld())
        {
            AddObject(incomingObj);
        }
    }

    // Conditionally increment i inside the loop to avoid skipping swaped elements
    for (uint32 i = 0; i < _updatableObjects.size();)
    {
        WorldObject* obj = _updatableObjects[i];

        // skips the loop if the object was deleted from memory or is not in the world
        if (!obj || !obj->IsInWorld())
        {
            ++i;
            continue;
        }

        // triggers combat, spellcasting, movement, and pathfinding calc here
        obj->Update(diff);

        // Check if the object is no longer within the partition
        GridCoord currentGrid = Acore::ComputeGridCoord(obj->GetPositionX(), obj->GetPositionY());
        if (!Contains(currentGrid.x_coord, currentGrid.y_coord))
        {
            // Remove object from partition if it is no longer inside the partition
            RemoveObject(obj);

            // Ask parent map what partition the object is in, then push the object to that partitions queue
            MapPartition* newPartition = GetParent()->GetPartition(currentGrid.x_coord, currentGrid.y_coord);
            if (newPartition)
            {
                newPartition->QueueTransfer(obj);
            }

            // intentionally skip ++i because RemoveObject swaps array elements
            continue;
        }

        // removes the entity from the active list if it does not need updating
        if (!obj->IsUpdateNeeded())
        {
            RemoveObject(obj);

            // intentionally skip ++i because RemoveObject swaps array elements
        }
        else {
            // object gets updated and is still active, moves onto the next object
            ++i;
        }
    }
}
