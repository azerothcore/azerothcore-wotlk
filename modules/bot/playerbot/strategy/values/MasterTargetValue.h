#pragma once
#include "../Value.h"

namespace BotAI
{
    class MasterTargetValue : public UnitCalculatedValue
	{
	public:
        MasterTargetValue(PlayerbotAI* ai) : UnitCalculatedValue(ai) {}

        virtual Unit* Calculate() { return ai->GetMaster(); }
    };
}
