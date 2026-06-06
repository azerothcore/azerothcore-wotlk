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

#ifndef ACORE_DIAGNOSTIC_WRITER_H
#define ACORE_DIAGNOSTIC_WRITER_H

#include "Define.h"
#include "DiagnosticBuffer.h"
#include "StringLiteralView.h"

#include <cstddef>
#include <string_view>

class DiagnosticGuard;

class AC_COMMON_API DiagnosticWriter
{
public:
    /**
     * @brief Create a writer backed by the specified @p buffer.
     *
     * @param buffer The diagnostic buffer backing this writer.
     */
    explicit DiagnosticWriter(DiagnosticBuffer& buffer) noexcept;

    /**
     * @brief Destroy this object.
     */
    ~DiagnosticWriter() = default;

    DiagnosticWriter(DiagnosticWriter&&) noexcept = default;
    DiagnosticWriter& operator=(DiagnosticWriter&&) noexcept = default;

    DiagnosticWriter(DiagnosticWriter const&) noexcept = default;
    DiagnosticWriter& operator=(DiagnosticWriter const&) noexcept = default;

private:
    friend class DiagnosticGuard;

    void WriteArgument(StringLiteralView name, bool value) noexcept;
    void WriteArgument(StringLiteralView name, int value) noexcept;
    void WriteArgument(StringLiteralView name, uint32 value) noexcept;
    void WriteArgument(StringLiteralView name, int64 value) noexcept;
    void WriteArgument(StringLiteralView name, uint64 value) noexcept;
    void WriteArgument(StringLiteralView name, double value) noexcept;
    void WriteArgument(StringLiteralView name, StringLiteralView value) noexcept;
    void WriteArgument(StringLiteralView name, std::string_view value) noexcept;

    template <std::size_t Size>
    void WriteArgument(StringLiteralView name, char const (&value)[Size]) noexcept
    {
        static_assert(Size > 0);
        WriteArgument(name, std::string_view(value, Size - 1));
    }

    DiagnosticBuffer* _buffer = nullptr;
};

#endif // ACORE_DIAGNOSTIC_WRITER_H
