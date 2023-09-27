#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class GetTransmogSetsHandler : public ForgeTopicHandler
{
public:
    GetTransmogSetsHandler(ForgeCache* cache, ForgeCommonMessage* cmh) : ForgeTopicHandler(ForgeTopic::GET_XMOG_SETS)
    {
        fc = cache;
        cm = cmh;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        cm->SendXmogSets(iam.player);
    }


private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
