#pragma once

#include "../Action.h"

namespace BotAI
{
    class RepairAllAction : public Action 
    {
    public:
        RepairAllAction(PlayerbotAI* ai) : Action(ai, "repair") {}
        virtual bool Execute(Event event);
    };
}