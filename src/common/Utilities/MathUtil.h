/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
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
    size_t n = a.size();
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
