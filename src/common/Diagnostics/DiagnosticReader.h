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
#include "RingBuffer.h"

#include <optional>
#include <span>
#include <string_view>
#include <variant>
#include <vector>

using DiagnosticValue = std::variant<bool, int64, uint64, double, std::string_view>;

struct DiagnosticArg
{
    /**
     * @brief The name of this argument.
     */
    std::string_view name;

    /**
     * @brief The value of this argument.
     */
    DiagnosticValue value;
};

struct DiagnosticEvent
{
    /**
     * @brief The name of this event.
     */
    std::string_view name;

    /**
     * @brief The arguments written directly to this event.
     */
    std::vector<DiagnosticArg> args;

    /**
     * @brief The nested events written directly to this event.
     */
    std::vector<DiagnosticEvent> children;
};

class AC_COMMON_API DiagnosticReadResult
{
public:
    /**
     * @brief Create an empty result.
     */
    DiagnosticReadResult() = default;

    /**
     * @brief Destroy this object.
     */
    ~DiagnosticReadResult() = default;

    DiagnosticReadResult(DiagnosticReadResult&&) noexcept = default;
    DiagnosticReadResult& operator=(DiagnosticReadResult&&) noexcept = default;

    DiagnosticReadResult(DiagnosticReadResult const&) = delete;
    DiagnosticReadResult& operator=(DiagnosticReadResult const&) = delete;

    /**
     * @brief The recovered diagnostic events in natural forward order.
     */
    std::vector<DiagnosticEvent> events;

private:
    friend class DiagnosticReader;

    DiagnosticReadResult(std::optional<RingBuffer>&& records, std::vector<DiagnosticEvent>&& recoveredEvents);

    std::optional<RingBuffer> _ownedRecords;
};

class AC_COMMON_API DiagnosticReader
{
public:
    /**
     * @brief Create a reader owning the specified @p records.
     *
     * @param records The cloned diagnostic buffer to read.
     */
    explicit DiagnosticReader(RingBuffer&& records) noexcept;

    /**
     * @brief Destroy this object.
     */
    ~DiagnosticReader() = default;

    DiagnosticReader(DiagnosticReader&&) noexcept = default;
    DiagnosticReader& operator=(DiagnosticReader&&) noexcept = default;

    DiagnosticReader(DiagnosticReader const&) = delete;
    DiagnosticReader& operator=(DiagnosticReader const&) = delete;

    /**
     * @brief Return the recovered diagnostic events in natural forward order.
     *
     * @return The recovered diagnostic events in natural forward order, along
     *         with the cloned backing storage that owns their string data.
     */
    [[nodiscard]] DiagnosticReadResult ReadEvents();

private:
    RingBuffer _records;
};

/**
 * @brief Recover diagnostic events from the specified @p snapshot.
 *
 * @param snapshot The cloned ring-buffer read span to recover from.
 * @return The recovered diagnostic events in natural forward order.
 *
 * The returned events contain string views into the specified @p snapshot.
 */
AC_COMMON_API std::vector<DiagnosticEvent> RecoverRecords(std::span<uint8 const> snapshot);

#endif // ACORE_DIAGNOSTIC_READER_H
