/*
<--------------------------------------------------------------------------->
- Developer(s): WiiZZy
- Complete: 100%
- ScriptName: 'World chat'
- Comment: Fully tested
<--------------------------------------------------------------------------->
*/

#include "ScriptMgr.h"
#include "Log.h"
#include "Player.h"
#include "Channel.h"
#include "Chat.h"
#include "Common.h"
#include "World.h"
#include "WorldSession.h"
#include "Config.h"
#include <unordered_map>
#include <boost/algorithm/string.hpp>
#include <Chat/Channels/ChannelMgr.h>

/* VERSION */
float ver = 2.0f;

/* Colors */
std::string WORLD_CHAT_ALLIANCE_BLUE = "|cff3399FF";
std::string WORLD_CHAT_HORDE_RED = "|cffCC0000";
std::string WORLD_CHAT_WHITE = "|cffFFFFFF";
std::string WORLD_CHAT_GREEN = "|cff00CC00";
std::string WORLD_CHAT_RED = "|cffFF0000";
std::string WORLD_CHAT_BLUE = "|cff6666FF";
std::string WORLD_CHAT_BLACK = "|cff000000";
std::string WORLD_CHAT_GREY = "|cff808080";

/* Class Colors */
std::string world_chat_ClassColor[11] =
{
    "|cffC79C6E", // WARRIOR
    "|cffF58CBA", // PALADIN
    "|cffABD473", // HUNTER
    "|cffFFF569", // ROGUE
    "|cffFFFFFF", // PRIEST
    "|cffC41F3B", // DEATHKNIGHT
    "|cff0070DE", // SHAMAN
    "|cff40C7EB", // MAGE
    "|cff8787ED", // WARLOCK
    "", // ADDED IN MOP FOR MONK - NOT USED
    "|cffFF7D0A", // DRUID
};

/* Ranks */
std::string world_chat_GM_RANKS[4] =
{
    "Player",
    "MOD",
    "GM",
    "ADMIN",
};

/* BLIZZARD CHAT ICON FOR GM'S */
std::string world_chat_GMIcon = "|TINTERFACE/CHATFRAME/UI-CHATICON-BLIZZ:13:13:0:-1|t";

/* COLORED TEXT FOR CURRENT FACTION || NOT FOR GMS */
std::string world_chat_TeamIcon[2] =
{
    "|cff3399FFAlliance|r",
    "|cffCC0000Horde|r"
};

/* Config Variables */
struct WCConfig
{
    bool Enabled;
    std::string ChannelName;
    bool LoginState;
    bool CrossFaction;
    bool Announce;
};

WCConfig WC_Config;

class WorldChat_Config : public WorldScript
{
public: WorldChat_Config() : WorldScript("WorldChat_Config") { };
    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            WC_Config.Enabled = sConfigMgr->GetBoolDefault("World_Chat.Enable", true);
            WC_Config.ChannelName = sConfigMgr->GetStringDefault("World_Chat.ChannelName", "World");
            WC_Config.LoginState = sConfigMgr->GetBoolDefault("World_Chat.OnLogin.State", true);
            WC_Config.CrossFaction = sConfigMgr->GetBoolDefault("World_Chat.CrossFactions", true);
            WC_Config.Announce = sConfigMgr->GetBoolDefault("World_Chat.Announce", true);
        }
    }
};

/* STRUCTURE FOR WorldChat map */
struct ChatElements
{
    uint8 chat = (WC_Config.LoginState) ? 1 : 0; // CHAT DISABLED BY DEFAULT
};

/* UNORDERED MAP FOR STORING IF CHAT IS ENABLED OR DISABLED */
std::unordered_map<uint32, ChatElements>WorldChat;

void SendWorldMessage(Player* sender, const char* msg, int team) {

    if (!sender->CanSpeak()) {
        ChatHandler(sender->GetSession()).PSendSysMessage("[WC] %sYou can't use World Chat while muted!|r", WORLD_CHAT_RED.c_str());
        return;
    }

    if (!WorldChat[sender->GetGUID().GetCounter()].chat) {
        ChatHandler(sender->GetSession()).PSendSysMessage("[WC] %sWorld Chat is hidden. (.chat off)|r", WORLD_CHAT_RED.c_str());
        return;
    }

    char message[1024];

    SessionMap sessions = sWorld->GetAllSessions();

    for (SessionMap::iterator itr = sessions.begin(); itr != sessions.end(); ++itr)
    {
        if (!itr->second)
            continue;
        if (!itr->second->GetPlayer())
        {
            continue;
        }
        if (!itr->second->GetPlayer()->IsInWorld())
        {
            continue;
        }

        Player* target = itr->second->GetPlayer();
        uint64 guid2 = target->GetGUID().GetCounter();

        if (WorldChat[guid2].chat == 1 && (team == -1 || target->GetTeamId() == team))
        {
            if (WC_Config.CrossFaction || (sender->GetTeamId() == target->GetTeamId()) || target->GetSession()->GetSecurity())
            {
                if (!AccountMgr::IsPlayerAccount(sender->GetSession()->GetSecurity())) {
                    snprintf(message, 1024, "[World][%s][%s|Hplayer:%s|h%s|h|r]: %s%s|r", ((sender->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER)) ? (world_chat_ClassColor[5] + "DEV|r").c_str() : world_chat_GMIcon.c_str()) , world_chat_ClassColor[sender->getClass() - 1].c_str(), sender->GetName().c_str(), sender->GetName().c_str(), WORLD_CHAT_WHITE.c_str(), msg);
                }
                else {
                    snprintf(message, 1024, "[World][%s][%s|Hplayer:%s|h%s|h|r]: %s%s|r", world_chat_TeamIcon[sender->GetTeamId()].c_str(), world_chat_ClassColor[sender->getClass() - 1].c_str(), sender->GetName().c_str(), sender->GetName().c_str(), WORLD_CHAT_WHITE.c_str(), msg);
                }
                ChatHandler(target->GetSession()).PSendSysMessage("%s", message);
            }
        }
    }
}

class World_Chat : public CommandScript
{
public:
    World_Chat() : CommandScript("World_Chat") { }

    static bool HandleWorldChatCommand(ChatHandler * pChat, const char * msg)
    {

        if (!*msg)
            return false;

        SendWorldMessage(pChat->GetSession()->GetPlayer(), msg, -1);

        return true;
    }

    static bool HandleWorldChatHordeCommand(ChatHandler * pChat, const char * msg)
    {

        if (!*msg)
            return false;

        SendWorldMessage(pChat->GetSession()->GetPlayer(), msg, TEAM_HORDE);

        return true;
    }

    static bool HandleWorldChatAllianceCommand(ChatHandler * pChat, const char * msg)
    {

        if (!*msg)
            return false;

        SendWorldMessage(pChat->GetSession()->GetPlayer(), msg, TEAM_ALLIANCE);

        return true;
    }

    static bool HandleWorldChatOnCommand(ChatHandler* handler, const char* /*msg*/)
    {
        Player* player = handler->GetSession()->GetPlayer();
        uint64 guid = player->GetGUID().GetCounter();

        if (!WC_Config.Enabled) {
            ChatHandler(player->GetSession()).PSendSysMessage("[WC] %sWorld Chat System is disabled.|r", WORLD_CHAT_RED.c_str());
            return true;
        }

        if (WorldChat[guid].chat) {
            ChatHandler(player->GetSession()).PSendSysMessage("[WC] %sWorld Chat is already visible.|r", WORLD_CHAT_RED.c_str());
            return true;
        }

        WorldChat[guid].chat = 1;

        ChatHandler(player->GetSession()).PSendSysMessage("[WC] %sWorld Chat is now visible.|r", WORLD_CHAT_GREEN.c_str());

        return true;
    };

    static bool HandleWorldChatOffCommand(ChatHandler* handler, const char* /*msg*/)
    {
        Player* player = handler->GetSession()->GetPlayer();
        uint64 guid = player->GetGUID().GetCounter();

        if (!sConfigMgr->GetBoolDefault("World_Chat.Enable", true)) {
            ChatHandler(player->GetSession()).PSendSysMessage("[WC] %sWorld Chat System is disabled.|r", WORLD_CHAT_RED.c_str());
            return true;
        }

        if (!WorldChat[guid].chat) {
            ChatHandler(player->GetSession()).PSendSysMessage("[WC] %sWorld Chat is already hidden.|r", WORLD_CHAT_RED.c_str());
            return true;
        }

        WorldChat[guid].chat = 0;

        ChatHandler(player->GetSession()).PSendSysMessage("[WC] %sWorld Chat is now hidden.|r", WORLD_CHAT_GREEN.c_str());

        return true;
    };

    std::vector<ChatCommand> GetCommands() const
    {
        static std::vector<ChatCommand> wcCommandTable =
        {
            { "on",      SEC_PLAYER,     false,     &HandleWorldChatOnCommand,      "" },
            { "off",     SEC_PLAYER,     false,    &HandleWorldChatOffCommand,       "" },
            { "",        SEC_PLAYER,     false,    &HandleWorldChatCommand,       "" },
        };
        static std::vector<ChatCommand> commandTable =
        {
            { "chat", SEC_PLAYER, true, NULL , "" , wcCommandTable},
            { "chath", SEC_MODERATOR, true, &HandleWorldChatHordeCommand , ""},
            { "chata", SEC_MODERATOR, true, &HandleWorldChatAllianceCommand , ""},
        };
        return commandTable;
    }
};

class WorldChat_Announce : public PlayerScript
{
public:

    WorldChat_Announce() : PlayerScript("WorldChat_Announce")
    {
        GMChatColors[1] = "|cffff0022";
        GMChatColors[2] = "|cffd1001c";
        GMChatColors[3] = "|cffb5182d";
        GMChatColors[4] = "|cffb5182d";
        GMChatColors[5] = "|cffb5182d";
    }

    void OnLogin(Player* player)
    {

    }

    void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Channel* channel) 
    {
        if (lang != LANG_ADDON && boost::iequals(channel->GetName(), "World"))
        {
            SendWorldMessage(player, msg.c_str(), -1);
            msg = -1;
        }
    }

    void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg) override
    {
        SetColorMessage(player, msg, lang);
    }

    void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Player* receiver) override
    {
        SetColorMessage(player, msg, lang);
    }

    void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Group* /*group*/) override
    {
        SetColorMessage(player, msg, lang);
    }

    void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Guild* /*guild*/) override
    {
        SetColorMessage(player, msg, lang);
    }

private:
    std::unordered_map<uint8, std::string> GMChatColors;
    void SetColorMessage(Player* player, std::string& message, uint32 lang)
    {
        if (lang == LANG_ADDON || AccountMgr::IsPlayerAccount(player->GetSession()->GetSecurity()) || message.empty())
            return;

        uint8 gmLevel = player->GetSession()->GetSecurity();

        message = GMChatColors[gmLevel] + message;
    };
};

void AddSC_WorldChatScripts()
{
    new WorldChat_Announce;
    new WorldChat_Config;
    new World_Chat;
}
