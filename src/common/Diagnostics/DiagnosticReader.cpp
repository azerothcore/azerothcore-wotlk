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

#include "DiagnosticReader.h"

#include <string_view>
#include <type_traits>
#include <utility>

namespace
{
    std::string_view ReadStoredString(StringLiteralView value) noexcept
    {
        return DiagnosticStringView(value);
    }

    std::string_view ReadStoredString(DiagnosticStaticString const& value) noexcept
    {
        return DiagnosticStringView(value);
    }

    DiagnosticValue ReadStoredValue(DiagnosticStoredValue const& value)
    {
        return std::visit([](auto const& stored) -> DiagnosticValue
        {
            using T = std::decay_t<decltype(stored)>;

            if constexpr (std::is_same_v<T, StringLiteralView> || std::is_same_v<T, DiagnosticStaticString>)
                return ReadStoredString(stored);
            else
                return stored;
        }, value);
    }
}

DiagnosticReadResult::DiagnosticReadResult(std::vector<DiagnosticRecord>&& records, std::vector<DiagnosticArg>&& recoveredEntries) :
    entries(std::move(recoveredEntries)),
    _ownedRecords(std::move(records))
{
}

DiagnosticReader::DiagnosticReader(std::vector<DiagnosticRecord>&& records) noexcept :
    _records(std::move(records))
{
}

DiagnosticReadResult DiagnosticReader::ReadEntries()
{
    std::vector<DiagnosticArg> entries = RecoverRecords(_records);

    return DiagnosticReadResult(std::move(_records), std::move(entries));
}

std::vector<DiagnosticArg> RecoverRecords(std::span<DiagnosticRecord const> snapshot)
{
    std::vector<DiagnosticArg> entries;
    entries.reserve(snapshot.size());

    for (DiagnosticRecord const& record : snapshot)
    {
        DiagnosticArg entry;
        entry.name = DiagnosticStringView(record.name);
        entry.value = ReadStoredValue(record.value);
        entries.push_back(entry);
    }

    return entries;
}
