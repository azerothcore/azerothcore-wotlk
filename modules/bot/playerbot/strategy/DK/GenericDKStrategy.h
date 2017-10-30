#pragma once

#include "../Strategy.h"
#include "../generic/MeleeCombatStrategy.h"

namespace BotAI
{
    class GenericDKStrategy : public MeleeCombatStrategy
    {
    public:
        GenericDKStrategy(PlayerbotAI* ai);
        virtual string getName() { return "DK"; }

    public:
        virtual void InitTriggers(std::list<TriggerNode*> &triggers);
    };

}
