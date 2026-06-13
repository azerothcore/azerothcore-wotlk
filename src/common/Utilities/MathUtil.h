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

#ifndef _MATH_UTIL_H
#define _MATH_UTIL_H

#include <algorithm>
#include <iterator>
#include <numeric>
#include <vector>

// based on https://stackoverflow.com/questions/7616511/calculate-mean-and-standard-deviation-from-a-vector-of-samples-in-c-using-boos/12405793#comment32490316_12405793
template <typename Container, typename T = typename std::decay<decltype(*std::begin(std::declval<Container>()))>::type>
inline T standard_deviation(Container&& c)
{
    auto b = std::begin(c), e = std::end(c);
    auto size = std::distance(b, e);
    auto sum = std::accumulate(b, e, T());
    auto mean = sum / size;

    if (size == 1)
    {
        return (T) 0;
    }

    T accum = T();
    for (const auto d : c)
    {
        accum += (d - mean) * (d - mean);
    }
    return std::sqrt(accum / (size - 1));
}

template <typename Container, typename T = typename std::decay<decltype(*std::begin(std::declval<Container>()))>::type>
inline T mean(Container&& c)
{
    auto b = std::begin(c), e = std::end(c);
    auto size = std::distance(b, e);
    auto sum = std::accumulate(b, e, T());
    return sum / size;
}

// based off https://www.geeksforgeeks.org/finding-median-of-unsorted-array-in-linear-time-using-c-stl/
template <typename T>
inline T median(std::vector<T> a)
{
    std::size_t n = a.size();
    // If size of the arr[] is even
    if (n % 2 == 0)
    {

        // Applying nth_element
        // on n/2th index
        std::nth_element(a.begin(),
            a.begin() + n / 2,
            a.end());

        // Applying nth_element
        // on (n-1)/2 th index
        std::nth_element(a.begin(),
            a.begin() + (n - 1) / 2,
            a.end());

        // Find the average of value at
        // index N/2 and (N-1)/2
        return (T)(a[(n - 1) / 2]
            + a[n / 2])
            / 2.0;
    }

    // If size of the arr[] is odd
    else
    {

        // Applying nth_element
        // on n/2
        std::nth_element(a.begin(),
            a.begin() + n / 2,
            a.end());

        // Value at index (N/2)th
        // is the median
        return (T)a[n / 2];
    }
}

#endif
