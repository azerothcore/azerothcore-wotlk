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

#ifndef ACORE_OVERWRITING_RING_BUFFER_H
#define ACORE_OVERWRITING_RING_BUFFER_H

#include "Errors.h"

#include <cstddef>
#include <limits>
#include <type_traits>
#include <utility>
#include <vector>

template <typename T>
class OverwritingRingBuffer
{
    static_assert(std::is_trivially_destructible_v<T>,
        "OverwritingRingBuffer overwrites slots without running element cleanup");
    static_assert(std::is_trivially_copyable_v<T>,
        "OverwritingRingBuffer snapshots and overwrites slots by value");

public:
    explicit OverwritingRingBuffer(std::size_t capacity) :
        _storage(capacity)
    {
        ASSERT(capacity, "OverwritingRingBuffer capacity must be greater than zero");
    }

    [[nodiscard]] std::size_t Capacity() const noexcept { return _storage.size(); }
    [[nodiscard]] std::size_t Size() const noexcept { return _size; }
    [[nodiscard]] std::size_t Position() const noexcept { return _position; }
    [[nodiscard]] bool Empty() const noexcept { return !_size; }

    void Push(T const& value) noexcept
    {
        ASSERT(!_storage.empty(), "OverwritingRingBuffer::Push called on an empty buffer");
        ASSERT(_position != (std::numeric_limits<std::size_t>::max)(), "OverwritingRingBuffer position overflow");

        _storage[_head] = value;
        _head = (_head + 1) % _storage.size();

        if (_size < _storage.size())
            ++_size;

        ++_position;
    }

    template <typename... Args>
    void Emplace(Args&&... args) noexcept
    {
        Push(T(std::forward<Args>(args)...));
    }

    [[nodiscard]] std::vector<T> Snapshot() const
    {
        std::vector<T> snapshot;
        snapshot.reserve(_size);

        std::size_t const first = _size == _storage.size() ? _head : 0;
        for (std::size_t i = 0; i < _size; ++i)
            snapshot.push_back(_storage[(first + i) % _storage.size()]);

        return snapshot;
    }

private:
    std::vector<T> _storage;
    std::size_t _head = 0;
    std::size_t _size = 0;
    std::size_t _position = 0;
};

#endif // ACORE_OVERWRITING_RING_BUFFER_H
