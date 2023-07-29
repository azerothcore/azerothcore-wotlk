#include "TopicRouter.h"

TopicRouter* TopicRouter::get_instance()
{
    static TopicRouter* cache;

    if (cache == nullptr)
        cache = new TopicRouter();

    return cache;
}

TopicRouter::TopicRouter()
{

}

void TopicRouter::AddHandler(ForgeTopicHandler* handler)
{
    handlers[handler->HandlesTopic] = handler;
}

void TopicRouter::Route(Player* player, uint32& type, uint32& lang, std::string& msg)
{
    if (lang == LANG_ADDON && type == CHAT_MSG_WHISPER)
    {
        int addonTypeIndex = msg.find("\t");

        if (addonTypeIndex == std::string::npos)
            return;

        std::string addonType = msg.substr(0, addonTypeIndex);

        if (addonType != MSG_TYPE_FORGE)
            return;

        int delimeterIndex = msg.find(':');

        if (delimeterIndex == std::string::npos)
            return;

        addonTypeIndex++;
        auto evnt = msg.substr(addonTypeIndex, delimeterIndex - addonTypeIndex);
        delimeterIndex++; // advance past the delimiter
        ForgeAddonMessage iam;
        iam.player = player;
        iam.message = msg.substr(delimeterIndex);
        iam.topic = evnt;
        Route(iam, msg);
        msg = ""; // clearing the message will stop it from being used in chat handler.
    }
}

void TopicRouter::Route(ForgeAddonMessage& msg, std::string& msgStr)
{
    std::unordered_map<std::string, ForgeTopicHandler*>::iterator topic = handlers.find(msg.topic);

    if (topic != handlers.end())
    {
        msgStr = "";
        topic->second->HandleMessage(msg);
    }
}


// Player, topic, message#, message
std::unordered_map<ObjectGuid, std::unordered_map<std::string, std::map<int, ForgeAddonMessage, std::greater<int>>>> messages;
