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

#ifndef _AUCTION_HOUSE_MGR_H
#define _AUCTION_HOUSE_MGR_H

#include "Common.h"
#include "DBCStructure.h"
#include "DatabaseEnv.h"
#include "EventProcessor.h"
#include "ObjectGuid.h"
#include "Timer.h"
#include "WorldPacket.h"
#include <unordered_map>

class Item;
class Player;
class AuctionHouseSearcher;

#define MIN_AUCTION_TIME (12*HOUR)
#define MAX_AUCTION_ITEMS 160
#define MAX_AUCTIONS_PER_PAGE 50
#define AUCTION_SEARCH_DELAY 300

/*
    The max allowable single packet size in 3.3.5 client protocol is 0x7FFFFF. A single BuildAuctionInfo structure
    has a size of 148 bytes. 148 * 55000 = 8140000 which gives us just under the max size of 8388607 with a little
    bit of margin.

    Reference: https://wowpedia.fandom.com/wiki/API_QueryAuctionItems
    "In 4.0.1, getAll mode only fetches up to 42554 items. This is usually adequate, but high-population realms might have more."
*/
#define MAX_GETALL_RETURN 55000

enum AuctionError
{
    ERR_AUCTION_OK                  = 0,
    ERR_AUCTION_INVENTORY           = 1,
    ERR_AUCTION_DATABASE_ERROR      = 2,
    ERR_AUCTION_NOT_ENOUGHT_MONEY   = 3,
    ERR_AUCTION_ITEM_NOT_FOUND      = 4,
    ERR_AUCTION_HIGHER_BID          = 5,
    ERR_AUCTION_BID_INCREMENT       = 7,
    ERR_AUCTION_BID_OWN             = 10,
    ERR_AUCTION_RESTRICTED_ACCOUNT  = 13
};

enum AuctionAction
{
    AUCTION_SELL_ITEM   = 0,
    AUCTION_CANCEL      = 1,
    AUCTION_PLACE_BID   = 2
};

enum MailAuctionAnswers
{
    AUCTION_OUTBIDDED           = 0,
    AUCTION_WON                 = 1,
    AUCTION_SUCCESSFUL          = 2,
    AUCTION_EXPIRED             = 3,
    AUCTION_CANCELLED_TO_BIDDER = 4,
    AUCTION_CANCELED            = 5,
    AUCTION_SALE_PENDING        = 6
};

enum class AuctionHouseFaction : uint8
{
    Alliance,
    Horde,
    Neutral
};

enum class AuctionHouseId : uint8
{
    Alliance    = 2,
    Horde       = 6,
    Neutral     = 7
};

#define MAX_AUCTION_HOUSE_FACTIONS 3

struct AuctionEntry
{
    uint32 Id;
    AuctionHouseId houseId;
    ObjectGuid item_guid;
    uint32 item_template;
    uint32 itemCount;
    ObjectGuid owner;
    uint32 startbid;                                        //maybe useless
    uint32 bid;
    uint32 buyout;
    time_t expire_time;
    ObjectGuid bidder;
    uint32 deposit;                                         //deposit can be calculated only when creating auction
    AuctionHouseEntry const* auctionHouseEntry;             // in AuctionHouse.dbc

    // helpers
    [[nodiscard]] AuctionHouseId GetHouseId() const { return houseId; }
    [[nodiscard]] AuctionHouseFaction GetFactionId() const;
    [[nodiscard]] uint32 GetAuctionCut() const;
    [[nodiscard]] uint32 GetAuctionOutBid() const;
    [[nodiscard]] static uint32 CalculateAuctionOutBid(uint32 bid);
    void DeleteFromDB(CharacterDatabaseTransaction trans) const;
    void SaveToDB(CharacterDatabaseTransaction trans) const;
    bool LoadFromDB(Field* fields);
    [[nodiscard]] std::string BuildAuctionMailSubject(MailAuctionAnswers response) const;
    static std::string BuildAuctionMailBody(ObjectGuid guid, uint32 bid, uint32 buyout, uint32 deposit = 0, uint32 cut = 0, uint32 moneyDelay = 0, uint32 eta = 0);
};

//this class is used as auctionhouse instance
class AuctionHouseObject
{
public:
    // Initialize storage
    AuctionHouseObject() { _next = _auctionsMap.begin(); }
    ~AuctionHouseObject()
    {
        for (auto& itr : _auctionsMap)
            delete itr.second;
    }

    typedef std::map<uint32, AuctionEntry*> AuctionEntryMap;

    [[nodiscard]] uint32 Getcount() const { return _auctionsMap.size(); }

    AuctionEntryMap::iterator GetAuctionsBegin() { return _auctionsMap.begin(); }
    AuctionEntryMap::iterator GetAuctionsEnd() { return _auctionsMap.end(); }
    AuctionEntryMap const& GetAuctions() { return _auctionsMap; }

    [[nodiscard]] AuctionEntry* GetAuction(uint32 id) const
    {
        AuctionEntryMap::const_iterator itr = _auctionsMap.find(id);
        return itr != _auctionsMap.end() ? itr->second : nullptr;
    }

    void AddAuction(AuctionEntry* auction);

    bool RemoveAuction(AuctionEntry* auction);

    void Update();

private:
    AuctionEntryMap _auctionsMap;

    // storage for "next" auction item for next Update()
    AuctionEntryMap::const_iterator _next;
};

class AuctionHouseMgr
{
private:
    AuctionHouseMgr();
    ~AuctionHouseMgr();

public:
    typedef std::unordered_map<ObjectGuid, Item*> ItemMap;

    static AuctionHouseMgr* instance();

    AuctionHouseObject* GetAuctionsMap(uint32 factionTemplateId);
    AuctionHouseObject* GetAuctionsMapByHouseId(AuctionHouseId auctionHouseId);

    Item* GetAItem(ObjectGuid itemGuid)
    {
        ItemMap::const_iterator itr = _mAitems.find(itemGuid);
        if (itr != _mAitems.end())
            return itr->second;

        return nullptr;
    }

    //auction messages
    void SendAuctionWonMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification = true, bool updateAchievementCriteria = true, bool sendMail = true);
    void SendAuctionSalePendingMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendMail = true);
    void SendAuctionSuccessfulMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification = true, bool updateAchievementCriteria = true, bool sendMail = true);
    void SendAuctionExpiredMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification = true, bool sendMail = true);
    void SendAuctionOutbiddedMail(AuctionEntry* auction, uint32 newPrice, Player* newBidder, CharacterDatabaseTransaction trans, bool sendNotification = true, bool sendMail = true);
    void SendAuctionCancelledToBidderMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendMail = true);

    static uint32 GetAuctionDeposit(AuctionHouseEntry const* entry, uint32 time, Item* pItem, uint32 count);
    static AuctionHouseFaction GetAuctionHouseFactionFromHouseId(AuctionHouseId ahHouseId);
    static AuctionHouseEntry const* GetAuctionHouseEntryFromFactionTemplate(uint32 factionTemplateId);
    static AuctionHouseEntry const* GetAuctionHouseEntryFromHouse(AuctionHouseId ahHouseId);

    AuctionHouseSearcher* GetAuctionHouseSearcher() { return _auctionHouseSearcher; }

public:
    //load first auction items, because of check if item exists, when loading
    void LoadAuctionItems();
    void LoadAuctions();

    void AddAItem(Item* it);
    bool RemoveAItem(ObjectGuid itemGuid, bool deleteFromDB = false, CharacterDatabaseTransaction* trans = nullptr);

    void Update(uint32 const diff);

private:
    AuctionHouseObject _hordeAuctions;
    AuctionHouseObject _allianceAuctions;
    AuctionHouseObject _neutralAuctions;

    ItemMap _mAitems;

    AuctionHouseSearcher* _auctionHouseSearcher;

    IntervalTimer _updateIntervalTimer;
};

#define sAuctionMgr AuctionHouseMgr::instance()

#endif
