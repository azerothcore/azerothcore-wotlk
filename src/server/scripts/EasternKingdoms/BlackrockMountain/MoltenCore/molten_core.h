/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DEF_MOLTEN_CORE_H
#define DEF_MOLTEN_CORE_H

enum Encounters
{
    BOSS_LUCIFRON                   = 0,
    BOSS_MAGMADAR                   = 1,
    BOSS_GEHENNAS                   = 2,
    BOSS_GARR                       = 3,
    BOSS_SHAZZRAH                   = 4,
    BOSS_BARON_GEDDON               = 5,
    BOSS_SULFURON_HARBINGER         = 6,
    BOSS_GOLEMAGG_THE_INCINERATOR   = 7,
    BOSS_MAJORDOMO_EXECUTUS         = 8,
    BOSS_RAGNAROS                   = 9,
    MAX_ENCOUNTER,
};

enum Actions
{
    ACTION_START_RAGNAROS       = 0,
    ACTION_START_RAGNAROS_ALT   = 1,
};

Position const RagnarosTelePos   = {829.159f, -815.773f, -228.972f, 5.30500f};
Position const RagnarosSummonPos = {838.510f, -829.840f, -232.000f, 2.00000f};

enum Creatures
{
    NPC_LUCIFRON                    = 12118,
    NPC_MAGMADAR                    = 11982,
    NPC_GEHENNAS                    = 12259,
    NPC_GARR                        = 12057,
    NPC_SHAZZRAH                    = 12264,
    NPC_BARON_GEDDON                = 12056,
    NPC_SULFURON_HARBINGER          = 12098,
    NPC_GOLEMAGG_THE_INCINERATOR    = 11988,
    NPC_MAJORDOMO_EXECUTUS          = 12018,
    NPC_RAGNAROS                    = 11502,
    NPC_FLAMEWAKER_HEALER           = 11663,
    NPC_FLAMEWAKER_ELITE            = 11664,
    NPC_CORE_RAGER                  = 11672,
    NPC_CORE_HOUND                  = 11671,
};

enum GameObjects
{
    GO_CACHE_OF_THE_FIRELORD        = 179703,
    GO_CIRCLE_SULFURON              = 178187,
    GO_CIRCLE_BARON                 = 178188,
    GO_CIRCLE_SHAZZRAH              = 178189,
    GO_CIRCLE_GOLEMAGG              = 178190,
    GO_CIRCLE_GARR                  = 178191,
    GO_CIRCLE_MAGMADAR              = 178192,
    GO_CIRCLE_GEHENNAS              = 178193,
};

enum Data
{
    DATA_RAGNAROS_ADDS  = 0,
};

#endif
