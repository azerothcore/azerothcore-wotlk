#ifndef _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_COMMAND_RESULT_H_
#define _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_COMMAND_RESULT_H_

#include "../../libs/nlohmann/json.hpp"

#include "../IRequest.h"

namespace ModChatTransmitter::Requests
{
    class CommandResult : public IRequest
    {
    public:
        CommandResult(const std::string& commandId, const std::string& output, bool success);
        CommandResult& operator=(const CommandResult& other);
        std::string GetContents() override;

    protected:
        std::string commandId;
        std::string output;
        bool success;

        NLOHMANN_DEFINE_TYPE_INTRUSIVE(CommandResult, commandId, output, success)
    };
}

#endif // _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_COMMAND_RESULT_H_
