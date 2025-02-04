#ifndef __ACORE_REPUTATION_SOURCE_H
#define __ACORE_REPUTATION_SOURCE_H
#include "Define.h"

/**
 * @brief This enum represent all known sources a character can get reputation
 */
enum class ReputationSource : uint8 {
    /// The player killed an enemy
    Kill,
    /// The player turned in a quest
    Quest,
    /// The player turned in a daily quest
    DailyQuest,
    /// The player turned in a weekly quest
    WeeklyQuest,
    /// The player turned in a montly quest
    MonthlyQuest,
    /// The player turned in a repeatable quest
    RepeatableQuest,
    /// The player used a spell
    Spell,
    // The player get reputation by doing PvP related tasks
    PvP,
    /// The player get reputation by a console command
    Console,
    /// The player get some reputation by server configuration
    Config
};

#endif
