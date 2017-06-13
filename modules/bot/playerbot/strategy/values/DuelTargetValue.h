#pragma once
#include "../Value.h"
#include "TargetValue.h"

namespace BotAI
{
    class DuelTargetValue : public TargetValue
	{
	public:
        DuelTargetValue(PlayerbotAI* ai) : TargetValue(ai) {}

    public:
        Unit* Calculate();
    };
}
