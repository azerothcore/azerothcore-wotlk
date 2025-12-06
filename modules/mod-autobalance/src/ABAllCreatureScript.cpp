#include "ABAllCreatureScript.h"

#include "ABConfig.h"
#include "ABCreatureInfo.h"
#include "ABMapInfo.h"
#include "ABScriptMgr.h"
#include "ABUtils.h"
#include "AutoBalance.h"

#include "MapMgr.h"

void AutoBalance_AllCreatureScript::OnBeforeCreatureSelectLevel(const CreatureTemplate* /*creatureTemplate*/, Creature* creature, uint8& level)
{
    Map* creatureMap = creature->GetMap();

    if (creatureMap && creatureMap->IsDungeon())
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance:: ------------------------------------------------");
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnBeforeCreatureSelectLevel: Creature {} ({}) | Entry ID: ({}) | Spawn ID: ({})",
            creature->GetName(),
            level,
            creature->GetEntry(),
            creature->GetSpawnId()
        );

        // Create the new creature's AB info
        AutoBalanceCreatureInfo* creatureABInfo = creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

        // mark this creature as brand new so that only the level will be modified before creation
        creatureABInfo->isBrandNew = true;

        // if the creature already has a selectedLevel on it, we have already processed it and can re-use that value
        if (creatureABInfo->selectedLevel)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnBeforeCreatureSelectLevel: Creature {} ({}) | has already been processed, using level {}.",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel,
                creatureABInfo->selectedLevel
            );

            level = creatureABInfo->selectedLevel;
            return;
        }

        // Update the map's data if it is out of date (just before changing the map's creature list)
        UpdateMapDataIfNeeded(creature->GetMap());

        Map* creatureMap = creature->GetMap();
        InstanceMap* instanceMap = creatureMap->ToInstanceMap();

        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnBeforeCreatureSelectLevel: Creature {} ({}) | is in map {} ({}{}{}{})",
            creature->GetName(),
            level,
            creatureMap->GetMapName(),
            creatureMap->GetId(),
            instanceMap ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
            instanceMap ? ", " + std::to_string(instanceMap->GetMaxPlayers()) + "-player" : "",
            instanceMap ? instanceMap->IsHeroic() ? " Heroic" : " Normal" : ""
        );

        // Set level originally intended for the creature
        creatureABInfo->UnmodifiedLevel = level;

        // add the creature to the map's tracking list
        AddCreatureToMapCreatureList(creature);

        // Update the map's data if it is out of date (just after changing the map's creature list)
        UpdateMapDataIfNeeded(creature->GetMap());

        // do an initial modification run of the creature, but don't update the level yet
        ModifyCreatureAttributes(creature);

        if (isCreatureRelevant(creature))
        {
            // set the new creature level
            level = creatureABInfo->selectedLevel;

            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnBeforeCreatureSelectLevel: Creature {} ({}) | will spawn in as level ({}).",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel,
                creatureABInfo->selectedLevel
            );
        }
        else
        {
            // don't change level value
            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnBeforeCreatureSelectLevel: Creature {} ({}) | will spawn in at its original level ({}).",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel,
                creatureABInfo->selectedLevel
            );
        }
    }
}

void AutoBalance_AllCreatureScript::OnCreatureSelectLevel(const CreatureTemplate* /* cinfo */, Creature* creature)
{
    // ensure we're in a dungeon with a creature
    if (
        !creature ||
        !creature->GetMap() ||
        !creature->GetMap()->IsDungeon() ||
        !creature->GetMap()->GetInstanceId()
        )
    {
        return;
    }

    // get the creature's info
    AutoBalanceCreatureInfo* creatureABInfo = creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

    // If the creature is brand new, it needs more processing
    if (creatureABInfo->isBrandNew)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance:: ------------------------------------------------");

        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnCreatureSelectLevel: Creature {} ({}) | Entry ID: ({}) | Spawn ID: ({})",
            creature->GetName(),
            creature->GetLevel(),
            creature->GetEntry(),
            creature->GetSpawnId()
        );

        if (creatureABInfo->isBrandNew)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnCreatureSelectLevel: Creature {} ({}) | is no longer brand new.",
                creature->GetName(),
                creature->GetLevel()
            );
            creatureABInfo->isBrandNew = false;
        }

        // Update the map's data if it is out of date
        UpdateMapDataIfNeeded(creature->GetMap());

        ModifyCreatureAttributes(creature);

        // store the creature's max health value for validation in `OnCreatureAddWorld`
        creatureABInfo->initialMaxHealth = creature->GetMaxHealth();

        AutoBalanceCreatureInfo* creatureABInfo = creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

        if (creature->GetLevel() != creatureABInfo->selectedLevel && isCreatureRelevant(creature))
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnCreatureSelectLevel: Creature {} ({}) | is set to level ({}).",
                creature->GetName(),
                creature->GetLevel(),
                creatureABInfo->selectedLevel
            );
            creature->SetLevel(creatureABInfo->selectedLevel);
        }
    }
    else
    {
        LOG_ERROR("module.AutoBalance", "AutoBalance_AllCreatureScript::OnCreatureSelectLevel: Creature {} ({}) | is new to the instance but wasn't flagged as brand new. Please open an issue.",
            creature->GetName(),
            creature->GetLevel()
        );
    }
}

void AutoBalance_AllCreatureScript::OnCreatureAddWorld(Creature* creature)
{
    if (creature->GetMap()->IsDungeon())
    {
        Map* creatureMap = creature->GetMap();
        InstanceMap* instanceMap = creatureMap->ToInstanceMap();
        AutoBalanceCreatureInfo* creatureABInfo = creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

        // final checks on the creature before spawning
        if (isCreatureRelevant(creature))
        {
            // level check
            if (creature->GetLevel() != creatureABInfo->selectedLevel && !creature->IsSummon())
            {
                LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnCreatureAddWorld: Creature {} ({}) | is set to level ({}) just after being added to the world.",
                    creature->GetName(),
                    creature->GetLevel(),
                    creatureABInfo->selectedLevel
                );
                creature->SetLevel(creatureABInfo->selectedLevel);
            }

            // max health check
            if (creature->GetMaxHealth() != creatureABInfo->initialMaxHealth)
            {

                float oldMaxHealth = creature->GetMaxHealth();
                float healthPct = creature->GetHealthPct();
                creature->SetMaxHealth(creatureABInfo->initialMaxHealth);
                creature->SetHealth(creature->GetMaxHealth() * (healthPct / 100));

                LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnCreatureAddWorld: Creature {} ({}) | had its max health changed from ({})->({}) just after being added to the world.",
                    creature->GetName(),
                    creature->GetLevel(),
                    oldMaxHealth,
                    creatureABInfo->initialMaxHealth
                );
            }
        }

        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnCreatureAddWorld: Creature {} ({}) | added to map {} ({}{}{}{})",
            creature->GetName(),
            creature->GetLevel(),
            creatureMap->GetMapName(),
            creatureMap->GetId(),
            instanceMap ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
            instanceMap ? ", " + std::to_string(instanceMap->GetMaxPlayers()) + "-player" : "",
            instanceMap ? instanceMap->IsHeroic() ? " Heroic" : " Normal" : ""
        );
    }
}

void AutoBalance_AllCreatureScript::OnCreatureRemoveWorld(Creature* creature)
{
    if (creature->GetMap()->IsDungeon())
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance:: ------------------------------------------------");

        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnCreatureRemoveWorld: Creature {} ({}) | Entry ID: ({}) | Spawn ID: ({})",
            creature->GetName(),
            creature->GetLevel(),
            creature->GetEntry(),
            creature->GetSpawnId()

        );

        InstanceMap* instanceMap = creature->GetMap()->ToInstanceMap();
        Map* map = sMapMgr->FindBaseMap(creature->GetMapId());

        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnCreatureRemoveWorld: Creature {} ({}) | removed from map {} ({}{}{}{})",
            creature->GetName(),
            creature->GetLevel(),
            map->GetMapName(),
            map->GetId(),
            instanceMap ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
            instanceMap ? ", " + std::to_string(instanceMap->GetMaxPlayers()) + "-player" : "",
            instanceMap ? instanceMap->IsHeroic() ? " Heroic" : " Normal" : ""
        );

        // remove the creature from the map's tracking list, if present
        RemoveCreatureFromMapData(creature);
    }
}

void AutoBalance_AllCreatureScript::OnAllCreatureUpdate(Creature* creature, uint32 /*diff*/)
{
    // ensure we're in a dungeon with a creature
    if (
        !creature ||
        !creature->GetMap() ||
        !creature->GetMap()->IsDungeon() ||
        !creature->GetMap()->GetInstanceId()
        )
    {
        return;
    }

    // update map data before making creature changes
    UpdateMapDataIfNeeded(creature->GetMap());

    // If the config is out of date and the creature was reset, run modify against it
    if (ResetCreatureIfNeeded(creature))
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance:: ------------------------------------------------");

        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnAllCreatureUpdate: Creature {} ({}) | Entry ID: ({}) | Spawn ID: ({})",
            creature->GetName(),
            creature->GetLevel(),
            creature->GetEntry(),
            creature->GetSpawnId()
        );

        // Update the map's data if it is out of date
        UpdateMapDataIfNeeded(creature->GetMap());

        ModifyCreatureAttributes(creature);

        AutoBalanceCreatureInfo* creatureABInfo = creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

        if (creature->GetLevel() != creatureABInfo->selectedLevel && isCreatureRelevant(creature))
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::OnAllCreatureUpdate: Creature {} ({}) | is set to level ({}).",
                creature->GetName(),
                creature->GetLevel(),
                creatureABInfo->selectedLevel
            );
            creature->SetLevel(creatureABInfo->selectedLevel);
        }
    }
}

// Reset the passed creature to stock if the config has changed
bool AutoBalance_AllCreatureScript::ResetCreatureIfNeeded(Creature* creature)
{
    // make sure we have a creature
    if (!creature || !isCreatureRelevant(creature))
        return false;

    // get (or create) map and creature info
    AutoBalanceMapInfo* mapABInfo = GetMapInfo(creature->GetMap());
    AutoBalanceCreatureInfo* creatureABInfo = creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

    // if creature is dead and mapConfigTime is 0, skip for now
    if (creature->isDead() && creatureABInfo->mapConfigTime == 1)
        return false;
    // if the creature is dead but mapConfigTime is NOT 0, we set it to 0 so that it will be recalculated if revived
    // also remember that this creature was once alive but is now dead
    else if (creature->isDead())
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance:: ------------------------------------------------");
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ResetCreatureIfNeeded: Creature {} ({}) | is dead and mapConfigTime is not 0 - prime for reset if revived.", creature->GetName(), creature->GetLevel());
        creatureABInfo->mapConfigTime = 1;
        creatureABInfo->wasAliveNowDead = true;
        return false;
    }

    // if the config is outdated, reset the creature
    if (creatureABInfo->mapConfigTime < mapABInfo->mapConfigTime)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance:: ------------------------------------------------");

        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ResetCreatureIfNeeded: Creature {} ({}) | Entry ID: ({}) | Spawn ID: ({})",
            creature->GetName(),
            creature->GetLevel(),
            creature->GetEntry(),
            creature->GetSpawnId()
        );

        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ResetCreatureIfNeeded: Creature {} ({}) | Map config time is out of date ({} < {}). Resetting creature before modify.",
            creature->GetName(),
            creature->GetLevel(),
            creatureABInfo->mapConfigTime,
            mapABInfo->mapConfigTime
        );

        // retain some values
        uint8 unmodifiedLevel = creatureABInfo->UnmodifiedLevel;
        bool isActive = creatureABInfo->isActive;
        bool wasAliveNowDead = creatureABInfo->wasAliveNowDead;
        bool isInCreatureList = creatureABInfo->isInCreatureList;

        // reset AutoBalance modifiers
        creature->CustomData.Erase("AutoBalanceCreatureInfo");
        AutoBalanceCreatureInfo* creatureABInfo = creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

        // grab the creature's template and the original creature's stats
        CreatureTemplate const* creatureTemplate = creature->GetCreatureTemplate();

        // set the creature's level
        if (creature->GetLevel() != unmodifiedLevel)
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ResetCreatureIfNeeded: Creature {} ({}) | is set to level ({}).",
                creature->GetName(),
                creature->GetLevel(),
                unmodifiedLevel
            );
            creature->SetLevel(unmodifiedLevel);
            creature->UpdateAllStats();
        }
        else
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ResetCreatureIfNeeded: Creature {} ({}) | is already set to level ({}).",
                creature->GetName(),
                creature->GetLevel(),
                unmodifiedLevel
            );
        }

        // get the creature's base stats
        CreatureBaseStats const* origCreatureBaseStats = sObjectMgr->GetCreatureBaseStats(unmodifiedLevel, creatureTemplate->unit_class);

        // health
        float currentHealthPercent = (float)creature->GetHealth() / (float)creature->GetMaxHealth();
        creature->SetMaxHealth(origCreatureBaseStats->GenerateHealth(creatureTemplate));
        creature->SetHealth((float)origCreatureBaseStats->GenerateHealth(creatureTemplate) * currentHealthPercent);

        // mana
        if (creature->getPowerType() == POWER_MANA && creature->GetPower(POWER_MANA) >= 0 && creature->GetMaxPower(POWER_MANA) > 0)
        {
            float currentManaPercent = creature->GetPower(POWER_MANA) / creature->GetMaxPower(POWER_MANA);
            creature->SetMaxPower(POWER_MANA, origCreatureBaseStats->GenerateMana(creatureTemplate));
            creature->SetPower(POWER_MANA, creature->GetMaxPower(POWER_MANA) * currentManaPercent);
        }

        // armor
        creature->SetArmor(origCreatureBaseStats->GenerateArmor(creatureTemplate));

        // restore the saved data
        creatureABInfo->UnmodifiedLevel = unmodifiedLevel;
        creatureABInfo->isActive = isActive;
        creatureABInfo->wasAliveNowDead = wasAliveNowDead;
        creatureABInfo->isInCreatureList = isInCreatureList;

        // damage and ccduration are handled using AutoBalanceCreatureInfo data only

        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ResetCreatureIfNeeded: Creature {} ({}) is reset to its original stats.",
            creature->GetName(),
            creature->GetLevel()
        );

        // return true to indicate that the creature was reset
        return true;
    }

    // creature was not reset, return false
    return false;

}

void AutoBalance_AllCreatureScript::ModifyCreatureAttributes(Creature* creature)
{
    // make sure we have a creature
    if (!creature)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: creature is null.");
        return;
    }

    // grab creature and map data
    AutoBalanceCreatureInfo* creatureABInfo = creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");
    Map* map = creature->GetMap();
    InstanceMap* instanceMap = map->ToInstanceMap();
    AutoBalanceMapInfo* mapABInfo = GetMapInfo(instanceMap);

    // mark the creature as updated using the current settings if needed
    // if this creature is brand new, do not update this so that it will be re-processed next OnCreatureUpdate
    if (creatureABInfo->mapConfigTime < mapABInfo->mapConfigTime && !creatureABInfo->isBrandNew)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Map config time set to ({}).",
            creature->GetName(),
            creature->GetLevel(),
            mapABInfo->mapConfigTime
        );
        creatureABInfo->mapConfigTime = mapABInfo->mapConfigTime;
    }

    // check to make sure that the creature's map is enabled for scaling
    if (!mapABInfo->enabled)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | is in map {} ({}{}{}{}) that is not enabled, not changed.",
            creature->GetName(),
            creatureABInfo->UnmodifiedLevel,
            map->GetMapName(),
            map->GetId(),
            instanceMap ? "-" + std::to_string(instanceMap->GetInstanceId()) : "",
            instanceMap ? ", " + std::to_string(instanceMap->GetMaxPlayers()) + "-player" : "",
            instanceMap ? instanceMap->IsHeroic() ? " Heroic" : " Normal" : ""
        );

        // return the creature back to their original level, if it's not already
        creatureABInfo->selectedLevel = creatureABInfo->UnmodifiedLevel;

        return;
    }

    // if the creature isn't relevant, don't modify it
    if (!isCreatureRelevant(creature))
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | is not relevant, not changed.",
            creature->GetName(),
            creatureABInfo->UnmodifiedLevel
        );

        // return the creature back to their original level, if it's not already
        creatureABInfo->selectedLevel = creatureABInfo->UnmodifiedLevel;

        return;
    }

    // if this creature is below 85% of the minimum LFG level for the map, make no changes
    // if this creature is above 115% of the maximum LFG level for the map, make no changes
    // if this is a critter that is substantial enough to be considered a real enemy, still modify it
    // if this is a trigger, still modify it
    if (
        (
            (creatureABInfo->UnmodifiedLevel < (uint8)(((float)mapABInfo->lfgMinLevel * .85f) + 0.5f)) ||
            (creatureABInfo->UnmodifiedLevel > (uint8)(((float)mapABInfo->lfgMaxLevel * 1.15f) + 0.5f))
            ) &&
        (
            !(creature->IsCritter() && creatureABInfo->UnmodifiedLevel >= 5 && creature->GetMaxHealth() > 100) &&
            !creature->IsTrigger()
            )
        )
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | is a {} outside of the expected NPC level range for the map ({} to {}), not modified.",
            creature->GetName(),
            creatureABInfo->UnmodifiedLevel,
            creature->IsCritter() ? "critter" : "creature",
            (uint8)(((float)mapABInfo->lfgMinLevel * .85f) + 0.5f),
            (uint8)(((float)mapABInfo->lfgMaxLevel * 1.15f) + 0.5f)
        );

        creatureABInfo->selectedLevel = creatureABInfo->UnmodifiedLevel;

        return;
    }

    // if the creature was dead (but this function is being called because they are being revived), reset it and allow modifications
    if (creatureABInfo->wasAliveNowDead)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | was dead but appears to be alive now, reset wasAliveNowDead flag.", creature->GetName(), creatureABInfo->UnmodifiedLevel);
        // if the creature was dead, reset it
        creatureABInfo->wasAliveNowDead = false;
    }
    // if the creature is dead and wasn't marked as dead by this script, simply skip
    else if (creature->isDead())
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | is dead, do not modify.", creature->GetName(), creatureABInfo->UnmodifiedLevel);
        return;
    }

    CreatureTemplate const* creatureTemplate = creature->GetCreatureTemplate();

    // check to see if the creature is in the forced num players list
    uint32 forcedNumPlayers = GetForcedNumPlayers(creatureTemplate->Entry);

    if (forcedNumPlayers == 0)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | is in the forced num players list with a value of 0, not changed.", creature->GetName(), creatureABInfo->UnmodifiedLevel);
        return; // forcedNumPlayers 0 means that the creature is contained in DisabledID -> no scaling
    }

    // start with the map's adjusted player count
    uint32 adjustedPlayerCount = mapABInfo->adjustedPlayerCount;

    // if the forced value is set and the adjusted player count is above the forced value, change it to match
    if (forcedNumPlayers > 0 && adjustedPlayerCount > forcedNumPlayers)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | is in the forced num players list with a value of {}, adjusting adjustedPlayerCount to match.", creature->GetName(), creatureABInfo->UnmodifiedLevel, forcedNumPlayers);
        adjustedPlayerCount = forcedNumPlayers;
    }

    // store the current player count in the creature and map's data
    creatureABInfo->instancePlayerCount = adjustedPlayerCount;

    if (!creatureABInfo->instancePlayerCount) // no players in map, do not modify attributes
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | is on a map with no players, not changed.", creature->GetName(), creatureABInfo->UnmodifiedLevel);
        return;
    }

    if (!sABScriptMgr->OnBeforeModifyAttributes(creature, creatureABInfo->instancePlayerCount))
        return;

    // only scale levels if level scaling is enabled and the instance's average creature level is not within the skip range
    if
        (
            LevelScaling &&
            (
                (mapABInfo->avgCreatureLevel > mapABInfo->highestPlayerLevel + mapABInfo->levelScalingSkipHigherLevels || mapABInfo->levelScalingSkipHigherLevels == 0) ||
                (mapABInfo->avgCreatureLevel < mapABInfo->highestPlayerLevel - mapABInfo->levelScalingSkipLowerLevels || mapABInfo->levelScalingSkipLowerLevels == 0)
                ) &&
            !creatureABInfo->neverLevelScale
            )
    {
        uint8 selectedLevel;

        // handle "special" creatures
        // note that these already passed a more complex check above
        if (
            (creature->IsTotem() && creature->IsSummon() && creatureABInfo->summoner && creatureABInfo->summoner->IsPlayer()) ||
            (
                creature->IsCritter() && creatureABInfo->UnmodifiedLevel <= 5 && creature->GetMaxHealth() <= 100
                )
            )
        {
            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | is a {} that will not be level scaled, but will have modifiers set.",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel,
                creature->IsTotem() ? "totem" : "critter"
            );

            selectedLevel = creatureABInfo->UnmodifiedLevel;
        }
        // if we're using dynamic scaling, calculate the creature's level based relative to the highest player level in the map
        else if (LevelScalingMethod == AUTOBALANCE_SCALING_DYNAMIC)
        {
            // calculate the creature's new level
            selectedLevel = (mapABInfo->highestPlayerLevel + mapABInfo->levelScalingDynamicCeiling) - (mapABInfo->highestCreatureLevel - creatureABInfo->UnmodifiedLevel);

            // check to be sure that the creature's new level is at least the dynamic scaling floor
            if (selectedLevel < (mapABInfo->highestPlayerLevel - mapABInfo->levelScalingDynamicFloor))
                selectedLevel = mapABInfo->highestPlayerLevel - mapABInfo->levelScalingDynamicFloor;

            // check to be sure that the creature's new level is no higher than the dynamic scaling ceiling
            if (selectedLevel > (mapABInfo->highestPlayerLevel + mapABInfo->levelScalingDynamicCeiling))
                selectedLevel = mapABInfo->highestPlayerLevel + mapABInfo->levelScalingDynamicCeiling;

            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaled to level ({}) via dynamic scaling.",
                creature->GetName(),
                creatureABInfo->UnmodifiedLevel,
                selectedLevel
            );
        }
        // otherwise we're using "fixed" scaling and should use the highest player level in the map
        else
        {
            selectedLevel = mapABInfo->highestPlayerLevel;
            LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaled to level ({}) via fixed scaling.", creature->GetName(), creatureABInfo->UnmodifiedLevel, selectedLevel);
        }

        creatureABInfo->selectedLevel = selectedLevel;

        if (creature->GetLevel() != selectedLevel)
        {
            if (!creatureABInfo->isBrandNew)
            {
                LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | is set to new selectedLevel ({}).",
                    creature->GetName(),
                    creatureABInfo->UnmodifiedLevel,
                    selectedLevel
                );

                creature->SetLevel(selectedLevel);
            }
        }
    }
    else if (!LevelScaling)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | not level scaled due to level scaling being disabled.", creature->GetName(), creatureABInfo->UnmodifiedLevel);
        creatureABInfo->selectedLevel = creatureABInfo->UnmodifiedLevel;
    }
    else if (creatureABInfo->neverLevelScale)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | not level scaled due to being marked as multipliers only.", creature->GetName(), creatureABInfo->UnmodifiedLevel);
        creatureABInfo->selectedLevel = creatureABInfo->UnmodifiedLevel;
    }
    else
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | not level scaled due the instance's average creature level being inside the skip range.", creature->GetName(), creatureABInfo->UnmodifiedLevel);
        creatureABInfo->selectedLevel = creatureABInfo->UnmodifiedLevel;
    }

    if (creatureABInfo->isBrandNew)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | is brand new, do not modify level or stats yet.",
            creature->GetName(),
            creatureABInfo->UnmodifiedLevel
        );

        return;
    }

    CreatureBaseStats const* origCreatureBaseStats = sObjectMgr->GetCreatureBaseStats(creatureABInfo->UnmodifiedLevel, creatureTemplate->unit_class);
    CreatureBaseStats const* newCreatureBaseStats = sObjectMgr->GetCreatureBaseStats(creatureABInfo->selectedLevel, creatureTemplate->unit_class);

    // Inflection Point
    AutoBalanceInflectionPointSettings inflectionPointSettings = getInflectionPointSettings(instanceMap, isBossOrBossSummon(creature));

    // Generate the default multiplier
    float defaultMultiplier = getDefaultMultiplier(instanceMap, inflectionPointSettings);

    if (!sABScriptMgr->OnAfterDefaultMultiplier(creature, defaultMultiplier))
        return;

    // Stat Modifiers
    AutoBalanceStatModifiers statModifiers = getStatModifiers(map, creature);
    float statMod_global = statModifiers.global;
    float statMod_health = statModifiers.health;
    float statMod_mana = statModifiers.mana;
    float statMod_armor = statModifiers.armor;
    float statMod_damage = statModifiers.damage;
    float statMod_ccDuration = statModifiers.ccduration;

    // Storage for the final values applied to the creature
    uint32 newFinalHealth = 0;
    uint32 newFinalMana = 0;
    uint32 newFinalArmor = 0;

    //
    //  Health Scaling
    //
    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ---------- HEALTH MULTIPLIER ----------",
        creature->GetName(),
        creatureABInfo->selectedLevel
    );

    float healthMultiplier = defaultMultiplier * statMod_global * statMod_health;
    float scaledHealthMultiplier;

    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | HealthMultiplier: ({}) = defaultMultiplier ({}) * statMod_global ({}) * statMod_health ({})",
        creature->GetName(),
        creatureABInfo->selectedLevel,
        healthMultiplier,
        defaultMultiplier,
        statMod_global,
        statMod_health
    );

    // Can't be less than MinHPModifier
    if (healthMultiplier <= MinHPModifier)
    {
        healthMultiplier = MinHPModifier;

        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | HealthMultiplier: ({}) - capped to MinHPModifier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            healthMultiplier,
            MinHPModifier
        );
    }

    // set the non-level-scaled health multiplier on the creature's AB info
    creatureABInfo->HealthMultiplier = healthMultiplier;

    // only level scale health if level scaling is enabled and the creature level has been altered
    if (LevelScaling && creatureABInfo->selectedLevel != creatureABInfo->UnmodifiedLevel)
    {
        // the max health that the creature had before we did anything with it
        float origHealth = origCreatureBaseStats->GenerateHealth(creatureTemplate);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | origHealth ({}) = origCreatureBaseStats->GenerateHealth(creatureTemplate)",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            origHealth
        );

        // the base health of the new creature level for this creature's class
        // uses a custom smoothing formula to smooth transitions between expansions
        float newBaseHealth = getBaseExpansionValueForLevel(newCreatureBaseStats->BaseHealth, mapABInfo->highestPlayerLevel);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newBaseHealth ({}) = getBaseExpansionValueForLevel(newCreatureBaseStats->BaseHealth, mapABInfo->highestPlayerLevel ({}))",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            newBaseHealth,
            mapABInfo->highestPlayerLevel
        );

        // the health of the creature at its new level (before per-player scaling)
        float newHealth = newBaseHealth * creatureTemplate->ModHealth;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newHealth ({}) = newBaseHealth ({}) * creature ModHealth ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            newHealth,
            newBaseHealth,
            creatureTemplate->ModHealth
        );

        // the multiplier that would need to be applied to the creature's original health to get the new level's health (before per-player scaling)
        float newHealthMultiplier = newHealth / origHealth;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newHealthMultiplier ({}) = newHealth ({}) / origHealth ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            newHealthMultiplier,
            newHealth,
            origHealth
        );

        // the multiplier that would need to be applied to the creature's original health to get the new level's health (after per-player scaling)
        scaledHealthMultiplier = healthMultiplier * newHealthMultiplier;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledHealthMultiplier ({}) = healthMultiplier ({}) * newHealthMultiplier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            scaledHealthMultiplier,
            healthMultiplier,
            newHealthMultiplier
        );

        // the actual health value to be applied to the level-scaled and player-scaled creature
        newFinalHealth = round(origHealth * scaledHealthMultiplier);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newFinalHealth ({}) = origHealth ({}) * scaledHealthMultiplier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            newFinalHealth,
            origHealth,
            scaledHealthMultiplier
        );
    }
    else
    {
        // the non-level-scaled health multiplier is the same as the level-scaled health multiplier
        scaledHealthMultiplier = healthMultiplier;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledHealthMultiplier ({}) = healthMultiplier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            scaledHealthMultiplier,
            healthMultiplier
        );

        // the original health of the creature
        uint32 origHealth = origCreatureBaseStats->GenerateHealth(creatureTemplate);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | origHealth ({}) = origCreatureBaseStats->GenerateHealth(creatureTemplate)",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            origHealth
        );

        // the actual health value to be applied to the player-scaled creature
        newFinalHealth = round(origHealth * creatureABInfo->HealthMultiplier);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newFinalHealth ({}) = origHealth ({}) * HealthMultiplier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            newFinalHealth,
            origHealth,
            creatureABInfo->HealthMultiplier
        );
    }

    //
    //  Mana Scaling
    //
    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ---------- MANA MULTIPLIER ----------",
        creature->GetName(),
        creatureABInfo->selectedLevel
    );

    float manaMultiplier = defaultMultiplier * statMod_global * statMod_mana;
    float scaledManaMultiplier;

    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ManaMultiplier: ({}) = defaultMultiplier ({}) * statMod_global ({}) * statMod_mana ({})",
        creature->GetName(),
        creatureABInfo->selectedLevel,
        manaMultiplier,
        defaultMultiplier,
        statMod_global,
        statMod_mana
    );

    // Can't be less than MinManaModifier
    if (manaMultiplier <= MinManaModifier)
    {
        manaMultiplier = MinManaModifier;

        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ManaMultiplier: ({}) - capped to MinManaModifier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            manaMultiplier,
            MinManaModifier
        );
    }

    // if the creature doesn't have mana, set the multiplier to 0.0
    if (!origCreatureBaseStats->GenerateMana(creatureTemplate))
    {
        manaMultiplier = 0.0f;
        creatureABInfo->ManaMultiplier = 0.0f;
        scaledManaMultiplier = 0.0f;

        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Creature doesn't have mana, multiplier set to ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            creatureABInfo->ManaMultiplier
        );
    }
    // if the creature has mana, continue calculations
    else
    {
        // set the non-level-scaled mana multiplier on the creature's AB info
        creatureABInfo->ManaMultiplier = manaMultiplier;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ManaMultiplier: ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            creatureABInfo->ManaMultiplier
        );

        // only level scale mana if level scaling is enabled and the creature level has been altered
        if (LevelScaling && creatureABInfo->selectedLevel != creatureABInfo->UnmodifiedLevel)
        {
            // the max mana that the creature had before we did anything with it
            uint32 origMana = origCreatureBaseStats->GenerateMana(creatureTemplate);
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | origMana ({}) = origCreatureBaseStats->GenerateMana(creatureTemplate)",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                origMana
            );

            // the max mana that the creature would have at its new level
            // there is no per-expansion adjustment for mana
            uint32 newMana = newCreatureBaseStats->GenerateMana(creatureTemplate);
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newMana ({}) = newCreatureBaseStats->GenerateMana(creatureTemplate)",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                newMana
            );

            // the multiplier that would need to be applied to the creature's original mana to get the new level's mana (before per-player scaling)
            float newManaMultiplier = (float)newMana / (float)origMana;
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newManaMultiplier ({}) = newMana ({}) / origMana ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                newManaMultiplier,
                newMana,
                origMana
            );

            // the multiplier that would need to be applied to the creature's original mana to get the new level's mana (after per-player scaling)
            scaledManaMultiplier = manaMultiplier * newManaMultiplier;
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledManaMultiplier ({}) = manaMultiplier ({}) * newManaMultiplier ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                scaledManaMultiplier,
                manaMultiplier,
                newManaMultiplier
            );

            // the actual mana value to be applied to the level-scaled and player-scaled creature
            newFinalMana = round(origMana * scaledManaMultiplier);
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newFinalMana ({}) = origMana ({}) * scaledManaMultiplier ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                newFinalMana,
                origMana,
                scaledManaMultiplier
            );
        }
        else
        {
            // scaled mana multiplier is the same as the non-level-scaled mana multiplier
            scaledManaMultiplier = manaMultiplier;
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledManaMultiplier ({}) = manaMultiplier ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                scaledManaMultiplier,
                manaMultiplier
            );

            // the original mana of the creature
            uint32 origMana = origCreatureBaseStats->GenerateMana(creatureTemplate);
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | origMana ({}) = origCreatureBaseStats->GenerateMana(creatureTemplate)",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                origMana
            );

            // the actual mana value to be applied to the player-scaled creature
            newFinalMana = round(origMana * creatureABInfo->ManaMultiplier);
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newFinalMana ({}) = origMana ({}) * creatureABInfo->ManaMultiplier ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                newFinalMana,
                origMana,
                creatureABInfo->ManaMultiplier
            );
        }
    }

    //
    //  Armor Scaling
    //
    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ---------- ARMOR MULTIPLIER ----------",
        creature->GetName(),
        creatureABInfo->selectedLevel
    );

    float armorMultiplier = defaultMultiplier * statMod_global * statMod_armor;
    float scaledArmorMultiplier;

    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | armorMultiplier: ({}) = defaultMultiplier ({}) * statMod_global ({}) * statMod_armor ({})",
        creature->GetName(),
        creatureABInfo->selectedLevel,
        armorMultiplier,
        defaultMultiplier,
        statMod_global,
        statMod_armor
    );

    // set the non-level-scaled armor multiplier on the creature's AB info
    creatureABInfo->ArmorMultiplier = armorMultiplier;

    // only level scale armor if level scaling is enabled and the creature level has been altered
    if (LevelScaling && creatureABInfo->selectedLevel != creatureABInfo->UnmodifiedLevel)
    {
        // the armor that the creature had before we did anything with it
        uint32 origArmor = origCreatureBaseStats->GenerateArmor(creatureTemplate);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | origArmor ({}) = origCreatureBaseStats->GenerateArmor(creatureTemplate)",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            origArmor
        );

        // the armor that the creature would have at its new level
        // there is no per-expansion adjustment for armor
        uint32 newArmor = newCreatureBaseStats->GenerateArmor(creatureTemplate);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newArmor ({}) = newCreatureBaseStats->GenerateArmor(creatureTemplate)",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            newArmor
        );

        // the multiplier that would need to be applied to the creature's original armor to get the new level's armor (before per-player scaling)
        float newArmorMultiplier = (float)newArmor / (float)origArmor;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newArmorMultiplier ({}) = newArmor ({}) / origArmor ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            newArmorMultiplier,
            newArmor,
            origArmor
        );

        // the multiplier that would need to be applied to the creature's original armor to get the new level's armor (after per-player scaling)
        scaledArmorMultiplier = armorMultiplier * newArmorMultiplier;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledArmorMultiplier ({}) = armorMultiplier ({}) * newArmorMultiplier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            scaledArmorMultiplier,
            armorMultiplier,
            newArmorMultiplier
        );

        // the actual armor value to be applied to the level-scaled and player-scaled creature
        newFinalArmor = round(origArmor * scaledArmorMultiplier);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newFinalArmor ({}) = origArmor ({}) * scaledArmorMultiplier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            newFinalArmor,
            origArmor,
            scaledArmorMultiplier
        );
    }
    else
    {
        // Scaled armor multiplier is the same as the non-level-scaled armor multiplier
        scaledArmorMultiplier = armorMultiplier;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledArmorMultiplier ({}) = armorMultiplier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            scaledArmorMultiplier,
            armorMultiplier
        );

        // the original armor of the creature
        uint32 origArmor = origCreatureBaseStats->GenerateArmor(creatureTemplate);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | origArmor ({}) = origCreatureBaseStats->GenerateArmor(creatureTemplate)",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            origArmor
        );

        // the actual armor value to be applied to the player-scaled creature
        newFinalArmor = round(origArmor * creatureABInfo->ArmorMultiplier);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newFinalArmor ({}) = origArmor ({}) * creatureABInfo->ArmorMultiplier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            newFinalArmor,
            origArmor,
            creatureABInfo->ArmorMultiplier
        );
    }

    //
    //  Damage Scaling
    //
    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ---------- DAMAGE MULTIPLIER ----------",
        creature->GetName(),
        creatureABInfo->selectedLevel
    );

    float damageMultiplier = defaultMultiplier * statMod_global * statMod_damage;
    float scaledDamageMultiplier;

    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | DamageMultiplier: ({}) = defaultMultiplier ({}) * statMod_global ({}) * statMod_damage ({})",
        creature->GetName(),
        creatureABInfo->selectedLevel,
        damageMultiplier,
        defaultMultiplier,
        statMod_global,
        statMod_damage
    );

    // Can't be less than MinDamageModifier
    if (damageMultiplier <= MinDamageModifier)
    {
        damageMultiplier = MinDamageModifier;

        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | DamageMultiplier: ({}) - capped to MinDamageModifier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            damageMultiplier,
            MinDamageModifier
        );
    }

    // set the non-level-scaled damage multiplier on the creature's AB info
    creatureABInfo->DamageMultiplier = damageMultiplier;
    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | DamageMultiplier: ({})",
        creature->GetName(),
        creatureABInfo->selectedLevel,
        creatureABInfo->DamageMultiplier
    );

    // only level scale damage if level scaling is enabled and the creature level has been altered
    if (LevelScaling && creatureABInfo->selectedLevel != creatureABInfo->UnmodifiedLevel)
    {

        // the original base damage of the creature
        // note that we don't mess with the damage modifier here since it applied equally to the original and new levels
        float origBaseDamage = origCreatureBaseStats->GenerateBaseDamage(creatureTemplate);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | origBaseDamage ({}) = origCreatureBaseStats->GenerateBaseDamage(creatureTemplate)",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            origBaseDamage
        );

        // the base damage of the new creature level for this creature's class
        // uses a custom smoothing formula to smooth transitions between expansions
        float newBaseDamage = getBaseExpansionValueForLevel(newCreatureBaseStats->BaseDamage, mapABInfo->highestPlayerLevel);
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newBaseDamage ({}) = getBaseExpansionValueForLevel(newCreatureBaseStats->BaseDamage, mapABInfo->highestPlayerLevel ({}))",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            newBaseDamage,
            mapABInfo->highestPlayerLevel
        );

        // the multiplier that would need to be applied to the creature's original damage to get the new level's damage (before per-player scaling)
        float newDamageMultiplier = newBaseDamage / origBaseDamage;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | newDamageMultiplier ({}) = newBaseDamage ({}) / origBaseDamage ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            newDamageMultiplier,
            newBaseDamage,
            origBaseDamage
        );

        // the actual multiplier that will be used to scale the creature's damage (after per-player scaling)
        scaledDamageMultiplier = damageMultiplier * newDamageMultiplier;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledDamageMultiplier ({}) = damageMultiplier ({}) * newDamageMultiplier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            scaledDamageMultiplier,
            damageMultiplier,
            newDamageMultiplier
        );
    }
    else
    {
        // the scaled damage multiplier is the same as the non-level-scaled damage multiplier
        scaledDamageMultiplier = damageMultiplier;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledDamageMultiplier ({}) = damageMultiplier ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            scaledDamageMultiplier,
            origCreatureBaseStats->GenerateBaseDamage(creatureTemplate),
            damageMultiplier
        );

    }

    //
    // Crowd Control Debuff Duration Scaling
    //

    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ---------- CC DURATION MULTIPLIER ----------",
        creature->GetName(),
        creatureABInfo->selectedLevel
    );

    float ccDurationMultiplier;

    if (statMod_ccDuration != -1.0f)
    {
        // calculate CC Duration from the default multiplier and the config settings
        ccDurationMultiplier = defaultMultiplier * statMod_ccDuration;

        // Min/Max checking
        if (ccDurationMultiplier < MinCCDurationModifier)
            ccDurationMultiplier = MinCCDurationModifier;
        else if (ccDurationMultiplier > MaxCCDurationModifier)
            ccDurationMultiplier = MaxCCDurationModifier;

        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ccDurationMultiplier: ({})",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            ccDurationMultiplier
        );
    }
    else
    {
        // the CC Duration will not be changed
        ccDurationMultiplier = 1.0f;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Crowd Control Duration will not be changed.",
            creature->GetName(),
            creatureABInfo->selectedLevel
        );
    }

    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ccDurationMultiplier: ({}) = defaultMultiplier ({}) * statMod_ccDuration ({})",
        creature->GetName(),
        creatureABInfo->selectedLevel,
        ccDurationMultiplier,
        defaultMultiplier,
        statMod_ccDuration
    );

    //
    //  Apply New Values
    //
    if (!sABScriptMgr->OnBeforeUpdateStats(creature, newFinalHealth, newFinalMana, damageMultiplier, newFinalArmor))
        return;

    uint32 prevMaxHealth = creature->GetMaxHealth();
    uint32 prevMaxPower = creature->GetMaxPower(Powers::POWER_MANA);
    uint32 prevHealth = creature->GetHealth();
    uint32 prevPower = creature->GetPower(Powers::POWER_MANA);

    uint32 prevPlayerDamageRequired = creature->GetPlayerDamageReq();
    uint32 prevCreateHealth = creature->GetCreateHealth();

    Powers pType = creature->getPowerType();

    creature->SetArmor(newFinalArmor);
    creature->SetModifierValue(UNIT_MOD_ARMOR, BASE_VALUE, (float)newFinalArmor);
    creature->SetCreateHealth(newFinalHealth);
    creature->SetMaxHealth(newFinalHealth);
    creature->ResetPlayerDamageReq();
    creature->SetCreateMana(newFinalMana);
    creature->SetMaxPower(Powers::POWER_MANA, newFinalMana);
    creature->SetModifierValue(UNIT_MOD_ENERGY, BASE_VALUE, (float)100.0f);
    creature->SetModifierValue(UNIT_MOD_RAGE, BASE_VALUE, (float)100.0f);
    creature->SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, (float)newFinalHealth);
    creature->SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, (float)newFinalMana);
    creatureABInfo->ScaledHealthMultiplier = scaledHealthMultiplier;
    creatureABInfo->ScaledManaMultiplier = scaledManaMultiplier;
    creatureABInfo->ScaledArmorMultiplier = scaledArmorMultiplier;
    creatureABInfo->ScaledDamageMultiplier = scaledDamageMultiplier;
    creatureABInfo->CCDurationMultiplier = ccDurationMultiplier;

    // adjust the current health as appropriate
    uint32 scaledCurHealth = 0;
    uint32 scaledCurPower = 0;

    // if this is a summon and it's a clone of its summoner, keep the health and mana values of the summon
    // only do this once, when `_isSummonCloneOfSummoner(creature)` returns true but !creatureABInfo->isCloneOfSummoner is false
    if
        (
            creature->IsSummon() &&
            _isSummonCloneOfSummoner(creature) &&
            !creatureABInfo->isCloneOfSummoner
            )
    {
        creatureABInfo->isCloneOfSummoner = true;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Summon is a clone of its summoner, keeping health and mana values.",
            creature->GetName(),
            creatureABInfo->selectedLevel
        );

        if (prevHealth && prevMaxHealth)
        {
            scaledCurHealth = prevHealth;
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledCurHealth ({}) = prevHealth ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                scaledCurHealth,
                prevHealth
            );
        }

        if (prevPower && prevMaxPower)
        {
            scaledCurPower = prevPower;
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledCurPower ({}) = prevPower ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                scaledCurPower,
                prevPower
            );
        }
    }
    else
    {
        if (prevHealth && prevMaxHealth)
        {
            scaledCurHealth = float(newFinalHealth) / float(prevMaxHealth) * float(prevHealth);
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledCurHealth ({}) = float(newFinalHealth) ({}) / float(prevMaxHealth) ({}) * float(prevHealth) ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                scaledCurHealth,
                newFinalHealth,
                prevMaxHealth,
                prevHealth
            );
        }
        else
        {
            scaledCurHealth = 0;
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledCurHealth ({}) = 0",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                scaledCurHealth
            );
        }

        if (prevPower && prevMaxPower)
        {
            scaledCurPower = float(newFinalMana) / float(prevMaxPower) * float(prevPower);
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledCurPower ({}) = float(newFinalMana) ({}) / float(prevMaxPower) ({}) * float(prevPower) ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                scaledCurPower,
                newFinalMana,
                prevMaxPower,
                prevPower
            );
        }
        else
        {
            scaledCurPower = 0;
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | scaledCurPower ({}) = 0",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                scaledCurPower
            );
        }
    }

    creature->SetHealth(scaledCurHealth);
    if (pType == Powers::POWER_MANA)
        creature->SetPower(Powers::POWER_MANA, scaledCurPower);
    else
        creature->setPowerType(pType); // fix creatures with different power types

    uint32 playerDamageRequired = creature->GetPlayerDamageReq();
    if (prevPlayerDamageRequired == 0)
    {
        // If already reached damage threshold for loot, drop to zero again
        creature->LowerPlayerDamageReq(playerDamageRequired, true);
    }
    else
    {
        // Scale the damage requirements similar to creature HP scaling
        uint32 scaledPlayerDmgReq = float(prevPlayerDamageRequired) * float(newFinalHealth) / float(prevCreateHealth);
        // Do some math
        creature->LowerPlayerDamageReq(playerDamageRequired - scaledPlayerDmgReq, true);
    }

    //
    // Reward Scaling
    //

    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ---------- REWARD SCALING ----------",
        creature->GetName(),
        creatureABInfo->selectedLevel
    );

    // calculate the average multiplier after level scaling is applied
    float avgHealthDamageMultipliers;

    // only if one of the scaling options is enabled
    if (RewardScalingXP || RewardScalingMoney)
    {
        // use health and damage to calculate the average multiplier
        avgHealthDamageMultipliers = (scaledHealthMultiplier + scaledDamageMultiplier) / 2.0f;
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | avgHealthDamageMultipliers ({}) = (scaledHealthMultiplier ({}) + scaledDamageMultiplier ({})) / 2.0f",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            avgHealthDamageMultipliers,
            scaledHealthMultiplier,
            scaledDamageMultiplier
        );
    }
    else
    {
        // Reward scaling is disabled
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Reward scaling is disabled.",
            creature->GetName(),
            creatureABInfo->selectedLevel
        );
    }

    // XP Scaling
    if (RewardScalingXP)
    {
        if (RewardScalingMethod == AUTOBALANCE_SCALING_FIXED)
        {
            creatureABInfo->XPModifier = RewardScalingXPModifier;
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Fixed Mode: XPModifier ({}) = RewardScalingXPModifier ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                creatureABInfo->XPModifier,
                RewardScalingXPModifier
            );
        }
        else if (RewardScalingMethod == AUTOBALANCE_SCALING_DYNAMIC)
        {
            creatureABInfo->XPModifier = avgHealthDamageMultipliers * RewardScalingXPModifier;
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Dynamic Mode: XPModifier ({}) = avgHealthDamageMultipliers ({}) * RewardScalingXPModifier ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                creatureABInfo->XPModifier,
                avgHealthDamageMultipliers,
                RewardScalingXPModifier
            );
        }
    }

    // Money Scaling
    if (RewardScalingMoney)
    {

        if (RewardScalingMethod == AUTOBALANCE_SCALING_FIXED)
        {
            creatureABInfo->MoneyModifier = RewardScalingMoneyModifier;
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Fixed Mode: MoneyModifier ({}) = RewardScalingMoneyModifier ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                creatureABInfo->MoneyModifier,
                RewardScalingMoneyModifier
            );
        }
        else if (RewardScalingMethod == AUTOBALANCE_SCALING_DYNAMIC)
        {
            creatureABInfo->MoneyModifier = avgHealthDamageMultipliers * RewardScalingMoneyModifier;
            LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Dynamic Mode: MoneyModifier ({}) = avgHealthDamageMultipliers ({}) * RewardScalingMoneyModifier ({})",
                creature->GetName(),
                creatureABInfo->selectedLevel,
                creatureABInfo->MoneyModifier,
                avgHealthDamageMultipliers,
                RewardScalingMoneyModifier
            );
        }
    }

    // update all stats
    creature->UpdateAllStats();

    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | ---------- FINAL STATS ----------",
        creature->GetName(),
        creatureABInfo->selectedLevel
    );

    LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Health ({}/{} {:.1f}%) -> ({}/{} {:.1f}%)",
        creature->GetName(),
        creatureABInfo->selectedLevel,
        prevHealth,
        prevMaxHealth,
        prevMaxHealth ? float(prevHealth) / float(prevMaxHealth) * 100.0f : 0.0f,
        creature->GetHealth(),
        creature->GetMaxHealth(),
        creature->GetMaxHealth() ? float(creature->GetHealth()) / float(creature->GetMaxHealth()) * 100.0f : 0.0f
    );

    if (prevPower && prevMaxPower && pType == Powers::POWER_MANA)
    {
        LOG_DEBUG("module.AutoBalance_StatGeneration", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Mana ({}/{} {:.1f}%) -> ({}/{} {:.1f}%)",
            creature->GetName(),
            creatureABInfo->selectedLevel,
            prevPower,
            prevMaxPower,
            prevMaxPower ? float(prevPower) / float(prevMaxPower) * 100.0f : 0.0f,
            creature->GetPower(Powers::POWER_MANA),
            creature->GetMaxPower(Powers::POWER_MANA),
            creature->GetMaxPower(Powers::POWER_MANA) ? float(creature->GetPower(Powers::POWER_MANA)) / float(creature->GetMaxPower(Powers::POWER_MANA)) * 100.0f : 0.0f
        );
    }

    // debug log the new stat multipliers stored in CreatureABInfo in a compact, single-line format
    if (creatureABInfo->UnmodifiedLevel != creatureABInfo->selectedLevel)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}->{}) | Multipliers: H:{:.3f}->{:.3f} M:{:.3f}->{:.3f} A:{:.3f}->{:.3f} D:{:.3f}->{:.3f} CC:{:.3f} XP:{:.3f} $:{:.3f}",
            creature->GetName(),
            creatureABInfo->UnmodifiedLevel,
            creatureABInfo->selectedLevel,
            creatureABInfo->HealthMultiplier,
            creatureABInfo->ScaledHealthMultiplier,
            creatureABInfo->ManaMultiplier,
            creatureABInfo->ScaledManaMultiplier,
            creatureABInfo->ArmorMultiplier,
            creatureABInfo->ScaledArmorMultiplier,
            creatureABInfo->DamageMultiplier,
            creatureABInfo->ScaledDamageMultiplier,
            creatureABInfo->CCDurationMultiplier,
            creatureABInfo->XPModifier,
            creatureABInfo->MoneyModifier
        );
    }
    else
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::ModifyCreatureAttributes: Creature {} ({}) | Multipliers: H:{:.3f} M:{:.3f} A:{:.3f} D:{:.3f} CC:{:.3f} XP:{:.3f} $:{:.3f}",
            creature->GetName(),
            creatureABInfo->UnmodifiedLevel,
            creatureABInfo->HealthMultiplier,
            creatureABInfo->ManaMultiplier,
            creatureABInfo->ArmorMultiplier,
            creatureABInfo->DamageMultiplier,
            creatureABInfo->CCDurationMultiplier,
            creatureABInfo->XPModifier,
            creatureABInfo->MoneyModifier
        );
    }
}

bool AutoBalance_AllCreatureScript::_isSummonCloneOfSummoner(Creature* summon)
{
    // if the summon doesn't exist or isn't a summon
    if (!summon || !summon->IsSummon())
        return false;

    // get the summon's info
    AutoBalanceCreatureInfo* summonABInfo = summon->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

    // get the saved summoner
    Creature* summoner = summonABInfo->summoner;

    // if the summoner doesn't exist
    if (!summoner)
        return false;

    // if this creature's ID is in the list of creatures that are not clones of their summoner (creatureIDsThatAreNotClones), return false
    if (
        std::find
        (
            creatureIDsThatAreNotClones.begin(),
            creatureIDsThatAreNotClones.end(),
            summon->GetEntry()
        ) != creatureIDsThatAreNotClones.end()
        )
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::_isSummonCloneOfSummoner: Creature {} ({}) | creatureIDsThatAreNotClones contains this creature's ID ({}) | false",
            summon->GetName(),
            summonABInfo->selectedLevel,
            summon->GetEntry()
        );
        return false;
    }


    // create a running score for this check
    int8 score = 0;

    LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::_isSummonCloneOfSummoner: Creature {} ({}) | Is this a clone of it's summoner {} ({})?",
        summon->GetName(),
        summonABInfo->selectedLevel,
        summoner->GetName(),
        summoner->GetLevel()
    );


    // if the entry ID is the same, +2
    if (summon->GetEntry() == summoner->GetEntry())
    {
        score += 2;
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::_isSummonCloneOfSummoner: Creature {} ({}) | Entry: ({}) == ({}) | score: +2 = ({})",
            summon->GetName(),
            summonABInfo->selectedLevel,
            summon->GetEntry(),
            summoner->GetEntry(),
            score
        );
    }

    // if the max health is the same, +3
    if (summon->GetMaxHealth() == summoner->GetMaxHealth())
    {
        score += 3;
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::_isSummonCloneOfSummoner: Creature {} ({}) | MaxHealth: ({}) == ({}) | score: +3 = ({})",
            summon->GetName(),
            summonABInfo->selectedLevel,
            summon->GetMaxHealth(),
            summoner->GetMaxHealth(),
            score
        );
    }

    // if the type (humanoid, dragonkin, etc) is the same, +1
    if (summon->GetCreatureType() == summoner->GetCreatureType())
    {
        score += 1;
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::_isSummonCloneOfSummoner: Creature {} ({}) | CreatureType: ({}) == ({}) | score: +1 = ({})",
            summon->GetName(),
            summonABInfo->selectedLevel,
            summon->GetCreatureType(),
            summoner->GetCreatureType(),
            score
        );
    }

    // if the name is the same, +2
    if (summon->GetName() == summoner->GetName())
    {
        score += 2;
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::_isSummonCloneOfSummoner: Creature {} ({}) | Name: ({}) == ({}) | score: +2 = ({})",
            summon->GetName(),
            summonABInfo->selectedLevel,
            summon->GetName(),
            summoner->GetName(),
            score
        );
    }
    // if the summoner's name is a part of the summon's name, +1
    else if (summon->GetName().find(summoner->GetName()) != std::string::npos)
    {
        score += 1;
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::_isSummonCloneOfSummoner: Creature {} ({}) | Name: ({}) contains ({}) | score: +1 = ({})",
            summon->GetName(),
            summonABInfo->selectedLevel,
            summon->GetName(),
            summoner->GetName(),
            score
        );
    }

    // if the display ID is the same, +1
    if (summon->GetDisplayId() == summoner->GetDisplayId())
    {
        score += 1;
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::_isSummonCloneOfSummoner: Creature {} ({}) | DisplayId: ({}) == ({}) | score: +1 = ({})",
            summon->GetName(),
            summonABInfo->selectedLevel,
            summon->GetDisplayId(),
            summoner->GetDisplayId(),
            score
        );
    }

    // if the score is at least 5, consider this a clone
    if (score >= 5)
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::_isSummonCloneOfSummoner: Creature {} ({}) | score ({}) >= 5 | true",
            summon->GetName(),
            summonABInfo->selectedLevel,
            score
        );
        return true;
    }
    else
    {
        LOG_DEBUG("module.AutoBalance", "AutoBalance_AllCreatureScript::_isSummonCloneOfSummoner: Creature {} ({}) | score ({}) < 5 | false",
            summon->GetName(),
            summonABInfo->selectedLevel,
            score
        );
        return false;
    }
}