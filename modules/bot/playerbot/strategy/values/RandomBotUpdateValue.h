#pragma once
#include "../Value.h"

namespace BotAI
{
    class RandomBotUpdateValue : public ManualSetValue<bool>
	{
	public:
        RandomBotUpdateValue(PlayerbotAI* ai) : ManualSetValue<bool>(ai, false) {}
    };
}
