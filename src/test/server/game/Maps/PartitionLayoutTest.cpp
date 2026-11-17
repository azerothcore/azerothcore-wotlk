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
 * Map partitioning, Step 1 (.agents/plans/map-partitioning/PLAN.md):
 * PartitionLayout cell -> partition mapping, border-strip classification,
 * and the MapPartitioned / MapPartition scaffolding.
 */

#include "MapPartitioned.h"
#include "TestMap.h"
#include "WorldMock.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include <algorithm>
#include <cmath>
#include <limits>

using namespace testing;

namespace
{

constexpr uint32 CELLS_PER_SIDE = TOTAL_NUMBER_OF_CELLS_PER_MAP; // 512

// Checks, for every cell, that border classification is exactly the set of cells
// that have a cell of another partition within `border` cells (Chebyshev distance).
// "Sufficient": a non-border cell can't reach another partition within the strip width,
// so interactions of that range from an interior entity stay in its partition.
// "Minimal": a border cell really is within reach of another partition.
void ExpectBorderIsExactlyReachOfOtherPartitions(PartitionLayout const& layout)
{
    int32 const border = int32(layout.GetBorderCells());

    for (uint32 x = 0; x < CELLS_PER_SIDE; ++x)
    {
        for (uint32 y = 0; y < CELLS_PER_SIDE; ++y)
        {
            CellCoord const cell(x, y);
            uint32 const partition = layout.GetPartitionIndex(cell);

            bool reachesOtherPartition = false;
            for (int32 dx = -border; dx <= border && !reachesOtherPartition; ++dx)
            {
                for (int32 dy = -border; dy <= border; ++dy)
                {
                    int32 const nx = int32(x) + dx;
                    int32 const ny = int32(y) + dy;
                    if (nx < 0 || ny < 0 || nx >= int32(CELLS_PER_SIDE) || ny >= int32(CELLS_PER_SIDE))
                        continue;

                    if (layout.GetPartitionIndex(CellCoord(nx, ny)) != partition)
                    {
                        reachesOtherPartition = true;
                        break;
                    }
                }
            }

            ASSERT_EQ(layout.IsBorderCell(cell), reachesOtherPartition)
                << "cell (" << x << ", " << y << "), gridsPerPartition " << layout.GetGridsPerPartition()
                << ", borderCells " << border;
        }
    }
}

} // namespace

// ---------------------------------------------------------------------------
// PartitionLayout: configuration
// ---------------------------------------------------------------------------

TEST(PartitionLayoutTest, DefaultLayout)
{
    PartitionLayout const layout;

    EXPECT_EQ(layout.GetGridsPerPartition(), 8u);
    EXPECT_EQ(layout.GetCellsPerPartition(), 64u);
    EXPECT_EQ(layout.GetBorderCells(), 2u);
    EXPECT_EQ(layout.GetPartitionsPerSide(), 8u);
    EXPECT_EQ(layout.GetPartitionCount(), 64u);
}

TEST(PartitionLayoutTest, ClampsConfiguration)
{
    PartitionLayout const tooSmall(0, 2);
    EXPECT_EQ(tooSmall.GetGridsPerPartition(), 1u);
    EXPECT_EQ(tooSmall.GetPartitionCount(), uint32(MAX_NUMBER_OF_GRIDS * MAX_NUMBER_OF_GRIDS));

    PartitionLayout const tooLarge(1000, 2);
    EXPECT_EQ(tooLarge.GetGridsPerPartition(), uint32(MAX_NUMBER_OF_GRIDS));
    EXPECT_EQ(tooLarge.GetPartitionCount(), 1u);

    PartitionLayout const hugeBorder(8, 1000);
    EXPECT_EQ(hugeBorder.GetBorderCells(), hugeBorder.GetCellsPerPartition());
}

TEST(PartitionLayoutTest, UnevenTilingHasNarrowerLastPartition)
{
    PartitionLayout const layout(6, 2); // 48 cells per partition, 64 grids / 6 -> 11 per side

    EXPECT_EQ(layout.GetCellsPerPartition(), 48u);
    EXPECT_EQ(layout.GetPartitionsPerSide(), 11u);
    EXPECT_EQ(layout.GetPartitionCount(), 121u);

    // Last column starts at cell 480 and is only 32 cells wide.
    EXPECT_EQ(layout.GetPartitionIndex(CellCoord(479, 0)), 9u);
    EXPECT_EQ(layout.GetPartitionIndex(CellCoord(480, 0)), 10u);
    EXPECT_EQ(layout.GetPartitionIndex(CellCoord(511, 511)), 120u);
}

// ---------------------------------------------------------------------------
// PartitionLayout: cell -> partition index
// ---------------------------------------------------------------------------

TEST(PartitionLayoutTest, CellToPartitionIndexIsRowMajor)
{
    PartitionLayout const layout;

    EXPECT_EQ(layout.GetPartitionIndex(CellCoord(0, 0)), 0u);
    EXPECT_EQ(layout.GetPartitionIndex(CellCoord(63, 63)), 0u);
    EXPECT_EQ(layout.GetPartitionIndex(CellCoord(64, 0)), 1u);
    EXPECT_EQ(layout.GetPartitionIndex(CellCoord(0, 64)), 8u);
    EXPECT_EQ(layout.GetPartitionIndex(CellCoord(130, 200)), 3u * 8u + 2u);
    EXPECT_EQ(layout.GetPartitionIndex(CellCoord(511, 511)), 63u);
}

TEST(PartitionLayoutTest, EveryValidCellMapsToAValidPartition)
{
    for (uint32 gridsPerPartition : { 1u, 6u, 8u, 16u, 64u })
    {
        PartitionLayout const layout(gridsPerPartition, 2);
        for (uint32 x = 0; x < CELLS_PER_SIDE; ++x)
            for (uint32 y = 0; y < CELLS_PER_SIDE; ++y)
                ASSERT_LT(layout.GetPartitionIndex(CellCoord(x, y)), layout.GetPartitionCount());
    }
}

TEST(PartitionLayoutTest, InvalidCoordinatesMapToInvalidPartition)
{
    PartitionLayout const layout;

    EXPECT_EQ(layout.GetPartitionIndex(CellCoord(CELLS_PER_SIDE, 0)), PartitionLayout::INVALID_PARTITION);
    EXPECT_EQ(layout.GetPartitionIndex(CellCoord(0, CELLS_PER_SIDE)), PartitionLayout::INVALID_PARTITION);

    float const outside = MAP_HALFSIZE + 10.0f;
    EXPECT_EQ(layout.GetPartitionIndex(outside, 0.0f), PartitionLayout::INVALID_PARTITION);
    EXPECT_EQ(layout.GetPartitionIndex(0.0f, -outside), PartitionLayout::INVALID_PARTITION);
    EXPECT_EQ(layout.GetPartitionIndex(std::numeric_limits<float>::quiet_NaN(), 0.0f),
        PartitionLayout::INVALID_PARTITION);
}

TEST(PartitionLayoutTest, WorldPositionMatchesComputedCell)
{
    PartitionLayout const layout;

    float const positions[][2] =
    {
        { -8913.0f, 554.0f },  // Stormwind
        { 1630.0f, -4420.0f }, // Orgrimmar
        { 5804.0f, 624.0f },   // Dalaran
        { 0.0f, 0.0f },
        { MAP_HALFSIZE - 1.0f, -(MAP_HALFSIZE - 1.0f) },
    };

    for (auto const& pos : positions)
    {
        CellCoord const cell = Acore::ComputeCellCoord(pos[0], pos[1]);
        EXPECT_EQ(layout.GetPartitionIndex(pos[0], pos[1]), layout.GetPartitionIndex(cell))
            << "position (" << pos[0] << ", " << pos[1] << ")";
    }
}

// ---------------------------------------------------------------------------
// PartitionLayout: border strip
// ---------------------------------------------------------------------------

TEST(PartitionLayoutTest, BorderStripAroundInternalEdges)
{
    PartitionLayout const layout; // 64 cells per partition, border 2
    uint32 const mid = 32;        // interior on the other axis

    // Edge between partition column 0 and 1 is between cells 63 and 64.
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(61, mid)));
    EXPECT_TRUE(layout.IsBorderCell(CellCoord(62, mid)));
    EXPECT_TRUE(layout.IsBorderCell(CellCoord(63, mid)));
    EXPECT_TRUE(layout.IsBorderCell(CellCoord(64, mid)));
    EXPECT_TRUE(layout.IsBorderCell(CellCoord(65, mid)));
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(66, mid)));

    // Same along y.
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(mid, 61)));
    EXPECT_TRUE(layout.IsBorderCell(CellCoord(mid, 62)));
    EXPECT_TRUE(layout.IsBorderCell(CellCoord(mid, 65)));
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(mid, 66)));

    // Corner where four partitions meet.
    EXPECT_TRUE(layout.IsBorderCell(CellCoord(63, 63)));
    EXPECT_TRUE(layout.IsBorderCell(CellCoord(64, 64)));
}

TEST(PartitionLayoutTest, MapEdgesAreNotBorders)
{
    PartitionLayout const layout;
    uint32 const mid = 32;

    EXPECT_FALSE(layout.IsBorderCell(CellCoord(0, mid)));
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(1, mid)));
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(CELLS_PER_SIDE - 1, mid)));
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(CELLS_PER_SIDE - 2, mid)));
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(mid, 0)));
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(mid, CELLS_PER_SIDE - 1)));
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(0, 0)));
}

TEST(PartitionLayoutTest, UnevenTilingBorders)
{
    PartitionLayout const layout(6, 2); // edges at 48, 96, ..., 480; last partition 480..511
    uint32 const mid = 24;

    EXPECT_TRUE(layout.IsBorderCell(CellCoord(478, mid)));
    EXPECT_TRUE(layout.IsBorderCell(CellCoord(479, mid)));
    EXPECT_TRUE(layout.IsBorderCell(CellCoord(480, mid)));
    EXPECT_TRUE(layout.IsBorderCell(CellCoord(481, mid)));
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(482, mid)));
    // The narrow last partition ends at the map edge, which is not a border.
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(510, mid)));
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(511, mid)));
}

TEST(PartitionLayoutTest, NoBordersWithSinglePartitionOrZeroWidth)
{
    PartitionLayout const single(MAX_NUMBER_OF_GRIDS, 2);
    PartitionLayout const zeroWidth(8, 0);

    for (uint32 x = 0; x < CELLS_PER_SIDE; ++x)
    {
        for (uint32 y = 0; y < CELLS_PER_SIDE; ++y)
        {
            ASSERT_EQ(single.GetPartitionIndex(CellCoord(x, y)), 0u);
            ASSERT_FALSE(single.IsBorderCell(CellCoord(x, y)));
            ASSERT_FALSE(zeroWidth.IsBorderCell(CellCoord(x, y)));
        }
    }
}

TEST(PartitionLayoutTest, InvalidCellIsNotBorder)
{
    PartitionLayout const layout;
    EXPECT_FALSE(layout.IsBorderCell(CellCoord(CELLS_PER_SIDE, 64)));
}

TEST(PartitionLayoutTest, BorderStripIsExactlyTheReachOfOtherPartitions)
{
    ExpectBorderIsExactlyReachOfOtherPartitions(PartitionLayout(8, 2));
    ExpectBorderIsExactlyReachOfOtherPartitions(PartitionLayout(6, 2));
    ExpectBorderIsExactlyReachOfOtherPartitions(PartitionLayout(4, 3));
    ExpectBorderIsExactlyReachOfOtherPartitions(PartitionLayout(1, 1));
}

// ---------------------------------------------------------------------------
// MapPartition
// ---------------------------------------------------------------------------

TEST(MapPartitionTest, OutboxClearAndIsEmpty)
{
    MapPartition::Outbox outbox;
    EXPECT_TRUE(outbox.IsEmpty());

    outbox.GridLoadRequests.emplace_back(1, 2);
    outbox.ZonePlayerCountDeltas[12] += 1;
    EXPECT_FALSE(outbox.IsEmpty());
    outbox.Clear();
    EXPECT_TRUE(outbox.IsEmpty());

    outbox.CollisionBalanceRequested = true;
    EXPECT_FALSE(outbox.IsEmpty());
    outbox.Clear();
    EXPECT_TRUE(outbox.IsEmpty());
}

// ---------------------------------------------------------------------------
// MapPartitioned (needs a fake DBC map entry and a mocked World)
// ---------------------------------------------------------------------------

class MapPartitionedTest : public ::testing::Test
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

        TestMap::EnsureDBC(); // fake MapEntry for map 0 + script registries
        _map = new MapPartitioned(0, PartitionLayout());
    }

    void TearDown() override
    {
        delete _map;
        sWorld = std::move(_previousWorld);
    }

    std::unique_ptr<IWorld> _previousWorld;
    NiceMock<WorldMock>* _worldMock = nullptr;
    MapPartitioned* _map = nullptr;
};

TEST_F(MapPartitionedTest, ToMapPartitionedDispatch)
{
    Map* asMap = _map;
    Map const* asConstMap = _map;
    EXPECT_EQ(asMap->ToMapPartitioned(), _map);
    EXPECT_EQ(asConstMap->ToMapPartitioned(), _map);

    TestMap plain;
    EXPECT_EQ(plain.ToMapPartitioned(), nullptr);
    EXPECT_EQ(static_cast<Map const&>(plain).ToMapPartitioned(), nullptr);
}

TEST_F(MapPartitionedTest, CreatesOnePartitionPerLayoutSlot)
{
    ASSERT_EQ(_map->GetPartitionCount(), _map->GetLayout().GetPartitionCount());

    for (uint32 i = 0; i < _map->GetPartitionCount(); ++i)
    {
        MapPartition* partition = _map->GetPartition(i);
        ASSERT_NE(partition, nullptr);
        EXPECT_EQ(partition->GetIndex(), i);
        EXPECT_FALSE(partition->IsSerialSet());
        EXPECT_EQ(&partition->GetOwner(), _map);
        EXPECT_TRUE(partition->IsEmpty());
        EXPECT_TRUE(partition->GetOutbox().IsEmpty());
    }

    EXPECT_EQ(_map->GetPartition(_map->GetPartitionCount()), nullptr);
    EXPECT_EQ(_map->GetPartition(PartitionLayout::INVALID_PARTITION), nullptr);
}

TEST_F(MapPartitionedTest, PartitionForCell)
{
    MapPartition* partition = _map->GetPartitionForCell(CellCoord(130, 200));
    ASSERT_NE(partition, nullptr);
    EXPECT_EQ(partition->GetIndex(), 26u);

    EXPECT_EQ(_map->GetPartitionForCell(CellCoord(CELLS_PER_SIDE, 0)), nullptr);
}

TEST_F(MapPartitionedTest, SerialSetIsSeparateFromPartitions)
{
    MapPartition& serialSet = _map->GetSerialSet();
    EXPECT_TRUE(serialSet.IsSerialSet());
    EXPECT_EQ(serialSet.GetIndex(), MapPartition::SERIAL_SET_INDEX);
    EXPECT_EQ(&serialSet.GetOwner(), _map);

    for (uint32 i = 0; i < _map->GetPartitionCount(); ++i)
        EXPECT_NE(_map->GetPartition(i), &serialSet);
}

TEST_F(MapPartitionedTest, NotInParallelPhaseByDefault)
{
    EXPECT_FALSE(_map->IsInParallelPhase());
}

TEST_F(MapPartitionedTest, ScopeInstallsAndRestoresCurrentPartition)
{
    MapPartition* first = _map->GetPartition(0);
    MapPartition* second = _map->GetPartition(1);

    EXPECT_EQ(MapPartition::GetCurrent(), nullptr);
    {
        MapPartition::Scope outer(*first);
        EXPECT_EQ(MapPartition::GetCurrent(), first);
        {
            MapPartition::Scope inner(*second);
            EXPECT_EQ(MapPartition::GetCurrent(), second);
        }
        EXPECT_EQ(MapPartition::GetCurrent(), first);
    }
    EXPECT_EQ(MapPartition::GetCurrent(), nullptr);
}
