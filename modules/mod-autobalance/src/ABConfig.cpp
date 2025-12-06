/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#include "ABConfig.h"
#include "ABUtils.h"

std::map <int, int> forcedCreatureIds;
std::list<uint32> disabledDungeonIds;

uint32 minPlayersNormal;
uint32 minPlayersHeroic;
uint32 minPlayersRaid;
uint32 minPlayersRaidHeroic;
std::map<uint32, uint8> minPlayersPerDungeonIdMap;
std::map<uint32, uint8> minPlayersPerHeroicDungeonIdMap;

std::map<uint32, AutoBalanceInflectionPointSettings> dungeonOverrides;
std::map<uint32, AutoBalanceInflectionPointSettings> bossOverrides;
std::map<uint32, AutoBalanceStatModifiers> statModifierOverrides;
std::map<uint32, AutoBalanceStatModifiers> statModifierBossOverrides;
std::map<uint32, AutoBalanceStatModifiers> statModifierCreatureOverrides;
std::map<uint8, AutoBalanceLevelScalingDynamicLevelSettings> levelScalingDynamicLevelOverrides;
std::map<uint32, uint32> levelScalingDistanceCheckOverrides;

// spell IDs that spend player health
// player abilities don't actually appear to be caught by `ModifySpellDamageTaken`,
// but I'm leaving them here in case they ever DO get caught by it
std::list<uint32> spellIdsThatSpendPlayerHealth =
{
    45529,      // Blood Tap
    2687,       // Bloodrage
    27869,      // Dark Rune
    16666,      // Demonic Rune
    755,        // Health Funnel (Rank 1)
    3698,       // Health Funnel (Rank 2)
    3699,       // Health Funnel (Rank 3)
    3700,       // Health Funnel (Rank 4)
    11693,      // Health Funnel (Rank 5)
    11694,      // Health Funnel (Rank 6)
    11695,      // Health Funnel (Rank 7)
    27259,      // Health Funnel (Rank 8)
    47856,      // Health Funnel (Rank 9)
    1454,       // Life Tap (Rank 1)
    1455,       // Life Tap (Rank 2)
    1456,       // Life Tap (Rank 3)
    11687,      // Life Tap (Rank 4)
    11688,      // Life Tap (Rank 5)
    11689,      // Life Tap (Rank 6)
    27222,      // Life Tap (Rank 7)
    57946,      // Life Tap (Rank 8)
    29858,      // Soulshatter
    55213       // Unholy Frenzy
};

// spell IDs that should never be modified
// handles cases where a spell is reflecting damage or otherwise converting player damage to something else
std::list<uint32> spellIdsToNeverModify =
{
    1177        // Twin Empathy (AQ40 Twin Emperors, only in `spell_dbc` database table)
};

// creature IDs that should never be considered clones
// handles cases where a creature is spawned by another creature, but is not a clone (doesn't retain health/mana values)
std::list<uint32> creatureIDsThatAreNotClones =
{
    16152       // Attumen the Huntsman (Karazhan) combined form
};

int8          PlayerCountDifficultyOffset;

bool          LevelScaling;
int8          LevelScalingSkipHigherLevels;
int8          LevelScalingSkipLowerLevels;
int8          LevelScalingDynamicLevelCeilingDungeons;
int8          LevelScalingDynamicLevelFloorDungeons;
int8          LevelScalingDynamicLevelCeilingRaids;
int8          LevelScalingDynamicLevelFloorRaids;
int8          LevelScalingDynamicLevelCeilingHeroicDungeons;
int8          LevelScalingDynamicLevelFloorHeroicDungeons;
int8          LevelScalingDynamicLevelCeilingHeroicRaids;
int8          LevelScalingDynamicLevelFloorHeroicRaids;
ScalingMethod LevelScalingMethod;

uint32        rewardRaid;
uint32        rewardDungeon;
uint32        MinPlayerReward;

bool          Announcement;

bool          LevelScalingEndGameBoost;
bool          PlayerChangeNotify;
bool          rewardEnabled;

float         MinHPModifier;
float         MinManaModifier;
float         MinDamageModifier;
float         MinCCDurationModifier;
float         MaxCCDurationModifier;

//
// RewardScaling.*
//

ScalingMethod RewardScalingMethod;
bool          RewardScalingXP;
bool          RewardScalingMoney;
float         RewardScalingXPModifier;
float         RewardScalingMoneyModifier;

uint64_t      globalConfigTime = GetCurrentConfigTime();

//
// Enable.*
//

bool          EnableGlobal;
bool          Enable5M;
bool          Enable10M;
bool          Enable15M;
bool          Enable20M;
bool          Enable25M;
bool          Enable40M;
bool          Enable5MHeroic;
bool          Enable10MHeroic;
bool          Enable25MHeroic;
bool          EnableOtherNormal;
bool          EnableOtherHeroic;

//
// InflectionPoint*
//

float         InflectionPoint;
float         InflectionPointCurveFloor;
float         InflectionPointCurveCeiling;
float         InflectionPointBoss;

float         InflectionPointHeroic;
float         InflectionPointHeroicCurveFloor;
float         InflectionPointHeroicCurveCeiling;
float         InflectionPointHeroicBoss;

float         InflectionPointRaid;
float         InflectionPointRaidCurveFloor;
float         InflectionPointRaidCurveCeiling;
float         InflectionPointRaidBoss;

float         InflectionPointRaidHeroic;
float         InflectionPointRaidHeroicCurveFloor;
float         InflectionPointRaidHeroicCurveCeiling;
float         InflectionPointRaidHeroicBoss;

float         InflectionPointRaid10M;
float         InflectionPointRaid10MCurveFloor;
float         InflectionPointRaid10MCurveCeiling;
float         InflectionPointRaid10MBoss;

float         InflectionPointRaid10MHeroic;
float         InflectionPointRaid10MHeroicCurveFloor;
float         InflectionPointRaid10MHeroicCurveCeiling;
float         InflectionPointRaid10MHeroicBoss;

float         InflectionPointRaid15M;
float         InflectionPointRaid15MCurveFloor;
float         InflectionPointRaid15MCurveCeiling;
float         InflectionPointRaid15MBoss;

float         InflectionPointRaid20M;
float         InflectionPointRaid20MCurveFloor;
float         InflectionPointRaid20MCurveCeiling;
float         InflectionPointRaid20MBoss;

float         InflectionPointRaid25M;
float         InflectionPointRaid25MCurveFloor;
float         InflectionPointRaid25MCurveCeiling;
float         InflectionPointRaid25MBoss;

float         InflectionPointRaid25MHeroic;
float         InflectionPointRaid25MHeroicCurveFloor;
float         InflectionPointRaid25MHeroicCurveCeiling;
float         InflectionPointRaid25MHeroicBoss;

float         InflectionPointRaid40M;
float         InflectionPointRaid40MCurveFloor;
float         InflectionPointRaid40MCurveCeiling;
float         InflectionPointRaid40MBoss;

//
// StatModifier*
//

float         StatModifier_Global;
float         StatModifier_Health;
float         StatModifier_Mana;
float         StatModifier_Armor;
float         StatModifier_Damage;
float         StatModifier_CCDuration;

float         StatModifierHeroic_Global;
float         StatModifierHeroic_Health;
float         StatModifierHeroic_Mana;
float         StatModifierHeroic_Armor;
float         StatModifierHeroic_Damage;
float         StatModifierHeroic_CCDuration;

float         StatModifierRaid_Global;
float         StatModifierRaid_Health;
float         StatModifierRaid_Mana;
float         StatModifierRaid_Armor;
float         StatModifierRaid_Damage;
float         StatModifierRaid_CCDuration;

float         StatModifierRaidHeroic_Global;
float         StatModifierRaidHeroic_Health;
float         StatModifierRaidHeroic_Mana;
float         StatModifierRaidHeroic_Armor;
float         StatModifierRaidHeroic_Damage;
float         StatModifierRaidHeroic_CCDuration;

float         StatModifierRaid10M_Global;
float         StatModifierRaid10M_Health;
float         StatModifierRaid10M_Mana;
float         StatModifierRaid10M_Armor;
float         StatModifierRaid10M_Damage;
float         StatModifierRaid10M_CCDuration;

float         StatModifierRaid10MHeroic_Global;
float         StatModifierRaid10MHeroic_Health;
float         StatModifierRaid10MHeroic_Mana;
float         StatModifierRaid10MHeroic_Armor;
float         StatModifierRaid10MHeroic_Damage;
float         StatModifierRaid10MHeroic_CCDuration;

float         StatModifierRaid15M_Global;
float         StatModifierRaid15M_Health;
float         StatModifierRaid15M_Mana;
float         StatModifierRaid15M_Armor;
float         StatModifierRaid15M_Damage;
float         StatModifierRaid15M_CCDuration;

float         StatModifierRaid20M_Global;
float         StatModifierRaid20M_Health;
float         StatModifierRaid20M_Mana;
float         StatModifierRaid20M_Armor;
float         StatModifierRaid20M_Damage;
float         StatModifierRaid20M_CCDuration;

float         StatModifierRaid25M_Global;
float         StatModifierRaid25M_Health;
float         StatModifierRaid25M_Mana;
float         StatModifierRaid25M_Armor;
float         StatModifierRaid25M_Damage;
float         StatModifierRaid25M_CCDuration;

float         StatModifierRaid25MHeroic_Global;
float         StatModifierRaid25MHeroic_Health;
float         StatModifierRaid25MHeroic_Mana;
float         StatModifierRaid25MHeroic_Armor;
float         StatModifierRaid25MHeroic_Damage;
float         StatModifierRaid25MHeroic_CCDuration;

float         StatModifierRaid40M_Global;
float         StatModifierRaid40M_Health;
float         StatModifierRaid40M_Mana;
float         StatModifierRaid40M_Armor;
float         StatModifierRaid40M_Damage;
float         StatModifierRaid40M_CCDuration;

//
// StatModifier* (Boss)
//

float         StatModifier_Boss_Global;
float         StatModifier_Boss_Health;
float         StatModifier_Boss_Mana;
float         StatModifier_Boss_Armor;
float         StatModifier_Boss_Damage;
float         StatModifier_Boss_CCDuration;

float         StatModifierHeroic_Boss_Global;
float         StatModifierHeroic_Boss_Health;
float         StatModifierHeroic_Boss_Mana;
float         StatModifierHeroic_Boss_Armor;
float         StatModifierHeroic_Boss_Damage;
float         StatModifierHeroic_Boss_CCDuration;

float         StatModifierRaid_Boss_Global;
float         StatModifierRaid_Boss_Health;
float         StatModifierRaid_Boss_Mana;
float         StatModifierRaid_Boss_Armor;
float         StatModifierRaid_Boss_Damage;
float         StatModifierRaid_Boss_CCDuration;

float         StatModifierRaidHeroic_Boss_Global;
float         StatModifierRaidHeroic_Boss_Health;
float         StatModifierRaidHeroic_Boss_Mana;
float         StatModifierRaidHeroic_Boss_Armor;
float         StatModifierRaidHeroic_Boss_Damage;
float         StatModifierRaidHeroic_Boss_CCDuration;

float         StatModifierRaid10M_Boss_Global;
float         StatModifierRaid10M_Boss_Health;
float         StatModifierRaid10M_Boss_Mana;
float         StatModifierRaid10M_Boss_Armor;
float         StatModifierRaid10M_Boss_Damage;
float         StatModifierRaid10M_Boss_CCDuration;

float         StatModifierRaid10MHeroic_Boss_Global;
float         StatModifierRaid10MHeroic_Boss_Health;
float         StatModifierRaid10MHeroic_Boss_Mana;
float         StatModifierRaid10MHeroic_Boss_Armor;
float         StatModifierRaid10MHeroic_Boss_Damage;
float         StatModifierRaid10MHeroic_Boss_CCDuration;

float         StatModifierRaid15M_Boss_Global;
float         StatModifierRaid15M_Boss_Health;
float         StatModifierRaid15M_Boss_Mana;
float         StatModifierRaid15M_Boss_Armor;
float         StatModifierRaid15M_Boss_Damage;
float         StatModifierRaid15M_Boss_CCDuration;

float         StatModifierRaid20M_Boss_Global;
float         StatModifierRaid20M_Boss_Health;
float         StatModifierRaid20M_Boss_Mana;
float         StatModifierRaid20M_Boss_Armor;
float         StatModifierRaid20M_Boss_Damage;
float         StatModifierRaid20M_Boss_CCDuration;

float         StatModifierRaid25M_Boss_Global;
float         StatModifierRaid25M_Boss_Health;
float         StatModifierRaid25M_Boss_Mana;
float         StatModifierRaid25M_Boss_Armor;
float         StatModifierRaid25M_Boss_Damage;
float         StatModifierRaid25M_Boss_CCDuration;

float         StatModifierRaid25MHeroic_Boss_Global;
float         StatModifierRaid25MHeroic_Boss_Health;
float         StatModifierRaid25MHeroic_Boss_Mana;
float         StatModifierRaid25MHeroic_Boss_Armor;
float         StatModifierRaid25MHeroic_Boss_Damage;
float         StatModifierRaid25MHeroic_Boss_CCDuration;

float         StatModifierRaid40M_Boss_Global;
float         StatModifierRaid40M_Boss_Health;
float         StatModifierRaid40M_Boss_Mana;
float         StatModifierRaid40M_Boss_Armor;
float         StatModifierRaid40M_Boss_Damage;
float         StatModifierRaid40M_Boss_CCDuration;
