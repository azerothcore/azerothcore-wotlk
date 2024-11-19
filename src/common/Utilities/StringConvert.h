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

#ifndef _ACORE_STRINGCONVERT_H_
#define _ACORE_STRINGCONVERT_H_

#include "Define.h"
#include "Errors.h"
#include "Optional.h"
#include "Types.h"
#include "Util.h"
#include <charconv>
#include <string>
#include <string_view>
#include <type_traits>

namespace Acore::Impl::StringConvertImpl
{
    template <typename T, typename = void> struct For
    {
        static_assert(Acore::dependant_false_v<T>, "Unsupported type used for ToString or StringTo");
    };

    template <typename T>
    struct For<T, std::enable_if_t<std::is_integral_v<T> && !std::is_same_v<T, bool>>>
    {
        static Optional<T> FromString(std::string_view str, int base = 10)
        {
            if (base == 0)
            {
                if (StringEqualI(str.substr(0, 2), "0x"))
                {
                    base = 16;
                    str.remove_prefix(2);
                }
                else if (StringEqualI(str.substr(0, 2), "0b"))
                {
                    base = 2;
                    str.remove_prefix(2);
                }
                else
                {
                    base = 10;
                }

                if (str.empty())
                {
                    return std::nullopt;
                }
            }

            char const* const start = str.data();
            char const* const end = (start + str.length());

            T val;
            std::from_chars_result const res = std::from_chars(start, end, val, base);
            if ((res.ptr == end) && (res.ec == std::errc()))
            {
                return val;
            }
            else
            {
                return std::nullopt;
            }
        }

        static std::string ToString(T val)
        {
            std::string buf(20, '\0'); /* 2^64 is 20 decimal characters, -(2^63) is 20 including the sign */
            char* const start = buf.data();
            char* const end = (start + buf.length());
            std::to_chars_result const res = std::to_chars(start, end, val);
            ASSERT(res.ec == std::errc());
            buf.resize(res.ptr - start);
            return buf;
        }
    };

    template <>
    struct For<bool, void>
    {
        static Optional<bool> FromString(std::string_view str, int strict = 0) /* this is int to match the signature for "proper" integral types */
        {
            if (strict)
            {
                if (str == "1")
                {
                    return true;
                }
                if (str == "0")
                {
                    return false;
                }
                return std::nullopt;
            }
            else
            {
                if ((str == "1") || StringEqualI(str, "y") || StringEqualI(str, "on") || StringEqualI(str, "yes") || StringEqualI(str, "true"))
                {
                    return true;
                }
                if ((str == "0") || StringEqualI(str, "n") || StringEqualI(str, "off") || StringEqualI(str, "no") || StringEqualI(str, "false"))
                {
                    return false;
                }
                return std::nullopt;
            }
        }

        static std::string ToString(bool val)
        {
            return (val ? "1" : "0");
        }
    };

#if AC_COMPILER == AC_COMPILER_MICROSOFT
    template <typename T>
    struct For<T, std::enable_if_t<std::is_floating_point_v<T>>>
    {
        static Optional<T> FromString(std::string_view str, std::chars_format fmt = std::chars_format())
        {
            if (str.empty())
            {
                return std::nullopt;
            }

            if (fmt == std::chars_format())
            {
                if (StringEqualI(str.substr(0, 2), "0x"))
                {
                    fmt = std::chars_format::hex;
                    str.remove_prefix(2);
                }
                else
                {
                    fmt = std::chars_format::general;
                }

                if (str.empty())
                {
                    return std::nullopt;
                }
            }

            char const* const start = str.data();
            char const* const end = (start + str.length());

            T val;
            std::from_chars_result const res = std::from_chars(start, end, val, fmt);
            if ((res.ptr == end) && (res.ec == std::errc()))
            {
                return val;
            }
            else
            {
                return std::nullopt;
            }
        }

        // this allows generic converters for all numeric types (easier templating!)
        static Optional<T> FromString(std::string_view str, int base)
        {
            if (base == 16)
            {
                return FromString(str, std::chars_format::hex);
            }
            else if (base == 10)
            {
                return FromString(str, std::chars_format::general);
            }
            else
            {
                return FromString(str, std::chars_format());
            }
        }

        static std::string ToString(T val)
        {
            return std::to_string(val);
        }
    };
#else
   /// @todo replace this once libc++ supports double args to from_chars
    template <typename T>
    struct For<T, std::enable_if_t<std::is_floating_point_v<T>>>
    {
        static Optional<T> FromString(std::string_view str, int base = 0)
        {
            try
            {
                if (str.empty())
                {
                    return std::nullopt;
                }

                if ((base == 10) && StringEqualI(str.substr(0, 2), "0x"))
                {
                    return std::nullopt;
                }

                std::string tmp;
                if (base == 16)
                {
                    tmp.append("0x");
                }
                tmp.append(str);

                std::size_t n;
                T val = static_cast<T>(std::stold(tmp, &n));
                if (n != tmp.length())
                {
                    return std::nullopt;
                }
                return val;
            }
            catch (...) { return std::nullopt; }
        }

        static std::string ToString(T val)
        {
            return std::to_string(val);
        }
    };
#endif
}

namespace Acore
{
    template <typename Result, typename... Params>
    Optional<Result> StringTo(std::string_view str, Params&&... params)
    {
        return Acore::Impl::StringConvertImpl::For<Result>::FromString(str, std::forward<Params>(params)...);
    }

    template <typename Type, typename... Params>
    std::string ToString(Type&& val, Params&&... params)
    {
        return Acore::Impl::StringConvertImpl::For<std::decay_t<Type>>::ToString(std::forward<Type>(val), std::forward<Params>(params)...);
    }
}

#endif // _ACORE_STRINGCONVERT_H_
