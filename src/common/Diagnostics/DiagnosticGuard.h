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

#ifndef ACORE_DIAGNOSTIC_GUARD_H
#define ACORE_DIAGNOSTIC_GUARD_H

#include "Define.h"
#include "DiagnosticWriter.h"
#include "StringLiteralView.h"

#include <cstddef>
#include <string_view>

class AC_COMMON_API DiagnosticGuard
{
public:
    /**
     * @brief Create a guard that opens a diagnostic section having the
     *        specified @p name in the specified @p writer.
     *
     * @param writer The writer to receive this section.
     * @param name The name of the section.
     */
    DiagnosticGuard(DiagnosticWriter writer, StringLiteralView name) noexcept;

    /**
     * @brief Close this guard's diagnostic section.
     */
    ~DiagnosticGuard() noexcept;

    DiagnosticGuard(DiagnosticGuard const&) = delete;
    DiagnosticGuard& operator=(DiagnosticGuard const&) = delete;
    DiagnosticGuard(DiagnosticGuard&& other) noexcept;
    DiagnosticGuard& operator=(DiagnosticGuard&&) = delete;

    /**
     * @brief Write an argument having the specified @p name and @p value to
     *        this guard's section.
     *
     * @param name The name of the argument.
     * @param value The value of the argument.
     */
    void Arg(StringLiteralView name, bool value) noexcept;
    void Arg(StringLiteralView name, int value) noexcept;
    void Arg(StringLiteralView name, uint32 value) noexcept;
    void Arg(StringLiteralView name, int64 value) noexcept;
    void Arg(StringLiteralView name, uint64 value) noexcept;
    void Arg(StringLiteralView name, double value) noexcept;
    void Arg(StringLiteralView name, char const* value) noexcept;
    void Arg(StringLiteralView name, StringLiteralView value) noexcept;
    void Arg(StringLiteralView name, std::string_view value) noexcept;

private:
    DiagnosticWriter _writer;
    std::size_t _beginPosition = 0;
    bool _active = false;
};

#endif // ACORE_DIAGNOSTIC_GUARD_H
