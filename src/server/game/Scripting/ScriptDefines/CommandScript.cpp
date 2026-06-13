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

#include "CommandScript.h"
#include "Chat.h"
#include "ScriptMgr.h"

Acore::ChatCommands::ChatCommandTable ScriptMgr::GetChatCommands()
{
    Acore::ChatCommands::ChatCommandTable table;

    for (auto const& [scriptID, script] : ScriptRegistry<CommandScript>::ScriptPointerList)
    {
        Acore::ChatCommands::ChatCommandTable cmds = script->GetCommands();
        std::move(cmds.begin(), cmds.end(), std::back_inserter(table));
    }

    return table;
}

CommandScript::CommandScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<CommandScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<CommandScript>;
