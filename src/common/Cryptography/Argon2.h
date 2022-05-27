/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU GPL v2 or later license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 * Copyright (C) 2021+  WarheadCore <https://github.com/WarheadCore>
 */

#ifndef WARHEAD_ARGON2_H
#define WARHEAD_ARGON2_H

#include "BigNumber.h"
#include "Define.h"
#include "Optional.h"
#include <string>

namespace Acore::Crypto
{
    struct AC_COMMON_API Argon2
    {
        static constexpr uint32 HASH_LEN = 16;                    // 128 bits, in bytes
        static constexpr uint32 ENCODED_HASH_LEN = 100;           // in chars
        static constexpr uint32 DEFAULT_ITERATIONS = 10;          // determined by dice roll, guaranteed to be secure (not really)
        static constexpr uint32 DEFAULT_MEMORY_COST = (1u << 17); // 2^17 kibibytes is 2^7 mebibytes is ~100MB
        static constexpr uint32 PARALLELISM = 1;                  // we don't support threaded hashing

        static Optional<std::string> Hash(std::string const& password, BigNumber const& salt, uint32 nIterations = DEFAULT_ITERATIONS, uint32 kibMemoryCost = DEFAULT_MEMORY_COST);
        static bool Verify(std::string const& password, std::string const& hash);
    };
}

#endif
