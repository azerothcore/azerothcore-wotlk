/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ARC4.h"
#include "Errors.h"

Acore::Crypto::ARC4::ARC4()
    : _ctx(EVP_CIPHER_CTX_new())
{
    EVP_CIPHER_CTX_init(_ctx);
    int result = EVP_EncryptInit_ex(_ctx, EVP_rc4(), nullptr, nullptr, nullptr);
    ASSERT(result == 1);
}

Acore::Crypto::ARC4::~ARC4()
{
    EVP_CIPHER_CTX_free(_ctx);
}

void Acore::Crypto::ARC4::Init(uint8 const* seed, size_t len)
{
    int result1 = EVP_CIPHER_CTX_set_key_length(_ctx, len);
    ASSERT(result1 == 1);
    int result2 = EVP_EncryptInit_ex(_ctx, nullptr, nullptr, seed, nullptr);
    ASSERT(result2 == 1);
}

void Acore::Crypto::ARC4::UpdateData(uint8* data, size_t len)
{
    int outlen = 0;
    int result1 = EVP_EncryptUpdate(_ctx, data, &outlen, data, len);
    ASSERT(result1 == 1);
    int result2 = EVP_EncryptFinal_ex(_ctx, data, &outlen);
    ASSERT(result2 == 1);
}
