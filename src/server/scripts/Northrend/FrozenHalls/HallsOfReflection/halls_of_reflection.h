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

#ifndef DEF_HALLS_OF_REFLECTION_H
#define DEF_HALLS_OF_REFLECTION_H

#include "CreatureAIImpl.h"
#include "Player.h"

#define DataHeader "HOR"

#define HallsOfReflectionScriptName "instance_halls_of_reflection"

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
    DATA_LK_BATTLE,// in progress
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

    // Wave mobs
    NPC_WAVE_PRIEST                               = 38175,
    NPC_WAVE_MAGE                                 = 38172,
    NPC_PHANTOM_HALLUCINATION                     = 38567, // Doesn't talk
    NPC_WAVE_MERCENARY                            = 38177,
    NPC_WAVE_FOOTMAN                              = 38173,
    NPC_WAVE_RIFLEMAN                             = 38176,

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
    // Part 1
    // Alliance
    SAY_JAINA_INTRO_1                             = 0,
    SAY_JAINA_INTRO_2                             = 1,
    SAY_JAINA_INTRO_3                             = 2,
    SAY_JAINA_INTRO_4                             = 3,
    SAY_UTHER_INTRO_A2_1                          = 0,
    SAY_JAINA_INTRO_5                             = 4,
    SAY_UTHER_INTRO_A2_2                          = 1,
    SAY_JAINA_INTRO_6                             = 5,
    SAY_UTHER_INTRO_A2_3                          = 2,
    SAY_JAINA_INTRO_7                             = 6,
    SAY_UTHER_INTRO_A2_4                          = 3,
    SAY_JAINA_INTRO_8                             = 7,
    SAY_UTHER_INTRO_A2_5                          = 4,
    SAY_JAINA_INTRO_9                             = 8,
    SAY_UTHER_INTRO_A2_6                          = 5,
    SAY_UTHER_INTRO_A2_7                          = 6,
    SAY_JAINA_INTRO_10                            = 9,
    SAY_UTHER_INTRO_A2_8                          = 7,
    SAY_JAINA_INTRO_11                            = 10,
    SAY_UTHER_INTRO_A2_9                          = 8,

    // Horde
    SAY_SYLVANAS_INTRO_1                          = 0,
    SAY_SYLVANAS_INTRO_2                          = 1,
    SAY_SYLVANAS_INTRO_3                          = 2,
    SAY_UTHER_INTRO_H2_1                          = 9,
    SAY_SYLVANAS_INTRO_4                          = 3,
    SAY_UTHER_INTRO_H2_2                          = 10,
    SAY_SYLVANAS_INTRO_5                          = 4,
    SAY_UTHER_INTRO_H2_3                          = 11,
    SAY_SYLVANAS_INTRO_6                          = 5,
    SAY_UTHER_INTRO_H2_4                          = 12,
    SAY_SYLVANAS_INTRO_7                          = 6,
    SAY_UTHER_INTRO_H2_5                          = 13,
    SAY_UTHER_INTRO_H2_6                          = 14,
    SAY_SYLVANAS_INTRO_8                          = 7,
    SAY_UTHER_INTRO_H2_7                          = 15,

    // The Lich King Event
    SAY_LK_INTRO_1                                = 0,
    SAY_LK_INTRO_2                                = 1,
    SAY_LK_INTRO_3                                = 2,
    SAY_FALRIC_INTRO_1                            = 5,
    SAY_MARWYN_INTRO_1                            = 5,
    SAY_FALRIC_INTRO_2                            = 6,

    SAY_JAINA_INTRO_END                           = 11,
    SAY_SYLVANAS_INTRO_END                        = 8,

    // Wave mobs
    SAY_WAVE_DEATH                                = 0,

    // Frostsworn General - Big add after Falrick and Marwyn
    SAY_FROSTSWORN_GENERAL_AGGRO                  = 0,
    SAY_FROSTSWORN_GENERAL_DEATH                  = 1,

    // Part 2
    // The Lich King Boss
    SAY_LK_AGGRO_ALLY                             = 0,
    SAY_LK_AGGRO_HORDE                            = 1,
    SAY_LK_IW_1                                   = 2,
    SAY_LK_IW_2                                   = 3,
    SAY_LK_IW_3                                   = 4,
    SAY_LK_IW_4                                   = 5,
    //SAY_LK_GHOUL                                = 6, // Unused
    //SAY_LK_ABON                                 = 7, // Unused
    SAY_LK_WINTER                                 = 8,
    SAY_LK_NOWHERE_TO_RUN                         = 9,

    // Horde
    SAY_SYLVANA_AGGRO                             = 0,
    SAY_SYLVANAS_IW_1                             = 1,
    SAY_SYLVANAS_IW_2                             = 2,
    SAY_SYLVANAS_IW_3                             = 3,
    SAY_SYLVANAS_IW_4                             = 4,
    SAY_SYLVANA_ESCAPE_01                         = 5,
    //SAY_SYLVANA_ESCAPE_02                       = 6, // Unused
    SAY_SYLVANA_TRAP                              = 7,
    SAY_SYLVANA_FINAL                             = 8,

    // (H) Ship Captain 30824
    SAY_FIRE_HORDE                                = 0,
    SAY_ONBOARD_HORDE                             = 1,

    // Alliance
    SAY_JAINA_AGGRO                               = 0,
    SAY_JAINA_IW_1                                = 1,
    SAY_JAINA_IW_2                                = 2,
    SAY_JAINA_IW_3                                = 3,
    SAY_JAINA_IW_4                                = 4,
    SAY_JAINA_ESCAPE_01                           = 5,
    SAY_JAINA_TRAP                                = 6,
    SAY_JAINA_FINAL_1                             = 7,
    SAY_JAINA_FINAL_2                             = 8,

    // (A) Ship Captain 30344
    SAY_FIRE_ALLY                                 = 0,
    SAY_ONBOARD_ALLY                              = 1,

    // Battered Hilt - Quest: The Halls Of Reflection
    // Uther
    SAY_BATTERED_HILT_HALT                        = 16,
    EMOTE_QUEL_SPAWN                              = 0, // "Quel'Delar leeps to life in the presence of Frostmourne!"
    SAY_BATTERED_HILT_REALIZE                     = 17,
    EMOTE_QUEL_PREPARE                            = 1, // "Quel'Delar prepares to attack!"
    SAY_BATTERED_HILT_OUTRO1                      = 18,
    SAY_BATTERED_HILT_OUTRO2                      = 19,
    SAY_BATTERED_HILT_OUTRO3                      = 20,
    SAY_BATTERED_HILT_OUTRO4                      = 21,

    // Marwin - Said when starting after a wipe
    EMOTE_MARWYN_INTRO_SPIRIT                     = 6,
    // Marwin - Wipe between wave 6 and 9
    SAY_MARWYN_WIPE_AFTER_FALRIC                  = 7,
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
    SPELL_UTHER_DESPAWN                           = 70693, //Sniffed
    SPELL_WELL_OF_SOULS_VISUAL                    = 72630,
    SPELL_SUMMON_SOULS                            = 72711, //Sniffed Sylvanas

    //Battle of LK
    SPELL_BLIDING_RETREAT                         = 70199, //Sniffed LK
    SPELL_SOUL_REAPER                             = 69410, //Sniffed LK
    SPELL_EVASION                                 = 70190, //Sniffed Sylvanas

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

    // Battered Hilt - Summon Quel'Delar
    SPELL_SUMMON_EVIL_QUEL                        = 69966,
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

const Position CenterPos             = {5309.459473f, 2006.478516f, 711.595459f, 0.0f};
const Position SpawnPos              = {5263.22412f, 1950.95544f, 707.695862f, 0.808736f}; // Jaina/Sylvanas Beginning Position
const Position LoralenMidleFollowPos = {5274.25634f, 1976.04760f, 707.694763f, 0.929097f}; // Sniffed
const Position LoralenFollowPos      = {5283.29296f, 1992.43078f, 707.694763f, 0.549238f}; // Sniffed
const Position LoralenFollowLk1      = {5292.94921f, 2008.25451f, 707.695801f, 1.047967f}; // Sniffed
const Position LoralenFollowLk2      = {5298.94335f, 2016.37097f, 707.695801f, 0.694538f}; // Sniffed
const Position LoralenFollowLk3      = {5336.94044f, 2040.21814f, 707.695801f, 0.439284f}; // Sniffed
const Position LoralenFollowLkFinal  = {5361.96777f, 2065.68310f, 707.693848f, 0.831989f}; // Sniffed
const Position LoralenDeadPos        = {5369.71289f, 2083.6330f, 707.695129f, 0.188739f}; // Sniffed
const Position MoveThronePos         = {5306.98535f, 1998.10302f, 709.341187f, 1.277278f}; // Jaina/Sylvanas walks to throne
const Position UtherSpawnPos         = {5308.310059f, 2003.857178f, 709.341431f, 4.650315f}; // Uther starting position
const Position LichKingSpawnPos      = {5362.917480f, 2062.307129f, 707.695374f, 3.945812f};
const Position LichKingMoveMidlelThronePos   = {5333.48437f, 2032.02648f, 707.695679f, 3.973301f}; // Lich King moves and hits Uther [sniff]
const Position LichKingMoveThronePos   = {5312.79638f, 2010.07141f, 709.3942183f, 3.973301f}; // Lich King walks to throne [sniff]
const Position LichKingMoveAwayPos   = {5400.069824f, 2102.7131689f, 707.69525f, 0.843803f}; // Lich King walks away [sniff]
const Position FalricMovePos         = {5284.161133f, 2030.691650f, 709.319336f, 5.489386f};
const Position MarwynMovePos         = {5335.330078f, 1982.376221f, 709.319580f, 2.339942f};
const Position LeaderEscapePos       = {5576.80566f, 2235.55004f, 733.012268f, 2.782125f}; //Sniff
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
    {   // Alliance stairs
        {5226.36f, 1640.87f, 785.737f, 5.56137f},
        {5213.76f, 1626.21f, 798.068f, 5.56534f}, /// @todo: Issue with the clipping on the top most part, probably needs a positional sniff.
        {0.0f, 0.0f, 0.0f, 0.0f}
    },
    {   // Horde stairs
        {5233.61f, 1607.48f, 796.5f, 5.77774f},
        {5223.32f, 1589.24f, 809.0f, 5.76989f},
        {5243.42f, 1624.8f, 784.361f, 5.76592f}
    }
};

template <class AI, class T>
inline AI* GetHallsOfReflectionAI(T* obj)
{
    return GetInstanceAI<AI>(obj, HallsOfReflectionScriptName);
}

#endif
