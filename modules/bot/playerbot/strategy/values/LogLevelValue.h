#pragma once
#include "../Value.h"

namespace BotAI
{
    class LogLevelValue : public ManualSetValue<LogLevel>
	{
	public:
        LogLevelValue(PlayerbotAI* ai) :
            ManualSetValue<LogLevel>(ai, LOGL_DEBUG) {}
	};
}
