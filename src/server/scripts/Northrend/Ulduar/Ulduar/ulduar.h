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

#ifndef DEF_ULDUAR_H
#define DEF_ULDUAR_H

#include "CreatureAIImpl.h"
#include "Position.h"

#define DataHeader "UU"

#define UlduarScriptName "instance_ulduar"

enum UlduarBossIds
{
    // Boss IDs used by SetBossNumber/SetBossState, matching DungeonEncounter.dbc encounter indexes
    BOSS_LEVIATHAN                          = 0,
    BOSS_IGNIS                              = 1,
    BOSS_RAZORSCALE                         = 2,
    BOSS_XT002                              = 3,
    BOSS_ASSEMBLY                           = 4,
    BOSS_KOLOGARN                           = 5,
    BOSS_AURIAYA                            = 6,
    BOSS_HODIR                              = 7,
    BOSS_THORIM                             = 8,
    BOSS_FREYA                              = 9,
    BOSS_MIMIRON                            = 10,
    BOSS_VEZAX                              = 11,
    BOSS_YOGGSARON                          = 12,
    BOSS_ALGALON                            = 13,
    MAX_ENCOUNTER                           = 14
};

enum UlduarData
{
    // Hodir hard mode
    DATA_HODIR_HM_FAIL                      = 15,
    DATA_HODIR_HM_RESET                     = 17,

    // Assembly of Iron
    DATA_STEELBREAKER                       = 20,
    DATA_MOLGEIM                            = 21,
    DATA_BRUNDIR                            = 22,

    // Flame Leviathan
    DATA_VEHICLE_SPAWN                      = 100,
    DATA_LIGHTNING_WALL1                    = 101,
    DATA_LIGHTNING_WALL2                    = 102,
    DATA_REPAIR_STATION1                    = 103,
    DATA_REPAIR_STATION2                    = 104,
    DATA_LEVIATHAN_DOORS                    = 106,
    DATA_LEVIATHAN_VEHICLES_USABLE          = 107,

    // Mimiron creatures
    DATA_MIMIRON_LEVIATHAN_MKII             = 301,
    DATA_MIMIRON_VX001                      = 302,
    DATA_MIMIRON_ACU                        = 303,
    DATA_MIMIRON_DB_TARGET                  = 304,

    // Mimiron doors
    DATA_GO_MIMIRON_DOOR_1                  = 311,
    DATA_GO_MIMIRON_DOOR_2                  = 312,
    DATA_GO_MIMIRON_DOOR_3                  = 313,

    // Mimiron tram
    DATA_MIMIRON_TRAM                       = 320,
    DATA_MIMIRON_ACTIVATE_TRAM              = 321,
    DATA_MIMIRON_TRAM_ROCKET_BOOSTER        = 322,
    DATA_MIMIRON_CALL_TRAM_CENTER           = 323,
    DATA_MIMIRON_CALL_TRAM_MIMIRON          = 324,
    DATA_MIMIRON_TRAM_TURNAROUND_1          = 325,
    DATA_MIMIRON_TRAM_TURNAROUND_2          = 326,

    // XT-002
    DATA_XT002_DOORS                        = 400,
    DATA_XT002_HEART                        = 401,

    // Thorim
    DATA_THORIM_LEVER_GATE                  = 500,
    DATA_THORIM_LEVER                       = 501,
    DATA_THORIM_FENCE                       = 502,
    DATA_THORIM_FIRST_DOORS                 = 503,
    DATA_THORIM_SECOND_DOORS                = 504,

    // Algalon the Observer
    DATA_ALGALON_SUMMON_STATE               = 600,
    DATA_DESPAWN_ALGALON                    = 601,
    DATA_ALGALON_DEFEATED                   = 602,
    DATA_SIGILDOOR_01                       = 603,
    DATA_SIGILDOOR_02                       = 604,
    DATA_SIGILDOOR_03                       = 605,
    DATA_UNIVERSE_FLOOR_01                  = 606,
    DATA_UNIVERSE_FLOOR_02                  = 607,
    DATA_UNIVERSE_GLOBE                     = 608,
    DATA_ALGALON_TRAPDOOR                   = 609,
    DATA_BRANN_BRONZEBEARD_ALG              = 610,

    // Achievements
    DATA_DWARFAGEDDON                       = 700,

    // Tram
    DATA_CALL_TRAM                          = 710,

    // Freya elders
    DATA_ELDER_IRONBRANCH                   = 750,
    DATA_ELDER_STONEBARK                    = 751,
    DATA_ELDER_BRIGHTLEAF                   = 752,

    // Yogg-Saron
    DATA_SARA                               = 760,
    DATA_BRAIN_OF_YOGG_SARON                = 761,
    DATA_YOGG_SARON_DOORS                   = 762,
    DATA_VOICE_OF_YOGG_SARON                = 763,

    // Middle section
    DATA_ASSEMBLY_DOORS                     = 770,
    DATA_ARCHIVUM_DOORS                     = 771,
    DATA_KEEPERS_GATE                       = 772,

    // Hodir chests (dynamically spawned)
    DATA_HODIR_CHEST_NORMAL                 = 780,
    DATA_HODIR_CHEST_HARD                   = 781,
    DATA_HODIR_CHEST_NORMAL_HERO            = 782,
    DATA_HODIR_CHEST_HARD_HERO              = 783,

    // Mage Barrier
    DATA_MAGE_BARRIER                       = 800,
    DATA_BRANN_EASY_MODE                    = 802,

    // Observation Ring Keepers
    DATA_FREYA_GOSSIP                       = 810,
    DATA_HODIR_GOSSIP                       = 811,
    DATA_MIMIRON_GOSSIP                     = 812,
    DATA_THORIM_GOSSIP                      = 813,

    // Flame Leviathan outro
    DATA_BRANN_FORMATION_GROUNDS            = 814,

    // Freya, Hodir, Mimiron, Thorim
    DATA_KEEPER_TELEPORTED                  = 815,
};

enum UlduarNPCs
{
    // General
    NPC_LEVIATHAN                           = 33113,
    NPC_IGNIS                               = 33118,
    NPC_RAZORSCALE                          = 33186,
    NPC_XT002                               = 33293,
    NPC_XT_TOY_PILE                         = 33337,
    NPC_XS013_SCRAPBOT                      = 33343,
    NPC_HEART_OF_DECONSTRUCTOR              = 33329,
    NPC_STEELBREAKER                        = 32867,
    NPC_MOLGEIM                             = 32927,
    NPC_BRUNDIR                             = 32857,
    NPC_KOLOGARN                            = 32930,
    NPC_AURIAYA                             = 33515,
    NPC_MIMIRON                             = 33350,
    NPC_HODIR                               = 32845,
    NPC_THORIM                              = 32865,
    NPC_FREYA                               = 32906,
    NPC_STRENGTHENED_IRON_ROOTS             = 33168,
    NPC_VEZAX                               = 33271,
    NPC_SARONITE_ANIMUS                     = 33524,
    NPC_SARA                                = 33134,
    NPC_YOGGSARON                           = 33288,
    NPC_BRAIN_OF_YOGG_SARON                 = 33890,
    NPC_ALGALON                             = 32871,

    // Razorscale
    NPC_HARPOON_FIRE_STATE                  = 33282,
    NPC_RAZORSCALE_SPAWNER                  = 33245,
    NPC_RAZORSCALE_CONTROLLER               = 33233,
    NPC_EXPEDITION_COMMANDER                = 33210,
    NPC_EXPEDITION_ENGINEER                 = 33287,
    NPC_EXPEDITION_DEFENDER                 = 33816,
    NPC_EXPEDITION_TRAPPER                  = 33259,
    NPC_DARK_RUNE_GUARDIAN                  = 33388,
    NPC_DARK_RUNE_WATCHER                   = 33453,
    NPC_DARK_RUNE_SENTINEL                  = 33846,
    NPC_RAZORSCALE_DEVOURING_FLAME          = 34188,

    // Mimiron
    NPC_MIMIRON_LEVIATHAN_MKII              = 33432,
    NPC_MIMIRON_VX001                       = 33651,
    NPC_MIMIRON_ACU                         = 33670,
    NPC_MIMIRON_DB_TARGET                   = 33576,

    // Freya
    NPC_ELDER_BRIGHTLEAF                    = 32915,
    NPC_ELDER_STONEBARK                     = 32914,
    NPC_ELDER_IRONBRANCH                    = 32913,

    // Yogg-Saron
    NPC_VOICE_OF_YOGG_SARON                 = 33280,
    NPC_FREYA_GOSSIP                        = 33241,
    NPC_HODIR_GOSSIP                        = 33213,
    NPC_THORIM_GOSSIP                       = 33242,
    NPC_MIMIRON_GOSSIP                      = 33244,
    NPC_FREYA_KEEPER                        = 33410,
    NPC_HODIR_KEEPER                        = 33411,
    NPC_MIMIRON_KEEPER                      = 33412,
    NPC_THORIM_KEEPER                       = 33413,

    // Flame Leviathan
    NPC_SALVAGED_SIEGE_ENGINE               = 33060,
    NPC_SALVAGED_SIEGE_ENGINE_TURRET        = 33067,
    NPC_VEHICLE_CHOPPER                     = 33062,
    NPC_SALVAGED_DEMOLISHER                 = 33109,
    NPC_SALVAGED_DEMOLISHER_TURRET          = 33167,
    NPC_STEELFORGED_DEFENDER                = 33236,
    NPC_ULDUAR_COLOSSUS                     = 33237,
    NPC_IRONWORK_CANNON                     = 33264,
    NPC_ULDUAR_GAUNTLET_GENERATOR           = 33571,
    NPC_DEFENDER_GENERATED                  = 33572,
    NPC_ARCHMAGE_RHYDIAN                    = 33696,
    NPC_RUNEFORGED_SENTRY                   = 34234,
    NPC_BRANN_FORMATION_GROUNDS             = 34119,
    NPC_BRANN_S_FLYING_MACHINE              = 34120,
    NPC_EXPEDITION_MERCENARY                = 34144,
    NPC_EXPEDITION_ENGINEER_FORMATION       = 34145,

    // Algalon the Observer
    NPC_BRANN_BRONZEBEARD_ALG               = 34064,
    NPC_AZEROTH                             = 34246,
    NPC_LIVING_CONSTELLATION                = 33052,
    NPC_ALGALON_STALKER                     = 33086,
    NPC_COLLAPSING_STAR                     = 32955,
    NPC_BLACK_HOLE                          = 32953,
    NPC_WORM_HOLE                           = 34099,
    NPC_ALGALON_VOID_ZONE_VISUAL_STALKER    = 34100,
    NPC_ALGALON_STALKER_ASTEROID_TARGET_01  = 33104,
    NPC_ALGALON_STALKER_ASTEROID_TARGET_02  = 33105,
    NPC_UNLEASHED_DARK_MATTER               = 34097,

    // Ancient Gate
    NPC_ANCIENT_GATE_WORLD_TRIGGER          = 22515,
};

enum UlduarGameObjects
{
    // Chests
    GO_KOLOGARN_CHEST                       = 195046,
    GO_KOLOGARN_CHEST_HERO                  = 195047,
    GO_THORIM_CHEST                         = 194312,
    GO_THORIM_CHEST_HERO                    = 194314,
    GO_HODIR_CHEST_NORMAL                   = 194307,
    GO_HODIR_CHEST_NORMAL_HERO              = 194308,
    GO_HODIR_CHEST_HARD                     = 194200,
    GO_HODIR_CHEST_HARD_HERO                = 194201,
    GO_MIMIRON_CHEST                        = 194789,
    GO_MIMIRON_CHEST_HARD                   = 194957,
    GO_MIMIRON_CHEST_HERO                   = 194956,
    GO_MIMIRON_CHEST_HERO_HARD              = 194958,
    GO_ALGALON_CHEST                        = 194821,
    GO_ALGALON_CHEST_HERO                   = 194822,
    GO_FREYA_CHEST_3_ELDERS                 = 194324,
    GO_FREYA_CHEST_3_ELDERS_HERO            = 194325,
    GO_FREYA_CHEST_2_ELDERS                 = 194326,
    GO_FREYA_CHEST_2_ELDERS_HERO            = 194327,
    GO_FREYA_CHEST_1_ELDER                  = 194328,
    GO_FREYA_CHEST_1_ELDER_HERO             = 194329,
    GO_FREYA_CHEST                          = 194330,
    GO_FREYA_CHEST_HERO                     = 194331,

    // Herbs cleared for the lockout once Freya is defeated
    GO_ADDERS_TONGUE                        = 191019,
    GO_FROST_LOTUS                          = 190176,
    GO_LICHBLOOM                            = 190171,
    GO_TALANDRAS_ROSE                       = 190170,
    GO_GOLDCLOVER                           = 189973,

    // Flame Leviathan
    GO_REPAIR_STATION_TRAP                  = 194262,
    GO_LEVIATHAN_DOORS                      = 194630,
    GO_LIGHTNING_WALL1                      = 194905,
    GO_LIGHTNING_WALL2                      = 194416,
    GO_ULDUAR_PROTECTIVE_BUBBLE             = 194484,
    GO_MIMIRONS_TARGETTING_CRYSTAL          = 194705,
    GO_FREYAS_TARGETTING_CRYSTAL            = 194704,
    GO_HODIRS_TARGETTING_CRYSTAL            = 194707,
    GO_THORIMS_TARGETTING_CRYSTAL           = 194706,
    GO_MIMIRONS_GENERATOR                   = 194664,
    GO_FREYAS_GENERATOR                     = 194663,
    GO_HODIRS_GENERATOR                     = 194665,
    GO_THORIMS_GENERATOR                    = 194666,
    GO_STORM_BEACON_FIRST                   = 194398,
    GO_STORM_BEACON_LAST                    = 194415,
    GO_STORM_BEACON_FORMATION_GROUNDS       = 194506,

    // Middle
    GO_ARCHIVUM_DOORS                       = 194556,
    GO_ASSEMBLY_DOORS                       = 194554,
    GO_KOLOGARN_BRIDGE                      = 194232,
    GO_KEEPERS_GATE                         = 194255,
    GO_XT002_DOORS                          = 194631,

    // Tram
    GO_MIMIRON_TRAM                         = 194675,
    GO_MIMIRON_ACTIVATE_TRAM                = 194437,
    GO_MIMIRON_CALL_TRAM_CENTER             = 194914,
    GO_MIMIRON_CALL_TRAM_MIMIRON            = 194912,
    GO_MIMIRON_TRAM_ROCKET_BOOSTER          = 194904,
    GO_DOODAD_UL_TRAIN_TURNAROUND01         = 194915, // center
    GO_DOODAD_UL_TRAIN_TURNAROUND02         = 194913, // mimiron

    // Mimiron, Hodir, Vezax
    GO_MIMIRON_ELEVATOR                     = 194749,
    GO_MIMIRON_DOOR_1                       = 194776,
    GO_MIMIRON_DOOR_2                       = 194774,
    GO_MIMIRON_DOOR_3                       = 194775,
    GO_HODIR_FROZEN_DOOR                    = 194441,
    GO_HODIR_DOOR                           = 194634,
    GO_HODIR_FRONTDOOR                      = 194442,
    GO_VEZAX_DOOR                           = 194750,

    GO_SNOW_MOUND                           = 194907,

    // Razorscale
    GO_RAZOR_HARPOON_1                      = 194519,
    GO_RAZOR_HARPOON_2                      = 194541,
    GO_RAZOR_HARPOON_3                      = 194542,
    GO_RAZOR_HARPOON_4                      = 194543,
    GO_RAZOR_BROKEN_HARPOON                 = 194565,
    GO_RAZOR_MOLE_MACHINE                   = 194316,

    // Thorim
    GO_ARENA_LEVER_GATE                     = 194560,
    GO_ARENA_LEVER                          = 194264,
    GO_ARENA_FENCE                          = 194559,
    GO_FIRST_COLOSSUS_DOORS                 = 194557,
    GO_SECOND_COLOSSUS_DOORS                = 194558,

    // Yogg-Saron
    GO_YOGG_SARON_DOORS                     = 194773,

    // Algalon the Observer
    GO_CELESTIAL_PLANETARIUM_ACCESS_10      = 194628,
    GO_CELESTIAL_PLANETARIUM_ACCESS_25      = 194752,
    GO_DOODAD_UL_SIGILDOOR_01               = 194767,
    GO_DOODAD_UL_SIGILDOOR_02               = 194911,
    GO_DOODAD_UL_SIGILDOOR_03               = 194910,
    GO_DOODAD_UL_UNIVERSEFLOOR_01           = 194715,
    GO_DOODAD_UL_UNIVERSEFLOOR_02           = 194716,
    GO_DOODAD_UL_UNIVERSEGLOBE01            = 194148,
    GO_DOODAD_UL_ULDUAR_TRAPDOOR_03         = 194253,
};

enum UlduarPersistentData
{
    PERSISTENT_DATA_WATCHERS_MASK           = 0,
    PERSISTENT_DATA_CONSPEEDATORY,
    PERSISTENT_DATA_UNBROKEN_FAIL,
    PERSISTENT_DATA_ALGALON_TIMER,
    PERSISTENT_DATA_C_OF_ULDUAR_MASK,
    PERSISTENT_DATA_MAGE_BARRIER,
    PERSISTENT_DATA_ALGALON_FIRST_PULL,
    // Set when Brann's action list unlocks the salvaged vehicles, they stay boardable for the rest of the lockout
    PERSISTENT_DATA_LEVIATHAN_VEHICLES_USABLE,
    PERSISTENT_DATA_ALGALON_DEADLINE,
    MAX_PERSISTENT_DATA
};

enum UlduarLeviathanVehiclePositions
{
    VEHICLE_POS_START                       = 0,
    VEHICLE_POS_LEVIATHAN                   = 1,
    VEHICLE_POS_NONE                        = 2,
};

enum UlduarMageBarrierStates
{
    // Stored in PERSISTENT_DATA_MAGE_BARRIER by Brann's intro script once the Kirin Tor drop the shield
    MAGE_BARRIER_LOWERED                    = 3,
};

enum UlduarSummonGroups
{
    // creature_summon_groups entries for the post-Leviathan outro
    SUMMON_GROUP_LEVIATHAN_OUTRO            = 0, // Brann + crew in formation (reload; also the march destinations)
    SUMMON_GROUP_LEVIATHAN_OUTRO_MARCH      = 1, // crew at the gate, runs into formation (kill)
    SUMMON_GROUP_LEVIATHAN_OUTRO_RHYDIAN    = 2,
    SUMMON_GROUP_LEVIATHAN_OUTRO_MACHINE    = 3, // Brann's Flying Machine, airborne (kill)
    SUMMON_GROUP_LEVIATHAN_OUTRO_BRANN      = 4, // Brann at the landed machine (kill)
    SUMMON_GROUP_LEVIATHAN_OUTRO_MAGES      = 5, // 12 Kirin Tor Mages flanking Brann's spot
    SUMMON_GROUP_LEVIATHAN_OUTRO_BATTLE_MAGES = 7, // 2 sustaining the portal + 1 at the Formation Grounds teleporter

    // gameobject_summon_groups: the Dalaran portal behind the formation
    GO_SUMMON_GROUP_LEVIATHAN_PORTAL        = 1,
};

enum UlduarPaths
{
    // waypoint_data paths: Brann's walk from the machine to his spot, Rhydian's walk to Brann's side,
    // and the flying machine's approach arc over the grounds
    PATH_BRANN_FORMATION_GROUNDS            = 341190,
    PATH_RHYDIAN_TO_BRANN                   = 336960,
    PATH_FLYING_MACHINE_APPROACH            = 341200,

    // Six column routes per crew entry, PATH_* + 1 to PATH_* + 6
    PATH_EXPEDITION_MERCENARY_MARCH         = 3414400,
    PATH_EXPEDITION_ENGINEER_MARCH          = 3414500,
};

enum UlduarSpells
{
    // Gossip Keepers, Kirin Tor Mages: teleport-in flash
    SPELL_SIMPLE_TELEPORT_VISUAL            = 12980,

    // Kirin Tor Battle-Mages sustaining the Dalaran portal
    SPELL_ARCANE_CHANNELING                 = 39550,

    // Algalon the Observer, Freya, Hodir, Mimiron, Thorim, Gossip Keepers
    SPELL_TELEPORT                          = 62940,

    // Achievement credit spell, not in the client DBC
    SPELL_DWARFAGEDDON                      = 65387,
};

enum UlduarGameEvents
{
    EVENT_TOWER_OF_LIFE_DESTROYED           = 21030,
    EVENT_TOWER_OF_STORM_DESTROYED          = 21031,
    EVENT_TOWER_OF_FROST_DESTROYED          = 21032,
    EVENT_TOWER_OF_FLAMES_DESTROYED         = 21033,

    // Sent by Shatter Chest (62502), triggered by Hodir's hard mode timer missile (62501)
    EVENT_HODIR_SHATTER_CHEST               = 20907,
};

enum UlduarInstanceEvents
{
    EVENT_UPDATE_ALGALON_TIMER              = 1,
    EVENT_RESUMMON_ALGALON                  = 2,
};

enum UlduarActions
{
    // Algalon the Observer
    ACTION_FEEDS_ON_TEARS_FAILED            = 0,
    ACTION_INIT_ALGALON                     = 1,
    ACTION_DESPAWN_ALGALON                  = 2,
    ACTION_START_INTRO                      = 3,

    // Yogg-Saron
    ACTION_SARA_UPDATE_SUMMON_KEEPERS       = 4,
};

enum UlduarAlgalonTimerStates
{
    TIMER_ALGALON_DEFEATED                  = 300,
    TIMER_ALGALON_TO_SUMMON                 = 200,
    TIMER_ALGALON_SUMMONED                  = 100,
    TIMER_ALGALON_MINUTES                   = 60,
};

enum UlduarTexts
{
    // Ancient Gate world trigger
    EMOTE_ANCIENT_GATE_UNLOCKED             = 19,
};

enum UlduarKeepers
{
    KEEPER_FREYA                            = 0,
    KEEPER_HODIR                            = 1,
    KEEPER_MIMIRON                          = 2,
    KEEPER_THORIM                           = 3,
};

enum UlduarAchievementData
{
    ACHIEV_CON_SPEED_ATORY_START_EVENT      = 21597,

    // Champion of Ulduar (10 player) / Conqueror of Ulduar (25 player): a boss killed without a raid member dying
    ACHIEV_CRITERIA_CHAMPION_LEVIATHAN      = 10042,
    ACHIEV_CRITERIA_CONQUEROR_LEVIATHAN     = 10352,
    ACHIEV_CRITERIA_CHAMPION_IGNIS          = 10342,
    ACHIEV_CRITERIA_CONQUEROR_IGNIS         = 10355,
    ACHIEV_CRITERIA_CHAMPION_RAZORSCALE     = 10340,
    ACHIEV_CRITERIA_CONQUEROR_RAZORSCALE    = 10353,
    ACHIEV_CRITERIA_CHAMPION_XT002          = 10341,
    ACHIEV_CRITERIA_CONQUEROR_XT002         = 10354,
    ACHIEV_CRITERIA_CHAMPION_ASSEMBLY       = 10598,
    ACHIEV_CRITERIA_CONQUEROR_ASSEMBLY      = 10599,
    ACHIEV_CRITERIA_CHAMPION_KOLOGARN       = 10348,
    ACHIEV_CRITERIA_CONQUEROR_KOLOGARN      = 10357,
    ACHIEV_CRITERIA_CHAMPION_AURIAYA        = 10351,
    ACHIEV_CRITERIA_CONQUEROR_AURIAYA       = 10363,
    ACHIEV_CRITERIA_CHAMPION_HODIR          = 10439,
    ACHIEV_CRITERIA_CONQUEROR_HODIR         = 10719,
    ACHIEV_CRITERIA_CHAMPION_THORIM         = 10403,
    ACHIEV_CRITERIA_CONQUEROR_THORIM        = 10404,
    ACHIEV_CRITERIA_CHAMPION_FREYA          = 10582,
    ACHIEV_CRITERIA_CONQUEROR_FREYA         = 10583,
    ACHIEV_CRITERIA_CHAMPION_MIMIRON        = 10347,
    ACHIEV_CRITERIA_CONQUEROR_MIMIRON       = 10361,
    ACHIEV_CRITERIA_CHAMPION_VEZAX          = 10349,
    ACHIEV_CRITERIA_CONQUEROR_VEZAX         = 10362,
    ACHIEV_CRITERIA_CHAMPION_YOGGSARON      = 10350,
    ACHIEV_CRITERIA_CONQUEROR_YOGGSARON     = 10364,
};

Position const AlgalonSummonPos = {1632.531f, -304.8516f, 450.1123f, 1.530165f};
Position const AlgalonLandPos   = {1632.668f, -302.7656f, 417.3211f, 1.530165f};

template <class AI, class T>
inline AI* GetUlduarAI(T* obj)
{
    return GetInstanceAI<AI>(obj, UlduarScriptName);
}

#define RegisterUlduarCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetUlduarAI)

#endif // DEF_ULDUAR_H
