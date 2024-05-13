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

#include "GameEventScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnGameEventStart(uint16 EventID)
{
    CALL_ENABLED_HOOKS(GameEventScript, GAMEEVENTHOOK_ON_START, script->OnStart(EventID));
}

void ScriptMgr::OnGameEventStop(uint16 EventID)
{
    CALL_ENABLED_HOOKS(GameEventScript, GAMEEVENTHOOK_ON_STOP, script->OnStop(EventID));
}

void ScriptMgr::OnGameEventCheck(uint16 EventID)
{
    CALL_ENABLED_HOOKS(GameEventScript, GAMEEVENTHOOK_ON_EVENT_CHECK, script->OnEventCheck(EventID));
}

GameEventScript::GameEventScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, GAMEEVENTHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < GAMEEVENTHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<GameEventScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<GameEventScript>;
