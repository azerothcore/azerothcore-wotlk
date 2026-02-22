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

#ifndef ACORE_MAP_PARTITION_H
#define ACORE_MAP_PARTITION_H

#include "Define.h"
#include "Position.h"
#include <mutex>
#include <unordered_set>
#include <vector>

class Map;
class Player;
class Creature;
class GameObject;
class DynamicObject;
class WorldObject;

struct PartitionBounds
{
    float minX, maxX, minY, maxY;

    PartitionBounds() : minX(0.0f), maxX(0.0f), minY(0.0f), maxY(0.0f) {}
    PartitionBounds(float minX_, float maxX_, float minY_, float maxY_)
        : minX(minX_), maxX(maxX_), minY(minY_), maxY(maxY_) {}

    [[nodiscard]] bool Contains(float x, float y) const
    {
        return x >= minX && x < maxX && y >= minY && y < maxY;
    }

    [[nodiscard]] bool IsNearBorder(float x, float y, float margin) const
    {
        return (x - minX < margin) || (maxX - x < margin) ||
               (y - minY < margin) || (maxY - y < margin);
    }

    [[nodiscard]] float GetCenterX() const { return (minX + maxX) / 2.0f; }
    [[nodiscard]] float GetCenterY() const { return (minY + maxY) / 2.0f; }
    [[nodiscard]] float GetWidth() const { return maxX - minX; }
    [[nodiscard]] float GetHeight() const { return maxY - minY; }
};

class MapPartition
{
public:
    MapPartition(Map* parentMap, uint32 partitionId, PartitionBounds const& bounds);
    ~MapPartition();

    void Update(uint32 t_diff, uint32 s_diff);

    [[nodiscard]] bool ContainsPosition(float x, float y) const { return _bounds.Contains(x, y); }
    [[nodiscard]] bool IsNearBorder(float x, float y) const { return _bounds.IsNearBorder(x, y, _borderMargin); }

    void AddEntity(WorldObject* obj);
    void RemoveEntity(WorldObject* obj);
    std::vector<WorldObject*> GetBorderEntities() const;

    void CheckForMigrations(std::vector<std::pair<WorldObject*, MapPartition*>>& migrations);

    [[nodiscard]] uint32 GetPartitionId() const { return _partitionId; }
    [[nodiscard]] Map* GetParentMap() const { return _parentMap; }
    [[nodiscard]] PartitionBounds const& GetBounds() const { return _bounds; }
    [[nodiscard]] float GetBorderMargin() const { return _borderMargin; }

    [[nodiscard]] uint32 GetEntityCount() const;
    [[nodiscard]] uint32 GetPlayerCount() const;
    [[nodiscard]] uint32 GetCreatureCount() const;
    [[nodiscard]] uint32 GetGameObjectCount() const;

    std::string GetDebugInfo() const;

private:
    void UpdatePlayers(uint32 t_diff, uint32 s_diff);
    void UpdateCreatures(uint32 t_diff);
    void UpdateGameObjects(uint32 t_diff);
    void UpdateDynamicObjects(uint32 t_diff);

    Map* _parentMap;
    uint32 _partitionId;
    PartitionBounds _bounds;
    float _borderMargin;

    std::unordered_set<Player*> _players;
    std::unordered_set<Creature*> _creatures;
    std::unordered_set<GameObject*> _gameObjects;
    std::unordered_set<DynamicObject*> _dynamicObjects;

    mutable std::mutex _entityLock;
    uint32 _updateCount;
    uint32 _totalUpdateTime;
};

#endif
