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

#ifndef DEF_TOC_H
#define DEF_TOC_H

#include "CreatureAIImpl.h"

#define DataHeader "TC"

#define TrialOfTheChampionScriptName "instance_trial_of_the_champion"

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

    NPC_JAEREN                                      = 35004, // Horde
    NPC_ARELAS                                      = 35005, // Alliance
    NPC_RISEN_JAEREN                                = 35545,
    NPC_RISEN_ARELAS                                = 35564,
    NPC_TIRION                                      = 33628, // Possibly wrong npc here, 34996 had already populated creature_text (from ToC25) that matches. Needs a sniff to confirm.

    /// @todo: Argent Raid Spectator - FX - Missing spawns for Toc5 (map 650), ToC25 probably matches positions, needs a sniff to confirm.
    // Horde
    NPC_SPECTATOR_HORDE                             = 34883,
    NPC_SPECTATOR_BELF                              = 34904,
    NPC_SPECTATOR_TAUREN                            = 34903,
    NPC_SPECTATOR_TROLL                             = 34902,
    NPC_SPECTATOR_ORC                               = 34901,
    NPC_SPECTATOR_UNDEAD                            = 34905,

    // Alliance
    NPC_SPECTATOR_ALLIANCE                          = 34887,
    NPC_SPECTATOR_DWARF                             = 34906,
    NPC_SPECTATOR_GNOME                             = 34910,
    NPC_SPECTATOR_HUMAN                             = 34900,
    NPC_SPECTATOR_NELF                              = 34909,
    NPC_SPECTATOR_DRAENEI                           = 34908,
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
    // Spectators
    SAY_SPECTATOR_CHEER                             = 0,

    // Announcers: Alliance Announcer - Arelas Brightstar && Horde Announcer - Jaeren Sunsworn
    SAY_EADRIC_INTRO_ANNOUNCER                      = 0,
    SAY_JAEREN_PALETRESS_INTRO                      = 1,
    SAY_GRAND_CHAMPIONS_INTRO_1                     = 2,
    SAY_GRAND_CHAMPIONS_INTRO_DAWNSINGER            = 3, // Boltspark
    SAY_GRAND_CHAMPIONS_INTRO_ZULTORE               = 4, // Jaelyne
    SAY_GRAND_CHAMPIONS_INTRO_SKULLCRUSHER          = 5, // Jacob
    SAY_GRAND_CHAMPIONS_INTRO_DEATHSTALKER          = 6, // Lana
    SAY_GRAND_CHAMPIONS_INTRO_WILDMANE              = 7, // Colosos
    SAY_KNIGHT_INTRO                                = 8,

    // Eadric
    SAY_EADRIC_INTRO                                = 0,
    SAY_EADRIC_AGGRO                                = 1,
    SAY_EADRIC_EMOTE_RADIANCE                       = 2,
    SAY_EADRIC_EMOTE_HAMMER_RIGHTEOUS               = 3,
    SAY_EADRIC_HAMMER_RIGHTEOUS                     = 4,
    SAY_EADRIC_KILL_PLAYER                          = 5, // "You! You need more practice." && "Nay, nay, and I say yet again nay! Not good enough."
    SAY_EADRIC_DEFEATED                             = 6,

    // Confessor Paletress
    SAY_PALETRESS_INTRO_1                            = 0,
    SAY_PALETRESS_INTRO_2                            = 1,
    SAY_PALETRESS_AGGRO                              = 2,
    SAY_PALETRESS_MEMORY_SUMMON                      = 3,
    SAY_PALETRESS_MEMORY_DEATH                       = 4,
    SAY_PALETRESS_KILL_PLAYER                        = 5, // "Take your rest. "&& "Be at ease."
    SAY_PALETRESS_DEFEATED                           = 6,

    // Tirion
    TEXT_WELCOME                                    = 21,
    TEXT_WELCOME_2                                  = 22,
    TEXT_BEGIN                                      = 23,
    TEXT_GRATZ_SLAIN_CHAMPIONS                      = 24,
    TEXT_YOU_MAY_BEGIN                              = 41,
    // Tirion - The Black Knight Interactions
    TEXT_BK_INTRO                                   = 31,
    TEXT_BK_MEANING                                 = 34,

    // The Black Knight
    SAY_BK_INTRO_1                                  = 0,
    SAY_BK_INTRO_2                                  = 1,
    SAY_BK_INTRO_3                                  = 2,
    SAY_BK_AGGRO                                    = 3,
    SAY_BK_PHASE_2                                  = 4, // Skeleton
    SAY_BK_PHASE_3                                  = 5, // Ghost
    SAY_BK_KILL_PLAYER                              = 6, // "Pathetic." && "A waste of flesh."
    SAY_BK_DEATH                                    = 7,
};

template <class AI, class T>
inline AI* GetTrialOfTheChampionAI(T* obj)
{
    return GetInstanceAI<AI>(obj, TrialOfTheChampionScriptName);
}

#endif
