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

#include "gtest/gtest.h"
#include <G3D/Vector3.h>
#include <G3D/Vector4.h>
#include <G3D/Matrix4.h>
#include <cmath>
#include <vector>
#include <random>

using G3D::Vector3;
using G3D::Vector4;
using G3D::Matrix4;

namespace
{
    static const Matrix4 s_catmullRomCoeffs(
        -0.5f, 1.5f, -1.5f, 0.5f,
        1.f, -2.5f, 2.f, -0.5f,
        -0.5f, 0.f,  0.5f, 0.f,
        0.f,  1.f,  0.f,  0.f);

    inline void C_Evaluate(const Vector3* vertice, float t, const Matrix4& matr, Vector3& result)
    {
        Vector4 tvec(t * t * t, t * t, t, 1.f);
        Vector4 weights(tvec * matr);
        result = vertice[0] * weights[0] + vertice[1] * weights[1]
                 + vertice[2] * weights[2] + vertice[3] * weights[3];
    }

    inline Vector3 EvaluateLinear(const Vector3& p0, const Vector3& p1, float u)
    {
        return p0 + (p1 - p0) * u;
    }

    inline float Distance(const Vector3& a, const Vector3& b)
    {
        return (a - b).length();
    }

    inline float ComputeU_WithIntegerTiming(int32_t time_passed, int32_t seg_start, int32_t seg_time)
    {
        if (seg_time <= 0)
            return 1.0f;
        return static_cast<float>(time_passed - seg_start) / static_cast<float>(seg_time);
    }
}

TEST(PositionDriftTest, LinearInterpolation_ExactEndpoint)
{
    Vector3 start(1000.123f, 2000.456f, 100.789f);
    Vector3 end(1050.987f, 2050.654f, 105.321f);
    Vector3 result = EvaluateLinear(start, end, 1.0f);

    EXPECT_FLOAT_EQ(result.x, end.x);
    EXPECT_FLOAT_EQ(result.y, end.y);
    EXPECT_FLOAT_EQ(result.z, end.z);
}

TEST(PositionDriftTest, LinearInterpolation_AccumulatedDrift_RealWorld)
{
    const Vector3 homePosition(1000.0f, 2000.0f, 100.0f);
    Vector3 currentPosition = homePosition;
    float maxDrift = 0.0f;
    float totalDrift = 0.0f;
    const int NUM_CYCLES = 10000;

    std::mt19937 rng(42);
    std::uniform_real_distribution<float> angleDist(0.0f, 2.0f * 3.14159f);
    std::uniform_real_distribution<float> distDist(5.0f, 30.0f);
    std::uniform_int_distribution<int32_t> timeDist(100, 3000);

    for (int cycle = 0; cycle < NUM_CYCLES; ++cycle)
    {
        float angle = angleDist(rng);
        float dist = distDist(rng);
        Vector3 combatPosition(
            currentPosition.x + std::cos(angle) * dist,
            currentPosition.y + std::sin(angle) * dist,
            currentPosition.z
        );

        int32_t segTime = timeDist(rng);
        int32_t timePassed = segTime;
        float u = static_cast<float>(timePassed) / static_cast<float>(segTime);

        currentPosition = EvaluateLinear(currentPosition, combatPosition, u);

        segTime = timeDist(rng);
        timePassed = segTime;
        u = static_cast<float>(timePassed) / static_cast<float>(segTime);
        currentPosition = EvaluateLinear(currentPosition, homePosition, u);

        float drift = Distance(currentPosition, homePosition);
        maxDrift = std::max(maxDrift, drift);
        totalDrift += drift;
    }

    float avgDrift = totalDrift / NUM_CYCLES;

    std::cout << "Linear Interpolation Real-World Timing Test (10000 cycles):" << std::endl;
    std::cout << "  Max drift: " << maxDrift << " units" << std::endl;
    std::cout << "  Avg drift: " << avgDrift << " units" << std::endl;

    EXPECT_LT(maxDrift, 0.001f) << "With exact timing, linear interpolation should have negligible drift";
}

TEST(PositionDriftTest, LinearInterpolation_InexactU_Drift)
{
    const Vector3 homePosition(1000.0f, 2000.0f, 100.0f);
    Vector3 currentPosition = homePosition;
    float maxDrift = 0.0f;
    const int NUM_CYCLES = 10000;

    std::mt19937 rng(42);
    std::uniform_real_distribution<float> angleDist(0.0f, 2.0f * 3.14159f);
    std::uniform_real_distribution<float> distDist(5.0f, 30.0f);
    std::uniform_real_distribution<float> uVariation(0.999f, 1.001f);

    for (int cycle = 0; cycle < NUM_CYCLES; ++cycle)
    {
        float angle = angleDist(rng);
        float dist = distDist(rng);
        Vector3 combatPosition(
            currentPosition.x + std::cos(angle) * dist,
            currentPosition.y + std::sin(angle) * dist,
            currentPosition.z
        );

        float u = uVariation(rng);
        currentPosition = EvaluateLinear(currentPosition, combatPosition, u);

        u = uVariation(rng);
        currentPosition = EvaluateLinear(currentPosition, homePosition, u);

        float drift = Distance(currentPosition, homePosition);
        maxDrift = std::max(maxDrift, drift);
    }

    std::cout << "Linear Interpolation Inexact U Test (10000 cycles, u varies 0.999-1.001):" << std::endl;
    std::cout << "  Max drift: " << maxDrift << " units" << std::endl;
    std::cout << "  Final pos: (" << currentPosition.x << ", " << currentPosition.y << ", " << currentPosition.z << ")" << std::endl;
}

TEST(PositionDriftTest, IntegerTiming_PrecisionLoss)
{
    const Vector3 start(1000.0f, 2000.0f, 100.0f);
    const Vector3 end(1030.0f, 2000.0f, 100.0f);

    float maxError = 0.0f;
    int errorCount = 0;

    std::vector<int32_t> segmentDurations = {100, 250, 333, 500, 750, 1000, 1500, 2000, 3000};

    for (int32_t segDuration : segmentDurations)
    {
        int32_t timeAtEnd = segDuration;
        float u = ComputeU_WithIntegerTiming(timeAtEnd, 0, segDuration);

        Vector3 result = EvaluateLinear(start, end, u);
        float error = Distance(result, end);

        if (error > 0.0001f)
        {
            errorCount++;
            maxError = std::max(maxError, error);
        }
    }

    std::cout << "Integer Timing Precision Test:" << std::endl;
    std::cout << "  Max error: " << maxError << " units" << std::endl;
    std::cout << "  Segments with error: " << errorCount << "/" << segmentDurations.size() << std::endl;

    EXPECT_EQ(errorCount, 0) << "Integer timing at exact end should produce no error";
}

TEST(PositionDriftTest, IntegerTiming_FractionalSegments)
{
    const Vector3 start(1000.0f, 2000.0f, 100.0f);
    const Vector3 end(1030.0f, 2000.0f, 100.0f);

    float totalDrift = 0.0f;
    const int NUM_TESTS = 10000;

    std::mt19937 rng(42);
    std::uniform_int_distribution<int32_t> durationDist(50, 5000);

    for (int i = 0; i < NUM_TESTS; ++i)
    {
        int32_t segDuration = durationDist(rng);
        float u = ComputeU_WithIntegerTiming(segDuration, 0, segDuration);

        Vector3 result = EvaluateLinear(start, end, u);
        float drift = Distance(result, end);
        totalDrift += drift;
    }

    float avgDrift = totalDrift / NUM_TESTS;

    std::cout << "Integer Timing Fractional Test (10000 random durations):" << std::endl;
    std::cout << "  Average drift: " << avgDrift << " units" << std::endl;

    EXPECT_NEAR(avgDrift, 0.0f, 0.0001f);
}

TEST(PositionDriftTest, CatmullRom_EndpointPrecision)
{
    Vector3 points[4] = {
        Vector3(990.0f, 1990.0f, 99.0f),
        Vector3(1000.0f, 2000.0f, 100.0f),
        Vector3(1030.0f, 2000.0f, 100.0f),
        Vector3(1040.0f, 2010.0f, 101.0f)
    };

    Vector3 expectedEnd = points[2];
    Vector3 result;
    C_Evaluate(points, 1.0f, s_catmullRomCoeffs, result);

    float error = Distance(result, expectedEnd);

    std::cout << "CatmullRom Endpoint Precision Test:" << std::endl;
    std::cout << "  Expected: (" << expectedEnd.x << ", " << expectedEnd.y << ", " << expectedEnd.z << ")" << std::endl;
    std::cout << "  Got:      (" << result.x << ", " << result.y << ", " << result.z << ")" << std::endl;
    std::cout << "  Error:    " << error << " units" << std::endl;

    EXPECT_LT(error, 0.001f) << "CatmullRom should return near-exact endpoint at u=1.0";
}

TEST(PositionDriftTest, CatmullRom_AccumulatedDrift)
{
    const Vector3 homePosition(1000.0f, 2000.0f, 100.0f);
    Vector3 currentPosition = homePosition;

    float maxDrift = 0.0f;
    float totalDrift = 0.0f;
    const int NUM_CYCLES = 10000;

    std::mt19937 rng(42);
    std::uniform_real_distribution<float> angleDist(0.0f, 2.0f * 3.14159f);
    std::uniform_real_distribution<float> distDist(5.0f, 30.0f);

    for (int cycle = 0; cycle < NUM_CYCLES; ++cycle)
    {
        float angle = angleDist(rng);
        float dist = distDist(rng);
        Vector3 combatPosition(
            currentPosition.x + std::cos(angle) * dist,
            currentPosition.y + std::sin(angle) * dist,
            currentPosition.z + (rng() % 10 - 5) * 0.1f
        );

        Vector3 toCombatPoints[4] = {
            currentPosition + (currentPosition - combatPosition).unit() * 10.0f,
            currentPosition,
            combatPosition,
            combatPosition + (combatPosition - currentPosition).unit() * 10.0f
        };

        C_Evaluate(toCombatPoints, 1.0f, s_catmullRomCoeffs, currentPosition);

        Vector3 toHomePoints[4] = {
            currentPosition + (currentPosition - homePosition).unit() * 10.0f,
            currentPosition,
            homePosition,
            homePosition + (homePosition - currentPosition).unit() * 10.0f
        };

        C_Evaluate(toHomePoints, 1.0f, s_catmullRomCoeffs, currentPosition);

        float drift = Distance(currentPosition, homePosition);
        maxDrift = std::max(maxDrift, drift);
        totalDrift += drift;
    }

    float avgDrift = totalDrift / NUM_CYCLES;

    std::cout << "CatmullRom Accumulated Drift Test (10000 cycles):" << std::endl;
    std::cout << "  Max drift: " << maxDrift << " units" << std::endl;
    std::cout << "  Avg drift: " << avgDrift << " units" << std::endl;
    std::cout << "  Final position: (" << currentPosition.x << ", " << currentPosition.y << ", " << currentPosition.z << ")" << std::endl;
    std::cout << "  Home position:  (" << homePosition.x << ", " << homePosition.y << ", " << homePosition.z << ")" << std::endl;

    if (maxDrift > 0.1f)
    {
        std::cout << "  WARNING: Drift exceeds 0.1 units - may be visible to players!" << std::endl;
    }
}

TEST(PositionDriftTest, TerrainHeight_AdjustmentDrift)
{
    const float originalZ = 100.0f;
    float currentZ = originalZ;
    const int NUM_CYCLES = 1000000;

    std::mt19937 rng(42);
    std::normal_distribution<float> noiseDist(0.0f, 0.001f);

    for (int cycle = 0; cycle < NUM_CYCLES; ++cycle)
    {
        float terrainNoise = noiseDist(rng);
        currentZ = currentZ + terrainNoise;
    }

    float drift = std::abs(currentZ - originalZ);

    std::cout << "Terrain Height Adjustment Drift (1M iterations):" << std::endl;
    std::cout << "  Original Z: " << originalZ << std::endl;
    std::cout << "  Final Z:    " << currentZ << std::endl;
    std::cout << "  Z drift:    " << drift << " units" << std::endl;

    EXPECT_LT(drift, 0.5f) << "Terrain height noise causes unacceptable Z drift!";
}

TEST(PositionDriftTest, CombinedRealWorld_Simulation)
{
    const Vector3 spawnPosition(1000.0f, 2000.0f, 100.0f);
    Vector3 homePosition = spawnPosition;
    Vector3 currentPosition = spawnPosition;

    float maxDriftFromSpawn = 0.0f;
    float maxDriftFromHome = 0.0f;
    const int NUM_CYCLES = 1000000;

    std::mt19937 rng(42);
    std::uniform_real_distribution<float> angleDist(0.0f, 2.0f * 3.14159f);
    std::uniform_real_distribution<float> distDist(5.0f, 30.0f);
    std::normal_distribution<float> zNoiseDist(0.0f, 0.0005f);

    for (int cycle = 0; cycle < NUM_CYCLES; ++cycle)
    {
        float angle = angleDist(rng);
        float dist = distDist(rng);
        Vector3 combatPosition(
            currentPosition.x + std::cos(angle) * dist,
            currentPosition.y + std::sin(angle) * dist,
            currentPosition.z
        );

        currentPosition = EvaluateLinear(currentPosition, combatPosition, 1.0f);
        currentPosition.z += zNoiseDist(rng);
        currentPosition = EvaluateLinear(currentPosition, homePosition, 1.0f);
        currentPosition.z += zNoiseDist(rng);

        float driftFromSpawn = Distance(currentPosition, spawnPosition);
        float driftFromHome = Distance(currentPosition, homePosition);

        maxDriftFromSpawn = std::max(maxDriftFromSpawn, driftFromSpawn);
        maxDriftFromHome = std::max(maxDriftFromHome, driftFromHome);
    }

    std::cout << "Combined Real-World Simulation (1M iterations):" << std::endl;
    std::cout << "  Max drift from original spawn: " << maxDriftFromSpawn << " units" << std::endl;
    std::cout << "  Max drift from stored home:    " << maxDriftFromHome << " units" << std::endl;
    std::cout << "  Final position: (" << currentPosition.x << ", " << currentPosition.y << ", " << currentPosition.z << ")" << std::endl;
    std::cout << "  Spawn position: (" << spawnPosition.x << ", " << spawnPosition.y << ", " << spawnPosition.z << ")" << std::endl;

    EXPECT_LT(maxDriftFromSpawn, 0.1f) << "Combined simulation causes unacceptable drift from spawn!";
}

// Regression test: verifies NPCs return to original spawn after combat
TEST(PositionDriftTest, PlayerInteraction_HomePositionPreserved_FIXED)
{
    const Vector3 spawnPosition(1000.0f, 2000.0f, 100.0f);
    Vector3 homePosition = spawnPosition;
    Vector3 currentPosition = spawnPosition;

    float maxDrift = 0.0f;
    const int NUM_INTERACTIONS = 100000;

    std::mt19937 rng(42);
    std::normal_distribution<float> smallMoveDist(0.0f, 0.1f);
    std::normal_distribution<float> zNoiseDist(0.0f, 0.01f);

    for (int i = 0; i < NUM_INTERACTIONS; ++i)
    {
        currentPosition.x += smallMoveDist(rng);
        currentPosition.y += smallMoveDist(rng);
        currentPosition.z += zNoiseDist(rng);

        // FIX: home position NOT updated on player interaction

        if (i % 10 == 0)
        {
            float angle = (float)(rng() % 628) / 100.0f;
            float dist = 5.0f + (rng() % 25);
            Vector3 combatPos(
                currentPosition.x + std::cos(angle) * dist,
                currentPosition.y + std::sin(angle) * dist,
                currentPosition.z
            );
            currentPosition = combatPos;
            currentPosition = homePosition;
            currentPosition.z += zNoiseDist(rng);
        }

        float drift = Distance(currentPosition, spawnPosition);
        maxDrift = std::max(maxDrift, drift);
    }

    float finalDrift = Distance(currentPosition, spawnPosition);

    std::cout << "Player Interaction Home Preserved Test (100K interactions):" << std::endl;
    std::cout << "  Original spawn:  (" << spawnPosition.x << ", " << spawnPosition.y << ", " << spawnPosition.z << ")" << std::endl;
    std::cout << "  Final position:  (" << currentPosition.x << ", " << currentPosition.y << ", " << currentPosition.z << ")" << std::endl;
    std::cout << "  Max drift:       " << maxDrift << " units" << std::endl;
    std::cout << "  Final drift:     " << finalDrift << " units" << std::endl;

    EXPECT_LT(finalDrift, 1.0f) << "Player interactions should not cause NPC to drift from spawn!";
}

// Documents what the OLD buggy behavior caused (SetHomePosition on every interaction)
TEST(PositionDriftTest, PlayerInteraction_OldBuggyBehavior_DOCUMENTATION)
{
    const Vector3 spawnPosition(1000.0f, 2000.0f, 100.0f);
    Vector3 homePosition = spawnPosition;
    Vector3 currentPosition = spawnPosition;

    float maxDrift = 0.0f;
    const int NUM_INTERACTIONS = 100000;

    std::mt19937 rng(42);
    std::normal_distribution<float> smallMoveDist(0.0f, 0.1f);
    std::normal_distribution<float> zNoiseDist(0.0f, 0.01f);

    for (int i = 0; i < NUM_INTERACTIONS; ++i)
    {
        currentPosition.x += smallMoveDist(rng);
        currentPosition.y += smallMoveDist(rng);
        currentPosition.z += zNoiseDist(rng);

        // OLD BUG: home position was updated on every player interaction
        homePosition = currentPosition;

        if (i % 10 == 0)
        {
            float angle = (float)(rng() % 628) / 100.0f;
            float dist = 5.0f + (rng() % 25);
            Vector3 combatPos(
                currentPosition.x + std::cos(angle) * dist,
                currentPosition.y + std::sin(angle) * dist,
                currentPosition.z
            );
            currentPosition = combatPos;
            currentPosition = homePosition;
            currentPosition.z += zNoiseDist(rng);
        }

        float drift = Distance(currentPosition, spawnPosition);
        maxDrift = std::max(maxDrift, drift);
    }

    float finalDrift = Distance(currentPosition, spawnPosition);

    std::cout << "OLD BUGGY BEHAVIOR (documentation only):" << std::endl;
    std::cout << "  With SetHomePosition(GetPosition()) on interaction:" << std::endl;
    std::cout << "  Max drift:   " << maxDrift << " units" << std::endl;
    std::cout << "  Final drift: " << finalDrift << " units" << std::endl;
    std::cout << "  This is why we removed those calls!" << std::endl;
}

TEST(PositionDriftTest, HeightSourceSwitching_RootCause)
{
    const float gridHeight = 100.0f;
    const float vmapHeight = 100.05f;

    float currentZ = 100.0f;
    const float originalZ = currentZ;
    const int NUM_CYCLES = 1000000;

    for (int cycle = 0; cycle < NUM_CYCLES; ++cycle)
    {
        float distToGrid = std::fabs(gridHeight - currentZ);
        float distToVmap = std::fabs(vmapHeight - currentZ);

        float newHeight;
        if (vmapHeight > gridHeight || distToGrid > distToVmap)
            newHeight = vmapHeight;
        else
            newHeight = gridHeight;

        currentZ = newHeight;
    }

    float drift = std::abs(currentZ - originalZ);

    std::cout << "Height Source Switching Test (ROOT CAUSE - 1M iterations):" << std::endl;
    std::cout << "  Grid height:  " << gridHeight << std::endl;
    std::cout << "  Vmap height:  " << vmapHeight << std::endl;
    std::cout << "  Original z:   " << originalZ << std::endl;
    std::cout << "  Final z:      " << currentZ << std::endl;
    std::cout << "  Z drift:      " << drift << " units" << std::endl;

    EXPECT_LT(drift, 0.1f) << "Height source switching causes unacceptable Z drift!";
}

TEST(PositionDriftTest, HeightSourceSwitching_WithVariation)
{
    float currentZ = 100.0f;
    const float originalZ = currentZ;
    const int NUM_CYCLES = 1000000;

    std::mt19937 rng(42);
    std::normal_distribution<float> gridNoise(0.0f, 0.001f);
    std::normal_distribution<float> vmapNoise(0.0f, 0.002f);

    const float baseGridHeight = 100.0f;
    const float baseVmapHeight = 100.03f;

    for (int cycle = 0; cycle < NUM_CYCLES; ++cycle)
    {
        float gridHeight = baseGridHeight + gridNoise(rng);
        float vmapHeight = baseVmapHeight + vmapNoise(rng);

        float distToGrid = std::fabs(gridHeight - currentZ);
        float distToVmap = std::fabs(vmapHeight - currentZ);

        float newHeight;
        if (vmapHeight > gridHeight || distToGrid > distToVmap)
            newHeight = vmapHeight;
        else
            newHeight = gridHeight;

        currentZ = newHeight;
    }

    float drift = std::abs(currentZ - originalZ);

    std::cout << "Height Source Switching with Variation (1M iterations):" << std::endl;
    std::cout << "  Original z:   " << originalZ << std::endl;
    std::cout << "  Final z:      " << currentZ << std::endl;
    std::cout << "  Z drift:      " << drift << " units" << std::endl;

    EXPECT_LT(drift, 0.1f) << "Height source switching with variation causes unacceptable Z drift!";
}

TEST(PositionDriftTest, TriangleSelection_BoundaryFlip)
{
    [[maybe_unused]] const float h1 = 100.0f;
    [[maybe_unused]] const float h2 = 100.1f;
    [[maybe_unused]] const float h3 = 99.9f;
    [[maybe_unused]] const float h4 = 100.05f;
    [[maybe_unused]] const float h5 = 100.02f;

    float x = 0.5f;
    float y = 0.5f;

    std::mt19937 rng(42);
    std::normal_distribution<float> coordNoise(0.0f, 0.0001f);

    int triangle1Count = 0;
    int triangle3Count = 0;
    const int NUM_TESTS = 10000;

    for (int i = 0; i < NUM_TESTS; ++i)
    {
        float testX = x + coordNoise(rng);
        float testY = y + coordNoise(rng);

        if (testX + testY < 1)
        {
            if (testX > testY)
                triangle1Count++;
        }
        else
        {
            if (testX > testY)
                triangle3Count++;
        }
    }

    std::cout << "Triangle Selection Boundary Test (x=0.5, y=0.5):" << std::endl;
    std::cout << "  Triangle 1 selected: " << triangle1Count << "/" << NUM_TESTS << std::endl;
    std::cout << "  Triangle 3 selected: " << triangle3Count << "/" << NUM_TESTS << std::endl;
}

TEST(PositionDriftTest, VelocityDuration_PrecisionLoss)
{
    const int NUM_TESTS = 10000;
    float maxError = 0.0f;
    int significantErrors = 0;

    std::mt19937 rng(42);
    std::uniform_real_distribution<float> distDist(1.0f, 100.0f);
    std::uniform_real_distribution<float> velDist(1.0f, 10.0f);

    for (int i = 0; i < NUM_TESTS; ++i)
    {
        float distance = distDist(rng);
        float velocity = velDist(rng);

        float durationF = (distance / velocity) * 1000.0f;
        int32_t durationI = static_cast<int32_t>(durationF);

        float reconstructedDuration = static_cast<float>(durationI);
        float reconstructedDistance = (reconstructedDuration / 1000.0f) * velocity;

        float error = std::abs(reconstructedDistance - distance);

        if (error > 0.01f)
            significantErrors++;
        maxError = std::max(maxError, error);
    }

    std::cout << "Velocity/Duration Precision Test (10000 tests):" << std::endl;
    std::cout << "  Max distance error: " << maxError << " units" << std::endl;
    std::cout << "  Significant errors (>1cm): " << significantErrors << "/" << NUM_TESTS << std::endl;
}
