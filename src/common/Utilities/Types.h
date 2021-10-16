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

#ifndef _TYPES_H_
#define _TYPES_H_

#include "advstd.h"

namespace Acore
{
    // end "iterator" tag for find_type_if
    struct find_type_end;

    template<template<typename...> typename Check, typename... Ts>
    struct find_type_if;

    template<template<typename...> typename Check>
    struct find_type_if<Check>
    {
        using type = find_type_end;
    };

    template<template<typename...> typename Check, typename T1, typename... Ts>
    struct find_type_if<Check, T1, Ts...> : std::conditional_t<Check<T1>::value, advstd::type_identity<T1>, find_type_if<Check, Ts...>>
    {
    };

    /*
        Utility to find a type matching predicate (Check) in a given type list (Ts)
        Evaluates to first type matching predicate or find_type_end
        Check must be a type that contains static bool ::value, _v aliases don't work

        template<typename... Ts>
        struct Example
        {
            using TupleArg = Acore::find_type_if_t<Acore::is_tuple, Ts...>;

            bool HasTuple()
            {
                return !std::is_same_v<TupleArg, Acore::find_type_end>;
            }
        };

        Example<int, std::string, std::tuple<int, int, int>, char> example;
        example.HasTuple() == true; // TupleArg is std::tuple<int, int, int>

        Example<int, std::string, char> example2;
        example2.HasTuple() == false; // TupleArg is Acore::find_type_end
    */

    template<template<typename...> typename Check, typename... Ts>
    using find_type_if_t = typename find_type_if<Check, Ts...>::type;

    template <typename T>
    struct dependant_false { static constexpr bool value = false; };

    template <typename T>
    constexpr bool dependant_false_v = dependant_false<T>::value;
}

#endif // _TYPES_H_
