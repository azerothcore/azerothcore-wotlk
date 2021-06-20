/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_HALLS_OF_REFLECTION_H
#define DEF_HALLS_OF_REFLECTION_H

#include "Player.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "ScriptedCreature.h"
#include "PassiveAI.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "ScriptMgr.h"

enum Data
{
    DATA_INTRO,
    DATA_FALRIC,
    DATA_MARWYN,
    DATA_FROSTSWORN_GENERAL,
    DATA_LK_INTRO,
    DATA_LICH_KING,
    DATA_BATTERED_HILT,
    MAX_ENCOUNTER,
    ACTION_SHOW_TRASH,
    ACTION_SPIRITUAL_REFLECTIONS_COPY,
    ACTION_SPIRITUAL_REFLECTIONS_ACTIVATE,
    ACTION_SPIRITUAL_REFLECTIONS_HIDE,
    ACTION_START_LK_FIGHT,
    ACTION_STOP_LK_FIGHT,
    ACTION_DELETE_ICE_WALL,
    DATA_WAVE_NUMBER,
};

enum Creatures
{
    NPC_FALRIC                                    = 38112,
    NPC_MARWYN                                    = 38113,
    NPC_LICH_KING_EVENT                           = 37226,
    NPC_LICH_KING_BOSS                            = 36954,

    NPC_UTHER                                     = 37225,
    NPC_JAINA_PART1                               = 37221,
    NPC_JAINA_PART2                               = 36955,
    NPC_SYLVANAS_PART1                            = 37223,
    NPC_SYLVANAS_PART2                            = 37554,

    NPC_DARK_RANGER_LORALEN                       = 37779,
    NPC_ARCHMAGE_KORELN                           = 37582,

    NPC_WAVE_MERCENARY                            = 38177,
    NPC_WAVE_FOOTMAN                              = 38173,
    NPC_WAVE_RIFLEMAN                             = 38176,
    NPC_WAVE_PRIEST                               = 38175,
    NPC_WAVE_MAGE                                 = 38172,
    NPC_PHANTOM_HALLUCINATION                     = 38567,

    NPC_FROSTSWORN_GENERAL                        = 36723,
    NPC_SPIRITUAL_REFLECTION                      = 37068,
    NPC_ICE_WALL_TARGET                           = 37014,
    NPC_WRATH_OF_THE_LICH_KING_CREDIT             = 38211,
    NPC_HIGH_CAPTAIN_JUSTIN_BARLETT               = 30344,
    NPC_SKY_REAVER_KORM_BLACKSKAR                 = 30824,
    NPC_ALTAR_BUNNY                               = 37704,
    NPC_QUEL_DELAR                                = 37158,
};

enum GameObjects
{
    GO_FROSTMOURNE                                = 202302,
    GO_FROSTMOURNE_ALTAR                          = 202236,
    GO_FRONT_DOOR                                 = 201976,
    GO_ARTHAS_DOOR                                = 197341,
    GO_CAVE_IN                                    = 201596,
    GO_DOOR_BEFORE_THRONE                         = 197342,
    GO_DOOR_AFTER_THRONE                          = 197343,
    GO_ICE_WALL                                   = 201385,
    GO_THE_SKYBREAKER                             = 201598,
    GO_ORGRIMS_HAMMER                             = 201599,
    GO_STAIRS_ALLIANCE                            = 201709,
    GO_STAIRS_HORDE                               = 202211,
    GO_CHEST_NORMAL                               = 201710,
    GO_CHEST_HEROIC                               = 202336,
    GO_PORTAL_TO_DALARAN                          = 195682,
};

enum HorWorldStates
{
    WORLD_STATE_HOR_COUNTER                         = 4884,
    WORLD_STATE_HOR_WAVE_COUNT                      = 4882,
};

enum BatteredHiltStatusFlags
{
    BHSF_NONE = 0,
    BHSF_STARTED = 1,
    BHSF_THROWN = 2,
    BHSF_FINISHED = 4,
};

#define NUM_OF_TRASH 34
#define MAX_DIST_FROM_CENTER_IN_COMBAT 70.5f
#define MAX_DIST_FROM_CENTER_TO_START 40.0f

enum hYells
{
    SAY_JAINA_INTRO_1                             = 1,
    SAY_JAINA_INTRO_2                             = 2,
    SAY_JAINA_INTRO_3                             = 3,
    SAY_JAINA_INTRO_4                             = 4,
    SAY_UTHER_INTRO_A2_1                          = 5,
    SAY_JAINA_INTRO_5                             = 6,
    SAY_UTHER_INTRO_A2_2                          = 7,
    SAY_JAINA_INTRO_6                             = 8,
    SAY_UTHER_INTRO_A2_3                          = 9,
    SAY_JAINA_INTRO_7                             = 10,
    SAY_UTHER_INTRO_A2_4                          = 11,
    SAY_JAINA_INTRO_8                             = 12,
    SAY_UTHER_INTRO_A2_5                          = 13,
    SAY_JAINA_INTRO_9                             = 14,
    SAY_UTHER_INTRO_A2_6                          = 15,
    SAY_UTHER_INTRO_A2_7                          = 16,
    SAY_JAINA_INTRO_10                            = 17,
    SAY_UTHER_INTRO_A2_8                          = 18,
    SAY_JAINA_INTRO_11                            = 19,
    SAY_UTHER_INTRO_A2_9                          = 20,

    SAY_SYLVANAS_INTRO_1                          = 21,
    SAY_SYLVANAS_INTRO_2                          = 22,
    SAY_SYLVANAS_INTRO_3                          = 23,
    SAY_UTHER_INTRO_H2_1                          = 24,
    SAY_SYLVANAS_INTRO_4                          = 25,
    SAY_UTHER_INTRO_H2_2                          = 26,
    SAY_SYLVANAS_INTRO_5                          = 27,
    SAY_UTHER_INTRO_H2_3                          = 28,
    SAY_SYLVANAS_INTRO_6                          = 29,
    SAY_UTHER_INTRO_H2_4                          = 30,
    SAY_SYLVANAS_INTRO_7                          = 31,
    SAY_UTHER_INTRO_H2_5                          = 32,
    SAY_UTHER_INTRO_H2_6                          = 33,
    SAY_SYLVANAS_INTRO_8                          = 34,
    SAY_UTHER_INTRO_H2_7                          = 35,

    SAY_LK_INTRO_1                                = 36,
    SAY_LK_INTRO_2                                = 37,
    SAY_LK_INTRO_3                                = 38,
    SAY_FALRIC_INTRO_1                            = 39,
    SAY_MARWYN_INTRO_1                            = 40,
    SAY_FALRIC_INTRO_2                            = 41,

    SAY_JAINA_INTRO_END                           = 42,
    SAY_SYLVANAS_INTRO_END                        = 43,

    SAY_FROSTSWORN_GENERAL_AGGRO                  = 98,
    SAY_FROSTSWORN_GENERAL_DEATH                  = 99,

    SAY_LK_AGGRO_HORDE                            = 100,
    SAY_LK_AGGRO_ALLY                             = 101,
    SAY_SYLVANAS_LEAVE                            = 102,
    SAY_JAINA_LEAVE                               = 103,
    SAY_LK_IW_1                                   = 104,
    SAY_LK_IW_2                                   = 105,
    SAY_LK_IW_3                                   = 106,
    SAY_LK_IW_4                                   = 107,
    SAY_LK_IW_1_SUMMON                            = 108,
    SAY_SYLVANAS_IW_1                             = 109,
    SAY_SYLVANAS_IW_2                             = 110,
    SAY_SYLVANAS_IW_3                             = 111,
    SAY_SYLVANAS_IW_4                             = 112,
    SAY_SYLVANAS_OPENING                          = 113,
    SAY_SYLVANAS_END                              = 114,
    SAY_LK_NOWHERE_TO_RUN                         = 115,
    SAY_FIRE_HORDE                                = 116,
    SAY_ONBOARD_HORDE                             = 117,
    SAY_FINAL_HORDE                               = 118,
    SAY_JAINA_IW_1                                = 119,
    SAY_JAINA_IW_2                                = 120,
    SAY_JAINA_IW_3                                = 121,
    SAY_JAINA_IW_4                                = 122,
    SAY_JAINA_OPENING                             = 123,
    SAY_JAINA_END                                 = 124,
    SAY_FIRE_ALLY                                 = 125,
    SAY_ONBOARD_ALLY                              = 126,
    SAY_FINAL_ALLY                                = 127,
    SAY_FINAL_ALLY_SECOND                         = 128,

    SAY_BATTERED_HILT_HALT                        = 200,
    SAY_BATTERED_HILT_LEAP                        = 201,
    SAY_BATTERED_HILT_REALIZE                     = 202,
    SAY_BATTERED_HILT_PREPARE                     = 203,
    SAY_BATTERED_HILT_OUTRO1                      = 204,
    SAY_BATTERED_HILT_OUTRO2                      = 205,
    SAY_BATTERED_HILT_OUTRO3                      = 206,
    SAY_BATTERED_HILT_OUTRO4                      = 207,
};

enum hMisc
{
    ACTION_START_INTRO,
    ACTION_SKIP_INTRO,
    ACTION_START_LK_FIGHT_REAL,
    ACTION_INFORM_TRASH_DIED,
    ACTION_CHECK_TRASH_DIED,
    ACTION_INFORM_WALL_DESTROYED,

    QUEST_DELIVRANCE_FROM_THE_PIT_A2              = 24710,
    QUEST_DELIVRANCE_FROM_THE_PIT_H2              = 24712,
    QUEST_WRATH_OF_THE_LICH_KING_A2               = 24500,
    QUEST_WRATH_OF_THE_LICH_KING_H2               = 24802,
    ACHIEV_RETREATING_TIMED_EVENT                 = 22615,

    SPELL_FROSTMOURNE_SPAWN_SOUND                 = 70667,
    SPELL_FROSTMOURNE_EQUIP                       = 72729,
    SPELL_HOR_START_QUEST_ALLY                    = 71351,
    SPELL_HOR_START_QUEST_HORDE                   = 71542,
    SPELL_SHADOWMOURNE_VISUAL                     = 72523,
    SPELL_ARCANE_CAST_VISUAL                      = 65633,
    SPELL_WELL_OF_SOULS_VISUAL                    = 72630,

    // Frostsworn General
    EVENT_ACTIVATE_REFLECTIONS                    = 1,
    EVENT_THROW_SHIELD                            = 2,
    EVENT_BALEFUL_STRIKE                          = 3,
    SPELL_THROW_SHIELD                            = 69222,
    SPELL_SUMMON_REFLECTIONS_DUMMY                = 69223,
    SPELL_HOR_CLONE                               = 69828,
    SPELL_HOR_CLONE_NAME                          = 69837,
    SPELL_BALEFUL_STRIKE                          = 69933,
    SPELL_SPIRIT_BURST                            = 69900,
    SPELL_JAINA_ICE_BARRIER                       = 69787,
    SPELL_SYLVANAS_CLOAK_OF_DARKNESS              = 70188,
    SPELL_JAINA_ICE_PRISON                        = 69708,
    SPELL_SYLVANAS_DARK_BINDING                   = 70194,
    SPELL_REMORSELESS_WINTER                      = 69780,
    SPELL_LICH_KING_ZAP_PLAYER                    = 70653,
    SPELL_DESTROY_WALL_JAINA                      = 69784,
    SPELL_DESTROY_WALL_SYLVANAS                   = 70224,
    SPELL_SUMMON_ICE_WALL                         = 69768,
    SPELL_FURY_OF_FROSTMOURNE                     = 70063,
    SPELL_HARVEST_SOUL                            = 70070,
    SPELL_HOR_SUICIDE                             = 69908,
    SPELL_SUMMON_RAGING_GHOULS                    = 69818,
    SPELL_SUMMON_RISEN_WITCH_DOCTOR               = 69836,
    SPELL_SUMMON_LUMBERING_ABOMINATION            = 69835,
    SPELL_GUNSHIP_CANNON_FIRE_PERIODIC            = 70017,
    SPELL_ACHIEVEMENT_CHECK                       = 72830,
};

const uint32 allowedCompositions[8][5] =
{
    {NPC_WAVE_MERCENARY, NPC_WAVE_PRIEST, NPC_WAVE_RIFLEMAN, 0, 0},
    {NPC_WAVE_MAGE, NPC_WAVE_RIFLEMAN, NPC_WAVE_FOOTMAN, 0, 0},
    {NPC_WAVE_MERCENARY, NPC_WAVE_PRIEST, NPC_WAVE_FOOTMAN, NPC_WAVE_FOOTMAN, 0},
    {NPC_WAVE_MAGE, NPC_WAVE_PRIEST, NPC_WAVE_FOOTMAN, NPC_WAVE_FOOTMAN, 0},
    {NPC_WAVE_MERCENARY, NPC_WAVE_MAGE, NPC_WAVE_RIFLEMAN, NPC_WAVE_FOOTMAN, NPC_WAVE_FOOTMAN},
    {NPC_WAVE_MERCENARY, NPC_WAVE_MAGE, NPC_WAVE_PRIEST, NPC_WAVE_RIFLEMAN, NPC_WAVE_RIFLEMAN},
    {NPC_WAVE_MERCENARY, NPC_WAVE_MAGE, NPC_WAVE_PRIEST, NPC_WAVE_RIFLEMAN, NPC_WAVE_FOOTMAN},
    {NPC_WAVE_MERCENARY, NPC_WAVE_MAGE, NPC_WAVE_PRIEST, NPC_WAVE_FOOTMAN, NPC_WAVE_FOOTMAN}
};

const Position CenterPos = {5309.459473f, 2006.478516f, 711.595459f, 0.0f};
const Position SpawnPos              = {5262.540527f, 1949.693726f, 707.695007f, 0.808736f}; // Jaina/Sylvanas Beginning Position
const Position LoralenFollowPos      = {5283.234863f, 1990.946777f, 707.695679f, 0.929097f};
const Position MoveThronePos         = {5306.952148f, 1998.499023f, 709.341431f, 1.277278f}; // Jaina/Sylvanas walks to throne
const Position UtherSpawnPos         = {5308.310059f, 2003.857178f, 709.341431f, 4.650315f};
const Position LichKingSpawnPos      = {5362.917480f, 2062.307129f, 707.695374f, 3.945812f};
const Position LichKingMoveThronePos = {5312.080566f, 2009.172119f, 709.341431f, 3.973301f}; // Lich King walks to throne
const Position LichKingMoveAwayPos   = {5400.069824f, 2102.7131689f, 707.69525f, 0.843803f}; // Lich King walks away
const Position FalricMovePos         = {5284.161133f, 2030.691650f, 709.319336f, 5.489386f};
const Position MarwynMovePos         = {5335.330078f, 1982.376221f, 709.319580f, 2.339942f};
const Position SylvanasFightPos      = {5557.508301f, 2263.920654f, 733.011230f, 3.624075f};
const Position LeaderEscapePos       = {5577.654785f, 2235.347412f, 733.011230f, 2.359576f};
const Position ShipMasterSummonPos   = {5262.773926f, 1669.980103f, 715.000000f, 0.000000f};
const Position WalkCaveInPos         = {5267.594238f, 1678.750000f, 784.302856f, 1.041739f};
const Position AllyPortalPos         = {5205.015625f, 1605.680298f, 806.444458f, 0.884375f};
const Position AllyChestPos          = {5194.341797f, 1611.271484f, 806.408569f, 0.907936f};
const Position HordePortalPos        = {5222.733887f, 1568.052124f, 819.590881f, 1.198878f};
const Position HordeChestPos         = {5215.394531f, 1569.726074f, 819.149048f, 1.151754f};

#define PATH_WP_COUNT 19
const uint8 WP_STOP[6] = {0, 5, 8, 10, 14, 18};

const Position PathWaypoints[PATH_WP_COUNT] =
{
    {5588.055664f, 2229.327393f, 733.011353f, 5.440755f},
    {5605.567383f, 2203.448486f, 731.304626f, 5.059827f},
    {5607.415039f, 2189.225098f, 731.022217f, 4.203760f},
    {5598.958984f, 2169.660156f, 730.919800f, 4.093812f},
    {5586.018066f, 2149.685303f, 731.090759f, 4.093815f},
    {5558.182617f, 2103.950928f, 731.263000f, 4.239113f}, // Leader Ice Wall 1
    {5534.202637f, 2054.254150f, 731.131165f, 4.360846f},
    {5526.244629f, 2023.878540f, 732.408264f, 4.419744f},
    {5513.573242f, 1996.611206f, 735.115723f, 4.239110f}, // Leader Ice Wall 2
    {5478.590820f, 1938.773315f, 741.926697f, 4.168423f},
    {5456.632324f, 1902.801025f, 747.220886f, 4.058471f}, // Leader Ice Wall 3
    {5423.630371f, 1858.672363f, 754.901367f, 4.078105f},
    {5402.314453f, 1829.705811f, 758.029907f, 3.932807f},
    {5374.380371f, 1802.807007f, 760.831238f, 3.897464f},
    {5340.560059f, 1772.791016f, 766.478149f, 3.760019f}, // Leader Ice Wall 4
    {5318.707031f, 1750.379395f, 771.635132f, 3.944588f},
    {5297.951660f, 1725.419067f, 778.211548f, 4.121302f},
    {5279.251953f, 1697.474365f, 785.700256f, 4.152715f},
    {5262.773926f, 1669.980103f, 784.301697f, 1.015049f}
};

const Position CannonFirePos[2][3] =
{
    {
        {5231.177734f, 1617.087280f, 813.603755f, 0.990318f},
        {5222.555664f, 1623.302490f, 813.603755f, 0.868589f},
        {5203.667480f, 1630.986694f, 813.603755f, 0.790045f}
    },
    {
        {5233.234863f, 1572.758789f, 816.572266f, 1.202728f},
        {5220.500488f, 1577.656860f, 816.572266f, 1.128118f},
        {5209.669922f, 1584.753784f, 816.572266f, 0.982819f}
    }
};

const Position StairsPos[2][3] = 
{
    {
        {5226.36f, 1640.87f, 785.737f, 5.56137f},
        {5213.76f, 1626.21f, 798.068f, 5.56534f},
        {0.0f, 0.0f, 0.0f, 0.0f}
    },
    {
        {5233.61f, 1607.48f, 796.5f, 5.77774f},
        {5223.32f, 1589.24f, 809.0f, 5.76989f},
        {5243.42f, 1624.8f, 784.361f, 5.76592f}
    }
};

#endif
