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

#include "DiagnosticWriter.h"

#include <algorithm>
#include <string_view>

DiagnosticWriter::DiagnosticWriter(DiagnosticBuffer& buffer) noexcept :
    _buffer(&buffer)
{
}

void DiagnosticWriter::WriteArgument(StringLiteralView name, bool value) noexcept
{
    _buffer->Push(DiagnosticRecord(name, DiagnosticStoredValue(value)));
}

void DiagnosticWriter::WriteArgument(StringLiteralView name, int value) noexcept
{
    WriteArgument(name, static_cast<int64>(value));
}

void DiagnosticWriter::WriteArgument(StringLiteralView name, uint32 value) noexcept
{
    WriteArgument(name, static_cast<uint64>(value));
}

void DiagnosticWriter::WriteArgument(StringLiteralView name, int64 value) noexcept
{
    _buffer->Push(DiagnosticRecord(name, DiagnosticStoredValue(value)));
}

void DiagnosticWriter::WriteArgument(StringLiteralView name, uint64 value) noexcept
{
    _buffer->Push(DiagnosticRecord(name, DiagnosticStoredValue(value)));
}

void DiagnosticWriter::WriteArgument(StringLiteralView name, double value) noexcept
{
    _buffer->Push(DiagnosticRecord(name, DiagnosticStoredValue(value)));
}

void DiagnosticWriter::WriteArgument(StringLiteralView name, StringLiteralView value) noexcept
{
    _buffer->Push(DiagnosticRecord(name, DiagnosticStoredValue(value)));
}

void DiagnosticWriter::WriteArgument(StringLiteralView name, std::string_view value) noexcept
{
    // Values longer than the inline capacity are truncated rather than dropped.
    std::size_t const count = std::min(value.size(), DiagnosticStaticStringCapacity);

    DiagnosticStaticString stored;
    stored.assign(value.data(), count);

    _buffer->Push(DiagnosticRecord(name, DiagnosticStoredValue(stored)));
}
