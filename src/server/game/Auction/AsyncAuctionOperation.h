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

#ifndef AC_ASYNC_AUCTION_OPERATION_H_
#define AC_ASYNC_AUCTION_OPERATION_H_

#include "ObjectGuid.h"
#include <memory>
#include <utility>

class Player;

struct AuctionListItems;
struct AuctionSellItem;

class AC_GAME_API AsyncAuctionOperation
{
public:
    explicit AsyncAuctionOperation(ObjectGuid playerGuid) :
        _playerGuid(playerGuid) { }

    virtual ~AsyncAuctionOperation() = default;

    virtual void Execute() = 0;

    [[nodiscard]] ObjectGuid GetPlayerGUID() const { return _playerGuid; }
    [[nodiscard]] Player* GetPlayer() const;

private:
    ObjectGuid _playerGuid;

    AsyncAuctionOperation(AsyncAuctionOperation const& right) = delete;
    AsyncAuctionOperation& operator=(AsyncAuctionOperation const& right) = delete;
};

class AC_GAME_API SellItemTask : public AsyncAuctionOperation
{
public:
    SellItemTask(ObjectGuid playerGuid, std::shared_ptr<AuctionSellItem> packet) :
        AsyncAuctionOperation(playerGuid), _packet(std::move(packet)) { }

    ~SellItemTask() override = default;

    void Execute() override;

private:
    std::shared_ptr<AuctionSellItem> _packet;
};

class AC_GAME_API PlaceBidTask : public AsyncAuctionOperation
{
public:
    PlaceBidTask(ObjectGuid playerGuid, ObjectGuid auctioneer, uint32 auctionID, uint32 price) :
        AsyncAuctionOperation(playerGuid), _auctioneer(auctioneer), _auctionID(auctionID), _price(price) { }

    ~PlaceBidTask() override = default;

    void Execute() override;

private:
    ObjectGuid _auctioneer;
    uint32 _auctionID{};
    uint32 _price{};
};

class AC_GAME_API ListBidderItemsTask : public AsyncAuctionOperation
{
public:
    ListBidderItemsTask(ObjectGuid playerGuid, ObjectGuid auctioneer, std::vector<uint32>&& outbiddedAuctionIds) :
        AsyncAuctionOperation(playerGuid),
        _auctioneer(auctioneer),
        _outbiddedAuctionIds(std::move(outbiddedAuctionIds)) { }

    ~ListBidderItemsTask() override = default;

    void Execute() override;

private:
    ObjectGuid _auctioneer;
    std::vector<uint32> _outbiddedAuctionIds{};
};

class AC_GAME_API ListOwnerTask : public AsyncAuctionOperation
{
public:
    ListOwnerTask(ObjectGuid playerGuid, ObjectGuid creatureGuid) :
        AsyncAuctionOperation(playerGuid), _creatureGuid(creatureGuid) { }

    ~ListOwnerTask() override = default;

    void Execute() override;

private:
    ObjectGuid _creatureGuid;
};

class AC_GAME_API ListItemsTask : public AsyncAuctionOperation
{
public:
    explicit ListItemsTask(ObjectGuid playerGuid, std::shared_ptr<AuctionListItems> packet) :
        AsyncAuctionOperation(playerGuid), _packet(std::move(packet)) { }

    ~ListItemsTask() override = default;

    void Execute() override;

private:
    std::shared_ptr<AuctionListItems> _packet;
};

#endif
