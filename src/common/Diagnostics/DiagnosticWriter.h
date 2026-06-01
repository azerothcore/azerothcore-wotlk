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
#include "RingBuffer.h"
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
     * @param buffer The ring buffer backing this writer.
     *
     * The behavior is undefined unless @p buffer contains a mapping.
     */
    explicit DiagnosticWriter(RingBuffer& buffer) noexcept;

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

    [[nodiscard]] std::size_t CurrentPosition() const noexcept;
    [[nodiscard]] std::size_t BufferSize() const noexcept;

    bool OpenSection(StringLiteralView name) noexcept;
    bool WriteArgument(StringLiteralView name, bool value) noexcept;
    bool WriteArgument(StringLiteralView name, int value) noexcept;
    bool WriteArgument(StringLiteralView name, uint32 value) noexcept;
    bool WriteArgument(StringLiteralView name, int64 value) noexcept;
    bool WriteArgument(StringLiteralView name, uint64 value) noexcept;
    bool WriteArgument(StringLiteralView name, double value) noexcept;
    bool WriteArgument(StringLiteralView name, char const* value) noexcept;
    bool WriteArgument(StringLiteralView name, StringLiteralView value) noexcept;
    bool WriteArgument(StringLiteralView name, std::string_view value) noexcept;

    bool CloseSection(std::size_t sectionBegin) noexcept;

    template <typename Encode>
    bool WriteTaggedRecord(uint64 tag, std::size_t arrayLength, Encode&& encode) noexcept;

    bool WriteSectionFooter(uint64 sectionLength) noexcept;
    void WriteZeroFooterAtHead() noexcept;

    RingBuffer* _buffer = nullptr;
};

#endif // ACORE_DIAGNOSTIC_WRITER_H
