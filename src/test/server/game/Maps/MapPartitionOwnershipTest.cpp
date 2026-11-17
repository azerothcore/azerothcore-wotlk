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
 * Map partitioning, Step 4 (.agents/plans/map-partitioning/PLAN.md):
 * entity ownership (geometric partition vs serial set), owner assignment for
 * new objects, and owner-directed field-update bookkeeping.
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

class PartitionedMapProbe : public MapPartitioned
{
public:
    PartitionedMapProbe() : MapPartitioned(0, PartitionLayout(8, 2)) { }

    using Map::ApplyPartitionOutbox;
    using Map::GetOwnerPartition;
};

// World coordinate of the centre of cell `cell` on one axis (inverse of Acore::ComputeCellCoord).
float CellCenter(uint32 cell)
{
    return (float(CENTER_GRID_CELL_ID) - float(cell) - 0.5f) * float(SIZE_OF_GRID_CELL);
}

class MapPartitionOwnershipTest : public ::testing::Test
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
        for (TestCreature* creature : _creatures)
        {
            creature->m_Controlled.clear();
            creature->CleanupCombatState();
            delete creature;
        }

        delete _map;
        sWorld = std::move(_previousWorld);
    }

    // Creature in world on the partitioned map, at the centre of cell (cellX, cellY).
    TestCreature* SpawnAtCell(uint32 cellX, uint32 cellY)
    {
        TestCreature* creature = new TestCreature();
        creature->SetupForCombatTest(_map, ObjectGuid::LowType(_creatures.size() + 1), 12345);
        creature->Relocate(CellCenter(cellX), CellCenter(cellY), 0.0f);
        _creatures.push_back(creature);
        return creature;
    }

    std::unique_ptr<IWorld> _previousWorld;
    NiceMock<WorldMock>* _worldMock = nullptr;
    PartitionedMapProbe* _map = nullptr;
    std::vector<TestCreature*> _creatures;
};

} // namespace

TEST_F(MapPartitionOwnershipTest, CellCenterHelperMatchesComputeCellCoord)
{
    for (uint32 cell : { 0u, 32u, 63u, 64u, 255u, 256u, 511u })
    {
        CellCoord const coord = Acore::ComputeCellCoord(CellCenter(cell), CellCenter(cell));
        EXPECT_EQ(coord.x_coord, cell);
        EXPECT_EQ(coord.y_coord, cell);
    }
}

TEST_F(MapPartitionOwnershipTest, SetMapAssignsTheDefaultPartitionProvisionally)
{
    TestCreature* creature = SpawnAtCell(32, 32);
    EXPECT_EQ(creature->GetPartition(), &_map->GetSerialSet());
}

TEST_F(MapPartitionOwnershipTest, InteriorEntityIsOwnedByItsGeometricPartition)
{
    TestCreature* creature = SpawnAtCell(32, 32);
    EXPECT_EQ(&_map->ComputeOwner(creature), _map->GetPartition(0));

    creature->Relocate(CellCenter(96), CellCenter(32), 0.0f); // partition column 1
    EXPECT_EQ(&_map->ComputeOwner(creature), _map->GetPartition(1));
}

TEST_F(MapPartitionOwnershipTest, BorderStripEntityIsOwnedByTheSerialSet)
{
    TestCreature* creature = SpawnAtCell(63, 32);
    EXPECT_EQ(&_map->ComputeOwner(creature), &_map->GetSerialSet());

    creature->Relocate(CellCenter(64), CellCenter(32), 0.0f);
    EXPECT_EQ(&_map->ComputeOwner(creature), &_map->GetSerialSet());

    creature->Relocate(CellCenter(66), CellCenter(32), 0.0f); // just outside the strip
    EXPECT_EQ(&_map->ComputeOwner(creature), _map->GetPartition(1));
}

TEST_F(MapPartitionOwnershipTest, LinkInsideOnePartitionKeepsBothThere)
{
    TestCreature* owner = SpawnAtCell(20, 20);
    TestCreature* pet = SpawnAtCell(21, 20);
    owner->m_Controlled.insert(pet);

    EXPECT_EQ(&_map->ComputeOwner(owner), _map->GetPartition(0));
    EXPECT_EQ(&_map->ComputeOwner(pet), _map->GetPartition(0));
}

TEST_F(MapPartitionOwnershipTest, LinkAcrossPartitionsMovesTheLinkedEntityToTheSerialSet)
{
    TestCreature* owner = SpawnAtCell(20, 20);    // partition 0
    TestCreature* pet = SpawnAtCell(100, 20);     // partition 1
    owner->m_Controlled.insert(pet);

    EXPECT_EQ(&_map->ComputeOwner(owner), &_map->GetSerialSet());
}

TEST_F(MapPartitionOwnershipTest, LinkToABorderEntityMovesTheLinkedEntityToTheSerialSet)
{
    TestCreature* owner = SpawnAtCell(20, 20);    // partition 0 interior
    TestCreature* pet = SpawnAtCell(63, 20);      // border strip
    owner->m_Controlled.insert(pet);

    EXPECT_EQ(&_map->ComputeOwner(owner), &_map->GetSerialSet());
}

TEST_F(MapPartitionOwnershipTest, LinkToAnEntityOutOfWorldMovesToTheSerialSet)
{
    TestCreature* owner = SpawnAtCell(20, 20);
    TestCreature* pet = SpawnAtCell(21, 20);
    pet->SetInWorld(false);
    owner->m_Controlled.insert(pet);

    EXPECT_EQ(&_map->ComputeOwner(owner), &_map->GetSerialSet());
}

TEST_F(MapPartitionOwnershipTest, PinnedEntityIsOwnedByTheSerialSet)
{
    TestCreature* creature = SpawnAtCell(32, 32);
    _map->PinToSerialSet(creature->GetGUID());
    EXPECT_TRUE(_map->IsPinnedToSerialSet(creature->GetGUID()));
    EXPECT_EQ(&_map->ComputeOwner(creature), &_map->GetSerialSet());

    _map->UnpinFromSerialSet(creature->GetGUID());
    EXPECT_EQ(&_map->ComputeOwner(creature), _map->GetPartition(0));
}

TEST_F(MapPartitionOwnershipTest, NewObjectFromARunningPartitionIsOwnedByItOrTheSerialSet)
{
    TestCreature* nearby = SpawnAtCell(32, 32);   // partition 0 interior
    TestCreature* far = SpawnAtCell(100, 32);     // partition 1 interior

    // Serial phase: the geometric owner.
    EXPECT_EQ(&_map->GetOwnerForNewObject(far), _map->GetPartition(1));

    // Added while partition 0 runs: it can own what is in its interior, nothing else.
    MapPartition::Scope scope(*_map->GetPartition(0));
    EXPECT_EQ(&_map->GetOwnerForNewObject(nearby), _map->GetPartition(0));
    EXPECT_EQ(&_map->GetOwnerForNewObject(far), &_map->GetSerialSet());
}

TEST_F(MapPartitionOwnershipTest, FieldUpdatesAreQueuedOnTheOwnerAndRemovedDirectly)
{
    TestCreature* creature = SpawnAtCell(32, 32);
    MapPartition* owner = _map->GetPartition(0);
    creature->SetPartition(owner);
    EXPECT_EQ(&_map->GetOwnerPartition(creature), owner);

    // Serial phase: queued on the owner partition.
    _map->AddUpdateObject(creature);
    EXPECT_EQ(owner->GetUpdateObjects().count(creature), 1u);

    // The owner's own thread removes it with a direct lookup, nothing is deferred.
    {
        MapPartition::Scope scope(*owner);
        _map->RemoveUpdateObject(creature);
    }
    EXPECT_TRUE(owner->GetUpdateObjects().empty());
    EXPECT_TRUE(owner->GetOutbox().IsEmpty());
}

TEST_F(MapPartitionOwnershipTest, SerialSetEntriesAreNotWrittenWhilePartitionsRun)
{
    TestCreature* borderCreature = SpawnAtCell(63, 32); // owned by the serial set
    MapPartition& serialSet = _map->GetSerialSet();
    MapPartition* partition = _map->GetPartition(0);
    ASSERT_EQ(borderCreature->GetPartition(), &serialSet);

    _map->AddUpdateObject(borderCreature);
    ASSERT_EQ(serialSet.GetUpdateObjects().count(borderCreature), 1u);

    {
        MapPartition::Scope scope(*partition);

        // Touched from partition 0: queued in partition 0's own set.
        _map->AddUpdateObject(borderCreature);
        EXPECT_EQ(partition->GetUpdateObjects().count(borderCreature), 1u);

        // Removal: partition 0's entry now, the serial set's entry deferred to POST-UPDATE.
        _map->RemoveUpdateObject(borderCreature);
        EXPECT_TRUE(partition->GetUpdateObjects().empty());
        EXPECT_EQ(serialSet.GetUpdateObjects().count(borderCreature), 1u);
        ASSERT_EQ(partition->GetOutbox().DeferredUpdateObjectRemovals.size(), 1u);
    }

    _map->ApplyPartitionOutbox(*partition);
    EXPECT_TRUE(serialSet.GetUpdateObjects().empty());
    EXPECT_TRUE(partition->GetOutbox().IsEmpty());
}
