#include "ForgeTopicHandler.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include <string>

ForgeTopicHandler::ForgeTopicHandler(const std::string& topic)
{
    HandlesTopic = topic;
}

ForgeTopicHandler::ForgeTopicHandler(ForgeTopic topic)
{
    HandlesTopic = std::to_string((int)topic);
}
