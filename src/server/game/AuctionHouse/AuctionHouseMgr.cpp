/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "AccountMgr.h"
#include "AsyncAuctionListing.h"
#include "AuctionHouseMgr.h"
#include "AvgDiffTracker.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "Item.h"
#include "Logging/Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include <vector>

constexpr auto AH_MINIMUM_DEPOSIT = 100;

AuctionHouseMgr::AuctionHouseMgr()
{
}

AuctionHouseMgr::~AuctionHouseMgr()
{
    for (ItemMap::iterator itr = mAitems.begin(); itr != mAitems.end(); ++itr)
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
        return &mNeutralAuctions;

    // team have linked auction houses
    FactionTemplateEntry const* u_entry = sFactionTemplateStore.LookupEntry(factionTemplateId);
    if (!u_entry)
        return &mNeutralAuctions;
    else if (u_entry->ourMask & FACTION_MASK_ALLIANCE)
        return &mAllianceAuctions;
    else if (u_entry->ourMask & FACTION_MASK_HORDE)
        return &mHordeAuctions;

    return &mNeutralAuctions;
}

AuctionHouseObject* AuctionHouseMgr::GetAuctionsMapByHouseId(uint8 auctionHouseId)
{
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION))
        return &mNeutralAuctions;

    switch(auctionHouseId)
    {
        case AUCTIONHOUSE_ALLIANCE:
            return &mAllianceAuctions;
        case AUCTIONHOUSE_HORDE:
            return &mHordeAuctions;
            break;
    }

    return &mNeutralAuctions;

}

uint32 AuctionHouseMgr::GetAuctionDeposit(AuctionHouseEntry const* entry, uint32 time, Item* pItem, uint32 count)
{
    uint32 MSV = pItem->GetTemplate()->SellPrice;

    if (MSV <= 0)
        return AH_MINIMUM_DEPOSIT * sWorld->getRate(RATE_AUCTION_DEPOSIT);

    float multiplier = CalculatePct(float(entry->depositPercent), 3);
    uint32 timeHr = (((time / 60) / 60) / 12);
    uint32 deposit = uint32(((multiplier * MSV * count / 3) * timeHr * 3) * sWorld->getRate(RATE_AUCTION_DEPOSIT));

    LOG_DEBUG("auctionHouse", "MSV:        %u", MSV);
    LOG_DEBUG("auctionHouse", "Items:      %u", count);
    LOG_DEBUG("auctionHouse", "Multiplier: %f", multiplier);
    LOG_DEBUG("auctionHouse", "Deposit:    %u", deposit);

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
        bidder_accId = bidder->GetSession()->GetAccountId();
    else
        bidder_accId = sObjectMgr->GetPlayerAccountIdByGUID(auction->bidder.GetCounter());

    // receiver exist
    if (bidder || bidder_accId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionWonMail(this, auction, bidder, bidder_accId, sendNotification, updateAchievementCriteria, sendMail);
        // set owner to bidder (to prevent delete item with sender char deleting)
        // owner in `data` will set at mail receive and item extracting
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ITEM_OWNER);
        stmt->setUInt32(0, auction->bidder.GetCounter());
        stmt->setUInt32(1, pItem->GetGUID().GetCounter());
        trans->Append(stmt);

        if (bidder)
        {
            if (sendNotification) // can be changed in the hook
                bidder->GetSession()->SendAuctionBidderNotification(auction->GetHouseId(), auction->Id, auction->bidder, 0, 0, auction->item_template);
            // FIXME: for offline player need also
            if (updateAchievementCriteria) // can be changed in the hook
                bidder->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_WON_AUCTIONS, 1);
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
    uint32 owner_accId = sObjectMgr->GetPlayerAccountIdByGUID(auction->owner.GetCounter());
    // owner exist (online or offline)
    if (owner || owner_accId)
    {
        sScriptMgr->OnBeforeAuctionHouseMgrSendAuctionSalePendingMail(this, auction, owner, owner_accId, sendMail);

        uint32 deliveryDelay = sWorld->getIntConfig(CONFIG_MAIL_DELIVERY_DELAY);

        ByteBuffer timePacker;
        timePacker.AppendPackedTime(time_t(time(nullptr) + deliveryDelay));

        if (sendMail) // can be changed in the hook
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_SALE_PENDING),
                AuctionEntry::BuildAuctionMailBody(auction->bidder, auction->bid, auction->buyout, auction->deposit, auction->GetAuctionCut(), deliveryDelay, timePacker.read<uint32>()))
            .SendMailTo(trans, MailReceiver(owner, auction->owner.GetCounter()), auction, MAIL_CHECK_MASK_COPIED, 0, 0, false, true, -static_cast<int32>(auction->Id));
    }
}

//call this method to send mail to auction owner, when auction is successful, it does not clear ram
void AuctionHouseMgr::SendAuctionSuccessfulMail(AuctionEntry* auction, CharacterDatabaseTransaction trans, bool sendNotification, bool updateAchievementCriteria, bool sendMail)
{
    Player* owner = ObjectAccessor::FindConnectedPlayer(auction->owner);
    uint32 owner_accId = sObjectMgr->GetPlayerAccountIdByGUID(auction->owner.GetCounter());
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

        if (sendMail) // can be changed in the hook
            MailDraft(auction->BuildAuctionMailSubject(AUCTION_SUCCESSFUL), AuctionEntry::BuildAuctionMailBody(auction->bidder, auction->bid, auction->buyout, auction->deposit, auction->GetAuctionCut()))
            .AddMoney(profit)
            .SendMailTo(trans, MailReceiver(owner, auction->owner.GetCounter()), auction, MAIL_CHECK_MASK_COPIED, sWorld->getIntConfig(CONFIG_MAIL_DELIVERY_DELAY), 0, false, true, auction->Id);

        if (auction->bid >= 500 * GOLD)
            if (const GlobalPlayerData* gpd = sWorld->GetGlobalPlayerData(auction->bidder.GetCounter()))
            {
                Player* bidder = ObjectAccessor::FindConnectedPlayer(auction->bidder);
                std::string owner_name = "";
                uint8 owner_level = 0;
                if (const GlobalPlayerData* gpd_owner = sWorld->GetGlobalPlayerData(auction->owner.GetCounter()))
                {
                    owner_name = gpd_owner->name;
                    owner_level = gpd_owner->level;
                }
                CharacterDatabase.PExecute("INSERT INTO log_money VALUES(%u, %u, \"%s\", \"%s\", %u, \"%s\", %u, \"<AH> profit: %ug, bidder: %s %u lvl (guid: %u), seller: %s %u lvl (guid: %u), item %u (%u)\", NOW())",
                    gpd->accountId, auction->bidder.GetCounter(), gpd->name.c_str(), bidder ? bidder->GetSession()->GetRemoteAddress().c_str() : "", owner_accId, owner_name.c_str(), auction->bid, (profit / GOLD), gpd->name.c_str(), gpd->level, auction->bidder.GetCounter(), owner_name.c_str(), owner_level, auction->owner.GetCounter(), auction->item_template, auction->itemCount);
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
    uint32 owner_accId = sObjectMgr->GetPlayerAccountIdByGUID(auction->owner.GetCounter());

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
        oldBidder_accId = sObjectMgr->GetPlayerAccountIdByGUID(auction->bidder.GetCounter());

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
        bidder_accId = sObjectMgr->GetPlayerAccountIdByGUID(auction->bidder.GetCounter());

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
    if (!mAitems.empty())
    {
        for (ItemMap::iterator itr = mAitems.begin(); itr != mAitems.end(); ++itr)
            delete itr->second;

        mAitems.clear();
    }

    // data needs to be at first place for Item::LoadFromDB
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_AUCTION_ITEMS);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 auction items. DB table `auctionhouse` or `item_instance` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        ObjectGuid::LowType item_guid = fields[11].GetUInt32();
        uint32 item_template = fields[12].GetUInt32();

        ItemTemplate const* proto = sObjectMgr->GetItemTemplate(item_template);
        if (!proto)
        {
            LOG_ERROR("auctionHouse", "AuctionHouseMgr::LoadAuctionItems: Unknown item (GUID: %u id: #%u) in auction, skipped.", item_guid, item_template);
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

    LOG_INFO("server.loading", ">> Loaded %u auction items in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AuctionHouseMgr::LoadAuctions()
{
    uint32 oldMSTime = getMSTime();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_AUCTIONS);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 auctions. DB table `auctionhouse` is empty.");
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

    LOG_INFO("server.loading", ">> Loaded %u auctions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AuctionHouseMgr::AddAItem(Item* it)
{
    ASSERT(it);
    ASSERT(mAitems.find(it->GetGUID()) == mAitems.end());
    mAitems[it->GetGUID()] = it;
}

bool AuctionHouseMgr::RemoveAItem(ObjectGuid itemGuid, bool deleteFromDB, CharacterDatabaseTransaction* trans /*= nullptr*/)
{
    ItemMap::iterator i = mAitems.find(itemGuid);
    if (i == mAitems.end())
        return false;

    if (deleteFromDB)
    {
        ASSERT(trans);
        i->second->FSetState(ITEM_REMOVED);
        i->second->SaveToDB(*trans);
    }

    mAitems.erase(i);
    return true;
}

void AuctionHouseMgr::Update()
{
    sScriptMgr->OnBeforeAuctionHouseMgrUpdate();
    mHordeAuctions.Update();
    mAllianceAuctions.Update();
    mNeutralAuctions.Update();
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

    AuctionsMap[auction->Id] = auction;
    sScriptMgr->OnAuctionAdd(this, auction);
}

bool AuctionHouseObject::RemoveAuction(AuctionEntry* auction)
{
    bool wasInMap = !!AuctionsMap.erase(auction->Id);

    sScriptMgr->OnAuctionRemove(this, auction);

    // we need to delete the entry, it is not referenced any more
    delete auction;
    auction = nullptr;

    return wasInMap;
}

void AuctionHouseObject::Update()
{
    time_t checkTime = sWorld->GetGameTime() + 60;
    ///- Handle expired auctions

    // If storage is empty, no need to update. next == nullptr in this case.
    if (AuctionsMap.empty())
        return;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    for (AuctionEntryMap::iterator itr, iter = AuctionsMap.begin(); iter != AuctionsMap.end(); )
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
    for (AuctionEntryMap::const_iterator itr = AuctionsMap.begin(); itr != AuctionsMap.end(); ++itr)
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
    for (AuctionEntryMap::const_iterator itr = AuctionsMap.begin(); itr != AuctionsMap.end(); ++itr)
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
        uint32& count, uint32& totalcount, uint8  /*getAll*/)
{
    uint32 itrcounter = 0;

    // pussywizard: optimization, this is a simplified case
    if (itemClass == 0xffffffff && itemSubClass == 0xffffffff && inventoryType == 0xffffffff && quality == 0xffffffff && levelmin == 0x00 && levelmax == 0x00 && usable == 0x00 && wsearchedname.empty())
    {
        totalcount = Getcount();
        if (listfrom < totalcount)
        {
            AuctionEntryMap::iterator itr = AuctionsMap.begin();
            std::advance(itr, listfrom);
            for (; itr != AuctionsMap.end(); ++itr)
            {
                itr->second->BuildAuctionInfo(data);
                if ((++count) >= 50)
                    break;
            }
        }
        return true;
    }

    time_t curTime = sWorld->GetGameTime();

    int loc_idx = player->GetSession()->GetSessionDbLocaleIndex();
    int locdbc_idx = player->GetSession()->GetSessionDbcLocale();

    for (AuctionEntryMap::const_iterator itr = AuctionsMap.begin(); itr != AuctionsMap.end(); ++itr)
    {
        if (!AsyncAuctionListingMgr::IsAuctionListingAllowed()) // pussywizard: World::Update is waiting for us...
            if ((itrcounter++) % 100 == 0) // check condition every 100 iterations
                if (avgDiffTracker.getAverage() >= 30 || getMSTimeDiff(World::GetGameTimeMS(), getMSTime()) >= 10) // pussywizard: stop immediately if diff is high or waiting too long
                    return false;

        AuctionEntry* Aentry = itr->second;
        // Skip expired auctions
        if (Aentry->expire_time < curTime)
            continue;

        Item* item = sAuctionMgr->GetAItem(Aentry->item_guid);
        if (!item)
            continue;

        ItemTemplate const* proto = item->GetTemplate();

        if (itemClass != 0xffffffff && proto->Class != itemClass)
            continue;

        if (itemSubClass != 0xffffffff && proto->SubClass != itemSubClass)
            continue;

        if (inventoryType != 0xffffffff && proto->InventoryType != inventoryType)
        {
            // xinef: exception, robes are counted as chests
            if (inventoryType != INVTYPE_CHEST || proto->InventoryType != INVTYPE_ROBE)
                continue;
        }

        if (quality != 0xffffffff && proto->Quality < quality)
            continue;

        if (levelmin != 0x00 && (proto->RequiredLevel < levelmin || (levelmax != 0x00 && proto->RequiredLevel > levelmax)))
            continue;

        if (usable != 0x00)
        {
            if (player->CanUseItem(item) != EQUIP_ERR_OK)
                continue;

            // xinef: check already learded recipes and pets
            if (proto->Spells[1].SpellTrigger == ITEM_SPELLTRIGGER_LEARN_SPELL_ID && player->HasSpell(proto->Spells[1].SpellId))
                continue;
        }

        // Allow search by suffix (ie: of the Monkey) or partial name (ie: Monkey)
        // No need to do any of this if no search term was entered
        if (!wsearchedname.empty())
        {
            std::string name = proto->Name1;
            if (name.empty())
                continue;

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
                //  even though the DBC name seems misleading

                char* const* suffix = nullptr;

                if (propRefID < 0)
                {
                    const ItemRandomSuffixEntry* itemRandEntry = sItemRandomSuffixStore.LookupEntry(-item->GetItemRandomPropertyId());
                    if (itemRandEntry)
                        suffix = itemRandEntry->nameSuffix;
                }
                else
                {
                    const ItemRandomPropertiesEntry* itemRandEntry = sItemRandomPropertiesStore.LookupEntry(item->GetItemRandomPropertyId());
                    if (itemRandEntry)
                        suffix = itemRandEntry->nameSuffix;
                }

                // dbc local name
                if (suffix)
                {
                    // Append the suffix (ie: of the Monkey) to the name using localization
                    // or default enUS if localization is invalid
                    name += ' ';
                    name += suffix[locdbc_idx >= 0 ? locdbc_idx : LOCALE_enUS];
                }
            }

            // Perform the search (with or without suffix)
            if (!Utf8FitTo(name, wsearchedname))
                continue;
        }

        // Add the item if no search term or if entered search term was found
        if (count < 50 && totalcount >= listfrom)
        {
            ++count;
            Aentry->BuildAuctionInfo(data);
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
        LOG_ERROR("auctionHouse", "AuctionEntry::BuildAuctionInfo: Auction %u has a non-existent item: %s", Id, item_guid.ToString().c_str());
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
    data << uint32((expire_time - time(nullptr)) * IN_MILLISECONDS); // time left
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
    stmt->setUInt32(0, Id);
    trans->Append(stmt);
}

void AuctionEntry::SaveToDB(CharacterDatabaseTransaction trans) const
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_AUCTION);
    stmt->setUInt32(0, Id);
    stmt->setUInt8(1, houseId);
    stmt->setUInt32(2, item_guid.GetCounter());
    stmt->setUInt32(3, owner.GetCounter());
    stmt->setUInt32 (4, buyout);
    stmt->setUInt32(5, uint32(expire_time));
    stmt->setUInt32(6, bidder.GetCounter());
    stmt->setUInt32 (7, bid);
    stmt->setUInt32 (8, startbid);
    stmt->setUInt32 (9, deposit);
    trans->Append(stmt);
}

bool AuctionEntry::LoadFromDB(Field* fields)
{
    Id = fields[0].GetUInt32();
    houseId = fields[1].GetUInt8();
    item_guid = ObjectGuid::Create<HighGuid::Item>(fields[2].GetUInt32());
    item_template = fields[3].GetUInt32();
    itemCount = fields[4].GetUInt32();
    owner = ObjectGuid::Create<HighGuid::Player>(fields[5].GetUInt32());
    buyout = fields[6].GetUInt32();
    expire_time = fields[7].GetUInt32();
    bidder = ObjectGuid::Create<HighGuid::Player>(fields[8].GetUInt32());
    bid = fields[9].GetUInt32();
    startbid = fields[10].GetUInt32();
    deposit = fields[11].GetUInt32();

    auctionHouseEntry = AuctionHouseMgr::GetAuctionHouseEntryFromHouse(houseId);
    if (!auctionHouseEntry)
    {
        LOG_ERROR("auctionHouse", "Auction %u has invalid house id %u", Id, houseId);
        return false;
    }

    // check if sold item exists for guid
    // and item_template in fact (GetAItem will fail if problematic in result check in AuctionHouseMgr::LoadAuctionItems)
    if (!sAuctionMgr->GetAItem(item_guid))
    {
        LOG_ERROR("auctionHouse", "Auction %u has not a existing item : %s", Id, item_guid.ToString().c_str());
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
