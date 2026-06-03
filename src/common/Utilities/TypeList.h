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

#ifndef TypeList_h__
#define TypeList_h__

#include <cstddef>
#include <utility>

namespace Acore
{
    /**
     * @brief Provide an empty tag type containing the specified @p Ts.
     *
     * @tparam Ts The types in this list.
     */
    template <typename... Ts>
    struct type_list { };

    namespace Impl
    {
        template <typename T>
        inline constexpr bool is_type_list = false;

        template <typename... Ts>
        inline constexpr bool is_type_list<type_list<Ts...>> = true;

        template <typename List>
        struct list_size;

        template <typename... Ts>
        struct list_size<type_list<Ts...>>
        {
            static constexpr std::size_t value = sizeof...(Ts);
        };

        template <typename... Ts, typename Func>
        constexpr void for_each(type_list<Ts...>, Func&& f)
        {
            (f.template operator()<Ts>(), ...);
        }

        template <typename... Ts, typename Pred>
        constexpr std::size_t count_if(type_list<Ts...>, Pred pred)
        {
            return ((pred.template operator()<Ts>() ? std::size_t{1} : std::size_t{0}) + ... + std::size_t{0});
        }

        template <typename... Ts, typename Pred>
        constexpr bool any_of(type_list<Ts...>, Pred pred)
        {
            return (false || ... || pred.template operator()<Ts>());
        }
    }

    /**
     * @brief Satisfied only by Acore::type_list specializations.
     *
     * Constrains the public list operations so they are viable only for an
     * actual type_list.
     */
    template <typename T>
    concept AnyTypeList = Impl::is_type_list<T>;

    /**
     * @brief The number of types in the specified @p List.
     *
     * @tparam List A type_list specialization.
     */
    template <AnyTypeList List>
    inline constexpr std::size_t size_v = Impl::list_size<List>::value;

    /**
     * @brief Invoke the specified @p f once for each type in the specified
     *        @p List, in declaration order.
     *
     * @tparam List A type_list specialization.
     * @tparam Func The type of the callable.
     * @param  f    The callable to invoke.
     */
    template <AnyTypeList List, typename Func>
    constexpr void for_each(Func&& f)
    {
        Impl::for_each(List{}, std::forward<Func>(f));
    }

    /**
     * @brief Return the number of types in the specified @p List for which the
     *        specified @p pred returns true.
     *
     * @tparam List A type_list specialization.
     * @tparam Pred The type of the predicate.
     * @param  pred The predicate to evaluate.
     * @return The number of matching types.
     */
    template <AnyTypeList List, typename Pred>
    constexpr std::size_t count_if(Pred pred)
    {
        return Impl::count_if(List{}, pred);
    }

    /**
     * @brief Return true if the specified @p pred returns true for any type in
     *        the specified @p List, and false otherwise.
     *
     * @tparam List A type_list specialization.
     * @tparam Pred The type of the predicate.
     * @param  pred The predicate to evaluate.
     * @return True if any type matches, and false otherwise.
     */
    template <AnyTypeList List, typename Pred>
    constexpr bool any_of(Pred pred)
    {
        return Impl::any_of(List{}, pred);
    }
}

#endif // TypeList_h__
