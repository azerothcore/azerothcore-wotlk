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

#ifndef ACORE_MAP_PARTITION_H
#define ACORE_MAP_PARTITION_H

#include "Define.h"
#include "GridDefines.h"
#include "ObjectGuid.h"
#include <unordered_map>
#include <unordered_set>
#include <vector>

class Corpse;
class Creature;
class DynamicObject;
class GameObject;
class GameObjectModel;
class Map;
class Object;
class Player;
class Unit;
class WorldObject;

/*
 * MapPartition
 *
 * Owner of a map's per-tick mutable containers: players to tick, updatable objects,
 * pending update-list additions, objects with pending field updates, delayed
 * visibility, cell move lists and the remove list.
 *
 * Every Map has a default partition (index SERIAL_SET_INDEX). On a plain map it is the
 * only one and Map::Update drives it. On a MapPartitioned continent it is the serial set
 * (border-strip and cross-partition-linked entities, updated on the world thread), and
 * the geometric partitions are updated in parallel by PartitionUpdateRequests. While a
 * partition runs in parallel it is only touched by its worker; shared mutations go to
 * the Outbox and are applied in the serial POST-UPDATE phase.
 *
 * See .agents/plans/map-partitioning/PLAN.md.
 */
class MapPartition
{
public:
    static constexpr uint32 SERIAL_SET_INDEX = 0xFFFFFFFF;

    // Work deferred from the parallel UPDATE phase to the serial POST-UPDATE phase.
    struct Outbox
    {
        enum class VisibilityMapOpType : uint8
        {
            AddFarVisible,
            RemoveFarVisible,
            AddZoneWide,
            RemoveZoneWide
        };

        struct VisibilityMapOp
        {
            VisibilityMapOpType Type;
            WorldObject* Target;
            uint32 ZoneId;
        };

        enum class CorpseOpType : uint8
        {
            Add,
            Remove,
            ConvertToBones
        };

        struct CorpseOp
        {
            CorpseOpType Type;
            Corpse* Target;         // Add / Remove
            ObjectGuid OwnerGuid;   // ConvertToBones
            bool Insignia;          // ConvertToBones
        };

        struct CollisionModelOp
        {
            GameObjectModel const* Model;
            bool Insert;
        };

        struct PendingGridAdd
        {
            WorldObject* Target;
            bool CheckTransport;
        };

        // Objects added to the map during UPDATE: they are in world, but grid insertion, transport
        // boarding, create-visibility and vehicle accessories are deferred.
        std::vector<PendingGridAdd> PendingGridAdds;
        // Objects owned by another partition (the serial set) that need to join its update list.
        std::vector<WorldObject*> DeferredUpdatableAdds;
        // Objects not owned by this partition that left the world: drop their queued field updates.
        std::vector<Object*> DeferredUpdateObjectRemovals;
        // Players whose far teleport was requested during UPDATE.
        std::vector<ObjectGuid> PendingFarTeleports;
        // zoneId -> player count delta (Map::UpdatePlayerZoneStats).
        std::unordered_map<uint32, int32> ZonePlayerCountDeltas;
        std::vector<VisibilityMapOp> VisibilityMapOps;
        std::vector<CorpseOp> CorpseOps;
        // DynamicMapTree insert/remove; the tree is frozen during UPDATE.
        std::vector<CollisionModelOp> CollisionModelOps;
        bool CollisionBalanceRequested = false;
        // Grids that must be loaded before a recorded cell move can be applied.
        std::vector<GridCoord> GridLoadRequests;

        [[nodiscard]] bool IsEmpty() const;
        void Clear();
    };

    typedef std::vector<WorldObject*> UpdatableObjectList;
    typedef std::unordered_set<WorldObject*> PendingAddUpdatableObjectList;

    MapPartition(Map& owner, uint32 index);
    ~MapPartition() = default;

    MapPartition(MapPartition const&) = delete;
    MapPartition& operator=(MapPartition const&) = delete;

    [[nodiscard]] uint32 GetIndex() const { return _index; }
    [[nodiscard]] bool IsSerialSet() const { return _index == SERIAL_SET_INDEX; }
    [[nodiscard]] Map& GetOwner() { return _owner; }
    [[nodiscard]] Map const& GetOwner() const { return _owner; }

    // True when the partition has nothing to tick (not scheduled during fan-out).
    [[nodiscard]] bool IsEmpty() const;

    // Per-partition body of the UPDATE phase: sessions, players and updatable objects of this
    // partition only. Map-wide work belongs to the owner's PRE/POST-UPDATE phases.
    void Update(uint32 t_diff, uint32 s_diff);

    // Removes a player from the tick vector. Safe while the vector is being iterated by
    // Map::UpdateSessions/UpdatePlayers (the iteration index is adjusted). Returns false if absent.
    bool RemovePlayer(Player* player);

    std::vector<Player*>& GetPlayers() { return _players; }
    UpdatableObjectList& GetUpdatableObjectList() { return _updatableObjectList; }
    PendingAddUpdatableObjectList& GetPendingAddUpdatableObjectList() { return _pendingAddUpdatableObjectList; }
    std::unordered_set<Object*>& GetUpdateObjects() { return _updateObjects; }
    std::unordered_set<Unit*>& GetObjectsForDelayedVisibility() { return _objectsForDelayedVisibility; }
    std::vector<Player*>& GetPlayersToMove() { return _playersToMove; }
    std::vector<Creature*>& GetCreaturesToMove() { return _creaturesToMove; }
    std::vector<GameObject*>& GetGameObjectsToMove() { return _gameObjectsToMove; }
    std::vector<DynamicObject*>& GetDynamicObjectsToMove() { return _dynamicObjectsToMove; }
    std::unordered_set<WorldObject*>& GetObjectsToRemove() { return _objectsToRemove; }
    Outbox& GetOutbox() { return _outbox; }

    // Partition currently being updated by this thread; nullptr outside the parallel UPDATE phase.
    [[nodiscard]] static MapPartition* GetCurrent() { return _currentPartition; }

    // RAII guard installing the thread-local current partition for the duration of an update.
    class Scope
    {
    public:
        explicit Scope(MapPartition& partition);
        ~Scope();

        Scope(Scope const&) = delete;
        Scope& operator=(Scope const&) = delete;

    private:
        MapPartition* _previous;
    };

private:
    friend class Map;

    Map& _owner;
    uint32 const _index;

    std::vector<Player*> _players;
    UpdatableObjectList _updatableObjectList;
    PendingAddUpdatableObjectList _pendingAddUpdatableObjectList;
    std::unordered_set<Object*> _updateObjects;
    std::unordered_set<Unit*> _objectsForDelayedVisibility;
    std::vector<Player*> _playersToMove;
    std::vector<Creature*> _creaturesToMove;
    std::vector<GameObject*> _gameObjectsToMove;
    std::vector<DynamicObject*> _dynamicObjectsToMove;
    std::unordered_set<WorldObject*> _objectsToRemove;
    Outbox _outbox;

    // Index of the player being ticked while _players is iterated (see RemovePlayer).
    std::size_t _playerIterIndex = 0;
    bool _iteratingPlayers = false;

    static thread_local MapPartition* _currentPartition;
};

#endif // ACORE_MAP_PARTITION_H
