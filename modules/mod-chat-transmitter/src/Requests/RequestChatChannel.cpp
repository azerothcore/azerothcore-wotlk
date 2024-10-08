#include "RequestChatChannel.h"
#include "../ChatTransmitter.h"

namespace ModChatTransmitter::Requests
{
    ChatChannel::ChatChannel(Player* player, uint32 type, std::string& msg, Channel* channel)
      : guildId(ChatTransmitter::Instance().GetDiscordGuildId()),
        player(player),
        text(msg),
        type(type),
        channel(channel->GetName())
    { }

    ChatChannel& ChatChannel::operator=(const ChatChannel& other)
    {
        player = other.player;
        text = other.text;
        type = other.type;
        channel = other.channel;

        return *this;
    }

    std::string ChatChannel::GetContents()
    {
        nlohmann::json jsonObj;
        jsonObj["message"] = "channelChat";
        nlohmann::to_json(jsonObj["data"], *this);
        return nlohmann::to_string(jsonObj);
    }
}
