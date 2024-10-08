#ifndef _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_CHAT_H_
#define _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_CHAT_H_

#include "../../libs/nlohmann/json.hpp"

#include "../IRequest.h"
#include "../PlayerInfo.h"

namespace ModChatTransmitter::Requests
{
    class Chat : public IRequest
    {
    public:
        Chat(Player* player, uint32 type, std::string& msg);
        Chat& operator=(const Chat& other);
        std::string GetContents() override;

    protected:
        std::string guildId;
        PlayerInfo player;
        std::string text;
        uint32 type;
        std::string zone;

        NLOHMANN_DEFINE_TYPE_INTRUSIVE(Chat, guildId, player, text, type, zone)
    };
}

#endif // _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_CHAT_H_
