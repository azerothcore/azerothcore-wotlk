/*
 * mod-nostrum-guide
 *
 * Spawns first-time onboarding guide NPCs in every starting zone.
 * Both NPCs (Alliance: Loremaster Caedric, Horde: Elder Gromak) share the
 * same CreatureScript and present an information-only gossip menu covering
 * NostrumWoW's features and policies.
 *
 * No vendors, teleporters, quest givers, or reward mechanics in v1.
 */

#include "Config.h"
#include "CreatureScript.h"
#include "GossipDef.h"
#include "Log.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "WorldScript.h"

// ---------------------------------------------------------------------------
// Config
// ---------------------------------------------------------------------------

namespace
{

// npc_text entry used for the main gossip greeting box.
constexpr uint32 NPC_TEXT_MAIN = 900001;

enum GuideGossipAction : uint32
{
    GUIDE_ACTION_MAIN           = 10,
    GUIDE_ACTION_WHAT_IS        = 11,
    GUIDE_ACTION_PHASE          = 12,
    GUIDE_ACTION_RATES          = 13,
    GUIDE_ACTION_HARDCORE       = 14,
    GUIDE_ACTION_WORLDCHAT      = 15,
    GUIDE_ACTION_CROSSFACTION   = 16,
    GUIDE_ACTION_DUNGEONBG      = 17,
    GUIDE_ACTION_WEBSITE        = 18,
    GUIDE_ACTION_COMMANDS       = 19,
    GUIDE_ACTION_CLOSE          = 20,
};

struct GuideConfig
{
    bool        enabled                 = true;

    uint32      allianceNpcEntry        = 900001;
    uint32      hordeNpcEntry           = 900002;
    std::string allianceNpcName         = "Loremaster Caedric";
    std::string hordeNpcName            = "Elder Gromak";
    std::string npcSubName              = "New Player Guide";
    float       npcScale                = 1.15f;
    uint32      allianceModelRef        = 16128;
    uint32      hordeModelRef           = 3057;

    bool        visualCueEnable         = true;
    uint32      visualCueGoEntry        = 149410;
    bool        visualCueSpawnAtNpc     = true;

    std::string websiteUrl              = "https://nostrumwow.com";
    std::string discordUrl              = "https://discord.gg/YOURCODE";

    std::string currentPhaseText        = "Pre-launch / Phase 0";
    std::string levelCapText            = "Current level cap: To be announced";
    std::string ratesText               = "Nostrum uses custom rates designed to respect the original WotLK progression while making the experience smoother.";
    std::string worldChatText           = "Use .chat <message> to talk on the World Chat. Use .chat on / .chat off to enable or disable it.";
    std::string hardcoreText            = "Hardcore mode is optional and can only be enabled on a fresh level 1 character with 0 XP. Hardcore characters have one life, join Deathwalkers, and receive cosmetic rewards.";
    std::string crossFactionText        = "Nostrum keeps faction identity in the open world, but enables selected cross-faction systems to improve queue times, grouping, and server health.";
    std::string dungeonFinderText       = "Dungeon Finder may include both factions to improve queue times and make leveling dungeons easier to run.";
    std::string battlegroundText        = "Battlegrounds may use cross-faction matchmaking to improve queue times and balance.";
    std::string commandsText            = "Useful commands: .hardcore — enable Hardcore mode. .chat <message> — talk on World Chat. .chat on / .chat off — toggle World Chat.";

    bool        debug                   = false;
};

GuideConfig gCfg;

void LoadConfig()
{
    gCfg.enabled            = sConfigMgr->GetOption<bool>  ("NostrumGuide.Enable",              true);

    gCfg.allianceNpcEntry   = sConfigMgr->GetOption<uint32>("NostrumGuide.AllianceNpcEntry",     900001);
    gCfg.hordeNpcEntry      = sConfigMgr->GetOption<uint32>("NostrumGuide.HordeNpcEntry",        900002);
    gCfg.allianceNpcName    = sConfigMgr->GetOption<std::string>("NostrumGuide.AllianceNpcName", "Loremaster Caedric");
    gCfg.hordeNpcName       = sConfigMgr->GetOption<std::string>("NostrumGuide.HordeNpcName",    "Elder Gromak");
    gCfg.npcSubName         = sConfigMgr->GetOption<std::string>("NostrumGuide.NpcSubName",      "New Player Guide");
    gCfg.npcScale           = sConfigMgr->GetOption<float> ("NostrumGuide.NpcScale",             1.15f);
    gCfg.allianceModelRef   = sConfigMgr->GetOption<uint32>("NostrumGuide.AllianceModelReferenceEntry", 16128);
    gCfg.hordeModelRef      = sConfigMgr->GetOption<uint32>("NostrumGuide.HordeModelReferenceEntry",    3057);

    gCfg.visualCueEnable    = sConfigMgr->GetOption<bool>  ("NostrumGuide.VisualCue.Enable",                true);
    gCfg.visualCueGoEntry   = sConfigMgr->GetOption<uint32>("NostrumGuide.VisualCue.GameObjectEntry",       149410);
    gCfg.visualCueSpawnAtNpc = sConfigMgr->GetOption<bool> ("NostrumGuide.VisualCue.SpawnAtNpcLocation",    true);

    gCfg.websiteUrl         = sConfigMgr->GetOption<std::string>("NostrumGuide.WebsiteUrl",  "https://nostrumwow.com");
    gCfg.discordUrl         = sConfigMgr->GetOption<std::string>("NostrumGuide.DiscordUrl",  "https://discord.gg/YOURCODE");

    gCfg.currentPhaseText   = sConfigMgr->GetOption<std::string>("NostrumGuide.CurrentPhaseText",
        "Pre-launch / Phase 0");
    gCfg.levelCapText       = sConfigMgr->GetOption<std::string>("NostrumGuide.LevelCapText",
        "Current level cap: To be announced");
    gCfg.ratesText          = sConfigMgr->GetOption<std::string>("NostrumGuide.RatesText",
        "Nostrum uses custom rates designed to respect the original WotLK progression while making the experience smoother.");
    gCfg.worldChatText      = sConfigMgr->GetOption<std::string>("NostrumGuide.WorldChatText",
        "Use .chat <message> to talk on the World Chat. Use .chat on / .chat off to enable or disable it.");
    gCfg.hardcoreText       = sConfigMgr->GetOption<std::string>("NostrumGuide.HardcoreText",
        "Hardcore mode is optional and can only be enabled on a fresh level 1 character with 0 XP. Hardcore characters have one life, join Deathwalkers, and receive cosmetic rewards.");
    gCfg.crossFactionText   = sConfigMgr->GetOption<std::string>("NostrumGuide.CrossFactionText",
        "Nostrum keeps faction identity in the open world, but enables selected cross-faction systems to improve queue times, grouping, and server health.");
    gCfg.dungeonFinderText  = sConfigMgr->GetOption<std::string>("NostrumGuide.DungeonFinderText",
        "Dungeon Finder may include both factions to improve queue times and make leveling dungeons easier to run.");
    gCfg.battlegroundText   = sConfigMgr->GetOption<std::string>("NostrumGuide.BattlegroundText",
        "Battlegrounds may use cross-faction matchmaking to improve queue times and balance.");
    gCfg.commandsText       = sConfigMgr->GetOption<std::string>("NostrumGuide.CommandsText",
        "Useful commands: .hardcore — enable Hardcore mode. .chat <message> — talk on World Chat. .chat on / .chat off — toggle World Chat.");

    gCfg.debug              = sConfigMgr->GetOption<bool>("NostrumGuide.Debug", false);
}

} // anonymous namespace

// ---------------------------------------------------------------------------
// WorldScript — config loading
// ---------------------------------------------------------------------------

class NostrumGuideWorldScript : public WorldScript
{
public:
    NostrumGuideWorldScript() : WorldScript("NostrumGuideWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD })
    {
    }

    void OnAfterConfigLoad(bool reload) override
    {
        LoadConfig();
        if (!reload)
            LOG_INFO("module", ">> NostrumGuide: loaded. enabled={} visualCue={}.",
                gCfg.enabled, gCfg.visualCueEnable);
    }
};

// ---------------------------------------------------------------------------
// CreatureScript — gossip menu
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
            LOG_INFO("module", "[NostrumGuide] {} opened guide gossip (NPC {}).",
                player->GetName(), creature->GetEntry());

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

        switch (static_cast<GuideGossipAction>(action))
        {
            case GUIDE_ACTION_MAIN:
                ShowMainMenu(player, creature);
                break;

            case GUIDE_ACTION_WHAT_IS:
                ShowPage(player, creature,
                    "NostrumWoW is a progressive WotLK 3.3.5a server with a blizzlike core, smart "
                    "quality-of-life features, optional Hardcore mode, and phased progression. "
                    "Our goal is to keep the old-school world alive while reducing unnecessary friction.");
                break;

            case GUIDE_ACTION_PHASE:
                ShowPage(player, creature,
                    "Current phase: " + gCfg.currentPhaseText + " | " + gCfg.levelCapText);
                break;

            case GUIDE_ACTION_RATES:
                ShowPage(player, creature, gCfg.ratesText);
                break;

            case GUIDE_ACTION_HARDCORE:
                ShowPage(player, creature,
                    gCfg.hardcoreText + " Use .hardcore to enable Hardcore mode.");
                break;

            case GUIDE_ACTION_WORLDCHAT:
                ShowPage(player, creature,
                    gCfg.worldChatText +
                    " | .chat <message> — talk on World Chat"
                    " | .chat on — enable World Chat"
                    " | .chat off — disable World Chat");
                break;

            case GUIDE_ACTION_CROSSFACTION:
                ShowPage(player, creature, gCfg.crossFactionText);
                break;

            case GUIDE_ACTION_DUNGEONBG:
                ShowPage(player, creature,
                    gCfg.dungeonFinderText + " " + gCfg.battlegroundText);
                break;

            case GUIDE_ACTION_WEBSITE:
                ShowPage(player, creature,
                    "Website: " + gCfg.websiteUrl + "  |  Discord: " + gCfg.discordUrl);
                break;

            case GUIDE_ACTION_COMMANDS:
                ShowPage(player, creature, gCfg.commandsText);
                break;

            case GUIDE_ACTION_CLOSE:
            default:
                CloseGossipMenuFor(player);
                break;
        }

        return true;
    }

private:
    void ShowMainMenu(Player* player, Creature* creature)
    {
        ClearGossipMenuFor(player);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "What is NostrumWoW?",              GOSSIP_SENDER_MAIN, GUIDE_ACTION_WHAT_IS);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Current phase and level cap",      GOSSIP_SENDER_MAIN, GUIDE_ACTION_PHASE);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Server rates",                     GOSSIP_SENDER_MAIN, GUIDE_ACTION_RATES);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Hardcore mode",                    GOSSIP_SENDER_MAIN, GUIDE_ACTION_HARDCORE);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "World chat",                       GOSSIP_SENDER_MAIN, GUIDE_ACTION_WORLDCHAT);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Cross-faction features",           GOSSIP_SENDER_MAIN, GUIDE_ACTION_CROSSFACTION);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Dungeon Finder and Battlegrounds", GOSSIP_SENDER_MAIN, GUIDE_ACTION_DUNGEONBG);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Website and Discord",              GOSSIP_SENDER_MAIN, GUIDE_ACTION_WEBSITE);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "Useful commands",                  GOSSIP_SENDER_MAIN, GUIDE_ACTION_COMMANDS);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Nevermind",                        GOSSIP_SENDER_MAIN, GUIDE_ACTION_CLOSE);
        SendGossipMenuFor(player, NPC_TEXT_MAIN, creature->GetGUID());
    }

    // Shows a single-page info response. Clicking the content text or "Back" returns
    // to the main menu; "Close" dismisses the gossip window entirely.
    void ShowPage(Player* player, Creature* creature, std::string const& content)
    {
        ClearGossipMenuFor(player);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, content,                   GOSSIP_SENDER_MAIN, GUIDE_ACTION_MAIN);
        AddGossipItemFor(player, GOSSIP_ICON_TALK, "< Back to main menu",     GOSSIP_SENDER_MAIN, GUIDE_ACTION_MAIN);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Close",                   GOSSIP_SENDER_MAIN, GUIDE_ACTION_CLOSE);
        SendGossipMenuFor(player, NPC_TEXT_MAIN, creature->GetGUID());
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
