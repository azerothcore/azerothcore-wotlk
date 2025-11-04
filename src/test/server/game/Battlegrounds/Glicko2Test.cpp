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

#include "Glicko2.h"
#include "gtest/gtest.h"
#include <cmath>

/**
 * Glicko-2 Algorithm Unit Tests
 *
 * Tests the core Glicko-2 rating algorithm to ensure mathematical
 * correctness and proper handling of edge cases.
 */

class Glicko2Test : public ::testing::Test
{
protected:
    Glicko2System glicko{0.5f}; // Standard tau value

    // Helper to compare floats with tolerance
    bool FloatNear(float a, float b, float epsilon = 0.5f)
    {
        return std::abs(a - b) < epsilon;
    }
};

// =============================================================================
// Basic Rating Update Tests
// =============================================================================

TEST_F(Glicko2Test, RatingIncreasesAfterWin)
{
    // Player wins against equal opponent
    Glicko2Rating player(1500.0f, 200.0f, 0.06f);
    std::vector<Glicko2Opponent> opponents;
    opponents.emplace_back(1500.0f, 200.0f, 1.0f); // Win

    Glicko2Rating newRating = glicko.UpdateRating(player, opponents);

    EXPECT_GT(newRating.rating, player.rating)
        << "Rating should increase after winning";
    EXPECT_LT(newRating.ratingDeviation, player.ratingDeviation)
        << "Rating deviation should decrease after playing";
}

TEST_F(Glicko2Test, RatingDecreasesAfterLoss)
{
    // Player loses against equal opponent
    Glicko2Rating player(1500.0f, 200.0f, 0.06f);
    std::vector<Glicko2Opponent> opponents;
    opponents.emplace_back(1500.0f, 200.0f, 0.0f); // Loss

    Glicko2Rating newRating = glicko.UpdateRating(player, opponents);

    EXPECT_LT(newRating.rating, player.rating)
        << "Rating should decrease after losing";
    EXPECT_LT(newRating.ratingDeviation, player.ratingDeviation)
        << "Rating deviation should decrease after playing";
}

TEST_F(Glicko2Test, DrawHasMinimalImpact)
{
    // Draw against equal opponent should have minimal rating change
    Glicko2Rating player(1500.0f, 200.0f, 0.06f);
    std::vector<Glicko2Opponent> opponents;
    opponents.emplace_back(1500.0f, 200.0f, 0.5f); // Draw

    Glicko2Rating newRating = glicko.UpdateRating(player, opponents);

    EXPECT_NEAR(newRating.rating, player.rating, 5.0f)
        << "Rating should change minimally after draw vs equal opponent";
}

// =============================================================================
// Rating Magnitude Tests
// =============================================================================

TEST_F(Glicko2Test, BiggerWinsAgainstStrongerOpponents)
{
    // Beating a stronger opponent gives more rating
    Glicko2Rating player(1500.0f, 200.0f, 0.06f);

    // Win vs weaker opponent (1400)
    std::vector<Glicko2Opponent> opponents1;
    opponents1.emplace_back(1400.0f, 200.0f, 1.0f);
    Glicko2Rating afterWeak = glicko.UpdateRating(player, opponents1);
    float gainWeak = afterWeak.rating - player.rating;

    // Win vs stronger opponent (1600)
    std::vector<Glicko2Opponent> opponents2;
    opponents2.emplace_back(1600.0f, 200.0f, 1.0f);
    Glicko2Rating afterStrong = glicko.UpdateRating(player, opponents2);
    float gainStrong = afterStrong.rating - player.rating;

    EXPECT_GT(gainStrong, gainWeak)
        << "Beating stronger opponent (1600) should give more rating than beating weaker (1400)";
}

TEST_F(Glicko2Test, SmallerLossAgainstStrongerOpponents)
{
    // Losing to a stronger opponent costs less rating
    Glicko2Rating player(1500.0f, 200.0f, 0.06f);

    // Loss vs weaker opponent (1400)
    std::vector<Glicko2Opponent> opponents1;
    opponents1.emplace_back(1400.0f, 200.0f, 0.0f);
    Glicko2Rating afterWeak = glicko.UpdateRating(player, opponents1);
    float lossWeak = player.rating - afterWeak.rating; // positive value

    // Loss vs stronger opponent (1600)
    std::vector<Glicko2Opponent> opponents2;
    opponents2.emplace_back(1600.0f, 200.0f, 0.0f);
    Glicko2Rating afterStrong = glicko.UpdateRating(player, opponents2);
    float lossStrong = player.rating - afterStrong.rating; // positive value

    EXPECT_LT(lossStrong, lossWeak)
        << "Losing to stronger opponent (1600) should cost less rating than losing to weaker (1400)";
}

// =============================================================================
// Rating Deviation Tests
// =============================================================================

TEST_F(Glicko2Test, RatingDeviationDecreasesWithGames)
{
    // RD should decrease as player plays more matches
    Glicko2Rating player(1500.0f, 200.0f, 0.06f);

    // Play 5 matches
    for (int i = 0; i < 5; ++i)
    {
        std::vector<Glicko2Opponent> opponents;
        opponents.emplace_back(1500.0f, 200.0f, (i % 2 == 0) ? 1.0f : 0.0f); // Alternate wins/losses
        player = glicko.UpdateRating(player, opponents);
    }

    EXPECT_LT(player.ratingDeviation, 200.0f)
        << "RD should decrease significantly after 5 matches";
    EXPECT_GT(player.ratingDeviation, 30.0f)
        << "RD shouldn't go below reasonable minimum";
}

TEST_F(Glicko2Test, HighRDOpponentsHaveLessImpact)
{
    // Opponents with high uncertainty affect rating less
    Glicko2Rating player(1500.0f, 50.0f, 0.06f); // Low RD player

    // Win vs high RD opponent
    std::vector<Glicko2Opponent> opponents1;
    opponents1.emplace_back(1600.0f, 200.0f, 1.0f);
    Glicko2Rating afterHighRD = glicko.UpdateRating(player, opponents1);
    float changeHighRD = std::abs(afterHighRD.rating - player.rating);

    // Win vs low RD opponent
    std::vector<Glicko2Opponent> opponents2;
    opponents2.emplace_back(1600.0f, 50.0f, 1.0f);
    Glicko2Rating afterLowRD = glicko.UpdateRating(player, opponents2);
    float changeLowRD = std::abs(afterLowRD.rating - player.rating);

    EXPECT_GT(changeLowRD, changeHighRD)
        << "Low RD opponent (50) should have more impact than high RD opponent (200)";
}

// =============================================================================
// Inactive Player Tests
// =============================================================================

TEST_F(Glicko2Test, InactivePlayerRatingDeviationIncreases)
{
    // Inactive players gain uncertainty
    Glicko2Rating player(1700.0f, 50.0f, 0.05f);
    Glicko2Rating afterInactive = glicko.UpdateInactiveRating(player);

    EXPECT_GT(afterInactive.ratingDeviation, player.ratingDeviation)
        << "RD should increase for inactive player";
    EXPECT_FLOAT_EQ(afterInactive.rating, player.rating)
        << "Rating should remain unchanged for inactive player";
}

// =============================================================================
// Edge Cases
// =============================================================================

TEST_F(Glicko2Test, NoOpponentsHandled)
{
    // Empty opponent list should behave like inactive rating
    Glicko2Rating player(1500.0f, 200.0f, 0.06f);
    std::vector<Glicko2Opponent> opponents; // Empty

    Glicko2Rating newRating = glicko.UpdateRating(player, opponents);

    EXPECT_FLOAT_EQ(newRating.rating, player.rating)
        << "Rating should not change with no opponents";
    EXPECT_GE(newRating.ratingDeviation, player.ratingDeviation)
        << "RD should increase (or stay same) with no opponents";
}

TEST_F(Glicko2Test, ExtremeRatingDifference)
{
    // System should handle large rating gaps without overflow
    Glicko2Rating player(1500.0f, 200.0f, 0.06f);
    std::vector<Glicko2Opponent> opponents;
    opponents.emplace_back(2500.0f, 50.0f, 0.0f); // Expected loss to much higher rated

    Glicko2Rating newRating = glicko.UpdateRating(player, opponents);

    EXPECT_LT(newRating.rating, player.rating)
        << "Rating should decrease slightly (expected loss)";
    EXPECT_GT(newRating.rating, player.rating - 10.0f)
        << "Rating loss should be small (expected outcome)";
}

TEST_F(Glicko2Test, MultipleOpponentsBatch)
{
    // Rating updates correctly with multiple opponents
    Glicko2Rating player(1500.0f, 200.0f, 0.06f);
    std::vector<Glicko2Opponent> opponents;

    // 3 wins, 2 losses
    opponents.emplace_back(1450.0f, 150.0f, 1.0f);
    opponents.emplace_back(1500.0f, 150.0f, 1.0f);
    opponents.emplace_back(1550.0f, 150.0f, 1.0f);
    opponents.emplace_back(1520.0f, 150.0f, 0.0f);
    opponents.emplace_back(1480.0f, 150.0f, 0.0f);

    Glicko2Rating newRating = glicko.UpdateRating(player, opponents);

    EXPECT_GT(newRating.rating, player.rating)
        << "Net rating should increase (3 wins, 2 losses)";
    EXPECT_LT(newRating.ratingDeviation, player.ratingDeviation)
        << "RD should decrease significantly (5 matches)";
}

// =============================================================================
// Mathematical Accuracy Test
// =============================================================================

TEST_F(Glicko2Test, GlickoReferenceCaseValidation)
{
    // Validate against example from official Glicko-2 paper
    // http://www.glicko.net/glicko/glicko2.pdf
    //
    // Player: rating=1500, RD=200, volatility=0.06
    // Opponent 1: rating=1400, RD=30, result=1.0 (win)
    // Opponent 2: rating=1550, RD=100, result=0.0 (loss)
    // Opponent 3: rating=1700, RD=300, result=0.0 (loss)
    //
    // Expected results (from paper):
    // new_rating ≈ 1464.06
    // new_RD ≈ 151.52
    // new_volatility ≈ 0.05999

    Glicko2System system(0.5f); // tau = 0.5 as in paper
    Glicko2Rating player(1500.0f, 200.0f, 0.06f);

    std::vector<Glicko2Opponent> opponents;
    opponents.emplace_back(1400.0f, 30.0f, 1.0f);   // Win
    opponents.emplace_back(1550.0f, 100.0f, 0.0f);  // Loss
    opponents.emplace_back(1700.0f, 300.0f, 0.0f);  // Loss

    Glicko2Rating newRating = system.UpdateRating(player, opponents);

    // Allow some tolerance for floating point differences
    EXPECT_TRUE(FloatNear(newRating.rating, 1464.06f, 1.0f))
        << "Rating should be close to reference value (1464.06), got: " << newRating.rating;
    EXPECT_TRUE(FloatNear(newRating.ratingDeviation, 151.52f, 1.0f))
        << "RD should be close to reference value (151.52), got: " << newRating.ratingDeviation;
    EXPECT_TRUE(FloatNear(newRating.volatility, 0.05999f, 0.001f))
        << "Volatility should be close to reference value (0.05999), got: " << newRating.volatility;
}

// =============================================================================
// Configuration Tests
// =============================================================================

TEST_F(Glicko2Test, DifferentTauValues)
{
    // Higher tau should allow larger volatility changes
    Glicko2System conservativeSystem(0.3f);
    Glicko2System aggressiveSystem(1.0f);

    Glicko2Rating player(1500.0f, 200.0f, 0.06f);

    // Unexpected result (loss to much weaker player)
    std::vector<Glicko2Opponent> opponents;
    opponents.emplace_back(1200.0f, 50.0f, 0.0f);

    Glicko2Rating conservativeResult = conservativeSystem.UpdateRating(player, opponents);
    Glicko2Rating aggressiveResult = aggressiveSystem.UpdateRating(player, opponents);

    float conservativeVolChange = std::abs(conservativeResult.volatility - player.volatility);
    float aggressiveVolChange = std::abs(aggressiveResult.volatility - player.volatility);

    EXPECT_GT(aggressiveVolChange, conservativeVolChange)
        << "Higher tau (1.0) should allow larger volatility changes than lower tau (0.3)";
}
