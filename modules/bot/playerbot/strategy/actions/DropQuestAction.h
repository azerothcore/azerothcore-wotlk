#pragma once

#include "../Action.h"

namespace BotAI
{
    class DropQuestAction : public Action {
    public:
        DropQuestAction(PlayerbotAI* ai) : Action(ai, "drop quest") {}
        virtual bool Execute(Event event);
    };

}