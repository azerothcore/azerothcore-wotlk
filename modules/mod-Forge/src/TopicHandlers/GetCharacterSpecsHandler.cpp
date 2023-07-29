#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class GetCharacterSpecsHandler : public ForgeTopicHandler
{
public:
    GetCharacterSpecsHandler(ForgeCache* cache, ForgeCommonMessage* fcm) : ForgeTopicHandler(ForgeTopic::GET_CHARACTER_SPECS)
    {
        fc = cache;
        cm = fcm;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        cm->SendSpecInfo(iam.player);
    }

private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
