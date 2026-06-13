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

#ifndef _DURATION_H_
#define _DURATION_H_

#include <chrono>

/// Microseconds shorthand typedef.
using Microseconds = std::chrono::microseconds;

/// Milliseconds shorthand typedef.
using Milliseconds = std::chrono::milliseconds;

/// Seconds shorthand typedef.
using Seconds = std::chrono::seconds;

/// Minutes shorthand typedef.
using Minutes = std::chrono::minutes;

/// Hours shorthand typedef.
using Hours = std::chrono::hours;

// Workaround for GCC and Clang 10 in C++20
#if defined(__GNUC__) && (!defined(__clang__) || (__clang_major__ == 10))
/// Days shorthand typedef.
using Days = std::chrono::duration<__INT64_TYPE__, std::ratio<86400>>;

/// Weeks shorthand typedef.
using Weeks = std::chrono::duration<__INT64_TYPE__, std::ratio<604800>>;

/// Years shorthand typedef.
using Years = std::chrono::duration<__INT64_TYPE__, std::ratio<31556952>>;

/// Months shorthand typedef.
using Months = std::chrono::duration<__INT64_TYPE__, std::ratio<2629746>>;

#else

/// Days shorthand typedef.
using Days = std::chrono::days;

/// Weeks shorthand typedef.
using Weeks = std::chrono::weeks;

/// Years shorthand typedef.
using Years = std::chrono::years;

/// Months shorthand typedef.
using Months = std::chrono::months;

#endif // GCC_VERSION

/// time_point shorthand typedefs
using TimePoint = std::chrono::steady_clock::time_point;
using SystemTimePoint = std::chrono::system_clock::time_point;

/// Makes std::chrono_literals globally available.
using namespace std::chrono_literals;

constexpr Days operator""_days(unsigned long long days)
{
    return Days(days);
}

constexpr Weeks operator""_weeks(unsigned long long weeks)
{
    return Weeks(weeks);
}

constexpr Years operator""_years(unsigned long long years)
{
    return Years(years);
}

constexpr Months operator""_months(unsigned long long months)
{
    return Months(months);
}

#endif
