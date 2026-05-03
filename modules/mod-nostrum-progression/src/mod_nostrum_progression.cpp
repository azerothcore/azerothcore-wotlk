/*
 * NostrumWoW Progression Module
 *
 * Enforces the phase level cap driven by a single config value:
 *
 *   Nostrum.ActivePhase = <0-7>
 *
 * The level cap and phase name are derived automatically from the phase table.
 * Changing ActivePhase and running `.reload config` is all that is needed to
 * advance the server to the next phase.
 *
 * Phase table:
 *   0 — Beta    (cap 80, no restriction)
 *   1 — Phase 1 (cap 19)
 *   2 — Phase 2 (cap 29)
 *   3 — Phase 3 (cap 39)
 *   4 — Phase 4 (cap 49)
 *   5 — Phase 5 (cap 60)
 *   6 — Phase 6 (cap 70)
 *   7 — Phase 7 (cap 80, WotLK — Death Knights unlocked)
 */

#include "Chat.h"
#include "Common.h"
#include "Config.h"
#include "Player.h"
#include "PlayerScript.h"
#include "ScriptMgr.h"
#include "WorldScript.h"

namespace
{

// ---------------------------------------------------------------------------
// Phase table
// ---------------------------------------------------------------------------

struct PhaseEntry
{
    uint8       cap;
    char const* name;
};

static constexpr PhaseEntry kPhases[8] =
{
    { 80, "Beta"    }, // 0 — no cap, 3× rates via mod-nostrum-rates
    { 19, "Phase 1" }, // 1
    { 29, "Phase 2" }, // 2
    { 39, "Phase 3" }, // 3
    { 49, "Phase 4" }, // 4
    { 60, "Phase 5" }, // 5 — vanilla endgame
    { 70, "Phase 6" }, // 6 — TBC
    { 80, "Phase 7" }, // 7 — WotLK
};

static constexpr uint8 kMaxPhase = 7;

// ---------------------------------------------------------------------------
// Config
// ---------------------------------------------------------------------------

struct ProgConfig
{
    bool    enabled           = true;
    uint8   activePhase       = 1;
    bool    gmBypass          = true;
    bool    loginAnnouncement = true;
};

ProgConfig gCfg;

void LoadConfig()
{
    gCfg = {};

    gCfg.enabled = sConfigMgr->GetOption<bool>("Nostrum.Progression.Enable", true);

    uint32 phase = sConfigMgr->GetOption<uint32>("Nostrum.ActivePhase", 1);
    if (phase > kMaxPhase)
    {
        LOG_WARN("module", ">> NostrumProgression: ActivePhase {} out of range [0-{}], using 1",
            phase, kMaxPhase);
        phase = 1;
    }
    gCfg.activePhase = static_cast<uint8>(phase);

    gCfg.gmBypass          = sConfigMgr->GetOption<bool>("Nostrum.Progression.GmBypass",          true);
    gCfg.loginAnnouncement = sConfigMgr->GetOption<bool>("Nostrum.Progression.LoginAnnouncement", true);

    LOG_INFO("module", ">> NostrumProgression: {} — cap {} — enabled={}",
        kPhases[gCfg.activePhase].name,
        uint32(kPhases[gCfg.activePhase].cap),
        gCfg.enabled);
}

} // anonymous namespace

// ---------------------------------------------------------------------------
// WorldScript — config reload
// ---------------------------------------------------------------------------

class NostrumProgressionWorldScript : public WorldScript
{
public:
    NostrumProgressionWorldScript() : WorldScript("NostrumProgressionWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD })
    {
    }

    void OnAfterConfigLoad(bool reload) override
    {
        LoadConfig();
        if (reload)
            LOG_INFO("module", ">> NostrumProgression: config reloaded");
    }
};

// ---------------------------------------------------------------------------
// PlayerScript — cap enforcement
// ---------------------------------------------------------------------------

class NostrumProgressionPlayerScript : public PlayerScript
{
public:
    NostrumProgressionPlayerScript() : PlayerScript("NostrumProgressionPlayerScript",
        {
            PLAYERHOOK_ON_LOGIN,
            PLAYERHOOK_ON_LEVEL_CHANGED,
            PLAYERHOOK_ON_GIVE_EXP,
        })
    {
    }

    void OnPlayerLogin(Player* player) override
    {
        if (!gCfg.enabled)
            return;

        uint8       cap  = kPhases[gCfg.activePhase].cap;
        char const* name = kPhases[gCfg.activePhase].name;

        if (IsExempt(player))
        {
            if (gCfg.loginAnnouncement)
                ChatHandler(player->GetSession()).PSendSysMessage(
                    "[NostrumWoW] {} — Level cap: {} (GM bypass active)", name, uint32(cap));
            return;
        }

        if (player->GetLevel() > cap)
            EnforceCap(player, cap, name);

        if (gCfg.loginAnnouncement)
            ChatHandler(player->GetSession()).PSendSysMessage(
                "[NostrumWoW] {} — Current level cap: {}", name, uint32(cap));
    }

    void OnPlayerLevelChanged(Player* player, uint8 /*oldLevel*/) override
    {
        if (!gCfg.enabled || IsExempt(player))
            return;

        uint8 cap = kPhases[gCfg.activePhase].cap;
        if (player->GetLevel() > cap)
            EnforceCap(player, cap, kPhases[gCfg.activePhase].name);
    }

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 /*xpSource*/) override
    {
        if (!gCfg.enabled || IsExempt(player))
            return;

        if (player->GetLevel() >= kPhases[gCfg.activePhase].cap)
            amount = 0;
    }

private:
    bool IsExempt(Player* player) const
    {
        return gCfg.gmBypass && player->GetSession()->GetSecurity() >= SEC_GAMEMASTER;
    }

    void EnforceCap(Player* player, uint8 cap, char const* phaseName) const
    {
        player->GiveLevel(cap);
        player->SetUInt32Value(PLAYER_XP, 0);
        ChatHandler(player->GetSession()).PSendSysMessage(
            "[NostrumWoW] Your level has been set to {} — {} cap enforced.", uint32(cap), phaseName);
    }
};

// ---------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------

void Addmod_nostrum_progressionScripts()
{
    new NostrumProgressionWorldScript();
    new NostrumProgressionPlayerScript();
}
