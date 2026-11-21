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

#include "AreaDefines.h"
#include "Containers.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Map.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "TemporarySummon.h"
#include "Transport.h"
#include "TransportMgr.h"
#include "WorldStateDefines.h"
#include "WorldStatePackets.h"
#include "icecrown_citadel.h"
#include <array>
#include <list>
#include <set>
#include <sstream>
#include <string_view>

enum EventIds
{
    EVENT_PLAYERS_GUNSHIP_SPAWN     = 22663,
    EVENT_PLAYERS_GUNSHIP_COMBAT    = 22664,
    EVENT_PLAYERS_GUNSHIP_SAURFANG  = 22665,
    EVENT_ENEMY_GUNSHIP_COMBAT      = 22860,
    EVENT_ENEMY_GUNSHIP_DESPAWN     = 22861,

    EVENT_QUAKE                     = 23437,
    EVENT_SECOND_REMORSELESS_WINTER = 23507,
    EVENT_TELEPORT_TO_FROSMOURNE    = 23617,
    EVENT_FESTERGUT_VALVE_USED      = 23438,
    EVENT_ROTFACE_VALVE_USED        = 23426,
};

enum TimedEvents
{
    EVENT_UPDATE_EXECUTION_TIME         = 1,
    EVENT_QUAKE_SHATTER                 = 2,
    EVENT_REBUILD_PLATFORM              = 3,
    EVENT_RESPAWN_GUNSHIP               = 4,
    EVENT_RESPAWN_SINDRAGOSA            = 5,
    EVENT_SPAWN_SAURFANG_EVENT          = 6,
    EVENT_SAURFANG_ZEPPELIN_DOCK        = 7,
    EVENT_SAURFANG_OUTRO_TIMEOUT        = 8,
    EVENT_SAURFANG_ZEPPELIN_REMOVE      = 9,
    // The camp is built on screen, stage by stage.
    EVENT_SAURFANG_CAMP_ACTIVATE        = 10,
    EVENT_SAURFANG_CAMP_WORKERS         = 11,
    EVENT_SAURFANG_CAMP_WORKER_0_RUN    = 12,
    EVENT_SAURFANG_CAMP_WORKER_1_RUN    = 13,
    EVENT_SAURFANG_CAMP_WORKER_0_WORK   = 14,
    EVENT_SAURFANG_CAMP_WORKER_1_WORK   = 15,
    EVENT_SAURFANG_CAMP_TENTS           = 16,
    EVENT_SAURFANG_CAMP_VENDORS         = 17,
    EVENT_LICH_KING_WHISPER             = 18,
};

enum Paths
{
    // waypoint_data paths walking the camp vendors from their teleporter pads to their pitches.
    PATH_CAMP_SHELY_STEELBOWELS         = NPC_CAMP_SHELY_STEELBOWELS * 10,
    PATH_CAMP_BRAZIE_GETZ               = NPC_CAMP_BRAZIE_GETZ * 10,
    PATH_CAMP_APOTHECARY_CANDITH_TOMAS  = NPC_CAMP_APOTHECARY_CANDITH_TOMAS * 10,
    PATH_CAMP_MORGAN_DAYBLAZE           = NPC_CAMP_MORGAN_DAYBLAZE * 10,

    PATH_SINDRAGOSA_RESPAWN             = NPC_SINDRAGOSA * 10,
};

enum MovePoints
{
    POINT_CAMP_WORKER_SITE              = 1,
    POINT_CAMP_WORKER_TELEPORTER        = 2,
};

enum Spells
{
    SPELL_GAS_VARIABLE                  = 74119,
    SPELL_OOZE_VARIABLE                 = 74118,
    SPELL_BLOOD_BEAM_VISUAL_RHAND       = 72304,
    SPELL_BLOOD_BEAM_VISUAL_LHAND       = 72303,
    SPELL_BLOOD_BEAM_VISUAL_LLEG        = 72302,
    SPELL_BLOOD_BEAM_VISUAL_RLEG        = 72301,
    SPELL_VOID_ZONE_VISUAL              = 69422,
    SPELL_SIMPLE_TELEPORT               = 12980,    // the camp crew stepping off the teleporter pads

    SPELL_HELLSCREAMS_WARSONG_5         = 73816,
    SPELL_HELLSCREAMS_WARSONG_10        = 73818,
    SPELL_HELLSCREAMS_WARSONG_15        = 73819,
    SPELL_HELLSCREAMS_WARSONG_20        = 73820,
    SPELL_HELLSCREAMS_WARSONG_25        = 73821,
    SPELL_HELLSCREAMS_WARSONG_30        = 73822,
    SPELL_STRENGTH_OF_WRYNN_5           = 73762,
    SPELL_STRENGTH_OF_WRYNN_10          = 73824,
    SPELL_STRENGTH_OF_WRYNN_15          = 73825,
    SPELL_STRENGTH_OF_WRYNN_20          = 73826,
    SPELL_STRENGTH_OF_WRYNN_25          = 73827,
    SPELL_STRENGTH_OF_WRYNN_30          = 73828,
};

enum Say
{
    SAY_SOULS_LICH_KING_RAND_WHISPER = 5
};

// How long the Lady Deathwhisper elevator stays motionless at each end of its cycle before departing again.
constexpr uint32 DeathwhisperElevatorDwellTime = 7 * IN_MILLISECONDS;

BossBoundaryData const Boundaries =
{
    { DATA_LORD_MARROWGAR, new CircleBoundary(Position(-428.0f, 2211.0f), 95.0f) },
    { DATA_LORD_MARROWGAR, new RectangleBoundary(-430.0f, -330.0f, 2110.0f, 2310.0f) },
    { DATA_LADY_DEATHWHISPER, new RectangleBoundary(-670.0f, -520.0f, 2145.0f, 2280.0f) },
    { DATA_DEATHBRINGER_SAURFANG, new RectangleBoundary(-565.0f, -465.0f, 2160.0f, 2260.0f) },

    { DATA_ROTFACE, new RectangleBoundary(4385.0f, 4505.0f, 3082.0f, 3195.0f) },
    { DATA_FESTERGUT, new RectangleBoundary(4205.0f, 4325.0f, 3082.0f, 3195.0f) },
    { DATA_PROFESSOR_PUTRICIDE, new ParallelogramBoundary(Position(4356.0f, 3290.0f), Position(4435.0f, 3194.0f), Position(4280.0f, 3194.0f)) },
    { DATA_PROFESSOR_PUTRICIDE, new RectangleBoundary(4280.0f, 4435.0f, 3150.0f, 4360.0f) },

    { DATA_BLOOD_PRINCE_COUNCIL, new EllipseBoundary(Position(4660.95f, 2769.194f), 85.0f, 60.0f) },
    { DATA_BLOOD_QUEEN_LANA_THEL, new CircleBoundary(Position(4595.93f, 2769.365f), 64.0f) },

    { DATA_SISTER_SVALNA, new RectangleBoundary(4291.0f, 4423.0f, 2438.0f, 2653.0f) },
    { DATA_VALITHRIA_DREAMWALKER, new RectangleBoundary(4112.5f, 4293.5f, 2385.0f, 2585.0f) },
    { DATA_SINDRAGOSA, new EllipseBoundary(Position(4418.6f, 2484.0f), 110.0f, 75.0f) }
};

DoorData const Doors[] =
{
    { GO_LORD_MARROWGAR_S_ENTRANCE,           DATA_LORD_MARROWGAR,        DOOR_TYPE_ROOM       },
    { GO_SCOURGE_TRANSPORTER_FIRST,           DATA_LORD_MARROWGAR,        DOOR_TYPE_PASSAGE    },
    { GO_ICEWALL,                             DATA_LORD_MARROWGAR,        DOOR_TYPE_PASSAGE    },
    { GO_DOODAD_ICECROWN_ICEWALL02,           DATA_LORD_MARROWGAR,        DOOR_TYPE_PASSAGE    },
    { GO_ORATORY_OF_THE_DAMNED_ENTRANCE,      DATA_LADY_DEATHWHISPER,     DOOR_TYPE_ROOM       },
    { GO_SAURFANG_S_DOOR,                     DATA_DEATHBRINGER_SAURFANG, DOOR_TYPE_PASSAGE    },
    { GO_ORANGE_PLAGUE_MONSTER_ENTRANCE,      DATA_FESTERGUT,             DOOR_TYPE_ROOM       },
    { GO_GREEN_PLAGUE_MONSTER_ENTRANCE,       DATA_ROTFACE,               DOOR_TYPE_ROOM       },
    { GO_CRIMSON_HALL_DOOR,                   DATA_BLOOD_PRINCE_COUNCIL,  DOOR_TYPE_ROOM       },
    { GO_CRIMSON_HALL_DOOR,                   DATA_BLOOD_PRINCE_TRASH,    DOOR_TYPE_PASSAGE    },
    { GO_BLOOD_ELF_COUNCIL_DOOR,              DATA_BLOOD_PRINCE_COUNCIL,  DOOR_TYPE_PASSAGE    },
    { GO_BLOOD_ELF_COUNCIL_DOOR_RIGHT,        DATA_BLOOD_PRINCE_COUNCIL,  DOOR_TYPE_PASSAGE    },
    { GO_DOODAD_ICECROWN_BLOODPRINCE_DOOR_01, DATA_BLOOD_QUEEN_LANA_THEL, DOOR_TYPE_ROOM       },
    { GO_DOODAD_ICECROWN_GRATE_01,            DATA_BLOOD_QUEEN_LANA_THEL, DOOR_TYPE_PASSAGE    },
    { GO_GREEN_DRAGON_BOSS_ENTRANCE,          DATA_SISTER_SVALNA,         DOOR_TYPE_PASSAGE    },
    { GO_GREEN_DRAGON_BOSS_ENTRANCE,          DATA_VALITHRIA_DREAMWALKER, DOOR_TYPE_ROOM       },
    { GO_GREEN_DRAGON_BOSS_EXIT,              DATA_VALITHRIA_DREAMWALKER, DOOR_TYPE_PASSAGE    },
    { GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_01,  DATA_VALITHRIA_DREAMWALKER, DOOR_TYPE_SPAWN_HOLE },
    { GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_02,  DATA_VALITHRIA_DREAMWALKER, DOOR_TYPE_SPAWN_HOLE },
    { GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_03,  DATA_VALITHRIA_DREAMWALKER, DOOR_TYPE_SPAWN_HOLE },
    { GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_04,  DATA_VALITHRIA_DREAMWALKER, DOOR_TYPE_SPAWN_HOLE },
    { GO_SINDRAGOSA_ENTRANCE_DOOR,            DATA_SINDRAGOSA,            DOOR_TYPE_ROOM       },
    { GO_SINDRAGOSA_ENTRANCE_DOOR,            DATA_SINDRAGOSA_GAUNTLET,   DOOR_TYPE_PASSAGE    },
    { GO_SINDRAGOSA_SHORTCUT_ENTRANCE_DOOR,   DATA_SINDRAGOSA,            DOOR_TYPE_PASSAGE    },
    { GO_SINDRAGOSA_SHORTCUT_EXIT_DOOR,       DATA_SINDRAGOSA,            DOOR_TYPE_PASSAGE    },
    { GO_ICE_WALL,                            DATA_SINDRAGOSA,            DOOR_TYPE_ROOM       },
    { 0,                                      0,                          DOOR_TYPE_ROOM       }
};

// Object storage slots only this script reads; they share the GetGuidData key space with DataTypes
enum InstanceObjects
{
    DATA_THE_LICH_KING_LH               = 100,
    DATA_LADY_DEATHWHISPER_ELEVATOR     = 101,
    DATA_GUNSHIP_ARMORY                 = 102,
    DATA_DEATHBRINGERS_CACHE            = 103,
    DATA_PUTRICIDE_ENTRANCE_DOOR        = 104,
    DATA_PUTRICIDE_COLLISION            = 105,
    DATA_PUTRICIDE_GATE_ORANGE          = 106,
    DATA_PUTRICIDE_GATE_GREEN           = 107,
    DATA_PUTRICIDE_PIPE_ORANGE          = 108,
    DATA_PUTRICIDE_PIPE_GREEN           = 109,
    DATA_GAS_RELEASE_VALVE              = 110,
    DATA_OOZE_RELEASE_VALVE             = 111,
    DATA_PLAGUE_SIGIL                   = 112,
    DATA_BLOODWING_SIGIL                = 113,
    DATA_FROSTWING_SIGIL                = 114,
    DATA_LICH_KING_TELEPORT             = 115,
    DATA_FROZEN_THRONE_EDGE             = 116,
    DATA_FROZEN_THRONE_WIND             = 117,
    DATA_FROZEN_THRONE_WARNING          = 118,
    DATA_FROZEN_BOLVAR                  = 119,
    DATA_PILLARS_CHAINED                = 120,
    DATA_PILLARS_UNCHAINED              = 121,
    DATA_SCOURGE_TRANSPORTER_FIRST      = 122,
};

ObjectData const CreatureObjectData[] =
{
    { NPC_LADY_DEATHWHISPER,                DATA_LADY_DEATHWHISPER          },
    { NPC_THE_SKYBREAKER,                   DATA_THE_SKYBREAKER             },
    { NPC_ORGRIMS_HAMMER,                   DATA_ORGRIMS_HAMMER             },
    { NPC_DEATHBRINGER_SAURFANG,            DATA_DEATHBRINGER_SAURFANG      },
    { NPC_FESTERGUT,                        DATA_FESTERGUT                  },
    { NPC_ROTFACE,                          DATA_ROTFACE                    },
    { NPC_PROFESSOR_PUTRICIDE,              DATA_PROFESSOR_PUTRICIDE        },
    { NPC_PUTRICADES_TRAP,                  DATA_PUTRICIDE_TRAP             },
    { NPC_PRINCE_KELESETH,                  DATA_PRINCE_KELESETH_GUID       },
    { NPC_PRINCE_TALDARAM,                  DATA_PRINCE_TALDARAM_GUID       },
    { NPC_PRINCE_VALANAR,                   DATA_PRINCE_VALANAR_GUID        },
    { NPC_BLOOD_ORB_CONTROLLER,             DATA_BLOOD_PRINCES_CONTROL      },
    { NPC_BLOOD_QUEEN_LANA_THEL,            DATA_BLOOD_QUEEN_LANA_THEL      },
    { NPC_CROK_SCOURGEBANE,                 DATA_CROK_SCOURGEBANE           },
    { NPC_CAPTAIN_ARNATH,                   DATA_CAPTAIN_ARNATH             },
    { NPC_CAPTAIN_BRANDON,                  DATA_CAPTAIN_BRANDON            },
    { NPC_CAPTAIN_GRONDEL,                  DATA_CAPTAIN_GRONDEL            },
    { NPC_CAPTAIN_RUPERT,                   DATA_CAPTAIN_RUPERT             },
    { NPC_SISTER_SVALNA,                    DATA_SISTER_SVALNA              },
    { NPC_VALITHRIA_DREAMWALKER,            DATA_VALITHRIA_DREAMWALKER      },
    { NPC_THE_LICH_KING_VALITHRIA,          DATA_VALITHRIA_LICH_KING        },
    { NPC_GREEN_DRAGON_COMBAT_TRIGGER,      DATA_VALITHRIA_TRIGGER          },
    { NPC_SINDRAGOSA_GAUNTLET,              DATA_SINDRAGOSA_GAUNTLET_NPC    },
    { NPC_SINDRAGOSA,                       DATA_SINDRAGOSA                 },
    { NPC_SPINESTALKER,                     DATA_SPINESTALKER               },
    { NPC_RIMEFANG,                         DATA_RIMEFANG                   },
    { NPC_THE_LICH_KING,                    DATA_THE_LICH_KING              },
    { NPC_THE_LICH_KING_LH,                 DATA_THE_LICH_KING_LH           },
    { 0,                                    0                               }
};

ObjectData const GameObjectObjectData[] =
{
    { GO_SCOURGE_TRANSPORTER_FIRST,         DATA_SCOURGE_TRANSPORTER_FIRST  },
    { GO_LADY_DEATHWHISPER_ELEVATOR,        DATA_LADY_DEATHWHISPER_ELEVATOR },
    { GO_THE_SKYBREAKER_H,                  DATA_ENEMY_GUNSHIP              },
    { GO_ORGRIMS_HAMMER_A,                  DATA_ENEMY_GUNSHIP              },
    { GO_GUNSHIP_ARMORY_H_10N,              DATA_GUNSHIP_ARMORY             },
    { GO_GUNSHIP_ARMORY_H_25N,              DATA_GUNSHIP_ARMORY             },
    { GO_GUNSHIP_ARMORY_H_10H,              DATA_GUNSHIP_ARMORY             },
    { GO_GUNSHIP_ARMORY_H_25H,              DATA_GUNSHIP_ARMORY             },
    { GO_GUNSHIP_ARMORY_A_10N,              DATA_GUNSHIP_ARMORY             },
    { GO_GUNSHIP_ARMORY_A_25N,              DATA_GUNSHIP_ARMORY             },
    { GO_GUNSHIP_ARMORY_A_10H,              DATA_GUNSHIP_ARMORY             },
    { GO_GUNSHIP_ARMORY_A_25H,              DATA_GUNSHIP_ARMORY             },
    { GO_SAURFANG_S_DOOR,                   DATA_SAURFANG_DOOR              },
    { GO_SCOURGE_TRANSPORTER_SAURFANG,      DATA_SAURFANG_TELEPORT          },
    { GO_DEATHBRINGER_S_CACHE_10N,          DATA_DEATHBRINGERS_CACHE        },
    { GO_DEATHBRINGER_S_CACHE_25N,          DATA_DEATHBRINGERS_CACHE        },
    { GO_DEATHBRINGER_S_CACHE_10H,          DATA_DEATHBRINGERS_CACHE        },
    { GO_DEATHBRINGER_S_CACHE_25H,          DATA_DEATHBRINGERS_CACHE        },
    { GO_SCIENTIST_ENTRANCE,                DATA_PUTRICIDE_ENTRANCE_DOOR    },
    { GO_SCIENTIST_AIRLOCK_DOOR_COLLISION,  DATA_PUTRICIDE_COLLISION        },
    { GO_SCIENTIST_AIRLOCK_DOOR_ORANGE,     DATA_PUTRICIDE_GATE_ORANGE      },
    { GO_SCIENTIST_AIRLOCK_DOOR_GREEN,      DATA_PUTRICIDE_GATE_GREEN       },
    { GO_DOODAD_ICECROWN_ORANGETUBES02,     DATA_PUTRICIDE_PIPE_ORANGE      },
    { GO_DOODAD_ICECROWN_GREENTUBES02,      DATA_PUTRICIDE_PIPE_GREEN       },
    { GO_GAS_RELEASE_VALVE,                 DATA_GAS_RELEASE_VALVE          },
    { GO_OOZE_RELEASE_VALVE,                DATA_OOZE_RELEASE_VALVE         },
    { GO_DRINK_ME,                          DATA_PUTRICIDE_TABLE            },
    { GO_PLAGUE_SIGIL,                      DATA_PLAGUE_SIGIL               },
    { GO_BLOODWING_SIGIL,                   DATA_BLOODWING_SIGIL            },
    { GO_SIGIL_OF_THE_FROSTWING,            DATA_FROSTWING_SIGIL            },
    { GO_SCOURGE_TRANSPORTER_LK,            DATA_LICH_KING_TELEPORT         },
    { GO_ARTHAS_PLATFORM,                   DATA_ARTHAS_PLATFORM            },
    { GO_DOODAD_ICECROWN_THRONEFROSTYEDGE01, DATA_FROZEN_THRONE_EDGE        },
    { GO_DOODAD_ICECROWN_THRONEFROSTYWIND01, DATA_FROZEN_THRONE_WIND        },
    { GO_DOODAD_ICECROWN_SNOWEDGEWARNING01, DATA_FROZEN_THRONE_WARNING      },
    { GO_FROZEN_LAVAMAN,                    DATA_FROZEN_BOLVAR              },
    { GO_LAVAMAN_PILLARS_CHAINED,           DATA_PILLARS_CHAINED            },
    { GO_LAVAMAN_PILLARS_UNCHAINED,         DATA_PILLARS_UNCHAINED          },
    { 0,                                    0                               }
};

// Not only questgivers: related quest spawns are listed too
struct WeeklyQuest
{
    uint32 CreatureEntry;
    uint32 QuestId[2];  // 10 and 25 man versions
};

WeeklyQuest const WeeklyQuestData[WeeklyNPCs] =
{
    {NPC_INFILTRATOR_MINCHAR,         {QUEST_DEPROGRAMMING_10,                 QUEST_DEPROGRAMMING_25                }}, // Deprogramming
    {NPC_KOR_KRON_LIEUTENANT,         {QUEST_SECURING_THE_RAMPARTS_10,         QUEST_SECURING_THE_RAMPARTS_25        }}, // Securing the Ramparts
    {NPC_ROTTING_FROST_GIANT_10,      {QUEST_SECURING_THE_RAMPARTS_10,         QUEST_SECURING_THE_RAMPARTS_25        }}, // Securing the Ramparts
    {NPC_ROTTING_FROST_GIANT_25,      {QUEST_SECURING_THE_RAMPARTS_10,         QUEST_SECURING_THE_RAMPARTS_25        }}, // Securing the Ramparts
    {NPC_ALCHEMIST_ADRIANNA,          {QUEST_RESIDUE_RENDEZVOUS_10,            QUEST_RESIDUE_RENDEZVOUS_25           }}, // Residue Rendezvous
    {NPC_ALRIN_THE_AGILE,             {QUEST_BLOOD_QUICKENING_10,              QUEST_BLOOD_QUICKENING_25             }}, // Blood Quickening
    {NPC_INFILTRATOR_MINCHAR_BQ,      {QUEST_BLOOD_QUICKENING_10,              QUEST_BLOOD_QUICKENING_25             }}, // Blood Quickening
    {NPC_MINCHAR_BEAM_STALKER,        {QUEST_BLOOD_QUICKENING_10,              QUEST_BLOOD_QUICKENING_25             }}, // Blood Quickening
    {NPC_VALITHRIA_DREAMWALKER_QUEST, {QUEST_RESPITE_FOR_A_TORMENTED_SOUL_10,  QUEST_RESPITE_FOR_A_TORMENTED_SOUL_25 }}, // Respite for a Tormented Soul
};

Position const JainaSpawnPos    = { -48.65278f, 2211.026f, 27.98586f, 3.124139f };
Position const MuradinSpawnPos  = { -47.34549f, 2208.087f, 27.98586f, 3.106686f };
Position const UtherSpawnPos    = { -26.58507f, 2211.524f, 30.19898f, 3.124139f };
Position const SylvanasSpawnPos = { -41.45833f, 2222.891f, 27.98586f, 3.647738f };
Position const SindragosaSpawnPos = { 4818.6997f, 2483.7102f, 287.06497f, 3.286661f };

// The camps differ: the Horde raises two tents by its bonfire, forge and anvil, the Alliance a
// tighter cluster with a banner and its own anvil and forge, and no bonfire.
Position const SaurfangCampTentPosH[2] =
{
    { -532.86456f, 2229.0088f, 539.2921f, 2.530723f },
    { -524.55730f, 2238.0920f, 539.2920f, 0.13962449f }
};

Position const SaurfangCampTentPosA[2] =
{
    { -532.52606f, 2229.6511f, 539.29193f, 5.480516f },
    { -528.74830f, 2233.4705f, 539.29193f, 5.463047f }
};

Position const SaurfangCampBannerPosA   = { -533.14410f, 2233.9670f, 539.29224f, 5.463047f };
Position const SaurfangCampAnvilPosA    = { -524.68580f, 2235.8855f, 539.29190f, 0.7853982f };
Position const SaurfangCampForgePosA    = { -526.50867f, 2237.5417f, 539.29205f, 0.0f };

Position const SaurfangCampTeleporterPos[2] =
{
    { -560.41840f, 2202.7500f, 539.28534f, 0.0f },
    { -560.29517f, 2220.2153f, 539.28540f, 0.0f }
};

// Where the workers stand hammering, one per teleporter pad, short of the tent they raise.
Position const SaurfangCampWorkPosH[2] =
{
    { -521.00696f, 2235.4844f, 539.29175f, 2.3f },
    { -529.47220f, 2225.7360f, 539.29193f, 2.3f }
};

Position const SaurfangCampWorkPosA[2] =
{
    { -524.22050f, 2232.9392f, 539.27704f, 2.2165682f },
    { -530.03820f, 2227.0989f, 539.27704f, 2.2863812f }
};

// The vendors' pitches, the end of their waypoint paths, for a camp not built on screen.
Position const SaurfangCampBlacksmithPos    = { -520.94100f, 2233.1077f, 539.2769f, 5.3756142f };
Position const SaurfangCampGeneralGoodsPos  = { -530.17017f, 2226.2310f, 539.2770f, 5.4628806f };
Position const SaurfangCampBlacksmithPosA   = { -526.80206f, 2231.3682f, 539.2771f, 5.5152402f };
Position const SaurfangCampGeneralGoodsPosA = { -530.60070f, 2227.6736f, 539.2771f, 5.4977870f };

// Where the zeppelin comes to rest; it is frozen on arrival.
Position const SaurfangOutroZeppelinPos     = { -527.66110f, 2254.6910f, 538.53300f, 0.6848107f };
float const SaurfangOutroZeppelinDockRange  = 12.0f;
// Saurfang's spot on deck while it flies in, relative to the transport.
Position const SaurfangZeppelinPassengerOffset = { -1.122207f, -2.488975f, -17.782246f, 1.553343f };

// Travel time of a mover at its run speed to a point, plus a margin for the spline to settle.
static Milliseconds RunTimeTo(Unit const* who, Position const& to)
{
    return Milliseconds(uint32(who->GetExactDist2d(&to) / who->GetSpeed(MOVE_RUN) * 1000.0f)) + 300ms;
}

// Candidate spots for each Spirit Alarm trap, one picked at random on spawn
std::array<std::array<Position, 3>, 4> const SpiritAlarmPositions =
{ {
    { { { -160.96f, 2210.46f, 35.24f, 0.0f }, { -176.27f, 2201.93f, 35.24f, 0.0f }, { -207.83f, 2207.38f, 35.24f, 0.0f } } },
    { { { -178.41f, 2225.11f, 35.24f, 0.0f }, { -195.23f, 2221.55f, 35.24f, 0.0f }, { -209.94f, 2250.34f, 37.99f, 0.0f } } },
    { { { -289.80f, 2216.60f, 42.39f, 0.0f }, { -317.76f, 2216.11f, 42.57f, 0.0f }, { -301.07f, 2216.62f, 42.0f, 0.0f } } },
    { { { -276.07f, 2206.76f, 42.57f, 0.0f }, { -304.44f, 2199.11f, 41.99f, 0.0f }, { -292.82f, 2204.61f, 42.02f, 0.0f } } }
} };

// Spire Gargoyles, Spire Minions and the Skybreaker/Kor'kron crews fighting on the Rampart of Skulls
static bool IsRampartOfSkullsFighter(Creature const* creature)
{
    if (creature->GetTransport() || creature->GetPositionZ() > 205.0f || creature->GetExactDist2d(-439.0f, 2210.0f) > 150.0f)
        return false;

    if (creature->GetEntry() == NPC_SPIRE_GARGOYLE || creature->GetEntry() == NPC_SPIRE_MINION)
        return true;

    std::string_view const name = creature->GetName();
    return name.starts_with("Skybreaker ") || name.starts_with("Kor'kron ");
}

class RespawnEvent : public BasicEvent
{
public:
    explicit RespawnEvent(Creature& owner) : _owner(owner) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        _owner.RemoveCorpse(false);
        _owner.Respawn();
        return true;
    }

private:
    Creature& _owner;
};

class DelayedCastMincharEvent : public BasicEvent
{
public:
    DelayedCastMincharEvent(Creature* trigger, uint32 spellId) : _trigger(trigger), _spellId(spellId) { }

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
    {
        if (Creature* minchar = _trigger->FindNearestCreature(NPC_INFILTRATOR_MINCHAR_BQ, 50.0f, true))
            _trigger->CastSpell(minchar, _spellId, true);

        return true;
    }

private:
    Creature* _trigger;
    uint32 _spellId;
};

class instance_icecrown_citadel : public InstanceMapScript
{
public:
    instance_icecrown_citadel() : InstanceMapScript(ICCScriptName, MAP_ICECROWN_CITADEL) { }

    struct instance_icecrown_citadel_InstanceMapScript : public InstanceScript
    {
        instance_icecrown_citadel_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
        {
            _isBuffAvailable = true;
            _weeklyQuestId10 = 0;
            _putricideEventProgress = 0;
            _lichKingHeroicAvailable = true;
            _deathwhisperElevatorTimer = DeathwhisperElevatorDwellTime;
            _saurfangCampSpawned = false;
            _saurfangOutroRunning = false;
            _saurfangZeppelinDocked = false;
            _saurfangZeppelinLeaving = false;

            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            SetPersistentDataCount(MAX_DATA_INDEXES);
            LoadBossBoundaries(Boundaries);
            LoadObjectData(CreatureObjectData, GameObjectObjectData);
            LoadDoorData(Doors);
            _heroicAttempts = MaxHeroicAttempts;
            _isBonedEligible = true;
            _isOozeDanceEligible = true;
            _isNauseaEligible = true;
            _isOrbWhispererEligible = true;
            _coldflameJetsState = NOT_STARTED;
            _bloodQuickeningState = NOT_STARTED;
            _bloodQuickeningMinutes = 0;
            _bloodPrinceTrashCount = 0;
            _isSindragosaIntroDone = false;

            _events.ScheduleEvent(EVENT_LICH_KING_WHISPER, 2min);
        }

        void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override
        {
            packet.Worldstates.reserve(5);
            packet.Worldstates.emplace_back(WORLD_STATE_ICECROWN_CITADEL_SHOW_TIMER, _bloodQuickeningState == IN_PROGRESS ? 1 : 0);
            packet.Worldstates.emplace_back(WORLD_STATE_ICECROWN_CITADEL_EXECUTION_TIME, _bloodQuickeningMinutes);
            packet.Worldstates.emplace_back(WORLD_STATE_ICECROWN_CITADEL_SHOW_ATTEMPTS, 1);
            packet.Worldstates.emplace_back(WORLD_STATE_ICECROWN_CITADEL_ATTEMPTS_REMAINING, _heroicAttempts);
            packet.Worldstates.emplace_back(WORLD_STATE_ICECROWN_CITADEL_ATTEMPTS_MAX, MaxHeroicAttempts);
        }

        void OnPlayerAreaUpdate(Player* player, uint32 /*oldArea*/, uint32 newArea) override
        {
            if (newArea == AREA_PUTRICIDES_LABORATORY_OF_ALCHEMICAL_HORRORS_AND_FUN ||
                newArea == AREA_THE_SANCTUM_OF_BLOOD ||
                newArea == AREA_THE_FROST_QUEENS_LAIR ||
                newArea == AREA_THE_FROZEN_THRONE ||
                newArea == AREA_FROSTMOURNE)
                player->SendInitWorldStates(player->GetZoneId(), player->GetAreaId());
            else
                player->SendUpdateWorldState(WORLD_STATE_ICECROWN_CITADEL_SHOW_ATTEMPTS, 0);
        }

        // Casts the health buff variants of the zone-wide ICC spell_area auras the target is eligible for
        void ApplyIccHealthBuff(Unit* target, uint32 raceMask)
        {
            SpellAreaForAreaMapBounds bounds = sSpellMgr->GetSpellAreaForAreaMapBounds(AREA_ICECROWN_CITADEL);
            for (SpellAreaForAreaMap::const_iterator itr = bounds.first; itr != bounds.second; ++itr)
            {
                SpellArea const* spellArea = itr->second;
                if (!(spellArea->raceMask & raceMask) || target->HasAura(spellArea->spellId))
                    continue;

                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellArea->spellId);
                if (!spellInfo || !spellInfo->HasAura(SPELL_AURA_MOD_INCREASE_HEALTH_PERCENT))
                    continue;

                if (Player* player = target->ToPlayer())
                    DoCastSpellOnPlayer(player, spellArea->spellId, false, false);
                else
                    target->AddAura(spellArea->spellId, target);
            }
        }

        void OnPlayerEnter(Player* player) override
        {
            InstanceScript::OnPlayerEnter(player);
            // for professor putricide hc
            DoRemoveAurasDueToSpellOnPlayers(SPELL_GAS_VARIABLE);
            DoRemoveAurasDueToSpellOnPlayers(SPELL_OOZE_VARIABLE);

            if (GetBossState(DATA_LADY_DEATHWHISPER) == DONE && GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != DONE)
                SpawnGunship();

            // Also covers an instance whose Gunship Battle state was set directly, which would
            // otherwise keep them hidden for good.
            if (GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == DONE && !_saurfangOutroRunning)
                RestoreHiddenSaurfangEventNpcs();

            if (GetBossState(DATA_DEATHBRINGER_SAURFANG) == DONE && !_saurfangOutroRunning)
                SpawnSaurfangCamp(false);

            if (GetBossState(DATA_SINDRAGOSA) != DONE && _isSindragosaIntroDone && !GetCreature(DATA_SINDRAGOSA) && !_events.HasTimeUntilEvent(EVENT_RESPAWN_SINDRAGOSA))
                _events.ScheduleEvent(EVENT_RESPAWN_SINDRAGOSA, 30s);

            if (_isBuffAvailable)
                ApplyIccHealthBuff(player, player->getRaceMask());
        }

        void OnCreatureCreate(Creature* creature) override
        {
            // apply ICC buff to pets/summons
            if (GetData(DATA_BUFF_AVAILABLE) && creature->GetOwnerGUID().IsPlayer() && creature->HasUnitTypeMask(UNIT_MASK_MINION | UNIT_MASK_GUARDIAN | UNIT_MASK_CONTROLLABLE_GUARDIAN) && creature->CanHaveThreatList())
            {
                if (Unit* owner = creature->GetOwner())
                    if (Player* player = owner->ToPlayer())
                        ApplyIccHealthBuff(creature, player->getRaceMask());
            }

            if (IsRampartOfSkullsFighter(creature))
                creature->AddToNotify(NOTIFY_AI_RELOCATION);

            // Check weekly here, before a possible UpdateEntry.
            // Allow creating all of them, because after killing Marrowgar some have to appear, so just hide them
            switch (creature->GetEntry())
            {
                case NPC_INFILTRATOR_MINCHAR:
                case NPC_KOR_KRON_LIEUTENANT:
                case NPC_ALCHEMIST_ADRIANNA:
                case NPC_ALRIN_THE_AGILE:
                case NPC_INFILTRATOR_MINCHAR_BQ:
                case NPC_MINCHAR_BEAM_STALKER:
                case NPC_VALITHRIA_DREAMWALKER_QUEST:
                    for (uint8 i = 0; i < WeeklyNPCs; ++i)
                    {
                        if (WeeklyQuestData[i].CreatureEntry != creature->GetEntry())
                            continue;

                        _weeklyQuestNpcGUIDs[i] = creature->GetGUID();
                        if (_weeklyQuestId10 != WeeklyQuestData[i].QuestId[0])
                            creature->SetVisible(false);
                        else if (WeeklyQuestData[i].CreatureEntry == NPC_VALITHRIA_DREAMWALKER_QUEST && GetBossState(DATA_VALITHRIA_DREAMWALKER) != DONE)
                            creature->SetVisible(false);
                    }
                    break;
                default:
                    break;
            }

            switch (creature->GetEntry())
            {
                case NPC_KOR_KRON_GENERAL:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ALLIANCE_COMMANDER);
                    break;
                case NPC_KOR_KRON_LIEUTENANT:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_SKYBREAKER_LIEUTENANT);
                    break;
                case NPC_TORTUNOK:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_ALANA_MOONSTRIKE);
                    break;
                case NPC_GERARDO_THE_SUAVE:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_TALAN_MOONSTRIKE);
                    break;
                case NPC_UVLUS_BANEFIRE:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_MALFUS_GRIMFROST);
                    break;
                case NPC_IKFIRUS_THE_VILE:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_YILI);
                    break;
                case NPC_VOL_GUK:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_JEDEBIA);
                    break;
                case NPC_HARAGG_THE_UNSEEN:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_NIBY_THE_ALMIGHTY);
                    break;
                case NPC_GARROSH_HELLSCREAM:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_KING_VARIAN_WRYNN);

                    // Summon in case of instance unload
                    if (GetBossState(DATA_THE_LICH_KING) == DONE)
                        SummonLichKingOutroNpcs();

                    break;
                case NPC_SE_HIGH_OVERLORD_SAURFANG:
                    // Only the static spawn is the event NPC - the Alliance outro summons another
                    // High Overlord Saurfang, which would otherwise clobber the guid.
                    if (creature->IsSummon())
                        break;

                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                    {
                        creature->UpdateEntry(NPC_SE_MURADIN_BRONZEBEARD, true);
                        creature->LoadEquipment();
                    }
                    _deathbringerSaurfangEventGUID = creature->GetGUID();
                    creature->LastUsedScriptID = creature->GetScriptId();
                    HideSaurfangEventNpc(creature);
                    break;
                case NPC_SE_MURADIN_BRONZEBEARD:
                    if (creature->IsSummon())
                        break;

                    _deathbringerSaurfangEventGUID = creature->GetGUID();
                    HideSaurfangEventNpc(creature);
                    break;
                case NPC_HIGH_OVERLORD_SAURFANG_DUMMY:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                    {
                        creature->UpdateEntry(NPC_MURADIN_BRONZEBEARD_DUMMY, creature->GetCreatureData());
                        creature->LoadEquipment();
                    }
                    break;
                case NPC_SE_KOR_KRON_REAVER:
                    if (creature->IsSummon())
                        break;

                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        creature->UpdateEntry(NPC_SE_SKYBREAKER_MARINE);
                    _saurfangEventGuardGUIDs.push_back(creature->GetGUID());
                    HideSaurfangEventNpc(creature);
                    break;
                case NPC_PROFESSOR_PUTRICIDE:
                    if (GetBossState(DATA_ROTFACE) == DONE && GetBossState(DATA_FESTERGUT) == DONE && !_heroicAttempts && GetData(DATA_HAS_LIMITED_ATTEMPTS) && creature->IsAlive())
                        creature->SetVisible(false);

                    break;
                case NPC_BLOOD_QUEEN_LANA_THEL:
                    if (!_heroicAttempts && GetData(DATA_HAS_LIMITED_ATTEMPTS) && creature->IsAlive())
                        creature->SetVisible(false);

                    break;
                case NPC_SINDRAGOSA:
                    if (!_heroicAttempts && GetData(DATA_HAS_LIMITED_ATTEMPTS) && creature->IsAlive())
                        creature->SetVisible(false);

                    break;
                case NPC_INVISIBLE_STALKER:
                    // Teleporter visual at center
                    if (creature->GetExactDist2d(4357.052f, 2769.421f) < 10.0f && AreUpperSpireWingsDone())
                        creature->CastSpell(creature, SPELL_ARTHAS_TELEPORTER_CEREMONY, false);

                    break;
                case NPC_THE_LICH_KING:
                    if (!_heroicAttempts && GetData(DATA_HAS_LIMITED_ATTEMPTS) && creature->IsAlive())
                        creature->SetVisible(false);

                    break;
                case NPC_HIGHLORD_TIRION_FORDRING_LK:
                    _highlordTirionFordringGUID = creature->GetGUID();
                    break;
                case NPC_TERENAS_MENETHIL_FROSTMOURNE:
                case NPC_TERENAS_MENETHIL_FROSTMOURNE_H:
                    _terenasMenethilGUID = creature->GetGUID();
                    break;
                case NPC_INFILTRATOR_MINCHAR_BQ:
                    if (_bloodQuickeningState == DONE)
                        creature->DespawnOrUnsummon(1ms);

                    break;
                case NPC_MINCHAR_BEAM_STALKER:
                    if (_bloodQuickeningState != DONE)
                    {
                        uint32 spellId = 0;
                        if (creature->GetPositionY() > 2790.0f && creature->GetPositionZ() > 420.0f)
                            spellId = SPELL_BLOOD_BEAM_VISUAL_RHAND;
                        else if (creature->GetPositionY() < 2790.0f && creature->GetPositionZ() > 420.0f)
                            spellId = SPELL_BLOOD_BEAM_VISUAL_LHAND;
                        else if (creature->GetPositionY() < 2790.0f && creature->GetPositionZ() < 420.0f)
                            spellId = SPELL_BLOOD_BEAM_VISUAL_LLEG;
                        else
                            spellId = SPELL_BLOOD_BEAM_VISUAL_RLEG;

                        creature->m_Events.AddEventAtOffset(new DelayedCastMincharEvent(creature, spellId), 1s);
                    }
                    break;
                case NPC_SKYBREAKER_DECKHAND:
                case NPC_ORGRIMS_HAMMER_CREW:
                    if (!creature->IsAlive())
                        creature->Respawn();
                    break;
                default:
                    break;
            }

            InstanceScript::OnCreatureCreate(creature);
        }

        uint32 GetCreatureEntry(ObjectGuid::LowType /*guidLow*/, CreatureData const* data) override
        {
            uint32 entry = data->id;
            switch (entry)
            {
                case NPC_HORDE_GUNSHIP_CANNON:
                case NPC_ORGRIMS_HAMMER_CREW:
                case NPC_SKY_REAVER_KORM_BLACKSCAR:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        return 0;
                    break;
                case NPC_ALLIANCE_GUNSHIP_CANNON:
                case NPC_SKYBREAKER_DECKHAND:
                case NPC_HIGH_CAPTAIN_JUSTIN_BARTLETT:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        return 0;
                    break;
                case NPC_ZAFOD_BOOMBOX:
                    if (GameObjectTemplate const* go = sObjectMgr->GetGameObjectTemplate(GO_THE_SKYBREAKER_A))
                        if ((GetTeamIdInInstance() == TEAM_ALLIANCE && data->mapid == go->moTransport.mapID) ||
                            (GetTeamIdInInstance() == TEAM_HORDE && data->mapid != go->moTransport.mapID))
                            return entry;

                    return 0;
                case NPC_IGB_MURADIN_BRONZEBEARD:
                    if ((GetTeamIdInInstance() == TEAM_ALLIANCE && data->posX > 10.0f) ||
                        (GetTeamIdInInstance() == TEAM_HORDE && data->posX < 10.0f))
                        return entry;

                    return 0;
                case NPC_SPIRE_FROSTWYRM:
                    if ((GetTeamIdInInstance() == TEAM_ALLIANCE && data->posY < 2200.0f) || (GetTeamIdInInstance() == TEAM_HORDE && data->posY > 2200.0f))
                        return 0;
                    break;
                default:
                    break;
            }

            return entry;
        }

        uint32 GetGameObjectEntry(ObjectGuid::LowType /*guidLow*/, uint32 entry) override
        {
            switch (entry)
            {
                case GO_GUNSHIP_ARMORY_H_10N:
                case GO_GUNSHIP_ARMORY_H_25N:
                case GO_GUNSHIP_ARMORY_H_10H:
                case GO_GUNSHIP_ARMORY_H_25H:
                    if (GetTeamIdInInstance() == TEAM_ALLIANCE)
                        return 0;
                    break;
                case GO_GUNSHIP_ARMORY_A_10N:
                case GO_GUNSHIP_ARMORY_A_25N:
                case GO_GUNSHIP_ARMORY_A_10H:
                case GO_GUNSHIP_ARMORY_A_25H:
                    if (GetTeamIdInInstance() == TEAM_HORDE)
                        return 0;
                    break;
                default:
                    break;
            }

            return entry;
        }

        void OnUnitDeath(Unit* unit) override
        {
            Creature* creature = unit->ToCreature();
            if (!creature)
                return;

            if (IsRampartOfSkullsFighter(creature) && !creature->GetLootRecipient())
                creature->m_Events.AddEventAtOffset(new RespawnEvent(*creature), 3s);

            switch (creature->GetEntry())
            {
                case NPC_YMIRJAR_BATTLE_MAIDEN:
                case NPC_YMIRJAR_DEATHBRINGER:
                case NPC_YMIRJAR_FROSTBINDER:
                case NPC_YMIRJAR_HUNTRESS:
                case NPC_YMIRJAR_WARLORD:
                    if (Creature* crok = GetCreature(DATA_CROK_SCOURGEBANE))
                        crok->AI()->SetGUID(creature->GetGUID(), ACTION_VRYKUL_DEATH);

                    break;
                case NPC_FROSTWING_WHELP:
                    if (_frostwyrmSpawnIds.empty())
                        return;

                    if (creature->AI()->GetData(DATA_FROSTWYRM_OWNER) == DATA_SPINESTALKER)
                    {
                        _spinestalkerTrash.erase(creature->GetSpawnId());
                        if (_spinestalkerTrash.empty())
                            if (Creature* spinestalker = GetCreature(DATA_SPINESTALKER))
                                spinestalker->AI()->DoAction(ACTION_START_FROSTWYRM);
                    }
                    else
                    {
                        _rimefangTrash.erase(creature->GetSpawnId());
                        if (_rimefangTrash.empty())
                            if (Creature* rimefang = GetCreature(DATA_RIMEFANG))
                                rimefang->AI()->DoAction(ACTION_START_FROSTWYRM);
                    }
                    break;
                case NPC_RIMEFANG:
                case NPC_SPINESTALKER:
                    if (GetData(DATA_HAS_LIMITED_ATTEMPTS) && !_heroicAttempts)
                        return;

                    if (GetBossState(DATA_SINDRAGOSA) == DONE)
                        return;

                    _frostwyrmSpawnIds.erase(creature->GetSpawnId());
                    if (_frostwyrmSpawnIds.empty())
                        if (Creature* boss = instance->SummonCreature(NPC_SINDRAGOSA, SindragosaSpawnPos))
                            boss->AI()->DoAction(ACTION_START_FROSTWYRM);

                    break;
                case NPC_DEATHSPEAKER_SERVANT:
                    if (Creature* trigger = creature->SummonCreature(WORLD_TRIGGER, *creature, TEMPSUMMON_TIMED_DESPAWN, 10000))
                    {
                        trigger->CastSpell(trigger, SPELL_VOID_ZONE_VISUAL, true);
                        creature->SummonCreature(NPC_RISEN_DEATHSPEAKER_SERVANT, *creature, TEMPSUMMON_MANUAL_DESPAWN);
                        creature->DespawnOrUnsummon(3s);
                    }
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            // Doors are added per entry below instead of through the base, which would also register the 25-man-only portcullises on 10-man
            AddObject(go);

            switch (go->GetEntry())
            {
                case GO_SPIRIT_ALARM_1:
                case GO_SPIRIT_ALARM_2:
                case GO_SPIRIT_ALARM_3:
                case GO_SPIRIT_ALARM_4:
                    SetPositionTraps(go);
                    break;
                case GO_GEIST_ALARM_1:
                case GO_GEIST_ALARM_2:
                    go->SetPosition(go->GetPositionX() + urand(0, 2) * 20.0f * (go->GetEntry() == GO_GEIST_ALARM_1 ? -1.0f : 1.0f), go->GetPositionY(), go->GetPositionZ(), go->GetOrientation());
                    break;
                case GO_DOODAD_ICECROWN_ICEWALL02:
                case GO_ICEWALL:
                case GO_LORD_MARROWGAR_S_ENTRANCE:
                case GO_ORATORY_OF_THE_DAMNED_ENTRANCE:
                case GO_ORANGE_PLAGUE_MONSTER_ENTRANCE:
                case GO_GREEN_PLAGUE_MONSTER_ENTRANCE:
                case GO_CRIMSON_HALL_DOOR:
                case GO_BLOOD_ELF_COUNCIL_DOOR:
                case GO_BLOOD_ELF_COUNCIL_DOOR_RIGHT:
                case GO_DOODAD_ICECROWN_BLOODPRINCE_DOOR_01:
                case GO_DOODAD_ICECROWN_GRATE_01:
                case GO_GREEN_DRAGON_BOSS_ENTRANCE:
                case GO_GREEN_DRAGON_BOSS_EXIT:
                case GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_02:
                case GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_03:
                case GO_SINDRAGOSA_SHORTCUT_ENTRANCE_DOOR:
                case GO_SINDRAGOSA_SHORTCUT_EXIT_DOOR:
                case GO_ICE_WALL:
                case GO_SINDRAGOSA_ENTRANCE_DOOR:
                case GO_SAURFANG_S_DOOR:
                    AddDoor(go);
                    break;
                case GO_SCIENTIST_ENTRANCE:
                    HandleGameObject(go->GetGUID(), _putricideEventProgress & PUTRICIDE_EVENT_FLAG_TRAP_FINISHED, go);
                    break;
                // these 2 gates are functional only on 25man modes
                case GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_01:
                case GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_04:
                    if (instance->Is25ManRaid())
                        AddDoor(go);
                    break;
                case GO_SAURFANG_CAMP_FORGE:
                case GO_SAURFANG_CAMP_BONFIRE:
                case GO_SAURFANG_CAMP_ANVIL:
                    // Camp props belong to the aftermath; their spawn rows are unconditional, hence the despawn.
                    _saurfangCampGUIDs.push_back(go->GetGUID());
                    if (GetBossState(DATA_DEATHBRINGER_SAURFANG) != DONE)
                        go->DespawnOrUnsummon(0ms, Seconds(WEEK));
                    // The despawn is persisted, so an instance restarted after the outro comes back
                    // with them hidden. Horde only - the Alliance camp summons its own props.
                    else if (GetTeamIdInInstance() == TEAM_HORDE)
                        go->Respawn();
                    break;
                case GO_PLAGUE_SIGIL:
                    if (GetBossState(DATA_PROFESSOR_PUTRICIDE) == DONE)
                        HandleGameObject(go->GetGUID(), false, go);

                    break;
                case GO_BLOODWING_SIGIL:
                    if (GetBossState(DATA_BLOOD_QUEEN_LANA_THEL) == DONE)
                        HandleGameObject(go->GetGUID(), false, go);

                    break;
                case GO_SIGIL_OF_THE_FROSTWING:
                    if (GetBossState(DATA_SINDRAGOSA) == DONE)
                        HandleGameObject(go->GetGUID(), false, go);

                    break;
                case GO_SCIENTIST_AIRLOCK_DOOR_COLLISION:
                    HandleGameObject(go->GetGUID(), AreBothPutricideValvesUsed(), go);
                    break;
                case GO_SCIENTIST_AIRLOCK_DOOR_ORANGE:
                    if (AreBothPutricideValvesUsed())
                        go->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
                    else
                        HandleGameObject(go->GetGUID(), !(_putricideEventProgress & PUTRICIDE_EVENT_FLAG_FESTERGUT_VALVE), go);

                    break;
                case GO_SCIENTIST_AIRLOCK_DOOR_GREEN:
                    if (AreBothPutricideValvesUsed())
                        go->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
                    else
                        HandleGameObject(go->GetGUID(), !(_putricideEventProgress & PUTRICIDE_EVENT_FLAG_ROTFACE_VALVE), go);

                    break;
                case GO_DOODAD_ICECROWN_ORANGETUBES02:
                    if (_putricideEventProgress & PUTRICIDE_EVENT_FLAG_FESTERGUT_VALVE)
                        HandleGameObject(go->GetGUID(), true, go);

                    break;
                case GO_DOODAD_ICECROWN_GREENTUBES02:
                    if (_putricideEventProgress & PUTRICIDE_EVENT_FLAG_ROTFACE_VALVE)
                        HandleGameObject(go->GetGUID(), true, go);

                    break;
                case GO_GAS_RELEASE_VALVE:
                    if (GetBossState(DATA_FESTERGUT) != DONE)
                        go->SetGameObjectFlag(GO_FLAG_INTERACT_COND | GO_FLAG_NOT_SELECTABLE);
                    break;
                case GO_OOZE_RELEASE_VALVE:
                    if (GetBossState(DATA_ROTFACE) != DONE)
                        go->SetGameObjectFlag(GO_FLAG_INTERACT_COND | GO_FLAG_NOT_SELECTABLE);
                    break;
                case GO_CACHE_OF_THE_DREAMWALKER_10N:
                case GO_CACHE_OF_THE_DREAMWALKER_25N:
                case GO_CACHE_OF_THE_DREAMWALKER_10H:
                case GO_CACHE_OF_THE_DREAMWALKER_25H:
                    if (Creature* valithria = GetCreature(DATA_VALITHRIA_DREAMWALKER))
                        go->SetLootRecipient(valithria);

                    go->RemoveGameObjectFlag(GO_FLAG_LOCKED | GO_FLAG_NOT_SELECTABLE | GO_FLAG_NODESPAWN);
                    break;
                case GO_SCOURGE_TRANSPORTER_LK:
                    if (AreUpperSpireWingsDone())
                        go->SetGoState(GO_STATE_ACTIVE);

                    break;
                case GO_ARTHAS_PLATFORM:
                    // this enables movement at The Frozen Throne, when printed this value is 0.000000f
                    // however, when represented as integer client will accept only this value
                    go->SetUInt32Value(GAMEOBJECT_PARENTROTATION, 5535469);
                    break;
                case GO_ARTHAS_PRECIPICE:
                    go->SetUInt32Value(GAMEOBJECT_PARENTROTATION, 4178312);
                    break;
                case GO_FROZEN_LAVAMAN:
                    if (GetBossState(DATA_THE_LICH_KING) == DONE)
                        go->SetRespawnTime(WEEK);

                    break;
                case GO_LAVAMAN_PILLARS_CHAINED:
                    if (GetBossState(DATA_THE_LICH_KING) == DONE)
                        go->SetRespawnTime(WEEK);

                    break;
                case GO_LAVAMAN_PILLARS_UNCHAINED:
                    if (GetBossState(DATA_THE_LICH_KING) == DONE)
                        go->SetRespawnTime(WEEK);

                    break;
                case GO_SCOURGE_TRANSPORTER_FIRST:
                    AddDoor(go);
                    if (GetBossState(DATA_LORD_MARROWGAR) == DONE)
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go) override
        {
            RemoveObject(go);

            switch (go->GetEntry())
            {
                case GO_DOODAD_ICECROWN_ICEWALL02:
                case GO_ICEWALL:
                case GO_LORD_MARROWGAR_S_ENTRANCE:
                case GO_ORATORY_OF_THE_DAMNED_ENTRANCE:
                case GO_SAURFANG_S_DOOR:
                case GO_ORANGE_PLAGUE_MONSTER_ENTRANCE:
                case GO_GREEN_PLAGUE_MONSTER_ENTRANCE:
                case GO_SCIENTIST_ENTRANCE:
                case GO_CRIMSON_HALL_DOOR:
                case GO_BLOOD_ELF_COUNCIL_DOOR:
                case GO_BLOOD_ELF_COUNCIL_DOOR_RIGHT:
                case GO_DOODAD_ICECROWN_BLOODPRINCE_DOOR_01:
                case GO_DOODAD_ICECROWN_GRATE_01:
                case GO_GREEN_DRAGON_BOSS_ENTRANCE:
                case GO_GREEN_DRAGON_BOSS_EXIT:
                case GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_01:
                case GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_02:
                case GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_03:
                case GO_DOODAD_ICECROWN_ROOSTPORTCULLIS_04:
                case GO_SINDRAGOSA_SHORTCUT_ENTRANCE_DOOR:
                case GO_SINDRAGOSA_SHORTCUT_EXIT_DOOR:
                case GO_ICE_WALL:
                case GO_SCOURGE_TRANSPORTER_FIRST:
                    RemoveDoor(go);
                    break;
                case GO_THE_SKYBREAKER_A:
                case GO_ORGRIMS_HAMMER_H:
                    _gunshipGUID.Clear();
                    break;
                default:
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_SAURFANG_OUTRO_ZEPPELIN:
                    // DONE once it has come to rest, so the outro can wait for the ship instead of guessing.
                    return _saurfangZeppelinDocked ? DONE : IN_PROGRESS;
                case DATA_BUFF_AVAILABLE:
                    return (_isBuffAvailable ? 1 : 0);
                case DATA_WEEKLY_QUEST_ID:
                    return _weeklyQuestId10;
                case DATA_PUTRICIDE_TRAP_STATE:
                    if (!(_putricideEventProgress & PUTRICIDE_EVENT_FLAG_FESTERGUT_VALVE) || !(_putricideEventProgress & PUTRICIDE_EVENT_FLAG_ROTFACE_VALVE))
                        return TO_BE_DECIDED;

                    if (_putricideEventProgress & PUTRICIDE_EVENT_FLAG_TRAP_INPROGRESS)
                        return IN_PROGRESS;

                    if (_putricideEventProgress & PUTRICIDE_EVENT_FLAG_TRAP_FINISHED)
                        return DONE;

                    return NOT_STARTED;
                case DATA_HAS_LIMITED_ATTEMPTS:
                    return (instance->IsHeroic() ? 1 : 0);
                case DATA_LK_HC_AVAILABLE:
                    return (_lichKingHeroicAvailable ? 1 : 0);
                case DATA_SINDRAGOSA_FROSTWYRMS:
                    return _frostwyrmSpawnIds.size();
                case DATA_SPINESTALKER:
                    return _spinestalkerTrash.size();
                case DATA_RIMEFANG:
                    return _rimefangTrash.size();
                case DATA_COLDFLAME_JETS:
                    return _coldflameJetsState;
                case DATA_TEAMID_IN_INSTANCE:
                    return GetTeamIdInInstance();
                case DATA_BLOOD_QUICKENING_STATE:
                    return _bloodQuickeningState;
                case DATA_HEROIC_ATTEMPTS:
                    return _heroicAttempts;
                case DATA_SINDRAGOSA_INTRO:
                    return (_isSindragosaIntroDone ? 1 : 0);
                default:
                    break;
            }

            return 0;
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_ICECROWN_GUNSHIP_BATTLE:
                    return _gunshipGUID;
                case DATA_SAURFANG_EVENT_NPC:
                    return _deathbringerSaurfangEventGUID;
                case DATA_HIGHLORD_TIRION_FORDRING:
                    return _highlordTirionFordringGUID;
                case DATA_TERENAS_MENETHIL:
                    return _terenasMenethilGUID;
                default:
                    break;
            }

            return InstanceScript::GetGuidData(type);
        }

        void HandleDropAttempt(bool drop = true)
        {
            if (!GetData(DATA_HAS_LIMITED_ATTEMPTS))
                return;

            if (drop && _heroicAttempts)
            {
                --_heroicAttempts;
                DoUpdateWorldState(WORLD_STATE_ICECROWN_CITADEL_ATTEMPTS_REMAINING, _heroicAttempts);
                SaveToDB();
            }

            if (_heroicAttempts)
                return;

            if (GetBossState(DATA_ROTFACE) == DONE && GetBossState(DATA_FESTERGUT) == DONE)
                if (Creature* professor = GetCreature(DATA_PROFESSOR_PUTRICIDE))
                    if (professor->IsAlive())
                        professor->SetVisible(false);

            if (Creature* bloodQueen = GetCreature(DATA_BLOOD_QUEEN_LANA_THEL))
                if (bloodQueen->IsAlive())
                    bloodQueen->SetVisible(false);

            if (Creature* sindragosa = GetCreature(DATA_SINDRAGOSA))
                if (sindragosa->IsAlive())
                    sindragosa->SetVisible(false);

            if (Creature* theLichKing = GetCreature(DATA_THE_LICH_KING))
                if (theLichKing->IsAlive())
                    theLichKing->SetVisible(false);
        }

        void RemoveBackPack()
        {
            for (auto const& itr : instance->GetPlayers())
                if (Player* player = itr.GetSource())
                    player->DestroyItemCount(ITEM_GOBLIN_ROCKET_PACK, player->GetItemCount(ITEM_GOBLIN_ROCKET_PACK), true);
        }

        bool AreUpperSpireWingsDone() const
        {
            return GetBossState(DATA_PROFESSOR_PUTRICIDE) == DONE && GetBossState(DATA_BLOOD_QUEEN_LANA_THEL) == DONE && GetBossState(DATA_SINDRAGOSA) == DONE;
        }

        bool AreBothPutricideValvesUsed() const
        {
            return (_putricideEventProgress & PUTRICIDE_EVENT_FLAG_FESTERGUT_VALVE) && (_putricideEventProgress & PUTRICIDE_EVENT_FLAG_ROTFACE_VALVE);
        }

        // Collision and both airlock gates follow the valves: all open once both are used, otherwise each gate until its valve is
        void UpdatePutricideAirlock()
        {
            HandleGameObject(DATA_PUTRICIDE_COLLISION, AreBothPutricideValvesUsed());
            if (AreBothPutricideValvesUsed())
            {
                for (uint32 gateData : { DATA_PUTRICIDE_GATE_ORANGE, DATA_PUTRICIDE_GATE_GREEN })
                    if (GameObject* gate = GetGameObject(gateData))
                        gate->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
            }
            else
            {
                HandleGameObject(DATA_PUTRICIDE_GATE_ORANGE, !(_putricideEventProgress & PUTRICIDE_EVENT_FLAG_FESTERGUT_VALVE));
                HandleGameObject(DATA_PUTRICIDE_GATE_GREEN, !(_putricideEventProgress & PUTRICIDE_EVENT_FLAG_ROTFACE_VALVE));
            }
        }

        // Upper Spire wing bosses: open the Frozen Throne teleporter once all are down, and a normal kill locks the heroic Lich King
        void HandleUpperSpireBossDone()
        {
            CheckLichKingAvailability();

            if (!instance->IsHeroic() && _lichKingHeroicAvailable)
            {
                _lichKingHeroicAvailable = false;
                SaveToDB();
            }
        }

        void SummonLichKingOutroNpcs()
        {
            instance->SummonCreature(NPC_LADY_JAINA_PROUDMOORE_QUEST, JainaSpawnPos);
            instance->SummonCreature(NPC_MURADIN_BRONZEBEARD_QUEST, MuradinSpawnPos);
            instance->SummonCreature(NPC_UTHER_THE_LIGHTBRINGER_QUEST, UtherSpawnPos);
            instance->SummonCreature(NPC_LADY_SYLVANAS_WINDRUNNER_QUEST, SylvanasSpawnPos);
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case DATA_LORD_MARROWGAR:
                    if (state == DONE)
                    {
                        _weeklyQuestId10 = RAND(QUEST_BLOOD_QUICKENING_10, QUEST_RESIDUE_RENDEZVOUS_10, QUEST_RESPITE_FOR_A_TORMENTED_SOUL_10, QUEST_DEPROGRAMMING_10, QUEST_SECURING_THE_RAMPARTS_10);
                        SetData(DATA_WEEKLY_QUEST_ID, 0); // show required hidden npcs
                        if (GameObject* transporter = GetGameObject(DATA_SCOURGE_TRANSPORTER_FIRST))
                            transporter->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);

                        SaveToDB();
                    }
                    break;
                case DATA_LADY_DEATHWHISPER:
                    if (state == DONE)
                        SpawnGunship();
                    break;
                case DATA_ICECROWN_GUNSHIP_BATTLE:
                    if (state == DONE)
                    {
                        if (GameObject* loot = GetGameObject(DATA_GUNSHIP_ARMORY))
                        {
                            loot->SetLootRecipient(instance);
                            loot->RemoveGameObjectFlag(GO_FLAG_LOCKED | GO_FLAG_NOT_SELECTABLE | GO_FLAG_NODESPAWN);
                        }
                    }
                    else if (state == FAIL)
                        _events.ScheduleEvent(EVENT_RESPAWN_GUNSHIP, 30s);

                    break;
                case DATA_DEATHBRINGER_SAURFANG:
                    switch (state)
                    {
                        case DONE:
                            if (GameObject* loot = GetGameObject(DATA_DEATHBRINGERS_CACHE))
                            {
                                if (Creature* deathbringer = GetCreature(DATA_DEATHBRINGER_SAURFANG))
                                    loot->SetLootRecipient(deathbringer);

                                loot->RemoveGameObjectFlag(GO_FLAG_LOCKED | GO_FLAG_NOT_SELECTABLE | GO_FLAG_NODESPAWN);
                            }

                            // Not raised here: DONE fires the moment the boss dies. The outro asks
                            // via SetData(DATA_SAURFANG_CAMP); OnPlayerEnter covers saved instances.
                            [[fallthrough]];
                        case NOT_STARTED:
                            if (GameObject* teleporter = GetGameObject(DATA_SAURFANG_TELEPORT))
                            {
                                HandleGameObject(teleporter->GetGUID(), true, teleporter);
                                teleporter->RemoveGameObjectFlag(GO_FLAG_IN_USE);
                            }
                            break;
                        default:
                            break;
                    }
                    break;
                case DATA_FESTERGUT:
                    if (state == DONE)
                    {
                        if (GameObject* go = GetGameObject(DATA_GAS_RELEASE_VALVE))
                            go->RemoveGameObjectFlag(GO_FLAG_INTERACT_COND | GO_FLAG_NOT_SELECTABLE);

                        if (GetBossState(DATA_ROTFACE) == DONE)
                            HandleDropAttempt(false);
                    }
                    break;
                case DATA_ROTFACE:
                    if (state == DONE)
                    {
                        if (GameObject* go = GetGameObject(DATA_OOZE_RELEASE_VALVE))
                            go->RemoveGameObjectFlag(GO_FLAG_INTERACT_COND | GO_FLAG_NOT_SELECTABLE);

                        if (GetBossState(DATA_FESTERGUT) == DONE)
                            HandleDropAttempt(false);
                    }
                    break;
                case DATA_PROFESSOR_PUTRICIDE:
                    HandleGameObject(DATA_PUTRICIDE_ENTRANCE_DOOR, (_putricideEventProgress & PUTRICIDE_EVENT_FLAG_TRAP_FINISHED) && state != IN_PROGRESS);
                    HandleGameObject(DATA_PLAGUE_SIGIL, state != DONE);
                    if (state == DONE)
                        HandleUpperSpireBossDone();
                    else if (state == FAIL)
                        HandleDropAttempt();

                    break;
                case DATA_BLOOD_QUEEN_LANA_THEL:
                    HandleGameObject(DATA_BLOODWING_SIGIL, state != DONE);
                    if (state == DONE)
                        HandleUpperSpireBossDone();
                    else if (state == FAIL)
                        HandleDropAttempt();

                    break;
                case DATA_VALITHRIA_DREAMWALKER:
                    if (state == DONE)
                        SetData(DATA_WEEKLY_QUEST_ID, GetData(DATA_WEEKLY_QUEST_ID)); // will show weekly quest npc if necessary
                    break;
                case DATA_SINDRAGOSA:
                    HandleGameObject(DATA_FROSTWING_SIGIL, state != DONE);
                    if (state == DONE)
                        HandleUpperSpireBossDone();
                    else if (state == FAIL)
                    {
                        _isSindragosaIntroDone = true;
                        HandleDropAttempt();
                    }
                    break;
                case DATA_THE_LICH_KING:
                    // dramatically increase visibility range during fight to seeing frostmourne room
                    instance->SetVisibilityRange(state == IN_PROGRESS ? 500.0f : 200.0f);

                    if (state == FAIL)
                    {
                        _events.CancelEvent(EVENT_QUAKE_SHATTER);
                        _events.CancelEvent(EVENT_REBUILD_PLATFORM);

                        HandleDropAttempt();
                    }

                    if (state == DONE)
                    {
                        if (GameObject* bolvar = GetGameObject(DATA_FROZEN_BOLVAR))
                            bolvar->SetRespawnTime(WEEK);

                        if (GameObject* pillars = GetGameObject(DATA_PILLARS_CHAINED))
                            pillars->SetRespawnTime(WEEK);

                        if (GameObject* pillars = GetGameObject(DATA_PILLARS_UNCHAINED))
                            pillars->SetRespawnTime(WEEK);

                        SummonLichKingOutroNpcs();
                    }
                    break;
                default:
                    break;
            }

            return true;
        }

        void SpawnGunship()
        {
            if (!_gunshipGUID && instance->HavePlayers())
            {
                SetBossState(DATA_ICECROWN_GUNSHIP_BATTLE, NOT_STARTED);
                uint32 gunshipEntry = GetTeamIdInInstance() == TEAM_HORDE ? GO_ORGRIMS_HAMMER_H : GO_THE_SKYBREAKER_A;
                if (MotionTransport* gunship = sTransportMgr->CreateTransport(gunshipEntry, 0, instance))
                {
                    _gunshipGUID = gunship->GetGUID();
                    gunship->setActive(false);
                }
            }
        }

        // Hidden rather than despawned: a despawned creature leaves the map and its guid would no
        // longer resolve.
        void HideSaurfangEventNpc(Creature* creature)
        {
            if (GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == DONE)
                return;

            creature->SetVisible(false);
        }

        void RestoreSaurfangEventNpc(Creature* creature)
        {
            float x, y, z, o;
            creature->GetHomePosition(x, y, z, o);
            creature->NearTeleportTo(x, y, z, o);
            creature->SetStandState(UNIT_STAND_STATE_STAND);
            creature->SetEmoteState(EMOTE_ONESHOT_NONE);
            creature->SetSheath(SHEATH_STATE_UNARMED);
            creature->SetVisible(true);
        }

        void SpawnSaurfangEventNpcs()
        {
            if (Creature* captain = instance->GetCreature(_deathbringerSaurfangEventGUID))
                RestoreSaurfangEventNpc(captain);

            for (ObjectGuid const& guid : _saurfangEventGuardGUIDs)
                if (Creature* guard = instance->GetCreature(guid))
                    RestoreSaurfangEventNpc(guard);
        }

        // Only the ones left hidden: a scene in progress has them visible and placed, and
        // teleporting those to their spawn points would break it mid-run.
        void RestoreHiddenSaurfangEventNpcs()
        {
            if (Creature* captain = instance->GetCreature(_deathbringerSaurfangEventGUID))
                if (!captain->IsVisible())
                    RestoreSaurfangEventNpc(captain);

            for (ObjectGuid const& guid : _saurfangEventGuardGUIDs)
                if (Creature* guard = instance->GetCreature(guid))
                    if (!guard->IsVisible())
                        RestoreSaurfangEventNpc(guard);
        }

        void DespawnSaurfangZeppelinPassenger()
        {
            if (Creature* passenger = instance->GetCreature(_saurfangZeppelinPassengerGUID))
                passenger->DespawnOrUnsummon();

            _saurfangZeppelinPassengerGUID.Clear();
        }

        // staged runs the on-screen build: teleporters and workers first, the tents once the workers
        // have hammered a while, then the vendors walking in. Unstaged drops the finished camp at
        // once, for an instance already DONE. The Horde crew is quicker off the mark than the Alliance one.
        void SpawnSaurfangCamp(bool staged)
        {
            if (_saurfangCampSpawned || !instance->HavePlayers())
                return;

            _saurfangCampSpawned = true;
            SummonSaurfangCampTeleporters();
            SpawnSaurfangEventNpcs();
            if (!staged)
            {
                ActivateSaurfangCampTeleporters();
                SpawnSaurfangCampTents();
                SummonSaurfangCampVendor(true, false);
                SummonSaurfangCampVendor(false, false);
                return;
            }

            bool const horde = GetTeamIdInInstance() == TEAM_HORDE;
            _events.ScheduleEvent(EVENT_SAURFANG_CAMP_ACTIVATE, horde ? 2s : 1s + 700ms);
            _events.ScheduleEvent(EVENT_SAURFANG_CAMP_WORKERS, horde ? 0s : 5s + 800ms);
            _events.ScheduleEvent(EVENT_SAURFANG_CAMP_WORKER_0_RUN, horde ? 2s : 11s);
            _events.ScheduleEvent(EVENT_SAURFANG_CAMP_WORKER_1_RUN, horde ? 2s : 8s + 200ms);
            _events.ScheduleEvent(EVENT_SAURFANG_CAMP_TENTS, horde ? 26s + 800ms : 34s + 500ms);
            _events.ScheduleEvent(EVENT_SAURFANG_CAMP_VENDORS, horde ? 30s + 400ms : 41s + 300ms);
        }

        // Summoned ready is the inert model; activating it is what turns the beam on.
        void SummonSaurfangCampTeleporters()
        {
            uint32 const teleporter = GetTeamIdInInstance() == TEAM_HORDE ? GO_SAURFANG_CAMP_TELEPORTER_H : GO_SAURFANG_CAMP_TELEPORTER_A;
            for (uint8 i = 0; i < 2; ++i)
                if (GameObject* go = instance->SummonGameObject(teleporter, SaurfangCampTeleporterPos[i], 0.0f, 0.0f, 0.0f, 0.0f, WEEK))
                    _saurfangCampTeleporterGUIDs[i] = go->GetGUID();
        }

        void ActivateSaurfangCampTeleporters()
        {
            for (ObjectGuid const& guid : _saurfangCampTeleporterGUIDs)
                if (GameObject* go = instance->GetGameObject(guid))
                    go->SetGoState(GO_STATE_ACTIVE);
        }

        void SpawnSaurfangCampWorkers()
        {
            uint32 const worker = GetTeamIdInInstance() == TEAM_HORDE ? NPC_CAMP_WARSONG_PEON : NPC_CAMP_ALLIANCE_MASON;
            for (uint8 i = 0; i < 2; ++i)
            {
                if (Creature* builder = instance->SummonCreature(worker, SaurfangCampTeleporterPos[i]))
                {
                    _saurfangCampWorkerGUIDs[i] = builder->GetGUID();
                    builder->SetReactState(REACT_PASSIVE);
                    builder->CastSpell(builder, SPELL_SIMPLE_TELEPORT, true);
                }
            }
        }

        // The hammering only starts once he is standing at the site.
        void SendSaurfangCampWorkerOut(uint8 i)
        {
            Creature* builder = instance->GetCreature(_saurfangCampWorkerGUIDs[i]);
            if (!builder)
                return;

            Position const& site = GetTeamIdInInstance() == TEAM_HORDE ? SaurfangCampWorkPosH[i] : SaurfangCampWorkPosA[i];
            builder->SetWalk(false);
            builder->GetMotionMaster()->MovePoint(POINT_CAMP_WORKER_SITE, site);
            _events.ScheduleEvent(i ? EVENT_SAURFANG_CAMP_WORKER_1_WORK : EVENT_SAURFANG_CAMP_WORKER_0_WORK, RunTimeTo(builder, site));
        }

        void SetSaurfangCampWorkerWorking(uint8 i)
        {
            Creature* builder = instance->GetCreature(_saurfangCampWorkerGUIDs[i]);
            if (!builder)
                return;

            Position const& site = GetTeamIdInInstance() == TEAM_HORDE ? SaurfangCampWorkPosH[i] : SaurfangCampWorkPosA[i];
            builder->SetFacingTo(site.GetOrientation());
            builder->SetEmoteState(EMOTE_STATE_WORK_MINING);
        }

        void SpawnSaurfangCampTents()
        {
            bool const horde = GetTeamIdInInstance() == TEAM_HORDE;
            uint32 const tents[2] =
            {
                static_cast<uint32>(horde ? GO_SAURFANG_CAMP_TENT_H1 : GO_SAURFANG_CAMP_TENT_A),
                static_cast<uint32>(horde ? GO_SAURFANG_CAMP_TENT_H2 : GO_SAURFANG_CAMP_TENT_A)
            };

            Position const* tentPos = horde ? SaurfangCampTentPosH : SaurfangCampTentPosA;
            for (uint8 i = 0; i < 2; ++i)
                instance->SummonGameObject(tents[i], tentPos[i], 0.0f, 0.0f, 0.0f, 0.0f, WEEK);

            if (horde)
            {
                for (ObjectGuid const& guid : _saurfangCampGUIDs)
                    if (GameObject* camp = instance->GetGameObject(guid))
                        camp->Respawn();
            }
            else
            {
                instance->SummonGameObject(GO_SAURFANG_CAMP_FORGE, SaurfangCampForgePosA, 0.0f, 0.0f, 0.0f, 0.0f, WEEK);
                instance->SummonGameObject(GO_SAURFANG_CAMP_ANVIL_A, SaurfangCampAnvilPosA, 0.0f, 0.0f, 0.0f, 0.0f, WEEK);
                instance->SummonGameObject(GO_SAURFANG_CAMP_BANNER_A, SaurfangCampBannerPosA, 0.0f, 0.0f, 0.0f, 0.0f, WEEK);
            }
        }

        // They down tools the moment the tents drop, run back to their pads and vanish there.
        void SendSaurfangCampWorkersBack()
        {
            for (uint8 i = 0; i < 2; ++i)
            {
                if (Creature* builder = instance->GetCreature(_saurfangCampWorkerGUIDs[i]))
                {
                    builder->SetEmoteState(EMOTE_ONESHOT_NONE);
                    builder->SetWalk(false);
                    builder->GetMotionMaster()->MovePoint(POINT_CAMP_WORKER_TELEPORTER, SaurfangCampTeleporterPos[i]);
                    builder->DespawnOrUnsummon(RunTimeTo(builder, SaurfangCampTeleporterPos[i]));
                }
                _saurfangCampWorkerGUIDs[i].Clear();
            }
        }

        // walkIn false drops the vendor straight on his pitch, for a camp not built on screen.
        void SummonSaurfangCampVendor(bool smith, bool walkIn)
        {
            bool const horde = GetTeamIdInInstance() == TEAM_HORDE;
            uint32 const entry = smith ? (horde ? NPC_CAMP_MORGAN_DAYBLAZE : NPC_CAMP_SHELY_STEELBOWELS)
                                       : (horde ? NPC_CAMP_APOTHECARY_CANDITH_TOMAS : NPC_CAMP_BRAZIE_GETZ);
            if (!walkIn)
            {
                instance->SummonCreature(entry, smith ? (horde ? SaurfangCampBlacksmithPos : SaurfangCampBlacksmithPosA)
                                                      : (horde ? SaurfangCampGeneralGoodsPos : SaurfangCampGeneralGoodsPosA));
                return;
            }

            Creature* vendor = instance->SummonCreature(entry, SaurfangCampTeleporterPos[smith ? 0 : 1]);
            if (!vendor)
                return;

            vendor->CastSpell(vendor, SPELL_SIMPLE_TELEPORT, true);
            // The path ends on the pitch, facing the customers.
            vendor->GetMotionMaster()->MoveWaypoint(smith ? (horde ? PATH_CAMP_MORGAN_DAYBLAZE : PATH_CAMP_SHELY_STEELBOWELS)
                                                          : (horde ? PATH_CAMP_APOTHECARY_CANDITH_TOMAS : PATH_CAMP_BRAZIE_GETZ), false);
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_SAURFANG_CAMP:
                    // The boss is DONE for the whole outro, so the encounter state alone cannot tell
                    // "outro playing" from "outro over".
                    if (data == IN_PROGRESS)
                    {
                        _saurfangOutroRunning = true;
                        // Safety net: an instance emptying mid-outro would leave the flag set and
                        // the camp could never be raised.
                        _events.ScheduleEvent(EVENT_SAURFANG_OUTRO_TIMEOUT, 8min);
                    }
                    else if (data == DONE)
                    {
                        _events.CancelEvent(EVENT_SAURFANG_OUTRO_TIMEOUT);
                        _saurfangOutroRunning = false;
                        SpawnSaurfangCamp(true);
                    }
                    break;
                case DATA_SAURFANG_OUTRO_ZEPPELIN:
                    if (data == IN_PROGRESS)
                    {
                        if (_saurfangZeppelinGUID)
                            break;

                        _saurfangZeppelinDocked = false;
                        _saurfangZeppelinLeaving = false;
                        MotionTransport* zeppelin = sTransportMgr->CreateTransport(GO_SAURFANG_OUTRO_ZEPPELIN, 0, instance);
                        if (!zeppelin)
                            break;

                        _saurfangZeppelinGUID = zeppelin->GetGUID();
                        zeppelin->setActive(true);
                        _events.ScheduleEvent(EVENT_SAURFANG_ZEPPELIN_DOCK, 1s);

                        // Saurfang rides in on deck; the one stepping off at the edge replaces him.
                        float x, y, z, o;
                        SaurfangZeppelinPassengerOffset.GetPosition(x, y, z, o);
                        zeppelin->CalculatePassengerPosition(x, y, z, &o);
                        if (Creature* passenger = instance->SummonCreature(NPC_SE_HIGH_OVERLORD_SAURFANG, Position(x, y, z, o)))
                        {
                            zeppelin->AddPassenger(passenger, true);
                            // Clients already got his create packet without the transport; the stop
                            // spline carries the transport guid and puts him on deck for them.
                            passenger->StopMovingOnCurrentPos();
                            passenger->SetReactState(REACT_PASSIVE);
                            passenger->SetSheath(SHEATH_STATE_MELEE);
                            passenger->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                            _saurfangZeppelinPassengerGUID = passenger->GetGUID();
                        }
                    }
                    else if (data == SPECIAL)
                        DespawnSaurfangZeppelinPassenger();
                    // Asked for twice (departure, then cleanup); without the guard the second call
                    // would restart the removal timer.
                    else if (_saurfangZeppelinGUID && !_saurfangZeppelinLeaving)
                    {
                        _events.CancelEvent(EVENT_SAURFANG_ZEPPELIN_DOCK);
                        _saurfangZeppelinDocked = false;
                        _saurfangZeppelinLeaving = true;
                        if (GameObject* go = instance->GetGameObject(_saurfangZeppelinGUID))
                            if (MotionTransport* zeppelin = go->ToMotionTransport())
                                zeppelin->EnableMovement(true);

                        // Releasing _pendingStop does not launch it: it leaves when the stop frame
                        // DepartureTime comes round, ~24s, and takes about 50s more to fly back to
                        // its berth above the rise. Removal is once it is back there.
                        _events.ScheduleEvent(EVENT_SAURFANG_ZEPPELIN_REMOVE, 80s);
                    }
                    break;
                case DATA_BUFF_AVAILABLE:
                    _isBuffAvailable = data != 0;
                    if (!_isBuffAvailable)
                    {
                        instance->DoForAllPlayers([&](Player* player)
                        {
                            player->UpdateAreaDependentAuras(player->GetAreaId());
                            for (Unit* controlled : player->m_Controlled)
                            {
                                Unit::AuraMap& auras = controlled->GetOwnedAuras();
                                for (Unit::AuraMap::iterator itr = auras.begin(); itr != auras.end();)
                                {
                                    switch (itr->second->GetId())
                                    {
                                        case SPELL_HELLSCREAMS_WARSONG_5:
                                        case SPELL_HELLSCREAMS_WARSONG_10:
                                        case SPELL_HELLSCREAMS_WARSONG_15:
                                        case SPELL_HELLSCREAMS_WARSONG_20:
                                        case SPELL_HELLSCREAMS_WARSONG_25:
                                        case SPELL_HELLSCREAMS_WARSONG_30:
                                        case SPELL_STRENGTH_OF_WRYNN_5:
                                        case SPELL_STRENGTH_OF_WRYNN_10:
                                        case SPELL_STRENGTH_OF_WRYNN_15:
                                        case SPELL_STRENGTH_OF_WRYNN_20:
                                        case SPELL_STRENGTH_OF_WRYNN_25:
                                        case SPELL_STRENGTH_OF_WRYNN_30:
                                            controlled->RemoveOwnedAura(itr);
                                            break;
                                        default:
                                            ++itr;
                                            break;
                                    }
                                }
                            }
                        });
                    }

                    SaveToDB();
                    break;
                case DATA_WEEKLY_QUEST_ID:
                    for (uint8 i = 0; i < WeeklyNPCs; ++i)
                    {
                        if (WeeklyQuestData[i].QuestId[0] != _weeklyQuestId10)
                            continue;

                        // Valithria's weekly only appears after she is saved
                        if (WeeklyQuestData[i].CreatureEntry == NPC_VALITHRIA_DREAMWALKER_QUEST && GetBossState(DATA_VALITHRIA_DREAMWALKER) != DONE)
                            continue;

                        if (Creature* questNpc = instance->GetCreature(_weeklyQuestNpcGUIDs[i]))
                            questNpc->SetVisible(true);
                    }
                    break;
                case DATA_PUTRICIDE_TRAP_STATE:
                    if (data == NOT_STARTED)
                    {
                        _putricideEventProgress &= ~PUTRICIDE_EVENT_FLAG_TRAP_INPROGRESS;
                        UpdatePutricideAirlock();
                        SaveToDB();
                    }
                    else if (data == IN_PROGRESS)
                    {
                        _putricideEventProgress |= PUTRICIDE_EVENT_FLAG_TRAP_INPROGRESS;
                        HandleGameObject(DATA_PUTRICIDE_COLLISION, false);
                        HandleGameObject(DATA_PUTRICIDE_GATE_ORANGE, false);
                        HandleGameObject(DATA_PUTRICIDE_GATE_GREEN, false);
                        SaveToDB();
                    }
                    else if (data == DONE)
                    {
                        _putricideEventProgress &= ~PUTRICIDE_EVENT_FLAG_TRAP_INPROGRESS;
                        _putricideEventProgress |= PUTRICIDE_EVENT_FLAG_TRAP_FINISHED;
                        HandleGameObject(DATA_PUTRICIDE_ENTRANCE_DOOR, true);
                        UpdatePutricideAirlock();
                        SaveToDB();
                    }
                    return;
                case DATA_BONED_ACHIEVEMENT:
                    _isBonedEligible = data != 0;
                    break;
                case DATA_OOZE_DANCE_ACHIEVEMENT:
                    _isOozeDanceEligible = data != 0;
                    break;
                case DATA_NAUSEA_ACHIEVEMENT:
                    _isNauseaEligible = data != 0;
                    break;
                case DATA_ORB_WHISPERER_ACHIEVEMENT:
                    _isOrbWhispererEligible = data != 0;
                    break;
                case DATA_SINDRAGOSA_FROSTWYRMS:
                    _frostwyrmSpawnIds.insert(data);
                    break;
                case DATA_SPINESTALKER:
                    _spinestalkerTrash.insert(data);
                    break;
                case DATA_RIMEFANG:
                    _rimefangTrash.insert(data);
                    break;
                case DATA_COLDFLAME_JETS:
                    _coldflameJetsState = data;
                    if (_coldflameJetsState == DONE)
                        SaveToDB();

                    break;
                case DATA_BLOOD_QUICKENING_STATE:
                    if (data == IN_PROGRESS && _bloodQuickeningState != NOT_STARTED)
                        break;

                    if (_bloodQuickeningState == data)
                        break;

                    if (_weeklyQuestId10 != QUEST_BLOOD_QUICKENING_10)
                        break;

                    switch (data)
                    {
                        case IN_PROGRESS:
                            _events.ScheduleEvent(EVENT_UPDATE_EXECUTION_TIME, 1min);
                            _bloodQuickeningMinutes = 30;
                            DoUpdateWorldState(WORLD_STATE_ICECROWN_CITADEL_SHOW_TIMER, 1);
                            DoUpdateWorldState(WORLD_STATE_ICECROWN_CITADEL_EXECUTION_TIME, _bloodQuickeningMinutes);
                            break;
                        case DONE:
                            _events.CancelEvent(EVENT_UPDATE_EXECUTION_TIME);
                            _bloodQuickeningMinutes = 0;
                            DoUpdateWorldState(WORLD_STATE_ICECROWN_CITADEL_SHOW_TIMER, 0);
                            break;
                        default:
                            break;
                    }

                    _bloodQuickeningState = data;
                    SaveToDB();
                    break;
                case DATA_BPC_TRASH_DIED:
                    if (++_bloodPrinceTrashCount >= 4)
                    {
                        SetBossState(DATA_BLOOD_PRINCE_TRASH, NOT_STARTED);
                        SetBossState(DATA_BLOOD_PRINCE_TRASH, DONE);
                    }

                    SaveToDB();
                    break;
                default:
                    break;
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteriaId, Player const* /*source*/, Unit const* /*target*/, uint32 /*miscvalue1*/) override
        {
            switch (criteriaId)
            {
                case CRITERIA_BONED_10N:
                case CRITERIA_BONED_25N:
                case CRITERIA_BONED_10H:
                case CRITERIA_BONED_25H:
                    return _isBonedEligible;
                case CRITERIA_DANCES_WITH_OOZES_10N:
                case CRITERIA_DANCES_WITH_OOZES_25N:
                case CRITERIA_DANCES_WITH_OOZES_10H:
                case CRITERIA_DANCES_WITH_OOZES_25H:
                    return _isOozeDanceEligible;
                case CRITERIA_NAUSEA_10N:
                case CRITERIA_NAUSEA_25N:
                case CRITERIA_NAUSEA_10H:
                case CRITERIA_NAUSEA_25H:
                    return _isNauseaEligible;
                case CRITERIA_ORB_WHISPERER_10N:
                case CRITERIA_ORB_WHISPERER_25N:
                case CRITERIA_ORB_WHISPERER_10H:
                case CRITERIA_ORB_WHISPERER_25H:
                    return _isOrbWhispererEligible;
                // Only one criteria for both modes, need to do it like this
                case CRITERIA_KILL_LANA_THEL_10M:
                    return instance->ToInstanceMap()->GetMaxPlayers() == 10;
                case CRITERIA_KILL_LANA_THEL_25M:
                    return instance->ToInstanceMap()->GetMaxPlayers() == 25;
                default:
                    break;
            }

            return false;
        }

        bool CheckRequiredBosses(uint32 bossId, Player const* player) const override
        {
            if (_SkipCheckRequiredBosses(player))
                return true;

            switch (bossId)
            {
                case DATA_THE_LICH_KING:
                    if (!CheckPlagueworks(bossId))
                        return false;

                    if (!CheckCrimsonHalls(bossId))
                        return false;

                    if (!CheckFrostwingHalls(bossId))
                        return false;

                    break;
                case DATA_SINDRAGOSA:
                case DATA_VALITHRIA_DREAMWALKER:
                    if (!CheckFrostwingHalls(bossId))
                        return false;

                    break;
                case DATA_BLOOD_QUEEN_LANA_THEL:
                case DATA_BLOOD_PRINCE_COUNCIL:
                    if (!CheckCrimsonHalls(bossId))
                        return false;

                    break;
                case DATA_FESTERGUT:
                case DATA_ROTFACE:
                case DATA_PROFESSOR_PUTRICIDE:
                    if (!CheckPlagueworks(bossId))
                        return false;

                    break;
                default:
                    break;
            }

            if (!CheckLowerSpire(bossId))
                return false;

            return true;
        }

        bool CheckPlagueworks(uint32 bossId) const
        {
            switch (bossId)
            {
                case DATA_THE_LICH_KING:
                    if (GetBossState(DATA_PROFESSOR_PUTRICIDE) != DONE)
                        return false;

                    [[fallthrough]];
                case DATA_PROFESSOR_PUTRICIDE:
                    if (GetBossState(DATA_FESTERGUT) != DONE || GetBossState(DATA_ROTFACE) != DONE)
                        return false;

                    break;
                default:
                    break;
            }

            return true;
        }

        bool CheckCrimsonHalls(uint32 bossId) const
        {
            switch (bossId)
            {
                case DATA_THE_LICH_KING:
                    if (GetBossState(DATA_BLOOD_QUEEN_LANA_THEL) != DONE)
                        return false;

                    [[fallthrough]];
                case DATA_BLOOD_QUEEN_LANA_THEL:
                    if (GetBossState(DATA_BLOOD_PRINCE_COUNCIL) != DONE)
                        return false;

                    break;
                default:
                    break;
            }

            return true;
        }

        bool CheckFrostwingHalls(uint32 bossId) const
        {
            switch (bossId)
            {
                case DATA_THE_LICH_KING:
                    if (GetBossState(DATA_SINDRAGOSA) != DONE)
                        return false;

                    [[fallthrough]];
                case DATA_SINDRAGOSA:
                    if (GetBossState(DATA_VALITHRIA_DREAMWALKER) != DONE)
                        return false;

                    if (GetBossState(DATA_SINDRAGOSA_GAUNTLET) != DONE)
                    {
                        return false;
                    }
                    break;
                default:
                    break;
            }

            return true;
        }

        bool CheckLowerSpire(uint32 bossId) const
        {
            switch (bossId)
            {
                case DATA_THE_LICH_KING:
                case DATA_SINDRAGOSA:
                case DATA_BLOOD_QUEEN_LANA_THEL:
                case DATA_PROFESSOR_PUTRICIDE:
                case DATA_VALITHRIA_DREAMWALKER:
                case DATA_BLOOD_PRINCE_COUNCIL:
                case DATA_ROTFACE:
                case DATA_FESTERGUT:
                    if (GetBossState(DATA_DEATHBRINGER_SAURFANG) != DONE)
                        return false;

                    [[fallthrough]];
                case DATA_DEATHBRINGER_SAURFANG:
                    if (GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != DONE)
                        return false;

                    [[fallthrough]];
                case DATA_ICECROWN_GUNSHIP_BATTLE:
                    if (GetBossState(DATA_LADY_DEATHWHISPER) != DONE)
                        return false;

                    [[fallthrough]];
                case DATA_LADY_DEATHWHISPER:
                    if (GetBossState(DATA_LORD_MARROWGAR) != DONE)
                        return false;

                    [[fallthrough]];
                case DATA_LORD_MARROWGAR:
                default:
                    break;
            }

            return true;
        }

        void CheckLichKingAvailability()
        {
            if (!AreUpperSpireWingsDone())
                return;

            GameObject* teleporter = GetGameObject(DATA_LICH_KING_TELEPORT);
            if (!teleporter)
                return;

            teleporter->SetGoState(GO_STATE_ACTIVE);

            std::list<Creature*> stalkers;
            GetCreatureListWithEntryInGrid(stalkers, teleporter, NPC_INVISIBLE_STALKER, 100.0f);
            if (stalkers.empty())
                return;

            stalkers.sort(Acore::ObjectDistanceOrderPred(teleporter));
            stalkers.front()->CastSpell(static_cast<Unit*>(nullptr), SPELL_ARTHAS_TELEPORTER_CEREMONY, false);
            stalkers.pop_front();
            for (Creature* stalker : stalkers)
                stalker->AI()->Reset();
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _heroicAttempts;

            uint32 temp = 0;
            data >> temp;

            if (temp == IN_PROGRESS)
                _coldflameJetsState = NOT_STARTED;
            else
                _coldflameJetsState = temp ? DONE : NOT_STARTED;

            data >> _bloodQuickeningState;
            data >> _bloodQuickeningMinutes;

            if (_bloodQuickeningState == IN_PROGRESS)
            {
                _events.ScheduleEvent(EVENT_UPDATE_EXECUTION_TIME, 1min);
                DoUpdateWorldState(WORLD_STATE_ICECROWN_CITADEL_SHOW_TIMER, 1);
                DoUpdateWorldState(WORLD_STATE_ICECROWN_CITADEL_EXECUTION_TIME, _bloodQuickeningMinutes);
            }

            data >> _weeklyQuestId10;
            data >> _putricideEventProgress;
            _putricideEventProgress &= ~PUTRICIDE_EVENT_FLAG_TRAP_INPROGRESS;
            data >> _lichKingHeroicAvailable;
            data >> _bloodPrinceTrashCount;
            data >> _isBuffAvailable;
            data >> _isSindragosaIntroDone;
            SetData(DATA_BUFF_AVAILABLE, _isBuffAvailable);
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _heroicAttempts << ' '
                << _coldflameJetsState << ' '
                << _bloodQuickeningState << ' '
                << _bloodQuickeningMinutes << ' '
                << _weeklyQuestId10 << ' '
                << _putricideEventProgress << ' '
                << uint32(_lichKingHeroicAvailable ? 1 : 0) << ' '
                << _bloodPrinceTrashCount << ' '
                << uint32(_isBuffAvailable ? 1 : 0) << ' '
                << uint32(_isSindragosaIntroDone ? 1 : 0);
        }

        void UpdateDeathwhisperElevator(uint32 diff)
        {
            GameObject* elevator = GetGameObject(DATA_LADY_DEATHWHISPER_ELEVATOR);
            if (!elevator)
                return;

            StaticTransport* transport = elevator->ToStaticTransport();
            if (!transport)
                return;

            // StaticTransport::Update clamps PathProgress to exactly 0 / GetPauseTime() and then freezes
            // there while GOState matches, so these two comparisons detect "parked at a stop" exactly.
            bool const atBottom = transport->GetGoState() == GO_STATE_READY && transport->GetPathProgress() == 0;
            bool const atTop = transport->GetGoState() == GO_STATE_ACTIVE && transport->GetPathProgress() == transport->GetPauseTime();

            // Count the dwell down only while parked, so it always starts on arrival instead of on the
            // phase of a free-running tick. Flipping GOState sends the transport towards the other end.
            if (!atBottom && !atTop)
                _deathwhisperElevatorTimer = DeathwhisperElevatorDwellTime;
            else if (_deathwhisperElevatorTimer <= diff)
            {
                _deathwhisperElevatorTimer = DeathwhisperElevatorDwellTime;
                transport->SetGoState(atBottom ? GO_STATE_ACTIVE : GO_STATE_READY);
            }
            else
                _deathwhisperElevatorTimer -= diff;
        }

        // A Feast of Souls whispers
        void HandleLichKingWhisper()
        {
            Map::PlayerList const& players = instance->GetPlayers();
            if (players.IsEmpty())
                return;

            Player* player = players.begin()->GetSource();
            if (!player || player->GetQuestStatus(QUEST_A_FEAST_OF_SOULS) != QUEST_STATUS_INCOMPLETE)
                return;

            if (Creature* theLichKing = GetCreature(DATA_THE_LICH_KING_LH))
                theLichKing->AI()->Talk(SAY_SOULS_LICH_KING_RAND_WHISPER, player);
        }

        void Update(uint32 diff) override
        {
            if (GetBossState(DATA_LADY_DEATHWHISPER) == DONE)
                UpdateDeathwhisperElevator(diff);

            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_UPDATE_EXECUTION_TIME:
                        --_bloodQuickeningMinutes;
                        if (_bloodQuickeningMinutes)
                        {
                            _events.ScheduleEvent(EVENT_UPDATE_EXECUTION_TIME, 1min);
                            DoUpdateWorldState(WORLD_STATE_ICECROWN_CITADEL_SHOW_TIMER, 1);
                            DoUpdateWorldState(WORLD_STATE_ICECROWN_CITADEL_EXECUTION_TIME, _bloodQuickeningMinutes);
                        }
                        else
                        {
                            _bloodQuickeningState = DONE;
                            DoUpdateWorldState(WORLD_STATE_ICECROWN_CITADEL_SHOW_TIMER, 0);
                            if (Creature* bloodQueen = GetCreature(DATA_BLOOD_QUEEN_LANA_THEL))
                                bloodQueen->AI()->DoAction(ACTION_KILL_MINCHAR);
                        }

                        SaveToDB();
                        break;
                    case EVENT_QUAKE_SHATTER:
                        if (GameObject* platform = GetGameObject(DATA_ARTHAS_PLATFORM))
                            platform->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);

                        if (GameObject* edge = GetGameObject(DATA_FROZEN_THRONE_EDGE))
                            edge->SetGoState(GO_STATE_ACTIVE);

                        if (GameObject* wind = GetGameObject(DATA_FROZEN_THRONE_WIND))
                            wind->SetGoState(GO_STATE_READY);

                        if (GameObject* warning = GetGameObject(DATA_FROZEN_THRONE_WARNING))
                            warning->SetGoState(GO_STATE_READY);

                        if (Creature* theLichKing = GetCreature(DATA_THE_LICH_KING))
                            theLichKing->AI()->DoAction(ACTION_RESTORE_LIGHT);

                        break;
                    case EVENT_REBUILD_PLATFORM:
                        if (GameObject* platform = GetGameObject(DATA_ARTHAS_PLATFORM))
                            platform->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, nullptr, true);

                        if (GameObject* edge = GetGameObject(DATA_FROZEN_THRONE_EDGE))
                            edge->SetGoState(GO_STATE_READY);

                        if (GameObject* wind = GetGameObject(DATA_FROZEN_THRONE_WIND))
                            wind->SetGoState(GO_STATE_ACTIVE);

                        break;
                    case EVENT_RESPAWN_GUNSHIP:
                        SpawnGunship();
                        break;
                    case EVENT_LICH_KING_WHISPER:
                        HandleLichKingWhisper();
                        _events.ScheduleEvent(EVENT_LICH_KING_WHISPER, 100s, 300s);
                        break;
                    case EVENT_RESPAWN_SINDRAGOSA:
                        if (!GetCreature(DATA_SINDRAGOSA))
                        {
                            if (Creature* sindragosa = instance->SummonCreature(NPC_SINDRAGOSA, SindragosaSpawnPos))
                            {
                                sindragosa->setActive(true);
                                sindragosa->SetDisableGravity(true);
                                sindragosa->GetMotionMaster()->MoveWaypoint(PATH_SINDRAGOSA_RESPAWN, true);

                                if (TempSummon* summon = sindragosa->ToTempSummon())
                                    summon->SetTempSummonType(TEMPSUMMON_DEAD_DESPAWN);
                            }
                        }

                        // Could happen more than once if more than one player enters before she respawns.
                        _events.CancelEvent(EVENT_RESPAWN_SINDRAGOSA);
                        break;
                    case EVENT_SPAWN_SAURFANG_EVENT:
                        SpawnSaurfangEventNpcs();
                        break;
                    case EVENT_SAURFANG_OUTRO_TIMEOUT:
                        _saurfangOutroRunning = false;
                        SetData(DATA_SAURFANG_OUTRO_ZEPPELIN, DONE);
                        if (GetBossState(DATA_DEATHBRINGER_SAURFANG) == DONE)
                        {
                            SpawnSaurfangCamp(false);
                            SpawnSaurfangEventNpcs();
                        }
                        break;
                    case EVENT_SAURFANG_CAMP_ACTIVATE:
                        ActivateSaurfangCampTeleporters();
                        break;
                    case EVENT_SAURFANG_CAMP_WORKERS:
                        SpawnSaurfangCampWorkers();
                        break;
                    case EVENT_SAURFANG_CAMP_WORKER_0_RUN:
                        SendSaurfangCampWorkerOut(0);
                        break;
                    case EVENT_SAURFANG_CAMP_WORKER_1_RUN:
                        SendSaurfangCampWorkerOut(1);
                        break;
                    case EVENT_SAURFANG_CAMP_WORKER_0_WORK:
                        SetSaurfangCampWorkerWorking(0);
                        break;
                    case EVENT_SAURFANG_CAMP_WORKER_1_WORK:
                        SetSaurfangCampWorkerWorking(1);
                        break;
                    case EVENT_SAURFANG_CAMP_TENTS:
                        SpawnSaurfangCampTents();
                        SendSaurfangCampWorkersBack();
                        break;
                    case EVENT_SAURFANG_CAMP_VENDORS:
                        SummonSaurfangCampVendor(true, true);
                        SummonSaurfangCampVendor(false, true);
                        break;
                    case EVENT_SAURFANG_ZEPPELIN_REMOVE:
                        DespawnSaurfangZeppelinPassenger();
                        if (GameObject* go = instance->GetGameObject(_saurfangZeppelinGUID))
                        {
                            // A MO_TRANSPORT is not despawned like an ordinary gameobject.
                            if (MotionTransport* zeppelin = go->ToMotionTransport())
                            {
                                zeppelin->EnableMovement(false);
                                zeppelin->UnloadStaticPassengers();
                            }
                            go->AddObjectToRemoveList();
                        }
                        _saurfangZeppelinLeaving = false;
                        _saurfangZeppelinGUID.Clear();
                        break;
                    case EVENT_SAURFANG_ZEPPELIN_DOCK:
                        {
                            // Reschedule unconditionally: giving up on a failed lookup would leave
                            // it looping its path forever.
                            GameObject* go = instance->GetGameObject(_saurfangZeppelinGUID);
                            MotionTransport* zeppelin = go ? go->ToMotionTransport() : nullptr;
                            if (zeppelin && zeppelin->GetExactDist2d(&SaurfangOutroZeppelinPos) <= SaurfangOutroZeppelinDockRange)
                            {
                                zeppelin->EnableMovement(false);
                                _saurfangZeppelinDocked = true;
                            }
                            else if (_saurfangZeppelinGUID)
                                _events.ScheduleEvent(EVENT_SAURFANG_ZEPPELIN_DOCK, 500ms);
                        }
                        break;
                    default:
                        break;
                }
            }
        }

        void ProcessEvent(WorldObject* source, uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_ENEMY_GUNSHIP_DESPAWN:
                    if (GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == DONE)
                    {
                        if (GameObject* go = source->ToGameObject())
                            if (MotionTransport* transport = go->ToMotionTransport())
                                transport->UnloadNonStaticPassengers();

                        source->AddObjectToRemoveList();
                    }
                    break;
                case EVENT_ENEMY_GUNSHIP_COMBAT:
                    if (Creature* captain = source->FindNearestCreature(GetTeamIdInInstance() == TEAM_HORDE ? NPC_IGB_HIGH_OVERLORD_SAURFANG : NPC_IGB_MURADIN_BRONZEBEARD, 200.0f))
                        captain->AI()->DoAction(ACTION_ENEMY_GUNSHIP_TALK);

                    [[fallthrough]];
                case EVENT_PLAYERS_GUNSHIP_SPAWN:
                case EVENT_PLAYERS_GUNSHIP_COMBAT:
                    if (GameObject* go = source->ToGameObject())
                        if (MotionTransport* transport = go->ToMotionTransport())
                            transport->EnableMovement(false);
                    break;
                case EVENT_PLAYERS_GUNSHIP_SAURFANG:
                    if (GameObject* go = source->ToGameObject())
                    {
                        if (MotionTransport* transport = go->ToMotionTransport())
                        {
                            transport->setActive(false);
                            transport->EnableMovement(false);
                            // After movement is stopped remove the backpack
                            RemoveBackPack();
                        }
                    }

                    if (Creature* captain = source->FindNearestCreature(GetTeamIdInInstance() == TEAM_HORDE ? NPC_IGB_HIGH_OVERLORD_SAURFANG : NPC_IGB_MURADIN_BRONZEBEARD, 200.0f))
                        captain->AI()->DoAction(ACTION_EXIT_SHIP);

                    // The captain despawns 18s into his walk off the ship; the event party appears with him.
                    _events.ScheduleEvent(EVENT_SPAWN_SAURFANG_EVENT, 18s);
                    break;
                case EVENT_QUAKE:
                    if (GameObject* warning = GetGameObject(DATA_FROZEN_THRONE_WARNING))
                        warning->SetGoState(GO_STATE_ACTIVE);

                    _events.ScheduleEvent(EVENT_QUAKE_SHATTER, 5s);
                    break;
                case EVENT_SECOND_REMORSELESS_WINTER:
                    if (GameObject* platform = GetGameObject(DATA_ARTHAS_PLATFORM))
                    {
                        platform->SetDestructibleState(GO_DESTRUCTIBLE_DESTROYED);
                        _events.ScheduleEvent(EVENT_REBUILD_PLATFORM, 1500ms);
                    }
                    break;
                case EVENT_TELEPORT_TO_FROSMOURNE: // Harvest Soul (normal mode)
                    if (Creature* terenas = instance->SummonCreature(NPC_TERENAS_MENETHIL_FROSTMOURNE, TerenasSpawn, nullptr, 65000))
                    {
                        terenas->AI()->DoAction(ACTION_FROSTMOURNE_INTRO);
                        std::list<Creature*> triggers;
                        GetCreatureListWithEntryInGrid(triggers, terenas, NPC_WORLD_TRIGGER_INFINITE_AOI, 100.0f);
                        if (!triggers.empty())
                        {
                            triggers.sort(Acore::ObjectDistanceOrderPred(terenas, false));
                            Unit* visual = triggers.front();
                            visual->CastSpell(visual, SPELL_FROSTMOURNE_TELEPORT_VISUAL, true);
                        }

                        if (Creature* warden = instance->SummonCreature(NPC_SPIRIT_WARDEN, SpiritWardenSpawn, nullptr, 65000))
                        {
                            terenas->AI()->AttackStart(warden);
                            warden->AddThreat(terenas, 300000.0f);
                        }
                    }
                    break;
                case EVENT_FESTERGUT_VALVE_USED:
                    HandlePutricideValveUsed(PUTRICIDE_EVENT_FLAG_FESTERGUT_VALVE, DATA_GAS_RELEASE_VALVE, DATA_PUTRICIDE_GATE_ORANGE, DATA_PUTRICIDE_PIPE_ORANGE);
                    break;
                case EVENT_ROTFACE_VALVE_USED:
                    HandlePutricideValveUsed(PUTRICIDE_EVENT_FLAG_ROTFACE_VALVE, DATA_OOZE_RELEASE_VALVE, DATA_PUTRICIDE_GATE_GREEN, DATA_PUTRICIDE_PIPE_GREEN);
                    break;
                default:
                    break;
            }
        }

        void HandlePutricideValveUsed(uint32 valveFlag, uint32 valveData, uint32 gateData, uint32 pipeData)
        {
            if (_putricideEventProgress & valveFlag)
                return;

            if (GameObject* valve = GetGameObject(valveData))
                valve->SetGameObjectFlag(GO_FLAG_INTERACT_COND | GO_FLAG_NOT_SELECTABLE);

            _putricideEventProgress |= valveFlag;
            if (AreBothPutricideValvesUsed())
                UpdatePutricideAirlock();
            else
                HandleGameObject(gateData, false);

            HandleGameObject(pipeData, true);
            SaveToDB();
        }

        void SetPositionTraps(GameObject* go)
        {
            uint8 alarm;
            switch (go->GetEntry())
            {
                case GO_SPIRIT_ALARM_1:
                    alarm = 0;
                    break;
                case GO_SPIRIT_ALARM_2:
                    alarm = 1;
                    break;
                case GO_SPIRIT_ALARM_3:
                    alarm = 2;
                    break;
                case GO_SPIRIT_ALARM_4:
                    alarm = 3;
                    break;
                default:
                    return;
            }

            go->Relocate(Acore::Containers::SelectRandomContainerElement(SpiritAlarmPositions[alarm]));
        }

    private:
        bool _isBuffAvailable;
        uint32 _weeklyQuestId10; // contains id from 10man for any difficulty (for simplicity)
        ObjectGuid _weeklyQuestNpcGUIDs[WeeklyNPCs];
        uint32 _putricideEventProgress;
        bool _lichKingHeroicAvailable;
        uint32 _deathwhisperElevatorTimer;

        EventMap _events;
        ObjectGuid _gunshipGUID;
        ObjectGuid _deathbringerSaurfangEventGUID;   // Muradin Bronzebeard or High Overlord Saurfang
        // Summoned, so kept out of the object storage
        ObjectGuid _highlordTirionFordringGUID;
        ObjectGuid _terenasMenethilGUID;
        GuidList _saurfangCampGUIDs;
        GuidList _saurfangEventGuardGUIDs;
        std::array<ObjectGuid, 2> _saurfangCampTeleporterGUIDs;
        std::array<ObjectGuid, 2> _saurfangCampWorkerGUIDs;
        ObjectGuid _saurfangZeppelinGUID;
        ObjectGuid _saurfangZeppelinPassengerGUID;
        bool _saurfangCampSpawned;
        bool _saurfangOutroRunning;
        bool _saurfangZeppelinDocked;
        bool _saurfangZeppelinLeaving;
        uint32 _coldflameJetsState;
        std::set<ObjectGuid::LowType> _frostwyrmSpawnIds;
        std::set<ObjectGuid::LowType> _spinestalkerTrash;
        std::set<ObjectGuid::LowType> _rimefangTrash;
        uint32 _bloodQuickeningState;
        uint32 _heroicAttempts;
        uint16 _bloodQuickeningMinutes;
        uint32 _bloodPrinceTrashCount;
        bool _isBonedEligible;
        bool _isOozeDanceEligible;
        bool _isNauseaEligible;
        bool _isOrbWhispererEligible;
        bool _isSindragosaIntroDone;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_icecrown_citadel_InstanceMapScript(map);
    }
};

void AddSC_instance_icecrown_citadel()
{
    new instance_icecrown_citadel();
}
