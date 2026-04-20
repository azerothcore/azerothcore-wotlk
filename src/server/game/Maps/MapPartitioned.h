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

#ifndef ACORE_MAP_PARTITIONED_H
#define ACORE_MAP_PARTITIONED_H

#include "Map.h"
#include <vector>
#include <mutex>
#include <atomic>

class MapPartitioned : public Map
{
public:
    static constexpr uint32 PARTITION_GRID_SIZE = 16;
    static constexpr uint32 NUM_PARTITIONS = (TOTAL_NUMBER_OF_CELLS_PER_MAP / PARTITION_GRID_SIZE) * (TOTAL_NUMBER_OF_CELLS_PER_MAP / PARTITION_GRID_SIZE);

    explicit MapPartitioned(uint32 id);
    ~MapPartitioned() override;

    void Update(const uint32 t_diff, const uint32 s_diff, bool thread = true) override;
    void DelayedUpdate(const uint32 diff) override;
    void UnloadAll() override;

    bool AddPlayerToMap(Player*) override;
    void RemovePlayerFromMap(Player*, bool) override;
    void AfterPlayerUnlinkFromMap() override;

    uint32 GetPartitionId(float x, float y) const;
    uint32 GetPartitionId(Cell const& cell) const;
    bool HasPartition(uint32 partitionId) const;

    void RemoveAllPlayers() override;

    // Partition management
    Map* GetPartition(uint32 partitionId) const;
    void UpdatePartition(uint32 partitionId, const uint32 t_diff, const uint32 s_diff, bool thread);

    // Broadcast to all partitions
    void BroadcastToAllPartitions(WorldPacket const* data) const;

    uint32 GetNumPartitions() const { return NUM_PARTITIONS; }

private:
    void CreatePartitions();
    void DestroyPartitions();
    Map* CreatePartitionMap(uint32 partitionId);

    std::array<Map*, NUM_PARTITIONS> _partitions;
    std::atomic<uint32> _activePartitions{0};
    mutable std::mutex _partitionLock;

    // Partition grid bounds
    struct PartitionBounds
    {
        uint32 partitionId;
        uint32 gridStartX;
        uint32 gridEndX;
        uint32 gridStartY;
        uint32 gridEndY;
    };

    static PartitionBounds GetPartitionBounds(uint32 partitionId);
    bool IsPositionInPartition(float x, float y, uint32 partitionId) const;
};

#endif // ACORE_MAP_PARTITIONED_H