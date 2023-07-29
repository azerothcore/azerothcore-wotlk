#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class GetTalentTreeHandler : public ForgeTopicHandler
{
public:
    GetTalentTreeHandler(ForgeCache* cache, ForgeCommonMessage* fcm) : ForgeTopicHandler(ForgeTopic::TALENT_TREE_LAYOUT)
    {
        fc = cache;
        cm = fcm;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message == "-1" || iam.message == "" || !fc->isNumber(iam.message))
        {
            cm->SendTalentTreeLayout(iam.player);
        }
        else
        {
            uint32 tabId = static_cast<uint32>(std::stoul(iam.message));
            cm->SendTalentTreeLayout(iam.player, tabId);
        }
    }


private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
