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

#ifndef ACORE_PARTITIONED_MAP_H
#define ACORE_PARTITIONED_MAP_H

#include "Map.h"
#include "MapPartition.h"
#include <shared_mutex>
#include <functional>

class PartitionedMap : public Map
{
public:
    PartitionedMap(uint32 id, uint32 InstanceId, uint8 SpawnMode, Map* parent = nullptr);
    ~PartitionedMap() override;

    void Update(const uint32 t_diff, const uint32 s_diff, bool thread = true) override;
    bool AddPlayerToMap(Player* player) override;
    void RemovePlayerFromMap(Player* player, bool remove) override;
    void UnloadAll() override;
    [[nodiscard]] bool IsPartitioned() const override { return _partitioningEnabled; }

    void InitializePartitions();

    MapPartition* GetPartitionFor(float x, float y) const;
    MapPartition* GetPartitionFor(WorldObject* obj) const;
    MapPartition* GetPartition(uint32 partitionId) const;
    std::vector<MapPartition*> const& GetAllPartitions() const { return _partitions; }

    std::vector<MapPartition*> GetAdjacentPartitions(MapPartition* partition) const;
    std::vector<MapPartition*> GetAdjacentPartitions(MapPartition* partition, WorldObject* obj) const;

    void CheckEntityPartitionChange(WorldObject* obj, float oldX, float oldY, float newX, float newY);
    void DoForAllPartitions(std::function<void(MapPartition*)> exec);

    uint32 GetPartitionCountX() const { return _partitionCountX; }
    uint32 GetPartitionCountY() const { return _partitionCountY; }
    uint32 GetTotalPartitionCount() const { return _partitionCountX * _partitionCountY; }

    void PlayerRelocationNotify(Player* player, float oldX, float oldY, float newX, float newY);
    void CreatureRelocationNotify(Creature* creature, float oldX, float oldY, float newX, float newY);

    std::string GetDebugInfo() const override;
    void PrintPartitionStatistics() const;

private:
    void CreatePartitions();
    uint32 CalculatePartitionId(float x, float y) const;
    void GetPartitionGridCoords(uint32 partitionId, uint32& gridX, uint32& gridY) const;
    void MigrateEntity(WorldObject* obj, MapPartition* from, MapPartition* to);
    void UpdateSharedSystems(uint32 t_diff);
    void ProcessCrossPartitionVisibility();
    void ProcessPendingMigrations();
    [[nodiscard]] bool IsContinentMap() const;

    std::vector<MapPartition*> _partitions;
    uint32 _partitionCountX;
    uint32 _partitionCountY;
    
    float _mapMinX, _mapMaxX, _mapMinY, _mapMaxY;

    struct PendingMigration
    {
        WorldObject* entity;
        MapPartition* fromPartition;
        MapPartition* toPartition;
    };
    std::vector<PendingMigration> _pendingMigrations;
    std::mutex _migrationLock;

    mutable std::shared_mutex _partitionLock;
    std::unordered_map<WorldObject*, MapPartition*> _entityPartitionMap;
    mutable std::shared_mutex _entityMapLock;

    bool _partitioningEnabled;
    float _borderMargin;
};

#endif // ACORE_PARTITIONED_MAP_H
