/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_UTILS_H
#define __AB_UTILS_H

#include "ABInflectionPointSettings.h"
#include "ABLevelScalingDynamicLevelSettings.h"
#include "ABMapInfo.h"
#include "ABStatModifiers.h"
#include "AutoBalance.h"

#include "Creature.h"
#include "Map.h"
#include "SharedDefines.h"

#include <list>
#include <map>
#include <string>

void AddCreatureToMapCreatureList(Creature* creature, bool addToCreatureList = true, bool forceRecalculation = false);
void RemoveCreatureFromMapData(Creature* creature);

uint64_t GetCurrentConfigTime();
uint32 getBaseExpansionValueForLevel(const uint32 baseValues[3], uint8 targetLevel);
float getBaseExpansionValueForLevel(const float baseValues[3], uint8 targetLevel);
float getDefaultMultiplier(Map* map, AutoBalanceInflectionPointSettings inflectionPointSettings);
int GetForcedNumPlayers(int creatureId);
World_Multipliers getWorldMultiplier(Map* map, BaseValueType baseValueType);
AutoBalanceInflectionPointSettings getInflectionPointSettings(InstanceMap* instanceMap, bool isBoss = false);
void getStatModifiersDebug(Map* map, Creature* creature, std::string message);
AutoBalanceStatModifiers getStatModifiers(Map* map, Creature* creature = nullptr);

bool hasBossOverride(uint32 dungeonId);
bool hasDungeonOverride(uint32 dungeonId);
bool hasDynamicLevelOverride(uint32 dungeonId);
bool hasLevelScalingDistanceCheckOverride(uint32 dungeonId);
bool hasStatModifierBossOverride(uint32 dungeonId);
bool hasStatModifierCreatureOverride(uint32 creatureId);
bool hasStatModifierOverride(uint32 dungeonId);

bool isBossOrBossSummon(Creature* creature, bool log = false);
bool isCreatureRelevant(Creature* creature);
bool isDungeonInDisabledDungeonIds(uint32 dungeonId);
bool isDungeonInMinPlayerMap(uint32 dungeonId, bool isHeroic);

void LoadForcedCreatureIdsFromString(std::string creatureIds, int forcedPlayerCount);
std::list<uint32> LoadDisabledDungeons(std::string dungeonIdString);
std::map <uint32, uint32> LoadDistanceCheckOverrides(std::string dungeonIdString);
std::map <uint8 , AutoBalanceLevelScalingDynamicLevelSettings> LoadDynamicLevelOverrides(std::string dungeonIdString);
std::map <uint32, AutoBalanceInflectionPointSettings> LoadInflectionPointOverrides(std::string dungeonIdString);
void LoadMapSettings(Map* map);
std::map <uint32, uint8> LoadMinPlayersPerDungeonId(std::string minPlayersString);
std::map <uint32, AutoBalanceStatModifiers> LoadStatModifierOverrides(std::string dungeonIdString);

bool ShouldMapBeEnabled (Map* map);
void UpdateMapPlayerStats (Map* map);
void AddPlayerToMap(Map* map, Player* player);
bool RemovePlayerFromMap(Map* map, Player* player);
bool UpdateMapDataIfNeeded(Map* map, bool force = false);
AutoBalanceMapInfo* GetMapInfo(Map* map);

#endif
