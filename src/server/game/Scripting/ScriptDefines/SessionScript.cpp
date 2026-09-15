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

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"
#include "SessionScript.h"

void ScriptMgr::OnSessionUpdate(WorldSession* session, uint32 diff)
{
    ASSERT(session);

    CALL_ENABLED_HOOKS(SessionScript, SESSIONHOOK_ON_UPDATE, script->OnSessionUpdate(session, diff));
}

SessionScript::SessionScript(char const* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, SESSIONHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < SESSIONHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<SessionScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<SessionScript>;
