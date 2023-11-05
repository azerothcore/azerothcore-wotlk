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

#include "AuctionHousePackets.h"
#include "AuctionHouseMgr.h"
#include "GameTime.h"
#include "Log.h"

void WorldPackets::AuctionHouse::HelloFromClient::Read()
{
    _worldPacket >> CreatureGuid;
}

WorldPacket const* WorldPackets::AuctionHouse::HelloToClient::Write()
{
    _worldPacket << CreatureGuid;
    _worldPacket << uint32(HouseID);
    _worldPacket << uint8(1); // 3.3.3: 1 - AH enabled, 0 - AH disabled

    return &_worldPacket;
}

WorldPacket const* WorldPackets::AuctionHouse::CommandResult::Write()
{
    AuctionID = Auction ? Auction->Id : 0;

    _worldPacket << uint32(AuctionID);
    _worldPacket << uint32(Action);
    _worldPacket << uint32(ErrorCode);

    switch (ErrorCode)
    {
        case ERR_AUCTION_OK:
        {
            if (Action == AUCTION_CANCEL)
                _worldPacket << uint32(0);
            else if (Action == AUCTION_PLACE_BID)
            {
                ASSERT(Auction);
                _worldPacket << uint32(Auction->GetAuctionOutBid());
            }

            break;
        }
        case ERR_AUCTION_INVENTORY:
            _worldPacket << uint32(InventoryError);
            break;
        case ERR_AUCTION_HIGHER_BID:
        {
            ASSERT(Auction);
            _worldPacket << Auction->Bidder;
            _worldPacket << uint32(Auction->Bid);
            _worldPacket << uint32(Auction->GetAuctionOutBid());
            break;
        }
        default:
            break;
    }

    return &_worldPacket;
}

WorldPacket const* WorldPackets::AuctionHouse::BidderNotification::Write()
{
    _worldPacket << uint32(Location);
    _worldPacket << uint32(AuctionID);
    _worldPacket << Bidder;
    _worldPacket << uint32(BidSum);
    _worldPacket << uint32(Diff);
    _worldPacket << uint32(ItemEntry);
    _worldPacket << uint32(0);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::AuctionHouse::OwnerNotification::Write()
{
    _worldPacket << uint32(ID);
    _worldPacket << uint32(Bid);
    _worldPacket << uint32(0);
    _worldPacket << uint64(0); // (bidder guid?)
    _worldPacket << uint32(ItemEntry);
    _worldPacket << uint32(0);
    _worldPacket << float(0); // (time?)

    return &_worldPacket;
}

void WorldPackets::AuctionHouse::SellItem::Read()
{
    SellItems.Items.fill({ ObjectGuid::Empty, 0 });

    _worldPacket >> SellItems.Auctioneer;
    _worldPacket >> SellItems.ItemsCount;

    if (SellItems.ItemsCount > MAX_AUCTION_ITEMS)
    {
        _worldPacket.rfinish();
        return;
    }

    for (uint32 i = 0; i < SellItems.ItemsCount; ++i)
    {
        _worldPacket >> SellItems.Items[i].first;
        _worldPacket >> SellItems.Items[i].second;
    }

    _worldPacket >> SellItems.Bid;
    _worldPacket >> SellItems.Buyout;
    _worldPacket >> SellItems.ExpireTime;
}

void WorldPackets::AuctionHouse::PlaceBid::Read()
{
    _worldPacket >> Auctioneer;
    _worldPacket >> AuctionID;
    _worldPacket >> Price;
}

void WorldPackets::AuctionHouse::RemoveItem::Read()
{
    _worldPacket >> Auctioneer;
    _worldPacket >> AuctionID;
}

void WorldPackets::AuctionHouse::ListBidderItems::Read()
{
    _worldPacket >> Auctioneer;
    _worldPacket >> ListFrom; // not used in fact (this list not have page control in client)
    _worldPacket >> OutbiddedCount;

    if (GetSize() != (16 + OutbiddedCount * 4))
    {
        LOG_ERROR("network.packet", "Client sent bad opcode!!! with count: {} and size : {} (must be: {})", OutbiddedCount, GetSize(), (16 + OutbiddedCount * 4));
        OutbiddedCount = 0;
    }

    while (OutbiddedCount > 0) // add all data, which client requires
    {
        uint32 outbiddedAuctionId{};
        _worldPacket >> outbiddedAuctionId;
        OutbiddedAuctionIds.emplace_back(outbiddedAuctionId);
        OutbiddedCount--;
    }
}

WorldPackets::AuctionHouse::BidderListResult::BidderListResult(AuctionHouseObject* auctionHouse)
    : ServerPacket(SMSG_AUCTION_BIDDER_LIST_RESULT, (4 + 4 + 4) + 30000)
{
    _auctionHouse = ASSERT_NOTNULL(auctionHouse);
}

WorldPacket const* WorldPackets::AuctionHouse::BidderListResult::Write()
{
    ASSERT(_auctionHouse, "Build packet without check exist auction house!");
    ASSERT(!PlayerGuid.IsEmpty(), "Build packet with null player guid!");

    _worldPacket << uint32(0); // Add 0 as count

    uint32 count{};
    uint32 totalCount{};

    for (auto const& outbiddedAuctionId : OutbiddedAuctionIds)
    {
        AuctionEntry* auction = _auctionHouse->GetAuction(outbiddedAuctionId);
        if (auction && auction->BuildAuctionInfo(_worldPacket))
        {
            ++totalCount;
            ++count;
        }
    }

    _auctionHouse->ForEachAuctions([this, &count, &totalCount](AuctionEntry* auction)
    {
        if (auction && auction->Bidder == PlayerGuid)
        {
            if (auction->BuildAuctionInfo(_worldPacket))
                ++count;

            ++totalCount;
        }
    });

    _worldPacket.put<uint32>(0, count);
    _worldPacket << uint32(totalCount);
    _worldPacket << uint32(SearchDelay); // clientside search cooldown [ms] (gray search button)

    return &_worldPacket;
}

void WorldPackets::AuctionHouse::ListOwnerItems::Read()
{
    _worldPacket >> Auctioneer;
    _worldPacket >> ListFrom;
}

WorldPacket const* WorldPackets::AuctionHouse::ListOwnerResult::Write()
{
    ASSERT(auctionHouse, "Build packet without check exist auction house!");

    _worldPacket << uint32(0); // Amount placeholder

    uint32 count{};
    uint32 totalCount{};

    auctionHouse->ForEachAuctions([this, &count, &totalCount](AuctionEntry* auction)
    {
        if (auction && auction->PlayerOwner == PlayerGuid)
        {
            if (auction->BuildAuctionInfo(_worldPacket))
                ++count;

            ++totalCount;
        }
    });

    _worldPacket.put<uint32>(0, count);
    _worldPacket << uint32(totalCount);
    _worldPacket << uint32(SearchDelay);

    return &_worldPacket;
}

void WorldPackets::AuctionHouse::ListItems::Read()
{
    _worldPacket >> AuctionItems.CreatureGuid;
    _worldPacket >> AuctionItems.ListFrom;
    _worldPacket >> AuctionItems.SearchedName;
    _worldPacket >> AuctionItems.LevelMin >> AuctionItems.LevelMax;
    _worldPacket >> AuctionItems.InventoryType >> AuctionItems.ItemClass >> AuctionItems.ItemSubClass;
    _worldPacket >> AuctionItems.Quality >> AuctionItems.Usable;
    _worldPacket >> AuctionItems.GetAll;
    _worldPacket >> SortOrderCount;

    for (uint8 i = 0; i < SortOrderCount; i++)
    {
        uint8 sortMode{};
        uint8 isDesc{};

        _worldPacket >> sortMode;
        _worldPacket >> isDesc;

        AuctionSortInfo sortInfo;
        sortInfo.IsDesc = (isDesc == 1);
        sortInfo.SortOrder = static_cast<AuctionSortOrder>(sortMode);
        AuctionItems.SortOrder.emplace_back(sortInfo);
    }
}

bool WorldPackets::AuctionHouse::ListResult::IsCorrectSearchedName(std::string_view searchedName)
{
    // converting string that we try to find to lower case
    return Utf8toWStr(searchedName, WSearchedName);
}

WorldPacket const* WorldPackets::AuctionHouse::ListResult::Write()
{
    _worldPacket << uint32(0);

    uint32 count{};
    uint32 totalCount{};

    for (auto const auction : AuctionShortlist)
    {
        if (IsGetAll)
        {
            Item* item = sAuctionMgr->GetAuctionItem(auction->ItemGuid);
            if (!item)
                continue;

            ++count;
            auction->BuildAuctionInfo(_worldPacket);
        }
        else if (count < 50 && totalCount >= ListFrom) // Add the item if no search term or if entered search term was found
        {
            Item* item = sAuctionMgr->GetAuctionItem(auction->ItemGuid);
            if (!item)
                continue;

            ++count;
            auction->BuildAuctionInfo(_worldPacket);
        }

        ++totalCount;
    }

    _worldPacket.put<uint32>(0, count);
    _worldPacket << uint32(totalCount);
    _worldPacket << uint32(SearchDelay); // clientside search cooldown [ms] (gray search button)

    return &_worldPacket;
}

void WorldPackets::AuctionHouse::ListPendingSales::Read()
{
    _worldPacket >> Unk1;
}

WorldPacket const* WorldPackets::AuctionHouse::ListPendingSalesServer::Write()
{
    _worldPacket << uint32(0);  // count

    /*for (uint32 i = 0; i < count; ++i)
    {
        data << "";                                         // string
        data << "";                                         // string
        data << uint32(0);
        data << uint32(0);
        data << float(0);
    }*/

    return &_worldPacket;
}
