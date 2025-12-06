/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#include "ABUtils.h"

#include "ABConfig.h"
#include "ABCreatureInfo.h"
#include "ABMapInfo.h"

#include "Log.h"
#include "Player.h"
#include "TemporarySummon.h"

#include <chrono>
#include <sstream>

void AddCreatureToMapCreatureList(Creature* creature, bool addToCreatureList, bool forceRecalculation)
{
    //
    // Make sure we have a creature and that it's assigned to a map
    //

    if (!creature || !creature->GetMap())
        return;

    //
    // If this isn't a dungeon, skip
    //

    if (!(creature->GetMap()->IsDungeon()))
        return;

    //
    // Get AutoBalance data
    //

    Map*                     map            = creature->GetMap();
    InstanceMap*             instanceMap    = map->ToInstanceMap();
    AutoBalanceMapInfo*      mapABInfo      = GetMapInfo(instanceMap);
    AutoBalanceCreatureInfo* creatureABInfo = creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

    //
    // Handle summoned creatures
    //

    if (creature->IsSummon())
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is a summon.",
            creature->GetName(),
            creatureABInfo->UnmodifiedLevel);

        if (creature->ToTempSummon() &&
            creature->ToTempSummon()->GetSummoner() &&
            creature->ToTempSummon()->GetSummoner()->ToCreature())
        {
            creatureABInfo->summoner      = creature->ToTempSummon()->GetSummoner()->ToCreature();
            creatureABInfo->summonerName  = creatureABInfo->summoner->GetName();
            creatureABInfo->summonerLevel = creatureABInfo->summoner->GetLevel();

            Creature* summoner = creatureABInfo->summoner;

            if (!summoner)
            {
                creatureABInfo->UnmodifiedLevel = mapABInfo->avgCreatureLevel;

                LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | is not owned by a summoner. Original level is {}.",
                    creature->GetName(),
                    creatureABInfo->UnmodifiedLevel);
            }
            else
            {
                AutoBalanceCreatureInfo* summonerABInfo = summoner->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

                LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | is owned by {} ({}).",
                    creature->GetName(),
                    creatureABInfo->UnmodifiedLevel,
                    summoner->GetName(),
                    summonerABInfo->UnmodifiedLevel);

                //
                // If the creature or its summoner is a trigger
                //
                if (creature->IsTrigger() || summoner->IsTrigger())
                {
                    LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | or their summoner is a trigger.",
                        creature->GetName(),
                        creatureABInfo->UnmodifiedLevel);

                    //
                    // If the creature is within the expected level range, allow scaling
                    //

                    if ((creatureABInfo->UnmodifiedLevel >= (uint8)(((float)mapABInfo->lfgMinLevel * .85f) + 0.5f)) &&
                        (creatureABInfo->UnmodifiedLevel <= (uint8)(((float)mapABInfo->lfgMaxLevel * 1.15f) + 0.5f)))
                    {
                        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | original level is within the expected NPC level for this map ({} to {}). Level scaling is allowed.",
                            creature->GetName(),
                            creatureABInfo->UnmodifiedLevel,
                            (uint8)(((float)mapABInfo->lfgMinLevel * .85f) + 0.5f),
                            (uint8)(((float)mapABInfo->lfgMaxLevel * 1.15f) + 0.5f));
                    }
                    else
                    {
                        creatureABInfo->neverLevelScale = true;

                        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | original level is outside the expected NPC level for this map ({} to {}). It will keep its original level.",
                            creature->GetName(),
                            creatureABInfo->UnmodifiedLevel,
                            (uint8)(((float)mapABInfo->lfgMinLevel * .85f) + 0.5f),
                            (uint8)(((float)mapABInfo->lfgMaxLevel * 1.15f) + 0.5f));
                    }
                }
                //
                // If the creature is not a trigger, match the summoner's level
                //
                else
                {
                    //
                    // Match the summoner's level
                    //
                    creatureABInfo->UnmodifiedLevel = summonerABInfo->UnmodifiedLevel;

                    LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | original level will match summoner's level ({}).",
                        creature->GetName(),
                        creatureABInfo->UnmodifiedLevel,
                        summonerABInfo->UnmodifiedLevel
                    );
                }
            }
        }
        //
        // Summoned by a player
        //
        else if(creature->ToTempSummon() &&
                creature->ToTempSummon()->GetSummoner() &&
                creature->ToTempSummon()->GetSummoner()->ToPlayer())
        {
            Player* summoner = creature->ToTempSummon()->GetSummoner()->ToPlayer();

            //
            // Is this creature relevant?
            //

            if (isCreatureRelevant(creature))
            {
                LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | is an enemy owned by player {} ({}). Summon original level set to ({}).",
                    creature->GetName(),
                    creatureABInfo->UnmodifiedLevel,
                    summoner->GetName(),
                    summoner->GetLevel(),
                    creatureABInfo->UnmodifiedLevel);
            }
            //
            // Summon is not relevant
            //
            else
            {
                uint8 newLevel = std::min(summoner->GetLevel(), creature->GetCreatureTemplate()->maxlevel);

                LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | is an ally owned by player {} ({}). Summon original level set to ({}) level ({}).",
                    creature->GetName(),
                    creatureABInfo->UnmodifiedLevel,
                    summoner->GetName(),
                    summoner->GetLevel(),
                    newLevel == summoner->GetLevel() ? "player's" : "creature template's max",
                    newLevel);

                creatureABInfo->UnmodifiedLevel = newLevel;
            }
        }
        //
        // Pets and totems
        //
        else if (creature->IsCreatedByPlayer() || creature->IsPet() || creature->IsHunterPet() || creature->IsTotem())
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | is a {}. Original level set to ({}).",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel,
                creature->IsCreatedByPlayer() ? "creature created by a player" : creature->IsPet() ? "pet" : creature->IsHunterPet() ? "hunter pet" : "totem",
                creatureABInfo->UnmodifiedLevel);
        }
        else
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | does not have a summoner. Summon original level set to ({}).",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel,
                creatureABInfo->UnmodifiedLevel);
        }

        //
        // if this is a summon, we shouldn't track it in any list and it does not contribute to the average level
        //

        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | will not affect the map's stats.", creature->GetName(), creatureABInfo->UnmodifiedLevel);
        return;
    }
    //
    // Handle "special" creatures
    //
    else if (creature->IsCritter() || creature->IsTotem() || creature->IsTrigger())
    {
        //
        // If this is an intentionally-low-level creature (below 85% of the minimum LFG level), leave it where it is
        // If this is an intentionally-high-level creature (above 125% of the maximum LFG level), leave it where it is
        //
        if ((creatureABInfo->UnmodifiedLevel < (uint8)(((float)mapABInfo->lfgMinLevel * .85f) + 0.5f)) ||
            (creatureABInfo->UnmodifiedLevel > (uint8)(((float)mapABInfo->lfgMaxLevel * 1.15f) + 0.5f)))
        {
            creatureABInfo->neverLevelScale = true;

            LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | is a {} and is outside the expected NPC level for this map ({} to {}). Keeping original level of {}.",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel,
                creature->IsCritter() ? "critter" : creature->IsTotem() ? "totem" : "trigger",
                (uint8)(((float)mapABInfo->lfgMinLevel * .85f) + 0.5f),
                (uint8)(((float)mapABInfo->lfgMaxLevel * 1.15f) + 0.5f),
                creatureABInfo->UnmodifiedLevel);
        }
        //
        // Otherwise, set it to the target level of the instance so it will get scaled properly
        //
        else
        {
            creatureABInfo->UnmodifiedLevel = mapABInfo->lfgTargetLevel;

            LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) (summon) | is a {} and is within the expected NPC level for this map ({} to {}). Keeping original level of {}.",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel,
                creature->IsCritter() ? "critter" : creature->IsTotem() ? "totem" : "trigger",
                (uint8)(((float)mapABInfo->lfgMinLevel * .85f) + 0.5f),
                (uint8)(((float)mapABInfo->lfgMaxLevel * 1.15f) + 0.5f),
                creatureABInfo->UnmodifiedLevel);
        }
    }
    //
    // Creature isn't a summon, just store their unmodified level
    //
    else
    {
        creatureABInfo->UnmodifiedLevel = creatureABInfo->UnmodifiedLevel;

        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | Original level set to ({}).",
            creature->GetName(),
            creatureABInfo->UnmodifiedLevel,
            creatureABInfo->UnmodifiedLevel);
    }

    //
    // If this is a creature controlled by the player, skip for stats
    //
    if (((creature->IsHunterPet() || creature->IsPet() || creature->IsSummon()) && creature->IsControlledByPlayer()))
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is controlled by the player and will not affect the map's stats.", creature->GetName(), creatureABInfo->UnmodifiedLevel);
        return;
    }

    //
    // If this is a non-relevant creature, skip for stats
    //

    if (creature->IsCritter() || creature->IsTotem() || creature->IsTrigger())
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is a {} and will not affect the map's stats.",
            creature->GetName(),
            creatureABInfo->UnmodifiedLevel,
            creature->IsCritter() ? "critter" : creature->IsTotem() ? "totem" : "trigger");
        return;
    }

    //
    // If the creature level is below 85% of the minimum LFG level, assume it's a flavor creature and shouldn't be tracked
    //

    if (creatureABInfo->UnmodifiedLevel < (uint8)(((float)mapABInfo->lfgMinLevel * 0.85f) + 0.5f))
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is below 85% of the LFG min level of {} and will not affect the map's stats.", creature->GetName(), creatureABInfo->UnmodifiedLevel, mapABInfo->lfgMinLevel);
        return;
    }

    //
    // If the creature level is above 125% of the maximum LFG level, assume it's a flavor creature or holiday boss and shouldn't be tracked
    //

    if (creatureABInfo->UnmodifiedLevel > (uint8)(((float)mapABInfo->lfgMaxLevel * 1.15f) + 0.5f))
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is above 115% of the LFG max level of {} and will not affect the map's stats.", creature->GetName(), creatureABInfo->UnmodifiedLevel, mapABInfo->lfgMaxLevel);
        return;
    }

    //
    // Is this creature already in the map's creature list?
    //

    bool isCreatureAlreadyInCreatureList = creatureABInfo->isInCreatureList;

    //
    // Add the creature to the map's creature list if configured to do so
    //
    if (addToCreatureList && !isCreatureAlreadyInCreatureList)
    {
        mapABInfo->allMapCreatures.push_back(creature);
        creatureABInfo->isInCreatureList = true;

        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is #{} in the creature list.", creature->GetName(), creatureABInfo->UnmodifiedLevel, mapABInfo->allMapCreatures.size());
    }

    //
    // Alter stats for the map if needed
    //

    bool isIncludedInMapStats = true;

    //
    // If this creature was already in the creature list, don't consider it for map stats (again)
    // exception for if forceRecalculation is true (used on player enter/exit to recalculate map stats)
    //

    if (isCreatureAlreadyInCreatureList && !forceRecalculation)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is already included in map stats.", creature->GetName(), creatureABInfo->UnmodifiedLevel);

        // ensure that this creature is marked active
        creatureABInfo->isActive = true;

        // increment the active creature counter
        mapABInfo->activeCreatureCount++;

        return;
    }

    //
    // Only do these additional checks if we still think they need to be applied to the map stats
    //

    if (isIncludedInMapStats)
    {
        //
        // If the creature is vendor, trainer, or has gossip, don't use it to update map stats
        //
        if ((creature->IsVendor() ||
            creature->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP) ||
            creature->HasNpcFlag(UNIT_NPC_FLAG_QUESTGIVER) ||
            creature->HasNpcFlag(UNIT_NPC_FLAG_TRAINER) ||
            creature->HasNpcFlag(UNIT_NPC_FLAG_TRAINER_PROFESSION) ||
            creature->HasNpcFlag(UNIT_NPC_FLAG_REPAIR) ||
            creature->HasUnitFlag(UNIT_FLAG_IMMUNE_TO_PC) ||
            creature->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE)) &&
            (!isBossOrBossSummon(creature)))
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is a a vendor, trainer, or is otherwise not attackable - do not include in map stats.", creature->GetName(), creatureABInfo->UnmodifiedLevel);

            isIncludedInMapStats = false;
        }
        else
        {
            //
            // If the creature is friendly to a player, don't use it to update map stats
            //
            for (std::vector<Player*>::const_iterator playerIterator = mapABInfo->allMapPlayers.begin(); playerIterator != mapABInfo->allMapPlayers.end(); ++playerIterator)
            {
                Player* thisPlayer = *playerIterator;

                //
                // If this player is a Game Master, skip
                //

                if (thisPlayer->IsGameMaster())
                    continue;

                //
                // If the creature is friendly and not a boss
                //

                if (creature->IsFriendlyTo(thisPlayer) && !isBossOrBossSummon(creature))
                {
                    LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is friendly to {} - do not include in map stats.",
                        creature->GetName(),
                        creatureABInfo->UnmodifiedLevel,
                        thisPlayer->GetName()
                    );
                    isIncludedInMapStats = false;
                    break;
                }
            }

            //
            // Perform the distance check if an override is configured for this map
            //
            if (hasLevelScalingDistanceCheckOverride(instanceMap->GetId()))
            {
                uint32 distance = levelScalingDistanceCheckOverrides[instanceMap->GetId()];
                bool isPlayerWithinDistance = false;

                for (std::vector<Player*>::const_iterator playerIterator = mapABInfo->allMapPlayers.begin(); playerIterator != mapABInfo->allMapPlayers.end(); ++playerIterator)
                {
                    Player* thisPlayer = *playerIterator;

                    //
                    // If this player is a Game Master, skip
                    //

                    if (thisPlayer->IsGameMaster())
                        continue;

                    if (thisPlayer->IsWithinDist(creature, 500))
                    {
                        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is in range ({} world units) of player {} and is considered active.", creature->GetName(), creatureABInfo->UnmodifiedLevel, distance, thisPlayer->GetName());
                        isPlayerWithinDistance = true;
                        break;
                    }
                    else
                    {
                        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is NOT in range ({} world units) of any player and is NOT considered active.",
                            creature->GetName(),
                            creatureABInfo->UnmodifiedLevel,
                            distance
                        );
                    }
                }

                //
                // If no players were within the distance, don't include this creature in the map stats
                //

                if (!isPlayerWithinDistance)
                    isIncludedInMapStats = false;
            }
        }
    }

    if (isIncludedInMapStats)
    {
        //
        // Mark this creature as being considered in the map stats
        //

        creatureABInfo->isActive = true;

        //
        // Update the highest and lowest creature levels
        //

        if (creatureABInfo->UnmodifiedLevel > mapABInfo->highestCreatureLevel || mapABInfo->highestCreatureLevel == 0)
            mapABInfo->highestCreatureLevel = creatureABInfo->UnmodifiedLevel;
        if (creatureABInfo->UnmodifiedLevel < mapABInfo->lowestCreatureLevel || mapABInfo->lowestCreatureLevel == 0)
            mapABInfo->lowestCreatureLevel = creatureABInfo->UnmodifiedLevel;

        //
        // Calculate the new average creature level
        //

        float creatureCount = mapABInfo->activeCreatureCount;
        float oldAvgCreatureLevel = mapABInfo->avgCreatureLevel;
        float newAvgCreatureLevel = (((float)mapABInfo->avgCreatureLevel * creatureCount) + (float)creatureABInfo->UnmodifiedLevel) / (creatureCount + 1.0f);

        mapABInfo->avgCreatureLevel = newAvgCreatureLevel;

        //
        // Increment the active creature counter
        //

        mapABInfo->activeCreatureCount++;

        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: Creature {} ({}) | is included in map stats (active), adjusting avgCreatureLevel to ({})", creature->GetName(), creatureABInfo->UnmodifiedLevel, newAvgCreatureLevel);

        //
        // If the average creature level transitions from one whole number to the next, reset the map's config time so it will refresh
        //

        if (round(oldAvgCreatureLevel) != round(newAvgCreatureLevel))
        {
            mapABInfo->mapConfigTime = 1;

            LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: {} ({}{}) | average creature level changes {}->{}. Force map update. {} ({}{}) map config set to ({}).",
                instanceMap->GetMapName(),
                instanceMap->GetId(),
                instanceMap->GetInstanceId() ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
                round(oldAvgCreatureLevel),
                round(newAvgCreatureLevel),
                map->GetMapName(),
                map->GetId(),
                map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                mapABInfo->mapConfigTime);
        }

        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddCreatureToMapCreatureList: There are ({}) creatures included (active) in map stats.", mapABInfo->activeCreatureCount);
    }
}

void RemoveCreatureFromMapData(Creature* creature)
{
    //
    // Get map data
    //

    AutoBalanceMapInfo *mapABInfo = GetMapInfo(creature->GetMap());

    //
    // If the creature is in the all creature list, remove it
    //

    if (mapABInfo->allMapCreatures.size() > 0)
    {
        for (std::vector<Creature*>::iterator creatureIteration = mapABInfo->allMapCreatures.begin(); creatureIteration != mapABInfo->allMapCreatures.end(); ++creatureIteration)
        {
            if (*creatureIteration == creature)
            {
                LOG_DEBUG("module.AutoBalance", "AutoBalance::RemoveCreatureFromMapData: Creature {} ({}) | is in the creature list and will be removed. There are {} creatures left.", creature->GetName(), creature->GetLevel(), mapABInfo->allMapCreatures.size() - 1);
                mapABInfo->allMapCreatures.erase(creatureIteration);

                //
                // Mark this creature as removed
                //

                AutoBalanceCreatureInfo *creatureABInfo = creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");
                creatureABInfo->isInCreatureList = false;

                //
                // Decrement the active creature counter if they were considered active
                //

                if (creatureABInfo->isActive)
                {
                    LOG_DEBUG("module.AutoBalance", "AutoBalance::RemoveCreatureFromMapData: Creature {} ({}) | is no longer active. There are {} active creatures left.",
                        creature->GetName(),
                        creature->GetLevel(),
                        mapABInfo->activeCreatureCount - 1);

                    if (mapABInfo->activeCreatureCount > 0)
                        mapABInfo->activeCreatureCount--;
                    else
                    {
                        LOG_DEBUG("module.AutoBalance", "AutoBalance::RemoveCreatureFromMapData: Map {} ({}{}) | activeCreatureCount is already 0. This should not happen.",
                            creature->GetMap()->GetMapName(),
                            creature->GetMap()->GetId(),
                            creature->GetMap()->GetInstanceId() ? "-" + std::to_string(creature->GetMap()->GetInstanceId()) : "");
                    }
                }

                break;
            }
        }
    }
}

uint64_t GetCurrentConfigTime()
{
    return std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
}

uint32 getBaseExpansionValueForLevel(const uint32 baseValues[3], uint8 targetLevel)
{
    // convert baseValues from an array of uint32 to an array of float
    float floatBaseValues[3];

    for (int i = 0; i < 3; i++)
        floatBaseValues[i] = (float)baseValues[i];

    // return the result
    return getBaseExpansionValueForLevel(floatBaseValues, targetLevel);
}

float getBaseExpansionValueForLevel(const float baseValues[3], uint8 targetLevel)
{
    // the database holds multiple base values depending on the expansion
    // this function returns the correct base value for the given level and
    // smooths the transition between expansions

    float vanillaValue = baseValues[0];
    float bcValue      = baseValues[1];
    float wotlkValue   = baseValues[2];

    float returnValue;

    // vanilla
    if (targetLevel <= 60)
    {
        returnValue = vanillaValue;
        //LOG_DEBUG("module.AutoBalance", "AutoBalance::getBaseExpansionValueForLevel: Returning Vanilla = {}", returnValue);
    }
    // transition from vanilla to BC
    else if (targetLevel < 63)
    {
        float vanillaMultiplier = (63 - targetLevel) / 3.0;
        float bcMultiplier      = 1.0f - vanillaMultiplier;

        returnValue = (vanillaValue * vanillaMultiplier) + (bcValue * bcMultiplier);
        //LOG_DEBUG("module.AutoBalance", "AutoBalance::getBaseExpansionValueForLevel: Returning Vanilla/BC = {}", returnValue);
    }
    // BC
    else if (targetLevel <= 70)
    {
        returnValue = bcValue;
        //LOG_DEBUG("module.AutoBalance", "AutoBalance::getBaseExpansionValueForLevel: Returning BC = {}", returnValue);
    }
    // transition from BC to WotLK
    else if (targetLevel < 73)
    {
        float bcMultiplier    = (73 - targetLevel) / 3.0f;
        float wotlkMultiplier = 1.0f - bcMultiplier;

        returnValue = (bcValue * bcMultiplier) + (wotlkValue * wotlkMultiplier);
        //LOG_DEBUG("module.AutoBalance", "AutoBalance::getBaseExpansionValueForLevel: Returning BC/WotLK = {}", returnValue);
    }
    // WotLK
    else
    {
        returnValue = wotlkValue;
        //LOG_DEBUG("module.AutoBalance", "AutoBalance::getBaseExpansionValueForLevel: Returning WotLK = {}", returnValue);
    }

    return returnValue;
}

float getDefaultMultiplier(Map* map, AutoBalanceInflectionPointSettings inflectionPointSettings)
{
    // You can visually see the effects of this function by using this spreadsheet:
    // https://docs.google.com/spreadsheets/d/100cmKIJIjCZ-ncWd0K9ykO8KUgwFTcwg4h2nfE_UeCc/copy

    //
    // Get the max player count for the map
    //
    uint32 maxNumberOfPlayers = map->ToInstanceMap()->GetMaxPlayers();

    //
    // Get the adjustedPlayerCount for this instance
    //
    AutoBalanceMapInfo *mapABInfo = GetMapInfo(map);
    float adjustedPlayerCount     = mapABInfo->adjustedPlayerCount;

    //
    // #maththings
    //
    float diff = ((float)maxNumberOfPlayers/5)*1.5f;

    //
    // For math reasons that I do not understand, curveCeiling needs to be adjusted to bring the actual multiplier
    // closer to the curveCeiling setting. Create an adjustment based on how much the ceiling should be changed at
    // the max players multiplier.
    //
    float curveCeilingAdjustment =
        inflectionPointSettings.curveCeiling /
        (((tanh(((float)maxNumberOfPlayers - inflectionPointSettings.value) / diff) + 1.0f) / 2.0f) *
        (inflectionPointSettings.curveCeiling - inflectionPointSettings.curveFloor) + inflectionPointSettings.curveFloor);

    //
    // Adjust the multiplier based on the configured floor and ceiling values, plus the ceiling adjustment we just calculated
    //
    float defaultMultiplier =
        ((tanh((adjustedPlayerCount - inflectionPointSettings.value) / diff) + 1.0f) / 2.0f) *
        (inflectionPointSettings.curveCeiling * curveCeilingAdjustment - inflectionPointSettings.curveFloor) +
        inflectionPointSettings.curveFloor;

    return defaultMultiplier;
}

int GetForcedNumPlayers(int creatureId)
{
    if (forcedCreatureIds.find(creatureId) == forcedCreatureIds.end()) // Don't want the forcedCreatureIds map to blowup to a massive empty array
        return -1;

    return forcedCreatureIds[creatureId];
}

World_Multipliers getWorldMultiplier(Map* map, BaseValueType baseValueType)
{
    World_Multipliers worldMultipliers;

    //
    // null check
    //

    if (!map)
        return worldMultipliers;

    //
    // If this isn't a dungeon, return defaults
    //

    if (!(map->IsDungeon()))
        return worldMultipliers;

    //
    // Grab map data
    //
    AutoBalanceMapInfo *mapABInfo = GetMapInfo(map);

    //
    // If the map isn't enabled, return defaults
    //

    if (!mapABInfo->enabled)
        return worldMultipliers;

    //
    // If there are no players on the map, return defaults
    //

    if (mapABInfo->allMapPlayers.size() == 0)
        return worldMultipliers;

    //
    // If creatures haven't been counted yet, return defaults
    //

    if (mapABInfo->avgCreatureLevel == 0)
        return worldMultipliers;

    //
    // Create some data variables
    //

    InstanceMap* instanceMap      = map->ToInstanceMap();
    uint8 avgCreatureLevelRounded = (uint8)(mapABInfo->avgCreatureLevel + 0.5f);

    //
    // Get the inflection point settings for this map
    //

    AutoBalanceInflectionPointSettings inflectionPointSettings = getInflectionPointSettings(instanceMap);

    //
    // Generate the default multiplier before level scaling
    // This value is only based on the adjusted number of players in the instance
    //

    float worldMultiplier   = 1.0f;
    float defaultMultiplier = getDefaultMultiplier(map, inflectionPointSettings);

    LOG_DEBUG("module.AutoBalance",
        "AutoBalance::getWorldMultiplier: Map {} ({}) {} | defaultMultiplier ({}) = getDefaultMultiplier(map, inflectionPointSettings)",
        map->GetMapName(),
        avgCreatureLevelRounded,
        baseValueType == BaseValueType::AUTOBALANCE_HEALTH ? "health" : "damage",
        defaultMultiplier
    );

    //
    // Multiply by the appropriate stat modifiers
    //
    AutoBalanceStatModifiers statModifiers = getStatModifiers(map);

    if (baseValueType == BaseValueType::AUTOBALANCE_HEALTH) // health
        worldMultiplier = defaultMultiplier * statModifiers.global * statModifiers.health;
    else // damage
        worldMultiplier = defaultMultiplier * statModifiers.global * statModifiers.damage;

    LOG_DEBUG("module.AutoBalance",
        "AutoBalance::getWorldMultiplier: Map {} ({}) {} | worldMultiplier ({}) = defaultMultiplier ({}) * statModifiers.global ({}) * statModifiers.{} ({})",
        map->GetMapName(),
        avgCreatureLevelRounded,
        baseValueType == BaseValueType::AUTOBALANCE_HEALTH ? "health" : "damage",
        worldMultiplier,
        defaultMultiplier,
        statModifiers.global,
        baseValueType == BaseValueType::AUTOBALANCE_HEALTH ? "health" : "damage",
        baseValueType == BaseValueType::AUTOBALANCE_HEALTH ? statModifiers.health : statModifiers.damage
    );

    //
    // Store the unscaled multiplier
    //
    worldMultipliers.unscaled = worldMultiplier;

    LOG_DEBUG("module.AutoBalance", "AutoBalance::getWorldMultiplier: Map {} ({}) {} | multiplier before level scaling = ({}).",
            map->GetMapName(),
            avgCreatureLevelRounded,
            baseValueType == BaseValueType::AUTOBALANCE_HEALTH ? "health" : "damage",
            worldMultiplier
    );

    //
    // Only scale based on level if level scaling is enabled and the instance's average creature level is not within the skip range
    //

    if (LevelScaling &&
            (
                (mapABInfo->avgCreatureLevel > mapABInfo->highestPlayerLevel + mapABInfo->levelScalingSkipHigherLevels || mapABInfo->levelScalingSkipHigherLevels == 0) ||
                (mapABInfo->avgCreatureLevel < mapABInfo->highestPlayerLevel - mapABInfo->levelScalingSkipLowerLevels || mapABInfo->levelScalingSkipLowerLevels == 0)
            )
        )
    {
        mapABInfo->worldMultiplierTargetLevel = mapABInfo->highestPlayerLevel;

        LOG_DEBUG("module.AutoBalance", "AutoBalance::getWorldMultiplier: Map {} ({}) {} | level will be scaled to {}.",
            map->GetMapName(),
            avgCreatureLevelRounded,
            baseValueType == BaseValueType::AUTOBALANCE_HEALTH ? "health" : "damage",
            mapABInfo->worldMultiplierTargetLevel
        );

        //
        // Use creature base stats to determine how to level scale the multiplier (the map is a warrior!)
        //

        CreatureBaseStats const* origMapBaseStats     = sObjectMgr->GetCreatureBaseStats(avgCreatureLevelRounded, Classes::CLASS_WARRIOR);
        CreatureBaseStats const* adjustedMapBaseStats = sObjectMgr->GetCreatureBaseStats(mapABInfo->worldMultiplierTargetLevel, Classes::CLASS_WARRIOR);

        //
        // Original Base Value
        //

        float originalBaseValue;

        if (baseValueType == BaseValueType::AUTOBALANCE_HEALTH) // health
        {
            originalBaseValue = getBaseExpansionValueForLevel(
                origMapBaseStats->BaseHealth,
                avgCreatureLevelRounded
            );
        }
        else // damage
        {
            originalBaseValue = getBaseExpansionValueForLevel(
                origMapBaseStats->BaseDamage,
                avgCreatureLevelRounded
            );
        }

        LOG_DEBUG("module.AutoBalance", "AutoBalance::getWorldMultiplier: Map {} ({}) {} | base is {}.",
            map->GetMapName(),
            avgCreatureLevelRounded,
            baseValueType == BaseValueType::AUTOBALANCE_HEALTH ? "health" : "damage",
            originalBaseValue
        );

        //
        // New Base Value
        //

        float newBaseValue;

        if (baseValueType == BaseValueType::AUTOBALANCE_HEALTH) // health
        {
            newBaseValue = getBaseExpansionValueForLevel(
                adjustedMapBaseStats->BaseHealth,
                mapABInfo->worldMultiplierTargetLevel
            );
        }
        else // damage
        {
            newBaseValue = getBaseExpansionValueForLevel(
                adjustedMapBaseStats->BaseDamage,
                mapABInfo->worldMultiplierTargetLevel
            );
        }

        LOG_DEBUG("module.AutoBalance", "AutoBalance::getWorldMultiplier: Map {} ({}->{}) {} | base is {}.",
            map->GetMapName(),
            avgCreatureLevelRounded,
            mapABInfo->worldMultiplierTargetLevel,
            baseValueType == BaseValueType::AUTOBALANCE_HEALTH ? "health" : "damage",
            newBaseValue
        );

        //
        // Update the world multiplier accordingly
        //

        worldMultiplier *= newBaseValue / originalBaseValue;

        LOG_DEBUG("module.AutoBalance", "AutoBalance::getWorldMultiplier: Map {} ({}->{}) {} | worldMultiplier ({}) = worldMultiplier ({}) * newBaseValue ({}) / originalBaseValue ({})",
            map->GetMapName(),
            mapABInfo->avgCreatureLevel,
            mapABInfo->worldMultiplierTargetLevel,
            baseValueType == BaseValueType::AUTOBALANCE_HEALTH ? "health" : "damage",
            worldMultiplier,
            worldMultiplier,
            newBaseValue,
            originalBaseValue
        );

        LOG_DEBUG("module.AutoBalance", "AutoBalance::getWorldMultiplier: Map {} ({}->{}) {} | multiplier after level scaling = ({}).",
                map->GetMapName(),
                avgCreatureLevelRounded,
                mapABInfo->worldMultiplierTargetLevel,
                baseValueType == BaseValueType::AUTOBALANCE_HEALTH ? "health" : "damage",
                worldMultiplier
        );
    }
    else
    {
        mapABInfo->worldMultiplierTargetLevel = avgCreatureLevelRounded;

        //
        // Level scaling is disabled
        //

        if (!LevelScaling)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::getWorldMultiplier: Map {} ({}) | not level scaled due to level scaling being disabled. World multiplier target level set to avgCreatureLevel ({}).",
                map->GetMapName(),
                mapABInfo->worldMultiplierTargetLevel,
                mapABInfo->worldMultiplierTargetLevel
            );
        }
        //
        // Inside the level skip range
        //
        else
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::getWorldMultiplier: Map {} ({}) | not level scaled due to being inside the level skip range. World multiplier target level set to avgCreatureLevel ({}).",
                map->GetMapName(),
                mapABInfo->worldMultiplierTargetLevel,
                mapABInfo->worldMultiplierTargetLevel
            );
        }

        LOG_DEBUG("module.AutoBalance", "AutoBalance::getWorldMultiplier: Map {} ({}) {} | multiplier after level scaling = ({}).",
                map->GetMapName(),
                mapABInfo->worldMultiplierTargetLevel,
                baseValueType == BaseValueType::AUTOBALANCE_HEALTH ? "health" : "damage",
                worldMultiplier
        );
    }

    //
    // Store the (potentially) level-scaled multiplier
    //

    worldMultipliers.scaled = worldMultiplier;

    return worldMultipliers;
}

AutoBalanceInflectionPointSettings getInflectionPointSettings (InstanceMap* instanceMap, bool isBoss)
{
    uint32 maxNumberOfPlayers = instanceMap->GetMaxPlayers();
    uint32 mapId              = instanceMap->GetEntry()->MapID;

    float  inflectionValue    = (float)maxNumberOfPlayers;
    float  curveFloor;
    float  curveCeiling;

    //
    // Base Inflection Point
    //

    if (instanceMap->IsHeroic())
    {
        if (maxNumberOfPlayers <= 5)
        {
            inflectionValue *= InflectionPointHeroic;
            curveFloor       = InflectionPointHeroicCurveFloor;
            curveCeiling     = InflectionPointHeroicCurveCeiling;
        }
        else if (maxNumberOfPlayers <= 10)
        {
            inflectionValue *= InflectionPointRaid10MHeroic;
            curveFloor       = InflectionPointRaid10MHeroicCurveFloor;
            curveCeiling     = InflectionPointRaid10MHeroicCurveCeiling;
        }
        else if (maxNumberOfPlayers <= 25)
        {
            inflectionValue *= InflectionPointRaid25MHeroic;
            curveFloor       = InflectionPointRaid25MHeroicCurveFloor;
            curveCeiling     = InflectionPointRaid25MHeroicCurveCeiling;
        }
        else
        {
            inflectionValue *= InflectionPointRaidHeroic;
            curveFloor       = InflectionPointRaidHeroicCurveFloor;
            curveCeiling     = InflectionPointRaidHeroicCurveCeiling;
        }
    }
    else
    {
        if (maxNumberOfPlayers <= 5)
        {
            inflectionValue *= InflectionPoint;
            curveFloor       = InflectionPointCurveFloor;
            curveCeiling     = InflectionPointCurveCeiling;
        }
        else if (maxNumberOfPlayers <= 10)
        {
            inflectionValue *= InflectionPointRaid10M;
            curveFloor       = InflectionPointRaid10MCurveFloor;
            curveCeiling     = InflectionPointRaid10MCurveCeiling;
        }
        else if (maxNumberOfPlayers <= 15)
        {
            inflectionValue *= InflectionPointRaid15M;
            curveFloor       = InflectionPointRaid15MCurveFloor;
            curveCeiling     = InflectionPointRaid15MCurveCeiling;
        }
        else if (maxNumberOfPlayers <= 20)
        {
            inflectionValue *= InflectionPointRaid20M;
            curveFloor       = InflectionPointRaid20MCurveFloor;
            curveCeiling     = InflectionPointRaid20MCurveCeiling;
        }
        else if (maxNumberOfPlayers <= 25)
        {
            inflectionValue *= InflectionPointRaid25M;
            curveFloor       = InflectionPointRaid25MCurveFloor;
            curveCeiling     = InflectionPointRaid25MCurveCeiling;
        }
        else if (maxNumberOfPlayers <= 40)
        {
            inflectionValue *= InflectionPointRaid40M;
            curveFloor       = InflectionPointRaid40MCurveFloor;
            curveCeiling     = InflectionPointRaid40MCurveCeiling;
        }
        else
        {
            inflectionValue *= InflectionPointRaid;
            curveFloor       = InflectionPointRaidCurveFloor;
            curveCeiling     = InflectionPointRaidCurveCeiling;
        }
    }

    //
    // Per map ID overrides alter the above settings, if set
    //

    if (hasDungeonOverride(mapId))
    {
        AutoBalanceInflectionPointSettings* myInflectionPointOverrides = &dungeonOverrides[mapId];

        //
        // Alter the inflectionValue according to the override, if set
        //

        if (myInflectionPointOverrides->value != -1)
        {
            inflectionValue  = (float)maxNumberOfPlayers; // Starting over
            inflectionValue *= myInflectionPointOverrides->value;
        }

        if (myInflectionPointOverrides->curveFloor   != -1)
            curveFloor   = myInflectionPointOverrides->curveFloor;
        if (myInflectionPointOverrides->curveCeiling != -1)
            curveCeiling = myInflectionPointOverrides->curveCeiling;
    }

    //
    // Boss Inflection Point
    //

    if (isBoss) {

        float bossInflectionPointMultiplier;

        if (instanceMap->IsHeroic())
        {
            if (maxNumberOfPlayers <= 5)
                bossInflectionPointMultiplier = InflectionPointHeroicBoss;
            else if (maxNumberOfPlayers <= 10)
                bossInflectionPointMultiplier = InflectionPointRaid10MHeroicBoss;
            else if (maxNumberOfPlayers <= 25)
                bossInflectionPointMultiplier = InflectionPointRaid25MHeroicBoss;
            else
                bossInflectionPointMultiplier = InflectionPointRaidHeroicBoss;
        }
        else
        {
            if (maxNumberOfPlayers <= 5)
                bossInflectionPointMultiplier = InflectionPointBoss;
            else if (maxNumberOfPlayers <= 10)
                bossInflectionPointMultiplier = InflectionPointRaid10MBoss;
            else if (maxNumberOfPlayers <= 15)
                bossInflectionPointMultiplier = InflectionPointRaid15MBoss;
            else if (maxNumberOfPlayers <= 20)
                bossInflectionPointMultiplier = InflectionPointRaid20MBoss;
            else if (maxNumberOfPlayers <= 25)
                bossInflectionPointMultiplier = InflectionPointRaid25MBoss;
            else if (maxNumberOfPlayers <= 40)
                bossInflectionPointMultiplier = InflectionPointRaid40MBoss;
            else
                bossInflectionPointMultiplier = InflectionPointRaidBoss;
        }

        //
        // Per map ID overrides alter the above settings, if set
        //

        if (hasBossOverride(mapId))
        {
            AutoBalanceInflectionPointSettings* myBossOverrides = &bossOverrides[mapId];

            //
            // If set, alter the inflectionValue according to the override
            //
            if (myBossOverrides->value != -1)
                inflectionValue *= myBossOverrides->value;
            //
            // Otherwise, calculate using the value determined by instance type
            //
            else
                inflectionValue *= bossInflectionPointMultiplier;
        }
        //
        // No override, use the value determined by the instance type
        //
        else
            inflectionValue *= bossInflectionPointMultiplier;
    }

    return AutoBalanceInflectionPointSettings(inflectionValue, curveFloor, curveCeiling);
}

void getStatModifiersDebug(Map *map, Creature *creature, std::string message)
{
    // if we have a creature, include that in the output
    if (creature)
    {
        // get the creature's info
        AutoBalanceCreatureInfo *creatureABInfo=creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance::getStatModifiers: Map {} ({}{}) | Creature {} ({}{}) | {}",
                    map->GetMapName(),
                    map->GetId(),
                    map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                    creature->GetName(),
                    creatureABInfo->UnmodifiedLevel,
                    creatureABInfo->selectedLevel ? "->" + std::to_string(creatureABInfo->selectedLevel) : "",
                    message
        );
    }
    // if no creature was provided, remove that from the output
    else
    {
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance::getStatModifiers: Map {} ({}{}) | {}",
                    map->GetMapName(),
                    map->GetId(),
                    map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                    message
        );
    }
}

AutoBalanceStatModifiers getStatModifiers (Map* map, Creature* creature)
{
    //
    // get the instance's InstanceMap
    //

    InstanceMap* instanceMap  = map->ToInstanceMap();

    //
    // map variables
    //

    uint32 maxNumberOfPlayers = instanceMap->GetMaxPlayers();
    uint32 mapId              = map->GetId();

    //
    // get the creature's info if a creature was specified
    //
    AutoBalanceCreatureInfo* creatureABInfo = nullptr;

    if (creature)
        creatureABInfo = creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

    //
    // this will be the return value
    //

    AutoBalanceStatModifiers statModifiers;

    //
    // Apply the per-instance-type modifiers first
    // AutoBalance.StatModifier*(.Boss).<stat>
    //

    if (instanceMap->IsHeroic()) // heroic
    {
        if (maxNumberOfPlayers <= 5)
        {
            if (creature && isBossOrBossSummon(creature))
            {
                statModifiers.global     = StatModifierHeroic_Boss_Global;
                statModifiers.health     = StatModifierHeroic_Boss_Health;
                statModifiers.mana       = StatModifierHeroic_Boss_Mana;
                statModifiers.armor      = StatModifierHeroic_Boss_Armor;
                statModifiers.damage     = StatModifierHeroic_Boss_Damage;
                statModifiers.ccduration = StatModifierHeroic_Boss_CCDuration;

                getStatModifiersDebug(map, creature, "1 to 5 Player Heroic Boss");
            }
            else
            {
                statModifiers.global     = StatModifierHeroic_Global;
                statModifiers.health     = StatModifierHeroic_Health;
                statModifiers.mana       = StatModifierHeroic_Mana;
                statModifiers.armor      = StatModifierHeroic_Armor;
                statModifiers.damage     = StatModifierHeroic_Damage;
                statModifiers.ccduration = StatModifierHeroic_CCDuration;

                getStatModifiersDebug(map, creature, "1 to 5 Player Heroic");
            }
        }
        else if (maxNumberOfPlayers <= 10)
        {
            if (creature && isBossOrBossSummon(creature))
            {
                statModifiers.global     = StatModifierRaid10MHeroic_Boss_Global;
                statModifiers.health     = StatModifierRaid10MHeroic_Boss_Health;
                statModifiers.mana       = StatModifierRaid10MHeroic_Boss_Mana;
                statModifiers.armor      = StatModifierRaid10MHeroic_Boss_Armor;
                statModifiers.damage     = StatModifierRaid10MHeroic_Boss_Damage;
                statModifiers.ccduration = StatModifierRaid10MHeroic_Boss_CCDuration;

                getStatModifiersDebug(map, creature, "10 Player Heroic Boss");
            }
            else
            {
                statModifiers.global     = StatModifierRaid10MHeroic_Global;
                statModifiers.health     = StatModifierRaid10MHeroic_Health;
                statModifiers.mana       = StatModifierRaid10MHeroic_Mana;
                statModifiers.armor      = StatModifierRaid10MHeroic_Armor;
                statModifiers.damage     = StatModifierRaid10MHeroic_Damage;
                statModifiers.ccduration = StatModifierRaid10MHeroic_CCDuration;

                getStatModifiersDebug(map, creature, "10 Player Heroic");
            }
        }
        else if (maxNumberOfPlayers <= 25)
        {
            if (creature && isBossOrBossSummon(creature))
            {
                statModifiers.global     = StatModifierRaid25MHeroic_Boss_Global;
                statModifiers.health     = StatModifierRaid25MHeroic_Boss_Health;
                statModifiers.mana       = StatModifierRaid25MHeroic_Boss_Mana;
                statModifiers.armor      = StatModifierRaid25MHeroic_Boss_Armor;
                statModifiers.damage     = StatModifierRaid25MHeroic_Boss_Damage;
                statModifiers.ccduration = StatModifierRaid25MHeroic_Boss_CCDuration;

                getStatModifiersDebug(map, creature, "25 Player Heroic Boss");
            }
            else
            {
                statModifiers.global     = StatModifierRaid25MHeroic_Global;
                statModifiers.health     = StatModifierRaid25MHeroic_Health;
                statModifiers.mana       = StatModifierRaid25MHeroic_Mana;
                statModifiers.armor      = StatModifierRaid25MHeroic_Armor;
                statModifiers.damage     = StatModifierRaid25MHeroic_Damage;
                statModifiers.ccduration = StatModifierRaid25MHeroic_CCDuration;

                getStatModifiersDebug(map, creature, "25 Player Heroic");
            }
        }
        else
        {
            if (creature && isBossOrBossSummon(creature))
            {
                statModifiers.global     = StatModifierRaidHeroic_Boss_Global;
                statModifiers.health     = StatModifierRaidHeroic_Boss_Health;
                statModifiers.mana       = StatModifierRaidHeroic_Boss_Mana;
                statModifiers.armor      = StatModifierRaidHeroic_Boss_Armor;
                statModifiers.damage     = StatModifierRaidHeroic_Boss_Damage;
                statModifiers.ccduration = StatModifierRaidHeroic_Boss_CCDuration;

                getStatModifiersDebug(map, creature, "?? Player Heroic Boss");
            }
            else
            {
                statModifiers.global     = StatModifierRaidHeroic_Global;
                statModifiers.health     = StatModifierRaidHeroic_Health;
                statModifiers.mana       = StatModifierRaidHeroic_Mana;
                statModifiers.armor      = StatModifierRaidHeroic_Armor;
                statModifiers.damage     = StatModifierRaidHeroic_Damage;
                statModifiers.ccduration = StatModifierRaidHeroic_CCDuration;

                getStatModifiersDebug(map, creature, "?? Player Heroic");
            }
        }
    }
    else // non-heroic
    {
        if (maxNumberOfPlayers <= 5)
        {
            if (creature && isBossOrBossSummon(creature))
            {
                statModifiers.global     = StatModifier_Boss_Global;
                statModifiers.health     = StatModifier_Boss_Health;
                statModifiers.mana       = StatModifier_Boss_Mana;
                statModifiers.armor      = StatModifier_Boss_Armor;
                statModifiers.damage     = StatModifier_Boss_Damage;
                statModifiers.ccduration = StatModifier_Boss_CCDuration;

                getStatModifiersDebug(map, creature, "1 to 5 Player Normal Boss");
            }
            else
            {
                statModifiers.global     = StatModifier_Global;
                statModifiers.health     = StatModifier_Health;
                statModifiers.mana       = StatModifier_Mana;
                statModifiers.armor      = StatModifier_Armor;
                statModifiers.damage     = StatModifier_Damage;
                statModifiers.ccduration = StatModifier_CCDuration;

                getStatModifiersDebug(map, creature, "1 to 5 Player Normal");
            }
        }
        else if (maxNumberOfPlayers <= 10)
        {
            if (creature && isBossOrBossSummon(creature))
            {
                statModifiers.global     = StatModifierRaid10M_Boss_Global;
                statModifiers.health     = StatModifierRaid10M_Boss_Health;
                statModifiers.mana       = StatModifierRaid10M_Boss_Mana;
                statModifiers.armor      = StatModifierRaid10M_Boss_Armor;
                statModifiers.damage     = StatModifierRaid10M_Boss_Damage;
                statModifiers.ccduration = StatModifierRaid10M_Boss_CCDuration;

                getStatModifiersDebug(map, creature, "10 Player Normal Boss");
            }
            else
            {
                statModifiers.global     = StatModifierRaid10M_Global;
                statModifiers.health     = StatModifierRaid10M_Health;
                statModifiers.mana       = StatModifierRaid10M_Mana;
                statModifiers.armor      = StatModifierRaid10M_Armor;
                statModifiers.damage     = StatModifierRaid10M_Damage;
                statModifiers.ccduration = StatModifierRaid10M_CCDuration;

                getStatModifiersDebug(map, creature, "10 Player Normal");
            }
        }
        else if (maxNumberOfPlayers <= 15)
        {
            if (creature && isBossOrBossSummon(creature))
            {
                statModifiers.global     = StatModifierRaid15M_Boss_Global;
                statModifiers.health     = StatModifierRaid15M_Boss_Health;
                statModifiers.mana       = StatModifierRaid15M_Boss_Mana;
                statModifiers.armor      = StatModifierRaid15M_Boss_Armor;
                statModifiers.damage     = StatModifierRaid15M_Boss_Damage;
                statModifiers.ccduration = StatModifierRaid15M_Boss_CCDuration;

                getStatModifiersDebug(map, creature, "15 Player Normal Boss");
            }
            else
            {
                statModifiers.global     = StatModifierRaid15M_Global;
                statModifiers.health     = StatModifierRaid15M_Health;
                statModifiers.mana       = StatModifierRaid15M_Mana;
                statModifiers.armor      = StatModifierRaid15M_Armor;
                statModifiers.damage     = StatModifierRaid15M_Damage;
                statModifiers.ccduration = StatModifierRaid15M_CCDuration;

                getStatModifiersDebug(map, creature, "15 Player Normal");
            }
        }
        else if (maxNumberOfPlayers <= 20)
        {
            if (creature && isBossOrBossSummon(creature))
            {
                statModifiers.global     = StatModifierRaid20M_Boss_Global;
                statModifiers.health     = StatModifierRaid20M_Boss_Health;
                statModifiers.mana       = StatModifierRaid20M_Boss_Mana;
                statModifiers.armor      = StatModifierRaid20M_Boss_Armor;
                statModifiers.damage     = StatModifierRaid20M_Boss_Damage;
                statModifiers.ccduration = StatModifierRaid20M_Boss_CCDuration;

                getStatModifiersDebug(map, creature, "20 Player Normal Boss");
            }
            else
            {
                statModifiers.global     = StatModifierRaid20M_Global;
                statModifiers.health     = StatModifierRaid20M_Health;
                statModifiers.mana       = StatModifierRaid20M_Mana;
                statModifiers.armor      = StatModifierRaid20M_Armor;
                statModifiers.damage     = StatModifierRaid20M_Damage;
                statModifiers.ccduration = StatModifierRaid20M_CCDuration;

                getStatModifiersDebug(map, creature, "20 Player Normal");
            }
        }
        else if (maxNumberOfPlayers <= 25)
        {
            if (creature && isBossOrBossSummon(creature))
            {
                statModifiers.global     = StatModifierRaid25M_Boss_Global;
                statModifiers.health     = StatModifierRaid25M_Boss_Health;
                statModifiers.mana       = StatModifierRaid25M_Boss_Mana;
                statModifiers.armor      = StatModifierRaid25M_Boss_Armor;
                statModifiers.damage     = StatModifierRaid25M_Boss_Damage;
                statModifiers.ccduration = StatModifierRaid25M_Boss_CCDuration;

                getStatModifiersDebug(map, creature, "25 Player Normal Boss");
            }
            else
            {
                statModifiers.global     = StatModifierRaid25M_Global;
                statModifiers.health     = StatModifierRaid25M_Health;
                statModifiers.mana       = StatModifierRaid25M_Mana;
                statModifiers.armor      = StatModifierRaid25M_Armor;
                statModifiers.damage     = StatModifierRaid25M_Damage;
                statModifiers.ccduration = StatModifierRaid25M_CCDuration;

                getStatModifiersDebug(map, creature, "25 Player Normal");
            }
        }
        else if (maxNumberOfPlayers <= 40)
        {
            if (creature && isBossOrBossSummon(creature))
            {
                statModifiers.global     = StatModifierRaid40M_Boss_Global;
                statModifiers.health     = StatModifierRaid40M_Boss_Health;
                statModifiers.mana       = StatModifierRaid40M_Boss_Mana;
                statModifiers.armor      = StatModifierRaid40M_Boss_Armor;
                statModifiers.damage     = StatModifierRaid40M_Boss_Damage;
                statModifiers.ccduration = StatModifierRaid40M_Boss_CCDuration;

                getStatModifiersDebug(map, creature, "40 Player Normal Boss");
            }
            else
            {
                statModifiers.global     = StatModifierRaid40M_Global;
                statModifiers.health     = StatModifierRaid40M_Health;
                statModifiers.mana       = StatModifierRaid40M_Mana;
                statModifiers.armor      = StatModifierRaid40M_Armor;
                statModifiers.damage     = StatModifierRaid40M_Damage;
                statModifiers.ccduration = StatModifierRaid40M_CCDuration;

                getStatModifiersDebug(map, creature, "40 Player Normal");
            }
        }
        else
        {
            if (creature && isBossOrBossSummon(creature))
            {
                statModifiers.global     = StatModifierRaid_Boss_Global;
                statModifiers.health     = StatModifierRaid_Boss_Health;
                statModifiers.mana       = StatModifierRaid_Boss_Mana;
                statModifiers.armor      = StatModifierRaid_Boss_Armor;
                statModifiers.damage     = StatModifierRaid_Boss_Damage;
                statModifiers.ccduration = StatModifierRaid_Boss_CCDuration;

                getStatModifiersDebug(map, creature, "?? Player Normal Boss");
            }
            else
            {
                statModifiers.global     = StatModifierRaid_Global;
                statModifiers.health     = StatModifierRaid_Health;
                statModifiers.mana       = StatModifierRaid_Mana;
                statModifiers.armor      = StatModifierRaid_Armor;
                statModifiers.damage     = StatModifierRaid_Damage;
                statModifiers.ccduration = StatModifierRaid_CCDuration;

                getStatModifiersDebug(map, creature, "?? Player Normal");
            }
        }
    }

    //
    // Per-Map Overrides
    // AutoBalance.StatModifier.Boss.PerInstance
    //

    if (creature && isBossOrBossSummon(creature) && hasStatModifierBossOverride(mapId))
    {
        AutoBalanceStatModifiers* myStatModifierBossOverrides = &statModifierBossOverrides[mapId];

        if (myStatModifierBossOverrides->global != -1)
            statModifiers.global = myStatModifierBossOverrides->global;

        if (myStatModifierBossOverrides->health != -1)
            statModifiers.health = myStatModifierBossOverrides->health;

        if (myStatModifierBossOverrides->mana != -1)
            statModifiers.mana = myStatModifierBossOverrides->mana;

        if (myStatModifierBossOverrides->armor != -1)
            statModifiers.armor = myStatModifierBossOverrides->armor;

        if (myStatModifierBossOverrides->damage != -1)
            statModifiers.damage = myStatModifierBossOverrides->damage;

        if (myStatModifierBossOverrides->ccduration != -1)
            statModifiers.ccduration = myStatModifierBossOverrides->ccduration;

        getStatModifiersDebug(map, creature, "Boss Per-Instance Override");
    }
    //
    // AutoBalance.StatModifier.PerInstance
    //
    else if (hasStatModifierOverride(mapId))
    {
        AutoBalanceStatModifiers* myStatModifierOverrides = &statModifierOverrides[mapId];

        if (myStatModifierOverrides->global != -1)
            statModifiers.global = myStatModifierOverrides->global;

        if (myStatModifierOverrides->health != -1)
            statModifiers.health = myStatModifierOverrides->health;

        if (myStatModifierOverrides->mana != -1)
            statModifiers.mana = myStatModifierOverrides->mana;

        if (myStatModifierOverrides->armor != -1)
            statModifiers.armor = myStatModifierOverrides->armor;

        if (myStatModifierOverrides->damage != -1)
            statModifiers.damage = myStatModifierOverrides->damage;

        if (myStatModifierOverrides->ccduration != -1)
            statModifiers.ccduration = myStatModifierOverrides->ccduration;

        getStatModifiersDebug(map, creature, "Per-Instance Override");
    }

    //
    // Per-creature modifiers applied last
    // AutoBalance.StatModifier.PerCreature
    //
    if (creature && hasStatModifierCreatureOverride(creature->GetEntry()))
    {
        AutoBalanceStatModifiers* myCreatureOverrides = &statModifierCreatureOverrides[creature->GetEntry()];

        if (myCreatureOverrides->global != -1)
            statModifiers.global = myCreatureOverrides->global;

        if (myCreatureOverrides->health != -1)
            statModifiers.health = myCreatureOverrides->health;

        if (myCreatureOverrides->mana != -1)
            statModifiers.mana = myCreatureOverrides->mana;

        if (myCreatureOverrides->armor != -1)
            statModifiers.armor = myCreatureOverrides->armor;

        if (myCreatureOverrides->damage != -1)
            statModifiers.damage = myCreatureOverrides->damage;

        if (myCreatureOverrides->ccduration != -1)
            statModifiers.ccduration = myCreatureOverrides->ccduration;

        getStatModifiersDebug(map, creature, "Per-Creature Override");
    }

    if (creature)
    {
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance::getStatModifiers: Map {} ({}{}) | Creature {} ({}{}) | Stat Modifiers = global: {} | health: {} | mana: {} | armor: {} | damage: {} | ccduration: {}",
                    map->GetMapName(),
                    map->GetId(),
                    map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                    creature->GetName(),
                    creatureABInfo->UnmodifiedLevel,
                    creatureABInfo->selectedLevel ? "->" + std::to_string(creatureABInfo->selectedLevel) : "",
                    statModifiers.global,
                    statModifiers.health,
                    statModifiers.mana,
                    statModifiers.armor,
                    statModifiers.damage,
                    statModifiers.ccduration == -1 ? 1.0f : statModifiers.ccduration
        );
    }
    else
    {
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance::getStatModifiers: Map {} ({}{}) | Stat Modifiers = global: {} | health: {} | mana: {} | armor: {} | damage: {} | ccduration: {}",
                    map->GetMapName(),
                    map->GetId(),
                    map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                    statModifiers.global,
                    statModifiers.health,
                    statModifiers.mana,
                    statModifiers.armor,
                    statModifiers.damage,
                    statModifiers.ccduration == -1 ? 1.0f : statModifiers.ccduration
        );
    }

    return statModifiers;
}

bool hasBossOverride(uint32 dungeonId)
{
    return (bossOverrides.find(dungeonId) != bossOverrides.end());
}

bool hasDungeonOverride(uint32 dungeonId)
{
    return (dungeonOverrides.find(dungeonId) != dungeonOverrides.end());
}

bool hasDynamicLevelOverride(uint32 dungeonId)
{
    return (levelScalingDynamicLevelOverrides.find(dungeonId) != levelScalingDynamicLevelOverrides.end());
}

bool hasLevelScalingDistanceCheckOverride(uint32 dungeonId)
{
    return (levelScalingDistanceCheckOverrides.find(dungeonId) != levelScalingDistanceCheckOverrides.end());
}

bool hasStatModifierBossOverride(uint32 dungeonId)
{
    return (statModifierBossOverrides.find(dungeonId) != statModifierBossOverrides.end());
}

bool hasStatModifierCreatureOverride(uint32 creatureId)
{
    return (statModifierCreatureOverrides.find(creatureId) != statModifierCreatureOverrides.end());
}

bool hasStatModifierOverride(uint32 dungeonId)
{
    return (statModifierOverrides.find(dungeonId) != statModifierOverrides.end());
}

bool isDungeonInDisabledDungeonIds(uint32 dungeonId)
{
    return (std::find(disabledDungeonIds.begin(), disabledDungeonIds.end(), dungeonId) != disabledDungeonIds.end());
}

bool isBossOrBossSummon(Creature* creature, bool log)
{
    // no creature? not a boss
    if (!creature)
    {
        LOG_INFO("module.AutoBalance", "AutoBalance::isBossOrBossSummon: Creature is null.");
        return false;
    }

    // if this creature is a boss, return true
    if (creature->IsDungeonBoss() || creature->isWorldBoss())
    {
        if (log)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::isBossOrBossSummon: {} ({}{}) is a boss.",
                        creature->GetName(),
                        creature->GetEntry(),
                        creature->GetInstanceId() ? "-" + std::to_string(creature->GetInstanceId()) : ""
            );
        }

        return true;
    }


    // if this creature is a summon of a boss, return true
    if (
        creature->IsSummon() &&
        creature->ToTempSummon() &&
        creature->ToTempSummon()->GetSummoner() &&
        creature->ToTempSummon()->GetSummoner()->ToCreature()
        )
    {
        Creature* summoner = creature->ToTempSummon()->GetSummoner()->ToCreature();

        if (summoner)
        {
            if (summoner->IsDungeonBoss() || summoner->isWorldBoss())
            {
                if (log)
                {
                    LOG_DEBUG("module.AutoBalance", "AutoBalance::isBossOrBossSummon: {} ({}) is a summon of boss {}({}).",
                                creature->GetName(),
                                creature->GetEntry(),
                                summoner->GetName(),
                                summoner->GetEntry()
                    );
                }

                return true;
            }
            else
            {
                if (log)
                {
                    LOG_DEBUG("module.AutoBalance", "AutoBalance::isBossOrBossSummon: {} ({}) is a summon of {}({}).",
                                creature->GetName(),
                                creature->GetEntry(),
                                summoner->GetName(),
                                summoner->GetEntry()
                    );
                }
                return false;
            }
        }
    }

    // not a boss
    if (log)
    {
        // LOG_DEBUG("module.AutoBalance", "AutoBalance::isBossOrBossSummon: {} ({}) is NOT a boss.",
        //             creature->GetName(),
        //             creature->GetEntry()
        // );
    }

    return false;
}

bool isCreatureRelevant(Creature* creature)
{
    // if the creature is gone, return false
    if (!creature)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::isCreatureRelevant: Creature is null.");
        return false;
    }

    // if this creature isn't assigned to a map, make no changes
    if (!creature->GetMap() || !creature->GetMap()->IsDungeon())
    {
        // executed every Creature update for every world creature, enable carefully
        // LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::isCreatureRelevant: Creature {} ({}) isn't in a dungeon.",
        //             creature->GetName(),
        //             creature->GetLevel()
        // );
        return false;
    }

    // get the creature's info
    AutoBalanceCreatureInfo *creatureABInfo=creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

    // if this creature has been already been evaluated, just return the previous evaluation
    if (creatureABInfo->relevance == AUTOBALANCE_RELEVANCE_FALSE)
        return false;
    else if (creatureABInfo->relevance == AUTOBALANCE_RELEVANCE_TRUE)
        return true;
    // otherwise the value is AUTOBALANCE_RELEVANCE_UNCHECKED, so it needs checking

    LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::isCreatureRelevant: Creature {} ({}) | Needs to be evaluated.",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel
    );

    // get the creature's map's info
    Map*               creatureMap = creature->GetMap();
    AutoBalanceMapInfo *mapABInfo  = GetMapInfo(creatureMap);
    InstanceMap*       instanceMap = creatureMap->ToInstanceMap();

    // if this creature is in the dungeon's base map, make no changes
    if (!(instanceMap))
    {
        creatureABInfo->relevance = AUTOBALANCE_RELEVANCE_FALSE;
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::isCreatureRelevant: Creature {} ({}) | is in the base map, no changes. Marked for skip.",
                    creature->GetName(),
                    creatureABInfo->UnmodifiedLevel
        );
        return false;
    }

    // if this is a pet or summon controlled by the player, make no changes
    if ((creature->IsHunterPet() || creature->IsPet() || creature->IsSummon()) && creature->IsControlledByPlayer())
    {
        creatureABInfo->relevance = AUTOBALANCE_RELEVANCE_FALSE;
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::isCreatureRelevant: Creature {} ({}) | is a pet or summon controlled by the player, no changes. Marked for skip.",
                    creature->GetName(),
                    creatureABInfo->UnmodifiedLevel
        );

        return false;
    }

    // if this is a player temporary summon (that isn't actively trying to kill the players), make no changes
    if (
        creature->ToTempSummon() &&
        creature->ToTempSummon()->GetSummoner() &&
        creature->ToTempSummon()->GetSummoner()->ToPlayer()
    )
    {
        // if this creature is hostile to any non-charmed player, it should be scaled
        bool isHostileToAnyValidPlayer = false;
        TempSummon* creatureTempSummon = creature->ToTempSummon();
        Player* summonerPlayer = creatureTempSummon->GetSummoner()->ToPlayer();

        for (std::vector<Player*>::const_iterator playerIterator = mapABInfo->allMapPlayers.begin(); playerIterator != mapABInfo->allMapPlayers.end(); ++playerIterator)
        {
            Player* thisPlayer = *playerIterator;

            // is this a valid player?
            if (!thisPlayer->IsGameMaster() &&
                !thisPlayer->IsCharmed() &&
                !thisPlayer->IsHostileToPlayers() &&
                !thisPlayer->IsHostileTo(summonerPlayer) &&
                thisPlayer->IsAlive()
            )
            {
                // if this is a guardian and the owner is not hostile to this player, skip
                if
                (
                    creatureTempSummon->IsGuardian() &&
                    !thisPlayer->IsHostileTo(summonerPlayer)
                )
                {
                    LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::isCreatureRelevant: Creature {} ({}) | is a guardian of player {}, who is not hostile to valid player {}.",
                                creature->GetName(),
                                creatureABInfo->UnmodifiedLevel,
                                summonerPlayer->GetName(),
                                thisPlayer->GetName()
                    );

                    continue;
                }
                // special case for totems?
                else if
                (
                    creature->IsTotem() &&
                    !thisPlayer->IsHostileTo(summonerPlayer)
                )
                {
                    LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::isCreatureRelevant: Creature {} ({}) | is a totem of player {}, who is not hostile to valid player {}.",
                                creature->GetName(),
                                creatureABInfo->UnmodifiedLevel,
                                summonerPlayer->GetName(),
                                thisPlayer->GetName()
                    );

                    continue;
                }

                // if the creature is hostile to this valid player,
                // unfortunately, `creature->IsHostileTo(thisPlayer)` returns true for cases when it is not actually hostile
                else if (
                    thisPlayer->isTargetableForAttack(true, creature)
                )
                {
                    LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::isCreatureRelevant: Creature {} ({}) | is a player temporary summon hostile to valid player {}.",
                                creature->GetName(),
                                creatureABInfo->UnmodifiedLevel,
                                thisPlayer->GetName()
                    );

                    isHostileToAnyValidPlayer = true;
                    break;
                }
            }
        }

        if (!isHostileToAnyValidPlayer)
        {
            // since no players are hostile to this creature, it should not be scaled
            creatureABInfo->relevance = AUTOBALANCE_RELEVANCE_FALSE;
            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::isCreatureRelevant: Creature {} ({}) | is player-summoned and non-hostile, no changes. Marked for skip.",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel
            );

            return false;
        }

    }

    // if this is a flavor critter
    // level and health checks for some nasty level 1 critters in some encounters
    if ((creature->IsCritter() && creatureABInfo->UnmodifiedLevel <= 5 && creature->GetMaxHealth() < 100))
    {
        creatureABInfo->relevance = AUTOBALANCE_RELEVANCE_FALSE;
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::isCreatureRelevant: Creature {} ({}) | is a non-relevant critter, no changes. Marked for skip.",
                    creature->GetName(),
                    creatureABInfo->UnmodifiedLevel
        );

        return false;
    }

    // survived to here, creature is relevant
    LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::isCreatureRelevant: Creature {} ({}) | is relevant. Marked for processing.",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel
    );
    creatureABInfo->relevance = AUTOBALANCE_RELEVANCE_TRUE;
    return true;

}

bool isDungeonInMinPlayerMap(uint32 dungeonId, bool isHeroic)
{
    if (isHeroic)
        return (minPlayersPerHeroicDungeonIdMap.find(dungeonId) != minPlayersPerHeroicDungeonIdMap.end());
    else
        return (minPlayersPerDungeonIdMap.find(dungeonId) != minPlayersPerDungeonIdMap.end());
}

// Used for reading the string from the configuration file to for those creatures who need to be scaled for XX number of players.
//
void LoadForcedCreatureIdsFromString(std::string creatureIds, int forcedPlayerCount)
{
    std::string       delimitedValue;
    std::stringstream creatureIdsStream;

    creatureIdsStream.str(creatureIds);

    while (std::getline(creatureIdsStream, delimitedValue, ',')) // Process each Creature ID in the string, delimited by the comma - ","
    {
        int creatureId = atoi(delimitedValue.c_str());

        if (creatureId >= 0)
            forcedCreatureIds[creatureId] = forcedPlayerCount;
    }
}

// Used for reading the string from the configuration file for selectively disabling dungeons
//
std::list<uint32> LoadDisabledDungeons(std::string dungeonIdString)
{
    std::string       delimitedValue;
    std::stringstream dungeonIdStream;
    std::list<uint32> dungeonIdList;

    dungeonIdStream.str(dungeonIdString);

    // Process each dungeon ID in the string, delimited by the comma - ","
    //
    while (std::getline(dungeonIdStream, delimitedValue, ',')) 
    {
        std::string       valueOne;
        std::stringstream dungeonPairStream(delimitedValue);

        dungeonPairStream >> valueOne;
        auto dungeonMapId = atoi(valueOne.c_str());

        dungeonIdList.push_back(dungeonMapId);
    }

    return dungeonIdList;
}

std::map<uint32, uint32> LoadDistanceCheckOverrides(std::string dungeonIdString)
{
    std::string       delimitedValue;
    std::stringstream dungeonIdStream;

    std::map<uint32, uint32> overrideMap;

    dungeonIdStream.str(dungeonIdString);

    // Process each dungeon ID in the string, delimited by the comma - "," and then space " "
    //
    while (std::getline(dungeonIdStream, delimitedValue, ',')) 
    {
        std::string       val1;
        std::string       val2;
        std::stringstream dungeonStream(delimitedValue);

        dungeonStream >> val1 >> val2;

        auto dungeonMapId         = atoi(val1.c_str());
        overrideMap[dungeonMapId] = atoi(val2.c_str());
    }

    return overrideMap;
}


// Used for reading the string from the configuration file for per-dungeon dynamic level overrides
//
std::map<uint8, AutoBalanceLevelScalingDynamicLevelSettings> LoadDynamicLevelOverrides(std::string dungeonIdString)
{
    std::string       delimitedValue;
    std::stringstream dungeonIdStream;

    std::map<uint8, AutoBalanceLevelScalingDynamicLevelSettings> overrideMap;

    dungeonIdStream.str(dungeonIdString);

    // Process each dungeon ID in the string, delimited by the comma - "," and then space " "
    //
    while (std::getline(dungeonIdStream, delimitedValue, ','))
    {
        std::string       val1;
        std::string       val2;
        std::string       val3;
        std::string       val4;
        std::string       val5;
        std::stringstream dungeonStream(delimitedValue);

        dungeonStream >> val1 >> val2 >> val3 >> val4 >> val5;
        auto dungeonMapId = atoi(val1.c_str());

        // Replace any missing values with -1
        if (val2.empty())
            val2 = "-1";
        if (val3.empty())
            val3 = "-1";
        if (val4.empty())
            val4 = "-1";
        if (val5.empty())
            val5 = "-1";

        AutoBalanceLevelScalingDynamicLevelSettings dynamicLevelSettings = AutoBalanceLevelScalingDynamicLevelSettings(
            atoi(val2.c_str()),
            atoi(val3.c_str()),
            atoi(val4.c_str()),
            atoi(val5.c_str())
        );

        overrideMap[dungeonMapId] = dynamicLevelSettings;
    }

    return overrideMap;
}


// Used for reading the string from the configuration file for selecting dungeons to override
//
std::map<uint32, AutoBalanceInflectionPointSettings> LoadInflectionPointOverrides(std::string dungeonIdString)
{
    std::string       delimitedValue;
    std::stringstream dungeonIdStream;

    std::map<uint32, AutoBalanceInflectionPointSettings> overrideMap;

    dungeonIdStream.str(dungeonIdString);

    while (std::getline(dungeonIdStream, delimitedValue, ',')) // Process each dungeon ID in the string, delimited by the comma - "," and then space " "
    {
        std::string       val1;
        std::string       val2;
        std::string       val3;
        std::string       val4;
        std::stringstream dungeonPairStream(delimitedValue);

        dungeonPairStream >> val1 >> val2 >> val3 >> val4;
        auto dungeonMapId = atoi(val1.c_str());

        // Replace any missing values with -1
        if (val2.empty())
            val2 = "-1";
        if (val3.empty())
            val3 = "-1";
        if (val4.empty())
            val4 = "-1";

        AutoBalanceInflectionPointSettings ipSettings = AutoBalanceInflectionPointSettings(
            atof(val2.c_str()),
            atof(val3.c_str()),
            atof(val4.c_str())
        );

        overrideMap[dungeonMapId] = ipSettings;
    }

    return overrideMap;
}

void LoadMapSettings(Map* map)
{
    //
    // Load (or create) the map's info
    //

    AutoBalanceMapInfo* mapABInfo = GetMapInfo(map);

    //
    // Create an InstanceMap object
    //

    InstanceMap* instanceMap = map->ToInstanceMap();

    LOG_DEBUG("module.AutoBalance", "AutoBalance::LoadMapSettings: Map {} ({}{}, {}-player {}) | Loading settings.",
        map->GetMapName(),
        map->GetId(),
        map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
        instanceMap->GetMaxPlayers(),
        instanceMap->IsHeroic() ? "Heroic" : "Normal"
    );

    //
    // Determine the minumum player count
    //

    if (isDungeonInMinPlayerMap(map->GetId(), instanceMap->IsHeroic()))
        mapABInfo->minPlayers = instanceMap->IsHeroic() ? minPlayersPerHeroicDungeonIdMap[map->GetId()] : minPlayersPerDungeonIdMap[map->GetId()];
    else if (instanceMap->GetMaxPlayers() <= 5 && !instanceMap->IsHeroic())
        mapABInfo->minPlayers = minPlayersNormal;
    else if (instanceMap->GetMaxPlayers() <= 5 && instanceMap->IsHeroic())
        mapABInfo->minPlayers = minPlayersHeroic;
    else if (instanceMap->GetMaxPlayers() > 5 && !instanceMap->IsHeroic())
        mapABInfo->minPlayers = minPlayersRaid;
    else
        mapABInfo->minPlayers = minPlayersRaidHeroic;

    //
    // If the minPlayers value we determined is less than the max number of players in this map, adjust down
    //
    if (mapABInfo->minPlayers > instanceMap->GetMaxPlayers())
    {
        LOG_WARN("module.AutoBalance", "AutoBalance::LoadMapSettings: Your settings tried to set a minimum player count of {} which is greater than {}'s max player count of {}. Adjusting down.",
            mapABInfo->minPlayers,
            map->GetMapName(),
            instanceMap->GetMaxPlayers()
        );

        mapABInfo->minPlayers = instanceMap->GetMaxPlayers();
    }

    LOG_DEBUG("module.AutoBalance", "AutoBalance::LoadMapSettings: Map {} ({}{}, {}-player {}) | has a minimum player count of {}.",
        map->GetMapName(),
        map->GetId(),
        map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
        instanceMap->GetMaxPlayers(),
        instanceMap->IsHeroic() ? "Heroic" : "Normal",
        mapABInfo->minPlayers
    );

    //
    // Dynamic Level Scaling Floor and Ceiling
    //

    // 5-player normal dungeons
    if (instanceMap->GetMaxPlayers() <= 5 && !instanceMap->IsHeroic())
    {
        mapABInfo->levelScalingDynamicCeiling = LevelScalingDynamicLevelCeilingDungeons;
        mapABInfo->levelScalingDynamicFloor   = LevelScalingDynamicLevelFloorDungeons;

    }
    // 5-player heroic dungeons
    else if (instanceMap->GetMaxPlayers() <= 5 && instanceMap->IsHeroic())
    {
        mapABInfo->levelScalingDynamicCeiling = LevelScalingDynamicLevelCeilingHeroicDungeons;
        mapABInfo->levelScalingDynamicFloor   = LevelScalingDynamicLevelFloorHeroicDungeons;
    }
    // Normal raids
    else if (instanceMap->GetMaxPlayers() > 5 && !instanceMap->IsHeroic())
    {
        mapABInfo->levelScalingDynamicCeiling = LevelScalingDynamicLevelCeilingRaids;
        mapABInfo->levelScalingDynamicFloor   = LevelScalingDynamicLevelFloorRaids;
    }
    // Heroic raids
    else if (instanceMap->GetMaxPlayers() > 5 && instanceMap->IsHeroic())
    {
        mapABInfo->levelScalingDynamicCeiling = LevelScalingDynamicLevelCeilingHeroicRaids;
        mapABInfo->levelScalingDynamicFloor   = LevelScalingDynamicLevelFloorHeroicRaids;
    }
    // something went wrong
    else
    {
        LOG_ERROR("module.AutoBalance", "AutoBalance::LoadMapSettings: Map {} ({}{}, {}-player {}) | Unable to determine dynamic scaling floor and ceiling for instance.",
            map->GetMapName(),
            map->GetId(),
            map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
            instanceMap->GetMaxPlayers(),
            instanceMap->IsHeroic() ? "Heroic" : "Normal"
        );

        mapABInfo->levelScalingDynamicCeiling = 3;
        mapABInfo->levelScalingDynamicFloor   = 5;

    }

    //
    // Level Scaling Skip Levels
    //

    // Load the global settings into the map
    mapABInfo->levelScalingSkipHigherLevels = LevelScalingSkipHigherLevels;
    mapABInfo->levelScalingSkipLowerLevels  = LevelScalingSkipLowerLevels;

    //
    // Per-instance overrides, if applicable
    //

    if (hasDynamicLevelOverride(map->GetId()))
    {
        AutoBalanceLevelScalingDynamicLevelSettings* myDynamicLevelSettings = &levelScalingDynamicLevelOverrides[map->GetId()];

        // LevelScaling.SkipHigherLevels
        if (myDynamicLevelSettings->skipHigher != -1)
            mapABInfo->levelScalingSkipHigherLevels = myDynamicLevelSettings->skipHigher;

        // LevelScaling.SkipLowerLevels
        if (myDynamicLevelSettings->skipLower != -1)
            mapABInfo->levelScalingSkipLowerLevels = myDynamicLevelSettings->skipLower;

        // LevelScaling.DynamicLevelCeiling
        if (myDynamicLevelSettings->ceiling != -1)
            mapABInfo->levelScalingDynamicCeiling = myDynamicLevelSettings->ceiling;

        // LevelScaling.DynamicLevelFloor
        if (myDynamicLevelSettings->floor != -1)
            mapABInfo->levelScalingDynamicFloor = myDynamicLevelSettings->floor;
    }
}

// Used for reading the string from the configuration file for per-dungeon minimum player count overrides
//
std::map<uint32, uint8> LoadMinPlayersPerDungeonId(std::string minPlayersString) 
{
    std::string             delimitedValue;
    std::stringstream       dungeonIdStream;
    std::map<uint32, uint8> dungeonIdMap;

    dungeonIdStream.str(minPlayersString);

    // Process each dungeon ID in the string, delimited by the comma - "," and then space " "
    //
    while (std::getline(dungeonIdStream, delimitedValue, ',')) 
    {
        std::string       val1;
        std::string       val2;
        std::stringstream dungeonPairStream(delimitedValue);

        dungeonPairStream >> val1 >> val2;
        auto dungeonMapId = atoi(val1.c_str());
        auto minPlayers   = atoi(val2.c_str());

        dungeonIdMap[dungeonMapId] = minPlayers;
    }

    return dungeonIdMap;
}

// Used for reading the string from the configuration file for per-dungeon stat modifiers
//
std::map<uint32, AutoBalanceStatModifiers> LoadStatModifierOverrides(std::string dungeonIdString)
{
    std::string       delimitedValue;
    std::stringstream dungeonIdStream;

    std::map<uint32, AutoBalanceStatModifiers> overrideMap;

    dungeonIdStream.str(dungeonIdString);

    // Process each dungeon ID in the string, delimited by the comma - "," and then space " "
    //
    while (std::getline(dungeonIdStream, delimitedValue, ',')) 
    {
        std::string       val1;
        std::string       val2;
        std::string       val3;
        std::string       val4;
        std::string       val5;
        std::string       val6;
        std::string       val7;
        std::stringstream dungeonStream(delimitedValue);

        dungeonStream >> val1 >> val2 >> val3 >> val4 >> val5 >> val6 >> val7;
        auto dungeonMapId = atoi(val1.c_str());

        // Replace any missing values with -1
        if (val2.empty())
            val2 = "-1";
        if (val3.empty())
            val3 = "-1";
        if (val4.empty())
            val4 = "-1";
        if (val5.empty())
            val5 = "-1";
        if (val6.empty())
            val6 = "-1";
        if (val7.empty())
            val7 = "-1";

        AutoBalanceStatModifiers statSettings = AutoBalanceStatModifiers(
            atof(val2.c_str()),
            atof(val3.c_str()),
            atof(val4.c_str()),
            atof(val5.c_str()),
            atof(val6.c_str()),
            atof(val7.c_str())
        );

        overrideMap[dungeonMapId] = statSettings;
    }

    return overrideMap;
}

bool ShouldMapBeEnabled(Map* map)
{
    if (map->IsDungeon())
    {
        // if globally disabled, return false
        if (!EnableGlobal)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::ShouldMapBeEnabled: {} ({}{}) - Not enabled because EnableGlobal is false",
                        map->GetMapName(),
                        map->GetId(),
                        map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : ""
            );
            return false;
        }

        InstanceMap* instanceMap = map->ToInstanceMap();

        // if there wasn't one, then we're not in an instance
        if (!instanceMap)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::ShouldMapBeEnabled: {} ({}{}) - Not enabled for the base map without an Instance ID.",
                      map->GetMapName(),
                      map->GetId(),
                      map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : ""
            );
            return false;
        }

        // if the player count is less than 1, then we're not in an instance
        if (instanceMap->GetMaxPlayers() < 1)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::ShouldMapBeEnabled: {} ({}{}, {}-player {}) - Not enabled because GetMaxPlayers < 1",
                      map->GetMapName(),
                      map->GetId(),
                      map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                      instanceMap->GetMaxPlayers(),
                      instanceMap->IsHeroic() ? "Heroic" : "Normal"
            );
            return false;
        }

        // if the Dungeon is disabled via configuration, do not enable it
        if (isDungeonInDisabledDungeonIds(map->GetId()))
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::ShouldMapBeEnabled: {} ({}{}, {}-player {}) - Not enabled because the map ID is disabled via configuration.",
                      map->GetMapName(),
                      map->GetId(),
                      map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                      instanceMap->GetMaxPlayers(),
                      instanceMap->IsHeroic() ? "Heroic" : "Normal"
            );

            return false;
        }

        // use the configuration variables to determine if this instance type/size should have scaling enabled
        bool sizeDifficultyEnabled;
        if (instanceMap->IsHeroic())
        {
            //LOG_DEBUG("module.AutoBalance", "AutoBalance::ShouldMapBeEnabled: Heroic Enables - 5:{} 10:{} 25:{} Other:{}",
            //            Enable5MHeroic, Enable10MHeroic, Enable25MHeroic, EnableOtherHeroic);

            if (instanceMap->GetMaxPlayers() <= 5)
                sizeDifficultyEnabled = Enable5MHeroic;
            else if (instanceMap->GetMaxPlayers() <= 10)
                sizeDifficultyEnabled = Enable10MHeroic;
            else if (instanceMap->GetMaxPlayers() <= 25)
                sizeDifficultyEnabled = Enable25MHeroic;
            else
                sizeDifficultyEnabled = EnableOtherHeroic;
        }
        else
        {
            //LOG_DEBUG("module.AutoBalance", "AutoBalance::ShouldMapBeEnabled: Normal Enables - 5:{} 10:{} 15:{} 20:{} 25:{} 40:{} Other:{}",
            //            Enable5M, Enable10M, Enable15M, Enable20M, Enable25M, Enable40M, EnableOtherNormal);
            if (instanceMap->GetMaxPlayers() <= 5)
                sizeDifficultyEnabled = Enable5M;
            else if (instanceMap->GetMaxPlayers() <= 10)
                sizeDifficultyEnabled = Enable10M;
            else if (instanceMap->GetMaxPlayers() <= 15)
                sizeDifficultyEnabled = Enable15M;
            else if (instanceMap->GetMaxPlayers() <= 20)
                sizeDifficultyEnabled = Enable20M;
            else if (instanceMap->GetMaxPlayers() <= 25)
                sizeDifficultyEnabled = Enable25M;
            else if (instanceMap->GetMaxPlayers() <= 40)
                sizeDifficultyEnabled = Enable40M;
            else
                sizeDifficultyEnabled = EnableOtherNormal;
        }

        if (sizeDifficultyEnabled)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::ShouldMapBeEnabled: Map {} ({}{}, {}-player {}) | Enabled for AutoBalancing.",
                      map->GetMapName(),
                      map->GetId(),
                      map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                      instanceMap->GetMaxPlayers(),
                      instanceMap->IsHeroic() ? "Heroic" : "Normal"
            );
        }
        else
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::ShouldMapBeEnabled: Map {} ({}{}, {}-player {}) | Not enabled because its size and difficulty are disabled via configuration.",
                      map->GetMapName(),
                      map->GetId(),
                      map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                      instanceMap->GetMaxPlayers(),
                      instanceMap->IsHeroic() ? "Heroic" : "Normal"
            );
        }

        return sizeDifficultyEnabled;
    }
    else
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::ShouldMapBeEnabled: Map {} ({}{}) | Not enabled because the map is not an instance.",
                    map->GetMapName(),
                    map->GetId(),
                    map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : ""
        );
        return false;

        // we're not in a dungeon or a raid, we never scale
        return false;
    }
}

void UpdateMapPlayerStats(Map* map)
{
    //
    // If this isn't a dungeon instance, just bail out immediately
    //

    if (!map->IsDungeon() || !map->GetInstanceId())
        return;

    //
    // Get the map's info
    //

    AutoBalanceMapInfo* mapABInfo   = GetMapInfo(map);
    InstanceMap*        instanceMap = map->ToInstanceMap();

    //
    // Remember some values
    //

    uint8 oldPlayerCount         = mapABInfo->playerCount;
    uint8 oldAdjustedPlayerCount = mapABInfo->adjustedPlayerCount;

    LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapPlayerStats: Map {} ({}{}) | oldPlayerCount = ({}), oldAdjustedPlayerCount = ({}).",
        instanceMap->GetMapName(),
        instanceMap->GetId(),
        instanceMap->GetInstanceId() ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
        oldPlayerCount,
        oldAdjustedPlayerCount);

    //
    // Update the player count
    // Minimum of 1 to prevent scaling weirdness when only GMs are in the instnace
    //

    mapABInfo->playerCount = mapABInfo->allMapPlayers.size() ? mapABInfo->allMapPlayers.size() : 1;

    LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapPlayerStats: Map {} ({}{}) | playerCount = ({}).",
        instanceMap->GetMapName(),
        instanceMap->GetId(),
        instanceMap->GetInstanceId() ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
        mapABInfo->playerCount);

    LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapPlayerStats: Map {} ({}{}) | combatLocked = ({}), combatLockMinPlayers = ({}).",
        instanceMap->GetMapName(),
        instanceMap->GetId(),
        instanceMap->GetInstanceId() ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
        mapABInfo->combatLocked,
        mapABInfo->combatLockMinPlayers);

    uint8 adjustedPlayerCount = 0;

    //
    // If combat is locked and the new player count is higher than the combat lock, update the combat lock
    //

    if(mapABInfo->combatLocked &&
       mapABInfo->playerCount > oldPlayerCount &&
       mapABInfo->playerCount > mapABInfo->combatLockMinPlayers)
    {
        //
        // Start with the actual player count
        //

        adjustedPlayerCount = mapABInfo->playerCount;

        //
        // This is the new floor
        //

        mapABInfo->combatLockMinPlayers = mapABInfo->playerCount;

        LOG_DEBUG("module.AutoBalance_CombatLocking", "AutoBalance::UpdateMapPlayerStats: Map {} ({}{}) | Combat is locked. Combat floor increased. New floor is ({}).",
            instanceMap->GetMapName(),
            instanceMap->GetId(),
            instanceMap->GetInstanceId() ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
            mapABInfo->combatLockMinPlayers);

    }
    //
    // If combat is otherwise locked
    //
    else if (mapABInfo->combatLocked)
    {
        //
        // Start with the saved floor
        //
        adjustedPlayerCount = mapABInfo->combatLockMinPlayers ? mapABInfo->combatLockMinPlayers : mapABInfo->playerCount;

        LOG_DEBUG("module.AutoBalance_CombatLocking", "AutoBalance::UpdateMapPlayerStats: Map {} ({}{}) | Combat is locked. Combat floor is ({}).",
            instanceMap->GetMapName(),
            instanceMap->GetId(),
            instanceMap->GetInstanceId() ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
            mapABInfo->combatLockMinPlayers);
    }
    //
    // If combat is not locked
    //
    else
    {
        //
        // Start with the actual player count
        //
        adjustedPlayerCount = mapABInfo->playerCount;
    }

    //
    // If the adjusted player count is below the min players setting, adjust it
    //

    if (adjustedPlayerCount < mapABInfo->minPlayers)
        adjustedPlayerCount = mapABInfo->minPlayers;

    //
    // Adjust by the PlayerDifficultyOffset
    //

    adjustedPlayerCount += PlayerCountDifficultyOffset;

    //
    // Store the adjusted player count in the map's info
    //

    mapABInfo->adjustedPlayerCount = adjustedPlayerCount;

    //
    // If the adjustedPlayerCount changed, schedule this map for a reconfiguration
    //

    if (oldAdjustedPlayerCount != mapABInfo->adjustedPlayerCount)
    {
        mapABInfo->mapConfigTime = 1;

        LOG_DEBUG("module.AutoBalance_CombatLocking", "AutoBalance::UpdateMapPlayerStats: Map {} ({}{}) | Player difficulty changes ({}->{}). Force map update. {} ({}{}) map config time set to ({}).",
            instanceMap->GetMapName(),
            instanceMap->GetId(),
            instanceMap->GetInstanceId() ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
            oldAdjustedPlayerCount,
            mapABInfo->adjustedPlayerCount,
            instanceMap->GetMapName(),
            instanceMap->GetId(),
            instanceMap->GetInstanceId() ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
            mapABInfo->mapConfigTime);
    }

    uint8 highestPlayerLevel = 0;
    uint8 lowestPlayerLevel  = 80;

    //
    // Iterate through the players and update the highest and lowest player levels
    //

    for (std::vector<Player*>::const_iterator playerIterator = mapABInfo->allMapPlayers.begin(); playerIterator != mapABInfo->allMapPlayers.end(); ++playerIterator)
    {
        Player* thisPlayer = *playerIterator;

        if (thisPlayer && !thisPlayer->IsGameMaster())
        {
            if (thisPlayer->GetLevel() > highestPlayerLevel || highestPlayerLevel == 0)
                highestPlayerLevel = thisPlayer->GetLevel();

            if (thisPlayer->GetLevel() < lowestPlayerLevel || lowestPlayerLevel == 0)
                lowestPlayerLevel = thisPlayer->GetLevel();
        }
    }

    mapABInfo->highestPlayerLevel = highestPlayerLevel;
    mapABInfo->lowestPlayerLevel  = lowestPlayerLevel;

    if (!highestPlayerLevel)
    {
        mapABInfo->highestPlayerLevel = mapABInfo->lfgTargetLevel;
        mapABInfo->lowestPlayerLevel  = mapABInfo->lfgTargetLevel;

        //
        // No non-GM players on the map
        //

        LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapPlayerStats: Map {} ({}{}, {}-player {}) | has no non-GM players. Player stats derived from LFG target level.",
            map->GetMapName(),
            map->GetId(),
            map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
            instanceMap->GetMaxPlayers(),
            instanceMap->IsHeroic() ? "Heroic" : "Normal");
    }
    else
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapPlayerStats: Map {} ({}{}, {}-player {}) | has {} player(s) with level range ({})-({}). Difficulty is {} player(s).",
            map->GetMapName(),
            map->GetId(),
            map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
            instanceMap->GetMaxPlayers(),
            instanceMap->IsHeroic() ? "Heroic" : "Normal",
            mapABInfo->playerCount,
            mapABInfo->lowestPlayerLevel,
            mapABInfo->highestPlayerLevel,
            mapABInfo->adjustedPlayerCount);
    }
}

void AddPlayerToMap(Map* map, Player* player)
{
    //
    // Get map data
    //

    AutoBalanceMapInfo* mapABInfo = GetMapInfo(map);


    if (!player)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddPlayerToMap: Map {} ({}{}) | Player does not exist.",
            map->GetMapName(),
            map->GetId(),
            map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "");
        return;
    }
    //
    // Player is a GM
    //
    else if (player->IsGameMaster())
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddPlayerToMap: Map {} ({}{}) | Game Master ({}) will not be added to the player list.",
            map->GetMapName(),
            map->GetId(),
            map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
            player->GetName());
        return;
    }
    //
    // If this player is already in the map's player list, skip
    //
    else if (std::find(mapABInfo->allMapPlayers.begin(), mapABInfo->allMapPlayers.end(), player) != mapABInfo->allMapPlayers.end())
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::AddPlayerToMap: Player {} ({}) | is already in the map's player list.",
            player->GetName(),
            player->GetLevel());
        return;
    }

    //
    // Add the player to the map's player list
    //

    mapABInfo->allMapPlayers.push_back(player);
    LOG_DEBUG("module.AutoBalance", "AutoBalance::AddPlayerToMap: Player {} ({}) | added to the map's player list.", player->GetName(), player->GetLevel());

    //
    // Update the map's player stats
    //

    UpdateMapPlayerStats(map);
}

bool RemovePlayerFromMap(Map* map, Player* player)
{
    //
    // Get map data
    //

    AutoBalanceMapInfo* mapABInfo = GetMapInfo(map);

    //
    // If this player isn't in the map's player list, skip
    //

    if (std::find(mapABInfo->allMapPlayers.begin(), mapABInfo->allMapPlayers.end(), player) == mapABInfo->allMapPlayers.end())
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance::RemovePlayerFromMap: Player {} ({}) | was not in the map's player list.", player->GetName(), player->GetLevel());
        return false;
    }

    //
    // Remove the player from the map's player list
    //

    mapABInfo->allMapPlayers.erase(std::remove(mapABInfo->allMapPlayers.begin(), mapABInfo->allMapPlayers.end(), player), mapABInfo->allMapPlayers.end());
    LOG_DEBUG("module.AutoBalance", "AutoBalance::RemovePlayerFromMap: Player {} ({}) | removed from the map's player list.", player->GetName(), player->GetLevel());

    //
    // If the map is combat locked, schedule a map update for when combat ends
    //

    if (mapABInfo->combatLocked)
        mapABInfo->combatLockTripped = true;

    //
    // Update the map's player stats
    //

    UpdateMapPlayerStats(map);

    return true;
}

bool UpdateMapDataIfNeeded(Map* map, bool force)
{
    //
    // Get map data
    //

    AutoBalanceMapInfo* mapABInfo = GetMapInfo(map);

    //
    // If map needs update
    //

    if (force || mapABInfo->globalConfigTime < globalConfigTime || mapABInfo->mapConfigTime < mapABInfo->globalConfigTime)
    {

        LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}) | globalConfigTime = ({}) | mapConfigTime = ({})",
            map->GetMapName(),
            map->GetId(),
            map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
            mapABInfo->globalConfigTime,
            mapABInfo->mapConfigTime);

        //
        // Update forced
        //

        if (force)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}) | Update forced.",
                map->GetMapName(),
                map->GetId(),
                map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                mapABInfo->mapConfigTime);
        }

        //
        // Some tracking variables
        //

        bool isGlobalConfigOutOfDate = mapABInfo->globalConfigTime < globalConfigTime;
        bool isMapConfigOutOfDate    = mapABInfo->mapConfigTime < globalConfigTime;

        //
        // If this was triggered by a global config update, redetect players
        //

        if (isGlobalConfigOutOfDate)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}) | Global config is out of date ({} < {}) and will be updated.",
                map->GetMapName(),
                map->GetId(),
                map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                mapABInfo->globalConfigTime,
                globalConfigTime);

            LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}) | Will recount players in the map.",
                map->GetMapName(),
                map->GetId(),
                map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "");

            //
            // Clear the map's player list
            //

            mapABInfo->allMapPlayers.clear();

            //
            // Reset the combat lock
            //

            mapABInfo->combatLockMinPlayers = 0;

            //
            // Get the map's player list
            //

            Map::PlayerList const& playerList = map->GetPlayers();

            //
            // Re-count the players in the dungeon
            //

            for (Map::PlayerList::const_iterator playerIteration = playerList.begin(); playerIteration != playerList.end(); ++playerIteration)
            {
                Player* thisPlayer = playerIteration->GetSource();

                //
                // If the player is in combat, combat lock the map
                //

                if (thisPlayer->IsInCombat())
                {
                    mapABInfo->combatLocked = true;

                    LOG_DEBUG("module.AutoBalance_CombatLocking", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}) | Player {} is in combat. Map is combat locked.",
                        map->GetMapName(),
                        map->GetId(),
                        map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                        thisPlayer->GetName());
                }

                //
                // (conditionally) add the player to the map's player list
                //

                AddPlayerToMap(map, thisPlayer);
            }

            //
            // Map's player count will be updated in UpdateMapPlayerStats below
            //
        }

        //
        // Map config is out of date
        //

        if (isMapConfigOutOfDate)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}) | Map config is out of date ({} < {}) and will be updated.",
                map->GetMapName(),
                map->GetId(),
                map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                mapABInfo->mapConfigTime,
                globalConfigTime);
        }

        //
        // Should the map be enabled?
        //

        bool newEnabled = ShouldMapBeEnabled(map);

        //
        // If this is a transition between enabled states, reset the map's config time so it will refresh
        ///

        if (mapABInfo->enabled != newEnabled)
        {
            mapABInfo->mapConfigTime = 1;

            LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}) | Enabled state transitions from {}->{}, map update forced. Map config time set to ({}).",
                map->GetMapName(),
                map->GetId(),
                map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                mapABInfo->enabled ? "ENABLED" : "DISABLED",
                newEnabled ? "ENABLED" : "DISABLED",
                mapABInfo->mapConfigTime);
        }

        //
        // Update the enabled state
        //

        mapABInfo->enabled = newEnabled;

        if (!mapABInfo->enabled)
        {
            //
            // Mark the config updated to prevent checking the disabled map repeatedly
            //

            mapABInfo->globalConfigTime = globalConfigTime;
            mapABInfo->mapConfigTime    = globalConfigTime;

            LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}) | is disabled.",
                map->GetMapName(),
                map->GetId(),
                map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "");
        }

        //
        // Load the map's settings
        //

        LoadMapSettings(map);

        //
        // Update the map's player stats
        //

        UpdateMapPlayerStats(map);

        //
        // If LevelScaling is disabled OR if the average creature level is inside the skip range,
        // Set the map level to the average creature level, rounded to the nearest integer
        //

        if (!LevelScaling ||
            ((mapABInfo->avgCreatureLevel <= mapABInfo->highestPlayerLevel + mapABInfo->levelScalingSkipHigherLevels && mapABInfo->levelScalingSkipHigherLevels != 0) &&
             (mapABInfo->avgCreatureLevel >= mapABInfo->highestPlayerLevel - mapABInfo->levelScalingSkipLowerLevels && mapABInfo->levelScalingSkipLowerLevels != 0)))
        {
            mapABInfo->prevMapLevel          = mapABInfo->mapLevel;
            mapABInfo->mapLevel              = (uint8)(mapABInfo->avgCreatureLevel + 0.5f);
            mapABInfo->isLevelScalingEnabled = false;

            //
            // Only log if the mapLevel has changed
            //

            if (mapABInfo->prevMapLevel != mapABInfo->mapLevel)
            {
                LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}, {}-player {}) | Level scaling is disabled. Map level tracking stat updated {}{} (original level).",
                    map->GetMapName(),
                    map->GetId(),
                    map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                    map->ToInstanceMap()->GetMaxPlayers(),
                    map->ToInstanceMap()->IsHeroic() ? "Heroic" : "Normal",
                    mapABInfo->mapLevel != mapABInfo->prevMapLevel ? std::to_string(mapABInfo->prevMapLevel) + "->" : "",
                    mapABInfo->mapLevel);
            }

        }
        //
        // If the average creature level is lower than the highest player level,
        // Set the map level to the average creature level, rounded to the nearest integer
        //
        else if (mapABInfo->avgCreatureLevel <= mapABInfo->highestPlayerLevel)
        {
            mapABInfo->prevMapLevel          = mapABInfo->mapLevel;
            mapABInfo->mapLevel              = (uint8)(mapABInfo->avgCreatureLevel + 0.5f);
            mapABInfo->isLevelScalingEnabled = true;

            //
            // Only log if the mapLevel has changed
            //
            if (mapABInfo->prevMapLevel != mapABInfo->mapLevel)
            {
                LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}, {}-player {}) | Level scaling is enabled. Map level updated ({}{}) (average creature level).",
                    map->GetMapName(),
                    map->GetId(),
                    map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                    map->ToInstanceMap()->GetMaxPlayers(),
                    map->ToInstanceMap()->IsHeroic() ? "Heroic" : "Normal",
                    mapABInfo->mapLevel != mapABInfo->prevMapLevel ? std::to_string(mapABInfo->prevMapLevel) + "->" : "",
                    mapABInfo->mapLevel);
            }
        }
        //
        // Caps at the highest player level
        //
        else
        {
            mapABInfo->prevMapLevel          = mapABInfo->mapLevel;
            mapABInfo->mapLevel              = mapABInfo->highestPlayerLevel;
            mapABInfo->isLevelScalingEnabled = true;

            //
            // Only log if the mapLevel has changed
            //
            if (mapABInfo->prevMapLevel != mapABInfo->mapLevel)
            {
                LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}, {}-player {}) | Lcaling is enabled. Map level updated ({}{}) (highest player level).",
                    map->GetMapName(),
                    map->GetId(),
                    map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                    map->ToInstanceMap()->GetMaxPlayers(),
                    map->ToInstanceMap()->IsHeroic() ? "Heroic" : "Normal",
                    mapABInfo->mapLevel != mapABInfo->prevMapLevel ? std::to_string(mapABInfo->prevMapLevel) + "->" : "",
                    mapABInfo->mapLevel);
            }
        }

        //
        // World multipliers only need to be updated if the mapLevel has changed OR if the map config is out of date
        //

        if (mapABInfo->prevMapLevel != mapABInfo->mapLevel || isMapConfigOutOfDate)
        {
            //
            // Update World Health multiplier
            // Used for scaling damage against destructible game objects
            //

            World_Multipliers health = getWorldMultiplier(map, BaseValueType::AUTOBALANCE_HEALTH);

            mapABInfo->worldHealthMultiplier = health.unscaled;

            //
            // Update World Damage or Healing multiplier
            // Used for scaling damage and healing between players and/or non-creatures
            //

            World_Multipliers damageHealing               = getWorldMultiplier(map, BaseValueType::AUTOBALANCE_DAMAGE_HEALING);

            mapABInfo->worldDamageHealingMultiplier       = damageHealing.unscaled;
            mapABInfo->scaledWorldDamageHealingMultiplier = damageHealing.scaled;
        }

        //
        // Mark the config updated
        //

        mapABInfo->globalConfigTime = globalConfigTime;
        mapABInfo->mapConfigTime    = GetCurrentConfigTime();

        LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: {} ({}{}) | Global config time set to ({}).",
            map->GetMapName(),
            map->GetId(),
            map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
            mapABInfo->globalConfigTime);

        LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: {} ({}{}) | Map config time set to ({}).",
            map->GetMapName(),
            map->GetId(),
            map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
            mapABInfo->mapConfigTime);

        return true;
    }
    else
    {
        // LOG_DEBUG("module.AutoBalance", "AutoBalance::UpdateMapDataIfNeeded: Map {} ({}{}) global config is up to date ({} == {}).",
        //             map->GetMapName(),
        //             map->GetId(),
        //             map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
        //             mapABInfo->globalConfigTime,
        //             globalConfigTime
        // );

        return false;
    }
}

AutoBalanceMapInfo* GetMapInfo(Map* map)
{
    AutoBalanceMapInfo* mapABInfo = map->CustomData.GetDefault<AutoBalanceMapInfo>("AutoBalanceMapInfo");
    if (mapABInfo->initialized)
        return mapABInfo;

    LOG_DEBUG("module.AutoBalance", "AutoBalance::InitializeMap: Map {} ({}{}) | Initializing map.",
        map->GetMapName(),
        map->GetId(),
        map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "");

    mapABInfo->initialized = true;

    if (!map->IsDungeon())
        return mapABInfo;

    // get the map's LFG stats even if not enabled
    LFGDungeonEntry const* dungeon = GetLFGDungeon(map->GetId(), map->GetDifficulty());
    if (dungeon) {
        mapABInfo->lfgMinLevel = dungeon->MinLevel;
        mapABInfo->lfgMaxLevel = dungeon->MaxLevel;
        mapABInfo->lfgTargetLevel = dungeon->TargetLevel;
    }
    // if this is a heroic dungeon that isn't in LFG, get the stats from the non-heroic version
    else if (map->IsHeroic())
    {
        LFGDungeonEntry const* nonHeroicDungeon = nullptr;
        if (map->GetDifficulty() == DUNGEON_DIFFICULTY_HEROIC)
            nonHeroicDungeon = GetLFGDungeon(map->GetId(), DUNGEON_DIFFICULTY_NORMAL);
        else if (map->GetDifficulty() == RAID_DIFFICULTY_10MAN_HEROIC)
            nonHeroicDungeon = GetLFGDungeon(map->GetId(), RAID_DIFFICULTY_10MAN_NORMAL);
        else if (map->GetDifficulty() == RAID_DIFFICULTY_25MAN_HEROIC)
            nonHeroicDungeon = GetLFGDungeon(map->GetId(), RAID_DIFFICULTY_25MAN_NORMAL);

        LOG_DEBUG("module.AutoBalance", "AutoBalance::InitializeMap: Map {} ({}{}) | is a Heroic dungeon that is not in LFG. Using non-heroic LFG levels.",
            map->GetMapName(),
            map->GetId(),
            map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : ""
        );

        if (nonHeroicDungeon)
        {
            mapABInfo->lfgMinLevel = nonHeroicDungeon->MinLevel;
            mapABInfo->lfgMaxLevel = nonHeroicDungeon->MaxLevel;
            mapABInfo->lfgTargetLevel = nonHeroicDungeon->TargetLevel;
        }
        else
        {
            LOG_ERROR("module.AutoBalance", "AutoBalance::InitializeMap: Map {} ({}{}) | Could not determine LFG level ranges for this map. Level will bet set to 0.",
                map->GetMapName(),
                map->GetId(),
                map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : ""
            );
        }
    }

    LOG_DEBUG("module.AutoBalance", "AutoBalance::InitializeMap: Map {} ({}{}) | LFG levels ({}-{}) (target {}). {} for AutoBalancing.",
        map->GetMapName(),
        map->GetId(),
        map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
        mapABInfo->lfgMinLevel ? std::to_string(mapABInfo->lfgMinLevel) : "?",
        mapABInfo->lfgMaxLevel ? std::to_string(mapABInfo->lfgMaxLevel) : "?",
        mapABInfo->lfgTargetLevel ? std::to_string(mapABInfo->lfgTargetLevel) : "?",
        mapABInfo->enabled ? "Enabled" : "Disabled"
    );

    return mapABInfo;
}
