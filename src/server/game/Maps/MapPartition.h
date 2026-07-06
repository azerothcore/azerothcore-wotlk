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

#ifndef MAPPARTITION_H
#define MAPPARTITION_H

#include "Common.h"
#include "LockedQueue.h"
#include <vector>

class Map;
class WorldObject;

/**
 * @class MapPartition
 * @brief Represents a subdivision of a map
 *
 * Subdivides maps into paritions to avoid bottlenecking with high volumes of world objects
 * Paritions manages it own subset of world objects
 * Update loops run parallel across multiple threads
 */
class MapPartition
{
public:
    /**
     * @brief Constructs a new MapPartition object with specific bounding coordinates
     * @param parent The parent map of the partition
     * @param minGridX The west most grid boundary
     * @param maxGridX The east most grid boundary
     * @param minGridY The north most grid boundary
     * @param maxGridY The south most grid boundary
     */
    MapPartition(Map* parent, uint16 minGridX, uint16 maxGridX, uint16 minGridY, uint16 maxGridY);

    ~MapPartition() = default;

    /**
     * @brief The core AI and physics loop for the partition
     * @param diff Time since last server tick (ms)
     */
    void Update(uint32 const diff);

    /**
     * @brief Adds an entity to the partitions update loop
     * @param obj The entity entering the partition
     */
    void AddObject(WorldObject* obj);

    /**
     * @brief Removes an entity from the partitions update loop
     * @param obj The entity leaving the partition
     */
    void RemoveObject(WorldObject* obj);

    /**
     * @brief Safely queues an entity to be added to this partition
     * @param obj the entity to queue
     */
    void QueueTransfer(WorldObject* obj);

    /**
     * @brief Checks if a grid coordinate is within the partition
     * @param gridX The X of the coordinate to check
     * @param gridY The Y of the coordinate to check
     * @return True if the coordinate falls within the partition, False otherwise.
     */
    [[nodiscard]] bool Contains(uint16 gridX, uint16 gridY) const;

    /**
     * @brief Gets the parent map of the partition
     * @return A Pointer to the parent map
     */
    [[nodiscard]] Map* GetParent() const { return _parentMap; }

private:
    Map* _parentMap;

    uint16 _minX;
    uint16 _maxX;
    uint16 _minY;
    uint16 _maxY;

    std::vector<WorldObject*> _updatableObjects;

    LockedQueue<ObjectGuid> _transferQueue;
};

#endif //MAPPARTITION_H
