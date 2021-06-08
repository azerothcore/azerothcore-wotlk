/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef AZEROTHCORE_CRYPTO_CONSTANTS_H
#define AZEROTHCORE_CRYPTO_CONSTANTS_H

#include "Define.h"

namespace Acore::Crypto
{
    struct Constants
    {
        static constexpr size_t SHA1_DIGEST_LENGTH_BYTES   = 20;
        static constexpr size_t SHA256_DIGEST_LENGTH_BYTES = 32;
    };
}

#endif
