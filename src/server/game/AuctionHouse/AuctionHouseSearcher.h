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

#ifndef _AUCTION_HOUSE_SEARCHER_H
#define _AUCTION_HOUSE_SEARCHER_H

#include "AuctionHouseMgr.h"
#include "Common.h"
#include "Item.h"
#include "LockedQueue.h"
#include "MPSCQueue.h"
#include "PCQueue.h"
#include <memory>
#include <thread>
#include <unordered_map>
#include <unordered_set>

struct ItemTemplate;

enum AuctionSortOrder
{
    AUCTION_SORT_MINLEVEL       = 0,
    AUCTION_SORT_RARITY         = 1,
    AUCTION_SORT_BUYOUT         = 2,
    AUCTION_SORT_TIMELEFT       = 3,
    AUCTION_SORT_UNK4           = 4,
    AUCTION_SORT_ITEM           = 5,
    AUCTION_SORT_MINBIDBUY      = 6,
    AUCTION_SORT_OWNER          = 7,
    AUCTION_SORT_BID            = 8,
    AUCTION_SORT_STACK          = 9,
    AUCTION_SORT_BUYOUT_2       = 10,

    AUCTION_SORT_MAX
};

struct AuctionSortInfo
{
    AuctionSortInfo() = default;

    AuctionSortOrder sortOrder{ AUCTION_SORT_MAX };
    bool isDesc{ true };
};

struct AuctionEntryItemEnchants
{
    uint32 id;
    uint32 duration;
    uint32 charges;
};

struct SearchableAuctionEntryItem
{
    std::wstring itemName[TOTAL_LOCALES];
    uint32 entry;
    AuctionEntryItemEnchants enchants[MAX_INSPECTED_ENCHANTMENT_SLOT];
    int32 randomPropertyId;
    uint32 suffixFactor;
    uint32 count;
    int32 spellCharges;
    ItemTemplate const* itemTemplate;
};

struct SearchableAuctionEntry
{
    uint32 Id;
    ObjectGuid ownerGuid;
    std::string ownerName;
    uint32 buyout;
    time_t expire_time;
    uint32 startbid;
    uint32 bid;
    ObjectGuid bidderGuid;
    AuctionHouseFaction listFaction;
    SearchableAuctionEntryItem item;

    void BuildAuctionInfo(WorldPacket& data) const;
    void SetItemNames();

    int CompareAuctionEntry(uint32 column, SearchableAuctionEntry const& auc, int loc_idx) const;
};

typedef std::vector<AuctionSortInfo> AuctionSortOrderVector;

struct AuctionHouseSearchInfo
{
    std::wstring wsearchedname;
    uint32 listfrom;
    uint8 levelmin;
    uint8 levelmax;
    bool usable;
    uint32 inventoryType;
    uint32 itemClass;
    uint32 itemSubClass;
    uint32 quality;
    bool getAll;
    AuctionSortOrderVector sorting;
};

typedef std::unordered_map<uint32, uint16> AuctionPlayerSkills;
typedef std::unordered_set<uint32> AuctionPlayerSpells;

struct AuctionHouseUsablePlayerInfo
{
    uint32 classMask;
    uint32 raceMask;
    uint8 level;
    AuctionPlayerSkills skills; // active skills only
    AuctionPlayerSpells spells; // active spells only

    bool PlayerCanUseItem(ItemTemplate const* proto) const;
    uint16 GetSkillValue(uint32 skill) const;
    bool HasSpell(uint32 spell) const;
};

struct AuctionHousePlayerInfo
{
    ObjectGuid playerGuid;
    uint32 faction;
    int loc_idx;
    int locdbc_idx;
    std::optional<AuctionHouseUsablePlayerInfo> usablePlayerInfo;
};

struct AuctionSearcherRequest
{
    enum class Type : uint8
    {
        LIST,
        OWNER_LIST,
        BIDDER_LIST
    };

    AuctionSearcherRequest(Type const _requestType, AuctionHouseFaction _listFaction) : requestType(_requestType), listFaction(_listFaction) { }
    virtual ~AuctionSearcherRequest() = default;

    Type requestType;
    AuctionHouseFaction listFaction;
};

struct AuctionSearchListRequest : AuctionSearcherRequest
{
    AuctionSearchListRequest(AuctionHouseFaction _listFaction, AuctionHouseSearchInfo const&& _searchInfo, AuctionHousePlayerInfo const&& _playerInfo)
        : AuctionSearcherRequest(AuctionSearcherRequest::Type::LIST, _listFaction), searchInfo(_searchInfo), playerInfo(_playerInfo) { }

    AuctionHouseSearchInfo searchInfo;
    AuctionHousePlayerInfo playerInfo;
};

struct AuctionSearchOwnerListRequest : AuctionSearcherRequest
{
    AuctionSearchOwnerListRequest(AuctionHouseFaction _listFaction, ObjectGuid _ownerGuid)
        : AuctionSearcherRequest(AuctionSearcherRequest::Type::OWNER_LIST, _listFaction), ownerGuid(_ownerGuid) { }

    ObjectGuid ownerGuid;
};

struct AuctionSearchBidderListRequest : AuctionSearcherRequest
{
    AuctionSearchBidderListRequest(AuctionHouseFaction _listFaction, std::vector<uint32> const&& _outbiddedAuctionIds, ObjectGuid _ownerGuid)
        : AuctionSearcherRequest(AuctionSearcherRequest::Type::BIDDER_LIST, _listFaction), outbiddedAuctionIds(_outbiddedAuctionIds), ownerGuid(_ownerGuid) { }

    std::vector<uint32> outbiddedAuctionIds;
    ObjectGuid ownerGuid;
};

struct AuctionSearcherResponse
{
    ObjectGuid playerGuid;
    WorldPacket packet;
};

struct AuctionSearcherUpdate
{
    enum class Type : uint8
    {
        ADD,
        REMOVE,
        UPDATE_BID
    };

    AuctionSearcherUpdate(Type const _updateType, AuctionHouseFaction _listFaction) : updateType(_updateType), listFaction(_listFaction) { }
    virtual ~AuctionSearcherUpdate() = default;

    Type updateType;
    AuctionHouseFaction listFaction;
};

struct AuctionSearchAdd : AuctionSearcherUpdate
{
    AuctionSearchAdd(std::shared_ptr<SearchableAuctionEntry> _searchableAuctionEntry)
        : AuctionSearcherUpdate(AuctionSearcherUpdate::Type::ADD, _searchableAuctionEntry->listFaction), searchableAuctionEntry(_searchableAuctionEntry) { }

    std::shared_ptr<SearchableAuctionEntry> searchableAuctionEntry;
};

struct AuctionSearchRemove : AuctionSearcherUpdate
{
    AuctionSearchRemove(uint32 _auctionId, AuctionHouseFaction _listFaction)
        : AuctionSearcherUpdate(AuctionSearcherUpdate::Type::REMOVE, _listFaction), auctionId(_auctionId) { }

    uint32 auctionId;
};

struct AuctionSearchUpdateBid : AuctionSearcherUpdate
{
    AuctionSearchUpdateBid(uint32 _auctionId, AuctionHouseFaction _listFaction, uint32 _bid, ObjectGuid _bidderGuid)
        : AuctionSearcherUpdate(AuctionSearcherUpdate::Type::UPDATE_BID, _listFaction), auctionId(_auctionId), bid(_bid), bidderGuid(_bidderGuid) { }

    uint32 auctionId;
    uint32 bid;
    ObjectGuid bidderGuid;
};

typedef std::unordered_map<uint32, std::shared_ptr<SearchableAuctionEntry>> SearchableAuctionEntriesMap;
typedef std::vector<SearchableAuctionEntry*> SortableAuctionEntriesList;

class AuctionSorter
{
public:
    AuctionSorter(AuctionSortOrderVector const* sort, int loc_idx) : _sort(sort), _loc_idx(loc_idx) {}
    bool operator()(SearchableAuctionEntry const* auc1, SearchableAuctionEntry const* auc2) const;

private:
    AuctionSortOrderVector const* _sort;
    int _loc_idx;
};

class AuctionHouseWorkerThread
{
public:
    AuctionHouseWorkerThread(ProducerConsumerQueue<AuctionSearcherRequest*>* requestQueue, MPSCQueue<AuctionSearcherResponse>* responseQueue);

    void Stop();

    void AddAuctionSearchUpdateToQueue(std::shared_ptr<AuctionSearcherUpdate> const auctionSearchUpdate);

private:
    void Run();

    void ProcessSearchUpdates();
    void SearchUpdateAdd(AuctionSearchAdd const& auctionAdd);
    void SearchUpdateRemove(AuctionSearchRemove const& auctionRemove);
    void SearchUpdateBid(AuctionSearchUpdateBid const& auctionUpdateBid);

    void ProcessSearchRequests();
    void SearchListRequest(AuctionSearchListRequest const& searchListRequest);
    void SearchOwnerListRequest(AuctionSearchOwnerListRequest const& searchOwnerListRequest);
    void SearchBidderListRequest(AuctionSearchBidderListRequest const& searchBidderListRequest);

    void BuildListAuctionItems(AuctionSearchListRequest const& searchRequest, SortableAuctionEntriesList& auctionEntries, SearchableAuctionEntriesMap const& auctionMap) const;

    SearchableAuctionEntriesMap& GetSearchableAuctionMap(AuctionHouseFaction faction) { return _searchableAuctionMap[static_cast<uint8>(faction)]; };

    SearchableAuctionEntriesMap _searchableAuctionMap[MAX_AUCTION_HOUSE_FACTIONS];
    LockedQueue<std::shared_ptr<AuctionSearcherUpdate>> _auctionUpdatesQueue;

    ProducerConsumerQueue<AuctionSearcherRequest*>* _requestQueue;
    MPSCQueue<AuctionSearcherResponse>* _responseQueue;

    std::thread _workerThread;
    std::atomic<bool> _stopped;
};

class AuctionHouseSearcher
{
public:
    AuctionHouseSearcher();
    ~AuctionHouseSearcher();

    void Update();

    void QueueSearchRequest(AuctionSearcherRequest* searchRequestInfo);

    void AddAuction(AuctionEntry const* auctionEntry);
    void RemoveAuction(AuctionEntry const* auctionEntry);
    void UpdateBid(AuctionEntry const* auctionEntry);

    void NotifyAllWorkers(std::shared_ptr<AuctionSearcherUpdate> const auctionSearchUpdate);
    void NotifyOneWorker(std::shared_ptr<AuctionSearcherUpdate> const auctionSearchUpdate);

private:
    ProducerConsumerQueue<AuctionSearcherRequest*> _requestQueue;
    MPSCQueue<AuctionSearcherResponse> _responseQueue;
    std::vector<std::unique_ptr<AuctionHouseWorkerThread>> _workerThreads;
};

#endif
