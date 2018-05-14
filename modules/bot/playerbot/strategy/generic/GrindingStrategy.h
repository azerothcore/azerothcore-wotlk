#include "../generic/NonCombatStrategy.h"
#pragma once

namespace BotAI
{
    class GrindingStrategy : public NonCombatStrategy
    {
    public:
        GrindingStrategy(PlayerbotAI* ai) : NonCombatStrategy(ai) {}
        virtual string getName() { return "grind"; }
        virtual int GetType() { return STRATEGY_TYPE_DPS; }
        NextAction** getDefaultActions();

    public:
        virtual void InitTriggers(std::list<TriggerNode*> &triggers);
    };



}
