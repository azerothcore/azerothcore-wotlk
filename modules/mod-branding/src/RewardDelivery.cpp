#include "RewardDelivery.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "Mail.h"
#include "Player.h"

namespace Branding
{
    DeliveryResult DeliverItem(Player* player, uint32_t itemId, uint32_t count,
        std::string_view subject, std::string_view body)
    {
        if (!player || itemId == 0 || count == 0)
            return DeliveryResult::None;

        // Primary: straight into the bags (handles stacking/splitting).
        if (player->AddItem(itemId, count))
            return DeliveryResult::Inventory;

        // Fallback: mail it. (count is assumed within one stack for our reward sizes.)
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        std::string subjectStr(subject);
        std::string bodyStr(body);
        MailDraft draft(subjectStr, bodyStr);
        if (Item* item = Item::CreateItem(itemId, count, player))
        {
            item->SaveToDB(trans);
            draft.AddItem(item);
        }
        draft.SendMailTo(trans, MailReceiver(player), MailSender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM));
        CharacterDatabase.CommitTransaction(trans);
        return DeliveryResult::Mailed;
    }
}
