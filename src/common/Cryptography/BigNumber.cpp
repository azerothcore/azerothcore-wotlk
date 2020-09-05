/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include <ace/Guard_T.h>

#include "Cryptography/BigNumber.h"
#include <openssl/bn.h>
#include <openssl/crypto.h>
#include <algorithm>

BigNumber::BigNumber()
    : _bn(BN_new())
{ }

BigNumber::BigNumber(BigNumber const& bn)
    : _bn(BN_dup(bn._bn))
{ }

BigNumber::BigNumber(uint32 val)
    : _bn(BN_new())
{
    BN_set_word(_bn, val);
}

BigNumber::~BigNumber()
{
    BN_free(_bn);
}

void BigNumber::SetDword(uint32 val)
{
    BN_set_word(_bn, val);
}

void BigNumber::SetQword(uint64 val)
{
    BN_set_word(_bn, (uint32)(val >> 32));
    BN_lshift(_bn, _bn, 32);
    BN_add_word(_bn, (uint32)(val & 0xFFFFFFFF));
}

void BigNumber::SetBinary(uint8 const* bytes, int32 len)
{
    uint8* array = new uint8[len];

    for (int i = 0; i < len; i++)
        array[i] = bytes[len - 1 - i];

    BN_bin2bn(array, len, _bn);

    delete[] array;
}

void BigNumber::SetHexStr(char const* str)
{
    BN_hex2bn(&_bn, str);
}

void BigNumber::SetRand(int32 numbits)
{
    BN_rand(_bn, numbits, 0, 1);
}

BigNumber& BigNumber::operator=(BigNumber const& bn)
{
    if (this == &bn)
        return *this;

    BN_copy(_bn, bn._bn);
    return *this;
}

BigNumber BigNumber::operator+=(BigNumber const& bn)
{
    BN_add(_bn, _bn, bn._bn);
    return *this;
}

BigNumber BigNumber::operator-=(BigNumber const& bn)
{
    BN_sub(_bn, _bn, bn._bn);
    return *this;
}

BigNumber BigNumber::operator*=(BigNumber const& bn)
{
    BN_CTX *bnctx;

    bnctx = BN_CTX_new();
    BN_mul(_bn, _bn, bn._bn, bnctx);
    BN_CTX_free(bnctx);

    return *this;
}

BigNumber BigNumber::operator/=(BigNumber const& bn)
{
    BN_CTX *bnctx;

    bnctx = BN_CTX_new();
    BN_div(_bn, NULL, _bn, bn._bn, bnctx);
    BN_CTX_free(bnctx);

    return *this;
}

BigNumber BigNumber::operator%=(BigNumber const& bn)
{
    BN_CTX *bnctx;

    bnctx = BN_CTX_new();
    BN_mod(_bn, _bn, bn._bn, bnctx);
    BN_CTX_free(bnctx);

    return *this;
}

BigNumber BigNumber::Exp(BigNumber const& bn)
{
    BigNumber ret;
    BN_CTX *bnctx;

    bnctx = BN_CTX_new();
    BN_exp(ret._bn, _bn, bn._bn, bnctx);
    BN_CTX_free(bnctx);

    return ret;
}

BigNumber BigNumber::ModExp(BigNumber const& bn1, BigNumber const& bn2)
{
    BigNumber ret;
    BN_CTX *bnctx;

    bnctx = BN_CTX_new();
    BN_mod_exp(ret._bn, _bn, bn1._bn, bn2._bn, bnctx);
    BN_CTX_free(bnctx);

    return ret;
}

int32 BigNumber::GetNumBytes(void)
{
    return BN_num_bytes(_bn);
}

uint32 BigNumber::AsDword()
{
    return (uint32)BN_get_word(_bn);
}

bool BigNumber::isZero() const
{
    return BN_is_zero(_bn);
}

std::unique_ptr<uint8[]> BigNumber::AsByteArray(int32 minSize, bool littleEndian)
{
    int numBytes = GetNumBytes();
    int length = (minSize >= numBytes) ? minSize : numBytes;

    uint8* array = new uint8[length];

    // If we need more bytes than length of BigNumber set the rest to 0
    if (length > numBytes)
        memset((void*)array, 0, length);

    BN_bn2bin(_bn, (unsigned char*)array);

    // openssl's BN stores data internally in big endian format, reverse if little endian desired
    if (littleEndian)
        std::reverse(array, array + length);

    std::unique_ptr<uint8[]> ret(array);
    return ret;
}

char * BigNumber::AsHexStr() const
{
    return BN_bn2hex(_bn);
}

char * BigNumber::AsDecStr() const
{
    return BN_bn2dec(_bn);
}

