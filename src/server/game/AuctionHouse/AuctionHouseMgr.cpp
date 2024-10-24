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
#include "Common.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Item.h"
#include "Logging/Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "UpdateTime.h"
#include "World.h"
#include "WorldPacket.h"
#include <vector>

constexpr auto AH_MINIMUM_DEPOSIT = 100;

// Proof of concept, we should shift the info we're obtaining in here into AuctionEntry probably
static bool SortAuction(AuctionEntry* left, AuctionEntry* right, AuctionSortOrderVector& sortOrder, Player* player, bool checkMinBidBuyout)
{
    for (auto& thisOrder : sortOrder)
    {
        switch (thisOrder.sortOrder)
        {
            case AUCTION_SORT_BID:
            {
                if (left->bid == right->bid)
                {
                    if (checkMinBidBuyout)
                    {
                        if (left->buyout == right->buyout)
                        {
                            if (left->startbid == right->startbid)
                            {
                                continue;
                            }

                            return thisOrder.isDesc ? left->startbid > right->startbid : left->startbid < right->startbid;
                        }

                        return thisOrder.isDesc ? left->buyout > right->buyout : left->buyout < right->buyout;
                    }

                    continue;
                }

                return thisOrder.isDesc ? left->bid > right->bid : left->bid < right->bid;
            }
            case AUCTION_SORT_BUYOUT:
            case AUCTION_SORT_BUYOUT_2:
            {
                if (left->buyout == right->buyout)
                {
                    continue;
                }

                return thisOrder.isDesc ? left->buyout > right->buyout : left->buyout < right->buyout;
            }
            case AUCTION_SORT_ITEM:
            {
                ItemTemplate const* protoLeft = sObjectMgr->GetItemTemplate(left->item_template);
                ItemTemplate const* protoRight = sObjectMgr->GetItemTemplate(right->item_template);
                if (!protoLeft || !protoRight)
                {
                    continue;
                }

                std::string leftName = protoLeft->Name1;
                std::string rightName = protoRight->Name1;
                if (leftName.empty() || rightName.empty())
                {
                    continue;
                }

                LocaleConstant locale = LOCALE_enUS;
                if (player && player->GetSession())
                {
                    locale = player->GetSession()->GetSessionDbLocaleIndex();
                }

                if (locale > LOCALE_enUS)
                {
                    if (ItemLocale const* leftIl = sObjectMgr->GetItemLocale(protoLeft->ItemId))
                    {
                        ObjectMgr::GetLocaleString(leftIl->Name, locale, leftName);
                    }

                    if (ItemLocale const* rightIl = sObjectMgr->GetItemLocale(protoRight->ItemId))
                    {
                        ObjectMgr::GetLocaleString(rightIl->Name, locale, rightName);
                    }
                }

                int result = leftName.compare(rightName);
                if (result == 0)
                {
                    continue;
                }

                return thisOrder.isDesc ? result > 0 : result < 0;
            }
            case AUCTION_SORT_MINLEVEL:
            {
                ItemTemplate const* protoLeft  = sObjectMgr->GetItemTemplate(left->item_template);
                ItemTemplate const* protoRight = sObjectMgr->GetItemTemplate(right->item_template);
                if (!protoLeft || !protoRight)
                {
                    continue;
                }

                if (protoLeft->RequiredLevel == protoRight->RequiredLevel)
                {
                    continue;
                }

                return thisOrder.isDesc ? protoLeft->RequiredLevel > protoRight->RequiredLevel : protoLeft->RequiredLevel < protoRight->RequiredLevel;
            }
            case AUCTION_SORT_OWNER:
            {
                std::string leftName;
                sCharacterCache->GetCharacterNameByGuid(left->owner, leftName);

                std::string rightName;
                sCharacterCache->GetCharacterNameByGuid(right->owner, rightName);

                int result = leftName.compare(rightName);
                if (result == 0)
                {
                    continue;
                }

                return thisOrder.isDesc ? result > 0 : result < 0;
            }
            case AUCTION_SORT_RARITY:
            {
                ItemTemplate const* protoLeft  = sObjectMgr->GetItemTemplate(left->item_template);
                ItemTemplate const*  protoRight = sObjectMgr->GetItemTemplate(right->item_template);
                if (!protoLeft || !protoRight)
                {
                    continue;
                }

                if (protoLeft->Quality == protoRight->Quality)
                {
                    continue;
                }

                return thisOrder.isDesc ? protoLeft->Quality > protoRight->Quality : protoLeft->Quality < protoRight->Quality;
            }
            case AUCTION_SORT_STACK:
            {
                if (left->itemCount == right->itemCount)
                {
                    continue;
                }

                if (!thisOrder.isDesc)
                {
                    return (left->itemCount < right->itemCount);
                }

                return (left->itemCount > right->itemCount);
            }
            case AUCTION_SORT_TIMELEFT:
            {
                if (left->expire_time == right->expire_time)
                {
                    continue;
                }

                return thisOrder.isDesc ? left->expire_time > right->expire_time : left->expire_time < right->expire_time;
            }
            case AUCTION_SORT_MINBIDBUY:
            {
                if (left->buyout == right->buyout)
                {
                    if (left->startbid == right->startbid)
                    {
                        continue;
                    }

                    return thisOrder.isDesc ? left->startbid > right->startbid : left->startbid < right->startbid;
                }

                return thisOrder.isDesc ? left->buyout > right->buyout : left->buyout < right->buyout;
            }
            case AUCTION_SORT_MAX:
                // Such sad travis appeasement
            case AUCTION_SORT_UNK4:
            default:
                break;
        }
    }

    return false;
}

AuctionHouseMgr::AuctionHouseMgr()
{
}

AuctionHouseMgr::~AuctionHouseMgr()
{
    for (ItemMap::iterator itr = _mAitems.begin(); itr != _mAitems.end(); ++itr)
        delete itr->second;
}

AuctionHouseMgr* AuctionHouseMgr::instance()
{
    static AuctionHouseMgr instance;
    return &instance;
}

AuctionHouseObject* AuctionHouseMgr::GetAuctionsMap(uint32 factionTemplateId)
{
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION))
        return &_neutralAuctions;

    // team have linked auction houses
    FactionTemplateEntry const* u_entry = sFactionTemplateStore.LookupEntry(factionTemplateId);
    if (!u_entry)
        return &_neutralAuctions;
    else if (u_entry->ourMask & FACTION_MASK_ALLIANCE)
        return &_allianceAuctions;
    else if (u_entry->ourMask & FACTION_MASK_HORDE)
        return &_hordeAuctions;

    return &_neutralAuctions;
}

AuctionHouseObject* AuctionHouseMgr::GetAuctionsMapByHouseId(uint8 auctionHouseId)
{
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION))
        return &_neutralAuctions;

    switch (auctionHouseId)
    {
        case AUCTIONHOUSE_ALLIANCE:
            return &_allianceAuctions;
        case AUCTIONHOUSE_HORDE:
            return &_hordeAuctions;
            break;
    }

    return &_neutralAuctions;
}

uint32 AuctionHouseMgr::GetAuctionDeposit(AuctionHouseEntry const* entry, uint32 time, Item* pItem, uint32 count)
{
    uint32 MSV = pItem->GetTemplate()->SellPrice;

    if (MSV <= 0)
        return AH_MINIMUM_DEPOSIT * sWorld->getRate(RATE_AUCTION_DEPOSIT);

    float multiplier = CalculatePct(float(entry->depositPercent), 3);
    uint32 timeHr = (((time / 60) / 60) / 12);
    uint32 deposit = uint32(((multiplier * MSV * count / 3) * timeHr * 3) * sWorld->getRate(RATE_AUCTION_DEPOSIT));

    LOG_DEBUG("auctionHouse", "MSV:        {}", MSV);
    LOG_DEBUG("auctionHouse", "Items:      {}", count);
    LOG_DEBUG("auctionHouse", "Multiplier: {}", multiplier);
    LOG_DEBUG("auctionHouse", "Deposit:    {}", deposit);

    if (deposit < AH_MINIMUM_DEPOSIT * sWorld->getRate(RATE_AUCTION_DEPOSIT))
        return AH_MINIMUM_DEPOSIT * sWorld->getRate(RATE_AUCTION_DEPOSIT);
    else
        return deposit;
}

//does not clear ram
void AuctionHouseMgr::SendAuctionWonMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification, bool updateAchievementCriteria, bool sendMail)
{
    Item* pItem = GetAItem(auction->item_guid);
    if (!pItem)
        return;

    uint32 bidder_accId = 0;
    Player* bidder = ObjectAccessor::FindConnectedPlayer(auction->bidder);
    if (bidder)
    {
        bidder_accId = bidder->GetSession()->GetAccountId();
    }
    else
    {
        bidder_accId = sCharacterCache->GetCharacterAccountIdByGuid(auction->bidder);
    }

    // receiver exist
    if (bidder || bidder_accId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionWonMail(this, auction, bidder, bidder_accId, sendNotification, updateAchievementCriteria, sendMail);
        // set owner to bidder (to prevent delete item with sender char deleting)
        // owner in `data` will set at mail receive and item extracting
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ITEM_OWNER);
        stmt->SetData(0, auction->bidder.GetCounter());
        stmt->SetData(1, pItem->GetGUID().GetCounter());
        trans->Append(stmt);

        if (bidder)
        {
            if (sendNotification) // can be changed in the hook
                bidder->GetSession()->SendAuctionBidderNotification(auction->GetHouseId(), auction->Id, auction->bidder, 0, 0, auction->item_template);

            if (updateAchievementCriteria) // can be changed in the hook
                bidder->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_WON_AUCTIONS, 1);
        }
        else if (updateAchievementCriteria)
        {
            sAchievementMgr->UpdateAchievementCriteriaForOfflinePlayer(auction->bidder.GetCounter(), ACHIEVEMENT_CRITERIA_TYPE_WON_AUCTIONS, 1);
        }

        if (sendMail) // can be changed in the hook
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_WON), AuctionEntry::BuildAuctionMailBody(auction->owner, auction->bid, auction->buyout))
            .AddItem(pItem)
            .SendMailTo(trans, MailReceiver(bidder, auction->bidder.GetCounter()), auction, MAIL_CHECK_MASK_COPIED);
    }
    else
        sAuctionMgr->RemoveAItem(auction->item_guid, true, &trans);
}

void AuctionHouseMgr::SendAuctionSalePendingMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendMail)
{
    Player* owner = ObjectAccessor::FindConnectedPlayer(auction->owner);
    uint32 owner_accId = sCharacterCache->GetCharacterAccountIdByGuid(auction->owner);
    // owner exist (online or offline)
    if (owner || owner_accId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionSalePendingMail(this, auction, owner, owner_accId, sendMail);

        uint32 deliveryDelay = sWorld->getIntConfig(CONFIG_MAIL_DELIVERY_DELAY);

        ByteBuffer timePacker;
        timePacker.AppendPackedTime(GameTime::GetGameTime().count() + time_t(deliveryDelay));

        if (sendMail) // can be changed in the hook
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_SALE_PENDING),
                AuctionEntry::BuildAuctionMailBody(auction->bidder, auction->bid, auction->buyout, auction->deposit, auction->GetAuctionCut(), deliveryDelay, timePacker.read<uint32>()))
            .SendMailTo(trans, MailReceiver(owner, auction->owner.GetCounter()), auction, MAIL_CHECK_MASK_COPIED);
    }
}

//call this method to send mail to auction owner, when auction is successful, it does not clear ram
void AuctionHouseMgr::SendAuctionSuccessfulMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification, bool updateAchievementCriteria, bool sendMail)
{
    Player* owner = ObjectAccessor::FindConnectedPlayer(auction->owner);
    uint32 owner_accId = sCharacterCache->GetCharacterAccountIdByGuid(auction->owner);
    // owner exist
    if (owner || owner_accId)
    {
        uint32 profit = auction->bid + auction->deposit - auction->GetAuctionCut();
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionSuccessfulMail(this, auction, owner, owner_accId, profit, sendNotification, updateAchievementCriteria, sendMail);

        if (owner)
        {
            if (updateAchievementCriteria) // can be changed in the hook
            {
                owner->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GOLD_EARNED_BY_AUCTIONS, profit);
                owner->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_SOLD, auction->bid);
            }

            if (sendNotification) // can be changed in the hook
                owner->GetSession()->SendAuctionOwnerNotification(auction);
        }
        else if (updateAchievementCriteria)
        {
            sAchievementMgr->UpdateAchievementCriteriaForOfflinePlayer(auction->owner.GetCounter(), ACHIEVEMENT_CRITERIA_TYPE_GOLD_EARNED_BY_AUCTIONS, profit);
            sAchievementMgr->UpdateAchievementCriteriaForOfflinePlayer(auction->owner.GetCounter(), ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_SOLD, auction->bid);
        }

        if (sendMail) // can be changed in the hook
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_SUCCESSFUL), AuctionEntry::BuildAuctionMailBody(auction->bidder, auction->bid, auction->buyout, auction->deposit, auction->GetAuctionCut()))
            .AddMoney(profit)
            .SendMailTo(trans, MailReceiver(owner, auction->owner.GetCounter()), auction, MAIL_CHECK_MASK_COPIED, sWorld->getIntConfig(CONFIG_MAIL_DELIVERY_DELAY));

        if (auction->bid >= 500 * GOLD)
            if (CharacterCacheEntry const* gpd = sCharacterCache->GetCharacterCacheByGuid(auction->bidder))
            {
                Player* bidder = ObjectAccessor::FindConnectedPlayer(auction->bidder);
                std::string owner_name = "";
                uint8 owner_level = 0;
                if (CharacterCacheEntry const* gpd_owner = sCharacterCache->GetCharacterCacheByGuid(auction->owner))
                {
                    owner_name = gpd_owner->Name;
                    owner_level = gpd_owner->Level;
                }
                CharacterDatabase.Execute("INSERT INTO log_money VALUES({}, {}, \"{}\", \"{}\", {}, \"{}\", {}, \"profit: {}g, bidder: {} {} lvl (guid: {}), seller: {} {} lvl (guid: {}), item {} ({})\", NOW(), {})",
                    gpd->AccountId, auction->bidder.GetCounter(), gpd->Name, bidder ? bidder->GetSession()->GetRemoteAddress() : "", owner_accId, owner_name, auction->bid, (profit / GOLD), gpd->Name, gpd->Level, auction->bidder.GetCounter(), owner_name, owner_level, auction->owner.GetCounter(), auction->item_template, auction->itemCount, 2);
            }
    }
}

//does not clear ram
void AuctionHouseMgr::SendAuctionExpiredMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification, bool sendMail)
{
    //return an item in auction to its owner by mail
    Item* pItem = GetAItem(auction->item_guid);
    if (!pItem)
        return;

    Player* owner = ObjectAccessor::FindConnectedPlayer(auction->owner);
    uint32 owner_accId = sCharacterCache->GetCharacterAccountIdByGuid(auction->owner);

    // owner exist
    if (owner || owner_accId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionExpiredMail(this, auction, owner, owner_accId, sendNotification, sendMail);

        if (owner && sendNotification) // can be changed in the hook
            owner->GetSession()->SendAuctionOwnerNotification(auction);

        if (sendMail) // can be changed in the hook
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_EXPIRED), AuctionEntry::BuildAuctionMailBody(ObjectGuid::Empty, 0, auction->buyout, auction->deposit))
            .AddItem(pItem)
            .SendMailTo(trans, MailReceiver(owner, auction->owner.GetCounter()), auction, MAIL_CHECK_MASK_COPIED, 0);
    }
    else
        sAuctionMgr->RemoveAItem(auction->item_guid, true, &trans);
}

//this function sends mail to old bidder
void AuctionHouseMgr::SendAuctionOutbiddedMail(AuctionEntry* auction, uint32 newPrice, Player* newBidder, CharacterDatabaseTransaction trans, bool sendNotification, bool sendMail)
{
    Player* oldBidder = ObjectAccessor::FindConnectedPlayer(auction->bidder);

    uint32 oldBidder_accId = 0;
    if (!oldBidder)
        oldBidder_accId = sCharacterCache->GetCharacterAccountIdByGuid(auction->bidder);

    // old bidder exist
    if (oldBidder || oldBidder_accId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionOutbiddedMail(this, auction, oldBidder, oldBidder_accId, newBidder, newPrice, sendNotification, sendMail);

        if (oldBidder && newBidder && sendNotification) // can be changed in the hook
            oldBidder->GetSession()->SendAuctionBidderNotification(auction->GetHouseId(), auction->Id, newBidder->GetGUID(), newPrice, auction->GetAuctionOutBid(), auction->item_template);

        if (sendMail) // can be changed in the hook
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_OUTBIDDED), AuctionEntry::BuildAuctionMailBody(auction->owner, auction->bid, auction->buyout, auction->deposit, auction->GetAuctionCut()))
            .AddMoney(auction->bid)
            .SendMailTo(trans, MailReceiver(oldBidder, auction->bidder.GetCounter()), auction, MAIL_CHECK_MASK_COPIED);
    }
}

//this function sends mail, when auction is cancelled to old bidder
void AuctionHouseMgr::SendAuctionCancelledToBidderMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendMail)
{
    Player* bidder = ObjectAccessor::FindConnectedPlayer(auction->bidder);

    uint32 bidder_accId = 0;
    if (!bidder)
    {
        bidder_accId = sCharacterCache->GetCharacterAccountIdByGuid(auction->bidder);
    }

    // bidder exist
    if (bidder || bidder_accId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionCancelledToBidderMail(this, auction, bidder, bidder_accId, sendMail);
        if (sendMail) // can be changed in the hook
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_CANCELLED_TO_BIDDER), AuctionEntry::BuildAuctionMailBody(auction->owner, auction->bid, auction->buyout, auction->deposit))
            .AddMoney(auction->bid)
            .SendMailTo(trans, MailReceiver(bidder, auction->bidder.GetCounter()), auction, MAIL_CHECK_MASK_COPIED);
    }
}

void AuctionHouseMgr::LoadAuctionItems()
{
    uint32 oldMSTime = getMSTime();

    // need to clear in case we are reloading
    if (!_mAitems.empty())
    {
        for (ItemMap::iterator itr = _mAitems.begin(); itr != _mAitems.end(); ++itr)
            delete itr->second;

        _mAitems.clear();
    }

    // data needs to be at first place for Item::LoadFromDB
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_AUCTION_ITEMS);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 auction items. DB table `auctionhouse` or `item_instance` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        ObjectGuid::LowType item_guid = fields[11].Get<uint32>();
        uint32 item_template = fields[12].Get<uint32>();

        ItemTemplate const* proto = sObjectMgr->GetItemTemplate(item_template);
        if (!proto)
        {
            LOG_ERROR("auctionHouse", "AuctionHouseMgr::LoadAuctionItems: Unknown item (GUID: {} id: #{}) in auction, skipped.", item_guid, item_template);
            continue;
        }

        Item* item = NewItemOrBag(proto);
        if (!item->LoadFromDB(item_guid, ObjectGuid::Empty, fields, item_template))
        {
            delete item;
            continue;
        }
        AddAItem(item);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} auction items in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AuctionHouseMgr::LoadAuctions()
{
    uint32 oldMSTime = getMSTime();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_AUCTIONS);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 auctions. DB table `auctionhouse` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    do
    {
        Field* fields = result->Fetch();

        AuctionEntry* aItem = new AuctionEntry();
        if (!aItem->LoadFromDB(fields))
        {
            aItem->DeleteFromDB(trans);
            delete aItem;
            continue;
        }

        GetAuctionsMapByHouseId(aItem->houseId)->AddAuction(aItem);
        count++;
    } while (result->NextRow());

    CharacterDatabase.CommitTransaction(trans);

    LOG_INFO("server.loading", ">> Loaded {} auctions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AuctionHouseMgr::AddAItem(Item* it)
{
    ASSERT(it);
    ASSERT(_mAitems.find(it->GetGUID()) == _mAitems.end());
    _mAitems[it->GetGUID()] = it;
}

bool AuctionHouseMgr::RemoveAItem(ObjectGuid itemGuid, bool deleteFromDB, CharacterDatabaseTransaction* trans /*= nullptr*/)
{
    ItemMap::iterator i = _mAitems.find(itemGuid);
    if (i == _mAitems.end())
        return false;

    if (deleteFromDB)
    {
        ASSERT(trans);
        i->second->FSetState(ITEM_REMOVED);
        i->second->SaveToDB(*trans);
    }

    _mAitems.erase(i);
    return true;
}

void AuctionHouseMgr::Update()
{
    sScriptMgr->OnBeforeAuctionHouseMgrUpdate();
    _hordeAuctions.Update();
    _allianceAuctions.Update();
    _neutralAuctions.Update();
}

AuctionHouseEntry const* AuctionHouseMgr::GetAuctionHouseEntry(uint32 factionTemplateId)
{
    uint32 houseid = AUCTIONHOUSE_NEUTRAL; // goblin auction house

    if (!sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION))
    {
        //FIXME: found way for proper auctionhouse selection by another way
        // AuctionHouse.dbc have faction field with _player_ factions associated with auction house races.
        // but no easy way convert creature faction to player race faction for specific city
        FactionTemplateEntry const* u_entry = sFactionTemplateStore.LookupEntry(factionTemplateId);
        if (!u_entry)
            houseid = AUCTIONHOUSE_NEUTRAL; // goblin auction house
        else if (u_entry->ourMask & FACTION_MASK_ALLIANCE)
            houseid = AUCTIONHOUSE_ALLIANCE; // human auction house
        else if (u_entry->ourMask & FACTION_MASK_HORDE)
            houseid = AUCTIONHOUSE_HORDE; // orc auction house
        else
            houseid = AUCTIONHOUSE_NEUTRAL; // goblin auction house
    }

    return sAuctionHouseStore.LookupEntry(houseid);
}

AuctionHouseEntry const* AuctionHouseMgr::GetAuctionHouseEntryFromHouse(uint8 houseId)
{
    return (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION)) ? sAuctionHouseStore.LookupEntry(AUCTIONHOUSE_NEUTRAL) : sAuctionHouseStore.LookupEntry(houseId);
}

void AuctionHouseObject::AddAuction(AuctionEntry* auction)
{
    ASSERT(auction);

    _auctionsMap[auction->Id] = auction;
    sScriptMgr->OnAuctionAdd(this, auction);
}

bool AuctionHouseObject::RemoveAuction(AuctionEntry* auction)
{
    bool wasInMap = !!_auctionsMap.erase(auction->Id);

    sScriptMgr->OnAuctionRemove(this, auction);

    // we need to delete the entry, it is not referenced any more
    delete auction;
    auction = nullptr;

    return wasInMap;
}

void AuctionHouseObject::Update()
{
    time_t checkTime = GameTime::GetGameTime().count() + 60;
    ///- Handle expired auctions

    // If storage is empty, no need to update. next == nullptr in this case.
    if (_auctionsMap.empty())
        return;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    for (AuctionEntryMap::iterator itr, iter = _auctionsMap.begin(); iter != _auctionsMap.end(); )
    {
        itr = iter++;
        AuctionEntry* auction = (*itr).second;

        if (auction->expire_time > checkTime)
            continue;

        ///- Either cancel the auction if there was no bidder
        if (!auction->bidder)
        {
            sAuctionMgr->SendAuctionExpiredMail(auction, trans);
            sScriptMgr->OnAuctionExpire(this, auction);
        }
        ///- Or perform the transaction
        else
        {
            //we should send an "item sold" message if the seller is online
            //we send the item to the winner
            //we send the money to the seller
            sAuctionMgr->SendAuctionSuccessfulMail(auction, trans);
            sAuctionMgr->SendAuctionWonMail(auction, trans);
            sScriptMgr->OnAuctionSuccessful(this, auction);
        }

        ///- In any case clear the auction
        auction->DeleteFromDB(trans);

        sAuctionMgr->RemoveAItem(auction->item_guid);
        RemoveAuction(auction);
    }
    CharacterDatabase.CommitTransaction(trans);
}

void AuctionHouseObject::BuildListBidderItems(WorldPacket& data, Player* player, uint32& count, uint32& totalcount)
{
    for (AuctionEntryMap::const_iterator itr = _auctionsMap.begin(); itr != _auctionsMap.end(); ++itr)
    {
        AuctionEntry* Aentry = itr->second;
        if (Aentry && Aentry->bidder == player->GetGUID())
        {
            if (itr->second->BuildAuctionInfo(data))
                ++count;

            ++totalcount;
        }
    }
}

void AuctionHouseObject::BuildListOwnerItems(WorldPacket& data, Player* player, uint32& count, uint32& totalcount)
{
    for (AuctionEntryMap::const_iterator itr = _auctionsMap.begin(); itr != _auctionsMap.end(); ++itr)
    {
        AuctionEntry* Aentry = itr->second;
        if (Aentry && Aentry->owner == player->GetGUID())
        {
            if (Aentry->BuildAuctionInfo(data))
                ++count;

            ++totalcount;
        }
    }
}

bool AuctionHouseObject::BuildListAuctionItems(WorldPacket& data, Player* player,
        std::wstring const& wsearchedname, uint32 listfrom, uint8 levelmin, uint8 levelmax, uint8 usable,
        uint32 inventoryType, uint32 itemClass, uint32 itemSubClass, uint32 quality,
        uint32& count, uint32& totalcount, uint8 /*getAll*/, AuctionSortOrderVector const& sortOrder, Milliseconds searchTimeout)
{
    uint32 itrcounter = 0;

    // Ensures that listfrom is not greater that auctions count
    listfrom = std::min(listfrom, static_cast<uint32>(GetAuctions().size()));

    std::vector<AuctionEntry*> auctionShortlist;

    // pussywizard: optimization, this is a simplified case
    if (itemClass == 0xffffffff && itemSubClass == 0xffffffff && inventoryType == 0xffffffff && quality == 0xffffffff && levelmin == 0x00 && levelmax == 0x00 && usable == 0x00 && wsearchedname.empty())
    {
        auto itr = GetAuctionsBegin();
        for (; itr != GetAuctionsEnd(); ++itr)
        {
            auctionShortlist.push_back(itr->second);
        }
    }
    else
    {
        auto curTime = GameTime::GetGameTime();

        int loc_idx = player->GetSession()->GetSessionDbLocaleIndex();
        int locdbc_idx = player->GetSession()->GetSessionDbcLocale();

        for (AuctionEntryMap::const_iterator itr = _auctionsMap.begin(); itr != _auctionsMap.end(); ++itr)
        {
            if ((itrcounter++) % 100 == 0) // check condition every 100 iterations
            {
                if (GetMSTimeDiff(GameTime::GetGameTimeMS(), GetTimeMS()) >= searchTimeout) // pussywizard: stop immediately if diff is high or waiting too long
                {
                    return false;
                }
            }

            AuctionEntry* Aentry = itr->second;
            if (!Aentry)
                return false;

            // Skip expired auctions
            if (Aentry->expire_time < curTime.count())
            {
                continue;
            }

            Item* item = sAuctionMgr->GetAItem(Aentry->item_guid);
            if (!item)
            {
                continue;
            }

            ItemTemplate const* proto = item->GetTemplate();
            if (itemClass != 0xffffffff && proto->Class != itemClass)
            {
                continue;
            }

            if (itemSubClass != 0xffffffff && proto->SubClass != itemSubClass)
            {
                continue;
            }

            if (inventoryType != 0xffffffff && proto->InventoryType != inventoryType)
            {
                // xinef: exception, robes are counted as chests
                if (inventoryType != INVTYPE_CHEST || proto->InventoryType != INVTYPE_ROBE)
                {
                    continue;
                }
            }

            if (quality != 0xffffffff && proto->Quality < quality)
            {
                continue;
            }

            if (levelmin != 0x00 && (proto->RequiredLevel < levelmin || (levelmax != 0x00 && proto->RequiredLevel > levelmax)))
            {
                continue;
            }

            if (usable != 0x00)
            {
                if (player->CanUseItem(item) != EQUIP_ERR_OK)
                {
                    continue;
                }

                // xinef: check already learded recipes and pets
                if (proto->Spells[1].SpellTrigger == ITEM_SPELLTRIGGER_LEARN_SPELL_ID && player->HasSpell(proto->Spells[1].SpellId))
                {
                    continue;
                }
            }

            // Allow search by suffix (ie: of the Monkey) or partial name (ie: Monkey)
            // No need to do any of this if no search term was entered
            if (!wsearchedname.empty())
            {
                std::string name = proto->Name1;
                if (name.empty())
                {
                    continue;
                }

                // local name
                if (loc_idx >= 0)
                    if (ItemLocale const* il = sObjectMgr->GetItemLocale(proto->ItemId))
                        ObjectMgr::GetLocaleString(il->Name, loc_idx, name);

                // DO NOT use GetItemEnchantMod(proto->RandomProperty) as it may return a result
                //  that matches the search but it may not equal item->GetItemRandomPropertyId()
                //  used in BuildAuctionInfo() which then causes wrong items to be listed
                int32 propRefID = item->GetItemRandomPropertyId();

                if (propRefID)
                {
                    // Append the suffix to the name (ie: of the Monkey) if one exists
                    // These are found in ItemRandomSuffix.dbc and ItemRandomProperties.dbc
                    // even though the DBC name seems misleading
                    std::array<char const*, 16> const* suffix = nullptr;

                    if (propRefID < 0)
                    {
                        ItemRandomSuffixEntry const* itemRandEntry = sItemRandomSuffixStore.LookupEntry(-item->GetItemRandomPropertyId());
                        if (itemRandEntry)
                            suffix = &itemRandEntry->Name;
                    }
                    else
                    {
                        ItemRandomPropertiesEntry const* itemRandEntry = sItemRandomPropertiesStore.LookupEntry(item->GetItemRandomPropertyId());
                        if (itemRandEntry)
                            suffix = &itemRandEntry->Name;
                    }

                    // dbc local name
                    if (suffix)
                    {
                        // Append the suffix (ie: of the Monkey) to the name using localization
                        // or default enUS if localization is invalid
                        name += ' ';
                        name += (*suffix)[locdbc_idx >= 0 ? locdbc_idx : LOCALE_enUS];
                    }
                }

                // Perform the search (with or without suffix)
                if (!Utf8FitTo(name, wsearchedname))
                {
                    continue;
                }
            }

            auctionShortlist.push_back(Aentry);
        }
    }

    if (auctionShortlist.empty())
    {
        return true;
    }

    // Check if sort enabled, and first sort column is valid, if not don't sort
    if (!sortOrder.empty())
    {
        AuctionSortInfo const& sortInfo = *sortOrder.begin();
        if (sortInfo.sortOrder >= AUCTION_SORT_MINLEVEL && sortInfo.sortOrder < AUCTION_SORT_MAX && sortInfo.sortOrder != AUCTION_SORT_UNK4)
        {
            // Partial sort to improve performance a bit, but the last pages will burn
            if (listfrom + 50 <= auctionShortlist.size())
            {
                std::partial_sort(auctionShortlist.begin(), auctionShortlist.begin() + listfrom + 50, auctionShortlist.end(),
                    std::bind(SortAuction, std::placeholders::_1, std::placeholders::_2, sortOrder, player, sortInfo.sortOrder == AUCTION_SORT_BID));
            }
            else
            {
                std::sort(auctionShortlist.begin(), auctionShortlist.end(), std::bind(SortAuction, std::placeholders::_1, std::placeholders::_2, sortOrder,
                    player, sortInfo.sortOrder == AUCTION_SORT_BID));
            }
        }
    }

    for (auto& auction : auctionShortlist)
    {
        // Add the item if no search term or if entered search term was found
        if (count < 50 && totalcount >= listfrom)
        {
            Item* item = sAuctionMgr->GetAItem(auction->item_guid);
            if (!item)
            {
                continue;
            }

            ++count;
            auction->BuildAuctionInfo(data);
        }
        ++totalcount;
    }

    return true;
}

//this function inserts to WorldPacket auction's data
bool AuctionEntry::BuildAuctionInfo(WorldPacket& data) const
{
    Item* item = sAuctionMgr->GetAItem(item_guid);
    if (!item)
    {
        LOG_ERROR("auctionHouse", "AuctionEntry::BuildAuctionInfo: Auction {} has a non-existent item: {}", Id, item_guid.ToString());
        return false;
    }
    data << uint32(Id);
    data << uint32(item->GetEntry());

    for (uint8 i = 0; i < MAX_INSPECTED_ENCHANTMENT_SLOT; ++i)
    {
        data << uint32(item->GetEnchantmentId(EnchantmentSlot(i)));
        data << uint32(item->GetEnchantmentDuration(EnchantmentSlot(i)));
        data << uint32(item->GetEnchantmentCharges(EnchantmentSlot(i)));
    }

    data << int32(item->GetItemRandomPropertyId());                 // Random item property id
    data << uint32(item->GetItemSuffixFactor());                    // SuffixFactor
    data << uint32(item->GetCount());                               // item->count
    data << uint32(item->GetSpellCharges());                        // item->charge FFFFFFF
    data << uint32(0);                                              // Unknown
    data << owner;                                                  // Auction->owner
    data << uint32(startbid);                                       // Auction->startbid (not sure if useful)
    data << uint32(bid ? GetAuctionOutBid() : 0);
    // Minimal outbid
    data << uint32(buyout);                                         // Auction->buyout
    data << uint32((expire_time - GameTime::GetGameTime().count()) * IN_MILLISECONDS); // time left
    data << bidder;                                                 // auction->bidder current
    data << uint32(bid);                                            // current bid
    return true;
}

uint32 AuctionEntry::GetAuctionCut() const
{
    int32 cut = int32(CalculatePct(bid, auctionHouseEntry->cutPercent) * sWorld->getRate(RATE_AUCTION_CUT));
    return std::max(cut, 0);
}

/// the sum of outbid is (1% from current bid)*5, if bid is very small, it is 1c
uint32 AuctionEntry::GetAuctionOutBid() const
{
    uint32 outbid = CalculatePct(bid, 5);
    return outbid ? outbid : 1;
}

void AuctionEntry::DeleteFromDB(CharacterDatabaseTransaction trans) const
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_AUCTION);
    stmt->SetData(0, Id);
    trans->Append(stmt);
}

void AuctionEntry::SaveToDB(CharacterDatabaseTransaction trans) const
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_AUCTION);
    stmt->SetData(0, Id);
    stmt->SetData(1, houseId);
    stmt->SetData(2, item_guid.GetCounter());
    stmt->SetData(3, owner.GetCounter());
    stmt->SetData (4, buyout);
    stmt->SetData(5, uint32(expire_time));
    stmt->SetData(6, bidder.GetCounter());
    stmt->SetData (7, bid);
    stmt->SetData (8, startbid);
    stmt->SetData (9, deposit);
    trans->Append(stmt);
}

bool AuctionEntry::LoadFromDB(Field* fields)
{
    Id = fields[0].Get<uint32>();
    houseId = fields[1].Get<uint8>();
    item_guid = ObjectGuid::Create<HighGuid::Item>(fields[2].Get<uint32>());
    item_template = fields[3].Get<uint32>();
    itemCount = fields[4].Get<uint32>();
    owner = ObjectGuid::Create<HighGuid::Player>(fields[5].Get<uint32>());
    buyout = fields[6].Get<uint32>();
    expire_time = fields[7].Get<uint32>();
    bidder = ObjectGuid::Create<HighGuid::Player>(fields[8].Get<uint32>());
    bid = fields[9].Get<uint32>();
    startbid = fields[10].Get<uint32>();
    deposit = fields[11].Get<uint32>();

    auctionHouseEntry = AuctionHouseMgr::GetAuctionHouseEntryFromHouse(houseId);
    if (!auctionHouseEntry)
    {
        LOG_ERROR("auctionHouse", "Auction {} has invalid house id {}", Id, houseId);
        return false;
    }

    // check if sold item exists for guid
    // and item_template in fact (GetAItem will fail if problematic in result check in AuctionHouseMgr::LoadAuctionItems)
    if (!sAuctionMgr->GetAItem(item_guid))
    {
        LOG_ERROR("auctionHouse", "Auction {} has not a existing item : {}", Id, item_guid.ToString());
        return false;
    }
    return true;
}

std::string AuctionEntry::BuildAuctionMailSubject(MailAuctionAnswers response) const
{
    std::ostringstream strm;
    strm << item_template << ":0:" << response << ':' << Id << ':' << itemCount;
    return strm.str();
}

std::string AuctionEntry::BuildAuctionMailBody(ObjectGuid guid, uint32 bid, uint32 buyout, uint32 deposit /*= 0*/, uint32 cut /*= 0*/, uint32 moneyDelay /*= 0*/, uint32 eta /*= 0*/)
{
    std::ostringstream strm;
    strm.width(16);
    strm << std::right << std::hex << guid.GetRawValue();
    strm << std::dec << ':' << bid << ':' << buyout;
    strm << ':' << deposit << ':' << cut;
    strm << ':' << moneyDelay << ':' << eta;
    return strm.str();
}
