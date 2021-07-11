/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "LocaleCommon.h"

void Acore::Game::Locale::AddLocaleString(std::string&& str, LocaleConstant locale, std::vector<std::string>& data)
{
    if (str.empty())
    {
        return;
    }

    if (data.size() <= size_t(locale))
    {
        data.resize(size_t(locale) + 1);
    }

    data[locale] = std::move(str);
}
