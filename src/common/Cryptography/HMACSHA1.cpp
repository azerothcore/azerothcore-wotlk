/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "HMACSHA1.h"
#include "BigNumber.h"
#include "Errors.h"
#include <cstring>

#if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER < 0x10100000L
HMAC_CTX* HMAC_CTX_new()
{
    HMAC_CTX *ctx = new HMAC_CTX();
    HMAC_CTX_init(ctx);
    return ctx;
}

void HMAC_CTX_free(HMAC_CTX* ctx)
{
    HMAC_CTX_cleanup(ctx);
    delete ctx;
}
#endif

HmacHash::HmacHash(uint32 len, uint8* seed)
{
    m_ctx = HMAC_CTX_new();
    HMAC_Init_ex(m_ctx, seed, len, EVP_sha1(), nullptr);
    memset(m_digest, 0, sizeof(m_digest));
}

HmacHash::~HmacHash()
{
    HMAC_CTX_free(m_ctx);
}

void HmacHash::UpdateData(std::string const& str)
{
    HMAC_Update(m_ctx, reinterpret_cast<uint8 const*>(str.c_str()), str.length());
}

void HmacHash::UpdateData(uint8 const* data, size_t len)
{
    HMAC_Update(m_ctx, data, len);
}

void HmacHash::Finalize()
{
    uint32 length = 0;
    HMAC_Final(m_ctx, m_digest, &length);
    ASSERT(length == SHA_DIGEST_LENGTH);
}

uint8* HmacHash::ComputeHash(BigNumber* bn)
{
    HMAC_Update(m_ctx, bn->AsByteArray().get(), bn->GetNumBytes());
    Finalize();
    return m_digest;
}
