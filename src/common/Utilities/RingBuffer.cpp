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

#include "RingBuffer.h"
#include "Errors.h"

#include <limits>
#include <utility>

RingBuffer::~RingBuffer()
{
    Release();
}

RingBuffer::RingBuffer(RingBuffer&& other) noexcept :
    _base(std::exchange(other._base, nullptr)),
    _mappedSize(std::exchange(other._mappedSize, 0)),
    _position(std::exchange(other._position, 0))
{
}

RingBuffer& RingBuffer::operator=(RingBuffer&& other) noexcept
{
    if (this != &other)
    {
        Release();

        _base = std::exchange(other._base, nullptr);
        _mappedSize = std::exchange(other._mappedSize, 0);
        _position = std::exchange(other._position, 0);
    }

    return *this;
}

std::span<uint8> RingBuffer::WriteSpan()
{
    ASSERT(_base, "RingBuffer::WriteSpan called on an empty buffer");

    return { _base + (_position % _mappedSize), _mappedSize };
}

std::span<uint8 const> RingBuffer::ReadSpan() const
{
    ASSERT(_base, "RingBuffer::ReadSpan called on an empty buffer");

    return { _base + (_position % _mappedSize), _mappedSize };
}

std::size_t RingBuffer::Position() const
{
    ASSERT(_base, "RingBuffer::Position called on an empty buffer");

    return _position;
}

void RingBuffer::Advance(std::size_t bytes)
{
    ASSERT(_base, "RingBuffer::Advance called on an empty buffer");
    ASSERT(_mappedSize, "RingBuffer::Advance called on an unmapped buffer");
    ASSERT(bytes <= _mappedSize, "RingBuffer::Advance({}) exceeds mapped size {}", bytes, _mappedSize);
    ASSERT(_position <= std::numeric_limits<std::size_t>::max() - bytes,
        "RingBuffer position overflow");

    _position += bytes;
}

std::size_t RingBuffer::AlignUp(std::size_t value, std::size_t alignment)
{
    ASSERT(value, "RingBuffer size must be greater than zero");
    ASSERT(alignment, "RingBuffer mapping granularity must be greater than zero");

    std::size_t remainder = value % alignment;
    if (!remainder)
        return value;

    std::size_t adjustment = alignment - remainder;
    ASSERT(value <= std::numeric_limits<std::size_t>::max() - adjustment,
        "RingBuffer size is too large");

    return value + adjustment;
}
