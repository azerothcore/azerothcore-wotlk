#pragma once

#include "../Strategy.h"
#include "../generic/RangedCombatStrategy.h"

namespace BotAI
{
    class AiObjectContext;

    class GenericHunterStrategy : public RangedCombatStrategy
    {
    public:
        GenericHunterStrategy(PlayerbotAI* ai);

    public:
        virtual void InitTriggers(std::list<TriggerNode*> &triggers);
        virtual string getName() { return "hunter"; }
    };
}

