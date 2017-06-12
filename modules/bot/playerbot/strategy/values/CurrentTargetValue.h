#pragma once
#include "../Value.h"

namespace BotAI
{
    class CurrentTargetValue : public UnitManualSetValue
	{
	public:
        CurrentTargetValue(PlayerbotAI* ai) : UnitManualSetValue(ai, NULL) {}

        virtual Unit* Get();
        virtual void Set(Unit* unit);

    private:
        uint64 selection;
    };
}
