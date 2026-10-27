# Feature: Map Partitioning Support for AzerothCore

## 1. Problem & Architecture Overview
In high-population AzerothCore World of Warcraft servers, large continent maps (Eastern Kingdoms `Map 0`, Kalimdor `Map 1`, Outland `Map 530`, Northrend `Map 571`) represent a significant single-threaded bottleneck:
- Under standard architecture, instances and battlegrounds run on dedicated threads, but an entire continent is updated monolithically on a single thread.
- With thousands of players, pets, creatures, gameobjects, and dynamic objects active simultaneously, per-tick update execution times increase, causing server lag and tick drops during world PvP, holiday events, or in major capital cities (Orgrimmar, Stormwind, Dalaran).

This feature introduces a parallel **Map Partitioning** subsystem to AzerothCore, allowing continent maps to divide active grid updates across logical quadrants and worker threads.

---

## 2. Key Technical Improvements

### 2.1 The `MapPartition` Subsystem (`src/server/game/Maps/MapPartition.h`, `.cpp`)
- Subdivides the monolithic 64x64 grid into logical partitions (e.g. 4 balanced quadrants: Northwest, Northeast, Southwest, Southeast).
- Each partition manages its own isolated list of `WorldObject*` updatables (`_updatableObjects`).
- Partition updates run in parallel via a Fork-Join model (`std::async`), executing AI, spellcasting, movement, and creature updates across CPU cores.
- Thread-safe inter-partition transfers: when an entity physically crosses a partition boundary (`GridCoord`), it is safely transferred via a lock-free/thread-safe `LockedQueue<ObjectGuid> _transferQueue` without loading screens or gameplay interruptions.

### 2.2 Collision & Spatial Query Concurrency (`DynamicMapTree`)
- Replaced unsynchronized access in `DynamicMapTree` with `std::shared_mutex`.
- Spatial lookups, LOS checks (`GetIntersectionTime`), and raycasts remain concurrent and non-blocking for readers via `std::shared_lock`.
- Mutating operations (transport insertion, removal, rebalancing) use exclusive `std::unique_lock` to prevent memory corruption while transports traverse across partitions.

### 2.3 Thread-Local Pathfinding Caching (`PathGenerator`)
- Integrated `thread_local std::unordered_map<uint32, std::pair<dtNavMesh const*, MMAP::ManagedNavMeshQuery>> t_navMeshQueries;`.
- Avoids cross-thread lock contention on navigation mesh query instances during simultaneous creature pathfinding computations.

### 2.4 Synchronization & Load Ordering (`Map.h`, `Map.cpp`)
- Protected `_updateObjects` and object movement queues (`_creaturesToMove`, `_gameObjectsToMove`, `_dynamicObjectsToMove`) with dedicated mutexes (`_updateObjectsLock`, `_moveListLock`).
- Protected grid creation and tile loading (`EnsureGridCreated`, `EnsureGridLoaded`) with recursive mutex synchronization (`_gridLock`) to guarantee safe NavMesh tile paging.

---

## 3. Verification & Safety
- Clean merge and integration against current AzerothCore master branch.
- Infinite loop safeguards verified in `MapPartition::Update` with conditional increment handling on deleted/relocated objects.
