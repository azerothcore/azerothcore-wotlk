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
#include <unordered_set>
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
 * MapMgr creates it for the maps in MapPartitioning.Maps when MapPartitioning.Enable is set.
 *
 * Entity ownership: an entity belongs to the geometric partition of its cell, or to the serial
 * set when it is in a border cell, on a transport, zone-wide visible, pinned, or linked (combat,
 * pet/owner, charm, vehicle, shared vision, far sight, duel, formation, periodic aura caster) to
 * an entity outside its partition. PreUpdate recomputes ownership and hands entities over.
 *
 * Until the shared stores are thread-safe (PLAN.md Step 5) the partitions are updated one after
 * another on the world thread, not on MapUpdater workers.
 */
class MapPartitioned : public Map
{
public:
    MapPartitioned(uint32 id, PartitionLayout const& layout, bool debugOwnershipChecks = false);
    ~MapPartitioned() override;

    MapPartitioned* ToMapPartitioned() override { return this; }
    [[nodiscard]] MapPartitioned const* ToMapPartitioned() const override { return this; }

    [[nodiscard]] PartitionLayout const& GetLayout() const { return _layout; }
    [[nodiscard]] uint32 GetPartitionCount() const { return uint32(_partitions.size()); }

    // nullptr for an out-of-range index / invalid coordinate.
    MapPartition* GetPartition(uint32 index);
    // Geometric partition of a cell. Assigning an entity to the serial set is the ownership pass's job (Step 4).
    MapPartition* GetPartitionForCell(CellCoord const& cell);
    // The serial set is the map's default partition (see Map::GetDefaultPartition).
    MapPartition& GetSerialSet() { return GetDefaultPartition(); }

    [[nodiscard]] bool IsInParallelPhase() const { return _inParallelPhase.load(std::memory_order_acquire); }

    // Fork-Join tick phases, driven by MapMgr::Update on the world thread:
    //   PreUpdate -> SchedulePartitions -> MapUpdater::wait() -> PostUpdate.
    // Map::Update is not used for a partitioned map.
    void PreUpdate(uint32 t_diff, uint32 s_diff);
    void SchedulePartitions(MapUpdater& updater, uint32 t_diff, uint32 s_diff);
    void PostUpdate(uint32 t_diff, uint32 s_diff);

    void ForEachPartition(std::function<void(MapPartition&)> const& visitor) override;
    MapPartition& GetOwnerForNewObject(WorldObject* obj) override;

    // Owner an entity should have now (geometric partition or serial set), see the class comment.
    MapPartition& ComputeOwner(WorldObject* obj);

    // Keeps an entity in the serial set regardless of position (e.g. scripts with map-wide reach).
    void PinToSerialSet(ObjectGuid guid) { _pinnedToSerialSet.insert(guid); }
    void UnpinFromSerialSet(ObjectGuid guid) { _pinnedToSerialSet.erase(guid); }
    [[nodiscard]] bool IsPinnedToSerialSet(ObjectGuid guid) const { return _pinnedToSerialSet.contains(guid); }

private:
    // PRE-UPDATE ownership pass: players every tick (their tick vectors are rebuilt), updatable
    // objects on full ticks; entities whose owner changed are handed over to the new partition.
    void ReassignOwnership(bool includeUpdatableObjects);
    // Geometric partition index of an object's cell, or INVALID_PARTITION for a border cell,
    // an invalid position, or an object that isn't in this map (when requireInWorld).
    uint32 GetPositionalPartitionIndex(WorldObject const* obj, bool requireInWorld) const;
    template<class Visitor> void ForEachLinkPartner(WorldObject* obj, Visitor&& visitor);

    PartitionLayout const _layout;
    std::vector<std::unique_ptr<MapPartition>> _partitions;
    std::atomic<bool> _inParallelPhase;
    std::unordered_set<ObjectGuid> _pinnedToSerialSet;
};

#endif // ACORE_MAP_PARTITIONED_H
