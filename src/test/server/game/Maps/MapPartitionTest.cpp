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
#include "gtest/gtest.h"

class PartitionBoundsTest : public ::testing::Test
{
protected:
    PartitionBounds bounds;
    
    void SetUp() override
    {
        bounds = PartitionBounds(0.0f, 1000.0f, 0.0f, 1000.0f);
    }
};

TEST_F(PartitionBoundsTest, Contains_InsideBounds)
{
    EXPECT_TRUE(bounds.Contains(0.0f, 0.0f));              // Min corner
    EXPECT_TRUE(bounds.Contains(500.0f, 500.0f));          // Center
    EXPECT_TRUE(bounds.Contains(999.0f, 999.0f));          // Near max corner
    EXPECT_TRUE(bounds.Contains(100.0f, 500.0f));          // Various positions
    EXPECT_TRUE(bounds.Contains(900.0f, 100.0f));
}

TEST_F(PartitionBoundsTest, Contains_OutsideBounds)
{
    EXPECT_FALSE(bounds.Contains(-1.0f, 0.0f));            // Below min X
    EXPECT_FALSE(bounds.Contains(0.0f, -1.0f));            // Below min Y
    EXPECT_FALSE(bounds.Contains(1000.0f, 500.0f));        // At/beyond max X
    EXPECT_FALSE(bounds.Contains(500.0f, 1000.0f));        // At/beyond max Y
    EXPECT_FALSE(bounds.Contains(1100.0f, 1100.0f));       // Well beyond max
    EXPECT_FALSE(bounds.Contains(-100.0f, -100.0f));       // Well below min
}

TEST_F(PartitionBoundsTest, Contains_BoundaryEdgeCases)
{
    EXPECT_TRUE(bounds.Contains(0.0f, 0.0f));              // Min corner (inclusive)
    EXPECT_FALSE(bounds.Contains(1000.0f, 0.0f));          // Max X boundary (exclusive)
    EXPECT_FALSE(bounds.Contains(0.0f, 1000.0f));          // Max Y boundary (exclusive)
    EXPECT_TRUE(bounds.Contains(999.999f, 999.999f));     // Just inside max
}

TEST_F(PartitionBoundsTest, IsNearBorder_WithMargin)
{
    float margin = 100.0f;
    
    // Near borders
    EXPECT_TRUE(bounds.IsNearBorder(50.0f, 500.0f, margin));     // Near min X
    EXPECT_TRUE(bounds.IsNearBorder(950.0f, 500.0f, margin));    // Near max X
    EXPECT_TRUE(bounds.IsNearBorder(500.0f, 50.0f, margin));     // Near min Y
    EXPECT_TRUE(bounds.IsNearBorder(500.0f, 950.0f, margin));    // Near max Y
    
    // In center
    EXPECT_FALSE(bounds.IsNearBorder(500.0f, 500.0f, margin));
    
    // Exactly at margin distance
    EXPECT_TRUE(bounds.IsNearBorder(100.0f, 500.0f, margin));    // Exactly margin from min X
    EXPECT_TRUE(bounds.IsNearBorder(900.0f, 500.0f, margin));    // Exactly margin from max X
}

TEST_F(PartitionBoundsTest, IsNearBorder_MultipleMargins)
{
    // Test with different margin sizes
    EXPECT_TRUE(bounds.IsNearBorder(25.0f, 500.0f, 50.0f));     // Margin 50
    EXPECT_FALSE(bounds.IsNearBorder(75.0f, 500.0f, 50.0f));    // Not near with margin 50
    
    EXPECT_TRUE(bounds.IsNearBorder(150.0f, 500.0f, 200.0f));   // Margin 200
    EXPECT_FALSE(bounds.IsNearBorder(250.0f, 500.0f, 200.0f));  // Not near with margin 200
}

TEST_F(PartitionBoundsTest, GetCenter)
{
    EXPECT_FLOAT_EQ(bounds.GetCenterX(), 500.0f);
    EXPECT_FLOAT_EQ(bounds.GetCenterY(), 500.0f);
    
    // Test with different bounds
    PartitionBounds bounds2(-1000.0f, 1000.0f, -500.0f, 500.0f);
    EXPECT_FLOAT_EQ(bounds2.GetCenterX(), 0.0f);
    EXPECT_FLOAT_EQ(bounds2.GetCenterY(), 0.0f);
}

TEST_F(PartitionBoundsTest, GetDimensions)
{
    EXPECT_FLOAT_EQ(bounds.GetWidth(), 1000.0f);
    EXPECT_FLOAT_EQ(bounds.GetHeight(), 1000.0f);
    
    // Test with asymmetric bounds
    PartitionBounds bounds2(0.0f, 500.0f, 0.0f, 1000.0f);
    EXPECT_FLOAT_EQ(bounds2.GetWidth(), 500.0f);
    EXPECT_FLOAT_EQ(bounds2.GetHeight(), 1000.0f);
}

TEST_F(PartitionBoundsTest, NegativeCoordinates)
{
    // Test with negative coordinate bounds
    PartitionBounds negativeBounds(-2000.0f, -1000.0f, -1500.0f, -500.0f);
    
    EXPECT_TRUE(negativeBounds.Contains(-2000.0f, -1500.0f));   // Min corner
    EXPECT_TRUE(negativeBounds.Contains(-1500.0f, -1000.0f));   // Center
    EXPECT_FALSE(negativeBounds.Contains(-500.0f, 0.0f));       // Outside
    EXPECT_FALSE(negativeBounds.Contains(-2001.0f, -1500.0f));  // Below min
    
    EXPECT_FLOAT_EQ(negativeBounds.GetCenterX(), -1500.0f);
    EXPECT_FLOAT_EQ(negativeBounds.GetCenterY(), -1000.0f);
    EXPECT_FLOAT_EQ(negativeBounds.GetWidth(), 1000.0f);
    EXPECT_FLOAT_EQ(negativeBounds.GetHeight(), 1000.0f);
}

TEST_F(PartitionBoundsTest, BorderDetection_AllFourSides)
{
    float margin = 100.0f;
    
    // Test all four borders with positions clearly inside margin
    EXPECT_TRUE(bounds.IsNearBorder(50.0f, 50.0f, margin));      // Near min X and min Y corner
    EXPECT_TRUE(bounds.IsNearBorder(950.0f, 50.0f, margin));     // Near max X and min Y corner
    EXPECT_TRUE(bounds.IsNearBorder(50.0f, 950.0f, margin));     // Near min X and max Y corner
    EXPECT_TRUE(bounds.IsNearBorder(950.0f, 950.0f, margin));    // Near max X and max Y corner
    
    // Far from all borders
    EXPECT_FALSE(bounds.IsNearBorder(500.0f, 500.0f, margin));
    EXPECT_FALSE(bounds.IsNearBorder(300.0f, 700.0f, margin));
    EXPECT_FALSE(bounds.IsNearBorder(700.0f, 300.0f, margin));
}

TEST_F(PartitionBoundsTest, ZeroSizedBounds)
{
    // zero-sized bounds (single point)
    PartitionBounds pointBounds(100.0f, 100.0f, 200.0f, 200.0f);
    
    EXPECT_FLOAT_EQ(pointBounds.GetWidth(), 0.0f);
    EXPECT_FLOAT_EQ(pointBounds.GetHeight(), 0.0f);
    EXPECT_FLOAT_EQ(pointBounds.GetCenterX(), 100.0f);
    EXPECT_FLOAT_EQ(pointBounds.GetCenterY(), 200.0f);
    
    EXPECT_FALSE(pointBounds.Contains(100.0f, 200.0f));
}

TEST_F(PartitionBoundsTest, LargeBounds_WoWContinentScale)
{
    // Test with WoW continent-sized bounds
    PartitionBounds continentBounds(-17066.666f, 17066.666f, -17066.666f, 17066.666f);
    
    EXPECT_TRUE(continentBounds.Contains(0.0f, 0.0f));                    // Center
    EXPECT_TRUE(continentBounds.Contains(-17000.0f, -17000.0f));          // Near min corner
    EXPECT_TRUE(continentBounds.Contains(17000.0f, 17000.0f));            // Near max corner
    EXPECT_FALSE(continentBounds.Contains(-20000.0f, 0.0f));              // Outside
    
    EXPECT_FLOAT_EQ(continentBounds.GetCenterX(), 0.0f);
    EXPECT_FLOAT_EQ(continentBounds.GetCenterY(), 0.0f);
    EXPECT_FLOAT_EQ(continentBounds.GetWidth(), 34133.332f);
    
    // Test border detection with large bounds
    EXPECT_TRUE(continentBounds.IsNearBorder(-17000.0f, 0.0f, 100.0f));  // Near edge
    EXPECT_FALSE(continentBounds.IsNearBorder(0.0f, 0.0f, 100.0f));      // Center, far from edges
}

TEST_F(PartitionBoundsTest, VerySmallMargin)
{
    // Test with very small margin (1 yard)
    float smallMargin = 1.0f;
    
    EXPECT_TRUE(bounds.IsNearBorder(0.5f, 500.0f, smallMargin));      // 0.5 from min X
    EXPECT_FALSE(bounds.IsNearBorder(2.0f, 500.0f, smallMargin));     // 2.0 from min X
    EXPECT_TRUE(bounds.IsNearBorder(999.5f, 500.0f, smallMargin));    // 0.5 from max X
    EXPECT_FALSE(bounds.IsNearBorder(998.0f, 500.0f, smallMargin));   // 2.0 from max X
}

TEST_F(PartitionBoundsTest, VeryLargeMargin)
{
    // Test with very large margin
    float largeMargin = 500.0f;
    
    // With 500 yard margin on 1000x1000 bounds
    EXPECT_TRUE(bounds.IsNearBorder(100.0f, 500.0f, largeMargin));
    EXPECT_TRUE(bounds.IsNearBorder(900.0f, 500.0f, largeMargin));
    EXPECT_TRUE(bounds.IsNearBorder(500.0f, 100.0f, largeMargin));
    EXPECT_TRUE(bounds.IsNearBorder(500.0f, 900.0f, largeMargin));
    
    // Only exact center is NOT near border with 500 yard margin
    EXPECT_FALSE(bounds.IsNearBorder(500.0f, 500.0f, largeMargin));
}
