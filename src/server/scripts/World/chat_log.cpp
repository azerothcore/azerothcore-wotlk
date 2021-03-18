/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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
                LOG_CHAT("say", "Player %s says (language %u): %s",
                    player->GetName().c_str(), lang, msg.c_str());
                break;

            case CHAT_MSG_EMOTE:
                LOG_CHAT("emote", "Player %s emotes: %s",
                    player->GetName().c_str(), msg.c_str());
                break;

            case CHAT_MSG_YELL:
                LOG_CHAT("yell", "Player %s yells (language %u): %s",
                    player->GetName().c_str(), lang, msg.c_str());
                break;
        }
    }

    void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Player* receiver) override
    {
        LOG_CHAT("whisper", "Player %s tells %s: %s",
               player->GetName().c_str(), receiver ? receiver->GetName().c_str() : "<unknown>", msg.c_str());
    }

    void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group) override
    {
        //! NOTE:
        //! LANG_ADDON can only be sent by client in "PARTY", "RAID", "GUILD", "BATTLEGROUND", "WHISPER"
        switch (type)
        {
            case CHAT_MSG_PARTY:
                LOG_CHAT("party", "Player %s tells group with leader %s: %s",
                    player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
                break;

            case CHAT_MSG_PARTY_LEADER:
                LOG_CHAT("party", "Leader %s tells group: %s",
                    player->GetName().c_str(), msg.c_str());
                break;

            case CHAT_MSG_RAID:
                LOG_CHAT("raid", "Player %s tells raid with leader %s: %s",
                    player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
                break;

            case CHAT_MSG_RAID_LEADER:
                LOG_CHAT("raid", "Leader player %s tells raid: %s",
                    player->GetName().c_str(), msg.c_str());
                break;

            case CHAT_MSG_RAID_WARNING:
                LOG_CHAT("raid", "Leader player %s warns raid with: %s",
                    player->GetName().c_str(), msg.c_str());
                break;

            case CHAT_MSG_BATTLEGROUND:
                LOG_CHAT("bg", "Player %s tells battleground with leader %s: %s",
                    player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
                break;

            case CHAT_MSG_BATTLEGROUND_LEADER:
                LOG_CHAT("bg", "Leader player %s tells battleground: %s",
                    player->GetName().c_str(), msg.c_str());
                break;
        }
    }

    void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild) override
    {
        switch (type)
        {
            case CHAT_MSG_GUILD:
                LOG_CHAT("guild", "Player %s tells guild %s: %s",
                    player->GetName().c_str(), guild ? guild->GetName().c_str() : "<unknown>", msg.c_str());
                break;

            case CHAT_MSG_OFFICER:
                LOG_CHAT("guild.officer", "Player %s tells guild %s officers: %s",
                    player->GetName().c_str(), guild ? guild->GetName().c_str() : "<unknown>", msg.c_str());
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
            LOG_CHAT("system", "Player %s tells channel %s: %s",
                player->GetName().c_str(), channel->GetName().c_str(), msg.c_str());
        }
        else
        {
            std::string channelName = channel ? channel->GetName() : "<unknown>";
            LOG_CHAT("channel." + channelName, "Player %s tells channel %s: %s",
                player->GetName().c_str(), channelName.c_str(), msg.c_str());
        }
    }
};

void AddSC_chat_log()
{
    new ChatLogScript();
}
