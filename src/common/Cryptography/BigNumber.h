/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _AUTH_BIGNUMBER_H
#define _AUTH_BIGNUMBER_H

#include "Define.h"
#include "Errors.h"
#include <array>
#include <memory>
#include <string>

struct bignum_st;

class BigNumber
{
public:
    BigNumber();
    BigNumber(BigNumber const& bn);
    BigNumber(uint32);
    ~BigNumber();

    void SetDword(uint32);
    void SetQword(uint64);
    void SetBinary(uint8 const* bytes, int32 len);
    void SetHexStr(char const* str);

    void SetRand(int32 numbits);

    BigNumber& operator=(BigNumber const& bn);

    BigNumber operator+=(BigNumber const& bn);
    BigNumber operator+(BigNumber const& bn)
    {
        BigNumber t(*this);
        return t += bn;
    }

    BigNumber operator-=(BigNumber const& bn);
    BigNumber operator-(BigNumber const& bn)
    {
        BigNumber t(*this);
        return t -= bn;
    }

    BigNumber operator*=(BigNumber const& bn);
    BigNumber operator*(BigNumber const& bn)
    {
        BigNumber t(*this);
        return t *= bn;
    }

    BigNumber operator/=(BigNumber const& bn);
    BigNumber operator/(BigNumber const& bn)
    {
        BigNumber t(*this);
        return t /= bn;
    }

    BigNumber operator%=(BigNumber const& bn);
    BigNumber operator%(BigNumber const& bn)
    {
        BigNumber t(*this);
        return t %= bn;
    }

    [[nodiscard]] bool isZero() const;

    BigNumber ModExp(BigNumber const& bn1, BigNumber const& bn2);
    BigNumber Exp(BigNumber const&);

    int32 GetNumBytes();

    struct bignum_st* BN() { return _bn; }

    uint32 AsDword();

    std::unique_ptr<uint8[]> AsByteArray(int32 minSize = 0, bool littleEndian = true);

    [[nodiscard]] char* AsHexStr() const;
    [[nodiscard]] char* AsDecStr() const;

private:
    struct bignum_st* _bn;
};
#endif
