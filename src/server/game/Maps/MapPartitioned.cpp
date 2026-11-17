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
    : Map(id, 0, REGULAR_DIFFICULTY), _layout(layout),
    _serialSet(*this, MapPartition::SERIAL_SET_INDEX), _inParallelPhase(false)
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

void MapPartitioned::PreUpdate(uint32 /*t_diff*/, uint32 /*s_diff*/)
{
    // Step 1: nothing to do. The serial PRE-UPDATE work still runs inside Map::Update.
}

void MapPartitioned::SchedulePartitions(MapUpdater& updater, uint32 t_diff, uint32 s_diff)
{
    // Step 1: the whole map is one task, exactly as MapMgr::Update schedules a plain Map today.
    if (updater.activated())
        updater.schedule_update(*this, t_diff, s_diff);
    else
        Update(t_diff, s_diff);
}

void MapPartitioned::PostUpdate(uint32 /*t_diff*/, uint32 /*s_diff*/)
{
    // Step 1: nothing to do. The serial POST-UPDATE work still runs inside Map::Update.
}
