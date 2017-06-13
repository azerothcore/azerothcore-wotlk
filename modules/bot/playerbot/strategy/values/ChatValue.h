#pragma once
#include "../Value.h"

namespace BotAI
{
    class ChatValue : public ManualSetValue<ChatMsg>
	{
	public:
        ChatValue(PlayerbotAI* ai) : ManualSetValue<ChatMsg>(ai, CHAT_MSG_WHISPER) {}
    };
}
