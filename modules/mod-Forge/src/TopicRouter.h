#pragma once

#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include <ForgeTopicHandler.h>
#include <unordered_map>

class TopicRouter
{
public:
    static TopicRouter* get_instance();
        TopicRouter();

        void AddHandler(ForgeTopicHandler*);
        void Route(Player* player, uint32& type, uint32& lang, std::string& msg);
        void Route(ForgeAddonMessage& msg, std::string& msgStr);

private:
    std::unordered_map<std::string, ForgeTopicHandler*> handlers;
    // Player, topic, message#, message
    std::unordered_map<ObjectGuid, std::unordered_map<std::string, std::map<int, ForgeAddonMessage, std::greater<int>>>> messages;
};

#define sTopicRouter TopicRouter::get_instance()
