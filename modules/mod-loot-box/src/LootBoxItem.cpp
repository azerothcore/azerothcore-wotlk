#include <algorithm>
#include "Chat.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "Player.h"
#include "LootBoxItem.h"
#include "LootBoxWorld.h"

struct Pity {
    int promotional;
    int epic;
    int featured;
    int rare;
};

const std::string SUBJECT = "Loot Box reward";
const std::string BODY = "Congratulations, you got a reward but your inventory was full."
    "Please take your reward when you free space from your inventory";

int randomId(std::vector<int> ids)
{
    std::random_shuffle(ids.begin(), ids.end());
    return ids[0];
}

bool isBannerItem(float result, int pity, int guarantee)
{
    return result <= 1 / (guarantee * (1 + std::min(pity, guarantee)));
}

bool isPromotion(float result, int pity)
{
    return !LootBoxWorld::FiveStars.size()
        || (isBannerItem(result, pity, LootBoxWorld::PromotionalGuarantee) && LootBoxWorld::Promotions.size());
}

bool isEpic()
{
    return LootBoxWorld::FiveStars.size();
}

bool isFeatured(float roll, int pity)
{
    return !LootBoxWorld::FourStars.size()
        || (isBannerItem(roll, pity, LootBoxWorld::FeaturedGuarantee) && LootBoxWorld::Features.size());
}

bool isRare()
{
    return LootBoxWorld::FourStars.size();
}

bool isCommon()
{
    return LootBoxWorld::ThreeStars.size();
}

float LootBoxItem::roll()
{
    return dis(gen);
}

bool LootBoxItem::sendRewardToPlayer(Player *player, uint32 itemId, enum Rarity rarity, enum Banner banner)
{
    ItemTemplate const *proto = sObjectMgr->GetItemTemplate(itemId);

    if (!proto) {
        sLog->outError("[Loot Box] Item ID is invalid: %u", itemId);
        return false;
    }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    uint32 count = proto->Stackable >= LootBoxWorld::StackSize ? uint32(LootBoxWorld::StackSize) : uint32(proto->Stackable);
    Item *item = Item::CreateItem(itemId, count);
    ItemPosCountVec dest;

    CharacterDatabase.PExecute(
        "INSERT INTO `lootbox` (`player`, `item`, `rarity`, `banner`)"
        "VALUES (%u, %u, %u, %u)",
        player->GetGUID().GetCounter(), itemId, rarity, banner
    );
    item->SaveToDB(trans);

    InventoryResult msg = player->CanStoreItem(NULL_BAG, NULL_SLOT, dest, item, false);
    if (msg == EQUIP_ERR_OK) {
        player->StoreItem(dest, item, true);
        CharacterDatabase.CommitTransaction(trans);
        return true;
    }

    player->SendEquipError(msg, item);
    ChatHandler(player->GetSession()).PSendSysMessage("You will receive your reward in the mail.");
    MailSender sender(LootBoxWorld::NPC);
    MailDraft draft(SUBJECT, BODY);
    draft.AddItem(item);
    draft.SendMailTo(trans, MailReceiver(player), sender);

    CharacterDatabase.CommitTransaction(trans);

    return true;
}

void LootBoxItem::openLootBox(Player *player, Item *box, struct Pity pity, enum Rarity rarity)
{
    std::vector<int> pool;
    enum Banner banner;

    switch (rarity) {
        case RARITY_FIVE_STAR:
            if (isPromotion(roll(), pity.promotional)) {
                rarity = RARITY_FIVE_STAR;
                banner = BANNER_PROMOTIONAL;
                pool = LootBoxWorld::Promotions;
                break;
            } else if (isEpic()) {
                rarity = RARITY_FIVE_STAR;
                banner = BANNER_NONE;
                pool = LootBoxWorld::FiveStars;
                break;
            }
        case RARITY_FOUR_STAR:
            if (isFeatured(roll(), pity.featured)) {
                rarity = RARITY_FOUR_STAR;
                banner = BANNER_FEATURED;
                pool = LootBoxWorld::Features;
                break;
            } else if (isRare()) {
                rarity = RARITY_FOUR_STAR;
                banner = BANNER_NONE;
                pool = LootBoxWorld::FourStars;
                break;
            }
        case RARITY_THREE_STAR:
            if (isCommon()) {
                rarity = RARITY_THREE_STAR;
                banner = BANNER_NONE;
                pool = LootBoxWorld::ThreeStars;
                break;
            }
        default:
            rarity = RARITY_NONE;
            banner = BANNER_NONE;
            pool = std::vector<int>();
    }

    if (!pool.size()) {
        ChatHandler(player->GetSession()).PSendSysMessage("Failed to open loot box.");
        sLog->outError("[Loot Box] No rewards configured.");
        return;
    }
 
    if (rarity == RARITY_FOUR_STAR) {
        player->CastSpell(player, 7931300);
    } else if (rarity == RARITY_FIVE_STAR) {
        player->CastSpell(player, 7931301);
    }

    int itemId = randomId(pool);
    bool sent = sendRewardToPlayer(player, itemId, rarity, banner);

    if (!sent) {
        ChatHandler(player->GetSession()).PSendSysMessage("Failed to open loot box.");
        return;
    }

    uint32 one = 1;
    uint32 &count = one;
    player->DestroyItemCount(box, count, true);
}

bool LootBoxItem::OnUse(Player *player, Item *box, SpellCastTargets const &/*targets*/)
{
    if (!LootBoxWorld::Enabled)
        return false;

    if ((uint32)LootBoxWorld::Box != box->GetEntry())
        return false;

    QueryResult rows = CharacterDatabase.PQuery(
        "SELECT `rarity`, `banner` FROM `lootbox`"
        "WHERE `player` = %u ORDER BY `id` ASC",
        player->GetGUID().GetCounter()
    );

    struct Pity pity = { .promotional = 0, .epic = 0, .featured = 0, .rare = 0 };
    if (rows) {
        do {
            Field *row = rows->Fetch();
            enum Rarity rarity = (enum Rarity)row[0].GetInt8();
            enum Banner banner = (enum Banner)row[1].GetInt8();

            switch (rarity) {
                case RARITY_FIVE_STAR:
                    if (banner == BANNER_PROMOTIONAL)
                        pity.promotional = 0;
                    else
                        pity.promotional++;
                    pity.epic = 0;
                    pity.rare = 0;
                    break;
                case RARITY_FOUR_STAR:
                    if (banner == BANNER_FEATURED)
                        pity.featured = 0;
                    else
                        pity.featured++;
                    pity.epic++;
                    pity.rare = 0;
                    break;
                default:
                    pity.epic++;
                    pity.rare++;
                    break;
            }
        } while (rows->NextRow());
    }

    float result = roll();
    if (result <= LootBoxWorld::FiveStarRate) {
        openLootBox(player, box, pity, RARITY_FIVE_STAR);
        return true;
    }

    float rare = (1 - LootBoxWorld::FourStarRate) / LootBoxWorld::FourStarGuarantee * std::min(pity.rare, LootBoxWorld::FourStarGuarantee) + LootBoxWorld::FourStarRate;
    if (result <= rare) {
        float epic = (1 - LootBoxWorld::FiveStarRate) / LootBoxWorld::FiveStarGuarantee * std::min(pity.epic, LootBoxWorld::FiveStarGuarantee) + LootBoxWorld::FiveStarRate;
        result = roll();

        if ((result <= epic) || (pity.epic > (LootBoxWorld::FiveStarGuarantee - LootBoxWorld::FourStarGuarantee))) {
            openLootBox(player, box, pity, RARITY_FIVE_STAR);
            return true;
        }

        openLootBox(player, box, pity, RARITY_FOUR_STAR);
        return true;
    }

    openLootBox(player, box, pity, RARITY_THREE_STAR);
    return true;
}

void AddLootBoxItemScripts()
{
    new LootBoxItem();
}
