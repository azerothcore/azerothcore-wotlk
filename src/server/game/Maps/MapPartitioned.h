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

class MapPartition : public Map
{
public:
    MapPartition(uint32 id, uint32 instanceId, uint8 spawnMode, Map* parent, uint8 partitionCount, uint8 partitionIndex)
        : Map(id, instanceId, spawnMode, parent), m_partitionCount(partitionCount), m_partitionIndex(partitionIndex) {}

    void ProcessCreatureRespawn(ObjectGuid::LowType spawnId) override;
    void ProcessGameObjectRespawn(ObjectGuid::LowType spawnId) override;

private:
    bool IsPositionInPartition(float x) const;
    uint32 GetPartitionIndex(float x) const;

    uint8 m_partitionCount;
    uint8 m_partitionIndex;
};

class MapPartitioned : public Map
{
public:
    using PartitionMap = std::vector<Map*>;

    MapPartitioned(uint32 id, uint8 partitionCount = 4);
    ~MapPartitioned() override;

    bool IsPartitioned() const override { return true; }

    void Update(const uint32 diff, const uint32 s_diff, bool thread = true) override;
    void DelayedUpdate(const uint32 diff) override;
    void OnCreateMap() override;
    void UnloadAll() override;
    void LoadRespawnTimes() override;
    EnterState CannotEnter(Player* player, bool loginCheck = false) override;
    bool AddPlayerToMap(Player* player) override;
    void RemovePlayerFromMap(Player* player, bool remove) override;
    void RemoveAllPlayers() override;

    Map* GetPartitionForPlayer(Player* player) const;
    Map* GetPartitionForPosition(float x, float y) const;
    uint32 GetPartitionCount() const { return m_partitionCount; }

    void InitVisibilityDistance() override;

    std::vector<Map*> const& GetPartitions() const { return m_Partitions; }

private:
    Map* CreatePartition(uint32 index);
    uint32 GetPartitionIndex(float x) const;

    uint32 m_partitionCount;
    PartitionMap m_Partitions;
};

#endif
