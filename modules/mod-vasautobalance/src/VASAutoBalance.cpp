/*
* Copyright (C) 2018 AzerothCore <http://www.azerothcore.org>
* Copyright (C) 2012 CVMagic <http://www.trinitycore.org/f/topic/6551-vas-autobalance/>
* Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
* Copyright (C) 1985-2010 {VAS} KalCorp  <http://vasserver.dyndns.org/>
*
* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the
* Free Software Foundation; either version 2 of the License, or (at your
* option) any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
* more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see <http://www.gnu.org/licenses/>.
*/

/*
* Script Name: AutoBalance
* Original Authors: KalCorp and Vaughner
* Maintainer(s): AzerothCore
* Original Script Name: VAS.AutoBalance
* Description: This script is intended to scale based on number of players,
* instance mobs & world bosses' level, health, mana, and damage.
*/


#include "Configuration/Config.h"
#include "Unit.h"
#include "Chat.h"
#include "Creature.h"
#include "Player.h"
#include "ObjectMgr.h"
#include "MapManager.h"
#include "World.h"
#include "Map.h"
#include "ScriptMgr.h"
#include "Language.h"
#include <vector>
#include "VASAutoBalance.h"
#include "ScriptMgrMacros.h"
#include "Group.h"

bool VasScriptMgr::OnBeforeModifyAttributes(Creature *creature, uint32 & instancePlayerCount) {
    bool ret=true;
    FOR_SCRIPTS_RET(VasModuleScript, itr, end, ret) // return true by default if not scripts
        if (!itr->second->OnBeforeModifyAttributes(creature, instancePlayerCount))
            ret=false; // we change ret value only when scripts return false

    return ret;
}

bool VasScriptMgr::OnAfterDefaultMultiplier(Creature *creature, float & defaultMultiplier) {
    bool ret=true;
    FOR_SCRIPTS_RET(VasModuleScript, itr, end, ret) // return true by default if not scripts
    if (!itr->second->OnAfterDefaultMultiplier(creature, defaultMultiplier))
        ret=false; // we change ret value only when scripts return false
        
        return ret;
}

bool VasScriptMgr::OnBeforeUpdateStats(Creature* creature, uint32& scaledHealth, uint32& scaledMana, float& damageMultiplier, uint32& newBaseArmor) {
    bool ret=true;
    FOR_SCRIPTS_RET(VasModuleScript, itr, end, ret)
    if (!itr->second->OnBeforeUpdateStats(creature, scaledHealth, scaledMana, damageMultiplier, newBaseArmor))
        ret=false;

        return ret;
}

VasModuleScript::VasModuleScript(const char* name)
    : ModuleScript(name)
{
    ScriptRegistry<VasModuleScript>::AddScript(this);
}


class AutoBalanceCreatureInfo : public DataMap::Base
{
public:
    AutoBalanceCreatureInfo() {}
    AutoBalanceCreatureInfo(uint32 count, float dmg, float hpRate, float manaRate, float armorRate, uint8 selLevel) :
    instancePlayerCount(count),selectedLevel(selLevel), DamageMultiplier(dmg),HealthMultiplier(hpRate),ManaMultiplier(manaRate),ArmorMultiplier(armorRate) {}
    uint32 instancePlayerCount = 0;
    uint8 selectedLevel = 0;
    // this is used to detect creatures that update their entry
    uint32 entry = 0;
    float DamageMultiplier = 1;
    float HealthMultiplier = 1;
    float ManaMultiplier = 1;
    float ArmorMultiplier = 1;
};

class AutoBalanceMapInfo : public DataMap::Base
{
public:
    AutoBalanceMapInfo() {}
    AutoBalanceMapInfo(uint32 count, uint8 selLevel) : playerCount(count),mapLevel(selLevel) {}
    uint32 playerCount = 0;
    uint8 mapLevel = 0;
};

// The map values correspond with the VAS.AutoBalance.XX.Name entries in the configuration file.
static std::map<int, int> forcedCreatureIds;
// cheaphack for difficulty server-wide.
// Another value TODO in player class for the party leader's value to determine dungeon difficulty.
static int8 PlayerCountDifficultyOffset, LevelScaling, higherOffset, lowerOffset, numPlayerConf;
static uint32 rewardRaid, rewardDungeon, MinPlayerReward;
static bool enabled, LevelEndGameBoost, DungeonsOnly, PlayerChangeNotify, LevelUseDb, rewardEnabled;
static float globalRate, healthMultiplier, manaMultiplier, armorMultiplier, damageMultiplier, MinHPModifier, MinDamageModifier, InflectionPoint;

int GetValidDebugLevel()
{
    int debugLevel = sConfigMgr->GetIntDefault("VASAutoBalance.DebugLevel", 2);

    if ((debugLevel < 0) || (debugLevel > 3))
        {
        return 1;
        }
    return debugLevel;
}

void LoadForcedCreatureIdsFromString(std::string creatureIds, int forcedPlayerCount) // Used for reading the string from the configuration file to for those creatures who need to be scaled for XX number of players.
{
    std::string delimitedValue;
    std::stringstream creatureIdsStream;

    creatureIdsStream.str(creatureIds);
    while (std::getline(creatureIdsStream, delimitedValue, ',')) // Process each Creature ID in the string, delimited by the comma - ","
    {
        int creatureId = atoi(delimitedValue.c_str());
        if (creatureId >= 0)
        {
            forcedCreatureIds[creatureId] = forcedPlayerCount;
        }
    }
}

int GetForcedCreatureId(int creatureId)
{
    if (forcedCreatureIds.find(creatureId) == forcedCreatureIds.end()) // Don't want the forcedCreatureIds map to blowup to a massive empty array
    {
        return 0;
    }
    return forcedCreatureIds[creatureId];
}


void getAreaLevel(Map *map, uint8 areaid, uint8 &min, uint8 &max) {
    LFGDungeonEntry const* dungeon = GetLFGDungeon(map->GetId(), map->GetDifficulty());
    if (dungeon && (map->IsDungeon() || map->IsRaid())) {
        min  = dungeon->minlevel;
        max  = dungeon->reclevel ? dungeon->reclevel : dungeon->maxlevel;
    }
    
    if (!min && !max)
    {
        AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(areaid);
        if (areaEntry && areaEntry->area_level > 0) {
            min = areaEntry->area_level;
            max = areaEntry->area_level;
        }
    }
}

class VAS_AutoBalance_WorldScript : public WorldScript
{
    public:
    VAS_AutoBalance_WorldScript()
        : WorldScript("VAS_AutoBalance_WorldScript")
    {
    }

    void OnBeforeConfigLoad(bool /*reload*/) override
    {
        SetInitialWorldSettings();
    }
    void OnStartup() override
    {
    }

    void SetInitialWorldSettings()
    {
        forcedCreatureIds.clear();
        LoadForcedCreatureIdsFromString(sConfigMgr->GetStringDefault("VASAutoBalance.ForcedID40", ""), 40);
        LoadForcedCreatureIdsFromString(sConfigMgr->GetStringDefault("VASAutoBalance.ForcedID25", ""), 25);
        LoadForcedCreatureIdsFromString(sConfigMgr->GetStringDefault("VASAutoBalance.ForcedID10", ""), 10);
        LoadForcedCreatureIdsFromString(sConfigMgr->GetStringDefault("VASAutoBalance.ForcedID5", ""), 5);
        LoadForcedCreatureIdsFromString(sConfigMgr->GetStringDefault("VASAutoBalance.ForcedID2", ""), 2);
        LoadForcedCreatureIdsFromString(sConfigMgr->GetStringDefault("VASAutoBalance.DisabledID", ""), 0);

        enabled = sConfigMgr->GetIntDefault("VASAutoBalance.enable", 1) == 1;
        LevelEndGameBoost = sConfigMgr->GetIntDefault("VASAutoBalance.LevelEndGameBoost", 1) == 1;
        DungeonsOnly = sConfigMgr->GetIntDefault("VASAutoBalance.DungeonsOnly", 1) == 1;
        PlayerChangeNotify = sConfigMgr->GetIntDefault("VASAutoBalance.PlayerChangeNotify", 1) == 1;
        LevelUseDb = sConfigMgr->GetIntDefault("VASAutoBalance.levelUseDbValuesWhenExists", 1) == 1;
        rewardEnabled = sConfigMgr->GetIntDefault("VASAutoBalance.reward.enable", 1) == 1;

        LevelScaling = sConfigMgr->GetIntDefault("VASAutoBalance.levelScaling", 1);
        PlayerCountDifficultyOffset = sConfigMgr->GetIntDefault("VASAutoBalance.playerCountDifficultyOffset", 0);
        higherOffset = sConfigMgr->GetIntDefault("VASAutoBalance.levelHigherOffset", 3);
        lowerOffset = sConfigMgr->GetIntDefault("VASAutoBalance.levelLowerOffset", 0);
        rewardRaid = sConfigMgr->GetIntDefault("VASAutoBalance.reward.raidToken", 49426);
        rewardDungeon = sConfigMgr->GetIntDefault("VASAutoBalance.reward.dungeonToken", 47241);
        MinPlayerReward = sConfigMgr->GetFloatDefault("VASAutoBalance.reward.MinPlayerReward", 1);

        InflectionPoint = sConfigMgr->GetFloatDefault("VASAutoBalance.InflectionPoint", 0.5f);
        globalRate = sConfigMgr->GetFloatDefault("VASAutoBalance.rate.global", 1.0f);
        healthMultiplier = sConfigMgr->GetFloatDefault("VASAutoBalance.rate.health", 1.0f);
        manaMultiplier = sConfigMgr->GetFloatDefault("VASAutoBalance.rate.mana", 1.0f);
        armorMultiplier = sConfigMgr->GetFloatDefault("VASAutoBalance.rate.armor", 1.0f);
        damageMultiplier = sConfigMgr->GetFloatDefault("VASAutoBalance.rate.damage", 1.0f);
        numPlayerConf=sConfigMgr->GetFloatDefault("VASAutoBalance.numPlayer", 1.0f);
        MinHPModifier = sConfigMgr->GetFloatDefault("VASAutoBalance.MinHPModifier", 0.1f);
        MinDamageModifier = sConfigMgr->GetFloatDefault("VASAutoBalance.MinDamageModifier", 0.1f);
    }
};

class VAS_AutoBalance_PlayerScript : public PlayerScript
{
    public:
        VAS_AutoBalance_PlayerScript()
            : PlayerScript("VAS_AutoBalance_PlayerScript")
        {
        }

        
        virtual void OnLevelChanged(Player* player, uint8 /*oldlevel*/) {
            if (!enabled || !player)
                return;

            if (LevelScaling == 0)
                return;

            AutoBalanceMapInfo *mapVasInfo=player->GetMap()->CustomData.GetDefault<AutoBalanceMapInfo>("VAS_AutoBalanceMapInfo");

            if (mapVasInfo->mapLevel < player->getLevel())
                mapVasInfo->mapLevel = player->getLevel();
        }
};

class VAS_AutoBalance_UnitScript : public UnitScript
{
    public:
    VAS_AutoBalance_UnitScript()
        : UnitScript("VAS_AutoBalance_UnitScript", true)
    {
    }

    uint32 DealDamage(Unit* AttackerUnit, Unit *playerVictim, uint32 damage, DamageEffectType /*damagetype*/) override
    {
        return VAS_Modifer_DealDamage(playerVictim, AttackerUnit, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage) override
    {
        damage = VAS_Modifer_DealDamage(target, attacker, damage);
    }

    void ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage) override
    {
        damage = VAS_Modifer_DealDamage(target, attacker, damage);
    }

    void ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage) override
    {
        damage = VAS_Modifer_DealDamage(target, attacker, damage);
    }

    void ModifyHealRecieved(Unit* target, Unit* attacker, uint32& damage) override {
        damage = VAS_Modifer_DealDamage(target, attacker, damage);
    }


    uint32 VAS_Modifer_DealDamage(Unit* target, Unit* attacker, uint32 damage)
    {
        if (!enabled)
            return damage;

        if (!attacker || attacker->GetTypeId() == TYPEID_PLAYER || !attacker->IsInWorld())
            return damage;

        float damageMultiplier = attacker->CustomData.GetDefault<AutoBalanceCreatureInfo>("VAS_AutoBalanceCreatureInfo")->DamageMultiplier;

        if (damageMultiplier == 1)
            return damage;

        if (!((DungeonsOnly < 1
                || (target->GetMap()->IsDungeon() && attacker->GetMap()->IsDungeon()) || (attacker->GetMap()->IsBattleground()
                     && target->GetMap()->IsBattleground()))))
            return damage;


        if ((attacker->IsHunterPet() || attacker->IsPet() || attacker->IsSummon()) && attacker->IsControlledByPlayer())
            return damage;

        return damage * damageMultiplier;
    }
};


class VAS_AutoBalance_AllMapScript : public AllMapScript
{
    public:
    VAS_AutoBalance_AllMapScript()
        : AllMapScript("VAS_AutoBalance_AllMapScript")
        {
        }

        void OnPlayerEnterAll(Map* map, Player* player)
        {
            if (!enabled)
                return;

            if (player->IsGameMaster())
                return;
            
            AutoBalanceMapInfo *mapVasInfo=map->CustomData.GetDefault<AutoBalanceMapInfo>("VAS_AutoBalanceMapInfo");

            // always check level, even if not conf enabled
            // because we can enable at runtime and we need this information
            if (player) {
                if (player->getLevel() > mapVasInfo->mapLevel)
                    mapVasInfo->mapLevel = player->getLevel();
            } else {
                Map::PlayerList const &playerList = map->GetPlayers();
                if (!playerList.isEmpty())
                {
                    for (Map::PlayerList::const_iterator playerIteration = playerList.begin(); playerIteration != playerList.end(); ++playerIteration)
                    {
                        if (Player* playerHandle = playerIteration->GetSource())
                        {
                            if (!playerHandle->IsGameMaster() && playerHandle->getLevel() > mapVasInfo->mapLevel)
                                mapVasInfo->mapLevel = playerHandle->getLevel();
                        }
                    }
                }
            }

            // mapVasInfo->playerCount++; (maybe we've to found a safe solution to avoid player recount each time)
            mapVasInfo->playerCount = map->GetPlayersCountExceptGMs();

            if (PlayerChangeNotify > 0)
            {
                if (map->GetEntry()->IsDungeon() && player)
                {
                    Map::PlayerList const &playerList = map->GetPlayers();
                    if (!playerList.isEmpty())
                    {
                        for (Map::PlayerList::const_iterator playerIteration = playerList.begin(); playerIteration != playerList.end(); ++playerIteration)
                        {
                            if (Player* playerHandle = playerIteration->GetSource())
                            {
                                ChatHandler chatHandle = ChatHandler(playerHandle->GetSession());
                                chatHandle.PSendSysMessage("|cffFF0000 [AutoBalance]|r|cffFF8000 %s entered the Instance %s. Auto setting player count to %u (Player Difficulty Offset = %u) |r", player->GetName().c_str(), map->GetMapName(), mapVasInfo->playerCount + PlayerCountDifficultyOffset, PlayerCountDifficultyOffset);
                            }
                        }
                    }
                }
            }
        }

        void OnPlayerLeaveAll(Map* map, Player* player)
        {
            if (!enabled)
                return;
            
            if (player->IsGameMaster())
                return;

            AutoBalanceMapInfo *mapVasInfo=map->CustomData.GetDefault<AutoBalanceMapInfo>("VAS_AutoBalanceMapInfo");

            // mapVasInfo->playerCount--; (maybe we've to found a safe solution to avoid player recount each time)
            mapVasInfo->playerCount = map->GetPlayersCountExceptGMs();

            // always check level, even if not conf enabled
            // because we can enable at runtime and we need this information
            if (!mapVasInfo->playerCount) {
                mapVasInfo->mapLevel = 0;
                return;
            }

            if (PlayerChangeNotify > 0)
            {
                if (map->GetEntry()->IsDungeon() && player)
                {
                    Map::PlayerList const &playerList = map->GetPlayers();
                    if (!playerList.isEmpty())
                    {
                        for (Map::PlayerList::const_iterator playerIteration = playerList.begin(); playerIteration != playerList.end(); ++playerIteration)
                        {
                            if (Player* playerHandle = playerIteration->GetSource())
                            {
                                ChatHandler chatHandle = ChatHandler(playerHandle->GetSession());
                                chatHandle.PSendSysMessage("|cffFF0000 [VAS-AutoBalance]|r|cffFF8000 %s left the Instance %s. Auto setting player count to %u (Player Difficulty Offset = %u) |r", player->GetName().c_str(), map->GetMapName(), mapVasInfo->playerCount, PlayerCountDifficultyOffset);
                            }
                        }
                    }
                }
            }
        }
};

class VAS_AutoBalance_AllCreatureScript : public AllCreatureScript
{
public:
    VAS_AutoBalance_AllCreatureScript()
        : AllCreatureScript("VAS_AutoBalance_AllCreatureScript")
    {
    }


    void Creature_SelectLevel(const CreatureTemplate* /*creatureTemplate*/, Creature* creature) override
    {
        if (!enabled)
            return;

        ModifyCreatureAttributes(creature, true);
    }

    void OnAllCreatureUpdate(Creature* creature, uint32 /*diff*/) override
    {
        if (!enabled)
            return;

        ModifyCreatureAttributes(creature);
    }

    bool checkLevelOffset(uint8 selectedLevel, uint8 targetLevel) {
        return selectedLevel && ((targetLevel >= selectedLevel && targetLevel <= (selectedLevel + higherOffset) ) || (targetLevel <= selectedLevel && targetLevel >= (selectedLevel - lowerOffset)));
    }

    void ModifyCreatureAttributes(Creature* creature, bool resetSelLevel = false)
    {
        if (!creature || !creature->GetMap())
            return;

        if (!creature->GetMap()->IsDungeon() && !creature->GetMap()->IsBattleground() && DungeonsOnly == 1)
            return;

        if (((creature->IsHunterPet() || creature->IsPet() || creature->IsSummon()) && creature->IsControlledByPlayer()))
        {
            return;
        }
        
        AutoBalanceMapInfo *mapVasInfo=creature->GetMap()->CustomData.GetDefault<AutoBalanceMapInfo>("VAS_AutoBalanceMapInfo");
        if (!mapVasInfo->mapLevel)
            return;

        CreatureTemplate const *creatureTemplate = creature->GetCreatureTemplate();

        AutoBalanceCreatureInfo *creatureVasInfo=creature->CustomData.GetDefault<AutoBalanceCreatureInfo>("VAS_AutoBalanceCreatureInfo");
        
        // force resetting selected level.
        // this is also a "workaround" to fix bug of not recalculated
        // attributes when UpdateEntry has been used.
        // TODO: It's better and faster to implement a core hook 
        // in that position and force a recalculation then
        if ((creatureVasInfo->entry != 0 && creatureVasInfo->entry != creature->GetEntry()) || resetSelLevel) {
            creatureVasInfo->selectedLevel = 0; // force a recalculation
        }

        if (!creature->IsAlive())
            return;

        uint32 curCount=mapVasInfo->playerCount + PlayerCountDifficultyOffset;

        uint8 bonusLevel = creatureTemplate->rank == CREATURE_ELITE_WORLDBOSS ? 3 : 0;
        // already scaled
        if (creatureVasInfo->selectedLevel > 0) {
            if (LevelScaling) {
                if (checkLevelOffset(mapVasInfo->mapLevel + bonusLevel, creature->getLevel()) &&
                    checkLevelOffset(creatureVasInfo->selectedLevel, creature->getLevel()) &&
                    creatureVasInfo->instancePlayerCount == curCount) {
                    return;
                }
            } else if (creatureVasInfo->instancePlayerCount == curCount) {
                    return;
            }
        }

        creatureVasInfo->instancePlayerCount = curCount;

        if (!creatureVasInfo->instancePlayerCount) // no players in map, do not modify attributes
            return;

        if (!sVasScriptMgr->OnBeforeModifyAttributes(creature, creatureVasInfo->instancePlayerCount))
            return;

        uint8 originalLevel = creatureTemplate->maxlevel;

        uint8 level = mapVasInfo->mapLevel;
        
        uint8 areaMinLvl, areaMaxLvl;
        getAreaLevel(creature->GetMap(), creature->GetAreaId(), areaMinLvl, areaMaxLvl);
        
        // avoid level changing for critters and special creatures (spell summons etc.) in instances
        bool skipLevel=false;
        if (originalLevel <= 1 && areaMinLvl >= 5)
            skipLevel = true;

        if (LevelScaling && creature->GetMap()->IsDungeon() && !skipLevel && !checkLevelOffset(level, originalLevel)) {  // change level only whithin the offsets and when in dungeon/raid
            if (level != creatureVasInfo->selectedLevel || creatureVasInfo->selectedLevel != creature->getLevel()) {
                // keep bosses +3 level
                creatureVasInfo->selectedLevel = level + bonusLevel;
                creature->SetLevel(creatureVasInfo->selectedLevel);
            }
        } else {
            creatureVasInfo->selectedLevel = creature->getLevel();
        }
        
        creatureVasInfo->entry = creature->GetEntry();

        bool useDefStats = false;
        if (LevelUseDb == 1 && creature->getLevel() >= creatureTemplate->minlevel && creature->getLevel() <= creatureTemplate->maxlevel)
            useDefStats = true;

        CreatureBaseStats const* origCreatureStats = sObjectMgr->GetCreatureBaseStats(originalLevel, creatureTemplate->unit_class);
        CreatureBaseStats const* creatureStats = sObjectMgr->GetCreatureBaseStats(creatureVasInfo->selectedLevel, creatureTemplate->unit_class);

        uint32 baseHealth = origCreatureStats->GenerateHealth(creatureTemplate);
        uint32 baseMana = origCreatureStats->GenerateMana(creatureTemplate);
        uint32 scaledHealth = 0;
        uint32 scaledMana = 0;
        
        uint32 maxNumberOfPlayers = ((InstanceMap*)sMapMgr->FindMap(creature->GetMapId(), creature->GetInstanceId()))->GetMaxPlayers();
        //   VAS SOLO  - By MobID
        if (GetForcedCreatureId(creatureTemplate->Entry) > 0)
        {
            maxNumberOfPlayers = GetForcedCreatureId(creatureTemplate->Entry); // Force maxNumberOfPlayers to be changed to match the Configuration entry.
        }

        // Note: InflectionPoint handle the number of players required to get 50% health.
        //       you'd adjust this to raise or lower the hp modifier for per additional player in a non-whole group.
        //
        //       diff modify the rate of percentage increase between
        //       number of players. Generally the closer to the value of 1 you have this
        //       the less gradual the rate will be. For example in a 5 man it would take 3
        //       total players to face a mob at full health.
        //
        //       The +1 and /2 values raise the TanH function to a positive range and make
        //       sure the modifier never goes above the value or 1.0 or below 0.
        //
        float defaultMultiplier = 1.0f;
        if (creatureVasInfo->instancePlayerCount < maxNumberOfPlayers) {
            float inflectionValue  = (float)maxNumberOfPlayers * InflectionPoint;
            float diff = ((float)maxNumberOfPlayers/5)*1.5f;
            defaultMultiplier = (tanh(((float)creatureVasInfo->instancePlayerCount - inflectionValue) / diff) + 1.0f) / 2.0f;
        }

        if (!sVasScriptMgr->OnAfterDefaultMultiplier(creature, defaultMultiplier))
            return;
        
        creatureVasInfo->HealthMultiplier =   healthMultiplier * defaultMultiplier * globalRate;
        
        if (creatureVasInfo->HealthMultiplier <= MinHPModifier)
        {
            creatureVasInfo->HealthMultiplier = MinHPModifier;
        }

        float hpStatsRate  = 1.0f;
        if (!useDefStats && LevelScaling && !skipLevel) {
            float newBaseHealth = 0;
            if (level <= 60)
                newBaseHealth=creatureStats->BaseHealth[0];
            else if(level <= 70)
                newBaseHealth=creatureStats->BaseHealth[1];
            else {
                newBaseHealth=creatureStats->BaseHealth[2];
                // special increasing for end-game contents
                if (LevelEndGameBoost == 1)
                    newBaseHealth *= creatureVasInfo->selectedLevel >= 75 && originalLevel < 75 ? float(creatureVasInfo->selectedLevel-70) * 0.3f : 1;
            }

            float newHealth =  newBaseHealth * creatureTemplate->ModHealth;

            // allows health to be different with creatures that originally
            // differentiate their health by different level instead of multiplier field.
            // expecially in dungeons. The health reduction decrease if original level is similar to the area max level
            if (originalLevel >= areaMinLvl && originalLevel < areaMaxLvl) {
                float reduction = newHealth / float(areaMaxLvl-areaMinLvl) * (float(areaMaxLvl-originalLevel)*0.3f); // never more than 30%
                if (reduction > 0 && reduction < newHealth)
                    newHealth -= reduction;
            }

            hpStatsRate = newHealth / float(baseHealth);
        }
        
        creatureVasInfo->HealthMultiplier *= hpStatsRate;
        
        scaledHealth = round(((float) baseHealth * creatureVasInfo->HealthMultiplier) + 1.0f);

        //Getting the list of Classes in this group - this will be used later on to determine what additional scaling will be required based on the ratio of tank/dps/healer
        //GetPlayerClassList(creature, playerClassList); // Update playerClassList with the list of all the participating Classes

        float manaStatsRate  = 1.0f;
        if (!useDefStats && LevelScaling && !skipLevel) {
            float newMana =  creatureStats->GenerateMana(creatureTemplate);
            manaStatsRate = newMana/float(baseMana);
        }

        creatureVasInfo->ManaMultiplier =  manaStatsRate * manaMultiplier * defaultMultiplier * globalRate;
        scaledMana = round(baseMana * creatureVasInfo->ManaMultiplier);

        float damageMul = defaultMultiplier * globalRate * damageMultiplier;
        
        // Can not be less then Min_D_Mod
        if (damageMul <= MinDamageModifier)
        {
            damageMul = MinDamageModifier;
        }
        
        if (!useDefStats && LevelScaling && !skipLevel) {
            float origDmgBase = origCreatureStats->GenerateBaseDamage(creatureTemplate);
            float newDmgBase = 0;
            if (level <= 60)
                newDmgBase=creatureStats->BaseDamage[0];
            else if(level <= 70)
                newDmgBase=creatureStats->BaseDamage[1];
            else {
                newDmgBase=creatureStats->BaseDamage[2];
                // special increasing for end-game contents
                if (LevelEndGameBoost == 1 && !creature->GetMap()->IsRaid())
                    newDmgBase *= creatureVasInfo->selectedLevel >= 75 && originalLevel < 75 ? float(creatureVasInfo->selectedLevel-70) * 0.3f : 1;
            }
            
            damageMul *= newDmgBase/origDmgBase;
        }

        creatureVasInfo->ArmorMultiplier = globalRate * armorMultiplier;
        uint32 newBaseArmor= round(creatureVasInfo->ArmorMultiplier * (useDefStats || !LevelScaling || skipLevel ? origCreatureStats->GenerateArmor(creatureTemplate) : creatureStats->GenerateArmor(creatureTemplate)));

        if (!sVasScriptMgr->OnBeforeUpdateStats(creature, scaledHealth, scaledMana, damageMul, newBaseArmor))
            return;
        
        uint32 prevMaxHealth = creature->GetMaxHealth();
        uint32 prevMaxPower = creature->GetMaxPower(POWER_MANA);
        uint32 prevHealth = creature->GetHealth();
        uint32 prevPower = creature->GetPower(POWER_MANA);
        
        Powers pType= creature->getPowerType();

        creature->SetArmor(newBaseArmor);
        creature->SetModifierValue(UNIT_MOD_ARMOR, BASE_VALUE, (float)newBaseArmor);
        creature->SetCreateHealth(scaledHealth);
        creature->SetMaxHealth(scaledHealth);
        creature->ResetPlayerDamageReq();
        creature->SetCreateMana(scaledMana);
        creature->SetMaxPower(POWER_MANA, scaledMana);
        creature->SetModifierValue(UNIT_MOD_ENERGY, BASE_VALUE, (float)100.0f);
        creature->SetModifierValue(UNIT_MOD_RAGE, BASE_VALUE, (float)100.0f);
        creature->SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, (float)scaledHealth);
        creature->SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, (float)scaledMana);
        creatureVasInfo->DamageMultiplier = damageMul;

        uint32 scaledCurHealth=prevHealth && prevMaxHealth ? float(scaledHealth)/float(prevMaxHealth)*float(prevHealth) : 0;
        uint32 scaledCurPower=prevPower && prevMaxPower  ? float(scaledMana)/float(prevMaxPower)*float(prevPower) : 0;
        
        creature->SetHealth(scaledCurHealth);
        if (pType == POWER_MANA)
            creature->SetPower(POWER_MANA, scaledCurPower);
        else
            creature->setPowerType(pType); // fix creatures with different power types

        creature->UpdateAllStats();
    }
};
class VAS_AutoBalance_CommandScript : public CommandScript
{
public:
    VAS_AutoBalance_CommandScript() : CommandScript("VAS_AutoBalance_CommandScript") { }

    std::vector<ChatCommand> GetCommands() const
    {
        static std::vector<ChatCommand> vasCommandTable =
        {
            { "setoffset",        SEC_GAMEMASTER,                        true, &HandleVasSetOffsetCommand,                 "Sets the global Player Difficulty Offset for instances. Example: (You + offset(1) = 2 player difficulty)." },
            { "getoffset",        SEC_GAMEMASTER,                        true, &HandleVasGetOffsetCommand,                 "Shows current global player offset value" },
            { "checkmap",         SEC_GAMEMASTER,                        true, &HandleVasCheckMapCommand,                  "Run a check for current map/instance, it can help in case you're testing vas with GM." },
            { "mapstat",          SEC_GAMEMASTER,                        true, &HandleVasMapStatsCommand,                  "Shows current vas information for this map-" },
            { "creaturestat",     SEC_GAMEMASTER,                        true, &HandleVasCreatureStatsCommand,             "Shows current vas information for selected creature." },
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "vas",     SEC_GAMEMASTER,                            false, NULL,                      "", vasCommandTable },
        };
        return commandTable;
    }

    static bool HandleVasSetOffsetCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
        {
            handler->PSendSysMessage(".vas setoffset #");
            handler->PSendSysMessage("Sets the Player Difficulty Offset for instances. Example: (You + offset(1) = 2 player difficulty).");
            return false;
        }
        char* offset = strtok((char*)args, " ");
        int32 offseti = -1;

        if (offset)
        {
            offseti = (uint32)atoi(offset);
            handler->PSendSysMessage("Changing Player Difficulty Offset to %i.", offseti);
            PlayerCountDifficultyOffset = offseti;
            return true;
        }
        else
            handler->PSendSysMessage("Error changing Player Difficulty Offset! Please try again.");
        return false;
    }

    static bool HandleVasGetOffsetCommand(ChatHandler* handler, const char* /*args*/)
    {
        handler->PSendSysMessage("Current Player Difficulty Offset = %i", PlayerCountDifficultyOffset);
        return true;
    }

    static bool HandleVasCheckMapCommand(ChatHandler* handler, const char* args)
    {
        Player *pl = handler->getSelectedPlayer();

        if (!pl)
        {
            handler->SendSysMessage(LANG_SELECT_PLAYER_OR_PET);
            handler->SetSentErrorMessage(true);
            return false;
        }

        AutoBalanceMapInfo *mapVasInfo=pl->GetMap()->CustomData.GetDefault<AutoBalanceMapInfo>("VAS_AutoBalanceMapInfo");

        mapVasInfo->playerCount = pl->GetMap()->GetPlayersCountExceptGMs();

        Map::PlayerList const &playerList = pl->GetMap()->GetPlayers();
        uint8 level = 0;
        if (!playerList.isEmpty())
        {
            for (Map::PlayerList::const_iterator playerIteration = playerList.begin(); playerIteration != playerList.end(); ++playerIteration)
            {
                if (Player* playerHandle = playerIteration->GetSource())
                {
                    if (playerHandle->getLevel() > level)
                        mapVasInfo->mapLevel = level = playerHandle->getLevel();
                }
            }
        }

        HandleVasMapStatsCommand(handler, args);

        return true;
    }

    static bool HandleVasMapStatsCommand(ChatHandler* handler, const char* /*args*/)
    {
        Player *pl = handler->getSelectedPlayer();

        if (!pl)
        {
            handler->SendSysMessage(LANG_SELECT_PLAYER_OR_PET);
            handler->SetSentErrorMessage(true);
            return false;
        }

        AutoBalanceMapInfo *mapVasInfo=pl->GetMap()->CustomData.GetDefault<AutoBalanceMapInfo>("VAS_AutoBalanceMapInfo");

        handler->PSendSysMessage("Players on map: %u", mapVasInfo->playerCount);
        handler->PSendSysMessage("Max level of players in this map: %u", mapVasInfo->mapLevel);

        return true;
    }

    static bool HandleVasCreatureStatsCommand(ChatHandler* handler, const char* /*args*/)
    {
        Creature* target = handler->getSelectedCreature();

        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        AutoBalanceCreatureInfo *creatureVasInfo=target->CustomData.GetDefault<AutoBalanceCreatureInfo>("VAS_AutoBalanceCreatureInfo");

        handler->PSendSysMessage("Instance player Count: %u", creatureVasInfo->instancePlayerCount);
        handler->PSendSysMessage("Selected level: %u", creatureVasInfo->selectedLevel);
        handler->PSendSysMessage("Damage multiplier: %.6f", creatureVasInfo->DamageMultiplier);
        handler->PSendSysMessage("Health multiplier: %.6f", creatureVasInfo->HealthMultiplier);
        handler->PSendSysMessage("Mana multiplier: %.6f", creatureVasInfo->ManaMultiplier);
        handler->PSendSysMessage("Armor multiplier: %.6f", creatureVasInfo->ArmorMultiplier);

        return true;

    }
};

class VAS_AutoBalance_GlobalScript : public GlobalScript {
public:
    VAS_AutoBalance_GlobalScript() : GlobalScript("VAS_AutoBalance_GlobalScript") { }
    
    void OnAfterUpdateEncounterState(Map* map, EncounterCreditType type,  uint32 /*creditEntry*/, Unit* source, Difficulty /*difficulty_fixed*/, DungeonEncounterList const* /*encounters*/, uint32 /*dungeonCompleted*/, bool updated) override {
        //if (!dungeonCompleted)
        //    return;

        if (!rewardEnabled || !updated)
            return;

        if (map->GetPlayersCountExceptGMs() < MinPlayerReward)
            return;
        
        AutoBalanceMapInfo *mapVasInfo=map->CustomData.GetDefault<AutoBalanceMapInfo>("VAS_AutoBalanceMapInfo");
        
        uint8 areaMinLvl, areaMaxLvl;
        getAreaLevel(map, source->GetAreaId(), areaMinLvl, areaMaxLvl);

        // skip if it's not a pre-wotlk dungeon/raid and if it's not scaled
        if (!LevelScaling || lowerOffset >= 10 || mapVasInfo->mapLevel <= 70 || areaMinLvl > 70
            // skip when not in dungeon or not kill credit
            || type != ENCOUNTER_CREDIT_KILL_CREATURE || !map->IsDungeon())
            return;

        Map::PlayerList const &playerList = map->GetPlayers();

        if (playerList.isEmpty())
            return;

        uint32 reward = map->IsRaid() ? rewardRaid : rewardDungeon;
        if (!reward)
            return;

        //instanceStart=0, endTime;
        uint8 difficulty = map->GetDifficulty();

        for (Map::PlayerList::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
        {
            if (!itr->GetSource() || itr->GetSource()->IsGameMaster() || itr->GetSource()->getLevel() < DEFAULT_MAX_LEVEL)
                continue;
            
            itr->GetSource()->AddItem(reward, 1 + difficulty); // difficulty boost
        }
    }
};



void AddVASAutoBalanceScripts()
{
    new VAS_AutoBalance_WorldScript;
    new VAS_AutoBalance_PlayerScript;
    new VAS_AutoBalance_UnitScript;
    new VAS_AutoBalance_AllCreatureScript;
    new VAS_AutoBalance_AllMapScript;
    new VAS_AutoBalance_CommandScript;
    new VAS_AutoBalance_GlobalScript;
}
