#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include <ForgeCache.cpp>
#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>

class UpdateSpecHandler : public ForgeTopicHandler
{
public:
    UpdateSpecHandler(ForgeCache* cache) : ForgeTopicHandler(ForgeTopic::UPDATE_SPEC)
    {
        fc = cache;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message.empty())
            return;

        std::vector<std::string> results;
        boost::algorithm::split(results, iam.message, boost::is_any_of(";"));

        if (results.empty() || results.size() != 6 || !fc->isNumber(results[0]) || !fc->isNumber(results[3]) || !fc->isNumber(results[4]) || !fc->isNumber(results[5]))
            return;

        uint32 id = static_cast<uint32>(std::stoul(results[0]));
        ForgeCharacterSpec* spec;

        if (fc->TryGetCharacterSpec(iam.player, id, spec))
        {
            spec->Name = results[1];
            spec->Description = results[2];
            spec->Active = boost::lexical_cast<bool>(results[3]);
            spec->SpellIconId = static_cast<uint32>(std::stoul(results[4]));
            spec->Visability = (SpecVisibility)std::stoi(results[5]);
            fc->UpdateCharacterSpecDetailsOnly(iam.player, spec);
        }
        else
        {
            iam.player->SendForgeUIMsg(ForgeTopic::UPDATE_SPEC_ERROR, "Unknown Spec");
        }
    }

private:

    ForgeCache* fc;
};
