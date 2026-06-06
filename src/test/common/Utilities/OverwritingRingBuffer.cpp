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

#include "OverwritingRingBuffer.h"
#include "gtest/gtest.h"

#include <vector>

namespace
{
    struct NonDefaultConstructibleValue
    {
        NonDefaultConstructibleValue() = delete;
        explicit NonDefaultConstructibleValue(int value) : Value(value) { }

        int Value;
    };

    bool operator==(NonDefaultConstructibleValue const& left, NonDefaultConstructibleValue const& right)
    {
        return left.Value == right.Value;
    }
}

TEST(OverwritingRingBufferTest, SnapshotReturnsValuesInWriteOrder)
{
    OverwritingRingBuffer<int> buffer(3);

    buffer.Emplace(1);
    buffer.Emplace(2);

    EXPECT_EQ(buffer.Position(), 2u);
    EXPECT_EQ(buffer.Size(), 2u);
    EXPECT_EQ(buffer.Snapshot(), std::vector<int>({ 1, 2 }));
}

TEST(OverwritingRingBufferTest, OverwritesOldestValues)
{
    OverwritingRingBuffer<int> buffer(3);

    buffer.Emplace(1);
    buffer.Emplace(2);
    buffer.Emplace(3);
    buffer.Emplace(4);
    buffer.Emplace(5);

    EXPECT_EQ(buffer.Position(), 5u);
    EXPECT_EQ(buffer.Size(), 3u);
    EXPECT_EQ(buffer.Snapshot(), std::vector<int>({ 3, 4, 5 }));
}

TEST(OverwritingRingBufferTest, SnapshotIsIndependent)
{
    OverwritingRingBuffer<int> buffer(2);

    buffer.Emplace(1);
    std::vector<int> snapshot = buffer.Snapshot();

    buffer.Emplace(2);
    buffer.Emplace(3);

    EXPECT_EQ(snapshot, std::vector<int>({ 1 }));
    EXPECT_EQ(buffer.Snapshot(), std::vector<int>({ 2, 3 }));
}

TEST(OverwritingRingBufferTest, EmplaceDoesNotRequireDefaultConstructibleValues)
{
    OverwritingRingBuffer<NonDefaultConstructibleValue> buffer(2);

    buffer.Emplace(1);
    buffer.Emplace(2);
    buffer.Emplace(3);

    EXPECT_EQ(buffer.Snapshot(), std::vector<NonDefaultConstructibleValue>({
        NonDefaultConstructibleValue(2),
        NonDefaultConstructibleValue(3)
    }));
}
