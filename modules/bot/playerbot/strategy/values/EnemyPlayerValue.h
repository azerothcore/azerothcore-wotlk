#pragma once
#include "../Value.h"
#include "TargetValue.h"

namespace BotAI
{
    class EnemyPlayerValue : public TargetValue
	{
	public:
        EnemyPlayerValue(PlayerbotAI* ai) : TargetValue(ai) {}

    public:
        Unit* Calculate();
    };
}
