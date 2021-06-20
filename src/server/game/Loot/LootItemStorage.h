/*
Xinef
 */

#ifndef ACORE_LOOTITEMSTORAGE_H
#define ACORE_LOOTITEMSTORAGE_H

#include "Common.h"
#include "Item.h"
#include "LootMgr.h"
#include <list>
#include <map>

struct StoredLootItem
{
    StoredLootItem(uint32 i, uint32 c, int32 ri, uint32 rs, bool follow_loot_rules, bool freeforall,
        bool is_blocked, bool is_counted, bool is_underthreshold, bool needs_quest, uint32 conditionLootId) :
        itemid(i), count(c), randomPropertyId(ri), randomSuffix(rs), follow_loot_rules(follow_loot_rules), freeforall(freeforall), is_blocked(is_blocked),
        is_counted(is_counted), is_underthreshold(is_underthreshold), needs_quest(needs_quest), conditionLootId(conditionLootId) { }

    // If itemid == 0 - money amount is stored in count value
    uint32 itemid;
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
    void RemoveEntryFromDB(ObjectGuid containerGUID, uint32 itemid, uint32 count);

    void AddNewStoredLoot(Loot* loot, Player* player);
    bool LoadStoredLoot(Item* item, Player* player);

    void RemoveStoredLootItem(ObjectGuid containerGUID, uint32 itemid, uint32 count, Loot* loot);
    void RemoveStoredLootMoney(ObjectGuid containerGUID, Loot* loot);
    void RemoveStoredLoot(ObjectGuid containerGUID);

private:
    LootItemContainer lootItemStore;
};

#define sLootItemStorage LootItemStorage::instance()

#endif
