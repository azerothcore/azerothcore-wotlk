#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class GetTransmogHandler : public ForgeTopicHandler
{
public:
    GetTransmogHandler(ForgeCache* cache, ForgeCommonMessage* cmh) : ForgeTopicHandler(ForgeTopic::LOAD_XMOG_SET)
    {
        fc = cache;
        cm = cmh;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message == "-1" || iam.message == "" || !fc->isNumber(iam.message))
            return;

        uint32 setId = static_cast<uint32>(std::stoul(iam.message));
        cm->SendXmogSet(iam.player, setId);
    }


private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
