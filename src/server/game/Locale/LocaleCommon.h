/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
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

#ifndef _LOCALE_COMMON_H_
#define _LOCALE_COMMON_H_

#include "Common.h"
#include <vector>

namespace Acore::Locale
{
    void AC_GAME_API AddLocaleString(std::string_view str, LocaleConstant locale, std::vector<std::string>& data);
}

#endif // _LOCALE_COMMON_H_
