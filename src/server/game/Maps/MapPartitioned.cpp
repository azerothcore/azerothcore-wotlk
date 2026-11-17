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
#include "CellImpl.h"
#include "CombatManager.h"
#include "Creature.h"
#include "CreatureGroups.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "MapRefMgr.h"
#include "MapUpdater.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "Vehicle.h"
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

MapPartitioned::MapPartitioned(uint32 id, PartitionLayout const& layout, bool debugOwnershipChecks)
    : Map(id, 0, REGULAR_DIFFICULTY), _layout(layout)
{
    _debugOwnershipChecks = debugOwnershipChecks;
    _objectStoreLock = &_objectStoreMutex;

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

uint32 MapPartitioned::GetPositionalPartitionIndex(WorldObject const* obj, bool requireInWorld) const
{
    if (obj->FindMap() != this || (requireInWorld && !obj->IsInWorld()))
        return PartitionLayout::INVALID_PARTITION;

    if (!Acore::IsValidMapCoord(obj->GetPositionX(), obj->GetPositionY()))
        return PartitionLayout::INVALID_PARTITION;

    CellCoord const cell = Acore::ComputeCellCoord(obj->GetPositionX(), obj->GetPositionY());
    if (_layout.IsBorderCell(cell))
        return PartitionLayout::INVALID_PARTITION;

    return _layout.GetPartitionIndex(cell);
}

template<class Visitor>
void MapPartitioned::ForEachLinkPartner(WorldObject* obj, Visitor&& visitor)
{
    if (Unit* unit = obj->ToUnit())
    {
        // Pet / guardian / summon <-> owner, charm <-> charmer
        if (Unit* charmerOrOwner = unit->GetCharmerOrOwner())
            visitor(charmerOrOwner);
        for (Unit* controlled : unit->m_Controlled)
            visitor(controlled);

        // Combat (threat implies combat)
        for (auto const& [guid, ref] : unit->GetCombatManager().GetPvECombatRefs())
            visitor(ref->GetOther(unit));
        for (auto const& [guid, ref] : unit->GetCombatManager().GetPvPCombatRefs())
            visitor(ref->GetOther(unit));

        // Vehicle <-> passengers
        if (unit->GetVehicle())
            if (Unit* vehicleBase = unit->GetVehicleBase())
                visitor(vehicleBase);
        if (Vehicle* vehicleKit = unit->GetVehicleKit())
            for (auto const& [seatId, seat] : vehicleKit->Seats)
                if (!seat.IsEmpty())
                    if (Unit* passenger = ObjectAccessor::GetUnit(*unit, seat.Passenger.Guid))
                        visitor(passenger);

        // Shared vision
        if (unit->HasSharedVision())
            for (Player* viewer : unit->GetSharedVisionList())
                visitor(viewer);

        // Periodic auras applied by someone else (their ticks read and credit the caster)
        for (auto const& [spellId, aurApp] : unit->GetAppliedAuras())
        {
            Aura const* aura = aurApp->GetBase();
            if (aura->GetCasterGUID() == unit->GetGUID())
                continue;

            bool periodic = false;
            for (uint8 i = 0; i < MAX_SPELL_EFFECTS && !periodic; ++i)
                if (AuraEffect const* effect = aura->GetEffect(i))
                    periodic = effect->IsPeriodic();

            if (periodic)
                if (Unit* caster = aura->GetCaster())
                    visitor(caster);
        }

        if (Player* player = unit->ToPlayer())
        {
            if (WorldObject* viewpoint = player->GetViewpoint())
                visitor(viewpoint);
            if (player->duel && player->duel->Opponent)
                visitor(player->duel->Opponent);
        }
        else if (Creature* creature = unit->ToCreature())
        {
            if (CreatureGroup* formation = creature->GetFormation())
                for (auto const& [member, formationInfo] : formation->GetMembers())
                    if (member != creature)
                        visitor(member);
        }
    }
    else if (GameObject* go = obj->ToGameObject())
    {
        if (ObjectGuid ownerGuid = go->GetOwnerGUID())
            if (Unit* owner = ObjectAccessor::GetUnit(*go, ownerGuid))
                visitor(owner);
    }
    else if (DynamicObject* dynObj = obj->ToDynObject())
    {
        if (Unit* caster = dynObj->GetCaster())
            visitor(caster);
    }
}

MapPartition& MapPartitioned::ComputeOwner(WorldObject* obj)
{
    MapPartition& serialSet = GetSerialSet();

    if (_pinnedToSerialSet.contains(obj->GetGUID()))
        return serialSet;

    // Transports move their passengers across the whole map; zone-wide objects are seen zone-wide.
    if (obj->GetTransport() || obj->IsZoneWideVisible())
        return serialSet;
    if (GameObject const* go = obj->ToGameObject(); go && go->IsTransport())
        return serialSet;

    // The object itself may not be in world yet (AddToMap).
    uint32 const index = GetPositionalPartitionIndex(obj, false);
    if (index == PartitionLayout::INVALID_PARTITION)
        return serialSet;

    // Linked to anything outside this partition's interior: serial, so no two threads reach either side.
    bool linkedOutside = false;
    ForEachLinkPartner(obj, [&](WorldObject* partner)
    {
        if (!linkedOutside && partner != obj && GetPositionalPartitionIndex(partner, true) != index)
            linkedOutside = true;
    });

    if (linkedOutside)
        return serialSet;

    return *_partitions[index];
}

MapPartition& MapPartitioned::GetOwnerForNewObject(WorldObject* obj)
{
    MapPartition& owner = ComputeOwner(obj);

    // Added from a running partition: it may only own what it can reach, anything else goes serial.
    if (MapPartition* current = GetParallelPartition(); current && &owner != current)
        return GetSerialSet();

    return owner;
}

void MapPartitioned::ReassignOwnership(bool includeUpdatableObjects)
{
    // Players: tick vectors are rebuilt from the map's player list.
    ForEachPartition([](MapPartition& partition) { partition.GetPlayers().clear(); });

    for (MapRefMgr::iterator itr = m_mapRefMgr.begin(); itr != m_mapRefMgr.end(); ++itr)
    {
        Player* player = itr->GetSource();
        if (!player)
            continue;

        MapPartition& owner = player->IsInWorld() ? ComputeOwner(player) : GetSerialSet();
        player->SetPartition(&owner);
        owner.GetPlayers().push_back(player);
    }

    if (includeUpdatableObjects)
    {
        // Collect first: handing over modifies the lists being walked.
        std::vector<std::pair<WorldObject*, MapPartition*>> handoffs;
        ForEachPartition([&](MapPartition& partition)
        {
            auto check = [&](WorldObject* obj)
            {
                if (!obj->IsInWorld() || obj->FindMap() != this)
                    return;

                MapPartition& owner = ComputeOwner(obj);
                obj->SetPartition(&owner);
                if (&owner != &partition)
                    handoffs.emplace_back(obj, &owner);
            };

            for (WorldObject* obj : partition.GetUpdatableObjectList())
                check(obj);
            for (WorldObject* obj : partition.GetPendingAddUpdatableObjectList())
                check(obj);
        });

        for (auto const& [obj, owner] : handoffs)
            MoveUpdatableToPartition(obj, *owner);
    }

    // Queued field updates follow their owner, so that removals during UPDATE find them directly.
    RehomeUpdateObjects();
}

void MapPartitioned::PreUpdate(uint32 t_diff, uint32 /*s_diff*/)
{
    METRIC_TIMER("map_partition_pre_update_time_diff", METRIC_TAG("map_id", std::to_string(GetId())));

    ReassignOwnership(t_diff != 0);

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

    // Fork: one task per populated partition, run in parallel by the MapUpdater workers. The serial
    // set is never scheduled: it is updated on the world thread in PostUpdate.
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

    // First: entries queued by partitions for objects they don't own go to the owners, so that every
    // serial-phase removal finds its entry with a direct lookup.
    RehomeUpdateObjects();

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
