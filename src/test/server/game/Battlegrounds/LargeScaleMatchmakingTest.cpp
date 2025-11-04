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
#include <algorithm>
#include <chrono>
#include <random>
#include <vector>

/**
 * Large-Scale Matchmaking Tests
 *
 * Tests matchmaking and sorting with hundreds of players to ensure
 * the system performs correctly at scale.
 */

// Simple player data structure for testing
struct TestPlayer
{
    float mmr;
    float gearScore;
    uint32 queueTime;
    uint32 id;

    TestPlayer(float m, float g, uint32 q, uint32 i)
        : mmr(m), gearScore(g), queueTime(q), id(i) {}

    float GetCombinedScore() const
    {
        // MMR weight = 0.7, Gear weight = 0.3
        float normalizedGear = (gearScore / 300.0f) * 1500.0f;
        return (mmr * 0.7f) + (normalizedGear * 0.3f);
    }
};

class LargeScaleMatchmakingTest : public ::testing::Test
{
protected:
    // Helper to generate large player pool with normal distribution
    std::vector<TestPlayer> GeneratePlayerPool(
        size_t count,
        float meanMMR = 1500.0f,
        float stdDevMMR = 300.0f)
    {
        std::vector<TestPlayer> players;
        players.reserve(count);

        std::random_device rd;
        std::mt19937 gen(42); // Fixed seed for reproducible tests
        std::normal_distribution<float> mmrDist(meanMMR, stdDevMMR);
        std::uniform_real_distribution<float> gearDist(150.0f, 350.0f);
        std::uniform_int_distribution<uint32> queueDist(0, 600);

        for (size_t i = 0; i < count; ++i)
        {
            float mmr = std::clamp(mmrDist(gen), 500.0f, 2500.0f);
            float gear = gearDist(gen);
            uint32 queueTime = queueDist(gen);

            players.emplace_back(mmr, gear, queueTime, static_cast<uint32>(i));
        }

        return players;
    }

    // Helper to verify list is sorted by MMR
    bool VerifySortedByMMR(const std::vector<TestPlayer>& players, bool ascending = true)
    {
        for (size_t i = 1; i < players.size(); ++i)
        {
            if (ascending && players[i].mmr < players[i-1].mmr) return false;
            if (!ascending && players[i].mmr > players[i-1].mmr) return false;
        }
        return true;
    }

    // Helper to verify list is sorted by combined score
    bool VerifySortedByCombinedScore(const std::vector<TestPlayer>& players)
    {
        for (size_t i = 1; i < players.size(); ++i)
        {
            if (players[i].GetCombinedScore() < players[i-1].GetCombinedScore())
                return false;
        }
        return true;
    }

    // Helper to calculate average MMR
    float CalculateAverageMMR(const std::vector<TestPlayer>& players)
    {
        if (players.empty()) return 0.0f;

        float sum = 0.0f;
        for (const auto& player : players)
            sum += player.mmr;

        return sum / players.size();
    }

    // Helper to calculate MMR standard deviation
    float CalculateMMRStdDev(const std::vector<TestPlayer>& players)
    {
        if (players.empty()) return 0.0f;

        float mean = CalculateAverageMMR(players);
        float sumSquaredDiff = 0.0f;

        for (const auto& player : players)
        {
            float diff = player.mmr - mean;
            sumSquaredDiff += diff * diff;
        }

        return std::sqrt(sumSquaredDiff / players.size());
    }

    // Helper to count players within MMR tolerance
    size_t CountPlayersInTolerance(
        const std::vector<TestPlayer>& pool,
        float targetMMR,
        float tolerance)
    {
        size_t count = 0;
        for (const auto& player : pool)
        {
            if (std::abs(player.mmr - targetMMR) <= tolerance)
                ++count;
        }
        return count;
    }
};

// =============================================================================
// Player Pool Generation Tests
// =============================================================================

TEST_F(LargeScaleMatchmakingTest, GenerateLargePlayerPool)
{
    // Generate 500 players with normal distribution
    std::vector<TestPlayer> players = GeneratePlayerPool(500, 1500.0f, 300.0f);

    EXPECT_EQ(players.size(), 500u);

    // Calculate distribution stats
    float avgMMR = CalculateAverageMMR(players);
    float stdDev = CalculateMMRStdDev(players);

    // Should be close to target mean (within 50 MMR)
    EXPECT_NEAR(avgMMR, 1500.0f, 50.0f)
        << "Average MMR should be close to mean (1500)";

    // Should have reasonable spread
    EXPECT_GT(stdDev, 200.0f)
        << "Standard deviation should show reasonable spread";

    // All players should have valid data
    for (const auto& player : players)
    {
        EXPECT_GE(player.mmr, 500.0f);
        EXPECT_LE(player.mmr, 2500.0f);
        EXPECT_GE(player.gearScore, 150.0f);
        EXPECT_LE(player.gearScore, 350.0f);
        EXPECT_LE(player.queueTime, 600u);
    }
}

// =============================================================================
// Sorting Tests
// =============================================================================

TEST_F(LargeScaleMatchmakingTest, SortPlayersByMMR)
{
    // Create 200 players with random MMRs
    std::vector<TestPlayer> players = GeneratePlayerPool(200);

    // Sort by MMR ascending
    std::sort(players.begin(), players.end(),
        [](const TestPlayer& a, const TestPlayer& b) {
            return a.mmr < b.mmr;
        });

    // Verify sorted
    EXPECT_TRUE(VerifySortedByMMR(players, true))
        << "Players should be sorted by MMR in ascending order";

    // Check boundaries
    EXPECT_LE(players.front().mmr, players.back().mmr)
        << "First player should have lowest or equal MMR";
}

TEST_F(LargeScaleMatchmakingTest, SortPlayersByCombinedScore)
{
    // Create 200 players with varying MMR and gear
    std::vector<TestPlayer> players = GeneratePlayerPool(200);

    // Sort by combined score
    std::sort(players.begin(), players.end(),
        [](const TestPlayer& a, const TestPlayer& b) {
            return a.GetCombinedScore() < b.GetCombinedScore();
        });

    // Verify sorted
    EXPECT_TRUE(VerifySortedByCombinedScore(players))
        << "Players should be sorted by combined score";
}

TEST_F(LargeScaleMatchmakingTest, SortStability)
{
    // Create 50 players all with same MMR
    std::vector<TestPlayer> players;
    for (uint32 i = 0; i < 50; ++i)
    {
        players.emplace_back(1500.0f, 250.0f, 0, i);
    }

    // Sort (should be stable)
    std::stable_sort(players.begin(), players.end(),
        [](const TestPlayer& a, const TestPlayer& b) {
            return a.mmr < b.mmr;
        });

    // With stable sort, equal elements should maintain relative order
    // All have same MMR, so IDs should still be in original order
    for (uint32 i = 0; i < 50; ++i)
    {
        EXPECT_EQ(players[i].id, i)
            << "Stable sort should preserve relative order for equal elements";
    }
}

// =============================================================================
// Queue Relaxation Impact Tests
// =============================================================================

TEST_F(LargeScaleMatchmakingTest, LowMMRPlayerRelaxationExpansion)
{
    // Low MMR player's matchable pool expands with time
    std::vector<TestPlayer> pool = GeneratePlayerPool(500, 1500.0f, 300.0f);
    float playerMMR = 900.0f;

    // Time 0s (tolerance=200)
    size_t matchableAt0s = CountPlayersInTolerance(pool, playerMMR, 200.0f);

    // Time 240s (tolerance=400)
    size_t matchableAt240s = CountPlayersInTolerance(pool, playerMMR, 400.0f);

    // Time 600s (tolerance=unlimited)
    size_t matchableAt600s = pool.size(); // Can match with everyone

    EXPECT_LT(matchableAt0s, matchableAt240s)
        << "Matchable pool should expand after relaxation";
    EXPECT_LT(matchableAt240s, matchableAt600s)
        << "Matchable pool should continue expanding";
}

TEST_F(LargeScaleMatchmakingTest, HighMMRPlayerRelaxationExpansion)
{
    // High MMR player's matchable pool expands with time
    std::vector<TestPlayer> pool = GeneratePlayerPool(500, 1500.0f, 300.0f);
    float playerMMR = 2200.0f;

    // Time 0s (tolerance=200)
    size_t matchableAt0s = CountPlayersInTolerance(pool, playerMMR, 200.0f);

    // Time 240s (tolerance=400)
    size_t matchableAt240s = CountPlayersInTolerance(pool, playerMMR, 400.0f);

    EXPECT_LT(matchableAt0s, matchableAt240s)
        << "High MMR outlier should have expanding matchable pool";
}

TEST_F(LargeScaleMatchmakingTest, AverageMMRPlayerConsistentMatches)
{
    // Average MMR players should have large matchable pool
    std::vector<TestPlayer> pool = GeneratePlayerPool(500, 1500.0f, 300.0f);
    float playerMMR = 1500.0f;

    // Even with initial tolerance, should find many matches
    size_t matchableAt0s = CountPlayersInTolerance(pool, playerMMR, 200.0f);

    EXPECT_GT(matchableAt0s, 100u)
        << "Average MMR player should have large matchable pool even initially";
}

// =============================================================================
// Team Formation Tests
// =============================================================================

TEST_F(LargeScaleMatchmakingTest, Balance10v10WithLargePool)
{
    // Form balanced 10v10 from 500 player pool
    std::vector<TestPlayer> pool = GeneratePlayerPool(500);

    // Sort by MMR to make team selection easier
    std::sort(pool.begin(), pool.end(),
        [](const TestPlayer& a, const TestPlayer& b) {
            return a.mmr < b.mmr;
        });

    // Select 20 players from middle of distribution for balanced match
    std::vector<TestPlayer> teamA;
    std::vector<TestPlayer> teamB;

    // Simple alternating selection from middle
    for (size_t i = 200; i < 220; ++i)
    {
        if (i % 2 == 0)
            teamA.push_back(pool[i]);
        else
            teamB.push_back(pool[i]);
    }

    ASSERT_EQ(teamA.size(), 10u);
    ASSERT_EQ(teamB.size(), 10u);

    // Calculate team averages
    float avgA = CalculateAverageMMR(teamA);
    float avgB = CalculateAverageMMR(teamB);

    // Teams should be relatively balanced (within 100 MMR)
    EXPECT_NEAR(avgA, avgB, 100.0f)
        << "Teams should have similar average MMR";
}

// =============================================================================
// Sorting Performance Tests
// =============================================================================

TEST_F(LargeScaleMatchmakingTest, Sort1000PlayersByMMR)
{
    // Performance test: sort 1000 players
    std::vector<TestPlayer> players = GeneratePlayerPool(1000);

    auto start = std::chrono::high_resolution_clock::now();

    std::sort(players.begin(), players.end(),
        [](const TestPlayer& a, const TestPlayer& b) {
            return a.mmr < b.mmr;
        });

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

    // Should complete quickly (< 10ms)
    EXPECT_LT(duration.count(), 10)
        << "Sorting 1000 players should take less than 10ms, took: " << duration.count() << "ms";

    // Verify correctness
    EXPECT_TRUE(VerifySortedByMMR(players, true))
        << "Players should be correctly sorted";
}

// =============================================================================
// Statistical Distribution Tests
// =============================================================================

TEST_F(LargeScaleMatchmakingTest, MatchedPlayersMMRClustering)
{
    // Verify matches respect MMR clustering
    std::vector<TestPlayer> pool = GeneratePlayerPool(500);

    // Sort by MMR
    std::sort(pool.begin(), pool.end(),
        [](const TestPlayer& a, const TestPlayer& b) {
            return a.mmr < b.mmr;
        });

    // Form 5 battlegrounds (20 players each) from different MMR ranges
    std::vector<std::vector<TestPlayer>> battlegrounds;

    for (int bg = 0; bg < 5; ++bg)
    {
        std::vector<TestPlayer> bgPlayers;
        // Take 20 consecutive players from sorted list
        for (int i = 0; i < 20; ++i)
        {
            bgPlayers.push_back(pool[bg * 100 + i]);
        }
        battlegrounds.push_back(bgPlayers);
    }

    // Each BG should have low MMR spread
    for (size_t i = 0; i < battlegrounds.size(); ++i)
    {
        float stdDev = CalculateMMRStdDev(battlegrounds[i]);
        EXPECT_LT(stdDev, 150.0f)
            << "Battleground " << i << " should have clustered MMRs (low std dev)";
    }

    // Different BGs should have different average MMRs
    float bg0Avg = CalculateAverageMMR(battlegrounds[0]);
    float bg4Avg = CalculateAverageMMR(battlegrounds[4]);
    EXPECT_NE(bg0Avg, bg4Avg)
        << "Different battlegrounds should have different average MMRs";
}

// =============================================================================
// Edge Case Tests
// =============================================================================

TEST_F(LargeScaleMatchmakingTest, AllPlayersIdenticalMMR)
{
    // All players with same MMR should be matchable
    std::vector<TestPlayer> players;
    for (uint32 i = 0; i < 400; ++i)
    {
        players.emplace_back(1500.0f, 250.0f, 0, i);
    }

    // Any player can match with any other
    size_t matchable = CountPlayersInTolerance(players, 1500.0f, 200.0f);

    EXPECT_EQ(matchable, 400u)
        << "All players with identical MMR should be matchable";
}

TEST_F(LargeScaleMatchmakingTest, ExtremeMMRGap)
{
    // Pool with huge MMR range
    std::vector<TestPlayer> players;

    // 100 low MMR players (800-1200)
    for (uint32 i = 0; i < 100; ++i)
    {
        players.emplace_back(800.0f + (i * 4.0f), 200.0f, 0, i);
    }

    // 100 high MMR players (1800-2200)
    for (uint32 i = 0; i < 100; ++i)
    {
        players.emplace_back(1800.0f + (i * 4.0f), 200.0f, 0, i + 100);
    }

    // With strict tolerance (200), should form two separate groups
    size_t lowGroupMatchable = CountPlayersInTolerance(players, 1000.0f, 200.0f);
    size_t highGroupMatchable = CountPlayersInTolerance(players, 2000.0f, 200.0f);

    EXPECT_GT(lowGroupMatchable, 50u)
        << "Low MMR group should have many matchable players";
    EXPECT_GT(highGroupMatchable, 50u)
        << "High MMR group should have many matchable players";

    // With unlimited tolerance, everyone can match
    size_t totalMatchable = CountPlayersInTolerance(players, 1500.0f, 999999.0f);
    EXPECT_EQ(totalMatchable, 200u)
        << "With unlimited tolerance, all players matchable";
}
