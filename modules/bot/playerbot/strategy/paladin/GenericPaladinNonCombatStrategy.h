#pragma once

#include "../generic/NonCombatStrategy.h"

namespace BotAI
{
    class GenericPaladinNonCombatStrategy : public NonCombatStrategy
    {
    public:
        GenericPaladinNonCombatStrategy(PlayerbotAI* ai);
        virtual string getName() { return "nc"; }
    
    public:
        virtual void InitTriggers(std::list<TriggerNode*> &triggers);
   };
}
