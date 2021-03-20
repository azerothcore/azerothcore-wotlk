/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2020 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef _DURATION_H_
#define _DURATION_H_

#include <chrono>

/// Microseconds shorthand typedef.
typedef std::chrono::microseconds Microseconds;

/// Milliseconds shorthand typedef.
typedef std::chrono::milliseconds Milliseconds;

/// Seconds shorthand typedef.
typedef std::chrono::seconds Seconds;

/// Minutes shorthand typedef.
typedef std::chrono::minutes Minutes;

/// Hours shorthand typedef.
typedef std::chrono::hours Hours;

/// time_point shorthand typedefs
typedef std::chrono::steady_clock::time_point TimePoint;
typedef std::chrono::system_clock::time_point SystemTimePoint;

/// Makes std::chrono_literals globally available.
using namespace std::chrono_literals;

#endif
