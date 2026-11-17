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

#include "MapPartitioned.h"
#include "MapUpdater.h"
#include "MapRefMgr.h"
#include "Player.h"
#include "Metric.h"
#include <algorithm>

PartitionLayout::PartitionLayout(uint32 gridsPerPartition, uint32 borderCells)
{
    _gridsPerPartition = std::clamp<uint32>(gridsPerPartition, 1, MAX_NUMBER_OF_GRIDS);
    _cellsPerPartition = _gridsPerPartition * MAX_NUMBER_OF_CELLS;
    _borderCells = std::min(borderCells, _cellsPerPartition);
    _partitionsPerSide = (MAX_NUMBER_OF_GRIDS + _gridsPerPartition - 1) / _gridsPerPartition;
}

uint32 PartitionLayout::GetPartitionIndex(CellCoord const& cell) const
{
    if (!cell.IsCoordValid())
        return INVALID_PARTITION;

    uint32 const partitionX = cell.x_coord / _cellsPerPartition;
    uint32 const partitionY = cell.y_coord / _cellsPerPartition;
    return partitionY * _partitionsPerSide + partitionX;
}

uint32 PartitionLayout::GetPartitionIndex(float x, float y) const
{
    if (!Acore::IsValidMapCoord(x, y))
        return INVALID_PARTITION;

    return GetPartitionIndex(Acore::ComputeCellCoord(x, y));
}

bool PartitionLayout::IsBorderCell(CellCoord const& cell) const
{
    if (!cell.IsCoordValid() || _partitionsPerSide == 1)
        return false;

    return IsBorderOnAxis(cell.x_coord) || IsBorderOnAxis(cell.y_coord);
}

bool PartitionLayout::IsBorderOnAxis(uint32 cellCoord) const
{
    if (!_borderCells)
        return false;

    uint32 const partition = cellCoord / _cellsPerPartition;
    uint32 const partitionStart = partition * _cellsPerPartition;
    uint32 const partitionEnd = partitionStart + _cellsPerPartition; // exclusive

    // Low edge is shared with the previous partition unless it is the map edge.
    if (partition > 0 && cellCoord < partitionStart + _borderCells)
        return true;

    // High edge is shared with the next partition unless this is the last (possibly narrower) one.
    if (partition + 1 < _partitionsPerSide && cellCoord >= partitionEnd - _borderCells)
        return true;

    return false;
}

MapPartitioned::MapPartitioned(uint32 id, PartitionLayout const& layout)
    : Map(id, 0, REGULAR_DIFFICULTY), _layout(layout), _inParallelPhase(false)
{
    uint32 const count = _layout.GetPartitionCount();
    _partitions.reserve(count);
    for (uint32 i = 0; i < count; ++i)
        _partitions.push_back(std::make_unique<MapPartition>(*this, i));
}

MapPartitioned::~MapPartitioned() = default;

MapPartition* MapPartitioned::GetPartition(uint32 index)
{
    if (index >= _partitions.size())
        return nullptr;

    return _partitions[index].get();
}

MapPartition* MapPartitioned::GetPartitionForCell(CellCoord const& cell)
{
    return GetPartition(_layout.GetPartitionIndex(cell));
}

void MapPartitioned::ForEachPartition(std::function<void(MapPartition&)> const& visitor)
{
    Map::ForEachPartition(visitor);
    for (std::unique_ptr<MapPartition>& partition : _partitions)
        visitor(*partition);
}

MapPartition& MapPartitioned::GetOwningPartition(WorldObject* /*object*/)
{
    return GetSerialSet();
}

void MapPartitioned::RebuildPartitionPlayers()
{
    ForEachPartition([](MapPartition& partition) { partition.GetPlayers().clear(); });

    for (MapRefMgr::iterator itr = m_mapRefMgr.begin(); itr != m_mapRefMgr.end(); ++itr)
        if (Player* player = itr->GetSource())
            GetOwningPartition(player).GetPlayers().push_back(player);
}

void MapPartitioned::PreUpdate(uint32 t_diff, uint32 /*s_diff*/)
{
    METRIC_TIMER("map_partition_pre_update_time_diff", METRIC_TAG("map_id", std::to_string(GetId())));

    RebuildPartitionPlayers();

    // Map-wide events may touch any entity: serial only.
    Events.Update(t_diff);

    if (!t_diff)
        return;

    UpdateRespawns(t_diff);
    ProcessScriptSchedule();

    // The marked-cells bitset spans partition borders, so it is only written here.
    IntervalTimer& recheckTimer = GetUpdatableObjectListRecheckTimer();
    recheckTimer.Update(t_diff);
    resetMarkedCells();
    if (recheckTimer.Passed())
        for (MapRefMgr::iterator itr = m_mapRefMgr.begin(); itr != m_mapRefMgr.end(); ++itr)
            if (Player* player = itr->GetSource())
                if (player->IsInWorld())
                    MarkNearbyCellsOfPlayer(player);
}

void MapPartitioned::SchedulePartitions(MapUpdater& updater, uint32 t_diff, uint32 s_diff)
{
    _inParallelPhase.store(true, std::memory_order_release);

    // Fan out one task per populated partition. The serial set is never scheduled:
    // it is updated on the world thread in PostUpdate.
    for (std::unique_ptr<MapPartition>& partition : _partitions)
    {
        if (partition->IsEmpty())
            continue;

        if (updater.activated())
            updater.schedule_partition_update(*partition, t_diff, s_diff);
        else
        {
            MapPartition::Scope scope(*partition);
            partition->Update(t_diff, s_diff);
        }
    }
}

void MapPartitioned::PostUpdate(uint32 t_diff, uint32 s_diff)
{
    // Called after MapUpdater::wait(): every partition task of this map has finished.
    _inParallelPhase.store(false, std::memory_order_release);

    METRIC_TIMER("map_partition_post_update_time_diff", METRIC_TAG("map_id", std::to_string(GetId())));

    // Border-strip and cross-partition-linked entities, on the world thread.
    {
        MapPartition& serialSet = GetSerialSet();
        MapPartition::Scope scope(serialSet);
        serialSet.Update(t_diff, s_diff);
    }

    // Shared mutations deferred by the partitions (grid loads needed by cell moves included).
    ForEachPartition([this](MapPartition& partition) { ApplyPartitionOutbox(partition); });

    if (!t_diff)
    {
        HandleDelayedVisibility();
        return;
    }

    IntervalTimer& recheckTimer = GetUpdatableObjectListRecheckTimer();
    if (recheckTimer.Passed())
        recheckTimer.Reset();

    // Same order as Map::Update: packets, cell moves, then visibility.
    SendObjectUpdates();
    ProcessCellMoves();
    HandleDelayedVisibility();

    _mapCollisionData.GetDynamicTree().update(t_diff);

    FinishTick(t_diff);
}
