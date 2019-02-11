/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_CULLING_OF_STRATHOLME_H
#define DEF_CULLING_OF_STRATHOLME_H

enum Data
{
    DATA_ARTHAS_EVENT,
    DATA_GUARDIANTIME_EVENT,

    // Communication
    DATA_SHOW_CRATES,
    DATA_CRATE_COUNT,
    DATA_START_WAVES,
    DATA_SHOW_INFINITE_TIMER,
    DATA_ARTHAS_REPOSITION,
};

enum Data64
{
    DATA_ARTHAS,
    DATA_INFINITE,
    DATA_SHKAF_GATE,
    DATA_EXIT_GATE,
};

enum Creatures
{
    NPC_MEATHOOK                        = 26529,
    NPC_SALRAMM                         = 26530,
    NPC_EPOCH                           = 26532,
    NPC_MAL_GANIS                       = 26533,
    NPC_INFINITE                        = 32273,
    NPC_ARTHAS                          = 26499,
    NPC_JAINA                           = 26497,
    NPC_UTHER                           = 26528,

    NPC_GUARDIAN_OF_TIME                = 32281,
    NPC_TIME_RIFT                       = 28409,

    NPC_CHROMIE_MIDDLE                  = 27915,
    NPC_GRAIN_CREATE_TRIGGER            = 30996,
    NPC_HOURGLASS                       = 28656,
};

enum GameObjects
{
    GO_SHKAF_GATE                       = 188686,
    GO_EXIT_GATE                        = 191788,
    GO_MALGANIS_CHEST_N                 = 190663,
    GO_MALGANIS_CHEST_H                 = 193597,
    GO_SUSPICIOUS_CRATE                 = 190094,
    GO_PLAGUED_CRATE                    = 190095,
};

enum WorldStatesCoT
{
    WORLDSTATE_SHOW_CRATES              = 3479,
    WORLDSTATE_CRATES_REVEALED          = 3480,
    WORLDSTATE_WAVE_COUNT               = 3504,
    WORLDSTATE_TIME_GUARDIAN            = 3931,
    WORLDSTATE_TIME_GUARDIAN_SHOW       = 3932,
};

enum CrateSpells
{
    SPELL_CRATES_CREDIT                 = 58109,
    SPELL_ARCANE_DISRUPTION             = 49590,

    SPELL_HUMAN_FEMALE                  = 35483,
    SPELL_HUMAN_MALE                    = 35482,
};

enum EventPositions
{
    EVENT_POS_CHROMIE               = 0,
    EVENT_POS_HOURGLASS             = 1,
    EVENT_SRC_UTHER,
    EVENT_SRC_JAINA,
    EVENT_SRC_HORSE1,
    EVENT_SRC_HORSE2,
    EVENT_SRC_HORSE3,
    EVENT_DST_UTHER,
    EVENT_DST_HORSE1,
    EVENT_DST_HORSE2,
    EVENT_DST_HORSE3,
    EVENT_POS_RETREAT,
    EVENT_SRC_TOWN_CITYMAN1,
    EVENT_SRC_TOWN_CITYMAN2,
    EVENT_DST_CITYMAN,
    EVENT_SRC_MALGANIS,
    EVENT_SRC_MEATHOOK,
    EVENT_SRC_SALRAMM,
    EVENT_SRC_HALL_CITYMAN1,
    EVENT_SRC_HALL_CITYMAN2,
    EVENT_SRC_HALL_CITYMAN3,
    EVENT_SRC_EPOCH,
    EVENT_DST_EPOCH,
    EVENT_SRC_CORRUPTOR,
    EVENT_SRC_MALGANIS_FINAL,
};

enum ArthasPhase
{
    COS_PROGRESS_NOT_STARTED                    = 0,
    COS_PROGRESS_CRATES_FOUND                   = 1,
    COS_PROGRESS_START_INTRO                    = 2,
    COS_PROGRESS_FINISHED_INTRO                 = 3,
    COS_PROGRESS_FINISHED_CITY_INTRO            = 4,
    COS_PROGRESS_KILLED_MEATHOOK                = 5,
    COS_PROGRESS_KILLED_SALRAMM                 = 6,
    COS_PROGRESS_REACHED_TOWN_HALL              = 7,
    COS_PROGRESS_KILLED_EPOCH                   = 8,
    COS_PROGRESS_LAST_CITY                      = 9,
    COS_PROGRESS_BEFORE_MALGANIS                = 10,
    COS_PROGRESS_FINISHED                       = 11,
};

enum Actions
{
    ACTION_START_EVENT                          = 1,
    ACTION_START_CITY                           = 2,
    ACTION_KILLED_SALRAMM                       = 3,
    ACTION_START_TOWN_HALL                      = 4,
    ACTION_START_SECRET_PASSAGE                 = 5,
    ACTION_START_LAST_CITY                      = 6,
    ACTION_RUN_OUT_OF_TIME                      = 7,
    ACTION_START_MALGANIS                       = 8,
    ACTION_KILLED_MALGANIS                      = 9,
};

const Position LeaderIntroPos1 = {1938.05f, 1289.79f, 145.38f, 3.18f};
const Position LeaderIntroPos2 = {2050.66f, 1287.33f, 142.67f, M_PI};
const Position LeaderIntroPos2special = {2092.15f, 1276.65f, 140.52f, 0.22f};
const Position LeaderIntroPos3 = {2365.63f, 1194.84f, 131.97f, 0.0f};
const Position LeaderIntroPos4 = {2423.12f, 1119.43f, 148.07f, 0.0f};
const Position LeaderIntroPos5 = {2540.48f, 1129.06f, 130.86f, 0.0f};
const Position LeaderIntroPos6 = {2327.39f, 1412.47f, 127.69f, 0.0f};

const Position EventPos[] = 
{
    {1813.298f, 1283.578f, 142.326f, 3.878161f},    // chromie
    {1809.46f,  1286.05f,  142.62f,  4.8f},         // hourglass
    {1795.76f,  1271.54f,  140.61f,  0.21f},        // source for uther
    {1895.48f,  1292.66f,  143.706f, 0.023475f},    // source for jaina
    {1788.38f,  1273.7f,   140.15f,  0.2f},         // source for horses
    {1788.76f,  1271.54f,  140.62f,  0.21f},
    {1788.74f,  1267.38f,  140.18f,  0.11f},
    {1897.6f,   1285.5f,   143.44f,  0.32f},        // dest for uther
    {1888.56f,  1289.95f,  143.8f,   0.01f},        // dest for horses
    {1888.94f,  1285.41f,  143.69f,  0.08f},
    {1889.55f,  1279.95f,  143.62f,  0.1f},
    {1751.9f,   1262.45f,  137.62f,  3.35f},        // retreat position after intro (uther + horses)
    {2091.977f, 1275.021f, 140.757f, 0.558f},       // source for town city man 1
    {2093.514f, 1275.842f, 140.408f, 3.801f},       // 2
    {2089.04f,  1277.98f,  140.85f,  2.35f},        // cityman dest pos
    {2117.349f, 1288.624f, 136.271f, 1.37f},        // malganis city intro
    {2351.45f,  1197.81f,  130.45f,  3.83f},        // meathook spawn position
    {2351.45f,  1197.81f,  130.45f,  3.83f},        // salramm spawn position
    {2398.14f,  1207.81f,  134.04f,  5.15f},        // source for hall city man 1
    {2403.22f,  1205.54f,  134.04f,  3.31f},        // 2
    {2400.82f,  1201.69f,  134.01f,  1.53f},        // 3
    {2463.131f, 1115.391f, 152.473f, 3.41f},        // epoch spawn position
    {2451.809f, 1112.901f, 149.220f, 3.36f},        // epoch move pos
    {2329.07f,  1276.98f,  132.68f,  4.0f},         // infinite corruptor pos
    {2298.25f,  1500.56f,  128.37f,  4.95f}         // malganis final pos
};

#endif
