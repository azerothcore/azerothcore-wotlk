#pragma once

#include "../Action.h"


namespace BotAI
{
    class ListSpellsAction : public Action {
    public:
        ListSpellsAction(PlayerbotAI* ai) : Action(ai, "spells") {}

        virtual bool Execute(Event event);
  
    };

}