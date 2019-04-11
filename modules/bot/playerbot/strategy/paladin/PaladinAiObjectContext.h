#pragma once

#include "../AiObjectContext.h"

namespace BotAI
{
    class PaladinAiObjectContext : public AiObjectContext
    {
    public:
        PaladinAiObjectContext(PlayerbotAI* ai);
    };
}