/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "StringFormat.h"
#include <locale>

template<class Str>
Str Acore::String::Trim(const Str& s, const std::locale& loc /*= std::locale()*/)
{
    typename Str::const_iterator first = s.begin();
    typename Str::const_iterator end = s.end();

    while (first != end && std::isspace(*first, loc))
    {
        ++first;
    }

    if (first == end)
    {
        return Str();
    }

    typename Str::const_iterator last = end;

    do
    {
        --last;
    } while (std::isspace(*last, loc));

    if (first != s.begin() || last + 1 != end)
    {
        return Str(first, last + 1);
    }

    return s;
}

// Template Trim
template std::string Acore::String::Trim<std::string>(const std::string& s, const std::locale& loc /*= std::locale()*/);
