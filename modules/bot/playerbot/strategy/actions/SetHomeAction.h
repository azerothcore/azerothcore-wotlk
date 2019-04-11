#pragma once

#include "MovementActions.h"

namespace BotAI
{
    class SetHomeAction : public MovementAction {
    public:
        SetHomeAction(PlayerbotAI* ai) : MovementAction(ai, "home") {}
        virtual bool Execute(Event event);
    };
}
