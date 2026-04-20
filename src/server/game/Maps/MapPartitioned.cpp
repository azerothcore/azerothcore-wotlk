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
#include "GridDefines.h"
#include "Log.h"
#include "MapMgr.h"
#include "Player.h"
#include "WorldPacket.h"
#include "MapGrid.h"

MapPartitioned::MapPartitioned(uint32 id) : Map(id, 0, REGULAR_DIFFICULTY, this)
{
    _partitions.fill(nullptr);
    CreatePartitions();
}

MapPartitioned::~MapPartitioned()
{
    DestroyPartitions();
}

MapPartitioned::PartitionBounds MapPartitioned::GetPartitionBounds(uint32 partitionId)
{
    PartitionBounds bounds;

    uint32 const partitionGridDim = TOTAL_NUMBER_OF_CELLS_PER_MAP / PARTITION_GRID_SIZE;

    uint32 const row = partitionId / partitionGridDim;
    uint32 const col = partitionId % partitionGridDim;

    bounds.partitionId = partitionId;
    bounds.gridStartX = col * PARTITION_GRID_SIZE;
    bounds.gridEndX = bounds.gridStartX + PARTITION_GRID_SIZE;
    bounds.gridStartY = row * PARTITION_GRID_SIZE;
    bounds.gridEndY = bounds.gridStartY + PARTITION_GRID_SIZE;

    return bounds;
}

bool MapPartitioned::IsPositionInPartition(float x, float y, uint32 partitionId) const
{
    GridCoord gridCoord = Acore::ComputeGridCoord(x, y);
    uint32 gridX = gridCoord.x_coord;
    uint32 gridY = gridCoord.y_coord;

    PartitionBounds bounds = GetPartitionBounds(partitionId);
    return (gridX >= bounds.gridStartX && gridX < bounds.gridEndX &&
            gridY >= bounds.gridStartY && gridY < bounds.gridEndY);
}

uint32 MapPartitioned::GetPartitionId(float x, float y) const
{
    GridCoord gridCoord = Acore::ComputeGridCoord(x, y);
    uint32 gridX = gridCoord.x_coord;
    uint32 gridY = gridCoord.y_coord;

    return (gridY / PARTITION_GRID_SIZE) * (TOTAL_NUMBER_OF_CELLS_PER_MAP / PARTITION_GRID_SIZE) + (gridX / PARTITION_GRID_SIZE);
}

uint32 MapPartitioned::GetPartitionId(Cell const& cell) const
{
    return GetPartitionId(cell.CellX(), cell.CellY());
}

bool MapPartitioned::HasPartition(uint32 partitionId) const
{
    return partitionId < NUM_PARTITIONS && _partitions[partitionId] != nullptr;
}

Map* MapPartitioned::GetPartition(uint32 partitionId) const
{
    if (partitionId >= NUM_PARTITIONS)
        return nullptr;

    std::lock_guard<std::mutex> lock(_partitionLock);
    return _partitions[partitionId];
}

void MapPartitioned::CreatePartitions()
{
    for (uint32 i = 0; i < NUM_PARTITIONS; ++i)
    {
        _partitions[i] = CreatePartitionMap(i);
    }
    _activePartitions.store(NUM_PARTITIONS);

    LOG_INFO("maps", "MapPartitioned::CreatePartitions: Created %u partitions for continent map %u", NUM_PARTITIONS, GetId());
}

void MapPartitioned::DestroyPartitions()
{
    std::lock_guard<std::mutex> lock(_partitionLock);

    for (uint32 i = 0; i < NUM_PARTITIONS; ++i)
    {
        if (_partitions[i])
        {
            _partitions[i]->UnloadAll();
            delete _partitions[i];
            _partitions[i] = nullptr;
        }
    }

    _activePartitions.store(0);
}

Map* MapPartitioned::CreatePartitionMap(uint32 partitionId)
{
    return new Map(GetId(), partitionId + 1, REGULAR_DIFFICULTY, this);
}

void MapPartitioned::Update(const uint32 t_diff, const uint32 s_diff, bool thread)
{
    for (uint32 i = 0; i < NUM_PARTITIONS; ++i)
    {
        if (_partitions[i])
        {
            _partitions[i]->Update(t_diff, s_diff, thread);
        }
    }
}

void MapPartitioned::UpdatePartition(uint32 partitionId, const uint32 t_diff, const uint32 s_diff, bool thread)
{
    if (partitionId < NUM_PARTITIONS && _partitions[partitionId])
    {
        _partitions[partitionId]->Update(t_diff, s_diff, thread);
    }
}

void MapPartitioned::DelayedUpdate(const uint32 diff)
{
    for (uint32 i = 0; i < NUM_PARTITIONS; ++i)
    {
        if (_partitions[i])
        {
            _partitions[i]->DelayedUpdate(diff);
        }
    }
}

void MapPartitioned::UnloadAll()
{
    for (uint32 i = 0; i < NUM_PARTITIONS; ++i)
    {
        if (_partitions[i])
        {
            _partitions[i]->UnloadAll();
        }
    }
}

bool MapPartitioned::AddPlayerToMap(Player* player)
{
    uint32 partitionId = GetPartitionId(player->GetPositionX(), player->GetPositionY());

    if (partitionId >= NUM_PARTITIONS)
    {
        LOG_ERROR("maps", "MapPartitioned::AddPlayerToMap: Player %s at invalid position (%f, %f) for map %u",
            player->GetName().c_str(), player->GetPositionX(), player->GetPositionY(), GetId());
        return false;
    }

    std::lock_guard<std::mutex> lock(_partitionLock);

    if (!_partitions[partitionId])
    {
        _partitions[partitionId] = CreatePartitionMap(partitionId);
    }

    return _partitions[partitionId]->AddPlayerToMap(player);
}

void MapPartitioned::RemovePlayerFromMap(Player* player, bool remove)
{
    uint32 partitionId = GetPartitionId(player->GetPositionX(), player->GetPositionY());

    if (partitionId < NUM_PARTITIONS && _partitions[partitionId])
    {
        _partitions[partitionId]->RemovePlayerFromMap(player, remove);
    }
}

void MapPartitioned::AfterPlayerUnlinkFromMap()
{
}

void MapPartitioned::RemoveAllPlayers()
{
    std::lock_guard<std::mutex> lock(_partitionLock);

    for (uint32 i = 0; i < NUM_PARTITIONS; ++i)
    {
        if (_partitions[i])
        {
            _partitions[i]->RemoveAllPlayers();
        }
    }
}

void MapPartitioned::BroadcastToAllPartitions(WorldPacket const* data) const
{
    std::lock_guard<std::mutex> lock(_partitionLock);

    for (uint32 i = 0; i < NUM_PARTITIONS; ++i)
    {
        if (_partitions[i])
        {
            _partitions[i]->SendToPlayers(data);
        }
    }
}