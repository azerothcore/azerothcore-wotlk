/*
Xinef
 */

#ifndef ACORE_LOOTITEMSTORAGE_H
#define ACORE_LOOTITEMSTORAGE_H

#include "Common.h"
#include "LootMgr.h"
#include "Item.h"
#include <map>
#include <list>

struct StoredLootItem
{
    StoredLootItem(uint32 i, uint32 c, int32 ri, uint32 rs) : 
        itemid(i), count(c), randomPropertyId(ri), randomSuffix(rs) { }

    // If itemid == 0 - money amount is stored in count value
    uint32 itemid;
    uint32 count;
    int32 randomPropertyId;
    uint32 randomSuffix;
};

typedef std::list<StoredLootItem> StoredLootItemList;
typedef std::unordered_map<uint32, StoredLootItemList> LootItemContainer;

class LootItemStorage
{
    private:
        LootItemStorage();
        ~LootItemStorage();

    public:
        static LootItemStorage* instance();

        void LoadStorageFromDB();
        void RemoveEntryFromDB(uint32 containerId, uint32 itemid, uint32 count);

        void AddNewStoredLoot(Loot* loot, Player* player);
        bool LoadStoredLoot(Item* item);

        void RemoveStoredLootItem(uint32 containerId, uint32 itemid, uint32 count, Loot* loot);
        void RemoveStoredLootMoney(uint32 containerId, Loot* loot);
        void RemoveStoredLoot(uint32 containerId);

    private:
        LootItemContainer lootItemStore;
};

#define sLootItemStorage LootItemStorage::instance()

#endif
