#pragma once

#include "../Strategy.h"
#include "../generic/CombatStrategy.h"

namespace BotAI
{
    class GenericPriestStrategy : public CombatStrategy
    {
    public:
        GenericPriestStrategy(PlayerbotAI* ai);

    public:
        virtual void InitTriggers(std::list<TriggerNode*> &triggers);

    };
}
