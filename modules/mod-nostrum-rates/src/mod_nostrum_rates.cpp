/*
 * mod-nostrum-rates
 *
 * Centralizes configurable gameplay rate modifiers for NostrumWoW.
 * All values are read from nostrum_rates.conf at startup and on .reload config.
 *
 * NOTE: This module multiplies on top of any rates set in worldserver.conf.
 *       Set Rate.XP.Kill, Rate.XP.Quest, etc. to 1.0 in worldserver.conf
 *       to let this module be the sole authority on rates.
 */

#include "ArenaTeamScript.h"
#include "Config.h"
#include "Creature.h"
#include "FormulaScript.h"
#include "GlobalScript.h"
#include "LootMgr.h"
#include "Map.h"
#include "Player.h"
#include "PlayerScript.h"
#include "WorldScript.h"
#include <sstream>
#include <string_view>
#include <vector>

namespace
{

// ---------------------------------------------------------------------------
// Config structs
// ---------------------------------------------------------------------------

struct LevelRangeEntry
{
    uint8 min;
    uint8 max;
    float kill;
    float quest;
    float explore;
};

struct NostrumRatesConfig
{
    bool enabled = true;

    // XP
    float xpKill         = 3.0f;
    float xpQuest        = 3.0f;
    float xpExplore      = 3.0f;
    float xpBattleground = 1.0f;
    float xpDungeon      = 3.0f;
    float xpElite        = 3.0f;

    // XP level range overrides
    bool levelRangeEnabled = true;
    std::vector<LevelRangeEntry> levelRanges;

    // Reputation
    float repKill  = 2.0f;
    float repQuest = 2.0f;

    // Profession skill gain
    float profGathering = 2.0f;
    float profCrafting  = 2.0f;

    // Loot drop chance multipliers (applied via OnItemRoll)
    // Mining and herbalism share gameobject_loot_template — see README.
    float lootCreature      = 1.0f;
    float lootSkinning      = 1.0f;
    float lootFishing       = 1.0f;
    float lootMining        = 1.0f; // also applies to herbalism
    float lootDisenchanting = 1.0f;
    float lootProspecting   = 1.0f;
    float lootMilling       = 1.0f;

    // Money
    float moneyCreature = 1.0f;

    // PvP
    float pvpHonor       = 1.0f;
    float pvpArenaPoints = 1.0f;
};

NostrumRatesConfig gCfg;

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

float ValidatedRate(std::string const& key, float value, float defaultVal)
{
    if (value < 0.0f || value > 100.0f)
    {
        LOG_WARN("module", ">> NostrumRates: invalid value for {}, using default {:.1f}", key, defaultVal);
        return defaultVal;
    }
    return value;
}

float LoadRate(std::string const& key, float defaultVal)
{
    return ValidatedRate(key, sConfigMgr->GetOption<float>(key, defaultVal), defaultVal);
}

void ParseLevelRanges()
{
    gCfg.levelRanges.clear();

    std::string brackets = sConfigMgr->GetOption<std::string>(
        "NostrumRates.XP.LevelRange.Brackets", "1-59,60-69,70-80");

    std::istringstream ss(brackets);
    std::string token;
    while (std::getline(ss, token, ','))
    {
        auto s = token.find_first_not_of(" \t");
        auto e = token.find_last_not_of(" \t");
        if (s == std::string::npos)
            continue;
        token = token.substr(s, e - s + 1);

        size_t dash = token.find('-');
        if (dash == std::string::npos || dash == 0)
        {
            LOG_WARN("module", ">> NostrumRates: malformed level range '{}', skipping", token);
            continue;
        }

        int32 lo = 0, hi = 0;
        try
        {
            lo = std::stoi(token.substr(0, dash));
            hi = std::stoi(token.substr(dash + 1));
        }
        catch (...)
        {
            LOG_WARN("module", ">> NostrumRates: malformed level range '{}', skipping", token);
            continue;
        }

        if (lo < 1 || hi > 80 || lo > hi)
        {
            LOG_WARN("module", ">> NostrumRates: level range {}-{} out of bounds [1-80], skipping", lo, hi);
            continue;
        }

        std::string prefix = "NostrumRates.XP.LevelRange." + token + ".";
        LevelRangeEntry entry;
        entry.min     = static_cast<uint8>(lo);
        entry.max     = static_cast<uint8>(hi);
        entry.kill    = LoadRate(prefix + "Kill",    gCfg.xpKill);
        entry.quest   = LoadRate(prefix + "Quest",   gCfg.xpQuest);
        entry.explore = LoadRate(prefix + "Explore", gCfg.xpExplore);
        gCfg.levelRanges.push_back(entry);
    }
}

void LoadConfig()
{
    gCfg = {};  // reset to defaults

    gCfg.enabled = sConfigMgr->GetOption<bool>("NostrumRates.Enable", true);
    if (!gCfg.enabled)
    {
        LOG_INFO("module", ">> NostrumRates: module disabled");
        return;
    }

    // XP
    gCfg.xpKill         = LoadRate("NostrumRates.XP.Kill",         3.0f);
    gCfg.xpQuest        = LoadRate("NostrumRates.XP.Quest",        3.0f);
    gCfg.xpExplore      = LoadRate("NostrumRates.XP.Explore",      3.0f);
    gCfg.xpBattleground = LoadRate("NostrumRates.XP.Battleground", 1.0f);
    gCfg.xpDungeon      = LoadRate("NostrumRates.XP.Dungeon",      3.0f);
    gCfg.xpElite        = LoadRate("NostrumRates.XP.Elite",        3.0f);

    gCfg.levelRangeEnabled = sConfigMgr->GetOption<bool>("NostrumRates.XP.LevelRange.Enable", true);
    if (gCfg.levelRangeEnabled)
        ParseLevelRanges();

    // Reputation
    gCfg.repKill  = LoadRate("NostrumRates.Reputation.Kill",  2.0f);
    gCfg.repQuest = LoadRate("NostrumRates.Reputation.Quest", 2.0f);

    // Profession
    gCfg.profGathering = LoadRate("NostrumRates.Profession.GatheringSkillGain", 2.0f);
    gCfg.profCrafting  = LoadRate("NostrumRates.Profession.CraftingSkillGain",  2.0f);

    // Loot
    gCfg.lootCreature      = LoadRate("NostrumRates.Loot.Creature",      1.0f);
    gCfg.lootSkinning      = LoadRate("NostrumRates.Loot.Skinning",      1.0f);
    gCfg.lootFishing       = LoadRate("NostrumRates.Loot.Fishing",       1.0f);
    gCfg.lootMining        = LoadRate("NostrumRates.Loot.Mining",        1.0f);
    gCfg.lootDisenchanting = LoadRate("NostrumRates.Loot.Disenchanting", 1.0f);
    gCfg.lootProspecting   = LoadRate("NostrumRates.Loot.Prospecting",   1.0f);
    gCfg.lootMilling       = LoadRate("NostrumRates.Loot.Milling",       1.0f);

    float herbRate = LoadRate("NostrumRates.Loot.Herbalism", 1.0f);
    if (herbRate != gCfg.lootMining)
        LOG_WARN("module", ">> NostrumRates: Loot.Mining ({:.1f}) and Loot.Herbalism ({:.1f}) differ "
                           "but both go through gameobject_loot_template — Mining rate will be used for both",
                           gCfg.lootMining, herbRate);

    // Money
    gCfg.moneyCreature = LoadRate("NostrumRates.Money.Creature", 1.0f);

    // PvP
    gCfg.pvpHonor       = LoadRate("NostrumRates.PvP.Honor",       1.0f);
    gCfg.pvpArenaPoints = LoadRate("NostrumRates.PvP.ArenaPoints", 1.0f);

    // Startup log
    LOG_INFO("module", ">> NostrumRates: module enabled");
    LOG_INFO("module", ">> NostrumRates: XP Kill = {:.1f}", gCfg.xpKill);
    LOG_INFO("module", ">> NostrumRates: XP Quest = {:.1f}", gCfg.xpQuest);
    LOG_INFO("module", ">> NostrumRates: XP Explore = {:.1f}", gCfg.xpExplore);
    LOG_INFO("module", ">> NostrumRates: XP Battleground = {:.1f}", gCfg.xpBattleground);
    LOG_INFO("module", ">> NostrumRates: XP Dungeon = {:.1f}", gCfg.xpDungeon);
    LOG_INFO("module", ">> NostrumRates: XP Elite = {:.1f}", gCfg.xpElite);
    LOG_INFO("module", ">> NostrumRates: XP LevelRange = {}", gCfg.levelRangeEnabled ? "enabled" : "disabled");
    LOG_INFO("module", ">> NostrumRates: Reputation Kill = {:.1f}", gCfg.repKill);
    LOG_INFO("module", ">> NostrumRates: Reputation Quest = {:.1f}", gCfg.repQuest);
    LOG_INFO("module", ">> NostrumRates: Profession Gathering = {:.1f}", gCfg.profGathering);
    LOG_INFO("module", ">> NostrumRates: Profession Crafting = {:.1f}", gCfg.profCrafting);
    LOG_INFO("module", ">> NostrumRates: Loot Creature = {:.1f}", gCfg.lootCreature);
    LOG_INFO("module", ">> NostrumRates: Loot Skinning = {:.1f}", gCfg.lootSkinning);
    LOG_INFO("module", ">> NostrumRates: Loot Fishing = {:.1f}", gCfg.lootFishing);
    LOG_INFO("module", ">> NostrumRates: Loot Mining+Herbalism = {:.1f}", gCfg.lootMining);
    LOG_INFO("module", ">> NostrumRates: Loot Disenchanting = {:.1f}", gCfg.lootDisenchanting);
    LOG_INFO("module", ">> NostrumRates: Loot Prospecting = {:.1f}", gCfg.lootProspecting);
    LOG_INFO("module", ">> NostrumRates: Loot Milling = {:.1f}", gCfg.lootMilling);
    LOG_INFO("module", ">> NostrumRates: Money Creature = {:.1f}", gCfg.moneyCreature);
    LOG_INFO("module", ">> NostrumRates: PvP Honor = {:.1f}", gCfg.pvpHonor);
    LOG_INFO("module", ">> NostrumRates: PvP ArenaPoints = {:.1f}", gCfg.pvpArenaPoints);
}

// Returns the effective XP rate for a player's current level, falling back to globalRate
// if level ranges are disabled or the player's level matches no configured range.
float ResolveXPRate(Player const* player, float LevelRangeEntry::*field, float globalRate)
{
    if (!gCfg.levelRangeEnabled || gCfg.levelRanges.empty())
        return globalRate;

    uint8 level = player->GetLevel();
    for (LevelRangeEntry const& r : gCfg.levelRanges)
        if (level >= r.min && level <= r.max)
            return r.*field;

    return globalRate;
}

float GetLootRate(char const* storeName)
{
    using sv = std::string_view;
    sv name = storeName;
    if (name == "creature_loot_template")    return gCfg.lootCreature;
    if (name == "skinning_loot_template")    return gCfg.lootSkinning;
    if (name == "fishing_loot_template")     return gCfg.lootFishing;
    if (name == "gameobject_loot_template")  return gCfg.lootMining; // mining + herbalism
    if (name == "disenchant_loot_template")  return gCfg.lootDisenchanting;
    if (name == "prospecting_loot_template") return gCfg.lootProspecting;
    if (name == "milling_loot_template")     return gCfg.lootMilling;
    return 1.0f;
}

} // anonymous namespace

// ---------------------------------------------------------------------------
// WorldScript — config load + startup logging
// ---------------------------------------------------------------------------

class NostrumRatesWorldScript : public WorldScript
{
public:
    NostrumRatesWorldScript() : WorldScript("NostrumRatesWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD })
    {
    }

    void OnAfterConfigLoad(bool reload) override
    {
        LoadConfig();
        if (reload)
            LOG_INFO("module", ">> NostrumRates: config reloaded");
    }
};

// ---------------------------------------------------------------------------
// PlayerScript — XP, reputation, profession skill, creature money
// ---------------------------------------------------------------------------

class NostrumRatesPlayerScript : public PlayerScript
{
public:
    NostrumRatesPlayerScript() : PlayerScript("NostrumRatesPlayerScript",
        {
            PLAYERHOOK_ON_GIVE_EXP,
            PLAYERHOOK_ON_GIVE_REPUTATION,
            PLAYERHOOK_ON_BEFORE_LOOT_MONEY,
            PLAYERHOOK_ON_UPDATE_GATHERING_SKILL,
            PLAYERHOOK_ON_UPDATE_CRAFTING_SKILL,
        })
    {
    }

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* victim, uint8 xpSource) override
    {
        if (!gCfg.enabled)
            return;

        float rate = 1.0f;

        switch (xpSource)
        {
            case XPSOURCE_KILL:
            {
                if (victim && victim->GetTypeId() == TYPEID_UNIT)
                {
                    bool inInstance = player->GetMap()->IsDungeon() || player->GetMap()->IsRaid();
                    if (inInstance)
                        rate = ResolveXPRate(player, &LevelRangeEntry::kill, gCfg.xpDungeon);
                    else if (victim->ToCreature()->isElite())
                        rate = ResolveXPRate(player, &LevelRangeEntry::kill, gCfg.xpElite);
                    else
                        rate = ResolveXPRate(player, &LevelRangeEntry::kill, gCfg.xpKill);
                }
                else
                    rate = ResolveXPRate(player, &LevelRangeEntry::kill, gCfg.xpKill);
                break;
            }
            case XPSOURCE_QUEST:
            case XPSOURCE_QUEST_DF:
                rate = ResolveXPRate(player, &LevelRangeEntry::quest, gCfg.xpQuest);
                break;
            case XPSOURCE_EXPLORE:
                rate = ResolveXPRate(player, &LevelRangeEntry::explore, gCfg.xpExplore);
                break;
            case XPSOURCE_BATTLEGROUND:
                rate = gCfg.xpBattleground;
                break;
            default:
                break;
        }

        if (rate != 1.0f)
            amount = uint32(amount * rate);
    }

    void OnPlayerGiveReputation(Player* /*player*/, int32 /*factionID*/, float& amount,
                                ReputationSource repSource) override
    {
        if (!gCfg.enabled)
            return;

        switch (repSource)
        {
            case REPUTATION_SOURCE_KILL:
                amount *= gCfg.repKill;
                break;
            case REPUTATION_SOURCE_QUEST:
            case REPUTATION_SOURCE_DAILY_QUEST:
            case REPUTATION_SOURCE_WEEKLY_QUEST:
            case REPUTATION_SOURCE_MONTHLY_QUEST:
            case REPUTATION_SOURCE_REPEATABLE_QUEST:
                amount *= gCfg.repQuest;
                break;
            default:
                break;
        }
    }

    void OnPlayerBeforeLootMoney(Player* /*player*/, Loot* loot) override
    {
        if (!gCfg.enabled || gCfg.moneyCreature == 1.0f || loot->gold == 0)
            return;
        loot->gold = uint32(loot->gold * gCfg.moneyCreature);
    }

    void OnPlayerUpdateGatheringSkill(Player* /*player*/, uint32 /*skillId*/, uint32 /*current*/,
                                      uint32 /*gray*/, uint32 /*green*/, uint32 /*yellow*/,
                                      uint32& gain) override
    {
        if (!gCfg.enabled || gCfg.profGathering == 1.0f)
            return;
        gain = std::max(1u, uint32(gain * gCfg.profGathering));
    }

    void OnPlayerUpdateCraftingSkill(Player* /*player*/, SkillLineAbilityEntry const* /*skill*/,
                                     uint32 /*currentLevel*/, uint32& gain) override
    {
        if (!gCfg.enabled || gCfg.profCrafting == 1.0f)
            return;
        gain = std::max(1u, uint32(gain * gCfg.profCrafting));
    }
};

// ---------------------------------------------------------------------------
// FormulaScript — honor gain
// ---------------------------------------------------------------------------

class NostrumRatesFormulaScript : public FormulaScript
{
public:
    NostrumRatesFormulaScript() : FormulaScript("NostrumRatesFormulaScript",
        { FORMULAHOOK_ON_HONOR_CALCULATION })
    {
    }

    void OnHonorCalculation(float& honor, uint8 /*level*/, float /*multiplier*/) override
    {
        if (!gCfg.enabled || gCfg.pvpHonor == 1.0f)
            return;
        honor *= gCfg.pvpHonor;
    }
};

// ---------------------------------------------------------------------------
// ArenaTeamScript — arena points
// ---------------------------------------------------------------------------

class NostrumRatesArenaTeamScript : public ArenaTeamScript
{
public:
    NostrumRatesArenaTeamScript() : ArenaTeamScript("NostrumRatesArenaTeamScript",
        { ARENATEAMHOOK_ON_GET_ARENA_POINTS })
    {
    }

    void OnGetArenaPoints(ArenaTeam* /*team*/, float& points) override
    {
        if (!gCfg.enabled || gCfg.pvpArenaPoints == 1.0f)
            return;
        points *= gCfg.pvpArenaPoints;
    }
};

// ---------------------------------------------------------------------------
// GlobalScript — loot drop chance
// ---------------------------------------------------------------------------

class NostrumRatesGlobalScript : public GlobalScript
{
public:
    NostrumRatesGlobalScript() : GlobalScript("NostrumRatesGlobalScript",
        { GLOBALHOOK_ON_ITEM_ROLL })
    {
    }

    // Returning true lets the roll proceed (with the modified chance).
    // Returning false cancels the drop entirely.
    bool OnItemRoll(Player const* /*player*/, LootStoreItem const* /*item*/, float& chance,
                    Loot& /*loot*/, LootStore const& store) override
    {
        if (!gCfg.enabled)
            return true;

        float rate = GetLootRate(store.GetName());
        if (rate != 1.0f)
            chance *= rate;

        return true;
    }
};

// ---------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------

void Addmod_nostrum_ratesScripts()
{
    new NostrumRatesWorldScript();
    new NostrumRatesPlayerScript();
    new NostrumRatesFormulaScript();
    new NostrumRatesArenaTeamScript();
    new NostrumRatesGlobalScript();
}
