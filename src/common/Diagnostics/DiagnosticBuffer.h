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

#ifndef ACORE_DIAGNOSTIC_BUFFER_H
#define ACORE_DIAGNOSTIC_BUFFER_H

#include "Define.h"
#include "OverwritingRingBuffer.h"
#include "StringLiteralView.h"

#include <boost/static_string.hpp>

#include <cstddef>
#include <string_view>
#include <type_traits>
#include <utility>
#include <variant>

inline constexpr std::size_t DiagnosticStaticStringCapacity = 64;

using DiagnosticStaticString = boost::static_string<DiagnosticStaticStringCapacity>;
using DiagnosticStoredValue = std::variant<bool, int64, uint64, double, StringLiteralView, DiagnosticStaticString>;

struct DiagnosticRecord
{
    template <typename Value>
    DiagnosticRecord(StringLiteralView recordName, Value&& recordValue) :
        name(recordName),
        value(std::forward<Value>(recordValue))
    {
    }

    StringLiteralView name;
    DiagnosticStoredValue value;
};

using DiagnosticBuffer = OverwritingRingBuffer<DiagnosticRecord>;

static_assert(std::is_trivially_copyable_v<StringLiteralView>);
static_assert(std::is_trivially_copyable_v<DiagnosticStaticString>);
static_assert(std::is_trivially_copyable_v<DiagnosticStoredValue>);
static_assert(std::is_trivially_copyable_v<DiagnosticRecord>);
static_assert(std::is_trivially_destructible_v<DiagnosticRecord>);

[[nodiscard]] inline std::string_view DiagnosticStringView(StringLiteralView value) noexcept
{
    return static_cast<std::string_view>(value);
}

[[nodiscard]] inline std::string_view DiagnosticStringView(DiagnosticStaticString const& value) noexcept
{
    return { value.data(), value.size() };
}

#endif // ACORE_DIAGNOSTIC_BUFFER_H
