/*
 * mod-nostrum-crossfaction
 *
 * Centralizes NostrumWoW cross-faction policy:
 *  - Blocks manual cross-faction group invites (configurable).
 *  - Blocks cross-faction direct trades (configurable).
 *  - Startup validation logs for features that require core config changes or
 *    external modules (RDF mixing, BG mixing via mod-cfbg).
 *
 * Features that cannot be implemented cleanly from a module (RDF queue mixing,
 * BG team mixing) are validated and logged at startup without fake stubs.
 */

#include "Chat.h"
#include "Config.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "PlayerScript.h"
#include "WorldScript.h"

// ---------------------------------------------------------------------------
// Config
// ---------------------------------------------------------------------------

namespace
{

struct CrossFactionConfig
{
    bool        enabled                         = true;

    // Communication
    bool        chatEnable                      = true;
    bool        channelsEnable                  = true;
    bool        whoListEnable                   = true;

    // Economy
    bool        ahEnable                        = true;
    bool        mailEnable                      = false;
    bool        tradingEnable                   = false;

    // Groups
    bool        manualGroupsEnable              = false;
    bool        dungeonGroupsEnable             = true;
    bool        dungeonGroupsRestrict           = true;
    bool        dungeonGroupsCleanup            = true;

    // RDF
    bool        rdfEnable                       = true;
    bool        rdfMixedFactions                = true;
    bool        rdfPreserveFlow                 = true;

    // Battlegrounds
    bool        bgEnable                        = true;
    bool        bgMixedTeams                    = true;
    bool        bgPrioritizeQueue               = true;

    // Guilds
    bool        guildsEnable                    = false;
    bool        systemGuildsEnable              = true;
    std::string systemGuildsAllowedNames        = "Deathwalkers";

    // Open World
    bool        preserveFactionIdentity         = true;
    bool        blockManualGroups               = true;
    bool        blockCrossFactionTrading        = true;

    // Logging
    bool        logConfig                       = true;
    bool        debug                           = false;
};

CrossFactionConfig gCfg;

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

static bool CoreBool(char const* key)
{
    return sConfigMgr->GetOption<bool>(key, false);
}

// ---------------------------------------------------------------------------
// Config loading
// ---------------------------------------------------------------------------

void LoadConfig()
{
    gCfg.enabled = sConfigMgr->GetOption<bool>("NostrumCrossFaction.Enable", true);

    gCfg.chatEnable     = sConfigMgr->GetOption<bool>("NostrumCrossFaction.Chat.Enable",     true);
    gCfg.channelsEnable = sConfigMgr->GetOption<bool>("NostrumCrossFaction.Channels.Enable", true);
    gCfg.whoListEnable  = sConfigMgr->GetOption<bool>("NostrumCrossFaction.WhoList.Enable",  true);

    gCfg.ahEnable      = sConfigMgr->GetOption<bool>("NostrumCrossFaction.AuctionHouse.Enable", true);
    gCfg.mailEnable    = sConfigMgr->GetOption<bool>("NostrumCrossFaction.Mail.Enable",          false);
    gCfg.tradingEnable = sConfigMgr->GetOption<bool>("NostrumCrossFaction.Trading.Enable",       false);

    gCfg.manualGroupsEnable    = sConfigMgr->GetOption<bool>("NostrumCrossFaction.ManualGroups.Enable",                  false);
    gCfg.dungeonGroupsEnable   = sConfigMgr->GetOption<bool>("NostrumCrossFaction.DungeonGroups.Enable",                 true);
    gCfg.dungeonGroupsRestrict = sConfigMgr->GetOption<bool>("NostrumCrossFaction.DungeonGroups.RestrictToInstances",    true);
    gCfg.dungeonGroupsCleanup  = sConfigMgr->GetOption<bool>("NostrumCrossFaction.DungeonGroups.CleanupOutsideInstance", true);

    gCfg.rdfEnable        = sConfigMgr->GetOption<bool>("NostrumCrossFaction.RDF.Enable",                 true);
    gCfg.rdfMixedFactions = sConfigMgr->GetOption<bool>("NostrumCrossFaction.RDF.MixedFactionGroups",     true);
    gCfg.rdfPreserveFlow  = sConfigMgr->GetOption<bool>("NostrumCrossFaction.RDF.PreserveBlizzlikeFlow",  true);

    gCfg.bgEnable          = sConfigMgr->GetOption<bool>("NostrumCrossFaction.Battlegrounds.Enable",               true);
    gCfg.bgMixedTeams      = sConfigMgr->GetOption<bool>("NostrumCrossFaction.Battlegrounds.MixedTeams",           true);
    gCfg.bgPrioritizeQueue = sConfigMgr->GetOption<bool>("NostrumCrossFaction.Battlegrounds.PrioritizeQueueHealth", true);

    gCfg.guildsEnable             = sConfigMgr->GetOption<bool>  ("NostrumCrossFaction.Guilds.Enable",                 false);
    gCfg.systemGuildsEnable       = sConfigMgr->GetOption<bool>  ("NostrumCrossFaction.SystemGuilds.Enable",           true);
    gCfg.systemGuildsAllowedNames = sConfigMgr->GetOption<std::string>("NostrumCrossFaction.SystemGuilds.AllowedNames", "Deathwalkers");

    gCfg.preserveFactionIdentity  = sConfigMgr->GetOption<bool>("NostrumCrossFaction.OpenWorld.PreserveFactionIdentity",       true);
    gCfg.blockManualGroups        = sConfigMgr->GetOption<bool>("NostrumCrossFaction.OpenWorld.BlockManualCrossFactionGroups",  true);
    gCfg.blockCrossFactionTrading = sConfigMgr->GetOption<bool>("NostrumCrossFaction.OpenWorld.BlockCrossFactionTrading",       true);

    gCfg.logConfig = sConfigMgr->GetOption<bool>("NostrumCrossFaction.LogConfig", true);
    gCfg.debug     = sConfigMgr->GetOption<bool>("NostrumCrossFaction.Debug",     false);
}

// ---------------------------------------------------------------------------
// Startup validation
// ---------------------------------------------------------------------------

void LogStartupState()
{
    if (!gCfg.logConfig)
    {
        LOG_INFO("module", ">> NostrumCrossFaction: loaded (enabled={}).", gCfg.enabled);
        return;
    }

    LOG_INFO("module", "[NostrumCrossFaction] ===== Cross-Faction Module =====");
    LOG_INFO("module", "[NostrumCrossFaction] Enabled: {}", gCfg.enabled);

    if (!gCfg.enabled)
    {
        LOG_INFO("module", "[NostrumCrossFaction] All features disabled.");
        LOG_INFO("module", "[NostrumCrossFaction] ================================");
        return;
    }

    // --- Communication ---
    LOG_INFO("module", "[NostrumCrossFaction] --- Communication ---");

    if (gCfg.chatEnable)
    {
        if (!CoreBool("AllowTwoSide.Interaction.Chat"))
            LOG_WARN("module", "[NostrumCrossFaction] Chat.Enable = 1 but AllowTwoSide.Interaction.Chat = 0 — "
                "cross-faction chat will NOT work. Set AllowTwoSide.Interaction.Chat = 1 in worldserver.conf.");
        else
            LOG_INFO("module", "[NostrumCrossFaction] Cross-faction chat: enabled (core config OK).");
    }
    else
        LOG_INFO("module", "[NostrumCrossFaction] Cross-faction chat: disabled.");

    if (gCfg.channelsEnable)
    {
        if (!CoreBool("AllowTwoSide.Interaction.Channel"))
            LOG_WARN("module", "[NostrumCrossFaction] Channels.Enable = 1 but AllowTwoSide.Interaction.Channel = 0 — "
                "cross-faction channels will NOT work. Set AllowTwoSide.Interaction.Channel = 1 in worldserver.conf.");
        else
            LOG_INFO("module", "[NostrumCrossFaction] Cross-faction channels: enabled (core config OK).");
    }
    else
        LOG_INFO("module", "[NostrumCrossFaction] Cross-faction channels: disabled.");

    if (gCfg.whoListEnable)
    {
        if (!CoreBool("AllowTwoSide.WhoList"))
            LOG_WARN("module", "[NostrumCrossFaction] WhoList.Enable = 1 but AllowTwoSide.WhoList = 0 — "
                "set AllowTwoSide.WhoList = 1 in worldserver.conf.");
        else
            LOG_INFO("module", "[NostrumCrossFaction] Cross-faction /who: enabled (core config OK).");
    }
    else
        LOG_INFO("module", "[NostrumCrossFaction] Cross-faction /who: disabled.");

    // --- Economy ---
    LOG_INFO("module", "[NostrumCrossFaction] --- Economy ---");

    if (gCfg.ahEnable)
    {
        if (!CoreBool("AllowTwoSide.Interaction.Auction"))
            LOG_WARN("module", "[NostrumCrossFaction] AuctionHouse.Enable = 1 but AllowTwoSide.Interaction.Auction = 0 — "
                "set AllowTwoSide.Interaction.Auction = 1 in worldserver.conf.");
        else
            LOG_INFO("module", "[NostrumCrossFaction] Cross-faction auction house: enabled (core config OK).");
    }
    else
        LOG_INFO("module", "[NostrumCrossFaction] Cross-faction auction house: disabled.");

    if (gCfg.mailEnable)
    {
        if (!CoreBool("AllowTwoSide.Interaction.Mail"))
            LOG_WARN("module", "[NostrumCrossFaction] Mail.Enable = 1 but AllowTwoSide.Interaction.Mail = 0 — "
                "set AllowTwoSide.Interaction.Mail = 1 in worldserver.conf.");
        else
            LOG_INFO("module", "[NostrumCrossFaction] Cross-faction mail: enabled (core config OK).");
    }
    else
        LOG_INFO("module", "[NostrumCrossFaction] Cross-faction mail: disabled by Nostrum config.");

    if (gCfg.tradingEnable)
        LOG_INFO("module", "[NostrumCrossFaction] Cross-faction trading: enabled. "
            "Set AllowTwoSide.Trade = 1 in worldserver.conf if needed.");
    else
        LOG_INFO("module", "[NostrumCrossFaction] Cross-faction trading: disabled — "
            "OnPlayerCanInitTrade will block cross-faction pairs.");

    // --- Groups ---
    LOG_INFO("module", "[NostrumCrossFaction] --- Groups ---");

    if (gCfg.manualGroupsEnable)
        LOG_WARN("module", "[NostrumCrossFaction] Manual cross-faction groups: ENABLED. "
            "AllowTwoSide.Interaction.Group = 1 may be required in worldserver.conf.");
    else
        LOG_INFO("module", "[NostrumCrossFaction] Manual cross-faction groups: disabled — "
            "OnPlayerCanGroupInvite will block cross-faction invites.");

    if (gCfg.dungeonGroupsEnable)
    {
        LOG_INFO("module", "[NostrumCrossFaction] Cross-faction dungeon groups: allowed (formed via RDF/dungeon system).");
        if (gCfg.dungeonGroupsRestrict)
            LOG_INFO("module", "[NostrumCrossFaction] Dungeon groups restrict-to-instances: configured. "
                "Full enforcement requires AllowTwoSide.Interaction.Group = 1 and hook availability.");
    }

    // --- RDF ---
    LOG_INFO("module", "[NostrumCrossFaction] --- RDF / Dungeon Finder ---");
    if (gCfg.rdfEnable && gCfg.rdfMixedFactions)
    {
        if (!CoreBool("AllowTwoSide.Interaction.Group"))
            LOG_WARN("module", "[NostrumCrossFaction] RDF cross-faction matching: requires "
                "AllowTwoSide.Interaction.Group = 1 in worldserver.conf.");
        else
            LOG_INFO("module", "[NostrumCrossFaction] RDF cross-faction matching: enabled (core config OK).");
    }
    else
        LOG_INFO("module", "[NostrumCrossFaction] RDF cross-faction: disabled.");

    // --- Battlegrounds ---
    LOG_INFO("module", "[NostrumCrossFaction] --- Battlegrounds ---");
    if (gCfg.bgEnable && gCfg.bgMixedTeams)
        // TODO: Cross-faction BG mixing requires mod-cfbg or a compatible implementation.
        // This module does not reimplement mod-cfbg behavior.
        LOG_WARN("module", "[NostrumCrossFaction] Cross-faction battlegrounds: configured but requires mod-cfbg "
            "or a compatible implementation. "
            "This module enforces config and policy only. Ensure mod-cfbg is loaded.");
    else
        LOG_INFO("module", "[NostrumCrossFaction] Cross-faction battlegrounds: disabled.");

    // --- Guilds ---
    LOG_INFO("module", "[NostrumCrossFaction] --- Guilds ---");

    if (gCfg.guildsEnable)
    {
        if (!CoreBool("AllowTwoSide.Interaction.Guild"))
            LOG_WARN("module", "[NostrumCrossFaction] Guilds.Enable = 1 but AllowTwoSide.Interaction.Guild = 0 — "
                "set AllowTwoSide.Interaction.Guild = 1 in worldserver.conf.");
        else
            LOG_INFO("module", "[NostrumCrossFaction] Cross-faction guilds: enabled (core config OK).");
    }
    else
        LOG_INFO("module", "[NostrumCrossFaction] Cross-faction guilds: disabled by Nostrum config.");

    if (gCfg.systemGuildsEnable)
        LOG_INFO("module", "[NostrumCrossFaction] System-managed cross-faction guilds allowed: \"{}\"",
            gCfg.systemGuildsAllowedNames);

    LOG_INFO("module", "[NostrumCrossFaction] ================================");
}

} // anonymous namespace

// ---------------------------------------------------------------------------
// WorldScript — config and startup validation
// ---------------------------------------------------------------------------

class NostrumCrossFactionWorldScript : public WorldScript
{
public:
    NostrumCrossFactionWorldScript() : WorldScript("NostrumCrossFactionWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD })
    {
    }

    void OnAfterConfigLoad(bool reload) override
    {
        LoadConfig();
        if (!reload)
            LogStartupState();
    }
};

// ---------------------------------------------------------------------------
// PlayerScript — world channel, group invites, trades
// ---------------------------------------------------------------------------

class NostrumCrossFactionPlayerScript : public PlayerScript
{
public:
    NostrumCrossFactionPlayerScript() : PlayerScript("NostrumCrossFactionPlayerScript",
        {
            PLAYERHOOK_CAN_GROUP_INVITE,
            PLAYERHOOK_CAN_INIT_TRADE,
        })
    {
    }

    // -----------------------------------------------------------------------
    // Block manual cross-faction group invites
    // -----------------------------------------------------------------------

    bool OnPlayerCanGroupInvite(Player* player, std::string& membername) override
    {
        if (!gCfg.enabled || gCfg.manualGroupsEnable)
            return true;

        Player* target = ObjectAccessor::FindPlayerByName(membername);
        if (!target)
            return true;  // Target not found; let core produce its own error

        if (player->GetTeamId() == target->GetTeamId())
            return true;

        if (gCfg.debug)
            LOG_INFO("module", "[NostrumCrossFaction] Blocked cross-faction invite: {} -> {}.",
                player->GetName(), target->GetName());

        ChatHandler(player->GetSession()).SendSysMessage("Cross-faction group invites are not allowed.");
        return false;
    }

    // -----------------------------------------------------------------------
    // Block cross-faction direct trades
    // -----------------------------------------------------------------------

    bool OnPlayerCanInitTrade(Player* player, Player* target) override
    {
        if (!gCfg.enabled || gCfg.tradingEnable)
            return true;

        if (player->GetTeamId() == target->GetTeamId())
            return true;

        if (gCfg.debug)
            LOG_INFO("module", "[NostrumCrossFaction] Blocked cross-faction trade: {} -> {}.",
                player->GetName(), target->GetName());

        ChatHandler(player->GetSession()).SendSysMessage("Cross-faction trading is not allowed.");
        return false;
    }
};

// ---------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------

void Addmod_nostrum_crossfactionScripts()
{
    new NostrumCrossFactionWorldScript();
    new NostrumCrossFactionPlayerScript();
}
