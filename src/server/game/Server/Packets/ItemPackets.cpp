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

#include "ItemPackets.h"

void WorldPackets::Item::SplitItem::Read()
{
    _worldPacket >> SourceBag;
    _worldPacket >> SourceSlot;
    _worldPacket >> DestinationBag;
    _worldPacket >> DestinationSlot;
    _worldPacket >> Count;
}

void WorldPackets::Item::SwapInventoryItem::Read()
{
    _worldPacket >> DestinationSlot;
    _worldPacket >> SourceSlot;
}

void WorldPackets::Item::AutoEquipItemSlot::Read()
{
    _worldPacket >> ItemGuid;
    _worldPacket >> DestinationSlot;
}

void WorldPackets::Item::SwapItem::Read()
{
    _worldPacket >> DestinationBag;
    _worldPacket >> DestinationSlot;
    _worldPacket >> SourceBag;
    _worldPacket >> SourceSlot;
}

void WorldPackets::Item::AutoEquipItem::Read()
{
    _worldPacket >> SourceBag;
    _worldPacket >> SourceSlot;
}

void WorldPackets::Item::DestroyItem::Read()
{
    _worldPacket >> Bag;
    _worldPacket >> Slot;
    _worldPacket >> Count;
    _worldPacket >> Data1;
    _worldPacket >> Data2;
    _worldPacket >> Data3;
}

void WorldPackets::Item::ReadItem::Read()
{
    _worldPacket >> Bag;
    _worldPacket >> Slot;
}

void WorldPackets::Item::SellItem::Read()
{
    _worldPacket >> VendorGuid;
    _worldPacket >> ItemGuid;
    _worldPacket >> Count;
}

void WorldPackets::Item::BuybackItem::Read()
{
    _worldPacket >> VendorGuid;
    _worldPacket >> Slot;
}

void WorldPackets::Item::BuyItemInSlot::Read()
{
    _worldPacket >> VendorGuid;
    _worldPacket >> Item;
    _worldPacket >> Slot;
    _worldPacket >> BagGuid;
    _worldPacket >> BagSlot;
    _worldPacket >> Count;
}

void WorldPackets::Item::BuyItem::Read()
{
    _worldPacket >> VendorGuid;
    _worldPacket >> Item;
    _worldPacket >> Slot;
    _worldPacket >> Count;
    _worldPacket >> Unk;
}

void WorldPackets::Item::ListInventory::Read()
{
    _worldPacket >> VendorGuid;
}

void WorldPackets::Item::AutoStoreBagItem::Read()
{
    _worldPacket >> SourceBag;
    _worldPacket >> SourceSlot;
    _worldPacket >> DestinationBag;
}

WorldPacket const* WorldPackets::Item::EnchantmentLog::Write()
{
    _worldPacket << Target;
    _worldPacket << Caster;
    _worldPacket << ItemId;
    _worldPacket << EnchantId;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Item::ItemEnchantTimeUpdate::Write()
{
    _worldPacket << ItemGuid;
    _worldPacket << Slot;
    _worldPacket << Duration;
    _worldPacket << PlayerGuid;

    return &_worldPacket;
}

void WorldPackets::Item::WrapItem::Read()
{
    _worldPacket >> GiftBag;
    _worldPacket >> GiftSlot;
    _worldPacket >> ItemBag;
    _worldPacket >> ItemSlot;
}

void WorldPackets::Item::SocketGems::Read()
{
    _worldPacket >> ItemGuid;
    for (int i = 0; i < MAX_GEM_SOCKETS; ++i)
        _worldPacket >> GemGuids[i];
}

void WorldPackets::Item::CancelTempEnchantment::Read()
{
    _worldPacket >> EquipmentSlot;
}

void WorldPackets::Item::ItemRefundInfo::Read()
{
    _worldPacket >> ItemGuid;
}

void WorldPackets::Item::ItemRefund::Read()
{
    _worldPacket >> ItemGuid;
}
