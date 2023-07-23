#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class GetPerksHandler : public ForgeTopicHandler
{
public:
    GetPerksHandler(ForgeCache* cache, ForgeCommonMessage* common) : ForgeTopicHandler(ForgeTopic::GET_PERKS)
    {
        fc = cache;
        cm = common;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message.empty())
            return;
        else if (iam.message == "-1")
            cm->SendAllPerks(iam.player);

        ForgeCharacterSpec* spec;
        if (fc->TryGetCharacterActiveSpec(iam.player, spec))
            cm->SendPerks(iam.player, spec->Id);
    }

private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
