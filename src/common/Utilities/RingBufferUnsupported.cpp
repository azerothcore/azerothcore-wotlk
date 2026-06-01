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

#include "CompilerDefs.h"

#if AC_PLATFORM != AC_PLATFORM_WINDOWS && !(AC_PLATFORM == AC_PLATFORM_UNIX && defined(__linux__))

#include "RingBuffer.h"

#include <system_error>

RingBuffer::RingBuffer(std::size_t /*desiredSize*/)
{
    throw std::system_error(std::make_error_code(std::errc::function_not_supported),
        "RingBuffer is only implemented on Linux and Windows");
}

void RingBuffer::Release() noexcept
{
    _base = nullptr;
    _mappedSize = 0;
    _position = 0;
}

#endif
