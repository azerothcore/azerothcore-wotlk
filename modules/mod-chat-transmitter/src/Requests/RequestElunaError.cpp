#include "RequestElunaError.h"
#include "../ChatTransmitter.h"

namespace ModChatTransmitter::Requests
{
    ElunaError::ElunaError(const std::string& trace)
        : guildId(ChatTransmitter::Instance().GetDiscordGuildId()),
        trace(trace)
    { }

    ElunaError& ElunaError::operator=(const ElunaError& other)
    {
        guildId = other.guildId;
        trace = other.trace;

        return *this;
    }

    std::string ElunaError::GetContents()
    {
        nlohmann::json jsonObj;
        jsonObj["message"] = "elunaError";
        nlohmann::to_json(jsonObj["data"], *this);
        return nlohmann::to_string(jsonObj);
    }
}
