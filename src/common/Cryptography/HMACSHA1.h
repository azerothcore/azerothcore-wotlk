/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _AUTH_HMAC_H
#define _AUTH_HMAC_H

#include "Define.h"
#include <string>
#include <openssl/hmac.h>
#include <openssl/sha.h>

class BigNumber;

#define SEED_KEY_SIZE 16

class HmacHash
{
    public:
        HmacHash(uint32 len, uint8* seed);
        ~HmacHash();
        void UpdateData(std::string const& str);
        void UpdateData(uint8 const* data, size_t len);
        void Finalize();
        uint8* ComputeHash(BigNumber* bn);
        uint8* GetDigest() { return m_digest; }
        int GetLength() const { return SHA_DIGEST_LENGTH; }
    private:
        HMAC_CTX* m_ctx;
        uint8 m_digest[SHA_DIGEST_LENGTH];
};
#endif

