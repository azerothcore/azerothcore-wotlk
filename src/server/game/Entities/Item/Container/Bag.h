/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_BAG_H
#define ACORE_BAG_H

// Maximum 36 Slots ((CONTAINER_END - CONTAINER_FIELD_SLOT_1)/2
#define MAX_BAG_SIZE 36                                     // 2.0.12

#include "Item.h"
#include "ItemTemplate.h"

class Bag : public Item
{
public:
    Bag();
    ~Bag() override;

    void AddToWorld() override;
    void RemoveFromWorld() override;

    bool Create(uint32 guidlow, uint32 itemid, Player const* owner) override;

    void Clear();
    void StoreItem(uint8 slot, Item* pItem, bool update);
    void RemoveItem(uint8 slot, bool update);

    [[nodiscard]] Item* GetItemByPos(uint8 slot) const;
    uint32 GetItemCount(uint32 item, Item* eItem = nullptr) const;
    uint32 GetItemCountWithLimitCategory(uint32 limitCategory, Item* skipItem = nullptr) const;

    [[nodiscard]] uint8 GetSlotByItemGUID(uint64 guid) const;
    [[nodiscard]] bool IsEmpty() const;
    [[nodiscard]] uint32 GetFreeSlots() const;
    [[nodiscard]] uint32 GetBagSize() const { return GetUInt32Value(CONTAINER_FIELD_NUM_SLOTS); }

    // DB operations
    // overwrite virtual Item::SaveToDB
    void SaveToDB(SQLTransaction& trans) override;
    // overwrite virtual Item::LoadFromDB
    bool LoadFromDB(uint32 guid, uint64 owner_guid, Field* fields, uint32 entry) override;
    // overwrite virtual Item::DeleteFromDB
    void DeleteFromDB(SQLTransaction& trans) override;

    void BuildCreateUpdateBlockForPlayer(UpdateData* data, Player* target) const override;

protected:
    // Bag Storage space
    Item* m_bagslot[MAX_BAG_SIZE];
};

inline Item* NewItemOrBag(ItemTemplate const* proto)
{
    return (proto->InventoryType == INVTYPE_BAG) ? new Bag : new Item;
}
#endif
