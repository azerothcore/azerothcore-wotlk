/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _LOCALE_COMMON_H_
#define _LOCALE_COMMON_H_

#include "Common.h"
#include <vector>

namespace Acore::Game::Locale
{
    void AC_GAME_API AddLocaleString(std::string&& str, LocaleConstant locale, std::vector<std::string>& data);
}

#endif // _LOCALE_COMMON_H_
