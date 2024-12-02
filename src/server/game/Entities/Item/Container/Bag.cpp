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

#include "Bag.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "UpdateData.h"
#include <algorithm>

Bag::Bag()
{
    m_objectType |= TYPEMASK_CONTAINER;
    m_objectTypeId = TYPEID_CONTAINER;

    m_valuesCount = CONTAINER_END;
}

Bag::~Bag()
{
    for (uint32 i = 0; i < MAX_BAG_SIZE; ++i)
    {
        auto item = m_bagslot[i];
        if (item == nullptr || !item->IsInWorld())
        {
            continue;
        }

        LOG_FATAL("entities.item", "Item {} (slot {}, bag slot {}) in bag {} (slot {}, bag slot {}, m_bagslot {}) is to be deleted but is still in world.",
            item->GetEntry(),
            (uint32)item->GetSlot(),
            (uint32)item->GetBagSlot(),
            GetEntry(),
            (uint32)GetSlot(),
            (uint32)GetBagSlot(),
            i);

        item->RemoveFromWorld();
    }
}

void Bag::AddToWorld()
{
    Item::AddToWorld();

    for (const auto item : m_bagslot)
    {
        if (item != nullptr)
            item->AddToWorld();
    }
}

void Bag::RemoveFromWorld()
{
    for (const auto item : m_bagslot)
    {
        if (item != nullptr)
            item->RemoveFromWorld();
    }

    Item::RemoveFromWorld();
}

bool Bag::Create(ObjectGuid::LowType guidlow, uint32 itemid, Player const* owner)
{
    ItemTemplate const* itemProto = sObjectMgr->GetItemTemplate(itemid);

    if (!itemProto || itemProto->ContainerSlots > MAX_BAG_SIZE)
        return false;

    Object::_Create(guidlow, 0, HighGuid::Item);

    SetEntry(itemid);
    SetObjectScale(1.0f);

    SetGuidValue(ITEM_FIELD_OWNER, owner ? owner->GetGUID() : ObjectGuid::Empty);
    SetGuidValue(ITEM_FIELD_CONTAINED, owner ? owner->GetGUID() : ObjectGuid::Empty);

    SetUInt32Value(ITEM_FIELD_MAXDURABILITY, itemProto->MaxDurability);
    SetUInt32Value(ITEM_FIELD_DURABILITY, itemProto->MaxDurability);
    SetUInt32Value(ITEM_FIELD_STACK_COUNT, 1);

    // Setting the number of Slots the Container has
    SetUInt32Value(CONTAINER_FIELD_NUM_SLOTS, itemProto->ContainerSlots);

    // Cleaning 20 slots
    for (uint8 i = 0; i < MAX_BAG_SIZE; ++i)
    {
        SetGuidValue(CONTAINER_FIELD_SLOT_1 + (i * 2), ObjectGuid::Empty);
    }
    m_bagslot.fill(nullptr);

    return true;
}

void Bag::SaveToDB(CharacterDatabaseTransaction trans)
{
    Item::SaveToDB(trans);
}

bool Bag::LoadFromDB(ObjectGuid::LowType guid, ObjectGuid owner_guid, const Field* fields, uint32 entry)
{
    if (!Item::LoadFromDB(guid, owner_guid, fields, entry))
        return false;

    ItemTemplate const* itemProto = GetTemplate(); // checked in Item::LoadFromDB
    SetUInt32Value(CONTAINER_FIELD_NUM_SLOTS, itemProto->ContainerSlots);
    // cleanup bag content related item value fields (its will be filled correctly from `character_inventory`)
    for (uint8 i = 0; i < MAX_BAG_SIZE; ++i)
    {
        auto item = m_bagslot[i];
        SetGuidValue(CONTAINER_FIELD_SLOT_1 + (i * 2), ObjectGuid::Empty);
        item.reset();
    }

    return true;
}

void Bag::DeleteFromDB(CharacterDatabaseTransaction trans)
{
    for (auto item : m_bagslot)
    {
        if (item != nullptr)
        {
            item->DeleteFromDB(trans);
        }
    }

    Item::DeleteFromDB(trans);
}

uint32 Bag::GetFreeSlots() const
{
    return std::ranges::count_if(m_bagslot, [](const auto item){ return item == nullptr; });
}

void Bag::RemoveItem(uint8 slot, bool /*update*/)
{
    ASSERT(slot < MAX_BAG_SIZE);


    if (auto pItem = m_bagslot.at(slot))
        pItem->SetContainer(nullptr);

    m_bagslot.at(slot).reset();
    SetGuidValue(CONTAINER_FIELD_SLOT_1 + (slot * 2), ObjectGuid::Empty);
}

void Bag::StoreItem(uint8 slot, std::shared_ptr<Item> pItem, bool /*update*/)
{
    ASSERT(slot < MAX_BAG_SIZE);

    if (pItem != nullptr && pItem->GetGUID() != this->GetGUID())
    {
        m_bagslot.at(slot) = pItem;
        SetGuidValue(CONTAINER_FIELD_SLOT_1 + (slot * 2), pItem->GetGUID());
        pItem->SetGuidValue(ITEM_FIELD_CONTAINED, GetGUID());
        pItem->SetGuidValue(ITEM_FIELD_OWNER, GetOwnerGUID());
        pItem->SetContainer(GetSharedPtr());
        pItem->SetSlot(slot);
    }
}

void Bag::BuildCreateUpdateBlockForPlayer(UpdateData* data, Player* target)
{
    Item::BuildCreateUpdateBlockForPlayer(data, target);

    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (m_bagslot[i])
            m_bagslot[i]->BuildCreateUpdateBlockForPlayer(data, target);
}

bool Bag::IsEmpty() const
{
    return !std::ranges::any_of(m_bagslot, [](const auto item) { return item != nullptr; });
}

uint32 Bag::GetItemCount(uint32 item, const std::shared_ptr<Item> ignoreItem /*= nullptr*/) const
{
    uint32 count = 0;
    for (uint32 i = 0; i < GetBagSize(); ++i)
    {
        const auto pItem = m_bagslot[i];
        if (pItem && pItem != ignoreItem && pItem->GetEntry() == item)
            count += pItem->GetCount();
    }

    if (ignoreItem != nullptr && ignoreItem->GetTemplate()->GemProperties)
    {
        for (uint32 i = 0; i < GetBagSize(); ++i)
        {
            const auto pItem = m_bagslot[i];
            if (pItem != nullptr && pItem != ignoreItem && pItem->GetTemplate()->Socket[0].Color)
                count += pItem->GetGemCountWithID(item);
        }
    }

    return count;
}

uint32 Bag::GetItemCountWithLimitCategory(uint32 limitCategory, const std::shared_ptr<Item> ignoreItem /*= nullptr*/) const
{
    uint32 count = 0;
    for (const auto pItem : m_bagslot)
    {
        if (pItem == nullptr || pItem == ignoreItem)
        {
            continue;
        }

        if (pItem->GetTemplate()->ItemLimitCategory == limitCategory)
            count += pItem->GetCount();
    }

    return count;
}

uint8 Bag::GetSlotByItemGUID(ObjectGuid guid) const
{
    for (uint32 i = 0; i < GetBagSize(); ++i)
        if (m_bagslot[i] != 0)
            if (m_bagslot[i]->GetGUID() == guid)
                return i;

    return NULL_SLOT;
}

std::shared_ptr<Item> Bag::GetItemByPos(uint8 slot) const
{
    try
    {
        return m_bagslot.at(slot);
    }
    catch (...)
    {
        return nullptr;
    }
}

std::string Bag::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << Item::GetDebugInfo();
    return sstr.str();
}
