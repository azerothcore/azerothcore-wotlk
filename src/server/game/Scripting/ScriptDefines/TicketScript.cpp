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

#include "TicketScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnTicketCreate(GmTicket* ticket)
{
    CALL_ENABLED_HOOKS(TicketScript, TICKETHOOK_ON_TICKET_CREATE, script->OnTicketCreate(ticket));
}

void ScriptMgr::OnTicketUpdateLastChange(GmTicket* ticket)
{
    CALL_ENABLED_HOOKS(TicketScript, TICKETHOOK_ON_TICKET_UPDATE_LAST_CHANGE, script->OnTicketUpdateLastChange(ticket));
}

void ScriptMgr::OnTicketClose(GmTicket* ticket)
{
    CALL_ENABLED_HOOKS(TicketScript, TICKETHOOK_ON_TICKET_CLOSE, script->OnTicketClose(ticket));
}

void ScriptMgr::OnTicketStatusUpdate(GmTicket* ticket)
{
    CALL_ENABLED_HOOKS(TicketScript, TICKETHOOK_ON_TICKET_STATUS_UPDATE, script->OnTicketStatusUpdate(ticket));
}

void ScriptMgr::OnTicketResolve(GmTicket* ticket)
{
    CALL_ENABLED_HOOKS(TicketScript, TICKETHOOK_ON_TICKET_RESOLVE, script->OnTicketResolve(ticket));
}

TicketScript::TicketScript(char const* name, std::vector<uint16> enabledHooks)
: ScriptObject(name, TICKETHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < TICKETHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<TicketScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<TicketScript>;
