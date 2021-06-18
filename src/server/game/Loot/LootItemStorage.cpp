/*
Xinef
 */

#include "LootItemStorage.h"
#include "ObjectMgr.h"
#include "PreparedStatement.h"

LootItemStorage::LootItemStorage()
{
}

LootItemStorage::~LootItemStorage()
{
}

LootItemStorage* LootItemStorage::instance()
{
    static LootItemStorage instance;
    return &instance;
}

void LootItemStorage::LoadStorageFromDB()
{
    uint32 oldMSTime = getMSTime();
    lootItemStore.clear();

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ITEMCONTAINER_ITEMS);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
    {
        LOG_INFO("server", ">>  Loaded 0 stored items!");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        StoredLootItemList& itemList = lootItemStore[ObjectGuid::Create<HighGuid::Item>(fields[0].GetUInt32())];
        itemList.push_back(StoredLootItem(fields[1].GetUInt32(), fields[2].GetUInt32(), fields[3].GetInt32(), fields[4].GetUInt32(), fields[5].GetBool(),
            fields[6].GetBool(), fields[7].GetBool(), fields[8].GetBool(), fields[9].GetBool(), fields[10].GetBool(), fields[11].GetUInt32()));

        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %d stored items in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void LootItemStorage::RemoveEntryFromDB(ObjectGuid containerGUID, uint32 itemid, uint32 count)
{
    SQLTransaction trans = CharacterDatabase.BeginTransaction();

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEMCONTAINER_SINGLE_ITEM);
    stmt->setUInt32(0, containerGUID.GetCounter());
    stmt->setUInt32(1, itemid);
    stmt->setUInt32(2, count);
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);
}

void LootItemStorage::AddNewStoredLoot(Loot* loot, Player* /*player*/)
{
    if (lootItemStore.find(loot->containerGUID) != lootItemStore.end())
    {
        LOG_INFO("misc", "LootItemStorage::AddNewStoredLoot (A1) - %s!", loot->containerGUID.ToString().c_str());
        return;
    }

    SQLTransaction trans = CharacterDatabase.BeginTransaction();
    PreparedStatement* stmt = nullptr;

    StoredLootItemList& itemList = lootItemStore[loot->containerGUID];

    // Gold at first
    if (loot->gold)
    {
        itemList.push_back(StoredLootItem(0, loot->gold, 0, 0, false, false, false, false, false, false, 0));

        uint8 index = 0;
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ITEMCONTAINER_SINGLE_ITEM);
        stmt->setUInt32(index++, loot->containerGUID.GetCounter());
        stmt->setUInt32(index++, 0);
        stmt->setUInt32(index++, loot->gold);
        stmt->setInt32(index++, 0);
        stmt->setUInt32(index++, 0);
        stmt->setBool(index++, false);
        stmt->setBool(index++, false);
        stmt->setBool(index++, false);
        stmt->setBool(index++, false);
        stmt->setBool(index++, false);
        stmt->setBool(index++, false);
        trans->Append(stmt);
    }

    // And normal items
    if (!loot->isLooted())
        for (LootItemList::const_iterator li = loot->items.begin(); li != loot->items.end(); li++)
        {
            // Even if an item is not available for a specific player, it doesn't mean that
            // we are not able to trade this container to another player that is able to loot that item
            // if we don't save it then the item will be lost at player re-login.
            //if (!li->AllowedForPlayer(player))
            //    continue;

            ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(li->itemid);
            if (!itemTemplate || itemTemplate->IsCurrencyToken())
                continue;

            uint32 conditionLootId = 0;
            if (!li->conditions.empty())
            {
                conditionLootId = li->conditions.front()->SourceGroup;
            }

            itemList.push_back(StoredLootItem(li->itemid, li->count, li->randomPropertyId, li->randomSuffix, li->follow_loot_rules, li->freeforall, li->is_blocked, li->is_counted,
                li->is_underthreshold, li->needs_quest, conditionLootId));

            uint8 index = 0;
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ITEMCONTAINER_SINGLE_ITEM);
            stmt->setUInt32(index++, loot->containerGUID.GetCounter());
            stmt->setUInt32(index++, li->itemid);
            stmt->setUInt32(index++, li->count);
            stmt->setInt32 (index++, li->randomPropertyId);
            stmt->setUInt32(index++, li->randomSuffix);
            stmt->setBool(index++, li->follow_loot_rules);
            stmt->setBool(index++, li->freeforall);
            stmt->setBool(index++, li->is_blocked);
            stmt->setBool(index++, li->is_counted);
            stmt->setBool(index++, li->is_underthreshold);
            stmt->setBool(index++, li->needs_quest);
            stmt->setUInt32(index++, conditionLootId);

            trans->Append(stmt);
        }

    CharacterDatabase.CommitTransaction(trans);
}

bool LootItemStorage::LoadStoredLoot(Item* item, Player* player)
{
    ItemTemplate const* proto = sObjectMgr->GetItemTemplate(item->GetEntry());
    if (!proto)
    {
        return false;
    }

    Loot* loot = &item->loot;
    LootItemContainer::iterator itr = lootItemStore.find(loot->containerGUID);
    if (itr == lootItemStore.end())
        return false;

    StoredLootItemList& itemList = itr->second;
    for (StoredLootItemList::iterator it2 = itemList.begin(); it2 != itemList.end(); ++it2)
    {
        if (it2->itemid == 0)
        {
            loot->gold = it2->count;
            continue;
        }

        if (LootTemplate const* lt = LootTemplates_Item.GetLootFor(item->GetEntry()))
        {
            LootItem li;
            li.itemid = it2->itemid;
            li.count = it2->count;
            li.follow_loot_rules = it2->follow_loot_rules;
            li.freeforall = it2->freeforall;
            li.is_blocked = it2->is_blocked;
            li.is_counted = it2->is_counted;
            li.is_underthreshold = it2->is_underthreshold;
            li.is_looted = false;
            li.needs_quest = it2->needs_quest;
            li.randomPropertyId = it2->randomPropertyId;
            li.randomSuffix = it2->randomSuffix;
            li.rollWinnerGUID = ObjectGuid::Empty;

            // Copy the extra loot conditions from the item in the loot template
            lt->CopyConditions(&li, it2->conditionLootId);

            if (li.needs_quest)
            {
                loot->quest_items.push_back(li);
            }
            else
            {
                loot->items.push_back(li);
            }

            // non-conditional one-player only items are counted here,
            // free for all items are counted in FillFFALoot(),
            // non-ffa conditionals are counted in FillNonQuestNonFFAConditionalLoot()
            if ((!li.needs_quest && li.conditions.empty() && !(proto->Flags & ITEM_FLAG_MULTI_DROP)) || li.is_counted)
            {
                ++loot->unlootedCount;
            }
        }
    }

    if (loot->unlootedCount)
    {
        loot->FillNotNormalLootFor(player, true);
    }

    // Mark the item if it has loot so it won't be generated again on open
    item->m_lootGenerated = true;
    return true;
}

void LootItemStorage::RemoveStoredLootItem(ObjectGuid containerGUID, uint32 itemid, uint32 count, Loot* loot)
{
    LootItemContainer::iterator itr = lootItemStore.find(containerGUID);
    if (itr == lootItemStore.end())
        return;

    StoredLootItemList& itemList = itr->second;
    for (StoredLootItemList::iterator it2 = itemList.begin(); it2 != itemList.end(); ++it2)
        if (it2->itemid == itemid && it2->count == count)
        {
            RemoveEntryFromDB(containerGUID, itemid, count);
            itemList.erase(it2);
            break;
        }

    // loot with empty itemList but unlootedCount > 0
    // must be deleted manually by the player or traded
    if (!loot->unlootedCount)
        lootItemStore.erase(itr);
}

void LootItemStorage::RemoveStoredLootMoney(ObjectGuid containerGUID, Loot* loot)
{
    LootItemContainer::iterator itr = lootItemStore.find(containerGUID);
    if (itr == lootItemStore.end())
        return;

    StoredLootItemList& itemList = itr->second;
    for (StoredLootItemList::iterator it2 = itemList.begin(); it2 != itemList.end(); ++it2)
        if (it2->itemid == 0)
        {
            RemoveEntryFromDB(containerGUID, 0, it2->count);
            itemList.erase(it2);
            break;
        }

    // loot with empty itemList but unlootedCount > 0
    // must be deleted manually by the player or traded
    if (!loot->unlootedCount)
        lootItemStore.erase(itr);
}

void LootItemStorage::RemoveStoredLoot(ObjectGuid containerGUID)
{
    lootItemStore.erase(containerGUID);

    SQLTransaction trans = CharacterDatabase.BeginTransaction();

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEMCONTAINER_CONTAINER);
    stmt->setUInt32(0, containerGUID.GetCounter());
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);
}
