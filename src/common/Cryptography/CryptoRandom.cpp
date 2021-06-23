/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "CryptoRandom.h"
#include "Errors.h"
#include <openssl/rand.h>

void Acore::Crypto::GetRandomBytes(uint8* buf, size_t len)
{
    int result = RAND_bytes(buf, len);
    ASSERT(result == 1);
}
