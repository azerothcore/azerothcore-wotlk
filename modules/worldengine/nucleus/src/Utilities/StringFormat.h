/*
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef __STRING_FORMAT_H__
#define __STRING_FORMAT_H__

#include <memory>
#include <iostream>
#include <string>
#include <cstdio>

namespace Trinity
{
    /// Default TC string format function.
    template<typename... Args>
    inline std::string StringFormat(const std::string& format, Args const&... args)
    {
        size_t size = std::snprintf(nullptr, 0, format.c_str(), args ...) + 1; // Extra space for '\0'
        unique_ptr<char[]> buf(new char[size]);
        std::snprintf(buf.get(), size, format.c_str(), args ...);
        return std::string(buf.get(), buf.get() + size - 1); // We don
    }

    /// Returns true if the given char pointer is null.
    inline bool IsFormatEmptyOrNull(const char* fmt)
    {
        return fmt == nullptr;
    }

    /// Returns true if the given std::string is empty.
    inline bool IsFormatEmptyOrNull(std::string const& fmt)
    {
        return fmt.empty();
    }
}

#endif
