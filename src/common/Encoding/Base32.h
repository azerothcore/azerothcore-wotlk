/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU GPL v2 or later license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 * Copyright (C) 2021+  WarheadCore <https://github.com/WarheadCore>
 */

#ifndef WARHEAD_BASE32_H
#define WARHEAD_BASE32_H

#include "Define.h"
#include "Optional.h"
#include <string>
#include <vector>

namespace Acore::Encoding
{
    struct AC_COMMON_API Base32
    {
        static std::string Encode(std::vector<uint8> const& data);
        static Optional<std::vector<uint8>> Decode(std::string const& data);
    };
}

#endif
