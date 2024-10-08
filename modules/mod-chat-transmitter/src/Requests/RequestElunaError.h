#ifndef _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_ELUNA_ERROR_H_
#define _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_ELUNA_ERROR_H_

#include "../../libs/nlohmann/json.hpp"

#include "../IRequest.h"

namespace ModChatTransmitter::Requests
{
    class ElunaError : public IRequest
    {
    public:
        ElunaError(const std::string& trace);
        ElunaError& operator=(const ElunaError& other);
        std::string GetContents() override;

    protected:
        std::string guildId;
        std::string trace;

        NLOHMANN_DEFINE_TYPE_INTRUSIVE(ElunaError, guildId, trace)
    };
}

#endif // _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_ELUNA_ERROR_H_
