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

#ifndef SCRIPT_OBJECT_TICKET_SCRIPT_H_
#define SCRIPT_OBJECT_TICKET_SCRIPT_H_

#include "ScriptObject.h"
#include "TicketMgr.h"
#include <vector>

enum TicketHook
{
    TICKETHOOK_ON_CREATE_TICKET,
    TICKETHOOK_ON_UPDATE_TICKET,
    TICKETHOOK_ON_CLOSE_TICKET,
    TICKETHOOK_ON_STATUS_UPDATE_TICKET,
    TICKETHOOK_ON_RESOLVE_TICKET,
    TICKETHOOK_END
};

class TicketScript : public ScriptObject
{
protected:
    TicketScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    virtual void OnCreateTicket(Player* /*player*/, GmTicket* /*ticket*/) { }
    virtual void OnTicketUpdate(Player* /*player*/, GmTicket* /*ticket*/, std::string /*message*/) { }
    virtual void OnTicketClose(Player* /*player*/, GmTicket* /*ticket*/) { }
    virtual void OnTicketStatusUpdate(Player* /*player*/, GmTicket* /*ticket*/) { }
    virtual void OnTicketResolve(Player* /*player*/, GmTicket* /*ticket*/) { }
};

#endif
