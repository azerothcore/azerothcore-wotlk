#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>
#include <Transmogrification.cpp>
#include <boost/algorithm/string.hpp>SSS

class ApplyTransmogHandler : public ForgeTopicHandler
{
public:
    ApplyTransmogHandler(ForgeCache* cache, ForgeCommonMessage* messageCommon) : ForgeTopicHandler(ForgeTopic::APPLY_XMOG)
    {
        fc = cache;
        mc = messageCommon;
        
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (!iam.player->pendingTransmogCheck)
        {
            iam.player->GetSession()->SendNotification("A transmogrifier must be present to apply this appearance.");
            return;
        }

        if (iam.message.empty())
            return;

        std::vector<std::string> results;
        boost::algorithm::split(results, iam.message, boost::is_any_of(";"));

        if (results.empty() || results.size() != 2 || !fc->isNumber(results[0]) || !fc->isNumber(results[1]))
            return;

        uint32 slot = static_cast<uint32>(std::stoul(results[0]));
        uint32 display = static_cast<uint32>(std::stoul(results[1]));

        
        Item * target = Transmogrification::instance().GetEquippedItem(iam.player, slot);

        if (!target)
            return;

        const ItemTemplate* tmogRecv = target->GetTemplate();

        Item* tmogSrc;
        auto appearance = sObjectMgr->GetItemTemplate(display);

        if (tmogRecv->ItemId != display && display)
            tmogSrc = Item::CreateItem(display, 1, 0);
        else
            tmogSrc = target;

        if (!appearance || !tmogSrc)
            return;

        if (TransmogResult res = Transmogrification::instance().CannotTransmogrifyItemWithItem(iam.player, tmogRecv, appearance, false))
            return;

        if (TransmogResult res = Transmogrification::instance().CannotTransmogrify(tmogRecv))
            return;

        if (TransmogResult res = Transmogrification::instance().CannotEquip(iam.player, tmogRecv))
            return;

        target->SetTransmog(tmogSrc->GetEntry());

        if (target->IsEquipped())
        {
            iam.player->SetVisibleItemSlot(target->GetSlot(), target);
            if (iam.player->IsInWorld())
                target->SendUpdateToPlayer(iam.player);
        }

        target->UpdatePlayedTime(iam.player);

        target->SetOwnerGUID(iam.player->GetGUID());
        target->SetNotRefundable(iam.player);
        target->ClearSoulboundTradeable(iam.player);

        if (tmogSrc->GetTemplate()->Bonding == BIND_WHEN_EQUIPED || tmogSrc->GetTemplate()->Bonding == BIND_WHEN_USE)
            tmogSrc->SetBinding(true);

        target->SetOwnerGUID(iam.player->GetGUID());
        target->SetNotRefundable(iam.player);
        target->ClearSoulboundTradeable(iam.player);

        auto message = std::to_string(slot) + "^" + std::to_string(tmogRecv->ItemId) + "^" + std::to_string(display);
        iam.player->SendForgeUIMsg(ForgeTopic::XMOG_OK, message);
    }


private:

    ForgeCache* fc;
    ForgeCommonMessage* mc;

};
