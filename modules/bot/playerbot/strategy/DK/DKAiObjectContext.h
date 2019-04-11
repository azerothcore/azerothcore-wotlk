#pragma once

#include "../AiObjectContext.h"

namespace BotAI
{
    class DKAiObjectContext : public AiObjectContext
    {
    public:
        DKAiObjectContext(PlayerbotAI* ai);
    };
}