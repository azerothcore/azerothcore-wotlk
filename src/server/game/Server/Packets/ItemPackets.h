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

#ifndef ItemPackets_h__
#define ItemPackets_h__

#include "Item.h"
#include "ObjectGuid.h"
#include "Packet.h"

namespace WorldPackets
{
    namespace Item
    {
        class SplitItem final : public ClientPacket
        {
        public:
            SplitItem(WorldPacket&& packet) : ClientPacket(CMSG_SPLIT_ITEM, std::move(packet)) {}

            void Read() override;

            uint8 SourceBag = 0;
            uint8 SourceSlot = 0;
            uint8 DestinationBag = 0;
            uint8 DestinationSlot = 0;
            uint32 Count = 0;
        };

        class SwapInventoryItem final : public ClientPacket
        {
        public:
            SwapInventoryItem(WorldPacket&& packet) : ClientPacket(CMSG_SWAP_INV_ITEM, std::move(packet)) {}

            void Read() override;

            uint8 DestinationSlot = 0;
            uint8 SourceSlot = 0;
        };

        class AutoEquipItemSlot final : public ClientPacket
        {
        public:
            AutoEquipItemSlot(WorldPacket&& packet) : ClientPacket(CMSG_AUTOEQUIP_ITEM_SLOT, std::move(packet)) {}

            void Read() override;

            ObjectGuid ItemGuid;
            uint8 DestinationSlot = 0;
        };

        class SwapItem final : public ClientPacket
        {
        public:
            SwapItem(WorldPacket&& packet) : ClientPacket(CMSG_SWAP_ITEM, std::move(packet)) {}

            void Read() override;

            uint8 DestinationBag = 0;
            uint8 DestinationSlot = 0;
            uint8 SourceBag = 0;
            uint8 SourceSlot = 0;
        };

        class AutoEquipItem final : public ClientPacket
        {
        public:
            AutoEquipItem(WorldPacket&& packet) : ClientPacket(CMSG_AUTOEQUIP_ITEM, std::move(packet)) {}

            void Read() override;

            uint8 SourceBag = 0;
            uint8 SourceSlot = 0;
        };

        class DestroyItem final : public ClientPacket
        {
        public:
            DestroyItem(WorldPacket&& packet) : ClientPacket(CMSG_DESTROYITEM, std::move(packet)) {}

            void Read() override;

            uint8 Bag = 0;
            uint8 Slot = 0;
            uint8 Count = 0;
            uint8 Data1 = 0;
            uint8 Data2 = 0;
            uint8 Data3 = 0;
        };

        class ReadItem final : public ClientPacket
        {
        public:
            ReadItem(WorldPacket&& packet) : ClientPacket(CMSG_READ_ITEM, std::move(packet)) {}

            void Read() override;

            uint8 Bag = 0;
            uint8 Slot = 0;
        };

        class SellItem final : public ClientPacket
        {
        public:
            SellItem(WorldPacket&& packet) : ClientPacket(CMSG_SELL_ITEM, std::move(packet)) {}

            void Read() override;

            ObjectGuid VendorGuid;
            ObjectGuid ItemGuid;
            uint32 Count = 0;
        };

        class BuybackItem final : public ClientPacket
        {
        public:
            BuybackItem(WorldPacket&& packet) : ClientPacket(CMSG_BUYBACK_ITEM, std::move(packet)) {}

            void Read() override;

            ObjectGuid VendorGuid;
            uint32 Slot = 0;
        };

        class BuyItemInSlot final : public ClientPacket
        {
        public:
            BuyItemInSlot(WorldPacket&& packet) : ClientPacket(CMSG_BUY_ITEM_IN_SLOT, std::move(packet)) {}

            void Read() override;

            ObjectGuid VendorGuid;
            uint32 Item = 0;
            uint32 Slot = 0;
            ObjectGuid BagGuid;
            uint8 BagSlot = 0;
            uint32 Count = 0;
        };

        class BuyItem final : public ClientPacket
        {
        public:
            BuyItem(WorldPacket&& packet) : ClientPacket(CMSG_BUY_ITEM, std::move(packet)) {}

            void Read() override;

            ObjectGuid VendorGuid;
            uint32 Item = 0;
            uint32 Slot = 0;
            uint32 Count = 0;
            uint8 Unk = 0;
        };

        class ListInventory final : public ClientPacket
        {
        public:
            ListInventory(WorldPacket&& packet) : ClientPacket(CMSG_LIST_INVENTORY, std::move(packet)) {}

            void Read() override;

            ObjectGuid VendorGuid;
        };

        class AutoStoreBagItem final : public ClientPacket
        {
        public:
            AutoStoreBagItem(WorldPacket&& packet) : ClientPacket(CMSG_AUTOSTORE_BAG_ITEM, std::move(packet)) {}

            void Read() override;

            uint8 SourceBag = 0;
            uint8 SourceSlot = 0;
            uint8 DestinationBag = 0;
        };

        class EnchantmentLog final : public ServerPacket
        {
        public:
            EnchantmentLog() : ServerPacket(SMSG_ENCHANTMENTLOG, 8 + 8 + 4 + 4) {}

            WorldPacket const* Write() override;

            PackedGuid Target;
            PackedGuid Caster;
            uint32 ItemId = 0;
            uint32 EnchantId = 0;
        };

        class ItemEnchantTimeUpdate final : public ServerPacket
        {
        public:
            ItemEnchantTimeUpdate() : ServerPacket(SMSG_ITEM_ENCHANT_TIME_UPDATE, 8 + 4 + 4 + 8) {}

            WorldPacket const* Write() override;

            // last check 2.0.10
            ObjectGuid ItemGuid;
            uint32 Slot = 0;
            uint32 Duration = 0;
            ObjectGuid PlayerGuid;
        };

        class WrapItem final : public ClientPacket
        {
        public:
            WrapItem(WorldPacket&& packet) : ClientPacket(CMSG_WRAP_ITEM, std::move(packet)) {}

            void Read() override;

            uint8 GiftBag = 0;
            uint8 GiftSlot = 0;
            uint8 ItemBag = 0;
            uint8 ItemSlot = 0;
        };

        class SocketGems final : public ClientPacket
        {
        public:
            SocketGems(WorldPacket&& packet) : ClientPacket(CMSG_SOCKET_GEMS, std::move(packet)) {}

            void Read() override;

            ObjectGuid ItemGuid;
            ObjectGuid GemGuids[MAX_GEM_SOCKETS];
        };

        class CancelTempEnchantment final : public ClientPacket
        {
        public:
            CancelTempEnchantment(WorldPacket&& packet) : ClientPacket(CMSG_CANCEL_TEMP_ENCHANTMENT, std::move(packet)) {}

            void Read() override;

            uint32 EquipmentSlot = 0;
        };

        class ItemRefundInfo final : public ClientPacket
        {
        public:
            ItemRefundInfo(WorldPacket&& packet) : ClientPacket(CMSG_ITEM_REFUND_INFO, std::move(packet)) {}

            void Read() override;

            ObjectGuid ItemGuid;
        };

        class ItemRefund final : public ClientPacket
        {
        public:
            ItemRefund(WorldPacket&& packet) : ClientPacket(CMSG_ITEM_REFUND, std::move(packet)) {}

            void Read() override;

            ObjectGuid ItemGuid;
        };
    }
}

#endif // ItemPackets_h__
