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

#ifndef _AUCTION_HOUSE_PACKETS_H_
#define _AUCTION_HOUSE_PACKETS_H_

#include "ObjectGuid.h"
#include "Packet.h"
#include "AuctionHouseMgr.h"
#include <array>

class Player;

namespace WorldPackets::AuctionHouse
{
    AC_GAME_API bool BuildAuctionInfo(WorldPacket& packet, AuctionEntry const* auctionEntry);

    class HelloFromClient final : public ClientPacket
    {
    public:
        HelloFromClient(WorldPacket&& packet) : ClientPacket(MSG_AUCTION_HELLO, std::move(packet)) { }

        void Read() override;

        ObjectGuid CreatureGuid;
    };

    class HelloToClient final : public ServerPacket
    {
    public:
        HelloToClient() : ServerPacket(MSG_AUCTION_HELLO, 8 + 4 + 1 /*12*/) { }

        WorldPacket const* Write() override;

        ObjectGuid CreatureGuid;
        uint32 HouseID{ 0 };
        uint8 IsAHEnable{ 1 };
    };

    class CommandResult final : public ServerPacket
    {
    public:
        CommandResult() : ServerPacket(SMSG_AUCTION_COMMAND_RESULT, 4 + 4 + 4 + 4) { }

        WorldPacket const* Write() override;

        uint32 AuctionID{ 0 };
        uint32 Action{ 0 };
        uint32 ErrorCode{ 0 };
        uint32 BidError{ 0 };
    };

    class BidderNotification final : public ServerPacket
    {
    public:
        BidderNotification() : ServerPacket(SMSG_AUCTION_BIDDER_NOTIFICATION, 4 + 4 + 8 + 4 + 4 + 4 + 4) { }

        WorldPacket const* Write() override;

        uint32 Location{ 0 };
        uint32 AuctionID{ 0 };
        ObjectGuid Bidder;
        uint32 BidSum{ 0 };
        uint32 Diff{ 0 };
        uint32 ItemEntry{ 0 };
        uint32 Unk7{ 0 };
    };

    class OwnerNotification final : public ServerPacket
    {
    public:
        OwnerNotification() : ServerPacket(SMSG_AUCTION_OWNER_NOTIFICATION, 4 + 4 + 4 + 8 + 4 + 4 + 4) { }

        WorldPacket const* Write() override;

        uint32 ID{ 0 };
        uint32 Bid{ 0 };
        uint32 Unk3{ 0 };
        uint64 Unk4{ 0 };
        uint32 ItemEntry{ 0 };
        uint32 Unk6{ 0 };
        float Unk7{ 0.0f };
    };

    class SellItem final : public ClientPacket
    {
    public:
        SellItem(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_SELL_ITEM, std::move(packet)) { }

        void Read() override;

        ObjectGuid Auctioneer;
        uint32 ItemsCount;
        uint32 ElapsedTime;
        uint32 Bid;
        uint32 Buyout;
        std::array<std::pair<ObjectGuid, uint32>, MAX_AUCTION_ITEMS> Items{ };
    };

    class PlaceBid final : public ClientPacket
    {
    public:
        PlaceBid(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_PLACE_BID, std::move(packet)) { }

        void Read() override;

        ObjectGuid Auctioneer;
        uint32 AuctionID{ 0 };
        uint32 Price{ 0 };
    };

    class RemoveItem final : public ClientPacket
    {
    public:
        RemoveItem(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_REMOVE_ITEM, std::move(packet)) { }

        void Read() override;

        ObjectGuid Auctioneer;
        uint32 AuctionID{ 0 };
    };

    class ListBidderItems final : public ClientPacket
    {
    public:
        ListBidderItems(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_LIST_BIDDER_ITEMS, std::move(packet)) { }

        void Read() override;

        ObjectGuid Auctioneer;
        uint32 ListFrom{ 0 };
        uint32 OutbiddedCount{ 0 };
        std::vector<uint32> OutbiddedAuctionIds;
    };

    class BidderListResult final : public ServerPacket
    {
    public:
        BidderListResult(AuctionHouseObject* auctionHouse);

        WorldPacket const* Write() override;

        uint32 Unk1{ 0 };
        uint32 SearchDelay{ 300 };
        std::vector<uint32> OutbiddedAuctionIds;
        ObjectGuid PlayerGuid;

    private:
        AuctionHouseObject* _auctionHouse{ nullptr };
    };

    class ListOwnerItems final : public ClientPacket
    {
    public:
        ListOwnerItems(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_LIST_OWNER_ITEMS, std::move(packet)) { }

        void Read() override;

        ObjectGuid Auctioneer;
        uint32 ListFrom{ 0 }; // // not used in fact (this list does not have page control in client)
    };

    class ListOwnerResult final : public ServerPacket
    {
    public:
        ListOwnerResult() : ServerPacket(SMSG_AUCTION_OWNER_LIST_RESULT, (4 + 4 + 4) + 60000) { }

        WorldPacket const* Write() override;

        ObjectGuid Auctioneer;
        ObjectGuid PlayerGuid;
        uint32 Unk1{ 0 };
        uint32 SearchDelay{ 300 };

        AuctionHouseObject* auctionHouse{ nullptr };        
    };

    class ListItems final : public ClientPacket
    {
    public:
        ListItems(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_LIST_ITEMS, std::move(packet)) { }

        void Read() override;

        std::string SearchedName;
        uint8 LevelMin{ 0 };
        uint8 LevelMax{ 0 };
        uint8 Usable{ 0 };
        uint32 ListFrom{ 0 };
        uint32 AuctionSlotID{ 0 };
        uint32 AuctionMainCategory{ 0 };
        uint32 AuctionSubCategory{ 0 };
        uint32 Quality{ 0 };
        ObjectGuid CreatureGuid;
        uint8 GetAll{ 0 };
        uint8 SortOrderCount{ 0 };
        AuctionSortOrderVector SortOrder;
    };

    class ListResult final : public ServerPacket
    {
    public:
        ListResult() : ServerPacket(SMSG_AUCTION_LIST_RESULT, (4 + 4 + 4) + 50 * ((16 + MAX_INSPECTED_ENCHANTMENT_SLOT * 3) * 4)) { }

        WorldPacket const* Write() override;

        bool IsCorrectSearchedName(ListItems const& packetListItems);
        bool IsExistResult(ListItems const& packetListItems);

        uint32 Unk1{ 0 };
        uint32 ListFrom{ 0 };
        uint32 SearchDelay{ 300 };

        std::vector<AuctionEntry*> AuctionShortlist;
        std::wstring WSearchedName;

        AuctionHouseObject* auctionHouse{ nullptr };
        Player* player{ nullptr };
    };

    class ListPendingSales final : public ClientPacket
    {
    public:
        ListPendingSales(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_LIST_PENDING_SALES, std::move(packet)) { }

        void Read() override;

        uint64 Unk1{ 0 };
    };

    class ListPendingSalesServer final : public ServerPacket
    {
    public:
        ListPendingSalesServer() : ServerPacket(SMSG_AUCTION_LIST_PENDING_SALES, 4) { }

        WorldPacket const* Write() override;

        uint32 Unk1{ 0 };
    };
}

#endif // _AUCTION_HOUSE_PACKETS_H_
