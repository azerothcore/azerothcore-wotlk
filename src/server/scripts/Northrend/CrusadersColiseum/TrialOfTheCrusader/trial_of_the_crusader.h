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

enum TrialOfTheCrusaderBossIds
{
    // Boss IDs used by SetBossNumber/SetBossState, matching DungeonEncounter.dbc encounter indexes
    BOSS_NORTHREND_BEASTS  = 0,
    BOSS_JARAXXUS          = 1,
    BOSS_FACTION_CHAMPIONS = 2,
    BOSS_TWIN_VALKYR       = 3,
    BOSS_ANUBARAK          = 4,
    MAX_ENCOUNTERS
};

enum DataTypes
{
    TYPE_NONE = 0,
    TYPE_INSTANCE_PROGRESS,
    TYPE_ANNOUNCER_GOSSIP_SELECT,                   // Set by value from Barrett's SmartAI
    TYPE_FAILED,

    TYPE_GORMOK,
    TYPE_JORMUNGAR,
    TYPE_ICEHOWL,
    TYPE_FACTION_CHAMPIONS,
    TYPE_FACTION_CHAMPIONS_PLAYER_DIED,

    TYPE_FACTION_CHAMPIONS_START,
};

enum TrialOfTheCrusaderObjectData
{
    // Creatures
    DATA_BARRETT,
    DATA_TIRION,
    DATA_FIZZLEBANG,
    DATA_GARROSH,
    DATA_VARIAN,
    DATA_GORMOK,
    DATA_DREADSCALE,
    DATA_ACIDMAW,
    DATA_ICEHOWL,
    DATA_BEASTS_COMBAT_STALKER,
    DATA_JARAXXUS,
    DATA_LIGHTBANE,
    DATA_DARKBANE,
    DATA_LICH_KING,
    DATA_ANUBARAK,

    // GameObjects
    DATA_MAIN_GATE,
    DATA_ENTER_GATE,
    DATA_WEB_DOOR,
    DATA_FLOOR,
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
    EVENT_SUMMON_DREADSCALE,
    EVENT_SUMMON_ACIDMAW,
    EVENT_ACIDMAW_AND_DREADSCALE_ATTACK,
    EVENT_SCENE_006,
    EVENT_SUMMON_ICEHOWL,
    EVENT_ICEHOWL_ATTACK,
    EVENT_SCENE_BEASTS_DONE,
    EVENT_NORTHREND_BEASTS_ENRAGE,
    EVENT_SUMMON_BARRETT,

    EVENT_SCENE_101,
    EVENT_SCENE_102,
    EVENT_SCENE_103,
    EVENT_WILFRED_TALK_EMOTE,
    EVENT_WILFRED_STOP_TALK_EMOTE,
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
    NPC_BARRETT_BEASTS                              = 34816,
    NPC_BARRETT_BEASTS_HC                           = 35909,
    NPC_BARRETT_JARAXXUS                            = 35035,
    NPC_BARRETT_FACTION_CHAMPIONS                   = 35766,
    NPC_BARRETT_VALKYR                              = 35770,
    NPC_BARRETT_LICH_KING                           = 35771,
    NPC_TIRION                                      = 34996,
    NPC_GARROSH                                     = 34995,
    NPC_THRALL                                      = 34994,
    NPC_VARIAN                                      = 34990,
    NPC_PROUDMOORE                                  = 34992,
    NPC_ARGENT_MAGE                                 = 36097,

    NPC_FIZZLEBANG                                  = 35458,
    NPC_LICH_KING                                   = 35877,

    NPC_GORMOK                                      = 34796,
    NPC_SNOBOLD_VASSAL                              = 34800,
    NPC_DREADSCALE                                  = 34799,
    NPC_ACIDMAW                                     = 35144,
    NPC_ICEHOWL                                     = 34797,
    NPC_BEASTS_COMBAT_STALKER                       = 36549,
    NPC_JARAXXUS                                    = 34780,
    NPC_MISTRESS_OF_PAIN                            = 34826,

    NPC_PURPLE_GROUND                               = 35651,
    NPC_OPEN_PORTAL_TARGET                          = 17965,
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

    NPC_ZHAAGRYM                                    = 35465,
    NPC_CAT                                         = 35610,

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

enum TrialOfTheCrusaderTexts
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

Position const Locs[] =
{
    {563.8f, 216.1f, 395.1f, 3 * M_PI / 2},             // 0
    {563.93f, 178.37f, 394.49f, 3 * M_PI / 2},          // 1
    {575.74f, 171.5f, 394.75f, 3 * M_PI / 2},           // 2
    {549.93f, 171.5f, 394.75f, 3 * M_PI / 2},           // 3
    {563.672974f, 139.571f, 393.837006f, 3 * M_PI / 2}, // 4
    {577.347839f, 210.0f, 395.14f, 3 * M_PI / 2},       // 5
    {550.955933f, 210.0f, 395.14f, 3 * M_PI / 2},       // 6
    {573.5f, 180.5f, 395.14f, 0.0f},                    // 7
    {553.5f, 180.5f, 395.14f, 0.0f},                    // 8
    {585.5f, 170.0f, 395.14f, 0.0f},                    // 9
    {545.5f, 170.0f, 395.14f, 0.0f},                    // 10
    {563.833008f, 179.244995f, 394.5f, 3 * M_PI / 2},   // 11
    {563.547f, 141.613f, 393.908f, 0.0f},               // 12
    {586.060242f, 117.514809f, 394.314026f, 0.0f},      // 13 - Dark essence 1
    {541.602112f, 161.879837f, 394.587952f, 0.0f},      // 14 - Dark essence 2
    {541.021118f, 117.262932f, 395.314819f, 0.0f},      // 15 - Light essence 1
    {586.200562f, 162.145523f, 394.626129f, 0.0f},      // 16 - Light essence 2
    {785.90f, 133.42f, 142.612f, M_PI},                 // 17
    {665.04f, 139.25f, 142.2f, 0.0f},                   // 18
    {664.75f, 135.0f, 142.2f, 0.0f},                    // 19
    {563.6597f, 139.7569f, 399.2507f, 3 * M_PI / 2},    // 20
    {559.1528f, 90.55729f, 395.2734f, 5.078908f},       // 21 - Barrett
    {563.8941f, 137.3333f, 405.8467f, 0.0f},            // 22 - Beasts Combat Stalker
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
    LOC_OPEN_PORTAL_TARGET,
    LOC_BARRETT,
    LOC_BEASTS_COMBAT_STALKER,
};

enum BarrettMisc
{
    // Barrett's SmartAI handles it through SMART_EVENT_ACTION_DONE
    ACTION_BARRETT_LEAVE                            = 1,
};

enum TrialOfTheCrusaderActions
{
    // Sent by the instance to Gormok, the Twin Val'kyr and Anub'arak on a wipe
    ACTION_DESPAWN_SUMMONS                          = -1,
};

enum TrialOfTheCrusaderModels
{
    MODEL_INVISIBLE_STALKER                         = 11686,
};

Position const FactionChampionLoc[] =
{
    {514.231f, 105.569f, 418.234f, 0.0f},               // 0 - Horde Initial Pos 0
    {508.334f, 115.377f, 418.234f, 0.0f},               // 1 - Horde Initial Pos 1
    {506.454f, 126.291f, 418.234f, 0.0f},               // 2 - Horde Initial Pos 2
    {506.243f, 106.596f, 421.592f, 0.0f},               // 3 - Horde Initial Pos 3
    {499.885f, 117.717f, 421.557f, 0.0f},               // 4 - Horde Initial Pos 4

    {613.127f, 100.443f, 419.74f, 0.0f},                // 5 - Ally Initial Pos 0
    {621.126f, 128.042f, 418.231f, 0.0f},               // 6 - Ally Initial Pos 1
    {618.829f, 113.606f, 418.232f, 0.0f},               // 7 - Ally Initial Pos 2
    {625.845f, 112.914f, 421.575f, 0.0f},               // 8 - Ally Initial Pos 3
    {615.566f, 109.653f, 418.234f, 0.0f},               // 9 - Ally Initial Pos 4

    {535.469f, 113.012f, 394.55f, 0.0f},                // 10 - Final Pos 0
    {526.417f, 137.465f, 394.55f, 0.0f},                // 11 - Final Pos 1
    {528.108f, 111.057f, 394.55f, 0.0f},                // 12 - Final Pos 2
    {519.92f, 134.285f, 394.55f, 0.0f},                 // 13 - Final Pos 3
    {533.648f, 119.148f, 394.55f, 0.0f},                // 14 - Final Pos 4
    {531.399f, 125.63f, 394.55f, 0.0f},                 // 15 - Final Pos 5
    {528.958f, 131.47f, 394.55f, 0.0f},                 // 16 - Final Pos 6
    {526.309f, 116.667f, 394.55f, 0.0f},                // 17 - Final Pos 7
    {524.238f, 122.411f, 394.55f, 0.0f},                // 18 - Final Pos 8
    {521.901f, 128.488f, 394.55f, 0.0f},                // 19 - Final Pos 9
};

enum EventSpells
{
    SPELL_OPEN_PORTAL                               = 67864,
    SPELL_WILFRED_PORTAL                            = 68424,
    SPELL_JORMUNGAR_ACHIEV                          = 68523,
    SPELL_FACTION_CHAMPIONS_KILL_CREDIT             = 68184,
    SPELL_RESILIENCE_WILL_FIX_IT_CREDIT             = 68620,
    SPELL_TRAITOR_KING                              = 68186,
    SPELL_PORTAL_TO_DALARAN                         = 53142,
    SPELL_JARAXXUS_CHAINS                           = 67924,
};

enum TrialOfTheCrusaderAchievementCriteria
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

template <class AI, class T>
inline AI* GetTrialOfTheCrusaderAI(T* obj)
{
    return GetInstanceAI<AI>(obj, TrialOfTheCrusaderScriptName);
}

#define RegisterTrialOfTheCrusaderCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetTrialOfTheCrusaderAI)

#endif
