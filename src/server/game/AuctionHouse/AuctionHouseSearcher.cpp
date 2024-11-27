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

#include "AuctionHouseMgr.h"
#include "AuctionHouseSearcher.h"
#include "CharacterCache.h"
#include "DBCStores.h"
#include "GameTime.h"
#include "Player.h"

AuctionHouseWorkerThread::AuctionHouseWorkerThread(ProducerConsumerQueue<AuctionSearchRequest*>* requestQueue, MPSCQueue<AuctionSearchResponse>* responseQueue)
{
    _workerThread = std::thread(&AuctionHouseWorkerThread::Run, this);
    _requestQueue = requestQueue;
    _responseQueue = responseQueue;
}

void AuctionHouseWorkerThread::Stop()
{
    _workerThread.join();
}

void AuctionHouseWorkerThread::AddAuctionSearchUpdateToQueue(std::shared_ptr<AuctionSearchUpdate> const auctionSearchUpdate)
{
    _auctionUpdatesQueue.add(auctionSearchUpdate);
}

void AuctionHouseWorkerThread::Run()
{
    while (!World::IsStopped())
    {
        std::this_thread::sleep_for(Milliseconds(25));

        ProcessSearchUpdates();
        ProcessSearchRequests();
    }
}

void AuctionHouseWorkerThread::ProcessSearchUpdates()
{
    std::shared_ptr<AuctionSearchUpdate> auctionSearchUpdate;
    while (_auctionUpdatesQueue.next(auctionSearchUpdate))
    {
        SearchableAuctionEntriesMap& searchableAuctionMap = GetSearchableAuctionMap(auctionSearchUpdate->listFaction);

        switch (auctionSearchUpdate->updateType)
        {
        case AuctionSearchUpdate::Type::ADD:
        {
            std::shared_ptr<AuctionSearchAdd> const auctionAdd = std::static_pointer_cast<AuctionSearchAdd>(auctionSearchUpdate);
            searchableAuctionMap.insert(std::make_pair(auctionAdd->searchableAuctionEntry->Id, auctionAdd->searchableAuctionEntry));
            break;
        }
        case AuctionSearchUpdate::Type::REMOVE:
        {
            std::shared_ptr<AuctionSearchRemove> const auctionRemove = std::static_pointer_cast<AuctionSearchRemove>(auctionSearchUpdate);
            searchableAuctionMap.erase(auctionRemove->auctionId);
            break;
        }
        case AuctionSearchUpdate::Type::UPDATE_BID:
        {
            std::shared_ptr<AuctionSearchUpdateBid> const auctionUpdateBid = std::static_pointer_cast<AuctionSearchUpdateBid>(auctionSearchUpdate);
            SearchableAuctionEntriesMap::const_iterator itr = searchableAuctionMap.find(auctionUpdateBid->auctionId);
            if (itr != searchableAuctionMap.end())
            {
                itr->second->bid = auctionUpdateBid->bid;
                itr->second->bidderGuid = auctionUpdateBid->bidderGuid;
            }
            break;
        }
        default:
            break;
        }
    }
}

void AuctionHouseWorkerThread::ProcessSearchRequests()
{
    AuctionSearchRequest* searchRequest = nullptr;
    while (_requestQueue->Pop(searchRequest))
    {
        SearchableAuctionEntriesMap const& searchableAuctionMap = GetSearchableAuctionMap(searchRequest->searchInfo.listFaction);

        AuctionSearchResponse* searchResponse = new AuctionSearchResponse();
        searchResponse->playerGuid = searchRequest->playerInfo.playerGuid;

        uint32 count = 0, totalCount = 0;

        searchResponse->packet.Initialize(SMSG_AUCTION_LIST_RESULT, (4 + 4 + 4));
        searchResponse->packet << (uint32)0;

        if (!searchRequest->searchInfo.getAll)
        {
            SortableAuctionEntriesList auctionEntries;
            BuildListAuctionItems(searchRequest, auctionEntries, searchableAuctionMap);

            if (!searchRequest->searchInfo.sorting.empty() && auctionEntries.size() > MAX_AUCTIONS_PER_PAGE)
            {
                AuctionSorter sorter(&searchRequest->searchInfo.sorting, searchRequest->playerInfo.locdbc_idx);
                std::sort(auctionEntries.begin(), auctionEntries.end(), sorter);
            }

            SortableAuctionEntriesList::const_iterator itr = auctionEntries.begin();
            if (searchRequest->searchInfo.listfrom)
            {
                if (searchRequest->searchInfo.listfrom > auctionEntries.size())
                    itr = auctionEntries.end();
                else
                    itr += searchRequest->searchInfo.listfrom;
            }

            for (; itr != auctionEntries.end(); ++itr)
            {
                (*itr)->BuildAuctionInfo(searchResponse->packet);

                if (++count >= MAX_AUCTIONS_PER_PAGE)
                    break;
            }

            totalCount = auctionEntries.size();
        }
        else
        {
            // getAll handling
            for (auto const& pair : searchableAuctionMap)
            {
                std::shared_ptr<SearchableAuctionEntry> const Aentry = pair.second;
                ++count;
                Aentry->BuildAuctionInfo(searchResponse->packet);

                if (count >= MAX_GETALL_RETURN)
                    break;
            }

            totalCount = searchableAuctionMap.size();
        }

        searchResponse->packet.put<uint32>(0, count);
        searchResponse->packet << totalCount;
        searchResponse->packet << uint32(AUCTION_SEARCH_DELAY);

        _responseQueue->Enqueue(searchResponse);

        delete searchRequest;
    }
}

void AuctionHouseWorkerThread::BuildListAuctionItems(AuctionSearchRequest const* searchRequest, SortableAuctionEntriesList& auctionEntries, SearchableAuctionEntriesMap const& auctionMap) const
{
    // pussywizard: optimization, this is a simplified case
    if (searchRequest->searchInfo.itemClass == 0xffffffff && searchRequest->searchInfo.itemSubClass == 0xffffffff
        && searchRequest->searchInfo.inventoryType == 0xffffffff && searchRequest->searchInfo.quality == 0xffffffff
        && searchRequest->searchInfo.levelmin == 0x00 && searchRequest->searchInfo.levelmax == 0x00
        && searchRequest->searchInfo.usable == 0x00 && searchRequest->searchInfo.wsearchedname.empty())
    {
        for (auto const& pair : auctionMap)
            auctionEntries.push_back(pair.second);
    }
    else
    {
        for (auto const& pair : auctionMap)
        {
            std::shared_ptr<SearchableAuctionEntry> const Aentry = pair.second;
            SearchableAuctionEntryItem const& Aitem = Aentry->item;
            ItemTemplate const* proto = Aitem.itemTemplate;

            if (searchRequest->searchInfo.itemClass != 0xffffffff && proto->Class != searchRequest->searchInfo.itemClass)
                continue;

            if (searchRequest->searchInfo.itemSubClass != 0xffffffff && proto->SubClass != searchRequest->searchInfo.itemSubClass)
                continue;

            if (searchRequest->searchInfo.inventoryType != 0xffffffff && proto->InventoryType != searchRequest->searchInfo.inventoryType)
            {
                // xinef: exception, robes are counted as chests
                if (searchRequest->searchInfo.inventoryType != INVTYPE_CHEST || proto->InventoryType != INVTYPE_ROBE)
                    continue;
            }

            if (searchRequest->searchInfo.quality != 0xffffffff && proto->Quality < searchRequest->searchInfo.quality)
                continue;

            if (searchRequest->searchInfo.levelmin != 0x00 && (proto->RequiredLevel < searchRequest->searchInfo.levelmin
                || (searchRequest->searchInfo.levelmax != 0x00 && proto->RequiredLevel > searchRequest->searchInfo.levelmax)))
            {
                continue;
            }

            if (searchRequest->searchInfo.usable != 0x00)
            {
                if (!searchRequest->playerInfo.usablePlayerInfo.value().PlayerCanUseItem(proto))
                    continue;
            }

            // Allow search by suffix (ie: of the Monkey) or partial name (ie: Monkey)
            // No need to do any of this if no search term was entered
            if (!searchRequest->searchInfo.wsearchedname.empty())
            {
                if (Aitem.itemName[searchRequest->playerInfo.locdbc_idx].find(searchRequest->searchInfo.wsearchedname) == std::wstring::npos)
                    continue;
            }

            auctionEntries.push_back(Aentry);
        }
    }
}

AuctionHouseSearcher::AuctionHouseSearcher()
{
    //@TODO: Config
    for (uint32 i = 0; i < 1; ++i)
        _workerThreads.push_back(new AuctionHouseWorkerThread(&_requestQueue, &_responseQueue));
}

AuctionHouseSearcher::~AuctionHouseSearcher()
{
    _requestQueue.Cancel();
    for (AuctionHouseWorkerThread* workerThread : _workerThreads)
        workerThread->Stop();
}

void AuctionHouseSearcher::Update()
{
    AuctionSearchResponse* response = nullptr;
    while (_responseQueue.Dequeue(response))
    {
        Player* player = ObjectAccessor::FindConnectedPlayer(response->playerGuid);
        if (player)
            player->GetSession()->SendPacket(&response->packet);

        delete response;
    }
}

void AuctionHouseSearcher::AddSearchRequest(AuctionSearchRequest* searchRequestInfo)
{
    _requestQueue.Push(searchRequestInfo);
}

void AuctionHouseSearcher::AddAuction(AuctionEntry const* auctionEntry)
{
    Item* item = sAuctionMgr->GetAItem(auctionEntry->item_guid);
    if (!item)
        return;

    // SearchableAuctionEntry is a shared_ptr as it will be shared among all the worker threads and needs to be self-managed
    std::shared_ptr<SearchableAuctionEntry> searchableAuctionEntry = std::make_shared<SearchableAuctionEntry>();
    searchableAuctionEntry->Id = auctionEntry->Id;

    // Auction info
    searchableAuctionEntry->ownerGuid = auctionEntry->owner;
    sCharacterCache->GetCharacterNameByGuid(auctionEntry->owner, searchableAuctionEntry->ownerName);
    searchableAuctionEntry->startbid = auctionEntry->startbid;
    searchableAuctionEntry->buyout = auctionEntry->buyout;
    searchableAuctionEntry->expire_time = auctionEntry->expire_time;
    searchableAuctionEntry->listFaction = auctionEntry->GetFactionId();

    searchableAuctionEntry->bid = 0;
    searchableAuctionEntry->bidderGuid = ObjectGuid::Empty;

    // Item info
    searchableAuctionEntry->item.entry = item->GetEntry();

    for (uint8 i = 0; i < MAX_INSPECTED_ENCHANTMENT_SLOT; ++i)
    {
        searchableAuctionEntry->item.enchants[i].id = item->GetEnchantmentId(EnchantmentSlot(i));
        searchableAuctionEntry->item.enchants[i].duration = item->GetEnchantmentDuration(EnchantmentSlot(i));
        searchableAuctionEntry->item.enchants[i].charges = item->GetEnchantmentCharges(EnchantmentSlot(i));
    }

    searchableAuctionEntry->item.randomPropertyId = item->GetItemRandomPropertyId();
    searchableAuctionEntry->item.suffixFactor = item->GetItemSuffixFactor();
    searchableAuctionEntry->item.count = item->GetCount();
    searchableAuctionEntry->item.spellCharges = item->GetSpellCharges();
    searchableAuctionEntry->item.itemTemplate = item->GetTemplate();

    searchableAuctionEntry->SetItemNames();

    // Let the worker threads know we have a new auction
    NotifyAllWorkers(std::make_shared<AuctionSearchAdd>(searchableAuctionEntry));
}

void AuctionHouseSearcher::RemoveAuction(AuctionEntry const* auctionEntry)
{
    NotifyAllWorkers(std::make_shared<AuctionSearchRemove>(auctionEntry->Id, auctionEntry->GetFactionId()));
}

void AuctionHouseSearcher::UpdateBid(AuctionEntry const* auctionEntry)
{
    // Updating bids is a bit unique, we really only need to update a single worker as every worker thread contains
    // a map of shared pointers to the same SearchableAuctionEntry's, so updating one will update them all.
    NotifyOneWorker(std::make_shared<AuctionSearchUpdateBid>(auctionEntry->Id, auctionEntry->GetFactionId(), auctionEntry->bid, auctionEntry->bidder));
}

void AuctionHouseSearcher::NotifyAllWorkers(std::shared_ptr<AuctionSearchUpdate> const auctionSearchUpdate)
{
    for (AuctionHouseWorkerThread* workerThread : _workerThreads)
        workerThread->AddAuctionSearchUpdateToQueue(auctionSearchUpdate);
}

void AuctionHouseSearcher::NotifyOneWorker(std::shared_ptr<AuctionSearchUpdate> const auctionSearchUpdate)
{
    // Just notify the first worker in the list, no big deal which
    (*_workerThreads.begin())->AddAuctionSearchUpdateToQueue(auctionSearchUpdate);
}

void SearchableAuctionEntry::BuildAuctionInfo(WorldPacket& data) const
{
    data << uint32(Id);
    data << uint32(item.entry);

    for (uint8 i = 0; i < MAX_INSPECTED_ENCHANTMENT_SLOT; ++i)
    {
        data << uint32(item.enchants[i].id);
        data << uint32(item.enchants[i].duration);
        data << uint32(item.enchants[i].charges);
    }

    data << int32(item.randomPropertyId);                           // Random item property id
    data << uint32(item.suffixFactor);                              // SuffixFactor
    data << uint32(item.count);                                     // item->count
    data << uint32(item.spellCharges);                              // item->charge FFFFFFF
    data << uint32(0);                                              // item->flags (client doesnt do anything with it)
    data << ownerGuid;                                              // Auction->owner
    data << uint32(startbid);                                       // Auction->startbid (not sure if useful)
    data << uint32(bid ? AuctionEntry::CalculateAuctionOutBid(bid) : 0);
    // Minimal outbid
    data << uint32(buyout);                                         // Auction->buyout
    data << uint32((expire_time - GameTime::GetGameTime().count()) * IN_MILLISECONDS); // time left
    data << bidderGuid;                                             // auction->bidder current
    data << uint32(bid);                                            // current bid
}

void SearchableAuctionEntry::SetItemNames()
{
    ItemTemplate const* proto = item.itemTemplate;
    ItemLocale const* il = sObjectMgr->GetItemLocale(proto->ItemId);

    for (uint32 locale = 0; locale < TOTAL_LOCALES; ++locale)
    {
        if (proto->Name1.empty())
            continue;

        std::string itemName = proto->Name1;

        // local name
        LocaleConstant locdbc_idx = sWorld->GetAvailableDbcLocale(static_cast<LocaleConstant>(locale));
        if (locdbc_idx >= LOCALE_enUS && il)
            ObjectMgr::GetLocaleString(il->Name, locale, itemName);

        // DO NOT use GetItemEnchantMod(proto->RandomProperty) as it may return a result
        //  that matches the search but it may not equal item->GetItemRandomPropertyId()
        //  used in BuildAuctionInfo() which then causes wrong items to be listed
        int32 propRefID = item.randomPropertyId;

        if (propRefID)
        {
            // Append the suffix to the name (ie: of the Monkey) if one exists
            // These are found in ItemRandomSuffix.dbc and ItemRandomProperties.dbc
            // even though the DBC name seems misleading
            std::array<char const*, 16> const* suffix = nullptr;

            if (propRefID < 0)
            {
                ItemRandomSuffixEntry const* itemRandEntry = sItemRandomSuffixStore.LookupEntry(-item.randomPropertyId);
                if (itemRandEntry)
                    suffix = &itemRandEntry->Name;
            }
            else
            {
                ItemRandomPropertiesEntry const* itemRandEntry = sItemRandomPropertiesStore.LookupEntry(item.randomPropertyId);
                if (itemRandEntry)
                    suffix = &itemRandEntry->Name;
            }

            // dbc local name
            if (suffix)
            {
                // Append the suffix (ie: of the Monkey) to the name using localization
                // or default enUS if localization is invalid
                itemName += ' ';
                itemName += (*suffix)[locdbc_idx >= 0 ? locdbc_idx : LOCALE_enUS];
            }
        }

        if (!Utf8toWStr(itemName, item.itemName[locale]))
            continue;

        wstrToLower(item.itemName[locale]);
    }
}

int SearchableAuctionEntry::CompareAuctionEntry(uint32 column, std::shared_ptr<SearchableAuctionEntry> const auc, int loc_idx) const
{
    switch (column)
    {
    case AUCTION_SORT_MINLEVEL:                                             // level = 0
    {
        ItemTemplate const* itemProto1 = item.itemTemplate;
        ItemTemplate const* itemProto2 = auc->item.itemTemplate;

        if (itemProto1->RequiredLevel > itemProto2->RequiredLevel)
            return -1;
        else if (itemProto1->RequiredLevel < itemProto2->RequiredLevel)
            return +1;
        break;
    }
    case AUCTION_SORT_RARITY:                                             // quality = 1
    {
        ItemTemplate const* itemProto1 = item.itemTemplate;
        ItemTemplate const* itemProto2 = auc->item.itemTemplate;

        if (itemProto1->Quality < itemProto2->Quality)
            return -1;
        else if (itemProto1->Quality > itemProto2->Quality)
            return +1;
        break;
    }
    case AUCTION_SORT_BUYOUT:                                             // buyoutthenbid = 2 (UNUSED?)
        if (buyout != auc->buyout)
        {
            if (buyout < auc->buyout)
                return -1;
            else if (buyout > auc->buyout)
                return +1;
        }
        else
        {
            if (bid < auc->bid)
                return -1;
            else if (bid > auc->bid)
                return +1;
        }
        break;
    case AUCTION_SORT_TIMELEFT:                                             // duration = 3
        if (expire_time < auc->expire_time)
            return -1;
        else if (expire_time > auc->expire_time)
            return +1;
        break;
    case AUCTION_SORT_UNK4:                                             // status = 4 (WRONG)
        if (bidderGuid.GetCounter() < auc->bidderGuid.GetCounter())
            return -1;
        else if (bidderGuid.GetCounter() > auc->bidderGuid.GetCounter())
            return +1;
        break;
    case AUCTION_SORT_ITEM:                                             // name = 5
    {
        int comparison = item.itemName[loc_idx].compare(auc->item.itemName[loc_idx]);
        if (comparison > 0)
            return -1;
        else if (comparison < 0)
            return +1;

        break;
    }
    case AUCTION_SORT_MINBIDBUY:                                             // minbidbuyout = 6
    {
        if (buyout != auc->buyout)
        {
            if (buyout > auc->buyout)
                return -1;
            else if (buyout < auc->buyout)
                return +1;
        }
        else
        {
            if (bid < auc->bid)
                return -1;
            else if (bid > auc->bid)
                return +1;
        }
        break;
    }
    case AUCTION_SORT_OWNER:                                             // seller = 7
    {
        int comparison = ownerName.compare(auc->ownerName);
        if (comparison > 0)
            return -1;
        else if (comparison < 0)
            return +1;

        break;
    }
    case AUCTION_SORT_BID:                                             // bid = 8
    {
        uint32 bid1 = bid ? bid : startbid;
        uint32 bid2 = auc->bid ? auc->bid : auc->startbid;

        if (bid1 > bid2)
            return -1;
        else if (bid1 < bid2)
            return +1;
        break;
    }
    case AUCTION_SORT_STACK:                                             // quantity = 9
    {
        if (item.count < auc->item.count)
            return -1;
        else if (item.count > auc->item.count)
            return +1;
        break;
    }
    case AUCTION_SORT_BUYOUT_2:                                            // buyout = 10 (UNUSED?)
        if (buyout < auc->buyout)
            return -1;
        else if (buyout > auc->buyout)
            return +1;
        break;
    default:
        break;
    }

    return 0;
}

bool AuctionSorter::operator()(std::shared_ptr<SearchableAuctionEntry> const auc1, std::shared_ptr<SearchableAuctionEntry> const auc2) const
{
    if (m_sort->empty())                      // not sorted
        return false;

    for (AuctionSortOrderVector::iterator itr = m_sort->begin(); itr != m_sort->end(); ++itr)
    {
        int res = auc1->CompareAuctionEntry(itr->sortOrder, auc2, m_loc_idx);
        // "equal" by used column
        if (res == 0)
            continue;
        // less/greater and normal/reversed ordered
        return (res < 0) == itr->isDesc;
    }

    return false;                                           // "equal" by all sorts
}

// Slightly simplified version of Player::CanUseItem. Only checks relevant to auctionhouse items
bool AuctionHouseUsablePlayerInfo::PlayerCanUseItem(ItemTemplate const* proto) const
{
    uint32 itemSkill = proto->GetSkill();
    if (itemSkill != 0)
    {
        if (GetSkillValue(itemSkill) == 0)
            return false;
    }

    if ((proto->AllowableClass & classMask) == 0 || (proto->AllowableRace & raceMask) == 0)
        return false;

    if (proto->RequiredSkill != 0)
    {
        if (GetSkillValue(proto->RequiredSkill) == 0)
            return false;
        else if (GetSkillValue(proto->RequiredSkill) < proto->RequiredSkillRank)
            return false;
    }

    if (proto->RequiredSpell != 0 && !HasSpell(proto->RequiredSpell))
        return false;

    if (level < proto->RequiredLevel)
        return false;

    if (proto->Spells[0].SpellId)
    {
        // this check is for vanilla recipies. Spells are learned through individual learning spells instead of spell 483 and 55884
        SpellEntry const* spellEntry = sSpellStore.LookupEntry(proto->Spells[0].SpellId);
        if (spellEntry && spellEntry->Effect[0] == SPELL_EFFECT_LEARN_SPELL && spellEntry->EffectTriggerSpell[0])
            if (HasSpell(spellEntry->EffectTriggerSpell[0]))
                return false;

        // this check is for tbc/wotlk recipies. Spells are learned through 483 and 55884, the second spell in the item will be the actual spell learned.
        if (proto->Spells[0].SpellId == 483 || proto->Spells[0].SpellId == 55884)
            if (HasSpell(proto->Spells[1].SpellId))
                return false;
    }

    return true;
}

uint16 AuctionHouseUsablePlayerInfo::GetSkillValue(uint32 skill) const
{
    if (!skill)
        return 0;

    AuctionPlayerSkills::const_iterator itr = skills.find(skill);
    if (itr == skills.end())
        return 0;

    return itr->second;
}

bool AuctionHouseUsablePlayerInfo::HasSpell(uint32 spell) const
{
    AuctionPlayerSpells::const_iterator itr = spells.find(spell);
    return (itr != spells.end());
}
