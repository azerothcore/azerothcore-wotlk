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

/*
 * Glicko-2 Rating System Implementation
 *
 * Based on the Glicko-2 rating system by Professor Mark E. Glickman
 * http://www.glicko.net/glicko.html
 *
 * The Glicko-2 algorithm is freely available for use and is in the public domain.
 *
 * Reference implementations consulted:
 * - glicko2 Python library by Heungsub Lee (https://github.com/sublee/glicko2)
 *   Copyright (c) 2012-2016, Heungsub Lee (BSD 3-Clause License)
 *
 * This C++ implementation is an original work for AzerothCore, adapted from the
 * algorithm specification in "Example of the Glicko-2 system" by Mark E. Glickman
 * (March 22, 2022) available at http://www.glicko.net/glicko/glicko2.pdf
 */

#ifndef _GLICKO2_H
#define _GLICKO2_H

#include <cmath>
#include <vector>
#include <algorithm>

/**
 * @brief Represents a player's Glicko-2 rating with uncertainty measures
 *
 * The Glicko-2 system tracks three values for each player:
 * - Rating (r): The player's skill level (default 1500, higher is better)
 * - Rating Deviation (RD): Uncertainty about the rating (decreases with more games)
 * - Volatility (σ): Expected fluctuation in performance (measures consistency)
 */
struct Glicko2Rating
{
    float rating;           ///< Player's skill rating (r) on original Glicko scale, default 1500
    float ratingDeviation;  ///< Rating deviation (RD), measures uncertainty, default 200
    float volatility;       ///< Volatility (σ), measures consistency, default 0.06

    /// @brief Default constructor initializes to standard starting values
    Glicko2Rating() : rating(1500.0f), ratingDeviation(200.0f), volatility(0.06f) {}

    /**
     * @brief Constructor with custom values
     * @param r Initial rating value
     * @param rd Initial rating deviation
     * @param vol Initial volatility
     */
    Glicko2Rating(float r, float rd, float vol) : rating(r), ratingDeviation(rd), volatility(vol) {}
};

/**
 * @brief Represents an opponent in a match with their rating and match outcome
 */
struct Glicko2Opponent
{
    float rating;           ///< Opponent's rating
    float ratingDeviation;  ///< Opponent's rating deviation
    float score;            ///< Match score: 1.0 = win, 0.5 = draw, 0.0 = loss

    /**
     * @brief Constructor for opponent data
     * @param r Opponent's rating
     * @param rd Opponent's rating deviation
     * @param s Match score (1.0 = win, 0.5 = draw, 0.0 = loss)
     */
    Glicko2Opponent(float r, float rd, float s) : rating(r), ratingDeviation(rd), score(s) {}
};

/**
 * @class Glicko2System
 * @brief Implements the Glicko-2 rating algorithm for skill-based matchmaking
 *
 * The Glicko-2 system is an improvement over the Elo rating system, adding:
 * - Rating Deviation (RD) to measure uncertainty
 * - Volatility to measure consistency
 * - Better handling of inactive players
 *
 * Usage example:
 * @code
 * Glicko2System system(0.5f); // tau = 0.5
 * Glicko2Rating playerRating(1500.0f, 200.0f, 0.06f);
 *
 * std::vector<Glicko2Opponent> opponents;
 * opponents.emplace_back(1400.0f, 30.0f, 1.0f);  // Beat a 1400-rated opponent
 * opponents.emplace_back(1550.0f, 100.0f, 0.0f); // Lost to a 1550-rated opponent
 *
 * Glicko2Rating newRating = system.UpdateRating(playerRating, opponents);
 * @endcode
 *
 * @see http://www.glicko.net/glicko/glicko2.pdf for algorithm details
 */
class Glicko2System
{
public:
    /**
     * @brief Constructs a Glicko-2 system with specified parameters
     * @param tau System constant (τ) that constrains volatility changes (0.2 to 1.2)
     * @param convergenceTolerance Convergence tolerance for iterative calculations (ε)
     *
     * Recommended tau values:
     * - 0.2-0.3: Conservative, prevents large rating swings
     * - 0.5: Balanced, good for most applications
     * - 0.8-1.2: Aggressive, allows faster adaptation
     */
    Glicko2System(float tau = 0.5f, float convergenceTolerance = 0.000001f)
        : _tau(tau), _epsilon(convergenceTolerance) {}

    /**
     * @brief Updates a player's rating based on match results against opponents
     * @param playerRating Current rating of the player
     * @param opponents Vector of opponents with their ratings and match outcomes
     * @return New rating after processing all matches
     *
     * This is the main function to call after a player completes one or more matches.
     * The algorithm considers all opponents simultaneously to produce an accurate
     * rating update that accounts for the strength of opposition and match outcomes.
     *
     * @note If opponents vector is empty, behaves like UpdateInactiveRating()
     */
    Glicko2Rating UpdateRating(const Glicko2Rating& playerRating,
                               const std::vector<Glicko2Opponent>& opponents);

    /**
     * @brief Updates rating for an inactive player (increases uncertainty)
     * @param playerRating Current rating of the player
     * @return New rating with increased rating deviation
     *
     * When a player doesn't compete for a period, their rating stays the same
     * but their rating deviation (uncertainty) increases, reflecting decreased
     * confidence in their current rating.
     *
     * Call this periodically for players who haven't played recently.
     */
    Glicko2Rating UpdateInactiveRating(const Glicko2Rating& playerRating);

    /**
     * @brief Gets the system constant tau
     * @return Current tau value
     */
    float GetTau() const { return _tau; }

    /**
     * @brief Sets the system constant tau
     * @param tau New tau value (should be between 0.2 and 1.2)
     */
    void SetTau(float tau) { _tau = tau; }

private:
    /**
     * @brief Converts rating from original Glicko scale to Glicko-2 scale
     * @param rating Rating on original scale (default ~1500)
     * @return Rating on Glicko-2 scale (μ)
     */
    float ConvertRatingToGlicko2(float rating) const;

    /**
     * @brief Converts rating deviation from original scale to Glicko-2 scale
     * @param rd Rating deviation on original scale (default ~200)
     * @return Rating deviation on Glicko-2 scale (φ)
     */
    float ConvertRDToGlicko2(float rd) const;

    /**
     * @brief Converts rating from Glicko-2 scale back to original scale
     * @param mu Rating on Glicko-2 scale
     * @return Rating on original scale
     */
    float ConvertRatingFromGlicko2(float mu) const;

    /**
     * @brief Converts rating deviation from Glicko-2 scale back to original scale
     * @param phi Rating deviation on Glicko-2 scale
     * @return Rating deviation on original scale
     */
    float ConvertRDFromGlicko2(float phi) const;

    /**
     * @brief Calculates the g function which reduces the impact of high RD opponents
     * @param phi Opponent's rating deviation on Glicko-2 scale
     * @return g(φ) value used in variance calculations
     */
    float CalculateG(float phi) const;

    /**
     * @brief Calculates the E function (expected score against an opponent)
     * @param mu Player's rating on Glicko-2 scale
     * @param muJ Opponent's rating on Glicko-2 scale
     * @param phiJ Opponent's rating deviation on Glicko-2 scale
     * @return Expected score between 0 and 1
     */
    float CalculateE(float mu, float muJ, float phiJ) const;

    /**
     * @brief Calculates the variance of the player's rating based on game outcomes
     * @param mu Player's rating on Glicko-2 scale
     * @param opponents Vector of opponents
     * @return Variance (v) used in rating updates
     */
    float CalculateVariance(float mu, const std::vector<Glicko2Opponent>& opponents) const;

    /**
     * @brief Calculates delta, the estimated improvement in rating
     * @param mu Player's rating on Glicko-2 scale
     * @param variance Calculated variance
     * @param opponents Vector of opponents
     * @return Delta (Δ) value
     */
    float CalculateDelta(float mu, float variance, const std::vector<Glicko2Opponent>& opponents) const;

    /**
     * @brief Updates the volatility measure using iterative algorithm
     * @param phi Player's rating deviation on Glicko-2 scale
     * @param variance Calculated variance
     * @param delta Calculated delta
     * @param sigma Current volatility
     * @return New volatility (σ')
     */
    float UpdateVolatility(float phi, float variance, float delta, float sigma) const;

    /**
     * @brief Illinois algorithm for finding optimal volatility (stable iteration)
     * @param a Starting point ln(σ²)
     * @param delta Calculated delta value
     * @param phi Rating deviation
     * @param variance Calculated variance
     * @param sigma Current volatility
     * @return New volatility value
     *
     * This uses the Illinois variant of the regula falsi method, which is more
     * stable than the Newton-Raphson method previously used in Glicko-2.
     */
    float IllinoisAlgorithm(float a, float delta, float phi, float variance, float sigma) const;

    /**
     * @brief Function to optimize when finding new volatility
     * @param x Current iteration value
     * @param delta Calculated delta
     * @param phi Rating deviation
     * @param variance Calculated variance
     * @param a Starting point
     * @return Function value at x
     */
    float VolatilityFunction(float x, float delta, float phi, float variance, float a) const;

    float _tau;      ///< System constant (τ) that constrains volatility changes
    float _epsilon;  ///< Convergence tolerance (ε) for iterative algorithms

    static constexpr float SCALE_FACTOR = 173.7178f;  ///< Conversion factor between scales
    static constexpr float PI_SQUARED = 9.8696044f;   ///< π² constant used in calculations
};

#endif // _GLICKO2_H
