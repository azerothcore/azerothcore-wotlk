/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef AZEROTHCORE_AUTHDEFINES_H
#define AZEROTHCORE_AUTHDEFINES_H

#include "Define.h"
#include <array>

constexpr size_t SESSION_KEY_LENGTH = 40;
using SessionKey = std::array<uint8, SESSION_KEY_LENGTH>;

#endif
