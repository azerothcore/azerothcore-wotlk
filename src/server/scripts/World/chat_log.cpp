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
#include "CreatureScript.h"
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

    void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg) override
    {
        switch (type)
        {
            case CHAT_MSG_SAY:
                LOG_INFO("chat.say", "Player {} says (language {}): {}",
                    player->GetName(), lang, msg);
                break;

            case CHAT_MSG_EMOTE:
                LOG_INFO("chat.emote", "Player {} emotes: {}",
                    player->GetName(), msg);
                break;

            case CHAT_MSG_YELL:
                LOG_INFO("chat.yell", "Player {} yells (language {}): {}",
                    player->GetName(), lang, msg);
                break;
        }
    }

    void OnChat(Player* player, uint32 /*type*/, uint32 /*lang*/, std::string& msg, Player* receiver) override
    {
        LOG_INFO("chat.whisper", "Player {} tells {}: {}",
               player->GetName(), receiver ? receiver->GetName() : "<unknown>", msg);
    }

    void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group) override
    {
        std::string str = lang != LANG_ADDON ? "chat." : "chat.addon.";
        //! NOTE:
        //! LANG_ADDON can only be sent by client in "PARTY", "RAID", "GUILD", "BATTLEGROUND", "WHISPER"
        switch (type)
        {
            case CHAT_MSG_PARTY:
                LOG_INFO(str + "party", "Player {} tells group with leader {}: {}",
                    player->GetName(), group ? group->GetLeaderName() : "<unknown>", msg);
                break;

            case CHAT_MSG_PARTY_LEADER:
                LOG_INFO(str + "party", "Leader {} tells group: {}",
                    player->GetName(), msg);
                break;

            case CHAT_MSG_RAID:
                LOG_INFO(str + "raid", "Player {} tells raid with leader {}: {}",
                    player->GetName(), group ? group->GetLeaderName() : "<unknown>", msg);
                break;

            case CHAT_MSG_RAID_LEADER:
                LOG_INFO(str + "raid", "Leader player {} tells raid: {}",
                    player->GetName(), msg);
                break;

            case CHAT_MSG_RAID_WARNING:
                LOG_INFO(str + "raid", "Leader player {} sends raid warning: {}",
                    player->GetName(), msg);
                break;

            case CHAT_MSG_BATTLEGROUND:
                LOG_INFO(str + "bg", "Player {} tells battleground with leader {}: {}",
                    player->GetName(), group ? group->GetLeaderName() : "<unknown>", msg);
                break;

            case CHAT_MSG_BATTLEGROUND_LEADER:
                LOG_INFO(str + "bg", "Leader player {} tells battleground: {}",
                    player->GetName(), msg);
                break;
        }
    }

    void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild) override
    {
        std::string str = lang != LANG_ADDON ? "chat." : "chat.addon.";
        switch (type)
        {
            case CHAT_MSG_GUILD:
                LOG_INFO(str + "guild", "Player {} tells guild {}: {}",
                    player->GetName(), guild ? guild->GetName() : "<unknown>", msg);
                break;

            case CHAT_MSG_OFFICER:
                LOG_INFO(str + "guild.officer", "Player {} tells guild {} officers: {}",
                    player->GetName(), guild ? guild->GetName() : "<unknown>", msg);
                break;
        }
    }

    void OnChat(Player* player, uint32 /*type*/, uint32 /*lang*/, std::string& msg, Channel* channel) override
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

