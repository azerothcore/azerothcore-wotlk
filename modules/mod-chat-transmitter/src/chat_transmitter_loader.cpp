#include "ChatTransmitter.h"
#include "Log.h"

void Addmod_chat_transmitterScripts()
{
    LOG_INFO("module", "[ModChatTransmitter] Initializing...");
    ModChatTransmitter::ChatTransmitter::Instance();
}
