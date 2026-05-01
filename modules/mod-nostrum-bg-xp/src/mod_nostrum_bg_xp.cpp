/*
 * mod-nostrum-bg-xp
 *
 * Grants configurable XP for battleground participation on NostrumWoW.
 * XP is calculated from completion, win/loss, objectives, and optional HK.
 * Anti-AFK: players below a contribution threshold receive no XP.
 *
 * IMPORTANT: Call player->GiveXP() directly — the OnPlayerGiveXP hook
 * is NOT fired, so this XP bypasses mod-nostrum-rates multipliers.
 * This is intentional: BG XP is separately configured here.
 *
 * Requires DB table: character_bg_xp_daily (see data/sql/...)
 */

#include "AllBattlegroundScript.h"
#include "Battleground.h"
#include "BattlegroundScore.h"
#include "Chat.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "PlayerScript.h"
#include "SharedDefines.h"
#include "WorldScript.h"
#include <ctime>
#include <sstream>
#include <unordered_map>

namespace
{

// ---------------------------------------------------------------------------
// Config
// ---------------------------------------------------------------------------

struct LevelRangeEntry
{
    uint8 min;
    uint8 max;
    float completionPercent;
};

struct BGXPConfig
{
    bool  enabled             = true;
    bool  debug               = false;
    uint8 minLevel            = 10;
    uint8 maxLevel            = 79;

    // Completion XP
    bool  completionEnabled   = true;
    float completionPercent   = 0.035f;
    float completionMult      = 1.0f;

    // Win / loss
    float winMult             = 1.0f;
    float lossMult            = 0.35f;

    // Objective XP (computed from BG score attrs at end)
    bool  objectiveEnabled    = true;
    float objectivePercent    = 0.005f;
    float objectiveMult       = 1.0f;
    uint32 maxObjectiveEvents = 10;

    // HK XP (disabled by default)
    bool  hkEnabled           = false;
    float hkPercent           = 0.001f;
    uint32 maxHKPerBG         = 25;

    // Daily first win
    bool  dailyWinEnabled     = true;
    float dailyWinMult        = 2.0f;
    uint8 dailyWinResetHour   = 6;

    // Participation / anti-AFK
    bool  requireParticipation  = true;
    int32 minContribution       = 1;
    int32 contribHKPoints       = 1;
    int32 contribObjPoints      = 3;
    uint32 contribDamageThresh  = 1000;
    uint32 contribHealThresh    = 1000;
    int32 contribDamagePoints   = 1;
    int32 contribHealPoints     = 1;
    uint32 noPartWinXP          = 0;
    uint32 noPartLossXP         = 0;

    // Level range overrides
    bool levelRangeEnabled      = true;
    std::vector<LevelRangeEntry> levelRanges;

    // BG type multipliers (keyed by BattlegroundTypeId)
    std::unordered_map<uint8, float> bgMultipliers;

    // Announcements
    bool announceXP             = true;
    bool announceNoParticipation = true;
};

BGXPConfig gCfg;

// Per-player in-memory state
// Last daily win date (YYYYMMDD) per player. Loaded from DB on login.
std::unordered_map<ObjectGuid, uint32> gDailyWin;

// HK count per player in current BG (for HK XP cap). Reset on BG join.
std::unordered_map<ObjectGuid, uint32> gHKCount;

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

float ValidateMult(std::string const& key, float val, float def)
{
    if (val < 0.0f || val > 100.0f)
    {
        LOG_WARN("module", ">> NostrumBGXP: invalid value for {}, using default {:.3f}", key, def);
        return def;
    }
    return val;
}

float ValidatePct(std::string const& key, float val, float def)
{
    if (val < 0.0f || val > 0.25f)
    {
        LOG_WARN("module", ">> NostrumBGXP: invalid value for {}, using default {:.4f}", key, def);
        return def;
    }
    return val;
}

float LoadMult(std::string const& key, float def)
{
    return ValidateMult(key, sConfigMgr->GetOption<float>(key, def), def);
}

float LoadPct(std::string const& key, float def)
{
    return ValidatePct(key, sConfigMgr->GetOption<float>(key, def), def);
}

void ParseLevelRanges()
{
    gCfg.levelRanges.clear();

    std::string brackets = sConfigMgr->GetOption<std::string>(
        "NostrumBGXP.LevelRange.Brackets", "10-19,20-29,30-39,40-49,50-59,60-69,70-79");

    std::istringstream ss(brackets);
    std::string tok;
    while (std::getline(ss, tok, ','))
    {
        auto s = tok.find_first_not_of(" \t");
        auto e = tok.find_last_not_of(" \t");
        if (s == std::string::npos)
            continue;
        tok = tok.substr(s, e - s + 1);

        size_t dash = tok.find('-');
        if (dash == std::string::npos || dash == 0)
        {
            LOG_WARN("module", ">> NostrumBGXP: malformed level range '{}', skipping", tok);
            continue;
        }

        int32 lo = 0, hi = 0;
        try { lo = std::stoi(tok.substr(0, dash)); hi = std::stoi(tok.substr(dash + 1)); }
        catch (...) { LOG_WARN("module", ">> NostrumBGXP: malformed level range '{}', skipping", tok); continue; }

        if (lo < 1 || hi > 80 || lo > hi)
        {
            LOG_WARN("module", ">> NostrumBGXP: level range {}-{} out of bounds, skipping", lo, hi);
            continue;
        }

        std::string key = "NostrumBGXP.LevelRange." + tok + ".CompletionPercent";
        LevelRangeEntry entry;
        entry.min               = static_cast<uint8>(lo);
        entry.max               = static_cast<uint8>(hi);
        entry.completionPercent = LoadPct(key, gCfg.completionPercent);
        gCfg.levelRanges.push_back(entry);
    }
}

void LoadConfig()
{
    gCfg = {};

    gCfg.enabled   = sConfigMgr->GetOption<bool>("NostrumBGXP.Enable", true);
    gCfg.debug     = sConfigMgr->GetOption<bool>("NostrumBGXP.Debug", false);

    if (!gCfg.enabled)
    {
        LOG_INFO("module", ">> NostrumBGXP: module disabled");
        return;
    }

    uint8 minLvl = sConfigMgr->GetOption<uint8>("NostrumBGXP.MinLevel", 10);
    uint8 maxLvl = sConfigMgr->GetOption<uint8>("NostrumBGXP.MaxLevel", 79);
    gCfg.minLevel = (minLvl < 1) ? 1 : minLvl;
    gCfg.maxLevel = (maxLvl > 80) ? 80 : maxLvl;

    // Completion XP
    gCfg.completionEnabled = sConfigMgr->GetOption<bool>("NostrumBGXP.CompletionXP.Enable", true);
    gCfg.completionPercent = LoadPct("NostrumBGXP.CompletionXP.PercentOfLevel", 0.035f);
    gCfg.completionMult    = LoadMult("NostrumBGXP.CompletionXP.BaseMultiplier", 1.0f);
    gCfg.winMult           = LoadMult("NostrumBGXP.WinMultiplier", 1.0f);
    gCfg.lossMult          = LoadMult("NostrumBGXP.LossMultiplier", 0.35f);

    // Objective XP
    gCfg.objectiveEnabled    = sConfigMgr->GetOption<bool>("NostrumBGXP.ObjectiveXP.Enable", true);
    gCfg.objectivePercent    = LoadPct("NostrumBGXP.ObjectiveXP.PercentOfLevel", 0.005f);
    gCfg.objectiveMult       = LoadMult("NostrumBGXP.ObjectiveXP.Multiplier", 1.0f);
    gCfg.maxObjectiveEvents  = sConfigMgr->GetOption<uint32>("NostrumBGXP.ObjectiveXP.MaxEventsPerBG", 10);

    // HK XP
    gCfg.hkEnabled    = sConfigMgr->GetOption<bool>("NostrumBGXP.HonorableKillXP.Enable", false);
    gCfg.hkPercent    = LoadPct("NostrumBGXP.HonorableKillXP.PercentOfLevel", 0.001f);
    gCfg.maxHKPerBG   = sConfigMgr->GetOption<uint32>("NostrumBGXP.HonorableKillXP.MaxEventsPerBG", 25);

    // Daily first win
    gCfg.dailyWinEnabled   = sConfigMgr->GetOption<bool>("NostrumBGXP.DailyFirstWin.Enable", true);
    gCfg.dailyWinMult      = LoadMult("NostrumBGXP.DailyFirstWin.Multiplier", 2.0f);
    gCfg.dailyWinResetHour = sConfigMgr->GetOption<uint8>("NostrumBGXP.DailyFirstWin.ResetHour", 6);
    gCfg.dailyWinResetHour = std::min<uint8>(gCfg.dailyWinResetHour, 23);

    // Participation
    gCfg.requireParticipation = sConfigMgr->GetOption<bool>("NostrumBGXP.RequireParticipation", true);
    gCfg.minContribution      = sConfigMgr->GetOption<int32>("NostrumBGXP.MinimumContributionScore", 1);
    gCfg.contribHKPoints      = sConfigMgr->GetOption<int32>("NostrumBGXP.Contribution.HonorKill", 1);
    gCfg.contribObjPoints     = sConfigMgr->GetOption<int32>("NostrumBGXP.Contribution.Objective", 3);
    gCfg.contribDamageThresh  = sConfigMgr->GetOption<uint32>("NostrumBGXP.Contribution.DamageDoneThreshold", 1000);
    gCfg.contribHealThresh    = sConfigMgr->GetOption<uint32>("NostrumBGXP.Contribution.HealingDoneThreshold", 1000);
    gCfg.contribDamagePoints  = sConfigMgr->GetOption<int32>("NostrumBGXP.Contribution.DamageDonePoints", 1);
    gCfg.contribHealPoints    = sConfigMgr->GetOption<int32>("NostrumBGXP.Contribution.HealingDonePoints", 1);
    gCfg.noPartWinXP          = sConfigMgr->GetOption<uint32>("NostrumBGXP.NoParticipationWinXP", 0);
    gCfg.noPartLossXP         = sConfigMgr->GetOption<uint32>("NostrumBGXP.NoParticipationLossXP", 0);

    // Level ranges
    gCfg.levelRangeEnabled = sConfigMgr->GetOption<bool>("NostrumBGXP.LevelRange.Enable", true);
    if (gCfg.levelRangeEnabled)
        ParseLevelRanges();

    // BG multipliers
    gCfg.bgMultipliers.clear();
    gCfg.bgMultipliers[BATTLEGROUND_WS] = LoadMult("NostrumBGXP.Battleground.WSG.Multiplier",  1.0f);
    gCfg.bgMultipliers[BATTLEGROUND_AB] = LoadMult("NostrumBGXP.Battleground.AB.Multiplier",   1.0f);
    gCfg.bgMultipliers[BATTLEGROUND_AV] = LoadMult("NostrumBGXP.Battleground.AV.Multiplier",   1.0f);
    gCfg.bgMultipliers[BATTLEGROUND_EY] = LoadMult("NostrumBGXP.Battleground.EOTS.Multiplier", 1.0f);
    gCfg.bgMultipliers[BATTLEGROUND_SA] = LoadMult("NostrumBGXP.Battleground.SOTA.Multiplier", 1.0f);
    gCfg.bgMultipliers[BATTLEGROUND_IC] = LoadMult("NostrumBGXP.Battleground.IOC.Multiplier",  1.0f);

    // Announcements
    gCfg.announceXP             = sConfigMgr->GetOption<bool>("NostrumBGXP.AnnounceXP", true);
    gCfg.announceNoParticipation = sConfigMgr->GetOption<bool>("NostrumBGXP.AnnounceNoParticipation", true);

    LOG_INFO("module", ">> NostrumBGXP: module enabled");
    LOG_INFO("module", ">> NostrumBGXP: level range = {}-{}", gCfg.minLevel, gCfg.maxLevel);
    LOG_INFO("module", ">> NostrumBGXP: completion XP = {:.1f}% of level", gCfg.completionPercent * 100.0f);
    LOG_INFO("module", ">> NostrumBGXP: win multiplier = {:.2f}", gCfg.winMult);
    LOG_INFO("module", ">> NostrumBGXP: loss multiplier = {:.2f}", gCfg.lossMult);
    LOG_INFO("module", ">> NostrumBGXP: daily first win = {}, multiplier {:.2f}",
             gCfg.dailyWinEnabled ? "enabled" : "disabled", gCfg.dailyWinMult);
    LOG_INFO("module", ">> NostrumBGXP: participation required = {}",
             gCfg.requireParticipation ? "enabled" : "disabled");
}

// Returns a date key YYYYMMDD adjusted for the configured reset hour (UTC).
uint32 GetCurrentDateKey()
{
    std::time_t now = std::time(nullptr);
    std::tm t{};
#ifdef _WIN32
    gmtime_s(&t, &now);
#else
    gmtime_r(&now, &t);
#endif
    if (t.tm_hour < gCfg.dailyWinResetHour)
    {
        now -= 24 * 3600;
#ifdef _WIN32
        gmtime_s(&t, &now);
#else
        gmtime_r(&now, &t);
#endif
    }
    return (uint32)((t.tm_year + 1900) * 10000 + (t.tm_mon + 1) * 100 + t.tm_mday);
}

// Returns completion percent for the player's level (level-range override or global).
float GetCompletionPercent(uint8 level)
{
    if (gCfg.levelRangeEnabled)
        for (LevelRangeEntry const& r : gCfg.levelRanges)
            if (level >= r.min && level <= r.max)
                return r.completionPercent;
    return gCfg.completionPercent;
}

float GetBGMultiplier(BattlegroundTypeId typeId)
{
    auto it = gCfg.bgMultipliers.find(static_cast<uint8>(typeId));
    return it != gCfg.bgMultipliers.end() ? it->second : 1.0f;
}

// Calculates contribution score from BG end-of-match stats.
int32 CalcContribution(BattlegroundScore const* score)
{
    int32 c = 0;
    c += (int32)score->GetHonorableKills() * gCfg.contribHKPoints;
    c += (int32)(score->GetAttr1() + score->GetAttr2()) * gCfg.contribObjPoints;
    if (score->GetDamageDone() >= gCfg.contribDamageThresh)
        c += gCfg.contribDamagePoints;
    if (score->GetHealingDone() >= gCfg.contribHealThresh)
        c += gCfg.contribHealPoints;
    return c;
}

} // anonymous namespace

// ---------------------------------------------------------------------------
// WorldScript — config loading
// ---------------------------------------------------------------------------

class NostrumBGXPWorldScript : public WorldScript
{
public:
    NostrumBGXPWorldScript() : WorldScript("NostrumBGXPWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD })
    {
    }

    void OnAfterConfigLoad(bool reload) override
    {
        LoadConfig();
        if (reload)
            LOG_INFO("module", ">> NostrumBGXP: config reloaded");
    }
};

// ---------------------------------------------------------------------------
// PlayerScript — login/logout (daily win), PvP kill (HK XP)
// ---------------------------------------------------------------------------

class NostrumBGXPPlayerScript : public PlayerScript
{
public:
    NostrumBGXPPlayerScript() : PlayerScript("NostrumBGXPPlayerScript",
        {
            PLAYERHOOK_ON_LOGIN,
            PLAYERHOOK_ON_LOGOUT,
            PLAYERHOOK_ON_PVP_KILL,
        })
    {
    }

    void OnPlayerLogin(Player* player) override
    {
        if (!gCfg.enabled || !gCfg.dailyWinEnabled)
            return;

        QueryResult result = CharacterDatabase.Query(
            "SELECT last_win_date FROM character_bg_xp_daily WHERE guid = {}",
            player->GetGUID().GetCounter());

        if (result)
            gDailyWin[player->GetGUID()] = result->Fetch()[0].Get<uint32>();
    }

    void OnPlayerLogout(Player* player) override
    {
        auto it = gDailyWin.find(player->GetGUID());
        if (it != gDailyWin.end())
        {
            CharacterDatabase.Execute(
                "REPLACE INTO character_bg_xp_daily (guid, last_win_date) VALUES ({}, {})",
                player->GetGUID().GetCounter(), it->second);
            gDailyWin.erase(it);
        }

        gHKCount.erase(player->GetGUID());
    }

    // Optional HK XP — disabled by default.
    void OnPlayerPVPKill(Player* killer, Player* /*killed*/) override
    {
        if (!gCfg.enabled || !gCfg.hkEnabled)
            return;
        if (!killer->InBattleground())
            return;

        uint8 level = killer->GetLevel();
        if (level < gCfg.minLevel || level > gCfg.maxLevel)
            return;

        uint32& count = gHKCount[killer->GetGUID()];
        if (count >= gCfg.maxHKPerBG)
            return;

        uint32 nextLevelXP = sObjectMgr->GetXPForLevel(level);
        uint32 xp = uint32(nextLevelXP * gCfg.hkPercent);
        if (xp == 0)
            return;

        killer->GiveXP(xp, nullptr);
        ++count;

        if (gCfg.debug)
            LOG_DEBUG("module", ">> NostrumBGXP: [{}] HK XP +{} (HK #{}/{})",
                      killer->GetName(), xp, count, gCfg.maxHKPerBG);
    }
};

// ---------------------------------------------------------------------------
// AllBattlegroundScript — end reward, player join/leave
// ---------------------------------------------------------------------------

class NostrumBGXPBattlegroundScript : public AllBattlegroundScript
{
public:
    NostrumBGXPBattlegroundScript() : AllBattlegroundScript("NostrumBGXPBattlegroundScript",
        {
            ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_END_REWARD,
            ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_ADD_PLAYER,
            ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_REMOVE_PLAYER_AT_LEAVE,
        })
    {
    }

    void OnBattlegroundAddPlayer(Battleground* /*bg*/, Player* player) override
    {
        // Reset per-BG HK count on join.
        gHKCount[player->GetGUID()] = 0;
    }

    void OnBattlegroundRemovePlayerAtLeave(Battleground* /*bg*/, Player* player) override
    {
        gHKCount.erase(player->GetGUID());
    }

    void OnBattlegroundEndReward(Battleground* bg, Player* player, TeamId winnerTeamId) override
    {
        if (!gCfg.enabled || !gCfg.completionEnabled)
            return;
        if (!bg->isBattleground())
            return; // skip arenas

        uint8 level = player->GetLevel();
        if (level < gCfg.minLevel || level > gCfg.maxLevel)
            return;

        // ---- Contribution check ----------------------------------------
        BattlegroundScore const* score = nullptr;
        {
            auto const* scores = bg->GetPlayerScores();
            auto it = scores->find(player->GetGUID().GetCounter());
            if (it != scores->end())
                score = it->second;
        }

        bool didWin = (winnerTeamId != TEAM_NEUTRAL)
                      && (player->GetBgTeamId() == winnerTeamId);
        bool isDraw = (winnerTeamId == TEAM_NEUTRAL);

        int32 contribution = score ? CalcContribution(score) : 0;
        bool participated = (contribution >= gCfg.minContribution);

        if (gCfg.requireParticipation && !participated)
        {
            uint32 fallbackXP = (didWin || isDraw) ? gCfg.noPartWinXP : gCfg.noPartLossXP;
            if (fallbackXP > 0)
                player->GiveXP(fallbackXP, nullptr);

            if (gCfg.announceNoParticipation)
                ChatHandler(player->GetSession()).PSendSysMessage(
                    "|cffff6666[NostrumWoW]|r You did not earn battleground XP — participation requirement not met.");

            if (gCfg.debug)
                LOG_DEBUG("module", ">> NostrumBGXP: [{}] no participation (score {}) — granted fallback {}",
                          player->GetName(), contribution, fallbackXP);
            return;
        }

        // ---- Base completion XP ----------------------------------------
        float completionPct = GetCompletionPercent(level);
        float bgMult        = GetBGMultiplier(bg->GetBgTypeID(true));
        uint32 nextLevelXP  = sObjectMgr->GetXPForLevel(level);
        float wlMult        = (didWin || isDraw) ? gCfg.winMult : gCfg.lossMult;

        uint32 totalXP = uint32(nextLevelXP * completionPct * gCfg.completionMult * bgMult * wlMult);

        // ---- Objective XP ----------------------------------------------
        uint32 objectiveXP = 0;
        if (gCfg.objectiveEnabled && score)
        {
            uint32 objEvents = std::min(score->GetAttr1() + score->GetAttr2(),
                                        gCfg.maxObjectiveEvents);
            objectiveXP = uint32(nextLevelXP * gCfg.objectivePercent * gCfg.objectiveMult * objEvents);
            totalXP += objectiveXP;
        }

        // ---- Daily first win bonus -------------------------------------
        bool dailyApplied = false;
        if (gCfg.dailyWinEnabled && didWin)
        {
            uint32 today = GetCurrentDateKey();
            auto& lastWin = gDailyWin[player->GetGUID()];
            if (lastWin != today)
            {
                totalXP    = uint32(totalXP * gCfg.dailyWinMult);
                lastWin    = today;
                dailyApplied = true;
            }
        }

        if (totalXP == 0)
            return;

        player->GiveXP(totalXP, nullptr);

        // ---- Announce --------------------------------------------------
        if (gCfg.announceXP)
        {
            if (dailyApplied)
                ChatHandler(player->GetSession()).PSendSysMessage(
                    "|cff00ff00[NostrumWoW]|r You earned {} XP from the battleground! (Daily first win bonus applied)",
                    totalXP);
            else
                ChatHandler(player->GetSession()).PSendSysMessage(
                    "|cff00ff00[NostrumWoW]|r You earned {} XP from the battleground!",
                    totalXP);
        }

        if (gCfg.debug)
            LOG_DEBUG("module",
                ">> NostrumBGXP: [{}] lv{} won={} contrib={} baseXP={} objXP={} daily={} total={}",
                player->GetName(), level, didWin, contribution,
                totalXP - objectiveXP - (dailyApplied ? uint32(totalXP * (1.0f - 1.0f / gCfg.dailyWinMult)) : 0),
                objectiveXP, dailyApplied, totalXP);

        // Clean up HK count entry — player is done with this BG.
        gHKCount.erase(player->GetGUID());
    }
};

// ---------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------

void Addmod_nostrum_bg_xpScripts()
{
    new NostrumBGXPWorldScript();
    new NostrumBGXPPlayerScript();
    new NostrumBGXPBattlegroundScript();
}
