#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class GetCollectionsHandler : public ForgeTopicHandler
{
public:
    GetCollectionsHandler(ForgeCache* cache, ForgeCommonMessage* cmh) : ForgeTopicHandler(ForgeTopic::COLLECTION_INIT)
    {
        fc = cache;
        cm = cmh;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message == "-1" || iam.message == "" || !fc->isNumber(iam.message))
        {
            SendCollections(iam.player);
        }
        else
        {
            uint32 slotId = static_cast<uint32>(std::stoul(iam.message));
            SendCollections(iam.player, slotId, "");
        }
    }

private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;

    void SendCollections(Player* player) {
        std::string msg = "";


        for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
        {

            msg = SendCollections(player, slot, msg);
        }

        player->SendForgeUIMsg(ForgeTopic::COLLECTION_INIT, msg);
    }

    std::string SendCollections(Player* player, uint32 slotId, std::string msg) {
        msg = msg + std::to_string(slotId) + "K";

        for (auto entry : player->transmogrification_appearances[slotId]) {
            if (slotId < EQUIPMENT_SLOT_END) {
                auto source = sObjectMgr->GetItemTemplate(entry);
                if (source->AllowableClass & player->getClassMask() && source->AllowableRace & player->getRaceMask())
                    msg = msg + std::to_string(entry)
                    + "^" + std::to_string(source->Class)
                    + "^" + std::to_string(source->SubClass) + "*";
            }
            else {
                // hater: for now skip enchants, still saved but will come back to this
                continue;
            }
        }
        msg = msg + ";";
        return msg;
    }

};
