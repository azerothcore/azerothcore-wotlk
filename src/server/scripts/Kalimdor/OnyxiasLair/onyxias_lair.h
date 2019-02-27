/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_ONYXIAS_LAIR_H
#define DEF_ONYXIAS_LAIR_H

enum eInstanceData
{
    DATA_ONYXIA                 = 0,
    MAX_ENCOUNTER               = 1,
    DATA_WHELP_SUMMONED,
    DATA_DEEP_BREATH_FAILED,
};

enum eCreatures
{
    NPC_ONYXIA                  = 10184,
    NPC_ONYXIAN_WHELP           = 11262,
    NPC_ONYXIAN_LAIR_GUARD      = 36561,
};

enum eGameObjects
{
    GO_WHELP_SPAWNER            = 176510,
    GO_WHELP_EGG                = 176511
};

enum eAchievementData
{
    ACHIEV_CRITERIA_MANY_WHELPS_10_PLAYER                   = 12565, // Criteria for achievement 4403: Many Whelps! Handle It! (10 player) Hatch 50 eggs in 10s
    ACHIEV_CRITERIA_MANY_WHELPS_25_PLAYER                   = 12568, // Criteria for achievement 4406: Many Whelps! Handle It! (25 player) Hatch 50 eggs in 10s
    ACHIEV_CRITERIA_DEEP_BREATH_10_PLAYER                   = 12566, // Criteria for achievement 4404: She Deep Breaths More (10 player) Everybody evade Deep Breath
    ACHIEV_CRITERIA_DEEP_BREATH_25_PLAYER                   = 12569, // Criteria for achievement 4407: She Deep Breaths More (25 player) Everybody evade Deep Breath
    ACHIEV_TIMED_START_EVENT                                =  6601, // Timed event for achievement 4402, 4005: More Dots! (10,25 player) 5 min kill
};

#endif
