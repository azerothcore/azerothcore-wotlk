/*
 * Copyright (C) 2010 - 2016 Eluna Lua Engine <http://emudevs.com/>
 * This program is free software licensed under GPL version 3
 * Please see the included DOCS/LICENSE.md for more information
 */

#include "Hooks.h"
#include "HookHelpers.h"
#include "LuaEngine.h"
#include "BindingMap.h"
#include "ElunaIncludes.h"
#include "ElunaTemplate.h"

using namespace Hooks;

#define START_HOOK(EVENT) \
    if (!IsEnabled())\
        return;\
    auto key = EventKey<TicketEvents>(EVENT);\
    if (!TicketEventBindings->HasBindingsFor(key))\
        return;\
    LOCK_ELUNA

#define START_HOOK(EVENT) \
    if (!IsEnabled())\
        return;\
    auto key = EventKey<TicketEvents>(EVENT);\
    if (!TicketEventBindings->HasBindingsFor(key))\
        return;\
    LOCK_ELUNA

void Eluna::OnTicketCreate(GmTicket* ticket)
{
    START_HOOK(TICKET_EVENT_ON_CREATE);
    Push(ticket);
    CallAllFunctions(TicketEventBindings, key);
}

void Eluna::OnTicketUpdateLastChange(GmTicket* ticket)
{
    START_HOOK(TICKET_EVENT_UPDATE_LAST_CHANGE);
    Push(ticket);
    CallAllFunctions(TicketEventBindings, key);
}

void Eluna::OnTicketClose(GmTicket* ticket)
{
    START_HOOK(TICKET_EVENT_ON_CLOSE);
    Push(ticket);
    CallAllFunctions(TicketEventBindings, key);
}

void Eluna::OnTicketResolve(GmTicket* ticket)
{
    START_HOOK(TICKET_EVENT_ON_RESOLVE);
    Push(ticket);
    CallAllFunctions(TicketEventBindings, key);
}

