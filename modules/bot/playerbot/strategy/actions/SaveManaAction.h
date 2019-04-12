#pragma once

#include "../Action.h"
#include "InventoryAction.h"

namespace BotAI
{
    class SaveManaAction : public Action
    {
    public:
        SaveManaAction(PlayerbotAI* ai) : Action(ai, "save mana") {}

    public:
        virtual bool Execute(Event event);

    private:
        string format(double value);
    };

}
