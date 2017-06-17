#pragma once
#include "../Value.h"
#include "TargetValue.h"

namespace BotAI
{
   
    class CurrentCcTargetValue : public TargetValue, public Qualified
	{
	public:
        CurrentCcTargetValue(PlayerbotAI* ai) : TargetValue(ai) {}

    public:
        Unit* Calculate();
    };
}
