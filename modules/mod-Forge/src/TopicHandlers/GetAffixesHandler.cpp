#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class GetAffixesHandler : public ForgeTopicHandler
{
public:
    GetAffixesHandler(ForgeCache* cache, ForgeCommonMessage* messageCommon) : ForgeTopicHandler(ForgeTopic::MYTHIC_GET_AFFIXES_LIST)
    {
        fc = cache;
        mc = messageCommon;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        auto affixes = sObjectMgr->GetForgeAffixesByTierMap();

        std::string out = "";
        std::string delim = "";

        for (auto tier : affixes) {
            if (tier.first > 1)
                delim = ";";

            out += delim + std::to_string(tier.first) + "K";

            std::string sep = "";
            for (int i = 0; i < tier.second.size(); i++) {
                if (i > 0)
                    sep = "*";

                out += sep + std::to_string(tier.second[i]);
            }
        }

        iam.player->SendForgeUIMsg(ForgeTopic::MYTHIC_GET_AFFIXES_LIST, out);
    }


private:

    ForgeCache* fc;
    ForgeCommonMessage* mc;
};
