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

    bool SetHexStr(char const* str);
    bool SetHexStr(std::string const& str) { return SetHexStr(str.c_str()); }

    void SetRand(int32 numbits);

    BigNumber& operator=(BigNumber const& bn);

    BigNumber& operator+=(BigNumber const& bn);
    BigNumber operator+(BigNumber const& bn) const
    {
        BigNumber t(*this);
        return t += bn;
    }

    BigNumber& operator-=(BigNumber const& bn);
    BigNumber operator-(BigNumber const& bn) const
    {
        BigNumber t(*this);
        return t -= bn;
    }

    BigNumber& operator*=(BigNumber const& bn);
    BigNumber operator*(BigNumber const& bn) const
    {
        BigNumber t(*this);
        return t *= bn;
    }

    BigNumber& operator/=(BigNumber const& bn);
    BigNumber operator/(BigNumber const& bn) const
    {
        BigNumber t(*this);
        return t /= bn;
    }

    BigNumber& operator%=(BigNumber const& bn);
    BigNumber operator%(BigNumber const& bn) const
    {
        BigNumber t(*this);
        return t %= bn;
    }

    BigNumber& operator<<=(int n);
    BigNumber operator<<(int n) const
    {
        BigNumber t(*this);
        return t <<= n;
    }

    [[nodiscard]] int CompareTo(BigNumber const& bn) const;
    bool operator<=(BigNumber const& bn) const { return (CompareTo(bn) <= 0); }
    bool operator==(BigNumber const& bn) const { return (CompareTo(bn) == 0); }
    bool operator>=(BigNumber const& bn) const { return (CompareTo(bn) >= 0); }
    bool operator<(BigNumber const& bn) const { return (CompareTo(bn) < 0); }
    bool operator>(BigNumber const& bn) const { return (CompareTo(bn) > 0); }

    [[nodiscard]] bool IsZero() const;
    [[nodiscard]] bool IsNegative() const;

    [[nodiscard]] BigNumber ModExp(BigNumber const& bn1, BigNumber const& bn2) const;
    [[nodiscard]] BigNumber Exp(BigNumber const&) const;

    [[nodiscard]] int32 GetNumBytes() const;

    struct bignum_st* BN() { return _bn; }
    [[nodiscard]] struct bignum_st const* BN() const { return _bn; }

    [[nodiscard]] uint32 AsDword() const;

    void GetBytes(uint8* buf, size_t bufsize, bool littleEndian = true) const;
    [[nodiscard]] std::vector<uint8> ToByteVector(int32 minSize = 0, bool littleEndian = true) const;

    template <std::size_t Size>
    std::array<uint8, Size> ToByteArray(bool littleEndian = true) const
    {
        std::array<uint8, Size> buf;
        GetBytes(buf.data(), Size, littleEndian);
        return buf;
    }

    [[nodiscard]] std::string AsHexStr() const;
    [[nodiscard]] std::string AsDecStr() const;

private:
    struct bignum_st* _bn;

};
#endif
