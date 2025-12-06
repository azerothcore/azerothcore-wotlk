/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_CREATURE_INFO_H
#define __AB_CREATURE_INFO_H

#include "AutoBalance.h"

#include "Creature.h"
#include "DataMap.h"

class AutoBalanceCreatureInfo : public DataMap::Base
{
public:
    AutoBalanceCreatureInfo() {}

    uint64_t    mapConfigTime          = 1;       // The last map config time that this creature was updated

    uint32      instancePlayerCount    = 0;       // The number of players this creature has been scaled for
    uint8       selectedLevel          = 0;       // The level that this creature should be set to

    float       DamageMultiplier       = 1.0f;    // Per-player damage multiplier (no level scaling)
    float       ScaledDamageMultiplier = 1.0f;    // Per-player and level scaling damage multiplier

    float       HealthMultiplier       = 1.0f;    // Per-player health multiplier (no level scaling)
    float       ScaledHealthMultiplier = 1.0f;    // Per-player and level scaling health multiplier

    float       ManaMultiplier         = 1.0f;    // Per-player mana multiplier (no level scaling)
    float       ScaledManaMultiplier   = 1.0f;    // Per-player and level scaling mana multiplier

    float       ArmorMultiplier        = 1.0f;    // Per-player armor multiplier (no level scaling)
    float       ScaledArmorMultiplier  = 1.0f;    // Per-player and level scaling armor multiplier

    float       CCDurationMultiplier   = 1.0f;    // Per-player crowd control duration multiplier (level scaling doesn't affect this)

    float       XPModifier             = 1.0f;    // Per-player XP modifier (level scaling provided by normal XP distribution)
    float       MoneyModifier          = 1.0f;    // Per-player money modifier (no level scaling)

    uint8       UnmodifiedLevel        = 0;       // Original level of the creature as determined by the game

    bool        isActive               = false;   // Whether or not the current creature is affecting map stats. May change as conditions change.
    bool        wasAliveNowDead        = false;   // Whether or not the creature was alive and is now dead
    bool        isInCreatureList       = false;   // Whether or not the creature is in the map's creature list
    bool        isBrandNew             = false;   // Whether or not the creature is brand new to the map (hasn't been added to the world yet)
    bool        neverLevelScale        = false;   // Whether or not the creature should never be level scaled (can still be player scaled)

    uint32      initialMaxHealth       = 0;       // Stored max health value to be applied just before being added to the world

    // creature->IsSummon()                       // Whether or not the creature is a summon
    Creature*   summoner               = nullptr; // The creature that summoned this creature
    std::string summonerName           = "";      // The name of the creature that summoned this creature
    uint8       summonerLevel          = 0;       // The level of the creature that summoned this creature
    bool        isCloneOfSummoner      = false;   // Whether or not the creature is a clone of its summoner

    Relevance   relevance              = AUTOBALANCE_RELEVANCE_UNCHECKED; // Whether or not the creature is relevant for scaling
};


#endif
