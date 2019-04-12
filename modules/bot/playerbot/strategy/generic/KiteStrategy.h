#pragma once

namespace BotAI
{
    class KiteStrategy : public Strategy
    {
    public:
        KiteStrategy(PlayerbotAI* ai);
        virtual string getName() { return "kite"; }
    
    public:
        virtual void InitTriggers(std::list<TriggerNode*> &triggers);
    };

}
