#ifndef _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_CHAT_CHANNEL_H_
#define _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_CHAT_CHANNEL_H_

#include "../../libs/nlohmann/json.hpp"

#include "Channel.h"
#include "../IRequest.h"
#include "../PlayerInfo.h"

namespace ModChatTransmitter::Requests
{
    class ChatChannel : public IRequest
    {
    public:
        ChatChannel(Player* player, uint32 type, std::string& msg, Channel* channel);
        ChatChannel& operator=(const ChatChannel& other);
        std::string GetContents() override;

    protected:
        std::string guildId;
        PlayerInfo player;
        std::string text;
        uint32 type;
        std::string channel;

        NLOHMANN_DEFINE_TYPE_INTRUSIVE(ChatChannel, guildId, player, text, type, channel)
    };
}

#endif // _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_CHAT_CHANNEL_H_
