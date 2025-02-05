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

#include "TicketScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnTicketCreate(Player* player, GmTicket* ticket)
{
    CALL_ENABLED_HOOKS(TicketScript, TICKETHOOK_ON_TICKET_CREATE, script->OnTicketCreate(player, ticket));
}

void ScriptMgr::OnTicketUpdate(Player* player, GmTicket* ticket)
{
    CALL_ENABLED_HOOKS(TicketScript, TICKETHOOK_ON_TICKET_UPDATE, script->OnTicketUpdate(player, ticket));
}

void ScriptMgr::OnTicketClose(Player* player, GmTicket* ticket)
{
    CALL_ENABLED_HOOKS(TicketScript, TICKETHOOK_ON_TICKET_CLOSE, script->OnTicketClose(player, ticket));
}

void ScriptMgr::OnTicketStatusUpdate(Player* player, GmTicket* ticket)
{
    CALL_ENABLED_HOOKS(TicketScript, TICKETHOOK_ON_TICKET_STATUS_UPDATE, script->OnTicketStatusUpdate(player, ticket));
}

void ScriptMgr::OnTicketResolve(Player* player, GmTicket* ticket)
{
    CALL_ENABLED_HOOKS(TicketScript, TICKETHOOK_ON_TICKET_RESOLVE, script->OnTicketResolve(player, ticket));
}

TicketScript::TicketScript(const char* name, std::vector<uint16> enabledHooks)
: ScriptObject(name, TICKETHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < TICKETHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<TicketScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<TicketScript>;
