#pragma once
#include "../Value.h"
#include "TargetValue.h"

namespace BotAI
{

    class SpellIdValue : public CalculatedValue<uint32>, public Qualified
	{
	public:
        SpellIdValue(PlayerbotAI* ai);

    public:
        virtual uint32 Calculate();

    };
}
