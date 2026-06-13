/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef ACORE_LOOTITEMSTORAGE_H
#define ACORE_LOOTITEMSTORAGE_H

#include "Item.h"
#include "LootMgr.h"
#include <list>

struct StoredLootItem
{
    StoredLootItem(uint32 i, uint32 idx, uint32 c, int32 ri, uint32 rs, bool follow_loot_rules, bool freeforall,
        bool is_blocked, bool is_counted, bool is_underthreshold, bool needs_quest, uint32 conditionLootId) : itemid(i), itemIndex(idx),
        count(c), randomPropertyId(ri), randomSuffix(rs), follow_loot_rules(follow_loot_rules), freeforall(freeforall), is_blocked(is_blocked),
        is_counted(is_counted), is_underthreshold(is_underthreshold), needs_quest(needs_quest), conditionLootId(conditionLootId) { }

    // If itemid == 0 - money amount is stored in count value
    uint32 itemid;
    uint32 itemIndex;
    uint32 count;
    int32 randomPropertyId;
    uint32 randomSuffix;
    bool follow_loot_rules;
    bool freeforall;
    bool is_blocked;
    bool is_counted;
    bool is_underthreshold;
    bool needs_quest;
    uint32 conditionLootId;
};

typedef std::list<StoredLootItem> StoredLootItemList;
typedef std::unordered_map<ObjectGuid, StoredLootItemList> LootItemContainer;

class LootItemStorage
{
private:
    LootItemStorage();
    ~LootItemStorage();

public:
    static LootItemStorage* instance();

    void LoadStorageFromDB();
    void RemoveEntryFromDB(ObjectGuid containerGUID, uint32 itemid, uint32 count, uint32 itemIndex);

    void AddNewStoredLoot(Loot* loot, Player* player);
    bool LoadStoredLoot(Item* item, Player* player);

    void RemoveStoredLootItem(ObjectGuid containerGUID, uint32 itemid, uint32 count, Loot* loot, uint32 itemIndex);
    void RemoveStoredLootMoney(ObjectGuid containerGUID, Loot* loot);
    void RemoveStoredLoot(ObjectGuid containerGUID);

private:
    LootItemContainer lootItemStore;
};

#define sLootItemStorage LootItemStorage::instance()

#endif
