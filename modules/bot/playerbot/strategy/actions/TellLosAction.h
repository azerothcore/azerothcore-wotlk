#pragma once

#include "../Action.h"

namespace BotAI
{
    class TellLosAction : public Action {
    public:
        TellLosAction(PlayerbotAI* ai) : Action(ai, "los") {}
        virtual bool Execute(Event event);

    private:
        void ListUnits(string title, list<uint64> units);
        void ListGameObjects(string title, list<uint64> gos);
    };

}
