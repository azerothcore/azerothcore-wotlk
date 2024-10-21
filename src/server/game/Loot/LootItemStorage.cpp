/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "LootItemStorage.h"
#include "DatabaseEnv.h"
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

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ITEMCONTAINER_ITEMS);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 stored items!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        StoredLootItemList& itemList = lootItemStore[ObjectGuid::Create<HighGuid::Item>(fields[0].Get<uint32>())];
        itemList.emplace_back(fields[1].Get<uint32>(), fields[2].Get<uint32>(), fields[3].Get<uint32>(), fields[4].Get<int32>(), fields[5].Get<uint32>(), fields[6].Get<bool>(),
            fields[7].Get<bool>(), fields[8].Get<bool>(), fields[9].Get<bool>(), fields[10].Get<bool>(), fields[11].Get<bool>(), fields[12].Get<uint32>());

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} stored items in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void LootItemStorage::RemoveEntryFromDB(ObjectGuid containerGUID, uint32 itemid, uint32 count, uint32 itemIndex)
{
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEMCONTAINER_SINGLE_ITEM);
    stmt->SetData(0, containerGUID.GetCounter());
    stmt->SetData(1, itemid);
    stmt->SetData(2, count);
    stmt->SetData(3, itemIndex);
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);
}

void LootItemStorage::AddNewStoredLoot(Loot* loot, Player* /*player*/)
{
    if (lootItemStore.find(loot->containerGUID) != lootItemStore.end())
    {
        LOG_INFO("misc", "LootItemStorage::AddNewStoredLoot (A1) - {}!", loot->containerGUID.ToString());
        return;
    }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    CharacterDatabasePreparedStatement* stmt = nullptr;

    StoredLootItemList& itemList = lootItemStore[loot->containerGUID];

    // Gold at first
    if (loot->gold)
    {
        itemList.emplace_back(0, 0, loot->gold, 0, 0, false, false, false, false, false, false, 0);

        uint8 index = 0;
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ITEMCONTAINER_SINGLE_ITEM);
        stmt->SetData(index++, loot->containerGUID.GetCounter());
        stmt->SetData(index++, 0);
        stmt->SetData(index++, 0);
        stmt->SetData(index++, loot->gold);
        stmt->SetData(index++, 0);
        stmt->SetData(index++, 0);
        stmt->SetData(index++, false);
        stmt->SetData(index++, false);
        stmt->SetData(index++, false);
        stmt->SetData(index++, false);
        stmt->SetData(index++, false);
        stmt->SetData(index++, false);
        stmt->SetData(index++, 0);
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

            itemList.emplace_back(li->itemid, li->itemIndex, li->count, li->randomPropertyId, li->randomSuffix, li->follow_loot_rules, li->freeforall, li->is_blocked, li->is_counted,
                li->is_underthreshold, li->needs_quest, conditionLootId);

            uint8 index = 0;
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ITEMCONTAINER_SINGLE_ITEM);
            stmt->SetData(index++, loot->containerGUID.GetCounter());
            stmt->SetData(index++, li->itemid);
            stmt->SetData(index++, li->itemIndex);
            stmt->SetData(index++, li->count);
            stmt->SetData (index++, li->randomPropertyId);
            stmt->SetData(index++, li->randomSuffix);
            stmt->SetData(index++, li->follow_loot_rules);
            stmt->SetData(index++, li->freeforall);
            stmt->SetData(index++, li->is_blocked);
            stmt->SetData(index++, li->is_counted);
            stmt->SetData(index++, li->is_underthreshold);
            stmt->SetData(index++, li->needs_quest);
            stmt->SetData(index++, conditionLootId);

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
            li.itemIndex = it2->itemIndex;
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
            li.groupid = 0;

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
            if ((!li.needs_quest && li.conditions.empty() && !proto->HasFlag(ITEM_FLAG_MULTI_DROP)) || li.is_counted)
            {
                ++loot->unlootedCount;
            }
        }
    }

    if (loot->unlootedCount)
    {
        loot->FillNotNormalLootFor(player);
    }

    // Mark the item if it has loot so it won't be generated again on open
    item->m_lootGenerated = true;
    return true;
}

void LootItemStorage::RemoveStoredLootItem(ObjectGuid containerGUID, uint32 itemid, uint32 count, Loot* loot, uint32 itemIndex)
{
    LootItemContainer::iterator itr = lootItemStore.find(containerGUID);
    if (itr == lootItemStore.end())
        return;

    StoredLootItemList& itemList = itr->second;
    for (StoredLootItemList::iterator it2 = itemList.begin(); it2 != itemList.end(); ++it2)
        if (it2->itemid == itemid && it2->count == count)
        {
            RemoveEntryFromDB(containerGUID, itemid, count, itemIndex);
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
            RemoveEntryFromDB(containerGUID, 0, it2->count, 0);
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

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEMCONTAINER_CONTAINER);
    stmt->SetData(0, containerGUID.GetCounter());
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);
}
