#ifndef BOTLOG_H_
#define BOTLOG_H_

#include "Define.h"

#include "botlogtraits.h"

class Creature;

constexpr uint32 BOT_LOG_KEEP_DAYS = 30;

enum BotLogType : uint16
{
    NPCBOT_LOG_SPAWN                    = 1,
    NPCBOT_LOG_END
};

class BotLogger
{
    public:
        template<typename... Args>
        requires NPCBots::LoggableArguments<Args...>
        static void Log(uint16 log_type, Creature const* bot, Args&&... params);
        template<typename... Args>
        requires NPCBots::LoggableArguments<Args...>
        static void Log(uint16 log_type, uint32 entry, Args&&... params);
};

#endif //BOTLOG_H_
