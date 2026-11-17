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
 * Map partitioning, Step 3 (.agents/plans/map-partitioning/PLAN.md):
 * per-tick state lives in MapPartition, and writes are routed to the partition
 * of the calling thread (or the default partition / serial set outside UPDATE).
 * Shared mutations made from a parallel partition are deferred to its outbox.
 */

#include "MapPartitioned.h"
#include "TestCreature.h"
#include "TestMap.h"
#include "WorldMock.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"

using namespace testing;

namespace
{

// Exposes the protected routing helpers.
class PartitionedMapProbe : public MapPartitioned
{
public:
    PartitionedMapProbe() : MapPartitioned(0, PartitionLayout()) { }

    using Map::ApplyPartitionOutbox;
    using Map::GetDefaultPartition;
    using Map::RehomeUpdateObjects;
    using Map::GetParallelPartition;
    using Map::GetWritePartition;
};

class PlainMapProbe : public TestMap
{
public:
    using Map::GetDefaultPartition;
    using Map::GetParallelPartition;
    using Map::GetWritePartition;
};

// Stand-ins that are only stored and compared, never dereferenced.
alignas(16) unsigned char FakeStorage[4][16];

Unit* FakeUnit(std::size_t i) { return reinterpret_cast<Unit*>(FakeStorage[i]); }
Player* FakePlayer(std::size_t i) { return reinterpret_cast<Player*>(FakeStorage[i]); }

class MapPartitionRoutingTest : public ::testing::Test
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
        _partitioned = new PartitionedMapProbe();
        _plain = new PlainMapProbe();
    }

    void TearDown() override
    {
        for (TestCreature* creature : _creatures)
            delete creature;

        delete _plain;
        delete _partitioned;
        sWorld = std::move(_previousWorld);
    }

    std::unique_ptr<IWorld> _previousWorld;
    NiceMock<WorldMock>* _worldMock = nullptr;
    PartitionedMapProbe* _partitioned = nullptr;
    PlainMapProbe* _plain = nullptr;
    std::vector<TestCreature*> _creatures;

    // AddUpdateObject() inspects the object (type, owner partition), so it needs a real one.
    TestCreature* SpawnOn(Map* map)
    {
        TestCreature* creature = new TestCreature();
        creature->SetupForCombatTest(map, ObjectGuid::LowType(_creatures.size() + 1), 12345);
        _creatures.push_back(creature);
        return creature;
    }
};

} // namespace

TEST_F(MapPartitionRoutingTest, PlainMapAlwaysWritesToItsDefaultPartition)
{
    EXPECT_EQ(&_plain->GetWritePartition(), &_plain->GetDefaultPartition());
    EXPECT_EQ(_plain->GetParallelPartition(), nullptr);

    // A partition of another map being updated on this thread must not capture the plain map's writes.
    MapPartition::Scope scope(*_partitioned->GetPartition(3));
    EXPECT_EQ(&_plain->GetWritePartition(), &_plain->GetDefaultPartition());
    EXPECT_EQ(_plain->GetParallelPartition(), nullptr);
}

TEST_F(MapPartitionRoutingTest, PartitionedMapRoutesToCurrentPartition)
{
    MapPartition& serialSet = _partitioned->GetSerialSet();
    MapPartition* partition = _partitioned->GetPartition(5);

    // Outside the parallel phase: the serial set.
    EXPECT_EQ(&_partitioned->GetWritePartition(), &serialSet);
    EXPECT_EQ(_partitioned->GetParallelPartition(), nullptr);

    {
        MapPartition::Scope scope(*partition);
        EXPECT_EQ(&_partitioned->GetWritePartition(), partition);
        EXPECT_EQ(_partitioned->GetParallelPartition(), partition);
    }

    {
        // The serial set runs on the world thread: writes route to it but nothing is deferred.
        MapPartition::Scope scope(serialSet);
        EXPECT_EQ(&_partitioned->GetWritePartition(), &serialSet);
        EXPECT_EQ(_partitioned->GetParallelPartition(), nullptr);
    }
}

TEST_F(MapPartitionRoutingTest, UpdateObjectsAndDelayedVisibilityAreQueuedPerPartition)
{
    MapPartition* partition = _partitioned->GetPartition(7);
    TestCreature* touched = SpawnOn(_partitioned);
    TestCreature* other = SpawnOn(_partitioned);

    {
        MapPartition::Scope scope(*partition);
        _partitioned->AddUpdateObject(touched);
        _partitioned->AddDelayedVisibility(FakeUnit(1));
    }
    // Serial phase: queued on the owner (the serial set, provisional owner after SetMap).
    _partitioned->AddUpdateObject(other);

    EXPECT_EQ(partition->GetUpdateObjects().count(touched), 1u);
    EXPECT_EQ(partition->GetObjectsForDelayedVisibility().count(FakeUnit(1)), 1u);
    EXPECT_EQ(_partitioned->GetSerialSet().GetUpdateObjects().count(other), 1u);
    EXPECT_TRUE(_partitioned->GetSerialSet().GetObjectsForDelayedVisibility().empty());

    // POST-UPDATE starts by moving partition-queued entries to their owner (the serial set here)...
    _partitioned->RehomeUpdateObjects();
    EXPECT_TRUE(partition->GetUpdateObjects().empty());
    EXPECT_EQ(_partitioned->GetSerialSet().GetUpdateObjects().count(touched), 1u);

    // ...so a serial-phase removal finds it with a direct lookup.
    _partitioned->RemoveUpdateObject(touched);
    EXPECT_EQ(_partitioned->GetSerialSet().GetUpdateObjects().count(touched), 0u);

    _partitioned->RemoveUpdateObject(other);
    EXPECT_TRUE(_partitioned->GetSerialSet().GetUpdateObjects().empty());

    partition->GetObjectsForDelayedVisibility().clear();
}

TEST_F(MapPartitionRoutingTest, PlainMapQueuesUpdateObjectsInDefaultPartition)
{
    TestCreature* creature = SpawnOn(_plain);
    EXPECT_EQ(creature->GetPartition(), &_plain->GetDefaultPartition());

    _plain->AddUpdateObject(creature);
    EXPECT_EQ(_plain->GetDefaultPartition().GetUpdateObjects().count(creature), 1u);

    _plain->RemoveUpdateObject(creature);
    EXPECT_TRUE(_plain->GetDefaultPartition().GetUpdateObjects().empty());
}

TEST_F(MapPartitionRoutingTest, ZonePlayerCountIsDeferredDuringParallelUpdate)
{
    constexpr uint32 ZONE_A = 12;   // Elwynn Forest
    constexpr uint32 ZONE_B = 40;   // Westfall

    _partitioned->UpdatePlayerZoneStats(0xFFFFFFFF, ZONE_A);
    ASSERT_EQ(_partitioned->GetPlayerCountInZone(ZONE_A), 1u);

    MapPartition* partition = _partitioned->GetPartition(2);
    {
        MapPartition::Scope scope(*partition);
        _partitioned->UpdatePlayerZoneStats(ZONE_A, ZONE_B);
    }

    // Not applied yet: the shared counter is untouched while partitions run.
    EXPECT_EQ(_partitioned->GetPlayerCountInZone(ZONE_A), 1u);
    EXPECT_EQ(_partitioned->GetPlayerCountInZone(ZONE_B), 0u);
    EXPECT_FALSE(partition->GetOutbox().IsEmpty());

    _partitioned->ApplyPartitionOutbox(*partition);

    EXPECT_EQ(_partitioned->GetPlayerCountInZone(ZONE_A), 0u);
    EXPECT_EQ(_partitioned->GetPlayerCountInZone(ZONE_B), 1u);
    EXPECT_TRUE(partition->GetOutbox().IsEmpty());
}

TEST_F(MapPartitionRoutingTest, ZonePlayerCountIsImmediateOutsideParallelUpdate)
{
    constexpr uint32 ZONE = 12;

    _plain->UpdatePlayerZoneStats(0xFFFFFFFF, ZONE);
    EXPECT_EQ(_plain->GetPlayerCountInZone(ZONE), 1u);

    MapPartition::Scope scope(_partitioned->GetSerialSet());
    _partitioned->UpdatePlayerZoneStats(0xFFFFFFFF, ZONE);
    EXPECT_EQ(_partitioned->GetPlayerCountInZone(ZONE), 1u);
}

TEST_F(MapPartitionRoutingTest, CollisionTreeBalanceIsDeferredDuringParallelUpdate)
{
    MapPartition* partition = _partitioned->GetPartition(0);
    {
        MapPartition::Scope scope(*partition);
        _partitioned->Balance();
    }

    EXPECT_TRUE(partition->GetOutbox().CollisionBalanceRequested);

    _partitioned->ApplyPartitionOutbox(*partition);
    EXPECT_TRUE(partition->GetOutbox().IsEmpty());
}

TEST(MapPartitionPlayersTest, RemovePlayer)
{
    TestMap::EnsureDBC();
    std::unique_ptr<IWorld> previousWorld = std::move(sWorld);
    auto* worldMock = new NiceMock<WorldMock>();
    static std::string emptyString;
    ON_CALL(*worldMock, GetDataPath()).WillByDefault(ReturnRef(emptyString));
    sWorld.reset(worldMock);

    {
        TestMap map;
        MapPartition partition(map, 0);
        partition.GetPlayers() = { FakePlayer(0), FakePlayer(1), FakePlayer(2) };

        EXPECT_TRUE(partition.RemovePlayer(FakePlayer(1)));
        EXPECT_EQ(partition.GetPlayers(), (std::vector<Player*>{ FakePlayer(0), FakePlayer(2) }));
        EXPECT_FALSE(partition.RemovePlayer(FakePlayer(1)));
        EXPECT_FALSE(partition.IsEmpty());
    }

    sWorld = std::move(previousWorld);
}
