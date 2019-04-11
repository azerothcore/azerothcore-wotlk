#pragma once

#include "../Action.h"
#include "InventoryAction.h"

namespace BotAI
{
    class GuildAcceptAction : public Action {
    public:
        GuildAcceptAction(PlayerbotAI* ai) : Action(ai, "guild accept") {}
        virtual bool Execute(Event event);
    };

}
