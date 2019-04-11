#pragma once

#include "../Action.h"
#include "MovementActions.h"

namespace BotAI
{
	class TeleportAction : public Action {
	public:
		TeleportAction(PlayerbotAI* ai) : Action(ai, "teleport") {}

    public:
        virtual bool Execute(Event event);
    };

}