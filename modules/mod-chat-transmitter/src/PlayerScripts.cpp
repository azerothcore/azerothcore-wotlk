#include "ChatTransmitter.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"

namespace ModChatTransmitter
{
    class PlayerScripts : public PlayerScript
    {
    public:
        PlayerScripts() : PlayerScript("ModChatTransmitterPlayerScripts")
        { }

        void OnLogin(Player*/* player*/)
        { }

        void OnChat(Player* player, uint32 type, uint32/* lang*/, std::string& msg)
        {
            if (type == ChatMsg::CHAT_MSG_SAY || type == CHAT_MSG_YELL || type == CHAT_MSG_EMOTE)
            {
                ChatTransmitter::Instance().QueueChat(player, type, msg);
            }
        }

        void OnChat(Player* player, uint32 type, uint32/* lang*/, std::string& msg, Channel* channel)
        {
            std::string addonChannels[] = { "Crb", "LFGForwarder", "TCForwarder", "LFGShout", "xtensionxtooltip2", "QuickHealMod" };
            for (const std::string& addonChannel : addonChannels)
            {
                if (channel->GetName().find(addonChannel) != std::string::npos)
                {
                    return;
                }
            }
            ChatTransmitter::Instance().QueueChat(player, type, msg, channel);
        }
    };

    void AddPlayerScripts()
    {
        new PlayerScripts();
    }
}
