#pragma once

#include "../generic/NonCombatStrategy.h"

namespace BotAI
{
    class GenericWarriorNonCombatStrategy : public NonCombatStrategy
    {
    public:
        GenericWarriorNonCombatStrategy(PlayerbotAI* ai) : NonCombatStrategy(ai) {}
        virtual string getName() { return "nc"; }
		virtual void InitTriggers(std::list<TriggerNode*> &triggers);		
   };
}