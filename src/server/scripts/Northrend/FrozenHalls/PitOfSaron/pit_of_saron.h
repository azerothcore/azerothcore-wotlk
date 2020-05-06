/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_PIT_OF_SARON_H
#define DEF_PIT_OF_SARON_H

#include "Chat.h"

enum DataTypes
{
    DATA_GARFROST,
    DATA_ICK,
    DATA_TYRANNUS,
    MAX_ENCOUNTER,

    DATA_INSTANCE_PROGRESS,
    DATA_TEAMID_IN_INSTANCE,
    DATA_TYRANNUS_EVENT_GUID,
    DATA_NECROLYTE_1_GUID,
    DATA_NECROLYTE_2_GUID,
    DATA_GUARD_1_GUID,
    DATA_GUARD_2_GUID,
    DATA_LEADER_FIRST_GUID,
    DATA_GARFROST_GUID,
    DATA_MARTIN_OR_GORKUN_GUID,
    DATA_RIMEFANG_GUID,
    DATA_TYRANNUS_GUID,
    DATA_LEADER_SECOND_GUID,
    DATA_SINDRAGOSA_GUID,
    DATA_ACHIEV_ELEVEN,
    DATA_ACHIEV_DONT_LOOK_UP,
    DATA_START_INTRO,
};

enum InstanceProgressConst
{
    INSTANCE_PROGRESS_NONE,
    INSTANCE_PROGRESS_FINISHED_INTRO,
    INSTANCE_PROGRESS_FINISHED_KRICK_SCENE,
    INSTANCE_PROGRESS_AFTER_WARN_1,
    INSTANCE_PROGRESS_AFTER_WARN_2,
    INSTANCE_PROGRESS_AFTER_TUNNEL_WARN,
    INSTANCE_PROGRESS_TYRANNUS_INTRO,
};

enum CreatureIds
{
    NPC_GARFROST                                = 36494,
    NPC_KRICK                                   = 36477,
    NPC_ICK                                     = 36476,
    NPC_TYRANNUS                                = 36658,
    NPC_RIMEFANG                                = 36661,
    NPC_SINDRAGOSA                              = 37755,

    NPC_TYRANNUS_EVENT                          = 36794,
    NPC_TYRANNUS_VOICE                          = 36795,
    NPC_SYLVANAS_PART1                          = 36990,
    NPC_SYLVANAS_PART2                          = 38189,
    NPC_JAINA_PART1                             = 36993,
    NPC_JAINA_PART2                             = 38188,

    NPC_KALIRA                                  = 37583,
    NPC_ELANDRA                                 = 37774,
    NPC_LORALEN                                 = 37779,
    NPC_KORELN                                  = 37582,

    NPC_CHAMPION_1_HORDE                        = 37584,
    NPC_CHAMPION_2_HORDE                        = 37587,
    NPC_CHAMPION_3_HORDE                        = 37588,
    NPC_CHAMPION_1_ALLIANCE                     = 37496,
    NPC_CHAMPION_2_ALLIANCE                     = 37497,

    NPC_HORDE_SLAVE_1                           = 36770,
    NPC_HORDE_SLAVE_2                           = 36771,
    NPC_HORDE_SLAVE_3                           = 36772,
    NPC_HORDE_SLAVE_4                           = 36773,
    NPC_ALLIANCE_SLAVE_1                        = 36764,
    NPC_ALLIANCE_SLAVE_2                        = 36765,
    NPC_ALLIANCE_SLAVE_3                        = 36766,
    NPC_ALLIANCE_SLAVE_4                        = 36767,

    NPC_RESCUED_ALLIANCE_SLAVE                  = 36888,
    NPC_RESCUED_HORDE_SLAVE                     = 36889,

    NPC_YMIRJAR_DEATHBRINGER                    = 36892,
    NPC_YMIRJAR_WRATHBRINGER                    = 36840,
    NPC_YMIRJAR_FLAMEBEARER                     = 36893,

    NPC_FALLEN_WARRIOR                          = 36841,
    NPC_WRATHBONE_COLDWRAITH                    = 36842,

    NPC_MARTIN_VICTUS_1                         = 37591,
    NPC_GORKUN_IRONSKULL_1                      = 37592,

    NPC_MARTIN_VICTUS_2                         = 37580,
    NPC_GORKUN_IRONSKULL_2                      = 37581,
    NPC_FREED_SLAVE_1_ALLIANCE                  = 37576, // mage
    NPC_FREED_SLAVE_2_ALLIANCE                  = 37575, // warr
    NPC_FREED_SLAVE_3_ALLIANCE                  = 37572, // warr
    NPC_FREED_SLAVE_1_HORDE                     = 37579, // mage
    NPC_FREED_SLAVE_2_HORDE                     = 37578, // warr
    NPC_FREED_SLAVE_3_HORDE                     = 37577, // warr
};

enum GameObjectIds
{
    GO_HOR_PORTCULLIS                           = 201848,
    GO_ICE_WALL                                 = 201885,
};

enum eSpells
{
    SPELL_NECROLYTE_CHANNELING                  = 30540,
    SPELL_KRICK_KILL_CREDIT                     = 71308,
    SPELL_TUNNEL_ICICLE                         = 69424,
    SPELL_TELEPORT_JAINA_VISUAL                 = 70623,
    SPELL_TELEPORT_JAINA                        = 70525,
    SPELL_TELEPORT_SYLVANAS_VISUAL              = 70638,
    SPELL_TELEPORT_SYLVANAS                     = 70639,
    SPELL_SINDRAGOSA_FROST_BOMB_POS             = 70521,
};

#define PATH_BEGIN_VALUE 3000200

/************
*** INTRO:
************/

enum eIntroTexts
{
    SAY_TYRANNUS_INTRO_1                        = 1,
    SAY_JAINA_INTRO_1                           = 2,
    SAY_SYLVANAS_INTRO_1                        = 3,
    SAY_TYRANNUS_INTRO_2                        = 4,
    SAY_TYRANNUS_INTRO_3                        = 5,
    SAY_JAINA_INTRO_2                           = 6,
    SAY_SYLVANAS_INTRO_2                        = 7,
    SAY_TYRANNUS_INTRO_4                        = 8,
    SAY_JAINA_INTRO_3                           = 9,
    SAY_JAINA_INTRO_4                           = 10,
    SAY_SYLVANAS_INTRO_3                        = 11,
    SAY_JAINA_INTRO_5                           = 12,
    SAY_SYLVANAS_INTRO_4                        = 13,
};

const Position PortalPos = {424.46f, 212.16f, 528.8f, 0.0f};
const Position LeaderIntroPos = {440.788f, 213.76f, 528.711f, 0.0f};
const Position NecrolytePos1 = {506.304f, 211.78f, 528.71f, M_PI};
const Position NecrolytePos2 = {506.127f, 231.46f, 528.71f, M_PI};

struct ChampionPosition
{
    uint32 entry[2];
    Position endPosition;
};

const ChampionPosition introPositions[] =
{
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 452.884f, 209.141f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 450.541f, 212.28f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 449.835f, 206.68f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_2_HORDE }, { 446.542f, 209.986f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_2_HORDE }, { 447.29f, 213.916f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_2_HORDE }, { 445.794f, 206.057f, 528.84f, 0.0f } },

    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 446.74f, 228.577f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 449.19f, 226.21f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 447.352f, 222.754f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 443.346f, 192.343f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 446.293f, 195.047f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 444.035f, 197.67f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_3_HORDE }, { 442.69f, 223.525f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_3_HORDE }, { 442.967f, 219.535f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_3_HORDE }, { 442.526f, 199.361f, 528.84f, 0.0f } },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_3_HORDE }, { 442.843f, 203.193f, 528.84f, 0.0f } },

    { { NPC_LORALEN, NPC_KALIRA }, { 438.505f, 211.54f, 528.71f, 0.0f } },
    { { NPC_KALIRA, NPC_LORALEN }, { 438.946f, 215.427f, 528.71f, 0.0f } },

    { { 0, 0 }, { 0.0f, 0.0f, 0.0f, 0.0f } }
};

/************
*** FIRST BOSS SCENE:
************/

enum eFBSTexts
{
    SAY_GENERAL_GARFROST                        = 21,
    SAY_TYRANNUS_GARFROST                       = 20,
};

const Position FBSSpawnPos = {695.685f, -118.825f, 513.877f, 3*M_PI/2};

struct FBSPosition
{
    uint32 entry;
    uint32 pathId;
};

const FBSPosition FBSData[] =
{
    { NPC_HORDE_SLAVE_1, PATH_BEGIN_VALUE+0 },
    { NPC_HORDE_SLAVE_1, PATH_BEGIN_VALUE+1 },
    { NPC_HORDE_SLAVE_2, PATH_BEGIN_VALUE+2 },
    { NPC_HORDE_SLAVE_2, PATH_BEGIN_VALUE+3 },
    { NPC_HORDE_SLAVE_2, PATH_BEGIN_VALUE+4 },
    { NPC_HORDE_SLAVE_3, PATH_BEGIN_VALUE+5 },
    { NPC_HORDE_SLAVE_3, PATH_BEGIN_VALUE+6 },
    { NPC_HORDE_SLAVE_4, PATH_BEGIN_VALUE+7 },
    { NPC_HORDE_SLAVE_4, PATH_BEGIN_VALUE+8 },
    { 0, 0 }
};

/************
*** SECOND BOSS SCENE:
************/

const Position KrickCenterPos = {836.65f, 115.08f, 510.0f, 0.0f};
const Position SBSTyrannusStartPos = {781.127f, 265.825f, 552.31f, 0.0f};
const Position SBSLeaderStartPos = {772.716f, 111.517f, 510.81f, 0.0f};
const Position SBSLeaderEndPos = {823.2f, -4.4497f, 509.49f, 0.86f};

enum eSBSTexts
{
    SAY_OUTRO_KRICK_1                           = 35,
    SAY_JAINA_KRICK_1                           = 36,
    SAY_SYLVANAS_KRICK_1                        = 37,
    SAY_OUTRO_KRICK_2                           = 38,
    SAY_JAINA_KRICK_2                           = 39,
    SAY_SYLVANAS_KRICK_2                        = 40,
    SAY_OUTRO_KRICK_3                           = 41,
    SAY_TYRANNUS_KRICK_1                        = 42,
    SAY_OUTRO_KRICK_4                           = 43,
    SAY_TYRANNUS_KRICK_2                        = 44,
    SAY_JAINA_KRICK_3                           = 45,
    SAY_SYLVANAS_KRICK_3                        = 46,
};

/************
*** PRE_TYRANNUS SCENES (WAVES OF TRASH):
************/

const Position PTSTyrannusWaitPos1 = {923.45f, 82.65f, 582.44f, 3.59f};
const Position PTSTyrannusWaitPos2 = {907.27f, -53.86f, 617.31f, 1.69f};
const Position PTSTyrannusWaitPos3 = {1117.93f, -125.16f, 760.34f, 0.10f};

enum ePTSTexts
{
    SAY_TYRANNUS_AMBUSH_1                       = 47,
    SAY_TYRANNUS_AMBUSH_2                       = 48,
    SAY_TYRANNUS_TRAP_TUNNEL                    = 49,
};

/************
*** TYRANNUS SCENE:
************/

const Position TSSpawnPos = {1069.49f, 88.99f, 631.5f, 2.0f};
const Position TSMidPos = {1051.475f, 126.56f, 628.157f, 2.02f};
const float TSHeight = 628.157f;
const Position TSLeaderSpawnPos = {1064.3761f, 99.10f, 631.0f, 2.1f};
const Position TSCenterPos = {990.48f, 165.37f, 628.157f, 5.7f};
const Position TSDistCheckPos = {1009.29f, 163.15f, 628.157f, 0.0f};
const Position TSSindragosaPos1 = {919.10f, 249.83f, 556.34f, 5.49f};
const Position TSSindragosaPos2 = {948.39f, 215.47f, 653.71f, 5.51f};

struct TSPosition
{
    uint32 entry;
    float x,y;
};

const TSPosition TSData[] =
{
    { NPC_FREED_SLAVE_3_HORDE, 1047.8f, 126.01f },
    { NPC_FREED_SLAVE_3_HORDE, 1049.21f, 127.10f },
    { NPC_FREED_SLAVE_3_HORDE, 1051.68f, 129.02f },
    { NPC_FREED_SLAVE_3_HORDE, 1053.24f, 130.23f },
    { NPC_FREED_SLAVE_1_HORDE, 1044.82f, 121.30f },
    { NPC_FREED_SLAVE_1_HORDE, 1049.33f, 124.01f },
    { NPC_FREED_SLAVE_1_HORDE, 1056.79f, 130.86f },
    { NPC_FREED_SLAVE_2_HORDE, 1045.56f, 118.46f },
    { NPC_FREED_SLAVE_2_HORDE, 1047.75f, 120.85f },
    { NPC_FREED_SLAVE_2_HORDE, 1052.93f, 124.156f },
    { NPC_FREED_SLAVE_2_HORDE, 1057.35f, 127.95f },
    { NPC_FREED_SLAVE_2_HORDE, 1059.18f, 129.86f },
    { NPC_FREED_SLAVE_2_HORDE, 1049.865f, 118.735f },
    { NPC_FREED_SLAVE_2_HORDE, 1052.32f, 121.827f },
    { NPC_FREED_SLAVE_2_HORDE, 1055.38f, 123.99f },
    { NPC_FREED_SLAVE_2_HORDE, 1058.723f, 125.98f },
    { 0, 0.0f, 0.0f }
};

enum eTSTexts
{
    SAY_PREFIGHT_1                              = 50,
    SAY_GENERAL_HORDE_TRASH                     = 51,
    SAY_PREFIGHT_2                              = 52,
    SAY_PREFIGHT_AGGRO                          = 53,

    SAY_GENERAL_HORDE_OUTRO_1                   = 61,
    SAY_GENERAL_OUTRO_2                         = 62,
    SAY_JAINA_OUTRO_1                           = 63,
    SAY_SYLVANAS_OUTRO_1                        = 64,
    SAY_JAINA_OUTRO_2                           = 65,
    SAY_JAINA_OUTRO_3                           = 66,
    SAY_SYLVANAS_OUTRO_2                        = 67,
    SAY_GENERAL_ALLIANCE_OUTRO_1                = 68,
    SAY_GENERAL_ALLIANCE_TRASH                  = 69,
};

#endif
