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

#include "PartitionedMap.h"
#include "MapMgr.h"
#include "Player.h"
#include "Creature.h"
#include "GameObject.h"
#include "World.h"
#include "Log.h"
#include "Config.h"
#include <sstream>

constexpr float CONTINENT_MAP_BOUNDS[][4] = {
    { -17066.666f, 17066.666f, -17066.666f, 17066.666f },
    { -17066.666f, 17066.666f, -17066.666f, 17066.666f },
    { -17066.666f, 17066.666f, -17066.666f, 17066.666f },
    { -17066.666f, 17066.666f, -17066.666f, 17066.666f }
};

PartitionedMap::PartitionedMap(uint32 id, uint32 InstanceId, uint8 SpawnMode, Map* parent)
    : Map(id, InstanceId, SpawnMode, parent),
      _partitionCountX(0), _partitionCountY(0),
      _mapMinX(0.0f), _mapMaxX(0.0f), _mapMinY(0.0f), _mapMaxY(0.0f),
      _partitioningEnabled(false), _borderMargin(100.0f)
{
    _partitioningEnabled = sConfigMgr->GetOption<bool>("MapPartitioning.Enable", false);

    if (_partitioningEnabled && IsContinentMap())
        LOG_INFO("maps.partition", "Map {} split into partitions", id);
}

PartitionedMap::~PartitionedMap()
{
    for (MapPartition* partition : _partitions)
        delete partition;

    _partitions.clear();
    _entityPartitionMap.clear();
}

bool PartitionedMap::IsContinentMap() const
{
    uint32 mapId = GetId();
    return (mapId == 0 || mapId == 1 || mapId == 530 || mapId == 571);
}

void PartitionedMap::InitializePartitions()
{
    if (!_partitioningEnabled || !IsContinentMap())
        return;

    uint32 gridSize = sConfigMgr->GetOption<uint32>("MapPartitioning.GridSize", 4);
    _partitionCountX = gridSize;
    _partitionCountY = gridSize;
    _borderMargin = sConfigMgr->GetOption<float>("MapPartitioning.BorderMargin", 100.0f);

    uint32 mapId = GetId();
    uint32 boundsIndex = 0;
    if (mapId == 0) boundsIndex = 0;
    else if (mapId == 1) boundsIndex = 1;
    else if (mapId == 530) boundsIndex = 2;
    else if (mapId == 571) boundsIndex = 3;

    _mapMinX = CONTINENT_MAP_BOUNDS[boundsIndex][0];
    _mapMaxX = CONTINENT_MAP_BOUNDS[boundsIndex][1];
    _mapMinY = CONTINENT_MAP_BOUNDS[boundsIndex][2];
    _mapMaxY = CONTINENT_MAP_BOUNDS[boundsIndex][3];

    CreatePartitions();

    LOG_INFO("maps.partition", "Map {}: {} partitions ({}x{})",
        mapId, GetTotalPartitionCount(), _partitionCountX, _partitionCountY);
}

void PartitionedMap::CreatePartitions()
{
    std::lock_guard<std::shared_mutex> guard(_partitionLock);

    float partitionWidth = (_mapMaxX - _mapMinX) / _partitionCountX;
    float partitionHeight = (_mapMaxY - _mapMinY) / _partitionCountY;

    uint32 partitionId = 0;
    for (uint32 y = 0; y < _partitionCountY; ++y)
    {
        for (uint32 x = 0; x < _partitionCountX; ++x)
        {
            PartitionBounds bounds(
                _mapMinX + (x * partitionWidth),
                _mapMinX + ((x + 1) * partitionWidth),
                _mapMinY + (y * partitionHeight),
                _mapMinY + ((y + 1) * partitionHeight)
            );

            _partitions.push_back(new MapPartition(this, partitionId++, bounds));
        }
    }
}

uint32 PartitionedMap::CalculatePartitionId(float x, float y) const
{
    if (x < _mapMinX || x >= _mapMaxX || y < _mapMinY || y >= _mapMaxY)
        return 0;

    float normalizedX = (x - _mapMinX) / (_mapMaxX - _mapMinX);
    float normalizedY = (y - _mapMinY) / (_mapMaxY - _mapMinY);

    uint32 gridX = static_cast<uint32>(normalizedX * _partitionCountX);
    uint32 gridY = static_cast<uint32>(normalizedY * _partitionCountY);

    if (gridX >= _partitionCountX) gridX = _partitionCountX - 1;
    if (gridY >= _partitionCountY) gridY = _partitionCountY - 1;

    return gridY * _partitionCountX + gridX;
}

void PartitionedMap::GetPartitionGridCoords(uint32 partitionId, uint32& gridX, uint32& gridY) const
{
    gridY = partitionId / _partitionCountX;
    gridX = partitionId % _partitionCountX;
}

MapPartition* PartitionedMap::GetPartitionFor(float x, float y) const
{
    if (!IsPartitioned())
        return nullptr;

    return GetPartition(CalculatePartitionId(x, y));
}

MapPartition* PartitionedMap::GetPartitionFor(WorldObject* obj) const
{
    if (!obj || !IsPartitioned())
        return nullptr;

    {
        std::shared_lock<std::shared_mutex> lock(_entityMapLock);
        auto it = _entityPartitionMap.find(obj);
        if (it != _entityPartitionMap.end())
            return it->second;
    }

MapPartition* PartitionedMap::GetPartition(uint32 partitionId) const
{
    std::shared_lock<std::shared_mutex> lock(_partitionLock);
    return partitionId < _partitions.size() ? _partitions[partitionId] : nullptr;
}

std::vector<MapPartition*> PartitionedMap::GetAdjacentPartitions(MapPartition* partition) const
{
    std::vector<MapPartition*> adjacent;
    if (!partition)
        return adjacent;

    uint32 centerGridX, centerGridY;
    GetPartitionGridCoords(partition->GetPartitionId(), centerGridX, centerGridY);

    for (int32 dy = -1; dy <= 1; ++dy)
    {
        for (int32 dx = -1; dx <= 1; ++dx)
        {
            if (dx == 0 && dy == 0)
                continue;

            int32 adjX = static_cast<int32>(centerGridX) + dx;
            int32 adjY = static_cast<int32>(centerGridY) + dy;

            if (adjX >= 0 && adjX < static_cast<int32>(_partitionCountX) &&
                adjY >= 0 && adjY < static_cast<int32>(_partitionCountY))
            {
                uint32 adjPartitionId = adjY * _partitionCountX + adjX;
                if (MapPartition* adjPartition = GetPartition(adjPartitionId))
                    adjacent.push_back(adjPartition);
            }
        }
    }

    return adjacent;
}

std::vector<MapPartition*> PartitionedMap::GetAdjacentPartitions(MapPartition* partition, WorldObject* obj) const
{
    return GetAdjacentPartitions(partition);
}

void PartitionedMap::Update(const uint32 t_diff, const uint32 s_diff, bool thread)
{
    if (!IsPartitioned())
    {
        Map::Update(t_diff, s_diff, thread);
        return;
    }

    UpdateSharedSystems(t_diff);

    if (thread && sMapMgr->GetMapUpdater()->activated())
    {
        for (MapPartition* partition : _partitions)
            sMapMgr->GetMapUpdater()->schedule_partition_update(*partition, t_diff, s_diff);

        sMapMgr->GetMapUpdater()->wait();
    }
    else
    {
        for (MapPartition* partition : _partitions)
            partition->Update(t_diff, s_diff);
    }

    if (t_diff)
        ProcessCrossPartitionVisibility();

    ProcessPendingMigrations();
    HandleDelayedVisibility();
}

void PartitionedMap::UpdateSharedSystems(uint32 t_diff)
{
    if (t_diff)
    {
        _dynamicTree.update(t_diff);
        UpdateWeather(t_diff);
        UpdateExpiredCorpses(t_diff);
        sScriptMgr->OnMapUpdate(this, t_diff);
    }

    Events.Update(t_diff);
}

void PartitionedMap::ProcessCrossPartitionVisibility()
{
    for (MapPartition* partition : _partitions)
    {
        std::vector<WorldObject*> borderEntities = partition->GetBorderEntities();
        if (borderEntities.empty())
            continue;

        std::vector<MapPartition*> adjacentPartitions = GetAdjacentPartitions(partition);
        
        for (WorldObject* obj : borderEntities)
        {
            if (!obj || !obj->IsInWorld())
                continue;

            for (MapPartition* adjPartition : adjacentPartitions)
            {
                if (!adjPartition)
                    continue;

                obj->UpdateObjectVisibility(false, false);
            }
        }
    }
}

void PartitionedMap::ProcessPendingMigrations()
{
    std::lock_guard<std::mutex> guard(_migrationLock);

    for (const PendingMigration& migration : _pendingMigrations)
        MigrateEntity(migration.entity, migration.fromPartition, migration.toPartition);

    _pendingMigrations.clear();
}

void PartitionedMap::CheckEntityPartitionChange(WorldObject* obj, float oldX, float oldY, float newX, float newY)
{
    if (!obj || !IsPartitioned())
        return;

    MapPartition* oldPartition = GetPartitionFor(oldX, oldY);
    MapPartition* newPartition = GetPartitionFor(newX, newY);

    if (oldPartition != newPartition && newPartition != nullptr)
    {
        std::lock_guard<std::mutex> guard(_migrationLock);
        _pendingMigrations.push_back({obj, oldPartition, newPartition});
    }
}

void PartitionedMap::MigrateEntity(WorldObject* obj, MapPartition* from, MapPartition* to)
{
    if (!obj || !to)
        return;

    if (from && from->GetPartitionId() < to->GetPartitionId())
    {
        from->RemoveEntity(obj);
        to->AddEntity(obj);
    }
    else
    {
        to->AddEntity(obj);
        if (from)
            from->RemoveEntity(obj);
    }

    {
        std::lock_guard<std::shared_mutex> lock(_entityMapLock);
        _entityPartitionMap[obj] = to;
    }
}

bool PartitionedMap::AddPlayerToMap(Player* player)
{
    if (!Map::AddPlayerToMap(player))
        return false;

    if (IsPartitioned())
    {
        if (MapPartition* partition = GetPartitionFor(player->GetPositionX(), player->GetPositionY()))
        {
            partition->AddEntity(player);
            
            std::lock_guard<std::shared_mutex> lock(_entityMapLock);
            _entityPartitionMap[player] = partition;
        }
    }

    return true;
}

void PartitionedMap::RemovePlayerFromMap(Player* player, bool remove)
{
    if (IsPartitioned())
    {
        if (MapPartition* partition = GetPartitionFor(player))
        {
            partition->RemoveEntity(player);
            
            std::lock_guard<std::shared_mutex> lock(_entityMapLock);
            _entityPartitionMap.erase(player);
        }
    }

    Map::RemovePlayerFromMap(player, remove);
}

void PartitionedMap::PlayerRelocationNotify(Player* player, float oldX, float oldY, float newX, float newY)
{
    CheckEntityPartitionChange(player, oldX, oldY, newX, newY);
}

void PartitionedMap::CreatureRelocationNotify(Creature* creature, float oldX, float oldY, float newX, float newY)
{
    CheckEntityPartitionChange(creature, oldX, oldY, newX, newY);
}

void PartitionedMap::DoForAllPartitions(std::function<void(MapPartition*)> exec)
{
    std::shared_lock<std::shared_mutex> lock(_partitionLock);
    for (MapPartition* partition : _partitions)
        exec(partition);
}

void PartitionedMap::UnloadAll()
{
    if (IsPartitioned())
    {
        std::lock_guard<std::shared_mutex> guard(_partitionLock);
        for (MapPartition* partition : _partitions)
            delete partition;
        _partitions.clear();
    }

    _entityPartitionMap.clear();
    Map::UnloadAll();
}

std::string PartitionedMap::GetDebugInfo() const
{
    std::ostringstream info;
    info << Map::GetDebugInfo();
    
    if (IsPartitioned())
    {
        info << "\nPartitioned: Yes (" << GetTotalPartitionCount() << " partitions, "
             << _partitionCountX << "x" << _partitionCountY << " grid)";
        
        uint32 totalEntities = 0;
        for (const MapPartition* partition : _partitions)
            totalEntities += partition->GetEntityCount();

        info << "\nTotal entities in partitions: " << totalEntities;
    }
    else
        info << "\nPartitioned: No";

    return info.str();
}

void PartitionedMap::PrintPartitionStatistics() const
{
    if (!IsPartitioned())
        return;

    LOG_INFO("maps.partition", "Map {} partitions:", GetId());

    for (const MapPartition* partition : _partitions)
    {
        LOG_INFO("maps.partition", "  [{}] {} players, {} creatures, {} objects",
            partition->GetPartitionId(),
            partition->GetPlayerCount(),
            partition->GetCreatureCount(),
            partition->GetGameObjectCount());
    }
}
