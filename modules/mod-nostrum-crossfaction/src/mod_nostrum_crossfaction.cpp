/*
 * mod-nostrum-crossfaction
 *
 * Centralizes NostrumWoW cross-faction policy:
 *  - World channel auto-join with configurable speak level and cooldown.
 *  - Blocks manual cross-faction group invites (configurable).
 *  - Blocks cross-faction direct trades (configurable).
 *  - Startup validation logs for features that require core config changes or
 *    external modules (RDF mixing, BG mixing via mod-cfbg).
 *
 * Features that cannot be implemented cleanly from a module (RDF queue mixing,
 * BG team mixing) are validated and logged at startup without fake stubs.
 */

#include "Channel.h"
#include "ChannelMgr.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Config.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "PlayerScript.h"
#include "WorldScript.h"

#include <algorithm>
#include <unordered_map>

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

    // World Channel
    bool        worldChannelEnable              = true;
    std::string worldChannelName                = "world";
    bool        worldChannelLoginMsgEnable      = true;
    std::string worldChannelLoginMsg            = "You have joined /world. Use it for global chat, questions, groups, and trading.";
    uint32      worldChannelMinSpeakLevel       = 5;
    uint32      worldChannelCooldownSec         = 3;

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

// guid.GetCounter() -> unix timestamp of last world-channel message
std::unordered_map<uint64, time_t> gLastSpeak;

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

static std::string strToLower(std::string s)
{
    std::transform(s.begin(), s.end(), s.begin(), ::tolower);
    return s;
}

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

    gCfg.worldChannelEnable         = sConfigMgr->GetOption<bool>  ("NostrumCrossFaction.WorldChannel.Enable",              true);
    gCfg.worldChannelName           = sConfigMgr->GetOption<std::string>("NostrumCrossFaction.WorldChannel.Name",           "world");
    gCfg.worldChannelLoginMsgEnable = sConfigMgr->GetOption<bool>  ("NostrumCrossFaction.WorldChannel.LoginMessage.Enable", true);
    gCfg.worldChannelLoginMsg       = sConfigMgr->GetOption<std::string>("NostrumCrossFaction.WorldChannel.LoginMessage",
        "You have joined /world. Use it for global chat, questions, groups, and trading.");
    gCfg.worldChannelMinSpeakLevel  = sConfigMgr->GetOption<uint32>("NostrumCrossFaction.WorldChannel.MinSpeakLevel",           5);
    gCfg.worldChannelCooldownSec    = sConfigMgr->GetOption<uint32>("NostrumCrossFaction.WorldChannel.MessageCooldownSeconds",   3);

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

    // --- World Channel ---
    LOG_INFO("module", "[NostrumCrossFaction] --- World Channel ---");
    if (gCfg.worldChannelEnable)
    {
        LOG_INFO("module", "[NostrumCrossFaction] World channel: \"{}\" (auto-join on login)", gCfg.worldChannelName);
        LOG_INFO("module", "[NostrumCrossFaction] World channel min speak level: {}", gCfg.worldChannelMinSpeakLevel);
        LOG_INFO("module", "[NostrumCrossFaction] World channel message cooldown: {}s", gCfg.worldChannelCooldownSec);
        if (!CoreBool("AllowTwoSide.Interaction.Channel"))
            LOG_WARN("module", "[NostrumCrossFaction] AllowTwoSide.Interaction.Channel = 0 — "
                "world channel will be faction-split. Set = 1 for a shared cross-faction world channel.");
    }
    else
        LOG_INFO("module", "[NostrumCrossFaction] World channel auto-join: disabled.");

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
            PLAYERHOOK_ON_LOGIN,
            PLAYERHOOK_CAN_PLAYER_USE_CHANNEL_CHAT,
            PLAYERHOOK_CAN_GROUP_INVITE,
            PLAYERHOOK_CAN_INIT_TRADE,
        })
    {
    }

    // -----------------------------------------------------------------------
    // World channel auto-join
    // -----------------------------------------------------------------------

    void OnPlayerLogin(Player* player) override
    {
        if (!gCfg.enabled || !gCfg.worldChannelEnable)
            return;

        ChannelMgr* mgr = ChannelMgr::forTeam(player->GetTeamId());
        if (!mgr)
            return;

        Channel* channel = mgr->GetJoinChannel(gCfg.worldChannelName, 0);
        if (!channel)
            return;

        channel->JoinChannel(player, "");

        if (gCfg.worldChannelLoginMsgEnable && !gCfg.worldChannelLoginMsg.empty())
            ChatHandler(player->GetSession()).SendSysMessage(gCfg.worldChannelLoginMsg);

        if (gCfg.debug)
            LOG_INFO("module", "[NostrumCrossFaction] {} joined world channel \"{}\".",
                player->GetName(), gCfg.worldChannelName);
    }

    // -----------------------------------------------------------------------
    // World channel speak enforcement (min level + cooldown)
    // -----------------------------------------------------------------------

    bool OnPlayerCanUseChat(Player* player, uint32 /*type*/, uint32 /*language*/,
        std::string& /*msg*/, Channel* channel) override
    {
        if (!gCfg.enabled || !gCfg.worldChannelEnable || !channel)
            return true;

        if (strToLower(channel->GetName()) != strToLower(gCfg.worldChannelName))
            return true;

        // Minimum speak level
        if (gCfg.worldChannelMinSpeakLevel > 0 &&
            player->GetLevel() < gCfg.worldChannelMinSpeakLevel)
        {
            ChatHandler(player->GetSession()).PSendSysMessage(
                "You must be at least level {} to speak in /{}.",
                gCfg.worldChannelMinSpeakLevel, gCfg.worldChannelName);
            return false;
        }

        // Message cooldown
        if (gCfg.worldChannelCooldownSec > 0)
        {
            time_t now     = time(nullptr);
            uint64 guidLow = player->GetGUID().GetCounter();
            auto   it      = gLastSpeak.find(guidLow);

            if (it != gLastSpeak.end())
            {
                time_t elapsed = now - it->second;
                if (elapsed < static_cast<time_t>(gCfg.worldChannelCooldownSec))
                {
                    ChatHandler(player->GetSession()).PSendSysMessage(
                        "Please wait {} more second(s) before speaking in /{}.",
                        static_cast<uint32>(gCfg.worldChannelCooldownSec - elapsed),
                        gCfg.worldChannelName);
                    return false;
                }
            }
            gLastSpeak[guidLow] = now;
        }

        return true;
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
// CommandScript — .world <message>
// Accessible to all players via rbac_default_permissions (secId=0, permId=9000010).
// ---------------------------------------------------------------------------

using namespace Acore::ChatCommands;

class NostrumCrossFactionCommandScript : public CommandScript
{
public:
    NostrumCrossFactionCommandScript() : CommandScript("NostrumCrossFactionCommandScript") { }

    ChatCommandTable GetCommands() const override
    {
        LOG_INFO("module", "[NostrumCrossFaction] Registering .world command.");
        static ChatCommandTable table =
        {
            { "world", HandleWorldChatCommand, static_cast<uint32>(9000010), Console::No },
        };
        return table;
    }

    static bool HandleWorldChatCommand(ChatHandler* handler, Tail message)
    {
        if (!gCfg.enabled || !gCfg.worldChannelEnable)
        {
            handler->SendSysMessage("World chat is currently disabled.");
            return true;
        }

        Player* player = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;
        if (!player)
            return false;

        LOG_DEBUG("module", "[NostrumCrossFaction] .world command executed by {}", player->GetName());

        // Get-or-create the channel, then ensure the player is joined.
        // GetJoinChannel creates the channel if it doesn't exist yet.
        // JoinChannel is a no-op if the player is already a member.
        ChannelMgr* mgr = ChannelMgr::forTeam(player->GetTeamId());
        if (!mgr)
        {
            handler->SendSysMessage("World channel could not be created or found.");
            return true;
        }

        Channel* channel = mgr->GetJoinChannel(gCfg.worldChannelName, 0);
        if (!channel)
        {
            handler->SendSysMessage("World channel could not be created or found.");
            return true;
        }

        channel->JoinChannel(player, "");

        if (message.empty())
        {
            handler->PSendSysMessage(
                "You have joined the {} channel. Use your channel number, usually /1 or /2, to speak.",
                gCfg.worldChannelName);
            return true;
        }

        if (gCfg.worldChannelMinSpeakLevel > 0 &&
            player->GetLevel() < gCfg.worldChannelMinSpeakLevel)
        {
            handler->PSendSysMessage("You must be at least level {} to speak in /{}.",
                gCfg.worldChannelMinSpeakLevel, gCfg.worldChannelName);
            return true;
        }

        uint64 guidLow = player->GetGUID().GetCounter();
        time_t now = time(nullptr);
        if (gCfg.worldChannelCooldownSec > 0)
        {
            auto it = gLastSpeak.find(guidLow);
            if (it != gLastSpeak.end())
            {
                time_t diff = now - it->second;
                if (diff < static_cast<time_t>(gCfg.worldChannelCooldownSec))
                {
                    handler->PSendSysMessage("Please wait {} more second(s) before speaking in /{}.",
                        static_cast<uint32>(gCfg.worldChannelCooldownSec - diff),
                        gCfg.worldChannelName);
                    return true;
                }
            }
        }

        channel->Say(player->GetGUID(), std::string(message), LANG_UNIVERSAL);
        gLastSpeak[guidLow] = now;
        return true;
    }
};

// ---------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------

void Addmod_nostrum_crossfactionScripts()
{
    new NostrumCrossFactionWorldScript();
    new NostrumCrossFactionPlayerScript();
    new NostrumCrossFactionCommandScript();
}
