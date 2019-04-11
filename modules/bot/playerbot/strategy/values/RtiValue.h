#pragma once
#include "../Value.h"

namespace BotAI
{
    class RtiValue : public ManualSetValue<string>
	{
	public:
        RtiValue(PlayerbotAI* ai);
    };
}
