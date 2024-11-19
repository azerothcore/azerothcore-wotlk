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

    int CompareAuctionEntry(uint32 column, std::shared_ptr<SearchableAuctionEntry> const auc, int loc_idx) const;
};

typedef std::vector<AuctionSortInfo> AuctionSortOrderVector;

struct AuctionHouseSearchInfo
{
    std::wstring wsearchedname;
    uint32 listfrom;
    uint8 levelmin;
    uint8 levelmax;
    uint8 usable;
    uint32 inventoryType;
    uint32 itemClass;
    uint32 itemSubClass;
    uint32 quality;
    uint8 getAll;
    AuctionHouseFaction listFaction;
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

struct AuctionSearchRequest
{
public:
    AuctionSearchRequest(AuctionHouseSearchInfo const&& _searchInfo, AuctionHousePlayerInfo const&& _playerInfo)
        : searchInfo(_searchInfo), playerInfo(_playerInfo) { }

    AuctionHouseSearchInfo searchInfo;
    AuctionHousePlayerInfo playerInfo;
};

struct AuctionSearchResponse
{
    ObjectGuid playerGuid;
    WorldPacket packet;
};

struct AuctionSearchUpdate
{
    enum class Type : bool
    {
        ADD,
        REMOVE
    };

    AuctionSearchUpdate() : updateType(Type::ADD) { }
    AuctionSearchUpdate(Type type, std::shared_ptr<SearchableAuctionEntry> const auctionEntry)
        : updateType(type), searchableAuctionEntry(auctionEntry) { }

    Type updateType;
    std::shared_ptr<SearchableAuctionEntry> searchableAuctionEntry;
};

typedef std::unordered_map<uint32, std::shared_ptr<SearchableAuctionEntry>> SearchableAuctionEntriesMap;
typedef std::vector<std::shared_ptr<SearchableAuctionEntry>> SortableAuctionEntriesList;

class AuctionSorter
{
public:
    AuctionSorter(AuctionSortOrderVector* sort, int loc_idx) : m_sort(sort), m_loc_idx(loc_idx) {}
    bool operator()(std::shared_ptr<SearchableAuctionEntry> const auc1, std::shared_ptr<SearchableAuctionEntry> const auc2) const;

private:
    AuctionSortOrderVector* m_sort;
    int m_loc_idx;
};

class AuctionHouseWorkerThread
{
public:
    AuctionHouseWorkerThread(ProducerConsumerQueue<AuctionSearchRequest*>* requestQueue, MPSCQueue<AuctionSearchResponse>* responseQueue);

    void Stop();

    void AddAuctionSearchUpdateToQueue(AuctionSearchUpdate const& auctionSearchUpdate);

private:
    void Run();

    void ProcessSearchUpdates();
    void ProcessSearchRequests();

    void BuildListAuctionItems(AuctionSearchRequest const* searchRequest, SortableAuctionEntriesList& auctionEntries, SearchableAuctionEntriesMap const& auctionMap) const;

    SearchableAuctionEntriesMap& GetSearchableAuctionMap(AuctionHouseFaction faction) { return _searchableAuctionMap[static_cast<uint8>(faction)]; };

    SearchableAuctionEntriesMap _searchableAuctionMap[MAX_AUCTION_HOUSE_FACTIONS];
    LockedQueue<AuctionSearchUpdate> _auctionUpdatesQueue;

    ProducerConsumerQueue<AuctionSearchRequest*>* _requestQueue;
    MPSCQueue<AuctionSearchResponse>* _responseQueue;

    std::thread _workerThread;
};

class AuctionHouseSearcher
{
public:
    AuctionHouseSearcher();
    ~AuctionHouseSearcher();

    void Update();

    void AddSearchRequest(AuctionSearchRequest* searchRequestInfo);

    void AddAuction(AuctionEntry const* auctionEntry);
    void RemoveAuction(AuctionEntry const* auctionEntry);
    void UpdateBid(AuctionEntry const* auctionEntry);

    void NotifyWorkers(AuctionSearchUpdate::Type const type, std::shared_ptr<SearchableAuctionEntry> const auctionEntry);

private:
    SearchableAuctionEntriesMap& GetSearchableAuctionMap(AuctionHouseFaction faction) { return _searchableAuctionEntriesMap[static_cast<uint8>(faction)]; };
    SearchableAuctionEntriesMap const& GetSearchableAuctionMap(AuctionHouseFaction faction) const { return _searchableAuctionEntriesMap[static_cast<uint8>(faction)]; };

    std::shared_ptr<SearchableAuctionEntry> GetSearchableAuctionEntry(AuctionHouseFaction faction, uint32 Id);

    SearchableAuctionEntriesMap _searchableAuctionEntriesMap[MAX_AUCTION_HOUSE_FACTIONS];

    ProducerConsumerQueue<AuctionSearchRequest*> _requestQueue;
    MPSCQueue<AuctionSearchResponse> _responseQueue;
    std::vector<AuctionHouseWorkerThread*> _workerThreads;
};

#endif
