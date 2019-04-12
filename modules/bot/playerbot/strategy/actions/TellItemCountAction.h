#pragma once

#include "../Action.h"
#include "InventoryAction.h"

namespace BotAI
{
    class TellItemCountAction : public InventoryAction {
    public:
        TellItemCountAction(PlayerbotAI* ai) : InventoryAction(ai, "c") {}
        virtual bool Execute(Event event);
    };

}