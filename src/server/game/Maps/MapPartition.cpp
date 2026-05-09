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
#include "Log.h"
#include <algorithm>

void MapPartitionManager::Initialize(uint32 gridsPerPartition)
{
    _partitions.clear();
    _enabled = false;

    if (gridsPerPartition == 0 || gridsPerPartition >= MAX_NUMBER_OF_GRIDS)
        return;

    _gridsPerPartition = gridsPerPartition;
    _partitionsPerAxis = (MAX_NUMBER_OF_GRIDS + gridsPerPartition - 1) / gridsPerPartition;

    // Need at least 2×2 partitions for parallelism to be worthwhile
    if (_partitionsPerAxis <= 1)
        return;

    for (uint32 py = 0; py < _partitionsPerAxis; ++py)
    {
        for (uint32 px = 0; px < _partitionsPerAxis; ++px)
        {
            MapPartition partition;
            partition.id = py * _partitionsPerAxis + px;
            partition.startGridX = px * gridsPerPartition;
            partition.startGridY = py * gridsPerPartition;
            partition.endGridX = std::min((px + 1) * gridsPerPartition,
                                         static_cast<uint32>(MAX_NUMBER_OF_GRIDS));
            partition.endGridY = std::min((py + 1) * gridsPerPartition,
                                         static_cast<uint32>(MAX_NUMBER_OF_GRIDS));
            _partitions.push_back(partition);
        }
    }

    _enabled = true;

    LOG_INFO("maps", "MapPartitionManager: Initialized {} partitions "
             "({}x{}, {} grids per partition)",
             _partitions.size(), _partitionsPerAxis, _partitionsPerAxis,
             gridsPerPartition);
}

uint32 MapPartitionManager::GetPartitionForGrid(uint32 gridX, uint32 gridY) const
{
    if (!_enabled)
        return 0;

    uint32 px = std::min(gridX / _gridsPerPartition, _partitionsPerAxis - 1);
    uint32 py = std::min(gridY / _gridsPerPartition, _partitionsPerAxis - 1);
    return py * _partitionsPerAxis + px;
}

uint32 MapPartitionManager::GetPartitionForPosition(float x, float y) const
{
    if (!_enabled)
        return 0;

    CellCoord cellCoord = Acore::ComputeCellCoord(x, y);
    uint32 gridX = cellCoord.x_coord / MAX_NUMBER_OF_CELLS;
    uint32 gridY = cellCoord.y_coord / MAX_NUMBER_OF_CELLS;
    return GetPartitionForGrid(gridX, gridY);
}
