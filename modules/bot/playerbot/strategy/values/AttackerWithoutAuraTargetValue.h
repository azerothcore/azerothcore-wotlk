#pragma once
#include "../Value.h"

namespace BotAI
{
    class AttackerWithoutAuraTargetValue : public UnitCalculatedValue, public Qualified
	{
	public:
        AttackerWithoutAuraTargetValue(PlayerbotAI* ai) :
            UnitCalculatedValue(ai, "attacker without aura") {}

    protected:
        virtual Unit* Calculate();
	};
}
