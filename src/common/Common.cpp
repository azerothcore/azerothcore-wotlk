/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Common.h"

char const* localeNames[TOTAL_LOCALES] =
{
    "enUS",
    "koKR",
    "frFR",
    "deDE",
    "zhCN",
    "zhTW",
    "esES",
    "esMX",
    "ruRU"
};

LocaleConstant GetLocaleByName(const std::string& name)
{
    for (uint32 i = 0; i < TOTAL_LOCALES; ++i)
        if (name == localeNames[i])
        {
            return LocaleConstant(i);
        }

    return LOCALE_enUS;                                     // including enGB case
}

void CleanStringForMysqlQuery(std::string& str)
{
    std::string::size_type n = 0;
    while ((n = str.find('\\')) != str.npos) { str.erase(n, 1); }
    while ((n = str.find('"')) != str.npos) { str.erase(n, 1); }
    while ((n = str.find('\'')) != str.npos) { str.erase(n, 1); }
}
