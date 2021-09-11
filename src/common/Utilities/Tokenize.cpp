/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "Tokenize.h"

std::vector<std::string_view> Acore::Tokenize(std::string_view str, char sep, bool keepEmpty)
{
    std::vector<std::string_view> tokens;

    size_t start = 0;
    for (size_t end = str.find(sep); end != std::string_view::npos; end = str.find(sep, start))
    {
        if (keepEmpty || (start < end))
        {
            tokens.push_back(str.substr(start, end - start));
        }

        start = end + 1;
    }

    if (keepEmpty || (start < str.length()))
    {
        tokens.push_back(str.substr(start));
    }

    return tokens;
}
