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
#include <algorithm>

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

MapPartition::MapPartition(Map& owner, uint32 index)
    : _owner(owner), _index(index)
{
}

bool MapPartition::IsEmpty() const
{
    return _players.empty()
        && _updatableObjectList.empty()
        && _pendingAddUpdatableObjectList.empty();
}

void MapPartition::Update(uint32 t_diff, uint32 s_diff)
{
    // Cells were marked map-wide in PRE-UPDATE, and the recheck timer is only reset in POST-UPDATE.
    _owner.UpdateSessionsAndPlayers(*this, t_diff, s_diff, false);

    if (!t_diff)
        return;

    _owner.UpdateNonPlayerObjects(*this, t_diff, _owner._updatableObjectListRecheckTimer.Passed());
}

bool MapPartition::RemovePlayer(Player* player)
{
    auto itr = std::find(_players.begin(), _players.end(), player);
    if (itr == _players.end())
        return false;

    std::size_t const index = std::size_t(itr - _players.begin());
    _players.erase(itr);

    // Keep the running loop on the next unvisited player. Unsigned wrap-around from 0 is intended:
    // the loop's ++ brings it back to 0.
    if (_iteratingPlayers && index <= _playerIterIndex)
        --_playerIterIndex;

    return true;
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
