/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU GPL v2 or later license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 * Copyright (C) 2021+  WarheadCore <https://github.com/WarheadCore>
 */

#ifndef WARHEAD_TOTP_H
#define WARHEAD_TOTP_H

#include "Define.h"
#include <ctime>
#include <vector>

namespace Acore::Crypto
{
    struct AC_COMMON_API TOTP
    {
        static constexpr size_t RECOMMENDED_SECRET_LENGTH = 20;
        using Secret = std::vector<uint8>;

        static uint32 GenerateToken(Secret const& key, time_t timestamp);
        static bool ValidateToken(Secret const& key, uint32 token);
    };
}

#endif
