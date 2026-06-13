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

#include "ModuleMgr.h"
#include "Tokenize.h"

namespace
{
    std::string_view _modulesList = {};
}

void Acore::Module::SetEnableModulesList(std::string_view modulesList)
{
    _modulesList = modulesList;
}

std::vector<std::string_view> Acore::Module::GetEnableModulesList()
{
    std::vector<std::string_view> _list;

    for (auto const& modName : Acore::Tokenize(_modulesList, ',', false))
    {
        _list.emplace_back(modName);
    }

    return _list;
}
