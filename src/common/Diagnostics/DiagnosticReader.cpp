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
#include "DiagnosticFormat.h"

#include <algorithm>
#include <cstring>
#include <limits>
#include <optional>
#include <utility>

namespace
{
    class Decoder
    {
    public:
        explicit Decoder(std::span<uint8 const> bytes) :
            _pos(bytes.data()),
            _end(bytes.empty() ? bytes.data() : bytes.data() + bytes.size())
        {
        }

        std::optional<DiagnosticEvent> ReadRootEvent()
        {
            return ReadEvent(false);
        }

    private:
        std::optional<DiagnosticEvent> ReadEvent(bool skipFooter)
        {
            DiagnosticEvent event;
            if (!ReadTaggedRecord(DiagnosticTag::Open, 1,
                [&event](CborValue& value)
                {
                    return ReadText(value, event.name);
                }))
            {
                return std::nullopt;
            }

            while (_pos < _end)
            {
                DiagnosticTag tag;
                if (!PeekTag(tag))
                    return std::nullopt;

                switch (tag)
                {
                    case DiagnosticTag::Arg:
                        if (!ReadArg(event))
                            return std::nullopt;
                        break;
                    case DiagnosticTag::Open:
                    {
                        std::optional<DiagnosticEvent> child = ReadEvent(true);
                        if (!child)
                            return std::nullopt;

                        event.children.push_back(std::move(*child));
                        break;
                    }
                    case DiagnosticTag::Close:
                        if (!ReadClose(skipFooter))
                            return std::nullopt;

                        return event;
                }
            }

            return std::nullopt;
        }

        bool ReadArg(DiagnosticEvent& event)
        {
            DiagnosticArg arg;
            if (!ReadTaggedRecord(DiagnosticTag::Arg, 2,
                [&arg](CborValue& value)
                {
                    return ReadText(value, arg.name) &&
                        ReadValue(value, arg.value);
                }))
            {
                return false;
            }

            event.args.push_back(arg);
            return true;
        }

        bool ReadClose(bool skipFooter)
        {
            if (!ReadTaggedRecord(DiagnosticTag::Close, 0,
                [](CborValue&)
                {
                    return true;
                }))
            {
                return false;
            }

            if (skipFooter)
                return SkipFooter();

            return true;
        }

        template <typename Decode>
        bool ReadTaggedRecord(DiagnosticTag expectedTag, std::size_t expectedSize, Decode&& decode)
        {
            DiagnosticTag tag;
            CborParser parser;
            CborValue record;
            CborValue item;

            if (cbor_parser_init(_pos, static_cast<std::size_t>(_end - _pos), 0, &parser, &record) != CborNoError)
                return false;
            if (!ReadTag(record, tag) || tag != expectedTag)
                return false;
            if (cbor_value_skip_tag(&record) != CborNoError)
                return false;
            if (!cbor_value_is_array(&record))
                return false;

            std::size_t size;
            if (cbor_value_get_array_length(&record, &size) != CborNoError || size != expectedSize)
                return false;
            if (cbor_value_enter_container(&record, &item) != CborNoError)
                return false;
            if (!std::forward<Decode>(decode)(item))
                return false;
            if (!cbor_value_at_end(&item))
                return false;

            // Do not call cbor_value_leave_container here: the next byte after
            // a nested close record may be this stream's raw section footer.
            uint8 const* next = cbor_value_get_next_byte(&item);
            if (next <= _pos || next > _end)
                return false;

            _pos = next;
            return true;
        }

        bool PeekTag(DiagnosticTag& tag)
        {
            CborParser parser;
            CborValue value;

            if (cbor_parser_init(_pos, static_cast<std::size_t>(_end - _pos), 0, &parser, &value) != CborNoError)
                return false;

            return ReadTag(value, tag);
        }

        static bool ReadTag(CborValue const& value, DiagnosticTag& tag)
        {
            if (!cbor_value_is_tag(&value))
                return false;

            CborTag cborTag;
            if (cbor_value_get_tag(&value, &cborTag) != CborNoError)
                return false;

            switch (cborTag)
            {
                case static_cast<CborTag>(DiagnosticTag::Open):
                    tag = DiagnosticTag::Open;
                    return true;
                case static_cast<CborTag>(DiagnosticTag::Arg):
                    tag = DiagnosticTag::Arg;
                    return true;
                case static_cast<CborTag>(DiagnosticTag::Close):
                    tag = DiagnosticTag::Close;
                    return true;
                default:
                    return false;
            }
        }

        static bool ReadText(CborValue& value, std::string_view& text)
        {
            if (!cbor_value_is_text_string(&value))
                return false;

            CborValue string = value;
            std::string_view result;

            if (cbor_value_begin_string_iteration(&string) != CborNoError)
                return false;

            char const* data = nullptr;
            std::size_t size = 0;
            if (cbor_value_get_text_string_chunk(&string, &data, &size, &string) != CborNoError || !data)
                return false;

            result = { data, size };

            if (!cbor_value_string_iteration_at_end(&string))
                return false;
            if (cbor_value_finish_string_iteration(&string) != CborNoError)
                return false;

            value = string;
            text = result;

            return true;
        }

        static bool ReadValue(CborValue& cborValue, DiagnosticValue& value)
        {
            if (cbor_value_is_unsigned_integer(&cborValue))
            {
                uint64 unsignedValue;
                if (cbor_value_get_uint64(&cborValue, &unsignedValue) != CborNoError)
                    return false;

                // CBOR does not retain whether a positive integer came from a
                // signed or unsigned source value.
                if (unsignedValue <= static_cast<uint64>(std::numeric_limits<int64>::max()))
                    value = static_cast<int64>(unsignedValue);
                else
                    value = unsignedValue;

                return cbor_value_advance_fixed(&cborValue) == CborNoError;
            }

            if (cbor_value_is_negative_integer(&cborValue))
            {
                int64 signedValue;
                if (cbor_value_get_int64_checked(&cborValue, &signedValue) != CborNoError)
                    return false;

                value = signedValue;
                return cbor_value_advance_fixed(&cborValue) == CborNoError;
            }

            if (cbor_value_is_text_string(&cborValue))
            {
                std::string_view stringValue;
                if (!ReadText(cborValue, stringValue))
                    return false;

                value = stringValue;
                return true;
            }

            if (cbor_value_is_boolean(&cborValue))
            {
                bool boolValue;
                if (cbor_value_get_boolean(&cborValue, &boolValue) != CborNoError)
                    return false;

                value = boolValue;
                return cbor_value_advance_fixed(&cborValue) == CborNoError;
            }

            if (cbor_value_is_double(&cborValue))
            {
                double doubleValue;
                if (cbor_value_get_double(&cborValue, &doubleValue) != CborNoError)
                    return false;

                value = doubleValue;
                return cbor_value_advance_fixed(&cborValue) == CborNoError;
            }

            if (cbor_value_is_float(&cborValue))
            {
                float floatValue;
                if (cbor_value_get_float(&cborValue, &floatValue) != CborNoError)
                    return false;

                value = static_cast<double>(floatValue);
                return cbor_value_advance_fixed(&cborValue) == CborNoError;
            }

            if (cbor_value_is_half_float(&cborValue))
            {
                float floatValue;
                if (cbor_value_get_half_float_as_float(&cborValue, &floatValue) != CborNoError)
                    return false;

                value = static_cast<double>(floatValue);
                return cbor_value_advance_fixed(&cborValue) == CborNoError;
            }

            return false;
        }

        bool SkipFooter()
        {
            if (static_cast<std::size_t>(_end - _pos) < sizeof(DiagnosticSectionFooter))
                return false;

            _pos += sizeof(DiagnosticSectionFooter);
            return true;
        }

        uint8 const* _pos = nullptr;
        uint8 const* _end = nullptr;
    };

    DiagnosticSectionFooter ReadFooter(std::span<uint8 const> snapshot, std::size_t offset)
    {
        DiagnosticSectionFooter footer;
        std::memcpy(&footer, snapshot.data() + offset, sizeof(footer));

        return footer;
    }
}

DiagnosticReadResult::DiagnosticReadResult(std::optional<RingBuffer>&& records, std::vector<DiagnosticEvent>&& recoveredEvents) :
    events(std::move(recoveredEvents)),
    _ownedRecords(std::move(records))
{
}

DiagnosticReader::DiagnosticReader(std::span<uint8 const> records) noexcept :
    _records(records)
{
}

DiagnosticReader::DiagnosticReader(RingBuffer&& records) noexcept :
    _ownedRecords(std::move(records))
{
    _records = _ownedRecords->ReadSpan();
}

DiagnosticReader::DiagnosticReader(DiagnosticReader&& other) noexcept :
    _ownedRecords(std::move(other._ownedRecords))
{
    _records = _ownedRecords ? _ownedRecords->ReadSpan() : other._records;
    other._records = {};
}

DiagnosticReader& DiagnosticReader::operator=(DiagnosticReader&& other) noexcept
{
    if (this != &other)
    {
        _ownedRecords = std::move(other._ownedRecords);
        _records = _ownedRecords ? _ownedRecords->ReadSpan() : other._records;
        other._records = {};
    }

    return *this;
}

DiagnosticReadResult DiagnosticReader::ReadEvents()
{
    DiagnosticReadResult result(std::move(_ownedRecords), RecoverRecords(_records));
    _records = {};

    return result;
}

std::vector<DiagnosticEvent> RecoverRecords(std::span<uint8 const> snapshot)
{
    std::vector<DiagnosticEvent> events;
    std::size_t cursor = snapshot.size();

    while (cursor >= sizeof(DiagnosticSectionFooter))
    {
        DiagnosticSectionFooter const footer = ReadFooter(snapshot, cursor - sizeof(DiagnosticSectionFooter));
        if (!footer)
            break;
        if (footer < sizeof(DiagnosticSectionFooter))
            break;
        if (footer > static_cast<uint64>(cursor))
            break;
        if (footer > std::numeric_limits<std::size_t>::max())
            break;

        std::size_t const length = static_cast<std::size_t>(footer);
        std::size_t const begin = cursor - length;
        std::size_t const payloadLength = length - sizeof(DiagnosticSectionFooter);

        Decoder decoder(snapshot.subspan(begin, payloadLength));
        std::optional<DiagnosticEvent> event = decoder.ReadRootEvent();
        if (!event)
            break;

        events.push_back(std::move(*event));
        cursor = begin;
    }

    std::reverse(events.begin(), events.end());

    return events;
}
