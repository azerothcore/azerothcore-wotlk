#pragma once

#include "../Action.h"

namespace BotAI
{
	class ChangeTalentsAction : public Action {
	public:
		ChangeTalentsAction(PlayerbotAI* ai) : Action(ai, "talents") {}

    public:
        virtual bool Execute(Event event);

    };

}