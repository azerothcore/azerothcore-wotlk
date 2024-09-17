/* This file is part of the ScriptDev2 Project. See AUTHORS file for Copyright information
 * This program is free software licensed under GPL version 2
 * Please see the included DOCS/LICENSE.TXT for more information */

#ifndef DEF_ZEPPELIN_H
#define DEF_ZEPPELIN_H


// ZEPPELIN
enum ZeppelinStation
{
    STATION_DUROTAR,
    STATION_TIRISFAL,
    STATION_STRANGLETHORN_VALE,

    STATION_BOREAN_TUNDRA,
    STATION_HOWLING_FJORD,
    STATION_MULGORE
};

typedef const std::pair<ZeppelinStation, ZeppelinStation> ZeppelinRoute;

enum ZeppelinEntry : uint32
{
    ORGRIMMAR_UNDERCITY = 9999,
    GROMGOL_ORGRIMMAR = 175080,
    GROMGOL_UNDERCITY = 999,
};

enum ZeppelinEvent : uint32
{
    GROMGOLUC_EVENT_1   = 15312,
    GROMGOLUC_EVENT_2   = 15313,
    GROMGOLUC_EVENT_3   = 15314,
    GROMGOLUC_EVENT_4   = 15315,
    OGUC_EVENT_1        = 15318,
    OGUC_EVENT_2        = 15319,
    OGUC_EVENT_3        = 15320,
    OGUC_EVENT_4        = 15321,
    GROMGOLOG_EVENT_1   = 15322,
    GROMGOLOG_EVENT_2   = 15323,
    GROMGOLOG_EVENT_3   = 15324,
    GROMGOLOG_EVENT_4   = 15325,

    SAY_DUROTAR_FROM_OG_ARRIVAL   = -1020001,
    SAY_TIRISFAL_FROM_UC_ARRIVAL  = -1020002,
    SAY_ST_FROM_GROMGOL_ARRIVAL   = -1020003,
    SAY_WK_DEPARTURE              = -1020004,
    SAY_WK_ARRIVAL                = -1020005,
    SAY_UC_FROM_VL_ARRIVAL        = -1020006,
    SAY_OG_FROM_BT_ARRIVAL        = -1020007,
    SAY_OG_FROM_TB_ARRIVAL        = -1020008,

    ACTION_GROMGOL_ORGRIMMAR = 8764,


    EVENT_UC_FROM_GROMGOL_ARRIVAL = 15312,
    EVENT_GROMGOL_FROM_UC_ARRIVAL = 15314,
    EVENT_OG_FROM_UC_ARRIVAL      = 15318,
    EVENT_UC_FROM_OG_ARRIVAL      = 15320,

    EVENT_OG_FROM_GROMGOL_ARRIVAL = 15322,
    EVENT_OG_TO_GROMGOL_DEPARTURE = 15323,
    EVENT_GROMGOL_FROM_OG_ARRIVAL = 15324,
    EVENT_GROMGOL_TO_OG_DEPARTURE = 15325,

    NPC_TEXT_OG_FROM_GROMGOL_ARRIVAL = 11169,
    NPC_TEXT_OG_TO_GROMGOL_DEPARTURE = 11170,
    NPC_TEXT_GROMGOL_FROM_OG_ARRIVAL = 11167,
    NPC_TEXT_GROMGOL_TO_OG_DEPARTURE = 11172,

    EVENT_WK_DEPARTURE            = 15430,
    EVENT_WK_ARRIVAL              = 15431,

    EVENT_VL_FROM_UC_ARRIVAL      = 19126,
    EVENT_UC_FROM_VL_ARRIVAL      = 19127,

    EVENT_OG_FROM_BT_ARRIVAL      = 19137,
    EVENT_BT_FROM_OG_ARRIVAL      = 19139,

    EVENT_OG_FROM_TB_ARRIVAL      = 21868,
    EVENT_TB_FROM_OG_ARRIVAL      = 21870,

    SOUND_ZEPPELIN_HORN           = 11804,
};

typedef const std::vector<ZeppelinEvent> ZeppelinEvents;

enum ZeppelinEventType
{
    ARRIVAL,
    DEPARTURE
};

// map? zeppelin arrived
// eventId -> zeppelinMaster



// typedef const std::map<ZeppelinStation, ZeppelinEvent> ZeppelinEventStore;

enum ZeppelinMaster
{
    NPC_NEZRAZ                  = 3149,
    NPC_HINDENBURG              = 3150,
    NPC_FREZZA                  = 9564,
    NPC_ZAPETTA                 = 9566,
    NPC_SNURK_BUCKSQUICK        = 12136,
    NPC_SQUIBBY_OVERSPECK       = 12137,
    NPC_HARROWMEISER            = 23823,
    NPC_GREEB_RAMROCKET         = 26537,
    NPC_NARGO_SCREWBORE         = 26538,
    NPC_MEEFI_FARTHROTTLE       = 26539,
    NPC_DRENK_SPANNERSPARK      = 26540,
    NPC_ZELLI_HOTNOZZLE         = 34765,
    NPC_KRENDLE_BIGPOCKETS      = 34766,
};

enum ZeppelinLocation
{
    LOCATION_UNKNOWN,
    LOCATION_ARRIVED_FIRST,
    LOCATION_ARRIVED_SECOND,
    LOCATION_DEPARTED_FIRST,
    LOCATION_DEPARTED_SECOND
};
const ZeppelinLocation NPC_LOCATION_FIRST = LOCATION_ARRIVED_FIRST;
const ZeppelinLocation NPC_LOCATION_SECOND = LOCATION_ARRIVED_SECOND;

// typedef const std::pair<ZeppelinStation, ZeppelinStation> ZeppelinRoute;
const std::map<ZeppelinEvent, ZeppelinLocation> EVENT_TO_LOCATION_MAP = {
    // EVENT_UC_FROM_GROMGOL_ARRIVAL
    // EVENT_GROMGOL_FROM_UC_ARRIVAL
    // EVENT_OG_FROM_UC_ARRIVAL
    // EVENT_UC_FROM_OG_ARRIVAL
    std::make_pair(EVENT_OG_FROM_GROMGOL_ARRIVAL, LOCATION_ARRIVED_SECOND),
    std::make_pair(EVENT_OG_TO_GROMGOL_DEPARTURE, LOCATION_ARRIVED_FIRST),
    std::make_pair(EVENT_GROMGOL_FROM_OG_ARRIVAL, LOCATION_ARRIVED_FIRST),
    std::make_pair(EVENT_GROMGOL_TO_OG_DEPARTURE, LOCATION_DEPARTED_FIRST),
};

// typedef const std::pair<ZeppelinStation, ZeppelinStation> ZeppelinRoute;
const std::map<ZeppelinEvent, ZeppelinMaster> EVENT_TO_MASTER_MAP = {
    std::make_pair(EVENT_UC_FROM_GROMGOL_ARRIVAL, NPC_HINDENBURG),
    std::make_pair(EVENT_GROMGOL_FROM_UC_ARRIVAL, NPC_SQUIBBY_OVERSPECK),
    std::make_pair(EVENT_OG_FROM_UC_ARRIVAL, NPC_FREZZA),
    std::make_pair(EVENT_UC_FROM_OG_ARRIVAL, NPC_ZAPETTA),
    std::make_pair(EVENT_OG_FROM_GROMGOL_ARRIVAL, NPC_SNURK_BUCKSQUICK),
    std::make_pair(EVENT_GROMGOL_FROM_OG_ARRIVAL, NPC_NEZRAZ),
    std::make_pair(EVENT_WK_ARRIVAL, NPC_HARROWMEISER),
    std::make_pair(EVENT_WK_DEPARTURE, NPC_HARROWMEISER),
    std::make_pair(EVENT_VL_FROM_UC_ARRIVAL, NPC_DRENK_SPANNERSPARK),
    std::make_pair(EVENT_UC_FROM_VL_ARRIVAL, NPC_MEEFI_FARTHROTTLE),
    std::make_pair(EVENT_OG_FROM_BT_ARRIVAL, NPC_GREEB_RAMROCKET),
    std::make_pair(EVENT_BT_FROM_OG_ARRIVAL, NPC_NARGO_SCREWBORE),
    std::make_pair(EVENT_OG_FROM_TB_ARRIVAL, NPC_ZELLI_HOTNOZZLE),
    std::make_pair(EVENT_TB_FROM_OG_ARRIVAL, NPC_KRENDLE_BIGPOCKETS),
};

enum ZeppelinGossipType
{
    ARRIVED,
    DEPARTED
};

const uint32 GOSSIP_WHERE_IS_THE_ZEPPELIN = 1969;

const uint32 GOSSIP_UNKNOWN = 11163;
// UNKNOWN TEXT 22081
// WHERE ZEPPELIN 22086

/// @todo DB entries suggest slightly different gossip for some NPCs with the same information (e.g. [..] Should be back in a few minutes...)
const std::map<std::pair<ZeppelinStation, ZeppelinGossipType>, uint32> GOSSIP_MAP =
{
    std::make_pair(std::make_pair(STATION_DUROTAR, ARRIVED), 11169),
    std::make_pair(std::make_pair(STATION_DUROTAR, DEPARTED), 11170),
    std::make_pair(std::make_pair(STATION_TIRISFAL, ARRIVED), 11173),
    std::make_pair(std::make_pair(STATION_TIRISFAL, DEPARTED), 11175),
    std::make_pair(std::make_pair(STATION_STRANGLETHORN_VALE, ARRIVED), 11167),
    std::make_pair(std::make_pair(STATION_STRANGLETHORN_VALE, DEPARTED), 11172)
};

const std::map<std::pair<ZeppelinEntry, ZeppelinLocation>, ZeppelinStation> STATION_MAP =
{
    std::make_pair(std::make_pair(GROMGOL_ORGRIMMAR, LOCATION_ARRIVED_FIRST), STATION_DUROTAR),
    std::make_pair(std::make_pair(GROMGOL_ORGRIMMAR, LOCATION_ARRIVED_SECOND), STATION_DUROTAR),
    std::make_pair(std::make_pair(ORGRIMMAR_UNDERCITY, LOCATION_ARRIVED_FIRST), STATION_DUROTAR),
    std::make_pair(std::make_pair(ORGRIMMAR_UNDERCITY, LOCATION_ARRIVED_SECOND), STATION_DUROTAR),
};

// typedef
#endif

