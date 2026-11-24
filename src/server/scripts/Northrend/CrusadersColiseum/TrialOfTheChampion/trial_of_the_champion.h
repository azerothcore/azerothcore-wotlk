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

enum DataTypes
{
    BOSS_GRAND_CHAMPIONS                            = 0,
    BOSS_ARGENT_CHALLENGE                           = 1,
    BOSS_BLACK_KNIGHT                               = 2,
    MAX_ENCOUNTER                                   = 3,

    DATA_INSTANCE_PROGRESS                          = 4,
    DATA_ANNOUNCER                                  = 5,
    DATA_ANNOUNCER_GOSSIP_SELECT                    = 6,
    DATA_GRAND_CHAMPION_REACHED_DEST                = 7,
    DATA_MOUNT_DIED                                 = 8,
    DATA_REACHED_NEW_MOUNT                          = 9,
    DATA_GRAND_CHAMPION_DIED                        = 10,
    DATA_ARGENT_SOLDIER_DEFEATED                    = 11,
    DATA_SKELETAL_GRYPHON_LANDED                    = 12,
    DATA_TEAMID_IN_INSTANCE                         = 13,
    DATA_PALETRESS                                  = 14,
    DATA_MEMORY_ENTRY                               = 15,
    DATA_ACHIEVEMENT_IVE_HAD_WORSE                  = 16,

    DATA_TIRION                                     = 17,
    DATA_BLACK_KNIGHT                               = 18,
    DATA_BLACK_KNIGHT_VEHICLE                       = 19,
};

enum DataTypesObjects
{
    DATA_MAIN_GATE                                  = 0,
    DATA_ENTER_GATE                                 = 1,
};

enum Progress
{
    INSTANCE_PROGRESS_INITIAL = 0,
    INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST = 1,
    INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_1 = 2,
    INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_2 = 3,
    INSTANCE_PROGRESS_CHAMPION_GROUP_DIED_3 = 4,
    INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED = 5,
    INSTANCE_PROGRESS_CHAMPIONS_DEAD = 6,
    INSTANCE_PROGRESS_ARGENT_SOLDIERS_DIED = 7,
    INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED = 8,
    INSTANCE_PROGRESS_FINISHED = 9,
};

enum Events
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

enum CreatureIds
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
    NPC_FOUNTAIN_OF_LIGHT                           = 35311,

    NPC_BLACK_KNIGHT                                = 35451,
    NPC_RISEN_CHAMPION                              = 35590,

    // Argent Challenge memories, one of them is summoned at random
    NPC_MEMORY_HOGGER                               = 34942,
    NPC_MEMORY_VANCLEEF                             = 35028,
    NPC_MEMORY_MUTANUS                              = 35029,
    NPC_MEMORY_HEROD                                = 35030,
    NPC_MEMORY_LUCIFRON                             = 35031,
    NPC_MEMORY_THUNDERAAN                           = 35032,
    NPC_MEMORY_CHROMAGGUS                           = 35033,
    NPC_MEMORY_HAKKAR                               = 35034,
    NPC_MEMORY_VEKNILASH                            = 35036,
    NPC_MEMORY_KALITHRESH                           = 35037,
    NPC_MEMORY_MALCHEZAAR                           = 35038,
    NPC_MEMORY_GRUUL                                = 35039,
    NPC_MEMORY_VASHJ                                = 35040,
    NPC_MEMORY_ARCHIMONDE                           = 35041,
    NPC_MEMORY_ILLIDAN                              = 35042,
    NPC_MEMORY_DELRISSA                             = 35043,
    NPC_MEMORY_ENTROPIUS                            = 35044,
    NPC_MEMORY_INGVAR                               = 35045,
    NPC_MEMORY_CYANIGOSA                            = 35046,
    NPC_MEMORY_ECK                                  = 35047,
    NPC_MEMORY_ONYXIA                               = 35048,
    NPC_MEMORY_HEIGAN                               = 35049,
    NPC_MEMORY_IGNIS                                = 35050,
    NPC_MEMORY_VEZAX                                = 35051,
    NPC_MEMORY_ALGALON                              = 35052,

    NPC_JAEREN                                      = 35004, // Horde
    NPC_ARELAS                                      = 35005, // Alliance
    NPC_RISEN_JAEREN                                = 35545,
    NPC_RISEN_ARELAS                                = 35564,
    // Possibly wrong npc here, 34996 had already populated creature_text
    // (from ToC25) that matches. Needs a sniff to confirm.
    NPC_TIRION                                      = 33628,

    /// @todo: Argent Raid Spectator - FX - Missing spawns for Toc5 (map 650), ToC25 probably matches
    /// positions, needs a sniff to confirm.
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

enum GameObjectIds
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

enum VehicleIds
{
    VEHICLE_ARGENT_WARHORSE                         = 35644,
    VEHICLE_ARGENT_BATTLEWORG                       = 36558,

    VEHICLE_BLACK_KNIGHT                            = 35491,
};

enum Texts
{
    // Spectators
    SAY_SPECTATOR_CHEER                             = 0,

    // Grand Champions
    SAY_TRAMPLED                                    = 0,

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
    // "You! You need more practice." && "Nay, nay, and I say yet again nay! Not good enough."
    SAY_EADRIC_KILL_PLAYER                          = 5,
    SAY_EADRIC_DEFEATED                             = 6,

    // Confessor Paletress
    SAY_PALETRESS_INTRO_1                           = 0,
    SAY_PALETRESS_INTRO_2                           = 1,
    SAY_PALETRESS_AGGRO                             = 2,
    SAY_PALETRESS_MEMORY_SUMMON                     = 3,
    SAY_PALETRESS_MEMORY_DEATH                      = 4,
    SAY_PALETRESS_KILL_PLAYER                       = 5, // "Take your rest. "&& "Be at ease."
    SAY_PALETRESS_DEFEATED                          = 6,

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

enum ArgentChallengeActions
{
    ACTION_MEMORY_DIED                              = 1,
    ACTION_DESPAWN_MEMORY                           = 2,
};

enum GrandChampionActions
{
    ACTION_DISMOUNT                                 = 1, // the champion leaves its mount for good
    ACTION_ENABLE_CHAMPION_ABILITIES                = 2, // the champion fights on foot with its class abilities
};

enum GrandChampionPoints
{
    POINT_CHAMPION_MOVE_MIDDLE                      = 4, // the mounted champions walk to the middle of the arena
    POINT_CHAMPION_MOVE_SIDE                        = 5, // the unmounted champions spread out to the sides
    POINT_CHAMPION_NEW_MOUNT                        = 7, // the champion walks to the mount it picks up
    POINT_CHAMPION_LEAVE_ARENA                      = 9, // the defeated champions walk out before despawning
};

enum BlackKnightActions
{
    ACTION_START_ENCOUNTER                          = 1, // the Black Knight starts his roleplay and his abilities
    ACTION_RESUME_ESCORT                            = 1, // the Skeletal Gryphon resumes its paused landing run
    ACTION_DESPAWN_SUMMONS                          = 2, // cleanup: the Black Knight drops the raised ghouls
};

enum SharedSpells
{
    SPELL_TRAMPLE_AURA                              = 67865, // also cast by the instance on the mounted champions
    SPELL_GRAND_CHAMPIONS_CREDIT                    = 68572, // credit marker, cast once when the champions are defeated
    // Death's Respite, applied to the announcer during the Black Knight scene
    SPELL_DEATH_RESPITE_ANNOUNCER                   = 68306,
};

template <class AI, class T>
inline AI* GetTrialOfTheChampionAI(T* obj)
{
    return GetInstanceAI<AI>(obj, TrialOfTheChampionScriptName);
}

#define RegisterTrialOfTheChampionCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetTrialOfTheChampionAI)

#endif
