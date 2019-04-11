#pragma once

#include "../Action.h"
#include "QuestAction.h"

namespace BotAI
{
    class CastCustomSpellAction : public Action
    {
    public:
        CastCustomSpellAction(PlayerbotAI* ai) : Action(ai, "cast custom spell") {}
        virtual bool Execute(Event event);
    };
}
