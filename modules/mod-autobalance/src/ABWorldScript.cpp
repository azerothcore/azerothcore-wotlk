#include "ABWorldScript.h"

#include "ABConfig.h"
#include "ABUtils.h"

#include "Configuration/Config.h"
#include "Log.h"

void AutoBalance_WorldScript::OnBeforeConfigLoad(bool /*reload*/)
{
    SetInitialWorldSettings();
    globalConfigTime = GetCurrentConfigTime();

    LOG_INFO("module.AutoBalance", "AutoBalance::OnBeforeConfigLoad: Config loaded. Global config time set to ({}).", globalConfigTime);
}

void AutoBalance_WorldScript::SetInitialWorldSettings()
{
    forcedCreatureIds.clear();
    disabledDungeonIds.clear();
    dungeonOverrides.clear();
    bossOverrides.clear();
    statModifierOverrides.clear();
    statModifierBossOverrides.clear();
    statModifierCreatureOverrides.clear();
    levelScalingDynamicLevelOverrides.clear();
    levelScalingDistanceCheckOverrides.clear();

    LoadForcedCreatureIdsFromString(sConfigMgr->GetOption<std::string>("AutoBalance.ForcedID40", ""), 40);
    LoadForcedCreatureIdsFromString(sConfigMgr->GetOption<std::string>("AutoBalance.ForcedID25", ""), 25);
    LoadForcedCreatureIdsFromString(sConfigMgr->GetOption<std::string>("AutoBalance.ForcedID10", ""), 10);
    LoadForcedCreatureIdsFromString(sConfigMgr->GetOption<std::string>("AutoBalance.ForcedID5" , ""), 5);
    LoadForcedCreatureIdsFromString(sConfigMgr->GetOption<std::string>("AutoBalance.ForcedID2" , ""), 2);
    LoadForcedCreatureIdsFromString(sConfigMgr->GetOption<std::string>("AutoBalance.DisabledID", ""), 0);

    //
    // Disabled Dungeon IDs
    //

    disabledDungeonIds = LoadDisabledDungeons(sConfigMgr->GetOption<std::string>("AutoBalance.Disable.PerInstance", ""));

    //
    // Min Players
    //

    minPlayersNormal = sConfigMgr->GetOption<int>("AutoBalance.MinPlayers", 1);
    minPlayersHeroic = sConfigMgr->GetOption<int>("AutoBalance.MinPlayers.Heroic", 1);
    minPlayersRaid = sConfigMgr->GetOption<int>("AutoBalance.MinPlayers.Raid", minPlayersNormal);
    minPlayersRaidHeroic = sConfigMgr->GetOption<int>("AutoBalance.MinPlayers.RaidHeroic", minPlayersHeroic);

    if (sConfigMgr->GetOption<float>("AutoBalance.PerDungeonPlayerCounts", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.PerDungeonPlayerCounts` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");

    minPlayersPerDungeonIdMap = LoadMinPlayersPerDungeonId(
        sConfigMgr->GetOption<std::string>("AutoBalance.MinPlayers.PerInstance",
        sConfigMgr->GetOption<std::string>("AutoBalance.PerDungeonPlayerCounts", "", false), false)); // `AutoBalance.PerDungeonPlayerCounts` for backwards compatibility

    minPlayersPerHeroicDungeonIdMap = LoadMinPlayersPerDungeonId(
        sConfigMgr->GetOption<std::string>("AutoBalance.MinPlayers.Heroic.PerInstance",
        sConfigMgr->GetOption<std::string>("AutoBalance.PerDungeonPlayerCounts", "", false), false)); // `AutoBalance.PerDungeonPlayerCounts` for backwards compatibility

    //
    // Overrides
    //

    if (sConfigMgr->GetOption<float>("AutoBalance.PerDungeonScaling", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.PerDungeonScaling` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");

    dungeonOverrides = LoadInflectionPointOverrides(
        sConfigMgr->GetOption<std::string>("AutoBalance.InflectionPoint.PerInstance",
        sConfigMgr->GetOption<std::string>("AutoBalance.PerDungeonScaling", "", false), false)); // `AutoBalance.PerDungeonScaling` for backwards compatibility

    if (sConfigMgr->GetOption<float>("AutoBalance.PerDungeonBossScaling", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.PerDungeonBossScaling` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");

    bossOverrides = LoadInflectionPointOverrides(
        sConfigMgr->GetOption<std::string>("AutoBalance.InflectionPoint.Boss.PerInstance",
        sConfigMgr->GetOption<std::string>("AutoBalance.PerDungeonBossScaling", "", false), false)); // `AutoBalance.PerDungeonBossScaling` for backwards compatibility

    statModifierOverrides = LoadStatModifierOverrides(
        sConfigMgr->GetOption<std::string>("AutoBalance.StatModifier.PerInstance", "", false));

    statModifierBossOverrides = LoadStatModifierOverrides(
        sConfigMgr->GetOption<std::string>("AutoBalance.StatModifier.Boss.PerInstance", "", false));

    statModifierCreatureOverrides = LoadStatModifierOverrides(
        sConfigMgr->GetOption<std::string>("AutoBalance.StatModifier.PerCreature", "", false));

    levelScalingDynamicLevelOverrides = LoadDynamicLevelOverrides(
        sConfigMgr->GetOption<std::string>("AutoBalance.LevelScaling.DynamicLevel.PerInstance", "", false));

    levelScalingDistanceCheckOverrides = LoadDistanceCheckOverrides(
        sConfigMgr->GetOption<std::string>("AutoBalance.LevelScaling.DynamicLevel.DistanceCheck.PerInstance", "", false));

    //
    // AutoBalance.Enable.*
    // Deprecated setting warning
    //
    if (sConfigMgr->GetOption<int>("AutoBalance.enable", -1, false) != -1)
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.enable` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");

    EnableGlobal      = sConfigMgr->GetOption<bool>("AutoBalance.Enable.Global"     , sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false)); // `AutoBalance.enable` for backwards compatibility

    Enable5M          = sConfigMgr->GetOption<bool>("AutoBalance.Enable.5M"         , sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false));
    Enable10M         = sConfigMgr->GetOption<bool>("AutoBalance.Enable.10M"        , sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false));
    Enable15M         = sConfigMgr->GetOption<bool>("AutoBalance.Enable.15M"        , sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false));
    Enable20M         = sConfigMgr->GetOption<bool>("AutoBalance.Enable.20M"        , sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false));
    Enable25M         = sConfigMgr->GetOption<bool>("AutoBalance.Enable.25M"        , sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false));
    Enable40M         = sConfigMgr->GetOption<bool>("AutoBalance.Enable.40M"        , sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false));
    EnableOtherNormal = sConfigMgr->GetOption<bool>("AutoBalance.Enable.OtherNormal", sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false));

    Enable5MHeroic    = sConfigMgr->GetOption<bool>("AutoBalance.Enable.5MHeroic"   , sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false));
    Enable10MHeroic   = sConfigMgr->GetOption<bool>("AutoBalance.Enable.10MHeroic"  , sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false));
    Enable25MHeroic   = sConfigMgr->GetOption<bool>("AutoBalance.Enable.25MHeroic"  , sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false));
    EnableOtherHeroic = sConfigMgr->GetOption<bool>("AutoBalance.Enable.OtherHeroic", sConfigMgr->GetOption<bool>("AutoBalance.enable", 1, false));

    //
    // Deprecated setting warning
    //

    if (sConfigMgr->GetOption<int>("AutoBalance.DungeonsOnly", -1, false) != -1)
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.DungeonsOnly` defined in `AutoBalance.conf`. This variable has been removed and has no effect. Please see `AutoBalance.conf.dist` for more details.");

    if (sConfigMgr->GetOption<int>("AutoBalance.levelUseDbValuesWhenExists", -1, false) != -1)
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.levelUseDbValuesWhenExists` defined in `AutoBalance.conf`. This variable has been removed and has no effect. Please see `AutoBalance.conf.dist` for more details.");

    //
    // Misc Settings
    // TODO: Organize and standardize variable names
    //

    PlayerChangeNotify          = sConfigMgr->GetOption<bool>  ("AutoBalance.PlayerChangeNotify", 1);

    rewardEnabled               = sConfigMgr->GetOption<bool>  ("AutoBalance.reward.enable", 1);
    PlayerCountDifficultyOffset = sConfigMgr->GetOption<uint32>("AutoBalance.playerCountDifficultyOffset", 0);
    rewardRaid                  = sConfigMgr->GetOption<uint32>("AutoBalance.reward.raidToken", 49426);
    rewardDungeon               = sConfigMgr->GetOption<uint32>("AutoBalance.reward.dungeonToken", 47241);
    MinPlayerReward             = sConfigMgr->GetOption<float> ("AutoBalance.reward.MinPlayerReward", 1);

    //
    // InflectionPoint*
    // warn the console if deprecated values are detected
    //

    if (sConfigMgr->GetOption<float>("AutoBalance.BossInflectionMult", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.BossInflectionMult` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");

    InflectionPoint                          = sConfigMgr->GetOption<float>("AutoBalance.InflectionPoint", 0.5f, false);
    InflectionPointCurveFloor                = sConfigMgr->GetOption<float>("AutoBalance.InflectionPoint.CurveFloor", 0.0f, false);
    InflectionPointCurveCeiling              = sConfigMgr->GetOption<float>("AutoBalance.InflectionPoint.CurveCeiling", 1.0f, false);
    InflectionPointBoss                      = sConfigMgr->GetOption<float>("AutoBalance.InflectionPoint.BossModifier", sConfigMgr->GetOption<float>("AutoBalance.BossInflectionMult", 1.0f, false), false); // `AutoBalance.BossInflectionMult` for backwards compatibility

    InflectionPointHeroic                    = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointHeroic", 0.5f, false);
    InflectionPointHeroicCurveFloor          = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointHeroic.CurveFloor", 0.0f, false);
    InflectionPointHeroicCurveCeiling        = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointHeroic.CurveCeiling", 1.0f, false);
    InflectionPointHeroicBoss                = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointHeroic.BossModifier", sConfigMgr->GetOption<float>("AutoBalance.BossInflectionMult", 1.0f, false), false); // `AutoBalance.BossInflectionMult` for backwards compatibility

    InflectionPointRaid                      = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid", 0.5f, false);
    InflectionPointRaidCurveFloor            = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid.CurveFloor", 0.0f, false);
    InflectionPointRaidCurveCeiling          = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid.CurveCeiling", 1.0f, false);
    InflectionPointRaidBoss                  = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid.BossModifier", sConfigMgr->GetOption<float>("AutoBalance.BossInflectionMult", 1.0f, false), false); // `AutoBalance.BossInflectionMult` for backwards compatibility

    InflectionPointRaidHeroic                = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaidHeroic", 0.5f, false);
    InflectionPointRaidHeroicCurveFloor      = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaidHeroic.CurveFloor", 0.0f, false);
    InflectionPointRaidHeroicCurveCeiling    = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaidHeroic.CurveCeiling", 1.0f, false);
    InflectionPointRaidHeroicBoss            = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaidHeroic.BossModifier", sConfigMgr->GetOption<float>("AutoBalance.BossInflectionMult", 1.0f, false), false); // `AutoBalance.BossInflectionMult` for backwards compatibility

    InflectionPointRaid10M                   = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid10M", InflectionPointRaid, false);
    InflectionPointRaid10MCurveFloor         = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid10M.CurveFloor", InflectionPointRaidCurveFloor, false);
    InflectionPointRaid10MCurveCeiling       = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid10M.CurveCeiling", InflectionPointRaidCurveCeiling, false);
    InflectionPointRaid10MBoss               = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid10M.BossModifier", InflectionPointRaidBoss, false);

    InflectionPointRaid10MHeroic             = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid10MHeroic", InflectionPointRaidHeroic, false);
    InflectionPointRaid10MHeroicCurveFloor   = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid10MHeroic.CurveFloor", InflectionPointRaidHeroicCurveFloor, false);
    InflectionPointRaid10MHeroicCurveCeiling = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid10MHeroic.CurveCeiling", InflectionPointRaidHeroicCurveCeiling, false);
    InflectionPointRaid10MHeroicBoss         = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid10MHeroic.BossModifier", InflectionPointRaidHeroicBoss, false);

    InflectionPointRaid15M                   = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid15M", InflectionPointRaid, false);
    InflectionPointRaid15MCurveFloor         = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid15M.CurveFloor", InflectionPointRaidCurveFloor, false);
    InflectionPointRaid15MCurveCeiling       = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid15M.CurveCeiling", InflectionPointRaidCurveCeiling, false);
    InflectionPointRaid15MBoss               = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid15M.BossModifier", InflectionPointRaidBoss, false);

    InflectionPointRaid20M                   = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid20M", InflectionPointRaid, false);
    InflectionPointRaid20MCurveFloor         = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid20M.CurveFloor", InflectionPointRaidCurveFloor, false);
    InflectionPointRaid20MCurveCeiling       = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid20M.CurveCeiling", InflectionPointRaidCurveCeiling, false);
    InflectionPointRaid20MBoss               = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid20M.BossModifier", InflectionPointRaidBoss, false);

    InflectionPointRaid25M                   = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid25M", InflectionPointRaid, false);
    InflectionPointRaid25MCurveFloor         = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid25M.CurveFloor", InflectionPointRaidCurveFloor, false);
    InflectionPointRaid25MCurveCeiling       = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid25M.CurveCeiling", InflectionPointRaidCurveCeiling, false);
    InflectionPointRaid25MBoss               = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid25M.BossModifier", InflectionPointRaidBoss, false);

    InflectionPointRaid25MHeroic             = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid25MHeroic", InflectionPointRaidHeroic, false);
    InflectionPointRaid25MHeroicCurveFloor   = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid25MHeroic.CurveFloor", InflectionPointRaidHeroicCurveFloor, false);
    InflectionPointRaid25MHeroicCurveCeiling = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid25MHeroic.CurveCeiling", InflectionPointRaidHeroicCurveCeiling, false);
    InflectionPointRaid25MHeroicBoss         = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid25MHeroic.BossModifier", InflectionPointRaidHeroicBoss, false);

    InflectionPointRaid40M                   = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid40M", InflectionPointRaid, false);
    InflectionPointRaid40MCurveFloor         = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid40M.CurveFloor", InflectionPointRaidCurveFloor, false);
    InflectionPointRaid40MCurveCeiling       = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid40M.CurveCeiling", InflectionPointRaidCurveCeiling, false);
    InflectionPointRaid40MBoss               = sConfigMgr->GetOption<float>("AutoBalance.InflectionPointRaid40M.BossModifier", InflectionPointRaidBoss, false);

    //
    // StatModifier*
    // warn the console if deprecated values are detected
    //

    if (sConfigMgr->GetOption<float>("AutoBalance.rate.global", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.rate.global` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");
    if (sConfigMgr->GetOption<float>("AutoBalance.rate.health", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.rate.health` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");
    if (sConfigMgr->GetOption<float>("AutoBalance.rate.mana", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.rate.mana` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");
    if (sConfigMgr->GetOption<float>("AutoBalance.rate.armor", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.rate.armor` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");
    if (sConfigMgr->GetOption<float>("AutoBalance.rate.damage", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.rate.damage` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");

    //
    // 5-player dungeons
    //

    StatModifier_Global                       = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.Global", sConfigMgr->GetOption<float>("AutoBalance.rate.global", 1.0f, false), false); // `AutoBalance.rate.global` for backwards compatibility
    StatModifier_Health                       = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.Health", sConfigMgr->GetOption<float>("AutoBalance.rate.health", 1.0f, false), false); // `AutoBalance.rate.health` for backwards compatibility
    StatModifier_Mana                         = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.Mana", sConfigMgr->GetOption<float>("AutoBalance.rate.mana", 1.0f, false), false); // `AutoBalance.rate.mana` for backwards compatibility
    StatModifier_Armor                        = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.Armor", sConfigMgr->GetOption<float>("AutoBalance.rate.armor", 1.0f, false), false); // `AutoBalance.rate.armor` for backwards compatibility
    StatModifier_Damage                       = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.Damage", sConfigMgr->GetOption<float>("AutoBalance.rate.damage", 1.0f, false), false); // `AutoBalance.rate.damage` for backwards compatibility
    StatModifier_CCDuration                   = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.CCDuration", -1.0f, false);

    StatModifier_Boss_Global                  = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.Boss.Global", sConfigMgr->GetOption<float>("AutoBalance.rate.global", 1.0f, false), false); // `AutoBalance.rate.global` for backwards compatibility
    StatModifier_Boss_Health                  = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.Boss.Health", sConfigMgr->GetOption<float>("AutoBalance.rate.health", 1.0f, false), false); // `AutoBalance.rate.health` for backwards compatibility
    StatModifier_Boss_Mana                    = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.Boss.Mana", sConfigMgr->GetOption<float>("AutoBalance.rate.mana", 1.0f, false), false); // `AutoBalance.rate.mana` for backwards compatibility
    StatModifier_Boss_Armor                   = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.Boss.Armor", sConfigMgr->GetOption<float>("AutoBalance.rate.armor", 1.0f, false), false); // `AutoBalance.rate.armor` for backwards compatibility
    StatModifier_Boss_Damage                  = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.Boss.Damage", sConfigMgr->GetOption<float>("AutoBalance.rate.damage", 1.0f, false), false); // `AutoBalance.rate.damage` for backwards compatibility
    StatModifier_Boss_CCDuration              = sConfigMgr->GetOption<float>("AutoBalance.StatModifier.Boss.CCDuration", -1.0f, false);

    //
    // 5-player heroic dungeons
    //

    StatModifierHeroic_Global                 = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.Global", sConfigMgr->GetOption<float>("AutoBalance.rate.global", 1.0f, false), false); // `AutoBalance.rate.global` for backwards compatibility
    StatModifierHeroic_Health                 = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.Health", sConfigMgr->GetOption<float>("AutoBalance.rate.health", 1.0f, false), false); // `AutoBalance.rate.health` for backwards compatibility
    StatModifierHeroic_Mana                   = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.Mana", sConfigMgr->GetOption<float>("AutoBalance.rate.mana", 1.0f, false), false); // `AutoBalance.rate.mana` for backwards compatibility
    StatModifierHeroic_Armor                  = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.Armor", sConfigMgr->GetOption<float>("AutoBalance.rate.armor", 1.0f, false), false); // `AutoBalance.rate.armor` for backwards compatibility
    StatModifierHeroic_Damage                 = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.Damage", sConfigMgr->GetOption<float>("AutoBalance.rate.damage", 1.0f, false), false); // `AutoBalance.rate.damage` for backwards compatibility
    StatModifierHeroic_CCDuration             = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.CCDuration", -1.0f, false);

    StatModifierHeroic_Boss_Global            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.Boss.Global", sConfigMgr->GetOption<float>("AutoBalance.rate.global", 1.0f, false), false); // `AutoBalance.rate.global` for backwards compatibility
    StatModifierHeroic_Boss_Health            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.Boss.Health", sConfigMgr->GetOption<float>("AutoBalance.rate.health", 1.0f, false), false); // `AutoBalance.rate.health` for backwards compatibility
    StatModifierHeroic_Boss_Mana              = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.Boss.Mana", sConfigMgr->GetOption<float>("AutoBalance.rate.mana", 1.0f, false), false); // `AutoBalance.rate.mana` for backwards compatibility
    StatModifierHeroic_Boss_Armor             = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.Boss.Armor", sConfigMgr->GetOption<float>("AutoBalance.rate.armor", 1.0f, false), false); // `AutoBalance.rate.armor` for backwards compatibility
    StatModifierHeroic_Boss_Damage            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.Boss.Damage", sConfigMgr->GetOption<float>("AutoBalance.rate.damage", 1.0f, false), false); // `AutoBalance.rate.damage` for backwards compatibility
    StatModifierHeroic_Boss_CCDuration        = sConfigMgr->GetOption<float>("AutoBalance.StatModifierHeroic.Boss.CCDuration", -1.0f, false);

    //
    // Default for all raids
    //

    StatModifierRaid_Global                   = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.Global", sConfigMgr->GetOption<float>("AutoBalance.rate.global", 1.0f, false), false); // `AutoBalance.rate.global` for backwards compatibility
    StatModifierRaid_Health                   = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.Health", sConfigMgr->GetOption<float>("AutoBalance.rate.health", 1.0f, false), false); // `AutoBalance.rate.health` for backwards compatibility
    StatModifierRaid_Mana                     = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.Mana", sConfigMgr->GetOption<float>("AutoBalance.rate.mana", 1.0f, false), false); // `AutoBalance.rate.mana` for backwards compatibility
    StatModifierRaid_Armor                    = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.Armor", sConfigMgr->GetOption<float>("AutoBalance.rate.armor", 1.0f, false), false); // `AutoBalance.rate.armor` for backwards compatibility
    StatModifierRaid_Damage                   = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.Damage", sConfigMgr->GetOption<float>("AutoBalance.rate.damage", 1.0f, false), false); // `AutoBalance.rate.damage` for backwards compatibility
    StatModifierRaid_CCDuration               = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.CCDuration", -1.0f, false);

    StatModifierRaid_Boss_Global              = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.Boss.Global", sConfigMgr->GetOption<float>("AutoBalance.rate.global", 1.0f, false), false); // `AutoBalance.rate.global` for backwards compatibility
    StatModifierRaid_Boss_Health              = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.Boss.Health", sConfigMgr->GetOption<float>("AutoBalance.rate.health", 1.0f, false), false); // `AutoBalance.rate.health` for backwards compatibility
    StatModifierRaid_Boss_Mana                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.Boss.Mana", sConfigMgr->GetOption<float>("AutoBalance.rate.mana", 1.0f, false), false); // `AutoBalance.rate.mana` for backwards compatibility
    StatModifierRaid_Boss_Armor               = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.Boss.Armor", sConfigMgr->GetOption<float>("AutoBalance.rate.armor", 1.0f, false), false); // `AutoBalance.rate.armor` for backwards compatibility
    StatModifierRaid_Boss_Damage              = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.Boss.Damage", sConfigMgr->GetOption<float>("AutoBalance.rate.damage", 1.0f, false), false); // `AutoBalance.rate.damage` for backwards compatibility
    StatModifierRaid_Boss_CCDuration          = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid.Boss.CCDuration", -1.0f, false);

    //
    // Default for all heroic raids
    //

    StatModifierRaidHeroic_Global             = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.Global", sConfigMgr->GetOption<float>("AutoBalance.rate.global", 1.0f, false), false); // `AutoBalance.rate.global` for backwards compatibility
    StatModifierRaidHeroic_Health             = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.Health", sConfigMgr->GetOption<float>("AutoBalance.rate.health", 1.0f, false), false); // `AutoBalance.rate.health` for backwards compatibility
    StatModifierRaidHeroic_Mana               = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.Mana", sConfigMgr->GetOption<float>("AutoBalance.rate.mana", 1.0f, false), false); // `AutoBalance.rate.mana` for backwards compatibility
    StatModifierRaidHeroic_Armor              = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.Armor", sConfigMgr->GetOption<float>("AutoBalance.rate.armor", 1.0f, false), false); // `AutoBalance.rate.armor` for backwards compatibility
    StatModifierRaidHeroic_Damage             = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.Damage", sConfigMgr->GetOption<float>("AutoBalance.rate.damage", 1.0f, false), false); // `AutoBalance.rate.damage` for backwards compatibility
    StatModifierRaidHeroic_CCDuration         = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.CCDuration", -1.0f, false);

    StatModifierRaidHeroic_Boss_Global        = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.Boss.Global", sConfigMgr->GetOption<float>("AutoBalance.rate.global", 1.0f, false), false); // `AutoBalance.rate.global` for backwards compatibility
    StatModifierRaidHeroic_Boss_Health        = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.Boss.Health", sConfigMgr->GetOption<float>("AutoBalance.rate.health", 1.0f, false), false); // `AutoBalance.rate.health` for backwards compatibility
    StatModifierRaidHeroic_Boss_Mana          = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.Boss.Mana", sConfigMgr->GetOption<float>("AutoBalance.rate.mana", 1.0f, false), false); // `AutoBalance.rate.mana` for backwards compatibility
    StatModifierRaidHeroic_Boss_Armor         = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.Boss.Armor", sConfigMgr->GetOption<float>("AutoBalance.rate.armor", 1.0f, false), false); // `AutoBalance.rate.armor` for backwards compatibility
    StatModifierRaidHeroic_Boss_Damage        = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.Boss.Damage", sConfigMgr->GetOption<float>("AutoBalance.rate.damage", 1.0f, false), false); // `AutoBalance.rate.damage` for backwards compatibility
    StatModifierRaidHeroic_Boss_CCDuration    = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaidHeroic.Boss.CCDuration", -1.0f, false);

    //
    // 10-player raids
    //

    StatModifierRaid10M_Global                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.Global", StatModifierRaid_Global, false);
    StatModifierRaid10M_Health                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.Health", StatModifierRaid_Health, false);
    StatModifierRaid10M_Mana                  = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.Mana", StatModifierRaid_Mana, false);
    StatModifierRaid10M_Armor                 = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.Armor", StatModifierRaid_Armor, false);
    StatModifierRaid10M_Damage                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.Damage", StatModifierRaid_Damage, false);
    StatModifierRaid10M_CCDuration            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.CCDuration", StatModifierRaid_CCDuration, false);

    StatModifierRaid10M_Boss_Global           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.Boss.Global", StatModifierRaid_Boss_Global, false);
    StatModifierRaid10M_Boss_Health           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.Boss.Health", StatModifierRaid_Boss_Health, false);
    StatModifierRaid10M_Boss_Mana             = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.Boss.Mana", StatModifierRaid_Boss_Mana, false);
    StatModifierRaid10M_Boss_Armor            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.Boss.Armor", StatModifierRaid_Boss_Armor, false);
    StatModifierRaid10M_Boss_Damage           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.Boss.Damage", StatModifierRaid_Boss_Damage, false);
    StatModifierRaid10M_Boss_CCDuration       = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10M.Boss.CCDuration", StatModifierRaid_Boss_CCDuration, false);

    //
    // 10-player heroic raids
    //

    StatModifierRaid10MHeroic_Global          = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.Global", StatModifierRaidHeroic_Global, false);
    StatModifierRaid10MHeroic_Health          = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.Health", StatModifierRaidHeroic_Health, false);
    StatModifierRaid10MHeroic_Mana            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.Mana", StatModifierRaidHeroic_Mana, false);
    StatModifierRaid10MHeroic_Armor           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.Armor", StatModifierRaidHeroic_Armor, false);
    StatModifierRaid10MHeroic_Damage          = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.Damage", StatModifierRaidHeroic_Damage, false);
    StatModifierRaid10MHeroic_CCDuration      = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.CCDuration", StatModifierRaidHeroic_CCDuration, false);

    StatModifierRaid10MHeroic_Boss_Global     = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.Boss.Global", StatModifierRaidHeroic_Boss_Global, false);
    StatModifierRaid10MHeroic_Boss_Health     = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.Boss.Health", StatModifierRaidHeroic_Boss_Health, false);
    StatModifierRaid10MHeroic_Boss_Mana       = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.Boss.Mana", StatModifierRaidHeroic_Boss_Mana, false);
    StatModifierRaid10MHeroic_Boss_Armor      = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.Boss.Armor", StatModifierRaidHeroic_Boss_Armor, false);
    StatModifierRaid10MHeroic_Boss_Damage     = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.Boss.Damage", StatModifierRaidHeroic_Boss_Damage, false);
    StatModifierRaid10MHeroic_Boss_CCDuration = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid10MHeroic.Boss.CCDuration", StatModifierRaidHeroic_Boss_CCDuration, false);

    //
    // 15-player raids
    //

    StatModifierRaid15M_Global                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.Global", StatModifierRaid_Global, false);
    StatModifierRaid15M_Health                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.Health", StatModifierRaid_Health, false);
    StatModifierRaid15M_Mana                  = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.Mana", StatModifierRaid_Mana, false);
    StatModifierRaid15M_Armor                 = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.Armor", StatModifierRaid_Armor, false);
    StatModifierRaid15M_Damage                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.Damage", StatModifierRaid_Damage, false);
    StatModifierRaid15M_CCDuration            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.CCDuration", StatModifierRaid_CCDuration, false);

    StatModifierRaid15M_Boss_Global           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.Boss.Global", StatModifierRaid_Boss_Global, false);
    StatModifierRaid15M_Boss_Health           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.Boss.Health", StatModifierRaid_Boss_Health, false);
    StatModifierRaid15M_Boss_Mana             = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.Boss.Mana", StatModifierRaid_Boss_Mana, false);
    StatModifierRaid15M_Boss_Armor            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.Boss.Armor", StatModifierRaid_Boss_Armor, false);
    StatModifierRaid15M_Boss_Damage           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.Boss.Damage", StatModifierRaid_Boss_Damage, false);
    StatModifierRaid15M_Boss_CCDuration       = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid15M.Boss.CCDuration", StatModifierRaid_Boss_CCDuration, false);

    //
    // 20-player raids
    //

    StatModifierRaid20M_Global                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.Global", StatModifierRaid_Global, false);
    StatModifierRaid20M_Health                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.Health", StatModifierRaid_Health, false);
    StatModifierRaid20M_Mana                  = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.Mana", StatModifierRaid_Mana, false);
    StatModifierRaid20M_Armor                 = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.Armor", StatModifierRaid_Armor, false);
    StatModifierRaid20M_Damage                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.Damage", StatModifierRaid_Damage, false);
    StatModifierRaid20M_CCDuration            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.CCDuration", StatModifierRaid_CCDuration, false);

    StatModifierRaid20M_Boss_Global           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.Boss.Global", StatModifierRaid_Boss_Global, false);
    StatModifierRaid20M_Boss_Health           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.Boss.Health", StatModifierRaid_Boss_Health, false);
    StatModifierRaid20M_Boss_Mana             = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.Boss.Mana", StatModifierRaid_Boss_Mana, false);
    StatModifierRaid20M_Boss_Armor            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.Boss.Armor", StatModifierRaid_Boss_Armor, false);
    StatModifierRaid20M_Boss_Damage           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.Boss.Damage", StatModifierRaid_Boss_Damage, false);
    StatModifierRaid20M_Boss_CCDuration       = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid20M.Boss.CCDuration", StatModifierRaid_Boss_CCDuration, false);

    //
    // 25-player raids
    //

    StatModifierRaid25M_Global                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.Global", StatModifierRaid_Global, false);
    StatModifierRaid25M_Health                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.Health", StatModifierRaid_Health, false);
    StatModifierRaid25M_Mana                  = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.Mana", StatModifierRaid_Mana, false);
    StatModifierRaid25M_Armor                 = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.Armor", StatModifierRaid_Armor, false);
    StatModifierRaid25M_Damage                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.Damage", StatModifierRaid_Damage, false);
    StatModifierRaid25M_CCDuration            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.CCDuration", StatModifierRaid_CCDuration, false);

    StatModifierRaid25M_Boss_Global           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.Boss.Global", StatModifierRaid_Boss_Global, false);
    StatModifierRaid25M_Boss_Health           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.Boss.Health", StatModifierRaid_Boss_Health, false);
    StatModifierRaid25M_Boss_Mana             = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.Boss.Mana", StatModifierRaid_Boss_Mana, false);
    StatModifierRaid25M_Boss_Armor            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.Boss.Armor", StatModifierRaid_Boss_Armor, false);
    StatModifierRaid25M_Boss_Damage           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.Boss.Damage", StatModifierRaid_Boss_Damage, false);
    StatModifierRaid25M_Boss_CCDuration       = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25M.Boss.CCDuration", StatModifierRaid_Boss_CCDuration, false);

    //
    // 25-player heroic raids
    //

    StatModifierRaid25MHeroic_Global          = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.Global", StatModifierRaidHeroic_Global, false);
    StatModifierRaid25MHeroic_Health          = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.Health", StatModifierRaidHeroic_Health, false);
    StatModifierRaid25MHeroic_Mana            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.Mana", StatModifierRaidHeroic_Mana, false);
    StatModifierRaid25MHeroic_Armor           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.Armor", StatModifierRaidHeroic_Armor, false);
    StatModifierRaid25MHeroic_Damage          = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.Damage", StatModifierRaidHeroic_Damage, false);
    StatModifierRaid25MHeroic_CCDuration      = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.CCDuration", StatModifierRaidHeroic_CCDuration, false);

    StatModifierRaid25MHeroic_Boss_Global     = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.Boss.Global", StatModifierRaidHeroic_Boss_Global, false);
    StatModifierRaid25MHeroic_Boss_Health     = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.Boss.Health", StatModifierRaidHeroic_Boss_Health, false);
    StatModifierRaid25MHeroic_Boss_Mana       = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.Boss.Mana", StatModifierRaidHeroic_Boss_Mana, false);
    StatModifierRaid25MHeroic_Boss_Armor      = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.Boss.Armor", StatModifierRaidHeroic_Boss_Armor, false);
    StatModifierRaid25MHeroic_Boss_Damage     = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.Boss.Damage", StatModifierRaidHeroic_Boss_Damage, false);
    StatModifierRaid25MHeroic_Boss_CCDuration = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid25MHeroic.Boss.CCDuration", StatModifierRaidHeroic_Boss_CCDuration, false);

    //
    // 40-player raids
    //

    StatModifierRaid40M_Global                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.Global", StatModifierRaid_Global, false);
    StatModifierRaid40M_Health                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.Health", StatModifierRaid_Health, false);
    StatModifierRaid40M_Mana                  = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.Mana", StatModifierRaid_Mana, false);
    StatModifierRaid40M_Armor                 = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.Armor", StatModifierRaid_Armor, false);
    StatModifierRaid40M_Damage                = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.Damage", StatModifierRaid_Damage, false);
    StatModifierRaid40M_CCDuration            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.CCDuration", StatModifierRaid_CCDuration, false);

    StatModifierRaid40M_Boss_Global           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.Boss.Global", StatModifierRaid_Boss_Global, false);
    StatModifierRaid40M_Boss_Health           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.Boss.Health", StatModifierRaid_Boss_Health, false);
    StatModifierRaid40M_Boss_Mana             = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.Boss.Mana", StatModifierRaid_Boss_Mana, false);
    StatModifierRaid40M_Boss_Armor            = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.Boss.Armor", StatModifierRaid_Boss_Armor, false);
    StatModifierRaid40M_Boss_Damage           = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.Boss.Damage", StatModifierRaid_Boss_Damage, false);
    StatModifierRaid40M_Boss_CCDuration       = sConfigMgr->GetOption<float>("AutoBalance.StatModifierRaid40M.Boss.CCDuration", StatModifierRaid_Boss_CCDuration, false);

    //
    // Modifier Min/Max
    //

    MinHPModifier         = sConfigMgr->GetOption<float>("AutoBalance.MinHPModifier", 0.1f);
    MinManaModifier       = sConfigMgr->GetOption<float>("AutoBalance.MinManaModifier", 0.01f);
    MinDamageModifier     = sConfigMgr->GetOption<float>("AutoBalance.MinDamageModifier", 0.01f);
    MinCCDurationModifier = sConfigMgr->GetOption<float>("AutoBalance.MinCCDurationModifier", 0.25f);
    MaxCCDurationModifier = sConfigMgr->GetOption<float>("AutoBalance.MaxCCDurationModifier", 1.0f);

    //
    // LevelScaling.*
    //

    LevelScaling = sConfigMgr->GetOption<bool>("AutoBalance.LevelScaling", true);

    std::string LevelScalingMethodString = sConfigMgr->GetOption<std::string>("AutoBalance.LevelScaling.Method", "dynamic", false);

    if (LevelScalingMethodString == "fixed")
        LevelScalingMethod = AUTOBALANCE_SCALING_FIXED;
    else if (LevelScalingMethodString == "dynamic")
        LevelScalingMethod = AUTOBALANCE_SCALING_DYNAMIC;
    else
    {
        LOG_ERROR("server.loading", "mod-autobalance: invalid value `{}` for `AutoBalance.LevelScaling.Method` defined in `AutoBalance.conf`. Defaulting to a value of `dynamic`.", LevelScalingMethodString);
        LevelScalingMethod = AUTOBALANCE_SCALING_DYNAMIC;
    }

    if (sConfigMgr->GetOption<float>("AutoBalance.LevelHigherOffset", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.LevelHigherOffset` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");

    LevelScalingSkipHigherLevels = sConfigMgr->GetOption<uint8>("AutoBalance.LevelScaling.SkipHigherLevels", sConfigMgr->GetOption<uint32>("AutoBalance.LevelHigherOffset", 3, false), true);

    if (sConfigMgr->GetOption<float>("AutoBalance.LevelLowerOffset", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.LevelLowerOffset` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");

    LevelScalingSkipLowerLevels = sConfigMgr->GetOption<uint8>("AutoBalance.LevelScaling.SkipLowerLevels", sConfigMgr->GetOption<uint32>("AutoBalance.LevelLowerOffset", 5, false), true);

    LevelScalingDynamicLevelCeilingDungeons       = sConfigMgr->GetOption<uint8>("AutoBalance.LevelScaling.DynamicLevel.Ceiling.Dungeons", 1);
    LevelScalingDynamicLevelFloorDungeons         = sConfigMgr->GetOption<uint8>("AutoBalance.LevelScaling.DynamicLevel.Floor.Dungeons", 5);
    LevelScalingDynamicLevelCeilingHeroicDungeons = sConfigMgr->GetOption<uint8>("AutoBalance.LevelScaling.DynamicLevel.Ceiling.HeroicDungeons", 2);
    LevelScalingDynamicLevelFloorHeroicDungeons   = sConfigMgr->GetOption<uint8>("AutoBalance.LevelScaling.DynamicLevel.Floor.HeroicDungeons", 5);
    LevelScalingDynamicLevelCeilingRaids          = sConfigMgr->GetOption<uint8>("AutoBalance.LevelScaling.DynamicLevel.Ceiling.Raids", 3);
    LevelScalingDynamicLevelFloorRaids            = sConfigMgr->GetOption<uint8>("AutoBalance.LevelScaling.DynamicLevel.Floor.Raids", 5);
    LevelScalingDynamicLevelCeilingHeroicRaids    = sConfigMgr->GetOption<uint8>("AutoBalance.LevelScaling.DynamicLevel.Ceiling.HeroicRaids", 3);
    LevelScalingDynamicLevelFloorHeroicRaids      = sConfigMgr->GetOption<uint8>("AutoBalance.LevelScaling.DynamicLevel.Floor.HeroicRaids", 5);

    if (sConfigMgr->GetOption<float>("AutoBalance.LevelEndGameBoost", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.LevelEndGameBoost` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");

    LevelScalingEndGameBoost = sConfigMgr->GetOption<bool>("AutoBalance.LevelScaling.EndGameBoost", sConfigMgr->GetOption<bool>("AutoBalance.LevelEndGameBoost", 1, false), true);

    if (LevelScalingEndGameBoost)
    {
        LOG_WARN("server.loading", "mod-autobalance: `AutoBalance.LevelScaling.EndGameBoost` is enabled in the configuration, but is not currently implemented. No effect.");
        LevelScalingEndGameBoost = 0;
    }

    //
    // RewardScaling.*
    // warn the console if deprecated values are detected
    //

    if (sConfigMgr->GetOption<float>("AutoBalance.DungeonScaleDownXP", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.DungeonScaleDownXP` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");

    if (sConfigMgr->GetOption<float>("AutoBalance.DungeonScaleDownMoney", false, false))
        LOG_WARN("server.loading", "mod-autobalance: deprecated value `AutoBalance.DungeonScaleDownMoney` defined in `AutoBalance.conf`. This variable will be removed in a future release. Please see `AutoBalance.conf.dist` for more details.");

    std::string RewardScalingMethodString = sConfigMgr->GetOption<std::string>("AutoBalance.RewardScaling.Method", "dynamic", false);

    if (RewardScalingMethodString == "fixed")
        RewardScalingMethod = AUTOBALANCE_SCALING_FIXED;
    else if (RewardScalingMethodString == "dynamic")
        RewardScalingMethod = AUTOBALANCE_SCALING_DYNAMIC;
    else
    {
        LOG_ERROR("server.loading", "mod-autobalance: invalid value `{}` for `AutoBalance.RewardScaling.Method` defined in `AutoBalance.conf`. Defaulting to a value of `dynamic`.", RewardScalingMethodString);
        RewardScalingMethod = AUTOBALANCE_SCALING_DYNAMIC;
    }

    RewardScalingXP            = sConfigMgr->GetOption<bool>("AutoBalance.RewardScaling.XP", sConfigMgr->GetOption<bool>("AutoBalance.DungeonScaleDownXP", true, false));
    RewardScalingXPModifier    = sConfigMgr->GetOption<float>("AutoBalance.RewardScaling.XP.Modifier", 1.0f, false);

    RewardScalingMoney         = sConfigMgr->GetOption<bool>("AutoBalance.RewardScaling.Money", sConfigMgr->GetOption<bool>("AutoBalance.DungeonScaleDownMoney", true, false));
    RewardScalingMoneyModifier = sConfigMgr->GetOption<float>("AutoBalance.RewardScaling.Money.Modifier", 1.0f, false);

    //
    // Announcement
    //

    Announcement = sConfigMgr->GetOption<bool>("AutoBalanceAnnounce.enable", true);
}
