/*
<--------------------------------------------------------------------------->
- Developer(s): Ouizzy
- Complete: 100%
- ScriptName: 'World chat'
<--------------------------------------------------------------------------->
*/

#ifndef AZEROTHCORE_MODULES_WORLDCHAT_H
#define AZEROTHCORE_MODULES_WORLDCHAT_H

#include <array>
#include <string>
#include <string_view>
#include <unordered_map>

#include "Channel.h"
#include "Chat.h"
#include "CommandScript.h"
#include "PlayerScript.h"
#include "SharedDefines.h"
#include "WorldScript.h"

namespace WC {
    /* Colors */
    namespace ChatColor {
        constexpr std::string_view ALLIANCE_BLUE = "|cff3399FF";
        constexpr std::string_view HORDE_RED     = "|cffCC0000";
        constexpr std::string_view WHITE         = "|cffFFFFFF";
        constexpr std::string_view GREEN         = "|cff00CC00";
        constexpr std::string_view RED           = "|cffFF0000";
        constexpr std::string_view BLUE          = "|cff6666FF";
        constexpr std::string_view BLACK         = "|cff000000";
        constexpr std::string_view GREY          = "|cff808080";
        constexpr std::string_view YELLOW        = "|cffFFF569";
    }

    /* Class Colors */
    constexpr std::array<std::string_view, MAX_CLASSES> ClassColor =
    {
        "",           // NONE - SKIP
        "|cffC79C6E", // WARRIOR
        "|cffF58CBA", // PALADIN
        "|cffABD473", // HUNTER
        "|cffFFF569", // ROGUE
        "|cffFFFFFF", // PRIEST
        "|cffC41F3B", // DEATHKNIGHT
        "|cff0070DE", // SHAMAN
        "|cff40C7EB", // MAGE
        "|cff8787ED", // WARLOCK
        "",           // MONK - SKIP
        "|cffFF7D0A", // DRUID
    };

    /* BLIZZARD CHAT ICON FOR GM'S */
    constexpr std::string_view GMIcon =
            "|TINTERFACE/CHATFRAME/UI-CHATICON-BLIZZ:13:26:0:-2|t";

    /* COLORED TEXT FOR CURRENT FACTION || NOT FOR GMS */
    constexpr std::array<std::string_view, 3> TeamColored =
    {
        "|TINTERFACE/WorldStateFrame/AllianceIcon:16:0:1:-1|t", // Alliance
        "|TINTERFACE/WorldStateFrame/HordeIcon:16:0:1:-1|t",    // Horde
        ""                                                      // NEUTRAL
    };

    constexpr std::string_view MessageTemplate =
            "[World][{}][{}|Hplayer:{}|h{}|h|r]: {}{}|r";

    /* Config Variables */
    struct PlayerState {
        bool chatEnabled;

        PlayerState();
    };

    struct Config {
        std::string channelName;
        std::string announceMessage;
        bool enabled{};
        bool loginState{};
        bool crossFaction{};
        bool announce{};

        std::unordered_map<uint32, PlayerState> playerStates;
    };

    class WorldChat_Config : public WorldScript {
    public:
        WorldChat_Config() : WorldScript("WorldChat_Config", {
                                             WORLDHOOK_ON_BEFORE_CONFIG_LOAD
                                         }) {
        };

        void OnBeforeConfigLoad(bool reload) override;
    };

    class WorldChat_Announce : public PlayerScript {
    public:
        WorldChat_Announce()
            : PlayerScript("WorldChat_Announce", {
                               PLAYERHOOK_ON_LOGIN,
                               PLAYERHOOK_CAN_PLAYER_USE_CHANNEL_CHAT,
                           }) {
        }

        void OnPlayerLogin(Player* player) override;

        [[nodiscard]] bool OnPlayerCanUseChat(Player* player, uint32 /*type*/, uint32 lang, std::string &msg,
                                              Channel* channel) override;
    };

    class WorldChat : public CommandScript {
    public:
        WorldChat() : CommandScript("WorldChat") {
        }

        static bool HandleWorldChatCommand(ChatHandler* pChat, const char* msg);

        static bool HandleWorldChatHordeCommand(ChatHandler* pChat, const char* msg);

        static bool HandleWorldChatAllianceCommand(ChatHandler* pChat, const char* msg);

        static bool HandleWorldChatOnCommand(ChatHandler* handler);;

        static bool HandleWorldChatOffCommand(ChatHandler* handler);;

        [[nodiscard]] Acore::ChatCommands::ChatCommandTable GetCommands() const override;
    };


    void SendWorldMessage(const Player &sender, const std::string &msg, const int team);
}

#endif //AZEROTHCORE_MODULES_WORLDCHAT_H
