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

#ifndef ACORE_RING_BUFFER_H
#define ACORE_RING_BUFFER_H

#include "Define.h"
#include <cstddef>
#include <span>

class AC_COMMON_API RingBuffer
{
public:
    /**
     * @brief Create a ring buffer having a circular memory window of at least
     *        the specified @p desiredSize bytes.
     *
     * @param desiredSize The desired size, in bytes, of the circular memory
     *                    window.
     *
     * The behavior is undefined unless @p desiredSize is non-zero and the
     * platform-aligned mapping size can be doubled without overflowing
     * `std::size_t`.
     */
    explicit RingBuffer(std::size_t desiredSize);

    /**
     * @brief Destroy this object.
     */
    ~RingBuffer();

    /**
     * @brief Create a ring buffer having the mapping held by the specified
     *        @p other object, and leave @p other empty.
     *
     * @param other The object to move from.
     */
    RingBuffer(RingBuffer&& other) noexcept;

    /**
     * @brief Assign to this object the mapping held by the specified @p other
     *        object, and leave @p other empty.
     *
     * @param other The object to move from.
     * @return A reference providing modifiable access to this object.
     */
    RingBuffer& operator=(RingBuffer&& other) noexcept;

    RingBuffer(RingBuffer const&) = delete;
    RingBuffer& operator=(RingBuffer const&) = delete;

    /**
     * @brief Return a writable span beginning at the current position in this
     *        buffer.
     *
     * @return A writable span over the circular memory window.
     *
     * The behavior is undefined unless this object contains a mapping.
     */
    [[nodiscard]] std::span<uint8> WriteSpan();

    /**
     * @brief Return a non-modifiable span beginning at the current position in
     *        this buffer.
     *
     * @return A non-modifiable span over the circular memory window.
     *
     * The behavior is undefined unless this object contains a mapping.
     */
    [[nodiscard]] std::span<uint8 const> ReadSpan() const;

    /**
     * @brief Return the logical current position of this buffer.
     *
     * @return The logical current position of this buffer.
     *
     * The behavior is undefined unless this object contains a mapping.
     */
    [[nodiscard]] std::size_t Position() const;

    /**
     * @brief Advance the current position by the specified @p bytes.
     *
     * @param bytes The number of bytes by which to advance the current
     *              position.
     *
     * The behavior is undefined unless this object contains a mapping and
     * @p bytes is no greater than `WriteSpan().size()`.
     */
    void Advance(std::size_t bytes);

private:
    void Release() noexcept;
    static std::size_t AlignUp(std::size_t value, std::size_t alignment);

    uint8* _base = nullptr;
    std::size_t _mappedSize = 0;
    std::size_t _position = 0;
};

#endif // ACORE_RING_BUFFER_H
