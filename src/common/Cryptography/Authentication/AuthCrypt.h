/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _AUTHCRYPT_H
#define _AUTHCRYPT_H

#include "ARC4.h"
#include "AuthDefines.h"
#include <array>

class AuthCrypt
{
public:
    AuthCrypt();

    void Init(SessionKey const& K);
    void DecryptRecv(uint8* data, size_t len);
    void EncryptSend(uint8* data, size_t len);

    bool IsInitialized() const { return _initialized; }

private:
    acore::Crypto::ARC4 _clientDecrypt;
    acore::Crypto::ARC4 _serverEncrypt;
    bool _initialized;
};
#endif
