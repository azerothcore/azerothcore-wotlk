/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DEF_BLACKWING_LAIR_H
#define DEF_BLACKWING_LAIR_H

uint32 const EncounterCount     = 8;

#define BRLScriptName "instance_blackwing_lair"

enum BWLEncounter
{
    BOSS_RAZORGORE              = 0,
    BOSS_VAELASTRAZ             = 1,
    BOSS_BROODLORD              = 2,
    BOSS_FIREMAW                = 3,
    BOSS_EBONROC                = 4,
    BOSS_FLAMEGOR               = 5,
    BOSS_CHROMAGGUS             = 6,
    BOSS_NEFARIAN               = 7
};

enum CreatureIds
{
    NPC_RAZORGORE               = 12435,
    NPC_BLACKWING_DRAGON        = 12422,
    NPC_BLACKWING_TASKMASTER    = 12458,
    NPC_BLACKWING_LEGIONAIRE    = 12416,
    NPC_BLACKWING_WARLOCK       = 12459,
    NPC_VAELASTRAZ              = 13020,
    NPC_BROODLORD               = 12017,
    NPC_FIRENAW                 = 11983,
    NPC_EBONROC                 = 14601,
    NPC_FLAMEGOR                = 11981,
    NPC_CHROMAGGUS              = 14020,
    NPC_VICTOR_NEFARIUS         = 10162,
    NPC_NEFARIAN                = 11583
};

enum BWLData64
{
    DATA_RAZORGORE_THE_UNTAMED = 1,
    DATA_VAELASTRAZ_THE_CORRUPT,
    DATA_BROODLORD_LASHLAYER,
    DATA_FIRENAW,
    DATA_EBONROC,
    DATA_FLAMEGOR,
    DATA_CHROMAGGUS,
    DATA_LORD_VICTOR_NEFARIUS,
    DATA_NEFARIAN
};

enum BWLEvents
{
    EVENT_RAZOR_SPAWN       = 1,
    EVENT_RAZOR_PHASE_TWO   = 2,
    EVENT_RESPAWN_NEFARIUS  = 3
};

enum BWLMisc
{
    // Razorgore Egg Event
    ACTION_PHASE_TWO            = 1,
    DATA_EGG_EVENT
};

#endif
