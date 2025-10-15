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

#include "Glicko2.h"

float Glicko2System::ConvertRatingToGlicko2(float rating) const
{
    return (rating - 1500.0f) / SCALE_FACTOR;
}

float Glicko2System::ConvertRDToGlicko2(float rd) const
{
    return rd / SCALE_FACTOR;
}

float Glicko2System::ConvertRatingFromGlicko2(float mu) const
{
    return mu * SCALE_FACTOR + 1500.0f;
}

float Glicko2System::ConvertRDFromGlicko2(float phi) const
{
    return phi * SCALE_FACTOR;
}

float Glicko2System::CalculateG(float phi) const
{
    return 1.0f / std::sqrt(1.0f + (3.0f * phi * phi) / PI_SQUARED);
}

float Glicko2System::CalculateE(float mu, float muJ, float phiJ) const
{
    return 1.0f / (1.0f + std::exp(-CalculateG(phiJ) * (mu - muJ)));
}

float Glicko2System::CalculateVariance(float mu, const std::vector<Glicko2Opponent>& opponents) const
{
    float sum = 0.0f;
    
    for (const auto& opponent : opponents)
    {
        float muJ = ConvertRatingToGlicko2(opponent.rating);
        float phiJ = ConvertRDToGlicko2(opponent.ratingDeviation);
        float gPhiJ = CalculateG(phiJ);
        float e = CalculateE(mu, muJ, phiJ);
        
        sum += gPhiJ * gPhiJ * e * (1.0f - e);
    }
    
    return sum > 0.0f ? 1.0f / sum : 0.0f;
}

float Glicko2System::CalculateDelta(float mu, float variance, const std::vector<Glicko2Opponent>& opponents) const
{
    float sum = 0.0f;
    
    for (const auto& opponent : opponents)
    {
        float muJ = ConvertRatingToGlicko2(opponent.rating);
        float phiJ = ConvertRDToGlicko2(opponent.ratingDeviation);
        float gPhiJ = CalculateG(phiJ);
        float e = CalculateE(mu, muJ, phiJ);
        
        sum += gPhiJ * (opponent.score - e);
    }
    
    return variance * sum;
}

float Glicko2System::VolatilityFunction(float x, float delta, float phi, float variance, float a) const
{
    float ex = std::exp(x);
    float phiSquared = phi * phi;
    float denominator = phiSquared + variance + ex;
    
    float term1 = (ex * (delta * delta - phiSquared - variance - ex)) / 
                  (2.0f * denominator * denominator);
    float term2 = (x - a) / (_tau * _tau);
    
    return term1 - term2;
}

float Glicko2System::IllinoisAlgorithm(float a, float delta, float phi, float variance, float sigma) const
{
    // Step 1: Initialize
    float A = a;
    float B;
    
    float deltaSquared = delta * delta;
    float phiSquared = phi * phi;
    
    // Step 2: Set initial values for bracketing
    if (deltaSquared > phiSquared + variance)
    {
        B = std::log(deltaSquared - phiSquared - variance);
    }
    else
    {
        // Find B by iteration
        int k = 1;
        while (VolatilityFunction(a - k * _tau, delta, phi, variance, a) < 0.0f)
        {
            k++;
            if (k > 100) // Safety limit
                break;
        }
        B = a - k * _tau;
    }
    
    float fA = VolatilityFunction(A, delta, phi, variance, a);
    float fB = VolatilityFunction(B, delta, phi, variance, a);
    
    // Step 3: Illinois algorithm iteration
    while (std::abs(B - A) > _epsilon)
    {
        float C = A + (A - B) * fA / (fB - fA);
        float fC = VolatilityFunction(C, delta, phi, variance, a);
        
        if (fC * fB <= 0.0f)
        {
            A = B;
            fA = fB;
        }
        else
        {
            fA = fA / 2.0f;
        }
        
        B = C;
        fB = fC;
    }
    
    return std::exp(A / 2.0f);
}

float Glicko2System::UpdateVolatility(float phi, float variance, float delta, float sigma) const
{
    float a = std::log(sigma * sigma);
    return IllinoisAlgorithm(a, delta, phi, variance, sigma);
}

Glicko2Rating Glicko2System::UpdateRating(const Glicko2Rating& playerRating, 
                                          const std::vector<Glicko2Opponent>& opponents)
{
    // Handle edge case: no opponents
    if (opponents.empty())
        return UpdateInactiveRating(playerRating);
    
    // Step 2: Convert to Glicko-2 scale
    float mu = ConvertRatingToGlicko2(playerRating.rating);
    float phi = ConvertRDToGlicko2(playerRating.ratingDeviation);
    float sigma = playerRating.volatility;
    
    // Step 3: Calculate variance
    float variance = CalculateVariance(mu, opponents);
    
    // Step 4: Calculate delta
    float delta = CalculateDelta(mu, variance, opponents);
    
    // Step 5: Update volatility
    float sigmaPrime = UpdateVolatility(phi, variance, delta, sigma);
    
    // Step 6: Update rating deviation to pre-rating period value
    float phiStar = std::sqrt(phi * phi + sigmaPrime * sigmaPrime);
    
    // Step 7: Update rating and RD
    float phiPrime = 1.0f / std::sqrt(1.0f / (phiStar * phiStar) + 1.0f / variance);
    
    float sum = 0.0f;
    for (const auto& opponent : opponents)
    {
        float muJ = ConvertRatingToGlicko2(opponent.rating);
        float phiJ = ConvertRDToGlicko2(opponent.ratingDeviation);
        sum += CalculateG(phiJ) * (opponent.score - CalculateE(mu, muJ, phiJ));
    }
    float muPrime = mu + phiPrime * phiPrime * sum;
    
    // Step 8: Convert back to original scale
    Glicko2Rating newRating;
    newRating.rating = ConvertRatingFromGlicko2(muPrime);
    newRating.ratingDeviation = ConvertRDFromGlicko2(phiPrime);
    newRating.volatility = sigmaPrime;
    
    return newRating;
}

Glicko2Rating Glicko2System::UpdateInactiveRating(const Glicko2Rating& playerRating)
{
    float phi = ConvertRDToGlicko2(playerRating.ratingDeviation);
    float sigma = playerRating.volatility;
    
    // Only update RD (increase uncertainty)
    float phiPrime = std::sqrt(phi * phi + sigma * sigma);
    
    Glicko2Rating newRating = playerRating;
    newRating.ratingDeviation = ConvertRDFromGlicko2(phiPrime);
    
    return newRating;
}
