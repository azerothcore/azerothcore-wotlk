#pragma once
#include "Action.h"
#include "Multiplier.h"

namespace BotAI
{
    class PassiveMultiplier : public Multiplier
    {
    public:
        PassiveMultiplier(PlayerbotAI* ai);

    public:
        virtual float GetValue(Action* action);

    private:
        static list<string> allowedActions;
        static list<string> allowedParts;
    };

}
