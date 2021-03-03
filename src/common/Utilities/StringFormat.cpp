/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "StringFormat.h"

// Taken from https://stackoverflow.com/a/1798170
std::string acore::String::Trim(std::string const& str, std::string_view whitespace /*= " \t"*/)
{
    const auto strBegin = str.find_first_not_of(whitespace);
    if (strBegin == std::string::npos)
        return ""; // no content

    auto const strEnd = str.find_last_not_of(whitespace);
    auto const strRange = strEnd - strBegin + 1;

    return str.substr(strBegin, strRange);
}

std::string acore::String::Reduce(std::string const& str, std::string_view fill /*= " "*/, std::string_view whitespace /*= " \t"*/)
{
    // trim first
    auto result = Trim(str, whitespace);

    // replace sub ranges
    auto beginSpace = result.find_first_of(whitespace);
    while (beginSpace != std::string::npos)
    {
        const auto endSpace = result.find_first_not_of(whitespace, beginSpace);
        const auto range = endSpace - beginSpace;

        result.replace(beginSpace, range, fill);

        const auto newStart = beginSpace + fill.length();
        beginSpace = result.find_first_of(whitespace, newStart);
    }

    return result;
}
