#pragma once

#include "../Action.h"
#include "InventoryAction.h"

namespace BotAI
{
    class RewardAction : public InventoryAction {
    public:
        RewardAction(PlayerbotAI* ai) : InventoryAction(ai, "reward") {}
        virtual bool Execute(Event event);

    private:
        bool Reward(uint32 itemId, Object* pNpc);
    };

}