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

#include "AllCommandScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnHandleDevCommand(Player* player, bool& enable)
{
    CALL_ENABLED_HOOKS(AllCommandScript, ALLCOMMANDHOOK_ON_HANDLE_DEV_COMMAND, script->OnHandleDevCommand(player, enable));
}

bool ScriptMgr::CanExecuteCommand(ChatHandler& handler, std::string_view cmdStr)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AllCommandScript, ALLCOMMANDHOOK_CAN_EXECUTE_COMMAND, !script->CanExecuteCommand(handler, cmdStr));
}

AllCommandScript::AllCommandScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, ALLCOMMANDHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < ALLCOMMANDHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<AllCommandScript>::AddScript(this, std::move(enabledHooks));
}
