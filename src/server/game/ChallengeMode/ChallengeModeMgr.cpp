#include "ChallengeModeMgr.h"
#include "Containers.h"
#include "Item.h"

ChallengeModeMgr* ChallengeModeMgr::instance()
{
    static ChallengeModeMgr instance;
    return &instance;
}

uint32 ChallengeModeMgr::GetRandomChallengeId(uint32 flags/* = 4*/)
{
    return sObjectMgr->GetRandomMythicKey();
}

std::vector<int32> ChallengeModeMgr::GetBonusListIdsForRewards(uint32 baseItemIlevel, uint8 challengeLevel)
{
//    if (challengeLevel < 2)
        return {};
//
//    std::vector<std::pair<int32, uint32>> bonusDescriptionByChallengeLevel =
//    {
//        { 3410, 5  },   // Mythic 2
//        { 3411, 5  },   // Mythic 3
//        { 3412, 10 },   // Mythic 4
//        { 3413, 15 },   // Mythic 5
//        { 3414, 20 },   // Mythic 6
//        { 3415, 20 },   // Mythic 7
//        { 3416, 25 },   // Mythic 8
//        { 3417, 25 },   // Mythic 9
//        { 3418, 30 },   // Mythic 10
//        { 3509, 35 },   // Mythic 11
//        { 3510, 40 },   // Mythic 12
//        { 3534, 45 },   // Mythic 13
//        { 3535, 50 },   // Mythic 14
//        { 3535, 55 },   // Mythic 15
//    };
//
//    const uint32 baseMythicIlevel = 885;
//    std::pair<int32, uint32> bonusAndDeltaPair = bonusDescriptionByChallengeLevel[challengeLevel < 15 ? (challengeLevel - 2): 13];
//    return { bonusAndDeltaPair.first, (int32)sDB2Manager.GetItemBonusListForItemLevelDelta(baseMythicIlevel - baseItemIlevel + bonusAndDeltaPair.second) };
}

void ChallengeModeMgr::Reward(Player* player, uint8 challengeLevel)
{
    //if (!GetMapChallengeModeEntry(player->GetMapId()))
    //    return;

    //JournalInstanceEntry const* journalInstance  = sDB2Manager.GetJournalInstanceByMapId(player->GetMapId());
    //if (!journalInstance)
    //    return;

    //auto encounters = sDB2Manager.GetJournalEncounterByJournalInstanceId(journalInstance->ID);
    //if (!encounters)
    //    return;

    //std::vector<JournalEncounterItemEntry const*> items;
    //for (auto encounter : *encounters)
    //    if (std::vector<JournalEncounterItemEntry const*> const* journalItems = sDB2Manager.GetJournalItemsByEncounter(encounter->ID))
    //        items.insert(items.end(), journalItems->begin(), journalItems->end());

    //if (items.empty())
    //    return;

    //std::vector<ItemTemplate const*> stuffLoots;
    //for (JournalEncounterItemEntry const* journalEncounterItem : items)
    //{
    //    ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(journalEncounterItem->ItemID);
    //    if (!itemTemplate)
    //        continue;

    //    if (!itemTemplate->IsUsableByLootSpecialization(player, false))
    //        continue;

    //    if (itemTemplate->GetInventoryType() != INVTYPE_NON_EQUIP)
    //        stuffLoots.push_back(itemTemplate);
    //}

    //ItemTemplate const* randomStuffItem = Trinity::Containers::SelectRandomContainerElement(stuffLoots);
    //if (!randomStuffItem)
    //    return;

    //uint32 itemId = randomStuffItem->GetId();
    //ItemPosCountVec dest;
    //InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, 1);
    //if (msg != EQUIP_ERR_OK)
    //{
    //    player->SendEquipError(msg, nullptr, nullptr, itemId);
    //    return;
    //}

    //std::vector<int32> bonusListIds = GetBonusListIdsForRewards(randomStuffItem->GetBaseItemLevel(), challengeLevel);
    //Item* pItem = player->StoreNewItem(dest, itemId, true, GenerateItemRandomBonusListId(itemId), GuidSet(), ItemContext(0), bonusListIds);
    //player->SendNewItem(pItem, 1, true, false, true);

    //WorldPackets::Loot::DisplayToast displayToast;
    //displayToast.EntityId = itemId;
    //displayToast.ToastType = TOAST_ITEM;
    //displayToast.Quantity = 1;
    //displayToast.RandomPropertiesID = pItem->GetItemRandomBonusListId();
    //displayToast.ToastMethod = TOAST_METHOD_POPUP;
    //displayToast.bonusListIDs = pItem->m_itemData->BonusListIDs;
    //player->SendDirectMessage(displayToast.Write());
}
