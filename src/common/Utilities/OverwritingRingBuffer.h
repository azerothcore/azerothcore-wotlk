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

#include <algorithm>
#include <cstddef>
#include <memory>
#include <new>
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
    explicit OverwritingRingBuffer(std::size_t capacity)
    {
        ASSERT(capacity, "OverwritingRingBuffer capacity must be greater than zero");
        _storage = std::make_unique_for_overwrite<SlotStorage[]>(capacity);
        _capacity = capacity;
    }

    std::size_t Size() const noexcept { return _size; }

    template <typename... Args>
    void Emplace(Args&&... args)
    {
        if (_size < _capacity)
            ++_size;

        // Construct directly on the raw storage: laundering before an object
        // lives in the slot would be undefined on the first lap.
        std::construct_at(reinterpret_cast<T*>(_storage[_head].bytes), std::forward<Args>(args)...);

        _head = (_head + 1) % _capacity;
    }

    [[nodiscard]] std::vector<T> Snapshot() const
    {
        std::vector<T> snapshot;
        snapshot.reserve(_size);

        std::size_t const first = _size == _capacity ? _head : 0;
        std::size_t const contiguousCount = std::min(_size, _capacity - first);
        if (contiguousCount)
            snapshot.insert(snapshot.end(), Slot(first), Slot(first) + contiguousCount);

        std::size_t const wrappedCount = _size - contiguousCount;
        if (wrappedCount)
            snapshot.insert(snapshot.end(), Slot(0), Slot(0) + wrappedCount);

        return snapshot;
    }

private:
    struct SlotStorage
    {
        alignas(T) std::byte bytes[sizeof(T)];
    };

    [[nodiscard]] T const* Slot(std::size_t index) const noexcept
    {
        return std::launder(reinterpret_cast<T const*>(_storage[index].bytes));
    }

    std::unique_ptr<SlotStorage[]> _storage;
    std::size_t _capacity = 0;
    std::size_t _head = 0;
    std::size_t _size = 0;
};

#endif // ACORE_OVERWRITING_RING_BUFFER_H
