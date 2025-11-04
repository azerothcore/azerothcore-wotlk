/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "BattlegroundMMR.h"
#include "gtest/gtest.h"
#include <cmath>

/**
 * Queue Relaxation Unit Tests
 *
 * Tests the queue relaxation system to ensure tolerance increases
 * correctly over time according to configuration.
 */

class QueueRelaxationTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        // Initialize the MMR manager
        sBattlegroundMMRMgr->LoadConfig();
    }

    void TearDown() override
    {
        // Cleanup if needed
    }

    // Helper to compare floats with tolerance
    bool FloatEquals(float a, float b, float epsilon = 0.01f)
    {
        return std::abs(a - b) < epsilon;
    }
};

// =============================================================================
// Basic Relaxation Tests
// =============================================================================

TEST_F(QueueRelaxationTest, InitialToleranceReturned)
{
    // At queue time 0, should return initial tolerance
    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(0);

    // Default config: initial tolerance = 200
    EXPECT_FLOAT_EQ(tolerance, 200.0f)
        << "At queue time 0, should return initial tolerance of 200";
}

TEST_F(QueueRelaxationTest, NoRelaxationBeforeInterval)
{
    // Before the first interval completes, tolerance should remain constant
    // Default config: interval = 120s
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(0), 200.0f);
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(30), 200.0f);
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(60), 200.0f);
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(90), 200.0f);
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(119), 200.0f);
}

TEST_F(QueueRelaxationTest, RelaxationAfterFirstInterval)
{
    // At 120s (exactly 1 interval), tolerance should increase by one step
    // Default config: initial=200, interval=120s, step=100
    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(120);

    EXPECT_FLOAT_EQ(tolerance, 300.0f)
        << "After 120s (1 interval), tolerance should be 200 + 100 = 300";
}

TEST_F(QueueRelaxationTest, RelaxationAfterMultipleIntervals)
{
    // Test multiple intervals
    // Default config: initial=200, interval=120s, step=100

    // 2 intervals: 200 + 2*100 = 400
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(240), 400.0f)
        << "After 240s (2 intervals), tolerance should be 400";

    // 3 intervals: 200 + 3*100 = 500
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(360), 500.0f)
        << "After 360s (3 intervals), tolerance should be 500";

    // 4 intervals: 200 + 4*100 = 600
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(480), 600.0f)
        << "After 480s (4 intervals), tolerance should be 600";
}

// =============================================================================
// Edge Case Tests
// =============================================================================

TEST_F(QueueRelaxationTest, PartialIntervalRoundsDown)
{
    // Only complete intervals count
    // At 239s, that's 1.99 intervals, but only 1 complete interval
    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(239);

    EXPECT_FLOAT_EQ(tolerance, 300.0f)
        << "At 239s (1.99 intervals), should still be 300 (only 1 full interval)";
}

TEST_F(QueueRelaxationTest, MaxRelaxationReached)
{
    // At max wait time, tolerance becomes unlimited
    // Default config: maxSeconds = 600
    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(600);

    EXPECT_FLOAT_EQ(tolerance, 999999.0f)
        << "At max wait time (600s), tolerance should be unlimited (999999)";
}

TEST_F(QueueRelaxationTest, BeyondMaxRelaxation)
{
    // Beyond max time, tolerance remains unlimited
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(700), 999999.0f);
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(1000), 999999.0f);
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(9999), 999999.0f);
}

TEST_F(QueueRelaxationTest, ZeroQueueTime)
{
    // Edge case: zero queue time
    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(0);

    EXPECT_FLOAT_EQ(tolerance, 200.0f)
        << "Zero queue time should return initial tolerance";
}

TEST_F(QueueRelaxationTest, VeryLongQueueTime)
{
    // Extreme edge case: very long queue time
    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(UINT32_MAX);

    EXPECT_FLOAT_EQ(tolerance, 999999.0f)
        << "Extreme queue times should still return unlimited tolerance";
}

// =============================================================================
// Realistic Scenario Tests
// =============================================================================

TEST_F(QueueRelaxationTest, TypicalPeakHoursQueueing)
{
    // Peak hours: player finds match in 30 seconds
    uint32 queueTime = 30;
    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(queueTime);

    EXPECT_FLOAT_EQ(tolerance, 200.0f)
        << "Peak hours: fast queue (30s) should use strict initial tolerance";
}

TEST_F(QueueRelaxationTest, TypicalOffPeakQueueing)
{
    // Off-peak hours: player waits 4+ minutes
    uint32 queueTime = 250; // just over 2 intervals
    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(queueTime);

    EXPECT_FLOAT_EQ(tolerance, 400.0f)
        << "Off-peak: 250s queue should have relaxed to 400 (2 intervals)";
}

TEST_F(QueueRelaxationTest, DeadHoursQueueing)
{
    // Dead hours: player waits a very long time
    uint32 queueTime = 700; // past max relaxation
    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(queueTime);

    EXPECT_FLOAT_EQ(tolerance, 999999.0f)
        << "Dead hours: long queue (700s) should have unlimited tolerance";
}

// =============================================================================
// Integration with Matchmaking Tests
// =============================================================================

TEST_F(QueueRelaxationTest, TwoPlayersWithinInitialTolerance)
{
    // Players with similar MMR should match immediately
    float playerA_MMR = 1500.0f;
    float playerB_MMR = 1600.0f;
    uint32 queueTime = 10;

    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(queueTime);
    float difference = std::abs(playerA_MMR - playerB_MMR);

    EXPECT_LT(difference, tolerance)
        << "Players with 100 MMR difference should match within 200 tolerance";
}

TEST_F(QueueRelaxationTest, TwoPlayersOutsideInitialTolerance)
{
    // Players with very different MMR should not match initially
    float playerA_MMR = 1500.0f;
    float playerB_MMR = 1800.0f; // 300 MMR difference
    uint32 queueTime = 10;

    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(queueTime);
    float difference = std::abs(playerA_MMR - playerB_MMR);

    EXPECT_GT(difference, tolerance)
        << "Players with 300 MMR difference should not match within 200 tolerance";
}

TEST_F(QueueRelaxationTest, MatchAfterRelaxation)
{
    // After waiting long enough, players can match
    float playerA_MMR = 1500.0f;
    float playerB_MMR = 1800.0f; // 300 MMR difference
    uint32 queueTime = 250; // past 2 intervals

    float tolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(queueTime);
    float difference = std::abs(playerA_MMR - playerB_MMR);

    EXPECT_LT(difference, tolerance)
        << "After 250s wait, 300 MMR difference should fit within 400 tolerance";
}

// =============================================================================
// Boundary Tests
// =============================================================================

TEST_F(QueueRelaxationTest, ExactIntervalBoundary)
{
    // Verify behavior exactly at interval boundaries

    // One second before first interval
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(119), 200.0f);

    // Exactly at first interval
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(120), 300.0f);

    // One second after first interval
    EXPECT_FLOAT_EQ(sBattlegroundMMRMgr->GetRelaxedMMRTolerance(121), 300.0f);
}

TEST_F(QueueRelaxationTest, ToleranceNeverDecreases)
{
    // Tolerance should monotonically increase with time
    float prevTolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(0);

    for (uint32 time = 1; time <= 600; time += 10)
    {
        float currentTolerance = sBattlegroundMMRMgr->GetRelaxedMMRTolerance(time);

        EXPECT_GE(currentTolerance, prevTolerance)
            << "Tolerance at " << time << "s should never be less than at " << (time-10) << "s";

        prevTolerance = currentTolerance;
    }
}
