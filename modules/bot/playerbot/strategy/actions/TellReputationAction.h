#pragma once

#include "../Action.h"

namespace BotAI
{
    class TellReputationAction : public Action {
    public:
        TellReputationAction(PlayerbotAI* ai) : Action(ai, "reputation") {}
        virtual bool Execute(Event event);

    private:

    };

}