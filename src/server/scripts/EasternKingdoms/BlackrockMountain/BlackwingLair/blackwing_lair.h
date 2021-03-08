/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DEF_BLACKWING_LAIR_H
#define DEF_BLACKWING_LAIR_H

#include "CreatureAIImpl.h"

uint32 const EncounterCount     = 8;

#define BWLScriptName "instance_blackwing_lair"
#define DataHeader    "BWL"

enum BWLEncounter
{
    // Encounter States/Boss GUIDs
    DATA_RAZORGORE_THE_UNTAMED  = 0,
    DATA_VAELASTRAZ_THE_CORRUPT = 1,
    DATA_BROODLORD_LASHLAYER    = 2,
    DATA_FIREMAW                = 3,
    DATA_EBONROC                = 4,
    DATA_FLAMEGOR               = 5,
    DATA_CHROMAGGUS             = 6,
    DATA_NEFARIAN               = 7,

    // Additional Data
    DATA_LORD_VICTOR_NEFARIUS   = 8,

    // Doors
    DATA_GO_CHROMAGGUS_DOOR     = 9
};

enum BWLCreatureIds
{
    NPC_RAZORGORE               = 12435,
    NPC_BLACKWING_DRAGON        = 12422,
    NPC_BLACKWING_TASKMASTER    = 12458,
    NPC_BLACKWING_LEGIONAIRE    = 12416,
    NPC_BLACKWING_WARLOCK       = 12459,
    NPC_VAELASTRAZ              = 13020,
    NPC_BROODLORD               = 12017,
    NPC_FIREMAW                 = 11983,
    NPC_EBONROC                 = 14601,
    NPC_FLAMEGOR                = 11981,
    NPC_CHROMAGGUS              = 14020,
    NPC_VICTOR_NEFARIUS         = 10162,
    NPC_NEFARIAN                = 11583
};

enum BWLGameObjectIds
{
    GO_BLACK_DRAGON_EGG         = 177807,
    GO_PORTCULLIS_RAZORGORE     = 175946,
    GO_PORTCULLIS_VAELASTRASZ   = 175185,
    GO_PORTCULLIS_BROODLORD     = 179365,
    GO_PORTCULLIS_THREEDRAGONS  = 179115,
    GO_CHROMAGGUS_LEVER         = 179148,
    GO_PORTCULLIS_CHROMAGGUS    = 179116,
    GO_PORTCULLIS_NEFARIAN      = 179117,
    GO_SUPPRESSION_DEVICE       = 179784
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
    DATA_EGG_EVENT              = 2,
    TALK_EGG_BROKEN_RAND        = 3,

    SAY_NEFARIAN_VAEL_INTRO     = 100003, // latest id in broadcast_text atm
};

#endif
