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

#include "GridDefines.h"
#include "Map.h"
#include "MapPartition.h"
#include <atomic>
#include <memory>
#include <vector>

class MapUpdater;

/*
 * PartitionLayout
 *
 * Static square tiling of the map's cell space into partitions of
 * GridsPerPartition x GridsPerPartition grids. Ownership is resolved per cell.
 * When MAX_NUMBER_OF_GRIDS isn't divisible by GridsPerPartition, the last row
 * and column of partitions are narrower.
 *
 * A cell is a border cell when it is within BorderCells cells of an edge shared
 * with another partition. Map edges are not partition edges. Entities in border
 * cells belong to the serial set, so every interaction of range <= BorderCells
 * cells stays on one thread (PLAN.md section 3.2).
 */
class PartitionLayout
{
public:
    static constexpr uint32 DEFAULT_GRIDS_PER_PARTITION = 8;
    static constexpr uint32 DEFAULT_BORDER_CELLS = 2;
    static constexpr uint32 INVALID_PARTITION = 0xFFFFFFFF;

    // gridsPerPartition is clamped to [1, MAX_NUMBER_OF_GRIDS],
    // borderCells to [0, cells per partition].
    explicit PartitionLayout(uint32 gridsPerPartition = DEFAULT_GRIDS_PER_PARTITION,
        uint32 borderCells = DEFAULT_BORDER_CELLS);

    [[nodiscard]] uint32 GetGridsPerPartition() const { return _gridsPerPartition; }
    [[nodiscard]] uint32 GetCellsPerPartition() const { return _cellsPerPartition; }
    [[nodiscard]] uint32 GetBorderCells() const { return _borderCells; }
    [[nodiscard]] uint32 GetPartitionsPerSide() const { return _partitionsPerSide; }
    [[nodiscard]] uint32 GetPartitionCount() const { return _partitionsPerSide * _partitionsPerSide; }

    // Partition index (row-major on cell x/y) or INVALID_PARTITION for an invalid coordinate.
    [[nodiscard]] uint32 GetPartitionIndex(CellCoord const& cell) const;
    [[nodiscard]] uint32 GetPartitionIndex(float x, float y) const;

    // False for invalid coordinates and for layouts with a single partition.
    [[nodiscard]] bool IsBorderCell(CellCoord const& cell) const;

private:
    [[nodiscard]] bool IsBorderOnAxis(uint32 cellCoord) const;

    uint32 _gridsPerPartition;
    uint32 _cellsPerPartition;
    uint32 _borderCells;
    uint32 _partitionsPerSide;
};

/*
 * MapPartitioned
 *
 * Non-instanced continent map whose tick is split into a Fork-Join cycle:
 *   PreUpdate (serial, world thread)
 *   -> SchedulePartitions (one PartitionUpdateRequest per populated partition)
 *   -> PostUpdate (serial, world thread, after MapUpdater::wait()).
 *
 * Step 1 scaffolding: the phases forward to the existing Map::Update
 * behaviour and nothing constructs this class yet (MapMgr wiring is Step 2).
 */
class MapPartitioned : public Map
{
public:
    MapPartitioned(uint32 id, PartitionLayout const& layout);
    ~MapPartitioned() override;

    MapPartitioned* ToMapPartitioned() override { return this; }
    [[nodiscard]] MapPartitioned const* ToMapPartitioned() const override { return this; }

    [[nodiscard]] PartitionLayout const& GetLayout() const { return _layout; }
    [[nodiscard]] uint32 GetPartitionCount() const { return uint32(_partitions.size()); }

    // nullptr for an out-of-range index / invalid coordinate.
    MapPartition* GetPartition(uint32 index);
    // Geometric partition of a cell. Assigning an entity to the serial set is the ownership pass's job (Step 4).
    MapPartition* GetPartitionForCell(CellCoord const& cell);
    MapPartition& GetSerialSet() { return _serialSet; }

    [[nodiscard]] bool IsInParallelPhase() const { return _inParallelPhase.load(std::memory_order_acquire); }

    // Fork-Join tick phases. Step 1: forward to the existing single-threaded Map::Update.
    void PreUpdate(uint32 t_diff, uint32 s_diff);
    void SchedulePartitions(MapUpdater& updater, uint32 t_diff, uint32 s_diff);
    void PostUpdate(uint32 t_diff, uint32 s_diff);

private:
    PartitionLayout const _layout;
    std::vector<std::unique_ptr<MapPartition>> _partitions;
    MapPartition _serialSet;
    std::atomic<bool> _inParallelPhase;
};

#endif // ACORE_MAP_PARTITIONED_H
