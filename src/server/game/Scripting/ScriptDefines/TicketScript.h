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
    TICKETHOOK_ON_TICKET_CREATE,
    TICKETHOOK_ON_TICKET_UPDATE_LAST_CHANGE,
    TICKETHOOK_ON_TICKET_CLOSE,
    TICKETHOOK_ON_TICKET_STATUS_UPDATE,
    TICKETHOOK_ON_TICKET_RESOLVE,
    TICKETHOOK_END
};

class TicketScript : public ScriptObject
{
protected:
    TicketScript(char const* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    virtual void OnTicketCreate(GmTicket* /*ticket*/) { }
    virtual void OnTicketUpdateLastChange(GmTicket* /*ticket*/) { }
    virtual void OnTicketClose(GmTicket* /*ticket*/) { }
    virtual void OnTicketStatusUpdate(GmTicket* /*ticket*/) { }
    virtual void OnTicketResolve(GmTicket* /*ticket*/) { }
};

#endif
