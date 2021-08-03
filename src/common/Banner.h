/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v3 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 */

#ifndef AZEROTHCORE_BANNER_H
#define AZEROTHCORE_BANNER_H

#include "Define.h"
#include <string_view>

namespace Acore::Banner
{
    AC_COMMON_API void Show(std::string_view applicationName, void(*log)(std::string_view text), void(*logExtraInfo)());
}

#endif // AZEROTHCORE_BANNER_H
