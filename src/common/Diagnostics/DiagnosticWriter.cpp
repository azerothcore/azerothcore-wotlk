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
#include "DiagnosticFormat.h"
#include "Errors.h"

#include <cstring>
#include <limits>
#include <string_view>
#include <utility>

namespace
{
    constexpr std::size_t CloseRecordSize = 2;

    uint64 TagValue(DiagnosticTag tag) noexcept
    {
        return static_cast<uint64>(static_cast<CborTag>(tag));
    }

    CborError EncodeText(CborEncoder* encoder, std::string_view value) noexcept
    {
        return cbor_encode_text_string(encoder, value.data(), value.size());
    }

    bool CborSucceeded(CborError error) noexcept
    {
        return error == CborNoError;
    }
}

DiagnosticWriter::DiagnosticWriter(RingBuffer& buffer) noexcept :
    _buffer(&buffer)
{
}

std::size_t DiagnosticWriter::CurrentPosition() const noexcept
{
    return _buffer->Position();
}

std::size_t DiagnosticWriter::BufferSize() const noexcept
{
    return _buffer->ReadSpan().size();
}

bool DiagnosticWriter::OpenSection(StringLiteralView name) noexcept
{
    std::string_view nameView = name;

    return WriteTaggedRecord(TagValue(DiagnosticTag::Open), 1,
        [nameView](CborEncoder* array) noexcept
        {
            return EncodeText(array, nameView);
        });
}

bool DiagnosticWriter::WriteArgument(StringLiteralView name, bool value) noexcept
{
    std::string_view nameView = name;

    return WriteTaggedRecord(TagValue(DiagnosticTag::Arg), 2,
        [nameView, value](CborEncoder* array) noexcept
        {
            CborError error = EncodeText(array, nameView);
            if (error)
                return error;

            return cbor_encode_boolean(array, value);
        });
}

bool DiagnosticWriter::WriteArgument(StringLiteralView name, int value) noexcept
{
    return WriteArgument(name, static_cast<int64>(value));
}

bool DiagnosticWriter::WriteArgument(StringLiteralView name, uint32 value) noexcept
{
    return WriteArgument(name, static_cast<uint64>(value));
}

bool DiagnosticWriter::WriteArgument(StringLiteralView name, int64 value) noexcept
{
    std::string_view nameView = name;

    return WriteTaggedRecord(TagValue(DiagnosticTag::Arg), 2,
        [nameView, value](CborEncoder* array) noexcept
        {
            CborError error = EncodeText(array, nameView);
            if (error)
                return error;

            return cbor_encode_int(array, value);
        });
}

bool DiagnosticWriter::WriteArgument(StringLiteralView name, uint64 value) noexcept
{
    std::string_view nameView = name;

    return WriteTaggedRecord(TagValue(DiagnosticTag::Arg), 2,
        [nameView, value](CborEncoder* array) noexcept
        {
            CborError error = EncodeText(array, nameView);
            if (error)
                return error;

            return cbor_encode_uint(array, value);
        });
}

bool DiagnosticWriter::WriteArgument(StringLiteralView name, double value) noexcept
{
    std::string_view nameView = name;

    return WriteTaggedRecord(TagValue(DiagnosticTag::Arg), 2,
        [nameView, value](CborEncoder* array) noexcept
        {
            CborError error = EncodeText(array, nameView);
            if (error)
                return error;

            return cbor_encode_double(array, value);
        });
}

bool DiagnosticWriter::WriteArgument(StringLiteralView name, char const* value) noexcept
{
    ASSERT(value, "DiagnosticWriter::WriteArgument called with a null string");

    if (!value)
        return false;

    return WriteArgument(name, std::string_view(value));
}

bool DiagnosticWriter::WriteArgument(StringLiteralView name, StringLiteralView value) noexcept
{
    return WriteArgument(name, static_cast<std::string_view>(value));
}

bool DiagnosticWriter::WriteArgument(StringLiteralView name, std::string_view value) noexcept
{
    std::string_view nameView = name;

    return WriteTaggedRecord(TagValue(DiagnosticTag::Arg), 2,
        [nameView, value](CborEncoder* array) noexcept
        {
            CborError error = EncodeText(array, nameView);
            if (error)
                return error;

            return EncodeText(array, value);
        });
}

bool DiagnosticWriter::CloseSection(std::size_t sectionBegin) noexcept
{
    ASSERT(sectionBegin <= CurrentPosition(), "Diagnostic section begin is after the current buffer position");

    uint64 const sectionLength =
        static_cast<uint64>(CurrentPosition() - sectionBegin) +
        CloseRecordSize +
        sizeof(DiagnosticSectionFooter);
    uint64 const bufferSize = BufferSize();
    bool const fitsWithTerminator =
        sectionLength <= bufferSize &&
        bufferSize - sectionLength >= sizeof(DiagnosticSectionFooter);

    ASSERT(fitsWithTerminator, "Diagnostic section length {} leaves no room for a terminator in buffer size {}",
        sectionLength, bufferSize);

    if (!fitsWithTerminator)
        return false;

    if (!WriteTaggedRecord(TagValue(DiagnosticTag::Close), 0,
        [](CborEncoder*) noexcept
        {
            return CborNoError;
        }))
    {
        return false;
    }

    return WriteSectionFooter(sectionLength);
}

template <typename Encode>
bool DiagnosticWriter::WriteTaggedRecord(uint64 tag, std::size_t arrayLength, Encode&& encode) noexcept
{
    std::span<uint8> target = _buffer->WriteSpan();
    CborEncoder encoder;
    CborEncoder array;

    cbor_encoder_init(&encoder, target.data(), target.size(), 0);

    CborError error = cbor_encode_tag(&encoder, static_cast<CborTag>(tag));
    if (CborSucceeded(error))
        error = cbor_encoder_create_array(&encoder, &array, arrayLength);
    if (CborSucceeded(error))
        error = std::forward<Encode>(encode)(&array);
    if (CborSucceeded(error))
        error = cbor_encoder_close_container_checked(&encoder, &array);

    if (!CborSucceeded(error))
        return false;

    std::size_t const bytes = cbor_encoder_get_buffer_size(&encoder, target.data());
    ASSERT(bytes <= target.size(), "Diagnostic record length {} exceeds buffer size {}", bytes, target.size());

    _buffer->Advance(bytes);

    return true;
}

bool DiagnosticWriter::WriteSectionFooter(uint64 sectionLength) noexcept
{
    DiagnosticSectionFooter const footer = sectionLength;
    std::span<uint8> target = _buffer->WriteSpan();
    ASSERT(target.size() >= sizeof(footer), "Diagnostic ring buffer is too small for a section footer");

    if (target.size() < sizeof(footer))
        return false;

    std::memcpy(target.data(), &footer, sizeof(footer));
    _buffer->Advance(sizeof(footer));
    WriteZeroFooterAtHead();

    return true;
}

void DiagnosticWriter::WriteZeroFooterAtHead() noexcept
{
    std::span<uint8> target = _buffer->WriteSpan();

    if (target.size() >= sizeof(DiagnosticSectionFooter))
        std::memset(target.data(), 0, sizeof(DiagnosticSectionFooter));
}
