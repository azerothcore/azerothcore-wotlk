#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class ResetTransmogHandler : public ForgeTopicHandler
{
public:
    ResetTransmogHandler(ForgeCache* cache, ForgeCommonMessage* messageCommon) : ForgeTopicHandler(ForgeTopic::GET_TALENTS)
    {
        fc = cache;
        mc = messageCommon;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message == "-1" || iam.message == "" || !fc->isNumber(iam.message))
        {
            mc->SendTalents(iam.player);
        }
        else
        {
            uint32 tabId = static_cast<uint32>(std::stoul(iam.message));
            mc->SendTalents(iam.player, tabId);
        }
    }


private:

    ForgeCache* fc;
    ForgeCommonMessage* mc;
};
