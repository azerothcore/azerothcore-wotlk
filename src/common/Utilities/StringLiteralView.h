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

#ifndef ACORE_STRING_LITERAL_VIEW_H
#define ACORE_STRING_LITERAL_VIEW_H

#include <cstddef>
#include <string_view>

/**
 * @brief Provide a non-owning view of a string literal.
 */
class StringLiteralView
{
public:
    /**
     * @brief Create an object referring to the specified @p literal.
     *
     * @tparam Size The size, in bytes, of the specified @p literal, including
     *              its null terminator.
     * @param literal The string literal to view.
     */
    template <std::size_t Size>
    consteval StringLiteralView(char const (&literal)[Size]) noexcept :
        _view{literal}
    {
    }

    constexpr StringLiteralView(StringLiteralView const&) noexcept = default;
    constexpr StringLiteralView& operator=(StringLiteralView const&) noexcept = default;
    constexpr StringLiteralView(StringLiteralView&&) noexcept = default;
    constexpr StringLiteralView& operator=(StringLiteralView&&) noexcept = default;

    /**
     * @brief Return the address of the first character in this view.
     *
     * @return The address of the first character in this view.
     */
    constexpr char const* data() const noexcept { return _view.data(); }

    /**
     * @brief Return the number of characters in this view.
     *
     * @return The number of characters in this view.
     */
    constexpr std::size_t size() const noexcept { return _view.size(); }

    /**
     * @brief Return whether this view is empty.
     *
     * @return `true` if this view is empty, and `false` otherwise.
     */
    constexpr bool empty() const noexcept { return _view.empty(); }

    /**
     * @brief Return this object as a string view.
     *
     * @return A string view referring to the same string literal as this
     *         object.
     */
    constexpr operator std::string_view() const noexcept { return _view; }

private:
    std::string_view _view;
};

#endif // ACORE_STRING_LITERAL_VIEW_H
