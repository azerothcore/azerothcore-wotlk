/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DEF_HYJAL_H
#define DEF_HYJAL_H

#include "GridNotifiers.h"

#define ERROR_INST_DATA     "TSCR: Instance data not set properly for Mount Hyjal. Encounters will be buggy."

uint32 const EncounterCount     = 5;

enum HyjalBosses
{
    BOSS_ARCHIMONDE = 0,
};

enum DataTypes
{
    DATA_ANETHERON              = 1,
    DATA_ANETHERONEVENT         = 2,
    DATA_ARCHIMONDE             = 3,
    DATA_ARCHIMONDEEVENT        = 4,
    DATA_AZGALOR                = 5,
    DATA_AZGALOREVENT           = 6,
    DATA_JAINAPROUDMOORE        = 7,
    DATA_KAZROGAL               = 8,
    DATA_KAZROGALEVENT          = 9,
    DATA_RAGEWINTERCHILL        = 10,
    DATA_RAGEWINTERCHILLEVENT   = 11,
    DATA_THRALL                 = 12,
    DATA_TYRANDEWHISPERWIND     = 13,
    DATA_TRASH                  = 14,
    DATA_RESET_TRASH_COUNT      = 15,
    DATA_ALLIANCE_RETREAT       = 16,
    DATA_HORDE_RETREAT          = 17,
    DATA_RAIDDAMAGE             = 18,
    DATA_RESET_RAIDDAMAGE       = 19,
    TYPE_RETREAT                = 20
};

enum WorldStateIds
{
    WORLD_STATE_WAVES           = 2842,
    WORLD_STATE_ENEMY           = 2453,
    WORLD_STATE_ENEMYCOUNT      = 2454
};

enum CreaturesIds
{
    // Trash Mobs summoned in waves
    NECROMANCER                 = 17899,
    ABOMINATION                 = 17898,
    GHOUL                       = 17895,
    BANSHEE                     = 17905,
    CRYPT_FIEND                 = 17897,
    GARGOYLE                    = 17906,
    FROST_WYRM                  = 17907,
    GIANT_INFERNAL              = 17908,
    FEL_STALKER                 = 17916,

    JAINA                       = 17772,
    THRALL                      = 17852,
    TYRANDE                     = 17948,

    // Bosses summoned after every 8 waves
    RAGE_WINTERCHILL            = 17767,
    ANETHERON                   = 17808,
    KAZROGAL                    = 17888,
    AZGALOR                     = 17842,
    ARCHIMONDE                  = 17968,
    NPC_WORLD_TRIGGER_TINY      = 21987
};

enum GameobjectIds
{
    GO_HORDE_ENCAMPMENT_PORTAL  = 182060,
    GO_NIGHT_ELF_VILLAGE_PORTAL = 182061,
    GO_ANCIENT_GEM              = 185557,
    GO_ANCIENT_VEIN             = 185557,
    GO_ROARING_FLAME            = 182592
};

#endif

