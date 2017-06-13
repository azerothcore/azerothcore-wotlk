#pragma once
#include "../Value.h"

namespace BotAI
{
    class SelfTargetValue : public UnitCalculatedValue
	{
	public:
        SelfTargetValue(PlayerbotAI* ai) : UnitCalculatedValue(ai) {}

        virtual Unit* Calculate() { return ai->GetBot(); }
    };
}
