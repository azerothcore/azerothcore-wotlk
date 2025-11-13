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

#ifndef DEF_BRD_H
#define DEF_BRD_H

#include "CreatureAIImpl.h"

#define DataHeader "BRD"
#define BRDScriptName "instance_blackrock_depths"

enum FactionIds
{
    FACTION_NEUTRAL            = 674,
    FACTION_HOSTILE            = 754,
    FACTION_FRIEND             = 35
};

enum BRDBosses
{
    BOSS_AMBASSADOR_FLAMELASH = 0,
};

enum DataTypes
{
    TYPE_RING_OF_LAW                = 1,
    TYPE_VAULT                      = 2,
    TYPE_BAR                        = 3,
    TYPE_TOMB_OF_SEVEN              = 4,
    TYPE_LYCEUM                     = 5,
    TYPE_IRON_HALL                  = 6,

    DATA_EMPEROR                    = 10,
    DATA_PHALANX                    = 11,

    DATA_ARENA1                     = 12,
    DATA_ARENA2                     = 13,
    DATA_ARENA3                     = 14,
    DATA_ARENA4                     = 15,

    DATA_GO_BAR_KEG                 = 16,
    DATA_GO_BAR_KEG_TRAP            = 17,
    DATA_GO_BAR_DOOR                = 18,
    DATA_GO_CHALICE                 = 19,

    DATA_GOLEM_DOOR_N               = 22,
    DATA_GOLEM_DOOR_S               = 23,

    DATA_THRONE_DOOR                = 24,

    DATA_SF_BRAZIER_N               = 25,
    DATA_SF_BRAZIER_S               = 26,
    DATA_MOIRA                      = 27,
    DATA_PRIESTESS                  = 28,
    DATA_OPEN_COFFER_DOORS          = 30,

    DATA_GOLEM_LORD_ARGELMACH_INIT  = 31,
    DATA_GOLEM_LORD_ARGELMACH_ADDS  = 32,
    DATA_MAGMUS                     = 33,

    DATA_COREN                      = 34,

    DATA_ANUBSHIAH,
    DATA_EVISCERATOR,
    DATA_GOROSH,
    DATA_GRIZZLE,
    DATA_HEDRUM,
    DATA_OKTHOR,
    DATA_TIME_RING_FAIL,
    DATA_ARENA_MOBS,
    DATA_ARENA_BOSS
};

enum Creatures
{
    NPC_EMPEROR   = 9019,
    NPC_PHALANX   = 9502,
    NPC_ANGERREL  = 9035,
    NPC_DOPEREL   = 9040,
    NPC_HATEREL   = 9034,
    NPC_VILEREL   = 9036,
    NPC_SEETHREL  = 9038,
    NPC_GLOOMREL  = 9037,
    NPC_DOOMREL   = 9039,
    NPC_MOIRA     = 8929,
    NPC_PRIESTESS = 10076,

    NPC_WATCHMAN_DOOMGRIP = 9476,

    NPC_WEAPON_TECHNICIAN      = 8920,
    NPC_DOOMFORGE_ARCANASMITH  = 8900,
    NPC_RAGEREAVER_GOLEM       = 8906,
    NPC_WRATH_HAMMER_CONSTRUCT = 8907,
    NPC_GOLEM_LORD_ARGELMACH   = 8983,

    NPC_COREN_DIREBREW = 23872,

    NPC_IRONHAND_GUARDIAN = 8982,

    NPC_ARENA_SPECTATOR     = 8916,
    NPC_SHADOWFORGE_PEASANT = 8896,
    NPC_SHADOWFORCE_CITIZEN = 8902,

    NPC_SHADOWFORGE_SENATOR = 8904,

    NPC_MAGMUS = 9938,

    NPC_DREDGE_WORM     = 8925,
    NPC_DEEP_STINGER    = 8926,
    NPC_DARK_SCREECHER  = 8927,
    NPC_THUNDERSNOUT    = 8928,
    NPC_BORER_BEETLE    = 8932,
    NPC_CAVE_CREEPER    = 8933,
    NPC_GOROSH          = 9027,
    NPC_GRIZZLE         = 9028,
    NPC_EVISCERATOR     = 9029,
    NPC_OKTHOR          = 9030,
    NPC_ANUBSHIAH       = 9031,
    NPC_HEDRUM          = 9032
};

enum eChallenge
{
    QUEST_THE_CHALLENGE      = 9015,
    GO_BANNER_OF_PROVOCATION = 181058,
    GO_ARENA_SPOILS          = 181074,

    NPC_GRIMSTONE = 10096,
    NPC_THELDREN  = 16059,
};

const uint32 theldrenTeam[] = {16053, 16055, 16050, 16051, 16049, 16052, 16054, 16058};

template <class AI, class T>
inline AI* GetBlackrockDepthsAI(T* obj)
{
    return GetInstanceAI<AI>(obj, BRDScriptName);
}

#endif
