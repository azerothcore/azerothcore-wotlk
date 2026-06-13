/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Tokenize.h"

std::vector<std::string_view> Acore::Tokenize(std::string_view str, char sep, bool keepEmpty)
{
    std::vector<std::string_view> tokens;

    std::size_t start = 0;
    for (std::size_t end = str.find(sep); end != std::string_view::npos; end = str.find(sep, start))
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
