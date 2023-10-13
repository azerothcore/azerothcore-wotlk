#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>
#include <boost/algorithm/string.hpp>

const auto GAMEOBJECT_TYPE_KEYSTONE_RECEPTACLE = 1000000;

class StartMythicHandler : public ForgeTopicHandler
{
public:
    StartMythicHandler(ForgeCache* cache, ForgeCommonMessage* messageCommon) : ForgeTopicHandler(ForgeTopic::MYTHIC_SET_AFFIXES_AND_START)
    {
        fc = cache;
        mc = messageCommon;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message == "ping") {
            if (auto script = iam.player->GetInstanceScript())
                if (script->IsChallengeModeStarted())
                    script->SendChallengeModeStart(iam.player);

            return;
        }
        else {

            if (!iam.player->mythicStartCheck)
                return;

            if (iam.message.empty())
                return;

            std::vector<std::string> results;
            boost::algorithm::split(results, iam.message, boost::is_any_of("~"));

            auto affixesRcv = results.size();

            if (results.empty() || !fc->isNumber(results[0]))
                return;
            else if (affixesRcv > 1)
                if (!fc->isNumber(results[1]))
                    return;
                else if (affixesRcv > 2)
                    if (!fc->isNumber(results[2]))
                        return;

            auto map = iam.player->GetMap()->GetId();
            auto keyMap = sObjectMgr->GetDungeonKeyMap();
            auto item = keyMap[map];

            if (!iam.player->HasItemCount(item->itemId))
                return;

            auto difficulty = -(iam.player->GetItemByEntry(item->itemId)->GetItemRandomPropertyId() + 100);
            auto affixesIntended = GetAffixCountForLevel(difficulty);

            if (affixesRcv != affixesIntended)
                return;

            uint32 tierOne = static_cast<uint32>(std::stoul(results[0]));
            if (!sObjectMgr->AffixExistsAndMatchesTier(tierOne, 1))
                return;

            uint32 tierTwo = 0;
            uint32 tierThree = 0;
            if (affixesIntended > 1) {
                tierTwo = static_cast<uint32>(std::stoul(results[1]));
                if (!sObjectMgr->AffixExistsAndMatchesTier(tierTwo, 2))
                    return;
                else if (affixesIntended > 2) {
                    tierThree = static_cast<uint32>(std::stoul(results[2]));
                    if (!sObjectMgr->AffixExistsAndMatchesTier(tierThree, 3))
                        return;
                }
            }

            iam.player->GetInstanceScript()->StartChallengeMode(iam.player, item, difficulty, tierOne, tierTwo, tierThree);
        }
    }

private:
    uint8 GetAffixCountForLevel(uint8 difficulty) {
        auto out = 1;
        if (difficulty > 3)
            out = 2;
        if (difficulty > 6)
            out = 3;
        return out;
    }

    ForgeCache* fc;
    ForgeCommonMessage* mc;
};
