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

#include <utility>

class AC_COMMON_API DiagnosticGuard
{
public:
    /**
     * @brief Create a guard that writes a @c "function" entry having the
     *        specified @p name to the specified @p writer.
     *
     * @param writer The writer to receive this guard's entries.
     * @param name The name identifying this scope.
     */
    DiagnosticGuard(DiagnosticWriter writer, StringLiteralView name) noexcept;

    DiagnosticGuard(DiagnosticGuard const&) = delete;
    DiagnosticGuard& operator=(DiagnosticGuard const&) = delete;
    DiagnosticGuard(DiagnosticGuard&&) noexcept = default;
    DiagnosticGuard& operator=(DiagnosticGuard&&) = delete;

    /**
     * @brief Write an argument having the specified @p name and @p value to
     *        this guard's section.
     *
     * @param name The name of the argument.
     * @param value The value of the argument.
     */
    template <typename T>
    void Arg(StringLiteralView name, T&& value) noexcept
    {
        _writer.WriteArgument(name, std::forward<T>(value));
    }

private:
    DiagnosticWriter _writer;
};

#endif // ACORE_DIAGNOSTIC_GUARD_H
