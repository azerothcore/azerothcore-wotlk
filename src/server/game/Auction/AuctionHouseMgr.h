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

#ifndef AC_AUCTION_HOUSE_MGR_H_
#define AC_AUCTION_HOUSE_MGR_H_

#include "AuctionFwd.h"
#include "DBCStructure.h"
#include "DatabaseEnvFwd.h"
#include "EventProcessor.h"
#include "ObjectGuid.h"
#include <functional>
#include <unordered_map>
#include <shared_mutex>

class Item;
class Player;
class WorldPacket;

struct AuctionListItems;

namespace WorldPackets::AuctionHouse
{
    class ListResult;
}

struct AuctionEntry
{
    uint32 Id{};
    uint8 HouseId{};
    ObjectGuid ItemGuid{ ObjectGuid::Empty };
    uint32 ItemID{};
    uint32 ItemCount{};
    ObjectGuid PlayerOwner{ ObjectGuid::Empty };
    uint32 StartBid{}; // maybe useless
    uint32 Bid{};
    uint32 BuyOut{};
    Seconds ExpireTime{};
    ObjectGuid Bidder{ ObjectGuid::Empty };
    uint32 Deposit{}; // Deposit can be calculated only when creating an auction
    AuctionHouseEntry const* auctionHouseEntry; // in AuctionHouse.dbc

    // Helpers
    [[nodiscard]] uint8 GetHouseId() const { return HouseId; }
    [[nodiscard]] uint32 GetAuctionCut() const;
    [[nodiscard]] uint32 GetAuctionOutBid() const;
    [[nodiscard]] Milliseconds GetExpiredTime() const;
    bool BuildAuctionInfo(WorldPacket& data) const;
    void DeleteFromDB(CharacterDatabaseTransaction trans) const;
    void SaveToDB(CharacterDatabaseTransaction trans) const;
    bool LoadFromDB(Field* fields);
    [[nodiscard]] std::string BuildAuctionMailSubject(MailAuctionAnswers response) const;
    static std::string BuildAuctionMailBody(ObjectGuid guid, uint32 bid, uint32 buyout, uint32 deposit = 0, uint32 cut = 0, uint32 moneyDelay = 0, uint32 eta = 0);
};

class AC_GAME_API AuctionHouseObject
{
public:
    // Initialize storage
    AuctionHouseObject() = default;
    ~AuctionHouseObject() = default;

    [[nodiscard]] std::size_t GetCount();
    void ForEachAuctions(std::function<void(AuctionEntry*)> const& fn);
    void ForEachAuctionsWrite(std::function<void(AuctionEntry*)> const& fn);
    [[nodiscard]] AuctionEntry* GetAuction(uint32 id);
    void AddAuction(std::unique_ptr<AuctionEntry>&& auction);
    bool RemoveAuction(AuctionEntry* auction);
    void Update();

    void BuildListAuctionItems(WorldPackets::AuctionHouse::ListResult& packet, Player* player, std::shared_ptr<AuctionListItems> listItems);

private:
    std::shared_mutex _mutex;
    std::unordered_map<uint32, std::unique_ptr<AuctionEntry>> _auctions;
};

class AC_GAME_API AuctionHouseMgr
{
private:
    AuctionHouseMgr() = default;
    ~AuctionHouseMgr();

public:
    static AuctionHouseMgr* instance();

    AuctionHouseObject* GetAuctionsMap(uint32 factionTemplateId);
    AuctionHouseObject* GetAuctionsMapByHouseId(uint8 auctionHouseId);

    Item* GetAuctionItem(ObjectGuid itemGuid);

    // Auction messages
    void SendAuctionWonMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification = true, bool updateAchievementCriteria = true, bool sendMail = true);
    void SendAuctionSalePendingMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendMail = true);
    void SendAuctionSuccessfulMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification = true, bool updateAchievementCriteria = true, bool sendMail = true);
    void SendAuctionExpiredMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification = true, bool sendMail = true);
    void SendAuctionOutbiddedMail(AuctionEntry* auction, uint32 newPrice, Player* newBidder, CharacterDatabaseTransaction trans, bool sendNotification = true, bool sendMail = true);
    void SendAuctionCancelledToBidderMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendMail = true);

    static uint32 GetAuctionDeposit(AuctionHouseEntry const* entry, Minutes elapsedTime, Item* pItem, uint32 count);
    static AuctionHouseEntry const* GetAuctionHouseEntry(uint32 factionTemplateId);
    static AuctionHouseEntry const* GetAuctionHouseEntryFromHouse(uint8 houseId);

    //load first auction items, because of check if item exists, when loading
    void LoadAuctionItems();
    void LoadAuctions();

    void AddAuctionItem(Item* item);
    bool RemoveAItem(ObjectGuid itemGuid, bool deleteFromDB = false, CharacterDatabaseTransaction trans = nullptr);

    void Update();

private:
    void ClearItems();

    AuctionHouseObject _hordeAuctions;
    AuctionHouseObject _allianceAuctions;
    AuctionHouseObject _neutralAuctions;
    std::unordered_map<ObjectGuid, Item*> _items;
    std::shared_mutex _mutex;
};

#define sAuctionMgr AuctionHouseMgr::instance()

#endif
