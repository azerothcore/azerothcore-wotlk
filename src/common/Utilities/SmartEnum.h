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

#ifndef TRINITY_SMARTENUM_H
#define TRINITY_SMARTENUM_H

#include "IteratorPair.h"
#include <iterator>

struct EnumText
{
    EnumText(char const* c, char const* t, char const* d) : Constant(c), Title(t), Description(d) { }
    // Enum constant of the value
    char const* const Constant;
    // Human-readable title of the value
    char const* const Title;
    // Human-readable description of the value
    char const* const Description;
};

namespace Acore::Impl::EnumUtilsImpl
{
    template <typename Enum>
    struct EnumUtils
    {
        static size_t Count();
        static EnumText ToString(Enum value);
        static Enum FromIndex(size_t index);
        static size_t ToIndex(Enum index);
    };
}

class EnumUtils
{
public:
    template <typename Enum>
    static auto Count() -> size_t { return Acore::Impl::EnumUtilsImpl::EnumUtils<Enum>::Count(); }
    template <typename Enum>
    static auto ToString(Enum value) -> EnumText { return Acore::Impl::EnumUtilsImpl::EnumUtils<Enum>::ToString(value); }
    template <typename Enum>
    static auto FromIndex(size_t index) -> Enum { return Acore::Impl::EnumUtilsImpl::EnumUtils<Enum>::FromIndex(index); }
    template <typename Enum>
    static auto ToIndex(Enum value) -> uint32 { return Acore::Impl::EnumUtilsImpl::EnumUtils<Enum>::ToIndex(value);}

    template<typename Enum>
    static auto IsValid(Enum value) -> bool
    {
        try
        {
            Acore::Impl::EnumUtilsImpl::EnumUtils<Enum>::ToIndex(value);
            return true;
        }
        catch (...)
        {
            return false;
        }
    }

    template<typename Enum>
    static auto IsValid(std::underlying_type_t<Enum> value) -> bool { return IsValid(static_cast<Enum>(value)); }

    template <typename Enum>
    class Iterator
    {
    public:
        using iterator_category = std::random_access_iterator_tag;
        using value_type = Enum;
        using pointer = Enum*;
        using reference = Enum&;
        using difference_type = std::ptrdiff_t;

        Iterator() : _index(EnumUtils::Count<Enum>()) {}
        explicit Iterator(size_t index) : _index(index) { }

        auto operator==(const Iterator& other) const -> bool { return other._index == _index; }
        auto operator!=(const Iterator& other) const -> bool { return !operator==(other); }
        auto operator-(Iterator const& other) const -> difference_type { return _index - other._index; }
        auto operator<(const Iterator& other) const -> bool { return _index < other._index; }
        auto operator<=(const Iterator& other) const -> bool { return _index <= other._index; }
        auto operator>(const Iterator& other) const -> bool { return _index > other._index; }
        auto operator>=(const Iterator& other) const -> bool { return _index >= other._index; }

        auto operator[](difference_type d) const -> value_type { return FromIndex<Enum>(_index + d); }
        auto operator*() const -> value_type { return operator[](0); }

        auto operator+=(difference_type d) -> Iterator& { _index += d; return *this; }
        auto operator++() -> Iterator& { return operator+=(1); }
        auto operator++(int) -> Iterator { Iterator i = *this; operator++(); return i; }
        auto operator+(difference_type d) const -> Iterator { Iterator i = *this; i += d; return i; }

        auto operator-=(difference_type d) -> Iterator& { _index -= d; return *this; }
        auto operator--() -> Iterator& { return operator-=(1); }
        auto operator--(int) -> Iterator { Iterator i = *this; operator--(); return i; }
        auto operator-(difference_type d) const -> Iterator { Iterator i = *this; i -= d; return i; }

    private:
        difference_type _index;
    };

    template <typename Enum>
    static auto Begin() -> Iterator<Enum> { return Iterator<Enum>(0); }

    template <typename Enum>
    static auto End() -> Iterator<Enum> { return Iterator<Enum>(); }

    template <typename Enum>
    static auto Iterate() -> Acore::IteratorPair<Iterator<Enum>> { return { Begin<Enum>(), End<Enum>() }; }

    template <typename Enum>
    static auto ToConstant(Enum value) -> char const* { return ToString(value).Constant; }

    template <typename Enum>
    static auto ToTitle(Enum value) -> char const* { return ToString(value).Title; }

    template <typename Enum>
    static auto ToDescription(Enum value) -> char const* { return ToString(value).Description; }
};

#endif
