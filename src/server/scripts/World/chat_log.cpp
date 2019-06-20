/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "Channel.h"
#include "Guild.h"
#include "Group.h"

class ChatLogScript : public PlayerScript
{
public:
    ChatLogScript() : PlayerScript("ChatLogScript") { }

    void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg) override
    {
        switch (type)
        {
        case CHAT_MSG_ADDON:
            LOG_DEBUG("chat.log.addon", "[ADDON] Player %s sends: %s", player->GetName().c_str(), msg.c_str());
            break;
        case CHAT_MSG_SAY:
            LOG_DEBUG("chat.log.say", "[SAY] Player %s says (language %u): %s", player->GetName().c_str(), lang, msg.c_str());
            break;
        case CHAT_MSG_EMOTE:
            LOG_DEBUG("chat.log.emote", "[TEXTEMOTE] Player %s emotes: %s", player->GetName().c_str(), msg.c_str());
            break;
        case CHAT_MSG_YELL:
            LOG_DEBUG("chat.log.yell", "[YELL] Player %s yells (language %u): %s", player->GetName().c_str(), lang, msg.c_str());
            break;
        }
    }

    void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Player* receiver) override
    {
        if (lang != LANG_ADDON)
            LOG_DEBUG("chat.log.whisper", "[WHISPER] Player %s tells %s: %s",
                player->GetName().c_str(), receiver ? receiver->GetName().c_str() : "<unknown>", msg.c_str());
        else
            LOG_DEBUG("chat.log.addon.whisper", "[ADDON] Player %s tells %s: %s",
                player->GetName().c_str(), receiver ? receiver->GetName().c_str() : "<unknown>", msg.c_str());
    }

    void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group) override
    {
        //! NOTE:
        //! LANG_ADDON can only be sent by client in "PARTY", "RAID", "GUILD", "BATTLEGROUND", "WHISPER"
        switch (type)
        {
        case CHAT_MSG_PARTY:
            if (lang != LANG_ADDON)
                LOG_DEBUG("chat.log.party", "[PARTY] Player %s tells group with leader %s: %s",
                    player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
            else
                LOG_DEBUG("chat.log.addon.party", "[ADDON] Player %s tells group with leader %s: %s",
                    player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
            break;
        case CHAT_MSG_PARTY_LEADER:
            LOG_DEBUG("chat.log.party", "[PARTY] Leader %s tells group: %s", player->GetName().c_str(), msg.c_str());
            break;
        case CHAT_MSG_RAID:
            if (lang != LANG_ADDON)
                LOG_DEBUG("chat.log.raid", "[RAID] Player %s tells raid with leader %s: %s", 
                    player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
            else
                LOG_DEBUG("chat.log.addon.raid", "[ADDON] Player %s tells raid with leader %s: %s",
                    player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
            break;
        case CHAT_MSG_RAID_LEADER:
            LOG_DEBUG("chat.log.raid", "[RAID] Leader player %s tells raid: %s", player->GetName().c_str(), msg.c_str());
            break;
        case CHAT_MSG_RAID_WARNING:
            LOG_DEBUG("chat.log.raid", "[RAID] Leader player %s warns raid with: %s", player->GetName().c_str(), msg.c_str());
            break;
        case CHAT_MSG_BATTLEGROUND:
            if (lang != LANG_ADDON)
                LOG_DEBUG("chat.log.bg", "[BATTLEGROUND] Player %s tells battleground with leader %s: %s",
                    player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
            else
                LOG_DEBUG("chat.log.addon.bg", "[ADDON] Player %s tells battleground with leader %s: %s",
                    player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
            break;
        case CHAT_MSG_BATTLEGROUND_LEADER:
            LOG_DEBUG("chat.log.bg", "[BATTLEGROUND] Leader player %s tells battleground: %s",
                player->GetName().c_str(), msg.c_str());
            break;
        }
    }

    void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild) override
    {
        switch (type)
        {
        case CHAT_MSG_GUILD:
            if (lang != LANG_ADDON)
                LOG_DEBUG("chat.log.guild", "[GUILD] Player %s tells guild %s: %s",
                    player->GetName().c_str(), guild ? guild->GetName().c_str() : "<unknown>", msg.c_str());
            else if (lang == LANG_ADDON)
                LOG_DEBUG("chat.log.addon.guild", "[ADDON] Player %s sends to guild %s: %s",
                    player->GetName().c_str(), guild ? guild->GetName().c_str() : "<unknown>", msg.c_str());
            break;
        case CHAT_MSG_OFFICER:
            LOG_DEBUG("chat.log.guild", "[OFFICER] Player %s tells guild %s officers: %s",
                player->GetName().c_str(), guild ? guild->GetName().c_str() : "<unknown>", msg.c_str());
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
            LOG_DEBUG("server", "[SYSCHAN] Player %s tells channel %s: %s",
                player->GetName().c_str(), channel->GetName().c_str(), msg.c_str());
        else
        {
            std::string channelName = channel ? channel->GetName() : "<unknown>";
            LOG_DEBUG("chat.log.channel." + channelName, "[CHANNEL] Player %s tells channel %s: %s", player->GetName().c_str(), channelName.c_str(), msg.c_str());
        }
    }
};

void AddSC_chat_log()
{
    new ChatLogScript();
}
