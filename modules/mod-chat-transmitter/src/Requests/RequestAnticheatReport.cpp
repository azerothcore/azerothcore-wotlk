#include "RequestAnticheatReport.h"
#include "../ChatTransmitter.h"

namespace ModChatTransmitter::Requests
{
    AnticheatReport::AnticheatReport(Player* player, uint16 reportType)
        : guildId(ChatTransmitter::Instance().GetDiscordGuildId()),
        player(player),
        reportType(reportType)
    { }

    AnticheatReport& AnticheatReport::operator=(const AnticheatReport& other)
    {
        player = other.player;
        reportType = other.reportType;

        return *this;
    }

    std::string AnticheatReport::GetContents()
    {
        nlohmann::json jsonObj;
        jsonObj["message"] = "anticheatReport";
        nlohmann::to_json(jsonObj["data"], *this);
        return nlohmann::to_string(jsonObj);
    }
}
