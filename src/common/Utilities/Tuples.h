/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef Tuples_h__
#define Tuples_h__

#include <tuple>

namespace Acore
{
    template <typename T, typename Tuple>
    struct has_type;

    template <typename T, typename... Us>
    struct has_type<T, std::tuple<Us...>> : std::disjunction<std::is_same<T, Us>...>
    {
    };

    template <typename T, typename... Us>
    constexpr bool has_type_v = has_type<T, Us...>::value;

    template<typename>
    struct is_tuple : std::false_type
    {
    };

    template<typename... Ts>
    struct is_tuple<std::tuple<Ts...>> : std::true_type
    {
    };

    template<typename... Ts>
    constexpr bool is_tuple_v = is_tuple<Ts...>::value;

    namespace Impl
    {
        template <class T, class Tuple, size_t... I>
        T* new_from_tuple(Tuple&& args, std::index_sequence<I...>)
        {
            return new T(std::get<I>(std::forward<Tuple>(args))...);
        }
    }

    template<class T, class Tuple>
    [[nodiscard]] T* new_from_tuple(Tuple&& args)
    {
        return Impl::new_from_tuple<T>(std::forward<Tuple>(args), std::make_index_sequence<std::tuple_size_v<std::remove_reference_t<Tuple>>>{});
    }
}

#endif // Tuples_h__
