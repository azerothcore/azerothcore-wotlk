#pragma once

#include "../Action.h"

namespace BotAI
{
    class AcceptDuelAction : public Action
    {
    public:
        AcceptDuelAction(PlayerbotAI* ai) : Action(ai, "accept duel")
        {}

        virtual bool Execute(Event event)
        {
            WorldPacket p(event.getPacket());

            uint64 flagGuid;
            p >> flagGuid;
            uint64 playerGuid;
            p >> playerGuid;

            WorldPacket* const packet = new WorldPacket(CMSG_DUEL_ACCEPTED, 8);
            *packet << flagGuid;
            bot->GetSession()->QueuePacket(packet);

            ai->ResetStrategies();
            return true;
        }
    };

}
