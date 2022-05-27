/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU GPL v2 or later license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 * Copyright (C) 2021+  WarheadCore <https://github.com/WarheadCore>
 */

#include "AES.h"
#include "Errors.h"
#include <limits>

Acore::Crypto::AES::AES(bool encrypting) : _ctx(EVP_CIPHER_CTX_new()), _encrypting(encrypting)
{
    EVP_CIPHER_CTX_init(_ctx);
    int status = EVP_CipherInit_ex(_ctx, EVP_aes_128_gcm(), nullptr, nullptr, nullptr, _encrypting ? 1 : 0);
    ASSERT(status);
}

Acore::Crypto::AES::~AES()
{
    EVP_CIPHER_CTX_free(_ctx);
}

void Acore::Crypto::AES::Init(Key const& key)
{
    int status = EVP_CipherInit_ex(_ctx, nullptr, nullptr, key.data(), nullptr, -1);
    ASSERT(status);
}

bool Acore::Crypto::AES::Process(IV const& iv, uint8* data, size_t length, Tag& tag)
{
    ASSERT(length <= static_cast<size_t>(std::numeric_limits<int>::max()));
    int len = static_cast<int>(length);
    if (!EVP_CipherInit_ex(_ctx, nullptr, nullptr, nullptr, iv.data(), -1))
    {
        return false;
    }

    int outLen;
    if (!EVP_CipherUpdate(_ctx, data, &outLen, data, len))
    {
        return false;
    }

    len -= outLen;

    if (!_encrypting && !EVP_CIPHER_CTX_ctrl(_ctx, EVP_CTRL_GCM_SET_TAG, sizeof(tag), tag))
    {
        return false;
    }

    if (!EVP_CipherFinal_ex(_ctx, data + outLen, &outLen))
    {
        return false;
    }

    ASSERT(len == outLen);

    if (_encrypting && !EVP_CIPHER_CTX_ctrl(_ctx, EVP_CTRL_GCM_GET_TAG, sizeof(tag), tag))
    {
        return false;
    }

    return true;
}
