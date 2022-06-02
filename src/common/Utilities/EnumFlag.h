/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef EnumFlag_h__
#define EnumFlag_h__

#include <type_traits>

template<typename T>
constexpr bool IsEnumFlag(T) { return false; }

#define DEFINE_ENUM_FLAG(enumType) constexpr bool IsEnumFlag(enumType) { return true; }

namespace EnumTraits
{
    template<typename T>
    using IsFlag = std::integral_constant<bool, IsEnumFlag(T{})>;
}

template<typename T, std::enable_if_t<EnumTraits::IsFlag<T>::value, std::nullptr_t> = nullptr>
inline constexpr T operator&(T left, T right)
{
    return static_cast<T>(static_cast<std::underlying_type_t<T>>(left) & static_cast<std::underlying_type_t<T>>(right));
}

template<typename T, std::enable_if_t<EnumTraits::IsFlag<T>::value, std::nullptr_t> = nullptr>
inline constexpr T& operator&=(T& left, T right)
{
    return left = left & right;
}

template<typename T, std::enable_if_t<EnumTraits::IsFlag<T>::value, std::nullptr_t> = nullptr>
inline constexpr T operator|(T left, T right)
{
    return static_cast<T>(static_cast<std::underlying_type_t<T>>(left) | static_cast<std::underlying_type_t<T>>(right));
}

template<typename T, std::enable_if_t<EnumTraits::IsFlag<T>::value, std::nullptr_t> = nullptr>
inline constexpr T& operator|=(T& left, T right)
{
    return left = left | right;
}

template<typename T, std::enable_if_t<EnumTraits::IsFlag<T>::value, std::nullptr_t> = nullptr>
inline constexpr T operator~(T value)
{
    return static_cast<T>(~static_cast<std::underlying_type_t<T>>(value));
}

template<typename T>
class EnumFlag
{
    static_assert(EnumTraits::IsFlag<T>::value, "EnumFlag must be used only with enums that are specify EnumFlag::IsFlag");

public:
    /*implicit*/ constexpr EnumFlag(T value) : _value(value)
    {
    }

    constexpr EnumFlag& operator&=(EnumFlag right)
    {
        _value &= right._value;
        return *this;
    }

    constexpr friend EnumFlag operator&(EnumFlag left, EnumFlag right)
    {
        return left &= right;
    }

    constexpr EnumFlag& operator|=(EnumFlag right)
    {
        _value |= right._value;
        return *this;
    }

    constexpr friend EnumFlag operator|(EnumFlag left, EnumFlag right)
    {
        return left |= right;
    }

    constexpr EnumFlag operator~() const
    {
        return static_cast<T>(~static_cast<std::underlying_type_t<T>>(_value));
    }

    constexpr void RemoveFlag(EnumFlag flag)
    {
        _value &= ~flag._value;
    }

    constexpr bool HasFlag(T flag) const
    {
        using i = std::underlying_type_t<T>;
        return static_cast<i>(_value & flag) != static_cast<i>(0);
    }

    constexpr bool HasAllFlags(T flags) const
    {
        return (_value & flags) == flags;
    }

    constexpr operator T() const
    {
        return _value;
    }

    constexpr std::underlying_type_t<T> AsUnderlyingType() const
    {
        return static_cast<std::underlying_type_t<T>>(_value);
    }

private:
    T _value;
};

#endif // EnumFlag_h__
