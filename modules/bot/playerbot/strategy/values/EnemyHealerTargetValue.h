#pragma once
#include "../Value.h"

namespace BotAI
{
    class EnemyHealerTargetValue : public UnitCalculatedValue, public Qualified
	{
	public:
        EnemyHealerTargetValue(PlayerbotAI* ai) :
            UnitCalculatedValue(ai, "enemy healer target") {}

    protected:
        virtual Unit* Calculate();
	};
}
