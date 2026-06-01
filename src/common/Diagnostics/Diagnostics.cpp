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

#include "Diagnostics.h"
#include "Errors.h"

#include <cstring>
#include <functional>

/*static*/ Diagnostics* Diagnostics::instance()
{
    static Diagnostics instance;
    return &instance;
}

DiagnosticWriter Diagnostics::GetWriter(std::string_view name)
{
    std::lock_guard<std::mutex> guard(_buffersLock);

    return DiagnosticWriter(GetOrCreate(name));
}

DiagnosticReader Diagnostics::GetReader(std::string_view name, bool clone)
{
    std::lock_guard<std::mutex> guard(_buffersLock);
    RingBuffer& buffer = GetOrCreate(name);

    if (clone)
        return DiagnosticReader(Clone(buffer));

    return DiagnosticReader(buffer.ReadSpan());
}

std::size_t Diagnostics::TransparentStringHash::operator()(std::string_view value) const noexcept
{
    return std::hash<std::string_view>{}(value);
}

std::size_t Diagnostics::TransparentStringHash::operator()(std::string const& value) const noexcept
{
    return (*this)(std::string_view(value));
}

std::size_t Diagnostics::TransparentStringHash::operator()(char const* value) const noexcept
{
    return (*this)(std::string_view(value));
}

RingBuffer& Diagnostics::GetOrCreate(std::string_view name)
{
    ASSERT(!name.empty(), "Diagnostics buffer name must not be empty");

    if (auto itr = _buffers.find(name); itr != _buffers.end())
        return itr->second;

    return _buffers.try_emplace(std::string(name), DefaultBufferSize).first->second;
}

RingBuffer Diagnostics::Clone(RingBuffer const& buffer)
{
    std::span<uint8 const> source = buffer.ReadSpan();
    RingBuffer clone(source.size());

    std::memcpy(clone.WriteSpan().data(), source.data(), source.size());

    return clone;
}
