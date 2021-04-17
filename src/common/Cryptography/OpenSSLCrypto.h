/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef OPENSSL_CRYPTO_H
#define OPENSSL_CRYPTO_H

#include "Define.h"
#include <openssl/opensslv.h>

/**
* A group of functions which setup openssl crypto module to work properly in multithreaded enviroment
* If not setup properly - it will crash
*/
namespace OpenSSLCrypto
{

#if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER < 0x1010000fL
    /// Needs to be called before threads using openssl are spawned
    void threadsSetup();
    /// Needs to be called after threads using openssl are despawned
    void threadsCleanup();
#else
    void threadsSetup() { };
    void threadsCleanup() { };
#endif

}

#endif
