#include "../generic/NonCombatStrategy.h"
#pragma once

namespace BotAI
{
    class MoveRandomStrategy : public NonCombatStrategy
    {
    public:
        MoveRandomStrategy(PlayerbotAI* ai) : NonCombatStrategy(ai) {}
        virtual string getName() { return "move random"; }

    public:
        virtual void InitTriggers(std::list<TriggerNode*> &triggers);
    };

}
