#pragma once

#include "../Action.h"
#include "InventoryAction.h"

namespace BotAI
{
    class SellAction : public InventoryAction {
    public:
        SellAction(PlayerbotAI* ai) : InventoryAction(ai, "sell") {}
        virtual bool Execute(Event event);

        void Sell(FindItemVisitor* visitor);
        void Sell(Item* item);

    };

}