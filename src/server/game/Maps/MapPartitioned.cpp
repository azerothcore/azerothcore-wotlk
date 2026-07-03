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
#include "MapMgr.h"
#include "Player.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "SpawnData.h"
#include "ScriptMgr.h"

MapPartitioned::MapPartitioned(uint32 id, uint8 partitionCount)
    : Map(id, 0, REGULAR_DIFFICULTY), m_partitionCount(partitionCount)
{
    for (uint32 i = 0; i < m_partitionCount; ++i)
    {
        Map* partition = CreatePartition(i);
        m_Partitions.push_back(partition);
    }
}

MapPartitioned::~MapPartitioned()
{
    for (Map* partition : m_Partitions)
    {
        partition->UnloadAll();
        delete partition;
    }
    m_Partitions.clear();
}

Map* MapPartitioned::CreatePartition(uint32 index)
{
    return new MapPartition(GetId(), 0, REGULAR_DIFFICULTY, this, m_partitionCount, static_cast<uint8>(index));
}

uint32 MapPartitioned::GetPartitionIndex(float x) const
{
    float const MAP_HALF_SIZE = 17066.0f;
    float clampedX = std::max(-MAP_HALF_SIZE, std::min(x, MAP_HALF_SIZE));
    float normalizedX = (clampedX + MAP_HALF_SIZE) / (2.0f * MAP_HALF_SIZE);
    return uint32(normalizedX * m_partitionCount) % m_partitionCount;
}

Map* MapPartitioned::GetPartitionForPosition(float x, float y) const
{
    uint32 index = GetPartitionIndex(x);
    if (index < m_Partitions.size())
        return m_Partitions[index];
    return m_Partitions[0];
}

Map* MapPartitioned::GetPartitionForPlayer(Player* player) const
{
    return GetPartitionForPosition(player->GetPositionX(), player->GetPositionY());
}

// ---- MapPartition implementation ----

bool MapPartition::IsPositionInPartition(float x) const
{
    return GetPartitionIndex(x) == m_partitionIndex;
}

uint32 MapPartition::GetPartitionIndex(float x) const
{
    float const MAP_HALF_SIZE = 17066.0f;
    float clampedX = std::max(-MAP_HALF_SIZE, std::min(x, MAP_HALF_SIZE));
    float normalizedX = (clampedX + MAP_HALF_SIZE) / (2.0f * MAP_HALF_SIZE);
    return uint32(normalizedX * m_partitionCount) % m_partitionCount;
}

void MapPartition::ProcessCreatureRespawn(ObjectGuid::LowType spawnId)
{
    CreatureData const* data = sObjectMgr->GetCreatureData(spawnId);
    if (!data)
    {
        RemoveCreatureRespawnTime(spawnId);
        return;
    }

    if (!IsPositionInPartition(data->posX))
    {
        RemoveCreatureRespawnTime(spawnId);
        return;
    }

    Map::ProcessCreatureRespawn(spawnId);
}

void MapPartition::ProcessGameObjectRespawn(ObjectGuid::LowType spawnId)
{
    GameObjectData const* data = sObjectMgr->GetGameObjectData(spawnId);
    if (!data)
    {
        RemoveGORespawnTime(spawnId);
        return;
    }

    if (!IsPositionInPartition(data->posX))
    {
        RemoveGORespawnTime(spawnId);
        return;
    }

    Map::ProcessGameObjectRespawn(spawnId);
}

// ---- MapPartitioned implementation ----

void MapPartitioned::LoadRespawnTimes()
{
    for (Map* partition : m_Partitions)
    {
        partition->LoadRespawnTimes();
    }

    Map::LoadRespawnTimes();
}

void MapPartitioned::OnCreateMap()
{
    for (Map* partition : m_Partitions)
    {
        partition->OnCreateMap();
    }

    Map::OnCreateMap();
}

void MapPartitioned::InitVisibilityDistance()
{
    for (Map* partition : m_Partitions)
    {
        partition->InitVisibilityDistance();
    }
}

void MapPartitioned::Update(const uint32 diff, const uint32 s_diff, bool /*thread*/)
{
    for (Map* partition : m_Partitions)
    {
        if (sMapMgr->GetMapUpdater()->activated())
            sMapMgr->GetMapUpdater()->schedule_update(*partition, diff, s_diff);
        else
            partition->Update(diff, s_diff);
    }
}

void MapPartitioned::DelayedUpdate(const uint32 diff)
{
    for (Map* partition : m_Partitions)
    {
        partition->DelayedUpdate(diff);
    }

    Map::DelayedUpdate(diff);
}

void MapPartitioned::UnloadAll()
{
    for (Map* partition : m_Partitions)
    {
        partition->UnloadAll();
    }

    Map::UnloadAll();
}

Map::EnterState MapPartitioned::CannotEnter(Player* /*player*/, bool /*loginCheck*/)
{
    return CAN_ENTER;
}

bool MapPartitioned::AddPlayerToMap(Player* player)
{
    Map* partition = GetPartitionForPlayer(player);
    player->SetMap(partition);
    return partition->AddPlayerToMap(player);
}

void MapPartitioned::RemovePlayerFromMap(Player* player, bool remove)
{
    Map* partition = player->GetMap();
    if (partition && partition != this)
    {
        partition->RemovePlayerFromMap(player, remove);
    }
}

void MapPartitioned::RemoveAllPlayers()
{
    for (Map* partition : m_Partitions)
    {
        partition->RemoveAllPlayers();
    }
}
