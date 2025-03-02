/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Channel.h"
#include "Group.h"
#include "Guild.h"
#include "Log.h"
#include "PlayerScript.h"

class ChatLogScript : public PlayerScript
{
public:
    ChatLogScript() :
        PlayerScript("ChatLogScript",
        {
            PLAYERHOOK_ON_CHAT,
            PLAYERHOOK_ON_CHAT_WITH_GROUP,
            PLAYERHOOK_ON_CHAT_WITH_GUILD,
            PLAYERHOOK_ON_CHAT_WITH_CHANNEL,
            PLAYERHOOK_ON_CHAT_WITH_RECEIVER
        })
    {
    }

    void OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg) override
    {
        std::string logType = "";
        std::string chatType = "";

        switch (type)
        {
            case CHAT_MSG_SAY:
                logType = "chat.say";
                chatType = "says";
                break;
            case CHAT_MSG_EMOTE:
                logType = "chat.emote";
                chatType = "emotes";
                break;
            case CHAT_MSG_YELL:
                logType = "chat.yell";
                chatType = "yells";
                break;
            default:
                return;
        }

        LOG_INFO(logType, "Player {} {} (language {}): {}",
            player->GetName(), chatType, lang, msg);
    }

    void OnPlayerChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Player* receiver) override
    {
        //! NOTE:
        //! LANG_ADDON can only be sent by client in "PARTY", "RAID", "GUILD", "BATTLEGROUND", "WHISPER"
        std::string logType = (lang != LANG_ADDON) ? "chat." : "chat.addon.";
        std::string msgType = "whisper";

        LOG_INFO(logType + msgType, "Player {} {} {}: {}",
               player->GetName(), msgType, receiver ? receiver->GetName() : "<unknown>", msg);
    }

    void OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group) override
    {
        //! NOTE:
        //! LANG_ADDON can only be sent by client in "PARTY", "RAID", "GUILD", "BATTLEGROUND", "WHISPER"
        std::string logType = (lang != LANG_ADDON) ? "chat." : "chat.addon.";
        std::string msgType = "";

        switch (type)
        {
            case CHAT_MSG_PARTY:
            case CHAT_MSG_PARTY_LEADER:
                msgType = "party";
                break;
            case CHAT_MSG_RAID:
            case CHAT_MSG_RAID_LEADER:
            case CHAT_MSG_RAID_WARNING:
                msgType = "raid";
                break;
            case CHAT_MSG_BATTLEGROUND:
            case CHAT_MSG_BATTLEGROUND_LEADER:
                msgType = "bg";
                break;
            default:
                return;
        }

        std::string role = (type == CHAT_MSG_PARTY_LEADER || type == CHAT_MSG_RAID_LEADER || type == CHAT_MSG_BATTLEGROUND_LEADER) ? "Leader player" : "Player";
        std::string action = (type == CHAT_MSG_RAID_WARNING) ? "sends raid warning" : "tells";
        std::string targetGroup = group ? group->GetLeaderName() : "<unknown>";

        LOG_INFO(logType + msgType, "{} {} {} {} with leader {}: {}",
            role, player->GetName(), action, msgType, targetGroup, msg);
    }

    void OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild) override
    {
        //! NOTE:
        //! LANG_ADDON can only be sent by client in "PARTY", "RAID", "GUILD", "BATTLEGROUND", "WHISPER"
        std::string logType = (lang != LANG_ADDON) ? "chat." : "chat.addon.";
        std::string msgType = "";

        switch (type)
        {
            case CHAT_MSG_GUILD:
                msgType = "guild";
                break;
            case CHAT_MSG_OFFICER:
                msgType = "guild.officer";
                break;
            default:
                return;
        }

        LOG_INFO(logType + msgType, "Player {} tells {} \"{}\": {}",
            player->GetName(), msgType, guild ? guild->GetName() : "<unknown>", msg);
    }

    void OnPlayerChat(Player* player, uint32 /*type*/, uint32 /*lang*/, std::string& msg, Channel* channel) override
    {
        bool isSystem = channel &&
                        (channel->HasFlag(CHANNEL_FLAG_TRADE) ||
                         channel->HasFlag(CHANNEL_FLAG_GENERAL) ||
                         channel->HasFlag(CHANNEL_FLAG_CITY) ||
                         channel->HasFlag(CHANNEL_FLAG_LFG));

        if (isSystem)
        {
            LOG_INFO("chat.channel", "Player {} tells channel {}: {}",
                player->GetName(), channel->GetName(), msg);
        }
        else
        {
            // Allow to log custom channels. i.e. world channel
            // in that case set config: Logger.channel.world=6,Chat
            std::string channelName = channel ? channel->GetName() : "<unknown>";
            LOG_INFO("chat.channel." + channelName, "Player {} tells channel {}: {}",
                player->GetName(), channelName, msg);
        }
    }
};

void AddSC_chat_log()
{
    new ChatLogScript();
}
