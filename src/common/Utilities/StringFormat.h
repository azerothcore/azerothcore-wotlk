/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _STRING_FORMAT_H_
#define _STRING_FORMAT_H_

#include "Define.h"
#include <fmt/chrono.h>
#include <fmt/format.h>
#include <fmt/printf.h>
#include <locale>

namespace Acore
{
    /// Default AC string format function.
    template<typename Format, typename... Args>
    inline std::string StringFormat(Format&& fmt, Args&& ... args)
    {
        try
        {
            return fmt::sprintf(std::forward<Format>(fmt), std::forward<Args>(args)...);
        }
        catch (const fmt::format_error& formatError)
        {
            std::string error = "An error occurred formatting string \"" + std::string(fmt) + "\" : " + std::string(formatError.what());
            return error;
        }
    }

    template<typename... Args>
    using FormatString = fmt::format_string<Args...>;

    // Default string format function.
    template<typename... Args>
    inline std::string StringFormatFmt(FormatString<Args...> fmt, Args&&... args)
    {
        try
        {
            return fmt::format(fmt, std::forward<Args>(args)...);
        }
        catch (std::exception const& e)
        {
            return fmt::format("Wrong format occurred ({}). Fmt string: '{}'", e.what(), fmt.get());
        }
    }

    /// Returns true if the given char pointer is null.
    inline bool IsFormatEmptyOrNull(char const* fmt)
    {
        return fmt == nullptr;
    }

    /// Returns true if the given std::string is empty.
    inline bool IsFormatEmptyOrNull(std::string_view fmt)
    {
        return fmt.empty();
    }
}

namespace Acore::String
{
    template<class Str>
    AC_COMMON_API Str Trim(const Str& s, const std::locale& loc = std::locale());

    AC_COMMON_API std::string TrimRightInPlace(std::string& str);

    AC_COMMON_API std::string AddSuffixIfNotExists(std::string str, const char suffix);
}

// Add support enum for fmt
//template <typename T, std::enable_if_t<std::is_enum_v<T>, int> = 0>
template <typename T, FMT_ENABLE_IF(std::is_enum_v<T>)>
auto format_as(T f) { return fmt::underlying(f); }

#endif
