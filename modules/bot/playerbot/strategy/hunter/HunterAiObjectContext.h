#pragma once

#include "../AiObjectContext.h"

namespace BotAI
{
    class HunterAiObjectContext : public AiObjectContext
    {
    public:
        HunterAiObjectContext(PlayerbotAI* ai);
    };
}