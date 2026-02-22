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
#include "Map.h"
#include "Player.h"
#include "Creature.h"
#include "GameObject.h"
#include "DynamicObject.h"
#include "Log.h"
#include "World.h"
#include <sstream>

MapPartition::MapPartition(Map* parentMap, uint32 partitionId, PartitionBounds const& bounds)
    : _parentMap(parentMap), _partitionId(partitionId), _bounds(bounds),
      _borderMargin(100.0f), _updateCount(0), _totalUpdateTime(0)
{
}

MapPartition::~MapPartition()
{
    std::lock_guard<std::mutex> guard(_entityLock);
    _players.clear();
    _creatures.clear();
    _gameObjects.clear();
    _dynamicObjects.clear();
}

void MapPartition::Update(uint32 t_diff, uint32 s_diff)
{
    std::lock_guard<std::mutex> guard(_entityLock);

    uint32 startTime = WorldTimer::getMSTime();

    if (t_diff)
    {
        UpdateCreatures(t_diff);
        UpdateGameObjects(t_diff);
        UpdateDynamicObjects(t_diff);
    }

    UpdatePlayers(t_diff, s_diff);

    uint32 updateTime = WorldTimer::getMSTimeDiff(startTime, WorldTimer::getMSTime());
    _totalUpdateTime += updateTime;
    ++_updateCount;

    if (_updateCount % 1000 == 0)
    {
        LOG_DEBUG("maps.partition", "Partition {}: {} entities, avg {}ms",
            _partitionId, GetEntityCount(), _totalUpdateTime / _updateCount);
    }
}

void MapPartition::UpdatePlayers(uint32 t_diff, uint32 s_diff)
{
    for (Player* player : _players)
    {
        if (player && player->IsInWorld() && t_diff)
            player->Update(t_diff);
    }
}

void MapPartition::UpdateCreatures(uint32 t_diff)
{
    for (Creature* creature : _creatures)
    {
        if (creature && creature->IsInWorld())
            creature->Update(t_diff);
    }
}

void MapPartition::UpdateGameObjects(uint32 t_diff)
{
    for (GameObject* gameObject : _gameObjects)
    {
        if (gameObject && gameObject->IsInWorld())
            gameObject->Update(t_diff);
    }
}

void MapPartition::UpdateDynamicObjects(uint32 t_diff)
{
    for (DynamicObject* dynObject : _dynamicObjects)
    {
        if (dynObject && dynObject->IsInWorld())
            dynObject->Update(t_diff);
    }
}

void MapPartition::AddEntity(WorldObject* obj)
{
    if (!obj)
        return;

    std::lock_guard<std::mutex> guard(_entityLock);

    if (Player* player = obj->ToPlayer())
    {
        _players.insert(player);
    }
    else if (Creature* creature = obj->ToCreature())
    {
        _creatures.insert(creature);
    }
    else if (GameObject* gameObject = obj->ToGameObject())
    {
        _gameObjects.insert(gameObject);
    }
    else if (DynamicObject* dynObject = obj->ToDynObject())
    {
        _dynamicObjects.insert(dynObject);
    }
}

void MapPartition::RemoveEntity(WorldObject* obj)
{
    if (!obj)
        return;

    std::lock_guard<std::mutex> guard(_entityLock);

    if (Player* player = obj->ToPlayer())
    {
        _players.erase(player);
    }
    else if (Creature* creature = obj->ToCreature())
    {
        _creatures.erase(creature);
    }
    else if (GameObject* gameObject = obj->ToGameObject())
    {
        _gameObjects.erase(gameObject);
    }
    else if (DynamicObject* dynObject = obj->ToDynObject())
    {
        _dynamicObjects.erase(dynObject);
    }
}

std::vector<WorldObject*> MapPartition::GetBorderEntities() const
{
    std::lock_guard<std::mutex> guard(_entityLock);
    std::vector<WorldObject*> borderEntities;

    for (Player* player : _players)
    {
        if (player && IsNearBorder(player->GetPositionX(), player->GetPositionY()))
            borderEntities.push_back(player);
    }

    for (Creature* creature : _creatures)
    {
        if (creature && IsNearBorder(creature->GetPositionX(), creature->GetPositionY()))
            borderEntities.push_back(creature);
    }

    for (GameObject* gameObject : _gameObjects)
    {
        if (gameObject && IsNearBorder(gameObject->GetPositionX(), gameObject->GetPositionY()))
            borderEntities.push_back(gameObject);
    }

    return borderEntities;
}

void MapPartition::CheckForMigrations(std::vector<std::pair<WorldObject*, MapPartition*>>& migrations)
{
}

uint32 MapPartition::GetEntityCount() const
{
    std::lock_guard<std::mutex> guard(_entityLock);
    return _players.size() + _creatures.size() + _gameObjects.size() + _dynamicObjects.size();
}

uint32 MapPartition::GetPlayerCount() const
{
    std::lock_guard<std::mutex> guard(_entityLock);
    return _players.size();
}

uint32 MapPartition::GetCreatureCount() const
{
    std::lock_guard<std::mutex> guard(_entityLock);
    return _creatures.size();
}

uint32 MapPartition::GetGameObjectCount() const
{
    std::lock_guard<std::mutex> guard(_entityLock);
    return _gameObjects.size();
}

std::string MapPartition::GetDebugInfo() const
{
    std::lock_guard<std::mutex> guard(_entityLock);
    std::ostringstream info;
    info << "Partition " << _partitionId << ": "
         << "Players=" << _players.size() << " "
         << "Creatures=" << _creatures.size() << " "
         << "GameObjects=" << _gameObjects.size() << " "
         << "DynamicObjects=" << _dynamicObjects.size() << " "
         << "Bounds=(" << _bounds.minX << "," << _bounds.minY << ")-("
         << _bounds.maxX << "," << _bounds.maxY << ")";
    return info.str();
}
