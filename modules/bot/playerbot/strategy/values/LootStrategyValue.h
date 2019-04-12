#pragma once
#include "../Value.h"

namespace BotAI
{
    class LootStrategyValue : public ManualSetValue<LootStrategy>
	{
	public:
        LootStrategyValue(PlayerbotAI* ai) : ManualSetValue<LootStrategy>(ai, LOOTSTRATEGY_SKILL) {}
    };
}
