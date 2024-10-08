#ifndef _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_ANTICHEAT_REPORT_H_
#define _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_ANTICHEAT_REPORT_H_

#include "../../libs/nlohmann/json.hpp"

#include "../IRequest.h"
#include "../PlayerInfo.h"

namespace ModChatTransmitter::Requests
{
    class AnticheatReport : public IRequest
    {
    public:
        AnticheatReport(Player* player, uint16 reportType);
        AnticheatReport& operator=(const AnticheatReport& other);
        std::string GetContents() override;

    protected:
        std::string guildId;
        PlayerInfo player;
        uint16 reportType;

        NLOHMANN_DEFINE_TYPE_INTRUSIVE(AnticheatReport, guildId, player, reportType)
    };
}

#endif // _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_ANTICHEAT_REPORT_H_
