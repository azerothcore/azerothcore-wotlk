#pragma once

#include "../Action.h"
#include "InventoryAction.h"

namespace BotAI
{
    class SendMailAction : public InventoryAction
    {
    public:
        SendMailAction(PlayerbotAI* ai) : InventoryAction(ai, "sendmail") {}

        virtual bool Execute(Event event);
    };

}