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

/*
 * Map partitioning, Step 5 (.agents/plans/map-partitioning/PLAN.md):
 * shared stores used by partitions running in parallel.
 */

#include "MapPartitioned.h"
#include "ObjectGuid.h"
#include "TestCreature.h"
#include "TestMap.h"
#include "WorldMock.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include <atomic>
#include <thread>
#include <unordered_set>

using namespace testing;

namespace
{

constexpr std::size_t THREAD_COUNT = 4;

class PartitionedMapProbe : public MapPartitioned
{
public:
    PartitionedMapProbe() : MapPartitioned(0, PartitionLayout()) { }

    using Map::ApplyPartitionOutbox;

    // What SchedulePartitions / PostUpdate do around the fork-join.
    void SetParallelPhase(bool parallel) { _inParallelPhase.store(parallel, std::memory_order_release); }
};

class MapPartitionThreadSafetyTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        _previousWorld = std::move(sWorld);
        _worldMock = new NiceMock<WorldMock>();

        ON_CALL(*_worldMock, getIntConfig(_)).WillByDefault(Return(0));
        ON_CALL(*_worldMock, getFloatConfig(_)).WillByDefault(Return(1.0f));
        ON_CALL(*_worldMock, getBoolConfig(_)).WillByDefault(Return(false));
        static std::string emptyString;
        ON_CALL(*_worldMock, GetDataPath()).WillByDefault(ReturnRef(emptyString));

        sWorld.reset(_worldMock);

        TestMap::EnsureDBC();
        _map = new PartitionedMapProbe();
    }

    void TearDown() override
    {
        _map->SetParallelPhase(false);
        for (TestCreature* creature : _creatures)
            delete creature;

        delete _map;
        sWorld = std::move(_previousWorld);
    }

    std::unique_ptr<IWorld> _previousWorld;
    NiceMock<WorldMock>* _worldMock = nullptr;
    PartitionedMapProbe* _map = nullptr;
    std::vector<TestCreature*> _creatures;
};

} // namespace

TEST(ObjectGuidGeneratorTest, ConcurrentGenerateHandsOutUniqueSequentialGuids)
{
    constexpr std::size_t PER_THREAD = 20000;
    ObjectGuidGenerator<HighGuid::Unit> generator(1);

    std::vector<std::vector<ObjectGuid::LowType>> generated(THREAD_COUNT);
    std::vector<std::thread> threads;
    for (std::size_t t = 0; t < THREAD_COUNT; ++t)
    {
        threads.emplace_back([&generator, &generated, t]()
        {
            generated[t].reserve(PER_THREAD);
            for (std::size_t i = 0; i < PER_THREAD; ++i)
                generated[t].push_back(generator.Generate());
        });
    }

    for (std::thread& thread : threads)
        thread.join();

    std::unordered_set<ObjectGuid::LowType> unique;
    for (auto const& guids : generated)
        unique.insert(guids.begin(), guids.end());

    EXPECT_EQ(unique.size(), THREAD_COUNT * PER_THREAD);
    EXPECT_EQ(generator.GetNextAfterMaxUsed(), ObjectGuid::LowType(THREAD_COUNT * PER_THREAD + 1));
    EXPECT_EQ(*std::min_element(unique.begin(), unique.end()), 1u);
    EXPECT_EQ(*std::max_element(unique.begin(), unique.end()), ObjectGuid::LowType(THREAD_COUNT * PER_THREAD));
}

TEST(ObjectGuidGeneratorTest, SetAndNextAfterMaxUsed)
{
    ObjectGuidGenerator<HighGuid::GameObject> generator(1);
    generator.Set(500);
    EXPECT_EQ(generator.Generate(), 500u);
    EXPECT_EQ(generator.GetNextAfterMaxUsed(), 501u);
}

TEST_F(MapPartitionThreadSafetyTest, PlainMapIsNeverInParallelPhase)
{
    TestMap plain;
    EXPECT_FALSE(plain.IsInParallelPhase());
    EXPECT_FALSE(_map->IsInParallelPhase());
}

TEST_F(MapPartitionThreadSafetyTest, ObjectStoreSupportsConcurrentWritersAndReadersWhilePartitionsRun)
{
    constexpr std::size_t PER_THREAD = 200;

    for (std::size_t i = 0; i < THREAD_COUNT * PER_THREAD; ++i)
    {
        TestCreature* creature = new TestCreature();
        creature->SetupForCombatTest(_map, ObjectGuid::LowType(i + 1), 12345);
        _creatures.push_back(creature);
    }

    _map->SetParallelPhase(true);

    // Each "partition" inserts its own creatures and keeps looking up everybody else's.
    std::atomic<std::size_t> found = 0;
    std::vector<std::thread> threads;
    for (std::size_t t = 0; t < THREAD_COUNT; ++t)
    {
        threads.emplace_back([this, t, &found]()
        {
            for (std::size_t i = 0; i < PER_THREAD; ++i)
            {
                _map->AddToObjectStore(_creatures[t * PER_THREAD + i]);
                if (_map->GetCreature(_creatures[(t * PER_THREAD + i * 7) % _creatures.size()]->GetGUID()))
                    ++found;
            }
        });
    }

    for (std::thread& thread : threads)
        thread.join();

    for (TestCreature* creature : _creatures)
        ASSERT_EQ(_map->GetCreature(creature->GetGUID()), creature);
    EXPECT_GT(found.load(), 0u);

    threads.clear();
    for (std::size_t t = 0; t < THREAD_COUNT; ++t)
    {
        threads.emplace_back([this, t]()
        {
            for (std::size_t i = 0; i < PER_THREAD; ++i)
                _map->RemoveFromObjectStore(_creatures[t * PER_THREAD + i]);
        });
    }

    for (std::thread& thread : threads)
        thread.join();

    _map->SetParallelPhase(false);
    for (TestCreature* creature : _creatures)
        EXPECT_EQ(_map->GetCreature(creature->GetGUID()), nullptr);
}

TEST_F(MapPartitionThreadSafetyTest, PoolUpdatesFromARunningPartitionAreDeferred)
{
    MapPartition* partition = _map->GetPartition(4);
    {
        MapPartition::Scope scope(*partition);
        _map->UpdatePool(SPAWN_TYPE_CREATURE, 77, 1234);
    }

    ASSERT_EQ(partition->GetOutbox().PoolUpdates.size(), 1u);
    EXPECT_EQ(partition->GetOutbox().PoolUpdates[0].Type, SPAWN_TYPE_CREATURE);
    EXPECT_EQ(partition->GetOutbox().PoolUpdates[0].PoolId, 77u);
    EXPECT_EQ(partition->GetOutbox().PoolUpdates[0].SpawnId, 1234u);

    // Not applied here: pool 77 doesn't exist in the test environment.
    partition->GetOutbox().Clear();
}

TEST_F(MapPartitionThreadSafetyTest, ScheduledRespawnsFromARunningPartitionAreDeferred)
{
    MapPartition* partition = _map->GetPartition(4);
    ObjectGuid const guid = ObjectGuid::Create<HighGuid::Unit>(12345, 99);
    {
        MapPartition::Scope scope(*partition);
        _map->ScheduleCreatureRespawn(guid, 30s);
    }

    // The map-wide event queue is untouched until POST-UPDATE.
    EXPECT_FALSE(_map->Events.HasEvents());
    ASSERT_EQ(partition->GetOutbox().ScheduledRespawns.size(), 1u);
    EXPECT_EQ(partition->GetOutbox().ScheduledRespawns[0].Guid, guid);

    _map->ApplyPartitionOutbox(*partition);
    EXPECT_TRUE(_map->Events.HasEvents());
    EXPECT_TRUE(partition->GetOutbox().IsEmpty());
}
