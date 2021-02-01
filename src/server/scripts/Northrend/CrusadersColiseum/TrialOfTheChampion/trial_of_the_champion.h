/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_TOC_H
#define DEF_TOC_H

#include "CombatAI.h"

enum eData
{
    BOSS_GRAND_CHAMPIONS                            = 0,
    BOSS_ARGENT_CHALLENGE                           = 1,
    BOSS_BLACK_KNIGHT                               = 2,
    MAX_ENCOUNTER                                   = 3,
    DATA_INSTANCE_PROGRESS                          = 4,

    DATA_ANNOUNCER                                  = 5,
    DATA_ANNOUNCER_GOSSIP_SELECT,
    DATA_GRAND_CHAMPION_REACHED_DEST,
    DATA_MOUNT_DIED,
    DATA_REACHED_NEW_MOUNT,
    DATA_GRAND_CHAMPION_PICKED_NEW_VEHICLE,
    DATA_GRAND_CHAMPION_DIED,
    DATA_ARGENT_SOLDIER_DEFEATED,
    DATA_SKELETAL_GRYPHON_LANDED,
    DATA_TEAMID_IN_INSTANCE,
    DATA_PALETRESS,
    DATA_MEMORY_ENTRY,
    DATA_ACHIEV_IVE_HAD_WORSE,
};

enum eProgress
{
    INSTANCE_PROGRESS_INITIAL = 0,
    INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST,
    INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_1,
    INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_2,
    INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_3,
    INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED,
    INSTANCE_PROGRESS_CHAMPIONS_DEAD,
    INSTANCE_PROGRESS_ARGENT_SOLDIERS_DIED,
    INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED,
    INSTANCE_PROGRESS_FINISHED,
};

enum eEvents
{
    EVENT_NULL = 0,
    EVENT_CHECK_PLAYERS,
    EVENT_CLOSE_GATE,
    EVENT_SUMMON_GRAND_CHAMPION_1,
    EVENT_SUMMON_GRAND_CHAMPION_2,
    EVENT_SUMMON_GRAND_CHAMPION_3,
    EVENT_YELL_WELCOME_2,
    EVENT_GRAND_GROUP_1_MOVE_MIDDLE,
    EVENT_GRAND_GROUP_1_ATTACK,
    EVENT_GRAND_GROUP_2_MOVE_MIDDLE,
    EVENT_GRAND_GROUP_2_ATTACK,
    EVENT_GRAND_GROUP_3_MOVE_MIDDLE,
    EVENT_GRAND_GROUP_3_ATTACK,
    EVENT_GRAND_CHAMPIONS_MOVE_MIDDLE,
    EVENT_GRAND_CHAMPIONS_MOUNTS_ATTACK,
    EVENT_GRAND_CHAMPIONS_MOVE_SIDE,
    EVENT_GRAND_CHAMPIONS_ATTACK,
    EVENT_GRATZ_SLAIN_CHAMPIONS,
    EVENT_RESTORE_ANNOUNCER_GOSSIP,
    EVENT_START_ARGENT_CHALLENGE_INTRO,
    EVENT_SUMMON_ARGENT_CHALLENGE,
    EVENT_ARGENT_CHALLENGE_SAY_1,
    EVENT_ARGENT_CHALLENGE_SAY_2,
    EVENT_ARGENT_SOLDIER_GROUP_ATTACK,
    EVENT_ARGENT_CHALLENGE_MOVE_FORWARD,
    EVENT_ARGENT_CHALLENGE_ATTACK,
    EVENT_ARGENT_CHALLENGE_RUN_MIDDLE,
    EVENT_ARGENT_CHALLENGE_LEAVE_CHEST,
    EVENT_ARGENT_CHALLENGE_DISAPPEAR,
    EVENT_SUMMON_BLACK_KNIGHT,
    EVENT_START_BLACK_KNIGHT_SCENE,
    EVENT_BLACK_KNIGHT_CAST_ANNOUNCER,
    EVENT_BLACK_KNIGHT_KILL_ANNOUNCER,
    EVENT_BLACK_KNIGHT_MOVE_FORWARD,
    EVENT_BLACK_KNIGHT_SAY_TASK,
    EVENT_BLACK_KNIGHT_ATTACK,
};

enum eNpcs
{
    // Horde Champions
    NPC_MOKRA                                       = 35572,
    NPC_ERESSEA                                     = 35569,
    NPC_RUNOK                                       = 35571,
    NPC_ZULTORE                                     = 35570,
    NPC_VISCERI                                     = 35617,

    // Alliance Champions
    NPC_JACOB                                       = 34705,
    NPC_AMBROSE                                     = 34702,
    NPC_COLOSOS                                     = 34701,
    NPC_JAELYNE                                     = 34657,
    NPC_LANA                                        = 34703,

    // Grand Champion Minions
    NPC_IRONFORGE_MINION                            = 35329,
    NPC_STORMWIND_MINION                            = 35328,
    NPC_GNOMEREGAN_MINION                           = 35331,
    NPC_EXODAR_MINION                               = 35330,
    NPC_DARNASSUS_MINION                            = 35332,
    NPC_ORGRIMMAR_MINION                            = 35314,
    NPC_SILVERMOON_MINION                           = 35326,
    NPC_THUNDER_BLUFF_MINION                        = 35325,
    NPC_SENJIN_MINION                               = 35323,
    NPC_UNDERCITY_MINION                            = 35327,

    NPC_EADRIC                                      = 35119,
    NPC_EADRIC_H                                    = 35518,
    NPC_PALETRESS                                   = 34928,
    NPC_PALETRESS_H                                 = 35517,

    NPC_ARGENT_LIGHTWIELDER                         = 35309,
    NPC_ARGENT_MONK                                 = 35305,
    NPC_PRIESTESS                                   = 35307,

    NPC_BLACK_KNIGHT                                = 35451,

    NPC_JAEREN                                      = 35004,
    NPC_ARELAS                                      = 35005,
    NPC_RISEN_JAEREN                                = 35545,
    NPC_RISEN_ARELAS                                = 35564,
    NPC_TIRION                                      = 33628,
};

enum eGameObjects
{
    GO_MAIN_GATE                                    = 195647,
    GO_SOUTH_PORTCULLIS                             = 195649,
    GO_EAST_PORTCULLIS                              = 195648,
    GO_NORTH_PORTCULLIS                             = 195650,

    GO_CHAMPIONS_LOOT                               = 195709,
    GO_CHAMPIONS_LOOT_H                             = 195710,

    GO_EADRIC_LOOT                                  = 195374,
    GO_EADRIC_LOOT_H                                = 195375,

    GO_PALETRESS_LOOT                               = 195323,
    GO_PALETRESS_LOOT_H                             = 195324,
};

enum eVehicles
{
    VEHICLE_ARGENT_WARHORSE                         = 35644,
    VEHICLE_ARGENT_BATTLEWORG                       = 36558,

    VEHICLE_BLACK_KNIGHT                            = 35491,
};

enum eTexts
{
    TEXT_LANA_STOUTHAMMER                           = 1,
    TEXT_CHEER_LANA_STOUTHAMMER                     = 2,
    TEXT_COLOSOS                                    = 3,
    TEXT_CHEER_COLOSOS                              = 4,
    TEXT_EVENSONG                                   = 5,
    TEXT_CHEER_EVENSONG                             = 6,
    TEXT_MARSHAL_JACOB_ALERIUS                      = 7,
    TEXT_CHEER_MARSHAL_JACOB_ALERIUS                = 8,
    TEXT_AMBROSE_BOLTSPARK                          = 9,
    TEXT_CHEER_AMBROSE_BOLTSPARK                    = 10,

    TEXT_DEATHSTALKER_VESCERI                       = 11,
    TEXT_CHEER_DEATHSTALKER_VESCERI                 = 12,
    TEXT_RUNOK_WILDMANE                             = 13,
    TEXT_CHEER_RUNOK_WILDMANE                       = 14,
    TEXT_ZUL_TORE                                   = 15,
    TEXT_CHEER_ZUL_TORE                             = 16,
    TEXT_MOKRA_SKILLCRUSHER                         = 17,
    TEXT_CHEER_MOKRA_SKILLCRUSHER                   = 18,
    TEXT_ERESSEA_DAWNSINGER                         = 19,
    TEXT_CHEER_ERESSEA_DAWNSINGER                   = 20,

    TEXT_WELCOME                                    = 21,
    TEXT_WELCOME_2                                  = 22,
    TEXT_BEGIN                                      = 23,
    TEXT_GRATZ_SLAIN_CHAMPIONS                      = 24,
    TEXT_INTRODUCE_EADRIC                           = 25,
    TEXT_INTRODUCE_PALETRESS                        = 26,
    TEXT_CHEER_EADRIC_1                             = 27,
    TEXT_CHEER_EADRIC_2                             = 28,
    TEXT_EADRIC_SAY_1                               = 39,
    TEXT_CHEER_PALETRESS_1                          = 29,
    TEXT_CHEER_PALETRESS_2                          = 30,
    TEXT_PALETRESS_SAY_1                            = 37,
    TEXT_PALETRESS_SAY_2                            = 38,
    TEXT_YOU_MAY_BEGIN                              = 41,

    TEXT_BK_INTRO                                   = 31,
    TEXT_BK_RAFTERS                                 = 32,
    TEXT_BK_SPOILED                                 = 33,
    TEXT_BK_MEANING                                 = 34,
    TEXT_BK_LICH                                    = 35,
    TEXT_BK_TASK                                    = 36,

    TEXT_EADRIC_AGGRO                               = 42,
    TEXT_EADRIC_HAMMER                              = 43,
    TEXT_EADRIC_SLAIN_1                             = 44,
    TEXT_EADRIC_SLAIN_2                             = 45,
    TEXT_EADRIC_DEATH                               = 46,

    TEXT_PALETRESS_AGGRO                            = 47,
    TEXT_PALETRESS_MEMORY_SUMMON                    = 48,
    TEXT_PALETRESS_MEMORY_DEFEATED                  = 51,
    TEXT_PALETRESS_SLAIN_1                          = 49,
    TEXT_PALETRESS_SLAIN_2                          = 50,
    TEXT_PALETRESS_DEATH                            = 52,

    TEXT_BK_AGGRO                                   = 53,
    TEXT_BK_SLAIN_1                                 = 57,
    TEXT_BK_SLAIN_2                                 = 58,
    TEXT_BK_SKELETON_RES                            = 54,
    TEXT_BK_GHOST_RES                               = 55,
    TEXT_BK_DEATH                                   = 56,
};

#endif
