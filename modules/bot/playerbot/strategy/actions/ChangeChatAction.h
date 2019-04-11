#pragma once

#include "../Action.h"

namespace BotAI
{
    class ChangeChatAction : public Action {
    public:
        ChangeChatAction(PlayerbotAI* ai) : Action(ai, "chat") {}
        virtual bool Execute(Event event);
   
    };

}