/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_MAP_INFO_H
#define __AB_MAP_INFO_H

#include "Creature.h"
#include "DataMap.h"
#include "Player.h"

#include <vector>

class AutoBalanceMapInfo : public DataMap::Base
{
public:
    AutoBalanceMapInfo() {}

    std::vector<Creature*> allMapCreatures;              // All creatures in the map, active and non-active
    std::vector<Player*>   allMapPlayers;                // All players that are currently in the map

    bool     enabled                            = false; // Should AutoBalance make any changes to this map or its creatures?

    uint64_t globalConfigTime                   = 1;     // The last global config time that this map was updated
    uint64_t mapConfigTime                      = 1;     // The last map config time that this map was updated

    uint8    playerCount                        = 0;     // The actual number of non-GM players in the map
    uint8    adjustedPlayerCount                = 0;     // The currently difficulty level expressed as number of players
    uint8    minPlayers                         = 1;     // Will be set by the config

    uint8    mapLevel                           = 0;     // Calculated from the avgCreatureLevel
    uint8    lowestPlayerLevel                  = 0;     // The lowest-level player in the map
    uint8    highestPlayerLevel                 = 0;     // The highest-level player in the map

    uint8    lfgMinLevel                        = 0;     // The minimum level for the map according to LFG
    uint8    lfgTargetLevel                     = 0;     // The target level for the map according to LFG
    uint8    lfgMaxLevel                        = 0;     // The maximum level for the map according to LFG

    uint8    worldMultiplierTargetLevel         = 0;     // The level of the pseudo-creature that the world modifiers scale to
    float    worldDamageHealingMultiplier       = 1.0f;  // The damage/healing multiplier for the world (where source isn't an enemy creature)
    float    scaledWorldDamageHealingMultiplier = 1.0f;  // The damage/healing multiplier for the world (where source isn't an enemy creature)
    float    worldHealthMultiplier              = 1.0f;  // The "health" multiplier for any destructible buildings in the map

    bool     combatLocked                       = false; // Whether or not the map is combat locked
    bool     combatLockTripped                  = false; // Set to true when combat locking was needed during this current combat (some tried to leave)
    uint8    combatLockMinPlayers               = 0;     // The instance cannot be set to less than this number of players until combat ends

    uint8    highestCreatureLevel               = 0;     // The highest-level creature in the map
    uint8    lowestCreatureLevel                = 0;     // The lowest-level creature in the map
    float    avgCreatureLevel                   = 0;     // The average level of all active creatures in the map (continuously updated)
    uint32   activeCreatureCount                = 0;     // The number of creatures in the map that are included in the map's stats (not necessarily alive)

    bool     isLevelScalingEnabled              = false; // Whether level scaling is enabled on this map
    uint8    levelScalingSkipHigherLevels       = 0;     // Used to determine if this map should scale or not
    uint8    levelScalingSkipLowerLevels        = 0;     // Used to determine if this map should scale or not
    uint8    levelScalingDynamicCeiling         = 0;     // How many levels MORE than the highestPlayerLevel creature should be scaled to
    uint8    levelScalingDynamicFloor           = 0;     // How many levels LESS than the highestPlayerLevel creature should be scaled to

    uint8    prevMapLevel                       = 0;     // Used to reduce calculations when they are not necessary
    bool     initialized                        = false; // Whether or not the map has been initialized
};
#endif
