/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "AuthCrypt.h"
#include "BigNumber.h"
#include "Errors.h"
#include "HMAC.h"

AuthCrypt::AuthCrypt() : _initialized(false)
{
}

void AuthCrypt::Init(SessionKey const& K)
{
    uint8 ServerEncryptionKey[] = { 0xCC, 0x98, 0xAE, 0x04, 0xE8, 0x97, 0xEA, 0xCA, 0x12, 0xDD, 0xC0, 0x93, 0x42, 0x91, 0x53, 0x57 };
    _serverEncrypt.Init(acore::Crypto::HMAC_SHA1::GetDigestOf(ServerEncryptionKey, K));
    uint8 ServerDecryptionKey[] = { 0xC2, 0xB3, 0x72, 0x3C, 0xC6, 0xAE, 0xD9, 0xB5, 0x34, 0x3C, 0x53, 0xEE, 0x2F, 0x43, 0x67, 0xCE };
    _clientDecrypt.Init(acore::Crypto::HMAC_SHA1::GetDigestOf(ServerDecryptionKey, K));

    // Drop first 1024 bytes, as WoW uses ARC4-drop1024.
    std::array<uint8, 1024> syncBuf;
    _serverEncrypt.UpdateData(syncBuf);
    _clientDecrypt.UpdateData(syncBuf);

    _initialized = true;
}

void AuthCrypt::DecryptRecv(uint8* data, size_t len)
{
     ASSERT(_initialized);
    _clientDecrypt.UpdateData(data, len);
}

void AuthCrypt::EncryptSend(uint8* data, size_t len)
{
    ASSERT(_initialized);
    _serverEncrypt.UpdateData(data, len);
}
