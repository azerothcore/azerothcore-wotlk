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

#ifndef ACORE_DIAGNOSTIC_READER_H
#define ACORE_DIAGNOSTIC_READER_H

#include "Define.h"
#include "DiagnosticBuffer.h"

#include <cstddef>
#include <span>
#include <string_view>
#include <type_traits>
#include <utility>
#include <variant>
#include <vector>

using DiagnosticValue = std::variant<bool, int64, uint64, double, std::string_view>;

struct DiagnosticArg
{
    /**
     * @brief The name of this entry.
     */
    std::string_view name;

    /**
     * @brief The value of this entry.
     */
    DiagnosticValue value;
};

/**
 * @brief Recover the consumer-facing value of the specified stored @p value,
 *        mapping both stored string representations onto a string view.
 *
 * @param value The stored value to recover.
 * @return The recovered value.
 *
 * A recovered string view refers into @p value and is valid for as long as the
 * storage backing @p value outlives it.
 */
[[nodiscard]] inline DiagnosticValue DiagnosticRecoverValue(DiagnosticStoredValue const& value)
{
    return std::visit([](auto const& stored) -> DiagnosticValue
    {
        using T = std::decay_t<decltype(stored)>;

        if constexpr (std::is_same_v<T, StringLiteralView> || std::is_same_v<T, DiagnosticStaticString>)
            return DiagnosticStringView(stored);
        else
            return stored;
    }, value);
}

/**
 * @brief Invoke @p visitor with a DiagnosticArg for each of the specified
 *        @p records, in natural forward order.
 *
 * @param records The records to recover.
 * @param visitor The callable, invoked as `visitor(DiagnosticArg const&)`.
 *
 * No storage is allocated; each visited argument's string views refer into
 * @p records and are valid only for the duration of the visit.
 */
template <typename Visitor>
void VisitDiagnosticRecords(std::span<DiagnosticRecord const> records, Visitor&& visitor)
{
    for (DiagnosticRecord const& record : records)
        visitor(DiagnosticArg{ DiagnosticStringView(record.name), DiagnosticRecoverValue(record.value) });
}

class AC_COMMON_API DiagnosticReader
{
public:
    /**
     * @brief Create a reader owning the specified @p records.
     *
     * @param records The cloned diagnostic records to read.
     */
    explicit DiagnosticReader(std::vector<DiagnosticRecord>&& records) noexcept;

    /**
     * @brief Destroy this object.
     */
    ~DiagnosticReader() = default;

    DiagnosticReader(DiagnosticReader&&) noexcept = default;
    DiagnosticReader& operator=(DiagnosticReader&&) noexcept = default;

    DiagnosticReader(DiagnosticReader const&) = delete;
    DiagnosticReader& operator=(DiagnosticReader const&) = delete;

    /**
     * @brief Return the number of recovered entries.
     *
     * @return The number of recovered entries.
     */
    [[nodiscard]] std::size_t Size() const noexcept { return _records.size(); }

    /**
     * @brief Invoke @p visitor with each recovered DiagnosticArg in natural
     *        forward order.
     *
     * @param visitor The callable, invoked as `visitor(DiagnosticArg const&)`.
     *
     * Each visited argument's string views refer into this reader's storage and
     * are valid for as long as this reader outlives them.
     */
    template <typename Visitor>
    void Visit(Visitor&& visitor) const
    {
        VisitDiagnosticRecords(_records, std::forward<Visitor>(visitor));
    }

private:
    std::vector<DiagnosticRecord> _records;
};

#endif // ACORE_DIAGNOSTIC_READER_H
