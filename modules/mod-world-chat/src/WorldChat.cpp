/*
<--------------------------------------------------------------------------->
- Developer(s): Ouizzy
- Complete: 100%
- ScriptName: 'World chat'
<--------------------------------------------------------------------------->
*/


#include "WorldChat.h"
#include "Config.h"
#include "StringFormat.h"
#include "WorldSessionMgr.h"

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

static WC::Config g_wcConfig;

static std::string strToLower(std::string str) {
    std::transform(str.begin(), str.end(), str.begin(), ::tolower);
    return str;
}

WC::PlayerState::PlayerState() : chatEnabled(g_wcConfig.loginState) {
}

void WC::WorldChat_Config::OnBeforeConfigLoad(const bool /*reload*/) {
    g_wcConfig.enabled      = sConfigMgr->GetOption<bool>("WorldChat.Enable", true);
    g_wcConfig.crossFaction = sConfigMgr->GetOption<bool>("WorldChat.CrossFaction", true);
    g_wcConfig.announce     = sConfigMgr->GetOption<bool>("WorldChat.Announce", true);
    g_wcConfig.channelName  = strToLower(sConfigMgr->GetOption<std::string>("WorldChat.ChannelName", "world"));
    g_wcConfig.loginState   = sConfigMgr->GetOption<bool>("WorldChat.OnLogin.State", true);

    std::string channelMessage;
    if (g_wcConfig.channelName != "") {
        channelMessage = " or use /join " + g_wcConfig.channelName;
    }

    std::string factionMessage;
    if (g_wcConfig.crossFaction) {
        factionMessage = " with your faction";
    }

    g_wcConfig.announceMessage = Acore::StringFormat(
        "This server is running the |cff4CFF00WorldChat |rmodule. Use .chat{} to communicate{}.", channelMessage,
        factionMessage);
}

void WC::SendWorldMessage(Player const &sender, const std::string &msg, const int team) {
    if (msg.empty()) {
        return;
    }

    if (!g_wcConfig.enabled) {
        ChatHandler(sender.GetSession()).PSendSysMessage(
            Acore::StringFormat("[WC] {}World Chat System is disabled.|r", ChatColor::RED)
        );
        return;
    }

    if (!sender.CanSpeak()) {
        ChatHandler(sender.GetSession()).PSendSysMessage(
            Acore::StringFormat("[WC] {}You can't use World Chat while muted!|r", ChatColor::RED)
        );
        return;
    }

    if (!g_wcConfig.playerStates[sender.GetGUID().GetCounter()].chatEnabled) {
        ChatHandler(sender.GetSession()).PSendSysMessage(
            Acore::StringFormat("[WC] {}World Chat is hidden. (.chat off)|r", ChatColor::RED)
        );
        return;
    }

    const AccountTypes senderSecurity = sender.GetSession()->GetSecurity();

    WorldSessionMgr::SessionMap sessions = sWorldSessionMgr->GetAllSessions();
    for (auto const& [accountId, session] : sessions) {
        if (!session) {
            LOG_DEBUG("WorldChat", "Skipping invalid session.");
            continue;
        }

        const Player* target = session->GetPlayer();

        if (!target || !target->IsInWorld()) {
            LOG_DEBUG("WorldChat", "Skipping invalid/loading player.");
            continue;
        }

        if (const uint64 targetGuid = target->GetGUID().GetCounter();
            !g_wcConfig.playerStates[targetGuid].chatEnabled) {
            LOG_DEBUG("WorldChat", "Skipping disabled player.");
            continue;
        }

        if (target->GetTeamId() != team && team != -1) {
            return;
        }

        if (sender.GetTeamId() != target->GetTeamId()
            && !g_wcConfig.crossFaction
            && senderSecurity == SEC_PLAYER
            && target->GetSession()->GetSecurity() == SEC_PLAYER) {
            continue;
        }

        const std::string &senderName = sender.GetName();

        std::string outMessage;
        if (sender.isGMChat() || sender.IsDeveloper()) {
            outMessage = Acore::StringFormat(
                MessageTemplate,
                GMIcon,
                ClassColor[sender.getClass()],
                senderName,
                senderName,
                ChatColor::WHITE,
                msg);
        } else {
            outMessage = Acore::StringFormat(
                MessageTemplate,
                TeamColored[sender.GetTeamId()],
                ClassColor[sender.getClass()],
                senderName,
                senderName,
                ChatColor::WHITE,
                msg);
        }
        ChatHandler(target->GetSession()).PSendSysMessage(outMessage);
    }
}

void WC::WorldChat_Announce::OnPlayerLogin(Player* player) {
    if (g_wcConfig.enabled && g_wcConfig.announce) {
        ChatHandler(player->GetSession()).SendSysMessage(g_wcConfig.announceMessage);
    }
}

bool WC::WorldChat_Announce::OnPlayerCanUseChat(Player* player, uint32 /*type*/, const uint32 lang, std::string &msg,
                                                Channel* channel) {
    if (g_wcConfig.channelName != "" && lang != LANG_ADDON && strToLower(channel->GetName()) == g_wcConfig.
        channelName) {
        SendWorldMessage(*player, msg, -1);
        return false;
    }
    return true;
}

bool WC::WorldChat::HandleWorldChatCommand(ChatHandler* pChat, const char* msg) {
    const std::string message = Acore::String::Trim(std::string(msg));
    if (message.empty()) {
        return false;
    }

    SendWorldMessage(*pChat->GetSession()->GetPlayer(), message, -1);

    return true;
}

bool WC::WorldChat::HandleWorldChatHordeCommand(ChatHandler* pChat, const char* msg) {
    SendWorldMessage(*pChat->GetSession()->GetPlayer(), msg, TEAM_HORDE);

    return true;
}

bool WC::WorldChat::HandleWorldChatAllianceCommand(ChatHandler* pChat, const char* msg) {
    SendWorldMessage(*pChat->GetSession()->GetPlayer(), msg, TEAM_ALLIANCE);

    return true;
}

bool WC::WorldChat::HandleWorldChatOnCommand(ChatHandler* handler) {
    const Player* player = handler->GetSession()->GetPlayer();

    if (!g_wcConfig.enabled) {
        ChatHandler(player->GetSession()).PSendSysMessage(
            Acore::StringFormat("[WC] {}WorldChat System is disabled.|r",
                                ChatColor::RED));
        return true;
    }

    const uint64 guid = player->GetGUID().GetCounter();
    if (g_wcConfig.playerStates[guid].chatEnabled) {
        ChatHandler(player->GetSession()).PSendSysMessage(
            Acore::StringFormat("[WC] {}World Chat is already visible.|r",
                                ChatColor::YELLOW));
        return true;
    }

    g_wcConfig.playerStates[guid].chatEnabled = true;
    ChatHandler(player->GetSession()).PSendSysMessage(
        Acore::StringFormat("[WC] {}World Chat is now visible.|r",
                            ChatColor::GREEN));

    return true;
}

bool WC::WorldChat::HandleWorldChatOffCommand(ChatHandler* handler) {
    const Player* player = handler->GetSession()->GetPlayer();

    if (!sConfigMgr->GetOption<bool>("WorldChat.Enable", true)) {
        ChatHandler(player->GetSession()).PSendSysMessage(
            Acore::StringFormat("[WC] {}World Chat System is disabled.|r",
                                ChatColor::RED));
        return true;
    }

    const uint64 guid = player->GetGUID().GetCounter();
    if (!g_wcConfig.playerStates[guid].chatEnabled) {
        ChatHandler(player->GetSession()).PSendSysMessage(
            Acore::StringFormat("[WC] {}World Chat is already hidden.|r",
                                ChatColor::YELLOW));
        return true;
    }

    g_wcConfig.playerStates[guid].chatEnabled = false;

    ChatHandler(player->GetSession()).PSendSysMessage(
        Acore::StringFormat("[WC] {}World Chat is now hidden.|r",
                            ChatColor::GREEN));

    return true;
}

Acore::ChatCommands::ChatCommandTable WC::WorldChat::GetCommands() const {
    static Acore::ChatCommands::ChatCommandTable chatCommandTable = {
        {"on", HandleWorldChatOnCommand, SEC_PLAYER, Acore::ChatCommands::Console::No},
        {"off", HandleWorldChatOffCommand, SEC_PLAYER, Acore::ChatCommands::Console::No},
        {"", HandleWorldChatCommand, SEC_PLAYER, Acore::ChatCommands::Console::No},
    };
    static Acore::ChatCommands::ChatCommandTable commandTable =
    {
        {"chat", chatCommandTable},
        {"chath", HandleWorldChatHordeCommand, SEC_MODERATOR, Acore::ChatCommands::Console::No},
        {"chata", HandleWorldChatAllianceCommand, SEC_MODERATOR, Acore::ChatCommands::Console::No},
    };

    return commandTable;
}


void AddSC_WorldChatScripts() {
    new WC::WorldChat_Config();
    new WC::WorldChat_Announce();
    new WC::WorldChat();
}
