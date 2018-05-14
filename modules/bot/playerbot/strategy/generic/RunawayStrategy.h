#include "../generic/NonCombatStrategy.h"
#pragma once

namespace BotAI
{
    class RunawayStrategy : public NonCombatStrategy
       {
       public:
           RunawayStrategy(PlayerbotAI* ai) : NonCombatStrategy(ai) {}
           virtual string getName() { return "runaway"; }
           virtual void InitTriggers(std::list<TriggerNode*> &triggers);
       };


}
