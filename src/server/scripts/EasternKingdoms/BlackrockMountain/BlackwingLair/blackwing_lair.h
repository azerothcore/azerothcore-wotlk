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

#ifndef DEF_BLACKWING_LAIR_H
#define DEF_BLACKWING_LAIR_H

#include "CreatureAIImpl.h"

constexpr uint32 EncounterCount = 8;

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
    DATA_GRETHOK                = 9,
    DATA_NEFARIAN_TROOPS        = 10,

    // Doors
    DATA_GO_CHROMAGGUS_DOOR     = 11,
    DATA_GO_CHROMAGGUS_DOOR_EXIT= 12
};

enum BWLCreatureIds
{
    NPC_GRETHOK                 = 12557,
    NPC_BLACKWING_GUARDSMAN     = 14456,
    NPC_NEFARIAN_TROOPS         = 14459,
    NPC_RAZORGORE               = 12435,
    NPC_BLACKWING_DRAGON        = 12422,
    NPC_BLACKWING_TASKMASTER    = 12458,
    NPC_BLACKWING_LEGIONAIRE    = 12416,
    NPC_BLACKWING_WARLOCK       = 12459,
    NPC_BLACKWING_MAGE          = 12420,
    NPC_VAELASTRAZ              = 13020,
    NPC_BROODLORD               = 12017,
    NPC_FIREMAW                 = 11983,
    NPC_EBONROC                 = 14601,
    NPC_FLAMEGOR                = 11981,
    NPC_CHROMAGGUS              = 14020,
    NPC_VICTOR_NEFARIUS         = 10162,
    NPC_NEFARIAN                = 11583,

    // Nefarian fight
    NPC_BLACK_SPAWNER           = 14307,
    NPC_RED_SPAWNER             = 14309,
    NPC_GREEN_SPAWNER           = 14310,
    NPC_BRONZE_SPAWNER          = 14311,
    NPC_BLUE_SPAWNER            = 14312,

    NPC_BRONZE_DRAKONID         = 14263,
    NPC_BLUE_DRAKONID           = 14261,
    NPC_RED_DRAKONID            = 14264,
    NPC_GREEN_DRAKONID          = 14262,
    NPC_BLACK_DRAKONID          = 14265,
    NPC_CHROMATIC_DRAKONID      = 14302,
    NPC_BONE_CONSTRUCT          = 14605
};

enum BWLGameObjectIds
{
    GO_BLACK_DRAGON_EGG             = 177807,
    GO_PORTCULLIS_RAZORGORE         = 175946,
    GO_PORTCULLIS_RAZORGORE_ROOM    = 176964,
    GO_PORTCULLIS_VAELASTRASZ       = 175185,
    GO_PORTCULLIS_BROODLORD         = 179365,
    GO_PORTCULLIS_THREEDRAGONS      = 179115,
    GO_CHROMAGGUS_LEVER             = 179148,
    GO_PORTCULLIS_CHROMAGGUS        = 179116,
    GO_PORTCULLIS_CHROMAGGUS_EXIT   = 179117,
    GO_PORTCULLIS_NEFARIAN          = 176966,
    GO_SUPPRESSION_DEVICE           = 179784
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

    SAY_NEFARIAN_VAEL_INTRO     = 14,

    // Nefarian fight
    DATA_NEFARIAN_LEFT_TUNNEL   = 15,
    DATA_NEFARIAN_RIGHT_TUNNEL  = 16,
    ACTION_NEFARIUS_ADD_KILLED  = 2
};

template <class AI, class T>
inline AI* GetBlackwingLairAI(T* obj)
{
    return GetInstanceAI<AI>(obj, BWLScriptName);
}

#define RegisterBlackwingLairCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetBlackwingLairAI)

#endif
