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
#include "ScriptMgr.h"

#define LOG_CHAT(TYPE, ...)                             \
    if (lang != LANG_ADDON)                             \
        LOG_DEBUG("chat.log." TYPE, __VA_ARGS__);       \
    else                                                \
        LOG_DEBUG("chat.log.addon." TYPE, __VA_ARGS__);

class ChatLogScript : public PlayerScript
{
public:
    ChatLogScript() : PlayerScript("ChatLogScript") { }

    void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg) override
    {
        switch (type)
        {
            case CHAT_MSG_SAY:
                LOG_CHAT("say", "[SAY] Игрок {} говорит (язык {}): {}",
                    player->GetName(), lang, msg);
                break;

            case CHAT_MSG_EMOTE:
                LOG_CHAT("emote", "Игрок {} показывают эмоцию: {}",
                    player->GetName(), msg);
                break;

            case CHAT_MSG_YELL:
                LOG_CHAT("yell", "Игрок {} кричит (язык {}): {}",
                    player->GetName(), lang, msg);
                break;
        }
    }

    void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Player* receiver) override
    {
        LOG_CHAT("whisper", "[WHISPER] Игрок {} шепчет {}: {}",
               player->GetName(), receiver ? receiver->GetName() : "<unknown>", msg);
    }

    void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group) override
    {
        //! NOTE:
        //! LANG_ADDON can only be sent by client in "PARTY", "RAID", "GUILD", "BATTLEGROUND", "WHISPER"
        switch (type)
        {
            case CHAT_MSG_PARTY:
                LOG_CHAT("party", "[PARTY] Игрок {} говорит группе с лидером {}: {}",
                    player->GetName(), group ? group->GetLeaderName() : "<unknown>", msg);
                break;

            case CHAT_MSG_PARTY_LEADER:
                LOG_CHAT("party", "[PARTY] Лидер группы {} говорит: {}",
                    player->GetName(), msg);
                break;

            case CHAT_MSG_RAID:
                LOG_CHAT("raid", "[RAID] Игрок {} говорит рейду с лидером {}: {}",
                    player->GetName(), group ? group->GetLeaderName() : "<unknown>", msg);
                break;

            case CHAT_MSG_RAID_LEADER:
                LOG_CHAT("raid", "[RAID] Лидер рейда {} говорит: {}",
                    player->GetName(), msg);
                break;

            case CHAT_MSG_RAID_WARNING:
                LOG_CHAT("raid", "Лидер рейда {} предупреждает рейд с: {}",
                    player->GetName(), msg);
                break;

            case CHAT_MSG_BATTLEGROUND:
                LOG_CHAT("bg", "[BG] Игрок {} говорит на BG с лидером {}: {}",
                    player->GetName(), group ? group->GetLeaderName() : "<unknown>", msg);
                break;

            case CHAT_MSG_BATTLEGROUND_LEADER:
                LOG_CHAT("bg", "[BG] Лидер BG {} говорит: {}",
                    player->GetName(), msg);
                break;
        }
    }

    void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild) override
    {
        switch (type)
        {
            case CHAT_MSG_GUILD:
                LOG_CHAT("guild", "[GUILD] Игрок {} говорит гильдии {}: {}",
                    player->GetName(), guild ? guild->GetName() : "<unknown>", msg);
                break;

            case CHAT_MSG_OFFICER:
                LOG_CHAT("guild.officer", "[GUILD] Игрок {} говорит гильдии {} офицерам: {}",
                    player->GetName(), guild ? guild->GetName() : "<unknown>", msg);
                break;
        }
    }

    void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Channel* channel) override
    {
        bool isSystem = channel &&
                        (channel->HasFlag(CHANNEL_FLAG_TRADE) ||
                         channel->HasFlag(CHANNEL_FLAG_GENERAL) ||
                         channel->HasFlag(CHANNEL_FLAG_CITY) ||
                         channel->HasFlag(CHANNEL_FLAG_LFG));

        if (isSystem)
        {
            LOG_CHAT("system", "[CHANNEL] Игрок {} говорит в канале {}: {}",
                player->GetName(), channel->GetName(), msg);
        }
        else
        {
            std::string channelName = channel ? channel->GetName() : "<unknown>";
            LOG_CHAT("channel." + channelName, "[CHANNEL] Игрок {} говорит в канале [{}]: {}",
                player->GetName(), channelName, msg);
        }
    }
};

void AddSC_chat_log()
{
    new ChatLogScript();
}
