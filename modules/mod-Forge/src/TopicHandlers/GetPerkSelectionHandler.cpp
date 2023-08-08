#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class GetPerkSelectionHandler : public ForgeTopicHandler
{
public:
    GetPerkSelectionHandler(ForgeCache* cache, ForgeCommonMessage* common) : ForgeTopicHandler(ForgeTopic::OFFER_SELECTION)
    {
        fc = cache;
        cm = common;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message.empty())
            return;

        if (!fc->isNumber(iam.message))
            return;

        uint32 specId = static_cast<uint32>(std::stoul(iam.message));
        ForgeCharacterSpec* spec;
        if (fc->TryGetCharacterActiveSpec(iam.player, spec)) {

            if (specId != iam.player->GetActiveSpec()) {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_PERK_ERROR, "Incorrect spec for selection request: Id "
                    + std::to_string(specId) + " given when " + std::to_string(iam.player->GetActiveSpec()) + " expected.");
                return;
            }

            cm->SendWithstandingSelect(iam.player, "");
        }
    }

private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
