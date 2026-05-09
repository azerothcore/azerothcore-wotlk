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
#include <vector>

// Forward declaration
struct GridCoord;

// Represents a rectangular partition of a map's grid space.
// Each partition covers a contiguous block of grids that can be
// updated independently in parallel.
struct MapPartition
{
    uint32 id;
    uint32 startGridX, startGridY;  // inclusive
    uint32 endGridX, endGridY;      // exclusive

    [[nodiscard]] bool ContainsGrid(uint32 gx, uint32 gy) const
    {
        return gx >= startGridX && gx < endGridX &&
               gy >= startGridY && gy < endGridY;
    }
};

// Manages partition layout for a map. Divides the MAX_NUMBER_OF_GRIDS × MAX_NUMBER_OF_GRIDS
// grid into N×N rectangular partitions, each of size gridsPerPartition × gridsPerPartition.
class MapPartitionManager
{
public:
    MapPartitionManager() = default;

    // Initialize partitions. gridsPerPartition controls partition size.
    // A value of 0 disables partitioning.
    void Initialize(uint32 gridsPerPartition);

    [[nodiscard]] uint32 GetPartitionCount() const { return static_cast<uint32>(_partitions.size()); }
    [[nodiscard]] uint32 GetPartitionForGrid(uint32 gridX, uint32 gridY) const;
    [[nodiscard]] uint32 GetPartitionForPosition(float x, float y) const;
    [[nodiscard]] MapPartition const& GetPartition(uint32 id) const { return _partitions[id]; }
    [[nodiscard]] bool IsEnabled() const { return _enabled; }
    [[nodiscard]] uint32 GetPartitionsPerAxis() const { return _partitionsPerAxis; }

private:
    std::vector<MapPartition> _partitions;
    uint32 _gridsPerPartition{0};
    uint32 _partitionsPerAxis{0};
    bool _enabled{false};
};

#endif // ACORE_MAP_PARTITION_H
