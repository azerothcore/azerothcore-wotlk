/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/> 
 */

#ifndef ACORE_OPTIONAL_H
#define ACORE_OPTIONAL_H

#include <optional>

//! Optional helper class to wrap optional values within.
template <class T>
using Optional = std::optional<T>;

#endif // ACORE_OPTIONAL_H
