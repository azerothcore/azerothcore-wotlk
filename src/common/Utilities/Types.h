/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
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
