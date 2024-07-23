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

#ifndef ACORE_BAG_H
#define ACORE_BAG_H

// Maximum 36 Slots ((CONTAINER_END - CONTAINER_FIELD_SLOT_1)/2
#define MAX_BAG_SIZE 36                                     // 2.0.12

#include "Item.h"
#include "ItemTemplate.h"

class CGBag : public Item
{
public:
    CGBag();
    ~CGBag() override;

    void AddToWorld() override;
    void RemoveFromWorld() override;

    bool Create(WOWGUID::LowType guidlow, uint32 itemid, Player const* owner) override;

    void StoreItem(uint8 slot, Item* pItem, bool update);
    void RemoveItem(uint8 slot, bool update);

    [[nodiscard]] Item* GetItemByPos(uint8 slot) const;
    uint32 GetItemCount(uint32 item, Item* eItem = nullptr) const;
    uint32 GetItemCountWithLimitCategory(uint32 limitCategory, Item* skipItem = nullptr) const;

    [[nodiscard]] uint8 GetSlotByItemGUID(WOWGUID guid) const;
    [[nodiscard]] bool IsEmpty() const;
    [[nodiscard]] uint32 GetFreeSlots() const;
    [[nodiscard]] uint32 GetBagSize() const { return GetUInt32Value(CONTAINER_FIELD_NUM_SLOTS); }

    // DB operations
    // overwrite virtual Item::SaveToDB
    void SaveToDB(CharacterDatabaseTransaction trans) override;
    // overwrite virtual Item::LoadFromDB
    bool LoadFromDB(WOWGUID::LowType guid, WOWGUID owner_guid, Field* fields, uint32 entry) override;
    // overwrite virtual Item::DeleteFromDB
    void DeleteFromDB(CharacterDatabaseTransaction trans) override;

    void BuildCreateUpdateBlockForPlayer(UpdateData* data, Player* target) override;

    std::string GetDebugInfo() const override;

protected:
    // Bag Storage space
    Item* m_bagslot[MAX_BAG_SIZE];
};

inline Item* NewItemOrBag(ItemTemplate const* proto)
{
    return (proto->InventoryType == INVTYPE_BAG) ? new CGBag : new Item;
}
#endif
