/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2021+  WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _AUTH_BIGNUMBER_H
#define _AUTH_BIGNUMBER_H

#include "Define.h"
#include <array>
#include <memory>
#include <string>
#include <vector>

struct bignum_st;

class AC_COMMON_API BigNumber
{
public:
    BigNumber();
    BigNumber(BigNumber const& bn);
    BigNumber(uint32 v) : BigNumber() { SetDword(v); }
    BigNumber(int32 v) : BigNumber() { SetDword(v); }
    BigNumber(std::string const& v) : BigNumber() { SetHexStr(v); }

    template <size_t Size>
    BigNumber(std::array<uint8, Size> const& v, bool littleEndian = true) : BigNumber() { SetBinary(v.data(), Size, littleEndian); }

    ~BigNumber();

    void SetDword(int32);
    void SetDword(uint32);
    void SetQword(uint64);
    void SetBinary(uint8 const* bytes, int32 len, bool littleEndian = true);

    template <typename Container>
    auto SetBinary(Container const& c, bool littleEndian = true) -> std::enable_if_t<!std::is_pointer_v<std::decay_t<Container>>> { SetBinary(std::data(c), std::size(c), littleEndian); }

    auto SetHexStr(char const* str) -> bool;
    auto SetHexStr(std::string const& str) -> bool { return SetHexStr(str.c_str()); }

    void SetRand(int32 numbits);

    auto operator=(BigNumber const& bn) -> BigNumber&;

    auto operator+=(BigNumber const& bn) -> BigNumber&;
    auto operator+(BigNumber const& bn) const -> BigNumber
    {
        BigNumber t(*this);
        return t += bn;
    }

    auto operator-=(BigNumber const& bn) -> BigNumber&;
    auto operator-(BigNumber const& bn) const -> BigNumber
    {
        BigNumber t(*this);
        return t -= bn;
    }

    auto operator*=(BigNumber const& bn) -> BigNumber&;
    auto operator*(BigNumber const& bn) const -> BigNumber
    {
        BigNumber t(*this);
        return t *= bn;
    }

    auto operator/=(BigNumber const& bn) -> BigNumber&;
    auto operator/(BigNumber const& bn) const -> BigNumber
    {
        BigNumber t(*this);
        return t /= bn;
    }

    auto operator%=(BigNumber const& bn) -> BigNumber&;
    auto operator%(BigNumber const& bn) const -> BigNumber
    {
        BigNumber t(*this);
        return t %= bn;
    }

    auto operator<<=(int n) -> BigNumber&;
    auto operator<<(int n) const -> BigNumber
    {
        BigNumber t(*this);
        return t <<= n;
    }

    [[nodiscard]] auto CompareTo(BigNumber const& bn) const -> int;
    auto operator<=(BigNumber const& bn) const -> bool { return (CompareTo(bn) <= 0); }
    auto operator==(BigNumber const& bn) const -> bool { return (CompareTo(bn) == 0); }
    auto operator>=(BigNumber const& bn) const -> bool { return (CompareTo(bn) >= 0); }
    auto operator<(BigNumber const& bn) const -> bool { return (CompareTo(bn) < 0); }
    auto operator>(BigNumber const& bn) const -> bool { return (CompareTo(bn) > 0); }

    [[nodiscard]] auto IsZero() const -> bool;
    [[nodiscard]] auto IsNegative() const -> bool;

    [[nodiscard]] auto ModExp(BigNumber const& bn1, BigNumber const& bn2) const -> BigNumber;
    [[nodiscard]] auto Exp(BigNumber const&) const -> BigNumber;

    [[nodiscard]] auto GetNumBytes() const -> int32;

    auto BN() -> struct bignum_st* { return _bn; }
    [[nodiscard]] auto BN() const -> struct bignum_st const* { return _bn; }

    [[nodiscard]] auto AsDword() const -> uint32;

    void GetBytes(uint8* buf, size_t bufsize, bool littleEndian = true) const;
    [[nodiscard]] auto ToByteVector(int32 minSize = 0, bool littleEndian = true) const -> std::vector<uint8>;

    template <std::size_t Size>
    auto ToByteArray(bool littleEndian = true) const -> std::array<uint8, Size>
    {
        std::array<uint8, Size> buf;
        GetBytes(buf.data(), Size, littleEndian);
        return buf;
    }

    [[nodiscard]] auto AsHexStr() const -> std::string;
    [[nodiscard]] auto AsDecStr() const -> std::string;

private:
    struct bignum_st* _bn;

};
#endif
