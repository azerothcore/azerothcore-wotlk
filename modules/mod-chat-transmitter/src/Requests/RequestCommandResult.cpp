#include "RequestCommandResult.h"
#include "../ChatTransmitter.h"

namespace ModChatTransmitter::Requests
{
    CommandResult::CommandResult(const std::string& commandId, const std::string& output, bool success)
      : commandId(commandId),
        output(output),
        success(success)
    { }

    CommandResult& CommandResult::operator=(const CommandResult& other)
    {
        commandId = other.commandId;
        output = other.output;
        success = other.success;

        return *this;
    }

    std::string CommandResult::GetContents()
    {
        nlohmann::json jsonObj;
        jsonObj["message"] = "commandResult";
        nlohmann::to_json(jsonObj["data"], *this);
        return nlohmann::to_string(jsonObj);
    }
}
