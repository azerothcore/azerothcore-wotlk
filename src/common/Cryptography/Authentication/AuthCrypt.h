/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _AUTHCRYPT_H
#define _AUTHCRYPT_H

#include "Cryptography/ARC4.h"

class BigNumber;

class AuthCrypt
{
public:
    AuthCrypt();

    void Init(BigNumber* K);
    void DecryptRecv(uint8*, size_t);
    void EncryptSend(uint8*, size_t);

    bool IsInitialized() const { return _initialized; }

private:
    ARC4 _clientDecrypt;
    ARC4 _serverEncrypt;
    bool _initialized;
};
#endif
