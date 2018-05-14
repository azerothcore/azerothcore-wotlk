#pragma once
#include "../Value.h"

namespace BotAI
{
    class AoeHealValue : public Uint8CalculatedValue, public Qualified
	{
	public:
    	AoeHealValue(PlayerbotAI* ai) : Uint8CalculatedValue(ai) {}

    public:
    	virtual uint8 Calculate();
    };
}
