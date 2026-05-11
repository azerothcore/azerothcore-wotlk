/*
 * mod-nostrum-guide
 *
 * Server onboarding hub NPCs in every starting zone.
 * Alliance: Loremaster Caedric, Horde: Elder Gromak.
 *
 * Reads phase/rates from actual shared config keys:
 *   Nostrum.Progression.Era / Nostrum.Progression.Phase  (shared with mod-nostrum-rates, mod-nostrum-progression)
 *   NostrumRates.*       (owned by mod-nostrum-rates)
 *
 * Provides Hardcore enrollment flow and World Chat join.
 *
 * Static detail text lives in npc_text entries (900001, 900010-900015) in SQL.
 * Only TEXT_FEATURES (900011) is dynamic — written in OnAfterConfigLoad()
 * from current phase/rates config. Gossip options are short button labels only.
 */

#include "Channel.h"
#include <algorithm>
#include "ChannelMgr.h"
#include "Chat.h"
#include "Config.h"
#include "CreatureScript.h"

#include "GossipDef.h"
#include "Log.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "StringFormat.h"
#include "WorldScript.h"

namespace
{

// npc_text entry for the greeting body text (exists in SQL)
constexpr uint32 TEXT_MAIN = 900001;

// Phase bracket table -- must match mod-nostrum-rates
struct PhaseInfo
{
    uint8       number;
    uint8       minLevel;
    uint8       maxLevel;
    char const* label;
};

static constexpr PhaseInfo kPhases[8] =
{
    { 0,  0,  0,  "Beta"           },
    { 1,  1, 19,  "Phase 1 (1-19)" },
    { 2, 19, 29,  "Phase 2 (19-29)"},
    { 3, 29, 39,  "Phase 3 (29-39)"},
    { 4, 39, 49,  "Phase 4 (39-49)"},
    { 5, 49, 60,  "Phase 5 (49-60)"},
    { 6, 60, 70,  "Phase 6 (60-70)"},
    { 7, 70, 80,  "Phase 7 (70-80)"},
};

static constexpr uint8 kMaxPhase = 7;

enum GuideAction : uint32
{
    ACTION_MAIN       = 0,
    ACTION_CLOSE      = 1,
    ACTION_WHAT_IS    = 10,
    ACTION_FEATURES   = 20,
    ACTION_HARDCORE   = 30,
    ACTION_HC_ENABLE  = 31,
    ACTION_HC_CONFIRM = 32,
    ACTION_SF_ENABLE  = 33,
    ACTION_SF_CONFIRM = 34,
    ACTION_WORLDCHAT  = 40,
    ACTION_WC_JOIN    = 41,
};

struct GuideConfig
{
    bool   enabled           = true;
    bool   debug             = false;

    uint32 allianceNpcEntry  = 900001;
    uint32 hordeNpcEntry     = 900002;

    bool   visualCueEnable   = true;
    uint32 visualCueGoEntry  = 149410;

    // Phase -- derived from Nostrum.Progression.Era/Phase + bracket table
    uint8      activePhase   = 1;
    std::string phaseLabel;
    uint8      levelCap      = 19;

    // Rates -- read from NostrumRates.* (owned by mod-nostrum-rates)
    float xpBetaRate         = 3.0f;
    float xpCurrentRate      = 1.0f;
    float xpCatchUpRate      = 2.0f;
    float profGatheringRate  = 1.0f;
    float profCraftingRate   = 1.0f;
    float lootRate           = 1.0f;
    float moneyRate          = 1.0f;
    float repKillRate        = 1.0f;
    float repQuestRate       = 1.0f;

    std::string ratesText;

    std::string websiteUrl       = "nostrumwow.com";
    std::string worldChannelName = "world";
};

GuideConfig gCfg;

void LoadConfig()
{
    gCfg.enabled           = sConfigMgr->GetOption<bool>  ("NostrumGuide.Enable", true);
    gCfg.debug             = sConfigMgr->GetOption<bool>  ("NostrumGuide.Debug", false);

    gCfg.allianceNpcEntry  = sConfigMgr->GetOption<uint32>("NostrumGuide.AllianceNpcEntry", 900001);
    gCfg.hordeNpcEntry     = sConfigMgr->GetOption<uint32>("NostrumGuide.HordeNpcEntry", 900002);

    gCfg.visualCueEnable   = sConfigMgr->GetOption<bool>  ("NostrumGuide.VisualCue.Enable", true);
    gCfg.visualCueGoEntry  = sConfigMgr->GetOption<uint32>("NostrumGuide.VisualCue.GameObjectEntry", 149410);

    // Phase -- derived from Era/Phase, shared with mod-nostrum-rates and mod-nostrum-progression
    uint32 era      = sConfigMgr->GetOption<uint32>("Nostrum.Progression.Era",   1);
    uint32 rawPhase = sConfigMgr->GetOption<uint32>("Nostrum.Progression.Phase", 1);
    if (era < 1 || era > 3) era = 1;
    if (rawPhase < 1) rawPhase = 1;

    uint8 flatPhase;
    if (era >= 3)       flatPhase = 7;
    else if (era == 2)  flatPhase = 6;
    else                flatPhase = static_cast<uint8>(std::min<uint32>(rawPhase, 5));

    gCfg.activePhase = flatPhase;
    gCfg.phaseLabel  = kPhases[gCfg.activePhase].label;
    gCfg.levelCap    = kPhases[gCfg.activePhase].maxLevel;

    // Rates -- read from NostrumRates.* (owned by mod-nostrum-rates)
    gCfg.xpBetaRate        = sConfigMgr->GetOption<float>("NostrumRates.XP.BetaRate", 3.0f);
    gCfg.xpCurrentRate     = sConfigMgr->GetOption<float>("NostrumRates.XP.CurrentPhaseRate", 1.0f);
    gCfg.xpCatchUpRate     = sConfigMgr->GetOption<float>("NostrumRates.XP.CatchUpRate", 2.0f);
    gCfg.profGatheringRate = sConfigMgr->GetOption<float>("NostrumRates.Profession.GatheringSkillGain", 1.0f);
    gCfg.profCraftingRate  = sConfigMgr->GetOption<float>("NostrumRates.Profession.CraftingSkillGain", 1.0f);
    gCfg.lootRate          = sConfigMgr->GetOption<float>("NostrumRates.Loot.Creature", 1.0f);
    gCfg.moneyRate         = sConfigMgr->GetOption<float>("NostrumRates.Money.Creature", 1.0f);
    gCfg.repKillRate       = sConfigMgr->GetOption<float>("NostrumRates.Reputation.Kill", 1.0f);
    gCfg.repQuestRate      = sConfigMgr->GetOption<float>("NostrumRates.Reputation.Quest", 1.0f);

    gCfg.ratesText = sConfigMgr->GetOption<std::string>("NostrumGuide.RatesText",
        "XP is phase-driven. Current bracket: blizzlike. Previous brackets: catch-up.");

    gCfg.websiteUrl = sConfigMgr->GetOption<std::string>("NostrumGuide.WebsiteUrl",
        "nostrumwow.com");

    gCfg.worldChannelName = sConfigMgr->GetOption<std::string>("WorldChat.ChannelName", "world");
}

// ---------------------------------------------------------------------------
// npc_text helpers
// ---------------------------------------------------------------------------

std::string BuildFeaturesText()
{
    std::string xpSummary;
    if (gCfg.activePhase == 0)
        xpSummary = Acore::StringFormat("{:.1f}x (beta flat rate)", gCfg.xpBetaRate);
    else
        xpSummary = Acore::StringFormat("{:.1f}x current / {:.1f}x catch-up",
            gCfg.xpCurrentRate, gCfg.xpCatchUpRate);

    return Acore::StringFormat(
        "Phase: {} \n"
        " Level cap: {} \n"
        "XP: {} \n"
        "Loot: {:.1f}x  |  Gold: {:.1f}x \n"
        "Professions: {:.1f}x gathering / {:.1f}x crafting  \n"
        "Reputation: {:.1f}x kills / {:.1f}x quests. \n"
        "{}",
        gCfg.phaseLabel, gCfg.levelCap,
        xpSummary,
        gCfg.lootRate, gCfg.moneyRate,
        gCfg.profGatheringRate, gCfg.profCraftingRate,
        gCfg.repKillRate, gCfg.repQuestRate,
        gCfg.ratesText);
}



// ---------------------------------------------------------------------------
// Action helpers
// ---------------------------------------------------------------------------

void RunCommand(Player* player, std::string const& cmd)
{
    ChatHandler(player->GetSession()).ParseCommands(cmd);
}

void JoinWorldChannel(Player* player)
{
    if (gCfg.worldChannelName.empty())
        return;

    if (ChannelMgr* cMgr = ChannelMgr::forTeam(player->GetTeamId()))
        if (Channel* channel = cMgr->GetJoinChannel(gCfg.worldChannelName, 0))
            channel->JoinChannel(player, "");
}

} // anonymous namespace

// ---------------------------------------------------------------------------
// WorldScript -- config loading + npc_text bootstrap
// ---------------------------------------------------------------------------

class NostrumGuideWorldScript : public WorldScript
{
public:
    NostrumGuideWorldScript() : WorldScript("NostrumGuideWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD }) {}

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        LoadConfig();
        LOG_INFO("module", ">> NostrumGuide: loaded. enabled={} phase={}.",
            gCfg.enabled, gCfg.phaseLabel);
    }
};

// ---------------------------------------------------------------------------
// CreatureScript -- onboarding gossip hub
// ---------------------------------------------------------------------------

class nostrum_guide : public CreatureScript
{
public:
    nostrum_guide() : CreatureScript("nostrum_guide") {}

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (!gCfg.enabled)
            return false;

        if (gCfg.debug)
            LOG_INFO("module", "[NostrumGuide] {} opened guide.", player->GetName());

        ShowMainMenu(player, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature,
        uint32 /*sender*/, uint32 action) override
    {
        if (!gCfg.enabled)
        {
            CloseGossipMenuFor(player);
            return true;
        }

        ClearGossipMenuFor(player);

        switch (action)
        {
            case ACTION_MAIN:       ShowMainMenu(player, creature);      break;
            case ACTION_CLOSE:      CloseGossipMenuFor(player);          break;
            case ACTION_WHAT_IS:    ShowWhatIs(player, creature);        break;
            case ACTION_FEATURES:   ShowFeatures(player, creature);      break;
            case ACTION_HARDCORE:   ShowHardcoreMenu(player, creature);  break;
            case ACTION_HC_ENABLE:  DoHcEnable(player, creature);        break;
            case ACTION_HC_CONFIRM: DoConfirm(player);                   break;
            case ACTION_SF_ENABLE:  DoSfEnable(player, creature);        break;
            case ACTION_SF_CONFIRM: DoConfirm(player);                   break;
            case ACTION_WORLDCHAT:  ShowWorldChat(player, creature);     break;
            case ACTION_WC_JOIN:    DoJoinWorldChat(player);             break;
            default:                CloseGossipMenuFor(player);          break;
        }

        return true;
    }

private:

    // ---- Main menu ----

    void ShowMainMenu(Player* player, Creature* creature)
    {
        ClearGossipMenuFor(player);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "What is NostrumWoW?",
            GOSSIP_SENDER_MAIN, ACTION_WHAT_IS);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Server features, phase, and rates",
            GOSSIP_SENDER_MAIN, ACTION_FEATURES);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Hardcore mode",
            GOSSIP_SENDER_MAIN, ACTION_HARDCORE);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "World chat",
            GOSSIP_SENDER_MAIN, ACTION_WORLDCHAT);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Goodbye",
            GOSSIP_SENDER_MAIN, ACTION_CLOSE);
        SendGossipMenuFor(player, TEXT_MAIN, creature->GetGUID());
    }

    // ---- What is NostrumWoW? ----

    void ShowWhatIs(Player* player, Creature* creature)
    {
        ClearGossipMenuFor(player);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT,
            "NostrumWoW is a progressive WotLK \n"
            "server with blizzlike gameplay \n"
            "quality-of-life improvements, optional Hardcore mode, and phased content releases. \n"
            "Website: " + gCfg.websiteUrl,
            GOSSIP_SENDER_MAIN, ACTION_WHAT_IS);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Back",
            GOSSIP_SENDER_MAIN, ACTION_MAIN);
        SendGossipMenuFor(player, TEXT_MAIN, creature->GetGUID());
    }

    // ---- Features, phase & rates ----

    void ShowFeatures(Player* player, Creature* creature)
    {
        ClearGossipMenuFor(player);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT,
            BuildFeaturesText(),
            GOSSIP_SENDER_MAIN, ACTION_FEATURES);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Back",
            GOSSIP_SENDER_MAIN, ACTION_MAIN);
        SendGossipMenuFor(player, TEXT_MAIN, creature->GetGUID());
    }

    // ---- Hardcore mode ----

    void ShowHardcoreMenu(Player* player, Creature* creature)
    {
        ClearGossipMenuFor(player);
        // AddGossipItemFor(player, GOSSIP_ICON_CHAT,
        //     "Hardcore is optional permadeath. One life -- die and your character "
        //     "becomes a permanent ghost. Available on fresh level 1 characters with "
        //     "0 XP and no prior player interaction.  Self-Found adds trade, mail, "
        //     "and Auction House restrictions on top of permadeath.",
        //     GOSSIP_SENDER_MAIN, ACTION_HARDCORE);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Start Hardcore journey",
            GOSSIP_SENDER_MAIN, ACTION_HC_ENABLE);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Start Self-Found journey",
            GOSSIP_SENDER_MAIN, ACTION_SF_ENABLE);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Back",
            GOSSIP_SENDER_MAIN, ACTION_MAIN);
        SendGossipMenuFor(player, TEXT_MAIN, creature->GetGUID());
    }

    void DoHcEnable(Player* player, Creature* creature)
    {
        RunCommand(player, ".hardcore enable");
        ClearGossipMenuFor(player);
        // AddGossipItemFor(player, GOSSIP_ICON_CHAT,
        //     "Hardcore -- IMPORTANT: Death is permanent. PvE and environmental "
        //     "deaths count. Duel deaths do NOT count. Trading, mail, and AH are "
        //     "allowed. You join the Deathwalkers guild. This cannot be undone.",
        //     GOSSIP_SENDER_MAIN, ACTION_HC_ENABLE);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Confirm Hardcore",
            GOSSIP_SENDER_MAIN, ACTION_HC_CONFIRM);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Go back",
            GOSSIP_SENDER_MAIN, ACTION_HARDCORE);
        SendGossipMenuFor(player, TEXT_MAIN, creature->GetGUID());
    }

    void DoSfEnable(Player* player, Creature* creature)
    {
        RunCommand(player, ".hardcore selffound");
        ClearGossipMenuFor(player);
        // AddGossipItemFor(player, GOSSIP_ICON_CHAT,
        //     "Self-Found -- IMPORTANT: Death is permanent. Trading is disabled. "
        //     "Auction House is disabled. Player mail is disabled. You join the "
        //     "Deathwalkers guild. This cannot be undone.",
        //     GOSSIP_SENDER_MAIN, ACTION_SF_ENABLE);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Confirm Self-Found",
            GOSSIP_SENDER_MAIN, ACTION_SF_CONFIRM);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Go back",
            GOSSIP_SENDER_MAIN, ACTION_HARDCORE);
        SendGossipMenuFor(player, TEXT_MAIN, creature->GetGUID());
    }

    void DoConfirm(Player* player)
    {
        RunCommand(player, ".hardcore confirm");
        CloseGossipMenuFor(player);
    }

    // ---- World chat ----

    void ShowWorldChat(Player* player, Creature* creature)
    {
        ClearGossipMenuFor(player);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT,
            "Talk to the entire server! \n "
            "Both factions share one channel. \n"
            ".chat <msg> -- send a message  \n"
            ".chat on / .chat off -- toggle  | \n "
            "Or join manually: /join " + gCfg.worldChannelName,
            GOSSIP_SENDER_MAIN, ACTION_WORLDCHAT);
        // AddGossipItemFor(player, GOSSIP_ICON_TALK, "Join world chat",
        //     GOSSIP_SENDER_MAIN, ACTION_WC_JOIN);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Back",
            GOSSIP_SENDER_MAIN, ACTION_MAIN);
        SendGossipMenuFor(player, TEXT_MAIN, creature->GetGUID());
    }

    void DoJoinWorldChat(Player* player)
    {
        JoinWorldChannel(player);
        ChatHandler(player->GetSession()).PSendSysMessage(
            "Joined the world channel. Use .chat <message> to talk.");
        CloseGossipMenuFor(player);
    }
};

// ---------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------

void Addmod_nostrum_guideScripts()
{
    new NostrumGuideWorldScript();
    new nostrum_guide();
}
