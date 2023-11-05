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

#ifndef AUCTION_HOUSE_PACKETS_H_
#define AUCTION_HOUSE_PACKETS_H_

#include "AuctionFwd.h"
#include "Packet.h"

class AuctionEntry;
class AuctionHouseObject;

namespace WorldPackets::AuctionHouse
{
    class HelloFromClient final : public ClientPacket
    {
    public:
        explicit HelloFromClient(WorldPacket&& packet) : ClientPacket(MSG_AUCTION_HELLO, std::move(packet)) { }

        void Read() override;

        ObjectGuid CreatureGuid;
    };

    class HelloToClient final : public ServerPacket
    {
    public:
        HelloToClient() : ServerPacket(MSG_AUCTION_HELLO, 8 + 4 + 1) { }

        WorldPacket const* Write() override;

        ObjectGuid CreatureGuid;
        uint32 HouseID{};
    };

    class CommandResult final : public ServerPacket
    {
    public:
        explicit CommandResult(AuctionEntry const* auction) :
            ServerPacket(SMSG_AUCTION_COMMAND_RESULT, 4 + 4 + 4 + 4), Auction(auction) { }

        WorldPacket const* Write() override;

        uint32 AuctionID{};
        uint32 Action{};
        uint32 ErrorCode{};
        uint32 InventoryError{};

    private:
        AuctionEntry const* Auction{};
    };

    class BidderNotification final : public ServerPacket
    {
    public:
        BidderNotification() : ServerPacket(SMSG_AUCTION_BIDDER_NOTIFICATION, 4 + 4 + 8 + 4 + 4 + 4 + 4) { }

        WorldPacket const* Write() override;

        uint32 Location{};
        uint32 AuctionID{};
        ObjectGuid Bidder;
        uint32 BidSum{};
        uint32 Diff{};
        uint32 ItemEntry{};
    };

    class OwnerNotification final : public ServerPacket
    {
    public:
        OwnerNotification() : ServerPacket(SMSG_AUCTION_OWNER_NOTIFICATION, 4 + 4 + 4 + 8 + 4 + 4 + 4) { }

        WorldPacket const* Write() override;

        uint32 ID{};
        uint32 Bid{};
        uint32 ItemEntry{};
    };

    class SellItem final : public ClientPacket
    {
    public:
        explicit SellItem(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_SELL_ITEM, std::move(packet)) { }

        void Read() override;

        AuctionSellItem SellItems;
    };

    class PlaceBid final : public ClientPacket
    {
    public:
        explicit PlaceBid(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_PLACE_BID, std::move(packet)) { }

        void Read() override;

        ObjectGuid Auctioneer;
        uint32 AuctionID{};
        uint32 Price{};
    };

    class RemoveItem final : public ClientPacket
    {
    public:
        explicit RemoveItem(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_REMOVE_ITEM, std::move(packet)) { }

        void Read() override;

        ObjectGuid Auctioneer;
        uint32 AuctionID{};
    };

    class ListBidderItems final : public ClientPacket
    {
    public:
        explicit ListBidderItems(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_LIST_BIDDER_ITEMS, std::move(packet)) { }

        void Read() override;

        ObjectGuid Auctioneer;
        uint32 ListFrom{};
        uint32 OutbiddedCount{};
        std::vector<uint32> OutbiddedAuctionIds;
    };

    class BidderListResult final : public ServerPacket
    {
    public:
        explicit BidderListResult(AuctionHouseObject* auctionHouse);

        WorldPacket const* Write() override;

        uint32 SearchDelay{ 300 };
        std::vector<uint32> OutbiddedAuctionIds;
        ObjectGuid PlayerGuid;

    private:
        AuctionHouseObject* _auctionHouse{ nullptr };
    };

    class ListOwnerItems final : public ClientPacket
    {
    public:
        explicit ListOwnerItems(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_LIST_OWNER_ITEMS, std::move(packet)) { }

        void Read() override;

        ObjectGuid Auctioneer;
        uint32 ListFrom{}; // not used in fact (this list does not have page control in client)
    };

    class ListOwnerResult final : public ServerPacket
    {
    public:
        ListOwnerResult() : ServerPacket(SMSG_AUCTION_OWNER_LIST_RESULT, 8 + 8 + 4 + 60000) { }

        WorldPacket const* Write() override;

        ObjectGuid Auctioneer;
        ObjectGuid PlayerGuid;
        uint32 SearchDelay{ 300 };

        AuctionHouseObject* auctionHouse{ nullptr };
    };

    class ListItems final : public ClientPacket
    {
    public:
        explicit ListItems(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_LIST_ITEMS, std::move(packet)) { }

        void Read() override;

        AuctionListItems AuctionItems;

    private:
        uint8 SortOrderCount{};
    };

    class ListResult final : public ServerPacket
    {
    public:
        ListResult() : ServerPacket(SMSG_AUCTION_LIST_RESULT, (4 + 4 + 4) + 50 * ((16 + 7 * 3) * 4)) { }

        WorldPacket const* Write() override;

        bool IsCorrectSearchedName(std::string_view searchedName);

        uint32 ListFrom{};
        bool IsGetAll{};
        uint32 SearchDelay{ 300 };

        std::vector<AuctionEntry*> AuctionShortlist;
        std::wstring WSearchedName;
    };

    class ListPendingSales final : public ClientPacket
    {
    public:
        explicit ListPendingSales(WorldPacket&& packet) : ClientPacket(CMSG_AUCTION_LIST_PENDING_SALES, std::move(packet)) { }

        void Read() override;

        uint64 Unk1{};
    };

    class ListPendingSalesServer final : public ServerPacket
    {
    public:
        ListPendingSalesServer() : ServerPacket(SMSG_AUCTION_LIST_PENDING_SALES, 4) { }

        WorldPacket const* Write() override;
    };
}

#endif
