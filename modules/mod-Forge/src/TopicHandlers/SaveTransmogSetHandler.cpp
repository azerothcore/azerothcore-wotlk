#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>
#include <boost/algorithm/string.hpp>

class SaveTransmogSetHandler : public ForgeTopicHandler
{
public:
    SaveTransmogSetHandler(ForgeCache* cache, ForgeCommonMessage* cmh) : ForgeTopicHandler(ForgeTopic::SAVE_XMOG_SET)
    {
        fc = cache;
        cm = cmh;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message.empty())
            return;

        std::vector<std::string> results;
        boost::algorithm::split(results, iam.message, boost::is_any_of(";"));

        if (results.empty() || results.size() != 2 || !fc->isNumber(results[0]))
            return;

        uint32 setId = static_cast<uint32>(std::stoul(results[0]));
        std::string name = results[1];

        if (setId < (uint8)sConfigMgr->GetIntDefault("Transmogrification.MaxSets", 10))
            fc->SaveXmogSet(iam.player, setId);
        else
            fc->AddXmogSet(iam.player, setId, name);
    }


private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
