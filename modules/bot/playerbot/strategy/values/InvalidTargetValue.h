#pragma once
#include "../Value.h"

namespace BotAI
{
    class InvalidTargetValue : public BoolCalculatedValue, public Qualified
	{
	public:
        InvalidTargetValue(PlayerbotAI* ai) : BoolCalculatedValue(ai) {}

	public:
        virtual bool Calculate();
    };
}
