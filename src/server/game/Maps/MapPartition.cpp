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

thread_local MapPartition* MapPartition::_currentPartition = nullptr;

bool MapPartition::Outbox::IsEmpty() const
{
    return PendingGridAdds.empty()
        && PendingFarTeleports.empty()
        && ZonePlayerCountDeltas.empty()
        && VisibilityMapOps.empty()
        && CorpseOps.empty()
        && CollisionModelOps.empty()
        && !CollisionBalanceRequested
        && GridLoadRequests.empty();
}

void MapPartition::Outbox::Clear()
{
    PendingGridAdds.clear();
    PendingFarTeleports.clear();
    ZonePlayerCountDeltas.clear();
    VisibilityMapOps.clear();
    CorpseOps.clear();
    CollisionModelOps.clear();
    CollisionBalanceRequested = false;
    GridLoadRequests.clear();
}

MapPartition::MapPartition(MapPartitioned& owner, uint32 index)
    : _owner(owner), _index(index)
{
}

bool MapPartition::IsEmpty() const
{
    return _players.empty()
        && _updatableObjectList.empty()
        && _pendingAddUpdatableObjectList.empty();
}

void MapPartition::Update(uint32 /*t_diff*/, uint32 /*s_diff*/)
{
    // Step 1 scaffolding: the per-partition UPDATE body (sessions, players,
    // local updatables, recorded movement) is implemented in Step 3.
}

MapPartition::Scope::Scope(MapPartition& partition)
    : _previous(_currentPartition)
{
    _currentPartition = &partition;
}

MapPartition::Scope::~Scope()
{
    _currentPartition = _previous;
}
