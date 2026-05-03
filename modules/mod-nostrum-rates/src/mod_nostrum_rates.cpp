/*
 * mod-nostrum-rates
 *
 * Centralizes configurable gameplay rate modifiers for NostrumWoW.
 *
 * Rates are phase-driven:
 *   Phase 0 (beta)   — flat multiplier (default 3×) for all XP.
 *   Phases 1-7       — each phase owns a level bracket.
 *                       Active bracket: 1× (configurable, blizzlike).
 *                       Previous brackets: 2× (configurable, catch-up).
 *
 * Phase brackets:
 *   0: beta    (flat)
 *   1:  1-19
 *   2: 19-29
 *   3: 29-39
 *   4: 39-49
 *   5: 49-60
 *   6: 60-70   (TBC)
 *   7: 70-80   (WotLK)
 *
 * Death Knight creation is blocked while ActivePhase < 7 (configurable).
 */

#include "AccountScript.h"
#include "ArenaTeamScript.h"
#include "Config.h"
#include "Creature.h"
#include "FormulaScript.h"
#include "GlobalScript.h"
#include "LootMgr.h"
#include "Map.h"
#include "Player.h"
#include "PlayerScript.h"
#include "SharedDefines.h"
#include "WorldScript.h"
#include <string_view>

namespace
{

// ---------------------------------------------------------------------------
// Phase table (hardcoded)
// ---------------------------------------------------------------------------

struct PhaseInfo
{
    uint8       number;
    uint8       minLevel;
    uint8       maxLevel;
    char const* label;
};

static constexpr PhaseInfo kPhases[8] =
{
    { 0,  0,  0,  "Phase 0 — Beta (flat rate)"      },
    { 1,  1, 19,  "Phase 1 — 1-19"                  },
    { 2, 19, 29,  "Phase 2 — 19-29"                 },
    { 3, 29, 39,  "Phase 3 — 29-39"                 },
    { 4, 39, 49,  "Phase 4 — 39-49"                 },
    { 5, 49, 60,  "Phase 5 — 49-60 (Vanilla endgame)"},
    { 6, 60, 70,  "Phase 6 — 60-70 (TBC)"           },
    { 7, 70, 80,  "Phase 7 — 70-80 (WotLK)"         },
};

static constexpr uint8 kMaxPhase = 7;

// ---------------------------------------------------------------------------
// Config
// ---------------------------------------------------------------------------

struct NostrumRatesConfig
{
    bool    enabled     = true;
    uint8   activePhase = 1;

    // XP — derived from phase at runtime
    float xpBeta         = 3.0f; // Phase 0: flat multiplier
    float xpCurrentPhase = 1.0f; // Active bracket (blizzlike)
    float xpCatchUp      = 2.0f; // Previous brackets (catch-up)
    float xpBattleground = 1.0f; // Not phase-scaled (handled by mod-nostrum-bg-xp)

    // Reputation
    float repKill  = 1.0f;
    float repQuest = 1.0f;

    // Profession skill gain
    float profGathering = 1.0f;
    float profCrafting  = 1.0f;

    // Loot drop chance multipliers
    // Mining and herbalism share gameobject_loot_template — see conf notes.
    float lootCreature      = 1.0f;
    float lootSkinning      = 1.0f;
    float lootFishing       = 1.0f;
    float lootMining        = 1.0f;
    float lootDisenchanting = 1.0f;
    float lootProspecting   = 1.0f;
    float lootMilling       = 1.0f;

    // Money
    float moneyCreature = 1.0f;

    // PvP
    float pvpHonor       = 1.0f;
    float pvpArenaPoints = 1.0f;

    // Death Knight restriction
    bool blockDKBeforePhase7 = true;
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

void LoadConfig()
{
    gCfg = {};

    gCfg.enabled = sConfigMgr->GetOption<bool>("NostrumRates.Enable", true);
    if (!gCfg.enabled)
    {
        LOG_INFO("module", ">> NostrumRates: module disabled");
        return;
    }

    uint32 phase = sConfigMgr->GetOption<uint32>("Nostrum.ActivePhase", 1);
    if (phase > kMaxPhase)
    {
        LOG_WARN("module", ">> NostrumRates: ActivePhase {} out of range [0-{}], clamping to 1",
            phase, kMaxPhase);
        phase = 1;
    }
    gCfg.activePhase = static_cast<uint8>(phase);

    // XP
    gCfg.xpBeta         = LoadRate("NostrumRates.XP.BetaRate",         3.0f);
    gCfg.xpCurrentPhase = LoadRate("NostrumRates.XP.CurrentPhaseRate", 1.0f);
    gCfg.xpCatchUp      = LoadRate("NostrumRates.XP.CatchUpRate",      2.0f);
    gCfg.xpBattleground = LoadRate("NostrumRates.XP.Battleground",     1.0f);

    // Reputation
    gCfg.repKill  = LoadRate("NostrumRates.Reputation.Kill",  1.0f);
    gCfg.repQuest = LoadRate("NostrumRates.Reputation.Quest", 1.0f);

    // Profession
    gCfg.profGathering = LoadRate("NostrumRates.Profession.GatheringSkillGain", 1.0f);
    gCfg.profCrafting  = LoadRate("NostrumRates.Profession.CraftingSkillGain",  1.0f);

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
        LOG_WARN("module",
            ">> NostrumRates: Loot.Mining ({:.1f}) and Loot.Herbalism ({:.1f}) differ "
            "but both go through gameobject_loot_template — Mining rate will be used for both",
            gCfg.lootMining, herbRate);

    // Money
    gCfg.moneyCreature = LoadRate("NostrumRates.Money.Creature", 1.0f);

    // PvP
    gCfg.pvpHonor       = LoadRate("NostrumRates.PvP.Honor",       1.0f);
    gCfg.pvpArenaPoints = LoadRate("NostrumRates.PvP.ArenaPoints", 1.0f);

    // DK
    gCfg.blockDKBeforePhase7 = sConfigMgr->GetOption<bool>("NostrumRates.BlockDKBeforePhase7", true);

    // Startup log
    LOG_INFO("module", ">> NostrumRates: active = {}", kPhases[gCfg.activePhase].label);
    if (gCfg.activePhase == 0)
        LOG_INFO("module", ">> NostrumRates: XP = {:.1f}x (beta flat rate)", gCfg.xpBeta);
    else
        LOG_INFO("module", ">> NostrumRates: XP current bracket = {:.1f}x  catch-up = {:.1f}x",
            gCfg.xpCurrentPhase, gCfg.xpCatchUp);
    LOG_INFO("module", ">> NostrumRates: XP Battleground = {:.1f}x", gCfg.xpBattleground);
    LOG_INFO("module", ">> NostrumRates: DK creation block = {}",
        (gCfg.blockDKBeforePhase7 && gCfg.activePhase < 7) ? "YES (phase < 7)" : "no");
}

// Returns the effective XP rate for a given player level.
// Scans phase brackets from active phase downward; the first match wins,
// so boundary levels (e.g. 19 appears in both Phase 1 and Phase 2) resolve
// to the higher-numbered (more recent) phase.
float ResolveXPRate(uint8 level)
{
    if (gCfg.activePhase == 0)
        return gCfg.xpBeta;

    for (int p = static_cast<int>(gCfg.activePhase); p >= 1; --p)
    {
        if (level >= kPhases[p].minLevel && level <= kPhases[p].maxLevel)
            return (p == static_cast<int>(gCfg.activePhase))
                ? gCfg.xpCurrentPhase
                : gCfg.xpCatchUp;
    }

    // Level not in any defined bracket — treat as current phase rate.
    return gCfg.xpCurrentPhase;
}

float GetLootRate(char const* storeName)
{
    using sv = std::string_view;
    sv name = storeName;
    if (name == "creature_loot_template")    return gCfg.lootCreature;
    if (name == "skinning_loot_template")    return gCfg.lootSkinning;
    if (name == "fishing_loot_template")     return gCfg.lootFishing;
    if (name == "gameobject_loot_template")  return gCfg.lootMining;
    if (name == "disenchant_loot_template")  return gCfg.lootDisenchanting;
    if (name == "prospecting_loot_template") return gCfg.lootProspecting;
    if (name == "milling_loot_template")     return gCfg.lootMilling;
    return 1.0f;
}

} // anonymous namespace

// ---------------------------------------------------------------------------
// WorldScript — config reload
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

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 xpSource) override
    {
        if (!gCfg.enabled)
            return;

        float rate = 1.0f;

        switch (xpSource)
        {
            case XPSOURCE_KILL:
            case XPSOURCE_QUEST:
            case XPSOURCE_QUEST_DF:
            case XPSOURCE_EXPLORE:
                rate = ResolveXPRate(player->GetLevel());
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
// AccountScript — block Death Knight creation before Phase 7
// ---------------------------------------------------------------------------

class NostrumRatesAccountScript : public AccountScript
{
public:
    NostrumRatesAccountScript() : AccountScript("NostrumRatesAccountScript",
        { ACCOUNTHOOK_CAN_ACCOUNT_CREATE_CHARACTER })
    {
    }

    bool CanAccountCreateCharacter(uint32 /*accountId*/, uint8 /*charRace*/, uint8 charClass) override
    {
        if (!gCfg.enabled || !gCfg.blockDKBeforePhase7)
            return true;

        if (gCfg.activePhase < 7 && charClass == CLASS_DEATH_KNIGHT)
            return false;

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
    new NostrumRatesAccountScript();
}
