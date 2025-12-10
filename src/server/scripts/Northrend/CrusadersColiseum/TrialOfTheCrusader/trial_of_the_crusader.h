/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DEF_CRUSADER_H
#define DEF_CRUSADER_H

#include "CreatureAIImpl.h"
#include "GridNotifiers.h"

#define DataHeader "TCR"

#define TrialOfTheCrusaderScriptName "instance_trial_of_the_crusader"

enum DataTypes
{
    TYPE_NONE = 0,
    TYPE_INSTANCE_PROGRESS,
    TYPE_ANNOUNCER_GOSSIP_SELECT,
    TYPE_FAILED,

    TYPE_GORMOK,
    TYPE_JORMUNGAR,
    TYPE_DREADSCALE,
    TYPE_ACIDMAW,
    TYPE_ICEHOWL,
    TYPE_JARAXXUS,
    TYPE_FACTION_CHAMPIONS,
    TYPE_FACTION_CHAMPIONS_PLAYER_DIED,
    TYPE_VALKYR,
    TYPE_ANUBARAK,

    TYPE_FACTION_CHAMPIONS_START,
    TYPE_NORTHREND_BEASTS_ALL,
};

enum Progress
{
    INSTANCE_PROGRESS_INITIAL = 0,
    INSTANCE_PROGRESS_INTRO_DONE,
    INSTANCE_PROGRESS_BEASTS_DEAD,
    INSTANCE_PROGRESS_JARAXXUS_INTRO_DONE,
    INSTANCE_PROGRESS_JARAXXUS_DEAD,
    INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD = 6,
    INSTANCE_PROGRESS_VALKYR_DEAD = 8,
    INSTANCE_PROGRESS_ANUB_ARAK,
    INSTANCE_PROGRESS_DONE = 10,
};

enum Events
{
    EVENT_CHECK_PLAYERS = 1,
    EVENT_OPEN_GATE,
    EVENT_CLOSE_GATE,

    EVENT_SCENE_001,
    EVENT_SCENE_002,
    EVENT_SCENE_003,
    EVENT_SCENE_004,
    EVENT_SUMMON_GORMOK,
    EVENT_GORMOK_ATTACK,
    EVENT_SCENE_005,
    EVENT_SCENE_005_2,
    EVENT_SUMMON_ACIDMAW_AND_DREADSCALE,
    EVENT_ACIDMAW_AND_DREADSCALE_ATTACK,
    EVENT_SCENE_006,
    EVENT_SUMMON_ICEHOWL,
    EVENT_ICEHOWL_ATTACK,
    EVENT_SCENE_BEASTS_DONE,
    EVENT_NORTHREND_BEASTS_ENRAGE,

    EVENT_SCENE_101,
    EVENT_SCENE_102,
    EVENT_SCENE_103,
    EVENT_SCENE_104,
    EVENT_SUMMON_JARAXXUS,
    EVENT_SCENE_105,
    EVENT_SCENE_106,
    EVENT_SCENE_107,
    EVENT_SCENE_108,
    EVENT_SCENE_109,
    EVENT_JARAXXUS_ATTACK,
    EVENT_SCENE_110,
    EVENT_SCENE_111,
    EVENT_SCENE_112,
    EVENT_SCENE_113,

    EVENT_SCENE_201,
    EVENT_SCENE_202,
    EVENT_SCENE_203,
    EVENT_SCENE_204,
    EVENT_SCENE_205,
    EVENT_SUMMON_CHAMPIONS,
    EVENT_CHAMPIONS_ATTACK,
    EVENT_SCENE_FACTION_CHAMPIONS_DEAD,

    EVENT_SCENE_301,
    EVENT_SCENE_302,
    EVENT_SCENE_303,
    EVENT_SCENE_304,
    EVENT_VALKYRIES_ATTACK,
    EVENT_SCENE_VALKYR_DEAD,

    EVENT_SCENE_401,
    EVENT_SCENE_402,
    EVENT_SCENE_403,
    EVENT_SCENE_404,
    EVENT_SCENE_405,
    EVENT_SCENE_406,
    EVENT_SCENE_406_2,
    EVENT_SCENE_407,
    EVENT_SCENE_408,
    EVENT_SCENE_409,
    EVENT_SCENE_410,
    EVENT_SCENE_501,
    EVENT_SCENE_502,
};

enum NPCs
{
    NPC_BARRENT                                     = 34816,
    NPC_TIRION                                      = 34996,
    NPC_GARROSH                                     = 34995,
    NPC_THRALL                                      = 34994,
    NPC_VARIAN                                      = 34990,
    NPC_PROUDMOORE                                  = 34992,
    NPC_ARGENT_MAGE                                 = 36097,

    NPC_FIZZLEBANG                                  = 35458,
    NPC_LICH_KING                                   = 35877,

    NPC_GORMOK                                      = 34796,
    NPC_DREADSCALE                                  = 34799,
    NPC_ACIDMAW                                     = 35144,
    NPC_ICEHOWL                                     = 34797,
    NPC_JARAXXUS                                    = 34780,

    NPC_PURPLE_GROUND                               = 35651,
    NPC_WORLD_TRIGGER                               = 18721,

    NPC_ALLIANCE_DEATH_KNIGHT                       = 34461,
    NPC_ALLIANCE_DRUID_BALANCE                      = 34460,
    NPC_ALLIANCE_DRUID_RESTORATION                  = 34469,
    NPC_ALLIANCE_HUNTER                             = 34467,
    NPC_ALLIANCE_MAGE                               = 34468,
    NPC_ALLIANCE_PALADIN_HOLY                       = 34465,
    NPC_ALLIANCE_PALADIN_RETRIBUTION                = 34471,
    NPC_ALLIANCE_PRIEST_DISCIPLINE                  = 34466,
    NPC_ALLIANCE_PRIEST_SHADOW                      = 34473,
    NPC_ALLIANCE_ROGUE                              = 34472,
    NPC_ALLIANCE_SHAMAN_ENHANCEMENT                 = 34463,
    NPC_ALLIANCE_SHAMAN_RESTORATION                 = 34470,
    NPC_ALLIANCE_WARLOCK                            = 34474,
    NPC_ALLIANCE_WARRIOR                            = 34475,

    NPC_HORDE_DEATH_KNIGHT                          = 34458,
    NPC_HORDE_DRUID_BALANCE                         = 34451,
    NPC_HORDE_DRUID_RESTORATION                     = 34459,
    NPC_HORDE_HUNTER                                = 34448,
    NPC_HORDE_MAGE                                  = 34449,
    NPC_HORDE_PALADIN_HOLY                          = 34445,
    NPC_HORDE_PALADIN_RETRIBUTION                   = 34456,
    NPC_HORDE_PRIEST_DISCIPLINE                     = 34447,
    NPC_HORDE_PRIEST_SHADOW                         = 34441,
    NPC_HORDE_ROGUE                                 = 34454,
    NPC_HORDE_SHAMAN_ENHANCEMENT                    = 34455,
    NPC_HORDE_SHAMAN_RESTORATION                    = 34444,
    NPC_HORDE_WARLOCK                               = 34450,
    NPC_HORDE_WARRIOR                               = 34453,

    NPC_LIGHTBANE                                   = 34497,
    NPC_DARKBANE                                    = 34496,

    NPC_ANUBARAK                                    = 34564,
};

enum GOs
{
    GO_ARGENT_COLISEUM_FLOOR                        = 195527,
    GO_MAIN_GATE_DOOR                               = 195647,
    GO_WEB_DOOR                                     = 195485,
    GO_EAST_PORTCULLIS                              = 195648,
    GO_SOUTH_PORTCULLIS                             = 195649,
    GO_NORTH_PORTCULLIS                             = 195650,

    GO_CRUSADERS_CACHE_10                           = 195631,
    GO_CRUSADERS_CACHE_25                           = 195632,
    GO_CRUSADERS_CACHE_10_H                         = 195633,
    GO_CRUSADERS_CACHE_25_H                         = 195635,

    // Tribute Chest (heroic)
    GO_TRIBUTE_CHEST_10H_25                         = 195668, // 10man 01-24 attempts
    GO_TRIBUTE_CHEST_10H_45                         = 195667, // 10man 25-44 attempts
    GO_TRIBUTE_CHEST_10H_50                         = 195666, // 10man 45-49 attempts
    GO_TRIBUTE_CHEST_10H_99                         = 195665, // 10man 50 attempts
    GO_TRIBUTE_CHEST_25H_25                         = 195672, // 25man 01-24 attempts
    GO_TRIBUTE_CHEST_25H_45                         = 195671, // 25man 25-44 attempts
    GO_TRIBUTE_CHEST_25H_50                         = 195670, // 25man 45-49 attempts
    GO_TRIBUTE_CHEST_25H_99                         = 195669, // 25man 50 attempts
};

enum eTexts
{
    // Highlord Tirion Fordring - 34996
    SAY_STAGE_0_01            = 0,
    SAY_STAGE_0_02            = 1,
    SAY_STAGE_0_04            = 2,
    SAY_STAGE_0_05            = 3,
    SAY_STAGE_0_06            = 4,
    SAY_STAGE_0_WIPE          = 5,
    SAY_STAGE_1_01            = 6,
    SAY_STAGE_1_07            = 7,
    SAY_STAGE_1_08            = 8,
    SAY_STAGE_1_11            = 9,
    SAY_STAGE_2_01            = 10,
    SAY_STAGE_2_03            = 11,
    SAY_STAGE_2_06            = 12,
    SAY_STAGE_3_01            = 13,
    SAY_STAGE_3_02            = 14,
    SAY_STAGE_4_01            = 15,
    SAY_STAGE_4_03            = 16,

    // Varian Wrynn
    SAY_STAGE_0_03a           = 0,
    SAY_STAGE_1_10            = 1,
    SAY_STAGE_2_02a           = 2,
    SAY_STAGE_2_04a           = 3,
    SAY_STAGE_2_05a           = 4,
    SAY_STAGE_3_03a           = 5,
    SAY_VARIAN_KILL_HORDE_PLAYER_1 = 6,

    // Garrosh
    SAY_STAGE_0_03h           = 0,
    SAY_STAGE_1_09            = 1,
    SAY_STAGE_2_02h           = 2,
    SAY_STAGE_2_04h           = 3,
    SAY_STAGE_2_05h           = 4,
    SAY_STAGE_3_03h           = 5,
    SAY_GARROSH_KILL_ALLIANCE_PLAYER_1 = 6,

    // Wilfred Fizzlebang
    SAY_STAGE_1_02            = 0,
    SAY_STAGE_1_03            = 1,
    SAY_STAGE_1_04            = 2,
    SAY_STAGE_1_06            = 3,

    // Lord Jaraxxus
    SAY_STAGE_1_05            = 0,
    SAY_STAGE_1_06_1          = 9,

    //  The Lich King
    SAY_STAGE_4_02            = 0,
    SAY_STAGE_4_05            = 1,
    SAY_STAGE_4_04            = 2,

    // Highlord Tirion Fordring - 36095
    SAY_STAGE_4_06            = 17,
    SAY_STAGE_4_07            = 18,
};

const Position Locs[] =
{
    {563.8f, 216.1f, 395.1f, 3 * M_PI / 2},             // 0
    {563.93f, 178.37f, 394.49f, 3 * M_PI / 2},          // 1
    {575.74f, 171.5f, 394.75f, 3 * M_PI / 2},           // 2
    {549.93f, 171.5f, 394.75f, 3 * M_PI / 2},           // 3
    {563.672974f, 139.571f, 393.837006f, 3 * M_PI / 2}, // 4
    {577.347839f, 210.0f, 395.14f /*+ 6.0f*/, 3 * M_PI / 2},        // 5
    {550.955933f, 210.0f, 395.14f /*+ 6.0f*/, 3 * M_PI / 2},        // 6
    {573.5f, 180.5f, 395.14f /*+ 6.0f*/, 0},                        // 7
    {553.5f, 180.5f, 395.14f /*+ 6.0f*/, 0},                        // 8
    {585.5f, 170.0f, 395.14f /*+ 6.0f*/, 0},                        // 9
    {545.5f, 170.0f, 395.14f /*+ 6.0f*/, 0},                        // 10
    {563.833008f, 179.244995f, 394.5f, 3 * M_PI / 2},   // 11
    {563.547f, 141.613f, 393.908f, 0},                  // 12
    {586.060242f, 117.514809f, 394.314026f, 0},         // 13 - Dark essence 1
    {541.602112f, 161.879837f, 394.587952f, 0},         // 14 - Dark essence 2
    {541.021118f, 117.262932f, 395.314819f, 0},         // 15 - Light essence 1
    {586.200562f, 162.145523f, 394.626129f, 0},         // 16 - Light essence 2
    {785.90f, 133.42f, 142.612f, M_PI},                 // 17
    {665.04f, 139.25f, 142.2f, 0.0f},                   // 18
    {664.75f, 135.0f, 142.2f, 0.0f}
};

enum LocNames
{
    LOC_BEHIND_GATE = 0,
    LOC_GATE_FRONT,
    LOC_DREADSCALE,
    LOC_ACIDMAW,
    LOC_CENTER,
    LOC_VALKYR_RIGHT,
    LOC_VALKYR_LEFT,
    LOC_VALKYR_DEST_RIGHT,
    LOC_VALKYR_DEST_LEFT,
    LOC_VALKYR_DEST_2_RIGHT,
    LOC_VALKYR_DEST_2_LEFT,
    LOC_ARTHAS_PORTAL,
    LOC_ARTHAS,
    LOC_DARKESS_1,
    LOC_DARKESS_2,
    LOC_LIGHTESS_1,
    LOC_LIGHTESS_2,
    LOC_ANUB,
    LOC_TIRION_FINAL,
    LOC_MAGE,
};

const Position FactionChampionLoc[] =
{
    {514.231f, 105.569f, 418.234f, 0},                  // 0 - Horde Initial Pos 0
    {508.334f, 115.377f, 418.234f, 0},                  // 1 - Horde Initial Pos 1
    {506.454f, 126.291f, 418.234f, 0},                  // 2 - Horde Initial Pos 2
    {506.243f, 106.596f, 421.592f, 0},                  // 3 - Horde Initial Pos 3
    {499.885f, 117.717f, 421.557f, 0},                  // 4 - Horde Initial Pos 4

    {613.127f, 100.443f, 419.74f, 0},                   // 5 - Ally Initial Pos 0
    {621.126f, 128.042f, 418.231f, 0},                  // 6 - Ally Initial Pos 1
    {618.829f, 113.606f, 418.232f, 0},                  // 7 - Ally Initial Pos 2
    {625.845f, 112.914f, 421.575f, 0},                  // 8 - Ally Initial Pos 3
    {615.566f, 109.653f, 418.234f, 0},                  // 9 - Ally Initial Pos 4

    {535.469f, 113.012f, 394.55f, 0},                   // 10 - Final Pos 0
    {526.417f, 137.465f, 394.55f, 0},                   // 11 - Final Pos 1
    {528.108f, 111.057f, 394.55f, 0},                   // 12 - Final Pos 2
    {519.92f, 134.285f, 394.55f, 0},                    // 13 - Final Pos 3
    {533.648f, 119.148f, 394.55f, 0},                   // 14 - Final Pos 4
    {531.399f, 125.63f, 394.55f, 0},                    // 15 - Final Pos 5
    {528.958f, 131.47f, 394.55f, 0},                    // 16 - Final Pos 6
    {526.309f, 116.667f, 394.55f, 0},                   // 17 - Final Pos 7
    {524.238f, 122.411f, 394.55f, 0},                   // 18 - Final Pos 8
    {521.901f, 128.488f, 394.55f, 0},                   // 19 - Final Pos 9
};

enum EventSpells
{
    SPELL_WILFRED_PORTAL                            = 68424,
    SPELL_JORMUNGAR_ACHIEV                          = 68523,
    SPELL_FACTION_CHAMPIONS_KILL_CREDIT             = 68184,
    SPELL_RESILIENCE_WILL_FIX_IT_CREDIT             = 68620,
    SPELL_TRAITOR_KING                              = 68186,
    SPELL_PORTAL_TO_DALARAN                         = 53142,
};

enum eAchievementCriteria
{
    ACHIEV_CRITERIA_UPPER_BACK_PAIN_10_N                    = 11779,
    ACHIEV_CRITERIA_UPPER_BACK_PAIN_10_H                    = 11802,
    ACHIEV_CRITERIA_UPPER_BACK_PAIN_25_N                    = 11780,
    ACHIEV_CRITERIA_UPPER_BACK_PAIN_25_H                    = 11801,
    ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_10_N             = 11838,
    ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_10_H             = 11861,
    ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_25_N             = 11839,
    ACHIEV_CRITERIA_THREE_SIXTY_PAIN_SPIKE_25_H             = 11862,

    ACHIEV_CRITERIA_A_TRIBUTE_TO_SKILL_10_PLAYER            = 12344,
    ACHIEV_CRITERIA_A_TRIBUTE_TO_SKILL_25_PLAYER            = 12338,
    ACHIEV_CRITERIA_A_TRIBUTE_TO_MAD_SKILL_10_PLAYER        = 12347,
    ACHIEV_CRITERIA_A_TRIBUTE_TO_MAD_SKILL_25_PLAYER        = 12341,
    ACHIEV_CRITERIA_A_TRIBUTE_TO_INSANITY_10_PLAYER         = 12349,
    ACHIEV_CRITERIA_A_TRIBUTE_TO_INSANITY_25_PLAYER         = 12343,
    ACHIEV_CRITERIA_A_TRIBUTE_TO_IMMORTALITY_HORDE          = 12358,
    ACHIEV_CRITERIA_A_TRIBUTE_TO_IMMORTALITY_ALLIANCE       = 12359,
    ACHIEV_CRITERIA_A_TRIBUTE_TO_DEDICATED_INSANITY         = 12360,
    ACHIEV_CRITERIA_REALM_FIRST_GRAND_CRUSADER              = 12350,
};

const uint32 dIIc = 405;
const uint32 dedicatedInsanityItems[405] =
{
    47658, 47659, 47660, 47661, 47662, 47664, 47665, 47666, 47667, 47668, 47670, 47671, 47672, 47673, 47674, 47675, 47677, 47678, 47681, 47682, 47684, 47685, 47686, 47687, 47688, 47689, 47690, 47691, 47692, 47693,
    47694, 47695, 47696, 47697, 47698, 47699, 47701, 47702, 47704, 47705, 47706, 47707, 47708, 47709, 47710, 47712, 47713, 47714, 47715, 47716, 47729, 47730, 47731, 47732, 47733, 47734, 47735, 47753, 47754, 47755,
    47756, 47757, 47768, 47769, 47770, 47771, 47772, 47778, 47779, 47780, 47781, 47782, 47803, 47804, 47805, 47806, 47807, 47915, 47916, 47917, 47918, 47919, 47920, 47921, 47922, 47923, 47924, 47925, 47926, 47927,
    47928, 47929, 47930, 47931, 47932, 47933, 47934, 47935, 47937, 47938, 47939, 47940, 47941, 47942, 47943, 47944, 47945, 47946, 47947, 47948, 47949, 47950, 47951, 47952, 47953, 47954, 47955, 47956, 47957, 47958,
    47959, 47960, 47961, 47962, 47963, 47964, 47965, 47966, 47967, 47968, 47969, 47970, 47971, 47972, 47973, 47974, 47975, 47976, 47977, 47978, 47979, 47983, 47984, 47985, 47986, 47987, 47988, 47989, 47990, 47991,
    47992, 47993, 47994, 47995, 47996, 47997, 47998, 47999, 48000, 48001, 48002, 48003, 48004, 48005, 48006, 48007, 48008, 48009, 48010, 48011, 48012, 48013, 48014, 48015, 48016, 48017, 48018, 48019, 48020, 48021,
    48022, 48023, 48024, 48025, 48026, 48027, 48028, 48030, 48032, 48034, 48036, 48038, 48039, 48040, 48041, 48042, 48043, 48044, 48045, 48046, 48047, 48048, 48049, 48050, 48051, 48052, 48053, 48054, 48055, 48056,
    48062, 48063, 48064, 48065, 48066, 48077, 48078, 48079, 48080, 48081, 48092, 48093, 48094, 48095, 48096, 48133, 48134, 48135, 48136, 48137, 48148, 48149, 48150, 48151, 48152, 48163, 48164, 48165, 48166, 48167,
    48178, 48179, 48180, 48181, 48182, 48193, 48194, 48195, 48196, 48197, 48208, 48209, 48210, 48211, 48212, 48223, 48224, 48225, 48226, 48227, 48238, 48239, 48240, 48241, 48242, 48255, 48256, 48257, 48258, 48259,
    48270, 48271, 48272, 48273, 48274, 48285, 48286, 48287, 48288, 48289, 48300, 48301, 48302, 48303, 48304, 48316, 48317, 48318, 48319, 48320, 48331, 48332, 48333, 48334, 48335, 48346, 48347, 48348, 48349, 48350,
    48361, 48362, 48363, 48364, 48365, 48376, 48377, 48378, 48379, 48380, 48391, 48392, 48393, 48394, 48395, 48430, 48446, 48450, 48452, 48454, 48461, 48462, 48463, 48464, 48465, 48481, 48482, 48483, 48484, 48485,
    48496, 48497, 48498, 48499, 48500, 48538, 48539, 48540, 48541, 48542, 48553, 48554, 48555, 48556, 48557, 48575, 48576, 48577, 48578, 48579, 48590, 48591, 48592, 48593, 48594, 48607, 48608, 48609, 48610, 48611,
    48622, 48623, 48624, 48625, 48626, 48637, 48638, 48639, 48640, 48641, 48657, 48658, 48659, 48660, 48661, 48666, 48667, 48668, 48669, 48670, 48671, 48672, 48673, 48674, 48675, 48693, 48695, 48697, 48699, 48701,
    48703, 48705, 48708, 48709, 48710, 48711, 48712, 48713, 48714, 48722, 48724, 49233, 49234, 49237, 49238
};

template <class AI, class T>
inline AI* GetTrialOfTheCrusaderAI(T* obj)
{
    return GetInstanceAI<AI>(obj, TrialOfTheCrusaderScriptName);
}

#endif
