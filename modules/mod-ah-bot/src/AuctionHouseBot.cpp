/*
 * Copyright (C) 2008-2010 Trinity <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include "ObjectMgr.h"
#include "AuctionHouseMgr.h"
#include "Config.h"
#include "Player.h"
#include "WorldSession.h"
#include "GameTime.h"
#include "DatabaseEnv.h"
#include "ScriptMgr.h"

#include "AuctionHouseBot.h"
#include "AuctionHouseBotCommon.h"
#include "AuctionHouseSearcher.h"

using namespace std;

AuctionHouseBot::AuctionHouseBot(uint32 account, uint32 id)
{
    _account        = account;
    _id             = id;

    _lastrun_a_sec  = time(NULL);
    _lastrun_h_sec  = time(NULL);
    _lastrun_n_sec  = time(NULL);

    _allianceConfig = NULL;
    _hordeConfig    = NULL;
    _neutralConfig  = NULL;
}

AuctionHouseBot::~AuctionHouseBot()
{
    // Nothing
}

uint32 AuctionHouseBot::getElement(std::set<uint32> set, int index, uint32 botId, uint32 maxDup, AuctionHouseObject* auctionHouse)
{
    std::set<uint32>::iterator it = set.begin();
    std::advance(it, index);

    if (maxDup > 0)
    {
        uint32 noStacks = 0;

        for (AuctionHouseObject::AuctionEntryMap::const_iterator itr = auctionHouse->GetAuctionsBegin(); itr != auctionHouse->GetAuctionsEnd(); ++itr)
        {
            AuctionEntry* Aentry = itr->second;

            if (Aentry->owner.GetCounter() == botId)
            {
                if (*it == Aentry->item_template)
                {
                    noStacks++;
                }
            }
        }

        if (noStacks >= maxDup)
        {
            return 0;
        }
    }

    return *it;
}

uint32 AuctionHouseBot::getStackCount(AHBConfig* config, uint32 max)
{
    if (max == 1)
    {
        return 1;
    }

    // 
    // Organize the stacks in a pseudo random way
    // 

    if (config->DivisibleStacks)
    {
        uint32 ret = 0;

        if (max % 5 == 0) // 5, 10, 15, 20
        {
            ret = urand(1, 4) * 5;
        }

        if (max % 4 == 0) // 4, 8, 12, 16
        {
            ret = urand(1, 4) * 4;
        }

        if (max % 3 == 0) // 3, 6, 9, 18
        {
            ret = urand(1, 3) * 3;
        }

        if (ret > max)
        {
            ret = max;
        }

        return ret;
    }

    // 
    // Totally random
    // 

    return urand(1, max);
}

uint32 AuctionHouseBot::getElapsedTime(uint32 timeClass)
{
    switch (timeClass)
    {
    case 2:
        return urand(1, 5) * 600;   // SHORT = In the range of one hour

    case 1:
        return urand(1, 23) * 3600; // MEDIUM = In the range of one day

    default:
        return urand(1, 3) * 86400; // LONG = More than one day but less than three
    }
}

uint32 AuctionHouseBot::getNofAuctions(AHBConfig* config, AuctionHouseObject* auctionHouse, ObjectGuid guid)
{
    //
    // All the auctions
    //

    if (!config->ConsiderOnlyBotAuctions)
    {
        return auctionHouse->Getcount();
    }

    //
    // Just the one handled by the bot
    //

    uint32 count = 0;

    for (AuctionHouseObject::AuctionEntryMap::const_iterator itr = auctionHouse->GetAuctionsBegin(); itr != auctionHouse->GetAuctionsEnd(); ++itr)
    {
        AuctionEntry* Aentry = itr->second;

        if (guid == Aentry->owner)
        {
            count++;
        }
    }

    return count;
}

// =============================================================================
// This routine performs the bidding/buyout operations for the bot
// =============================================================================

void AuctionHouseBot::Buy(Player* AHBplayer, AHBConfig* config, WorldSession* session)
{
    //
    // Check if disabled
    //

    if (!config->AHBBuyer)
    {
        return;
    }

    //
    // Retrieve items not owned by the bot and not bought/bidded on by the bot
    //

    QueryResult ahContentQueryResult = CharacterDatabase.Query("SELECT id FROM auctionhouse WHERE houseid={} AND itemowner<>{} AND buyguid<>{}", config->GetAHID(), _id, _id);

    if (!ahContentQueryResult)
    {
        return;
    }

    if (ahContentQueryResult->GetRowCount() == 0)
    {
        return;
    }

    if (config->DebugOutBuyer)
    {
        LOG_INFO("module", "AHBot [{}]: Performing Buy operations for AH={} nbOfAuctions={}", _id, config->GetAHID(), ahContentQueryResult->GetRowCount());
    }

    //
    // Fetches content of selected AH to look for possible bids
    //

    AuctionHouseObject* auctionHouseObject = sAuctionMgr->GetAuctionsMap(config->GetAHFID());
    std::vector<uint32> auctionsGuidsToConsider;

    do
    {
        uint32 autionGuid = ahContentQueryResult->Fetch()->Get<uint32>();
        auctionsGuidsToConsider.push_back(autionGuid);
    } while (ahContentQueryResult->NextRow());

    //
    // If it's not possible to bid stop here
    //

    if (auctionsGuidsToConsider.empty())
    {
        if (config->DebugOutBuyer)
        {
            LOG_INFO("module", "AHBot [{}]: no auctions to bid on has been recovered", _id);
        }

        return;
    }

    //
    // Perform the operation for a maximum amount of bids attempts configured
    //

    if (config->TraceBuyer)
    {
        LOG_INFO("module", "AHBot [{}]: Considering {} auctions per interval to bid on.", _id, config->GetBidsPerInterval());
    }

    for (
        uint32 count = 1;
        count <= config->GetBidsPerInterval() && !auctionsGuidsToConsider.empty();
        ++count
    ) {
        //
        // Choose a random auction from possible auctions
        //

        uint32 randomIndex = urand(0, auctionsGuidsToConsider.size() - 1);

        std::vector<uint32>::iterator itBegin = auctionsGuidsToConsider.begin();
        //std::advance(it, randomIndex);

        uint32 auctionID = auctionsGuidsToConsider.at(randomIndex);

        AuctionEntry* auction = auctionHouseObject->GetAuction(auctionID);

        //
        // Prevent to bid again on the same auction
        //

        auctionsGuidsToConsider.erase(itBegin + randomIndex);

        if (!auction)
        {
            if (config->DebugOutBuyer)
            {
                LOG_ERROR("module", "AHBot [{}]: Auction id: {} Possible entry to buy/bid from AH pool is invalid, this should not happen, moving on next auciton", _id, auctionID);
            }
            continue;
        }

        //
        // Prevent from buying items from the other bots
        //

        if (gBotsId.find(auction->owner.GetCounter()) != gBotsId.end())
        {
            continue;
        }

        //
        // Get the item information
        //

        Item* pItem = sAuctionMgr->GetAItem(auction->item_guid);

        if (!pItem)
        {
            if (config->DebugOutBuyer)
            {
                LOG_ERROR("module", "AHBot [{}]: item {} doesn't exist, perhaps bought already?", _id, auction->item_guid.ToString());
            }

            continue;
        }

        //
        // Get the item prototype
        //

        ItemTemplate const* prototype = sObjectMgr->GetItemTemplate(auction->item_template);


        //
        // Determine current price.
        //
        uint32 currentPrice = auction->bid ? auction->bid : auction->startbid;

        //
        // Determine maximum bid and skip auctions with too high a currentPrice.
        //

        double basePrice = config->UseBuyPriceForBuyer ? prototype->BuyPrice : prototype->SellPrice;
        double maximumBid = basePrice * pItem->GetCount() * config->GetBuyerPrice(prototype->Quality);

        if (config->TraceBuyer)
        {
            LOG_INFO("module", "-------------------------------------------------");
            LOG_INFO("module", "AHBot [{}]: Info for Auction #{}:", _id, auction->Id);
            LOG_INFO("module", "AHBot [{}]: AuctionHouse: {}", _id, auction->GetHouseId());
            LOG_INFO("module", "AHBot [{}]: Owner: {}", _id, auction->owner.ToString());
            LOG_INFO("module", "AHBot [{}]: Bidder: {}", _id, auction->bidder.ToString());
            LOG_INFO("module", "AHBot [{}]: Starting Bid: {}", _id, auction->startbid);
            LOG_INFO("module", "AHBot [{}]: Current Bid: {}", _id, currentPrice);
            LOG_INFO("module", "AHBot [{}]: Buyout: {}", _id, auction->buyout);
            LOG_INFO("module", "AHBot [{}]: Deposit: {}", _id, auction->deposit);
            LOG_INFO("module", "AHBot [{}]: Expire Time: {}", _id, uint32(auction->expire_time));
            LOG_INFO("module", "AHBot [{}]: Bid Max: {}", _id, maximumBid);
            LOG_INFO("module", "AHBot [{}]: Item GUID: {}", _id, auction->item_guid.ToString());
            LOG_INFO("module", "AHBot [{}]: Item Template: {}", _id, auction->item_template);
            LOG_INFO("module", "AHBot [{}]: Item ID: {}", _id, prototype->ItemId);
            LOG_INFO("module", "AHBot [{}]: Buy Price: {}", _id, prototype->BuyPrice);
            LOG_INFO("module", "AHBot [{}]: Sell Price: {}", _id, prototype->SellPrice);
            LOG_INFO("module", "AHBot [{}]: Bonding: {}", _id, prototype->Bonding);
            LOG_INFO("module", "AHBot [{}]: Quality: {}", _id, prototype->Quality);
            LOG_INFO("module", "AHBot [{}]: Item Level: {}", _id, prototype->ItemLevel);
            LOG_INFO("module", "AHBot [{}]: Ammo Type: {}", _id, prototype->AmmoType);
            LOG_INFO("module", "-------------------------------------------------");
        }

        if (currentPrice > maximumBid)
        {
            if (config->TraceBuyer)
            {
                LOG_INFO("module", "AHBot [{}]: Current price too high, skipped.", _id);
            }
            continue;
        }

        
        //
        // Recalculate the bid depending on the type of the item
        //

        switch (prototype->Class)
        {
        case ITEM_CLASS_PROJECTILE:
            maximumBid = 0;
            break;
        case ITEM_CLASS_GENERIC:
            maximumBid = 0;
            break;
        case ITEM_CLASS_MONEY:
            maximumBid = 0;
            break;
        case ITEM_CLASS_PERMANENT:
            maximumBid = 0;
            break;
        default:
            break;
        }

        //
        //  Make sure to skip the auction if maximum bid is 0.
        //

        if (maximumBid == 0)
        {
            if (config->TraceBuyer)
            {
                LOG_INFO("module", "AHBot [{}]: Maximum bid value for item class {} is 0, skipped.", _id, prototype->Class);
            }
            continue;
        }

        //
        // Calculate our bid
        //

        double bidRate = static_cast<double>(urand(1, 100)) / 100;
        double bidValue = currentPrice + ((maximumBid - currentPrice) * bidRate);
        uint32 bidPrice = static_cast<uint32>(bidValue);


        //
        // Check our bid is high enough to be valid. If not, correct it to minimum.
        //
        uint32 minimumOutbid = auction->GetAuctionOutBid();
        if ((currentPrice + minimumOutbid) > bidPrice)
        {
            bidPrice = currentPrice + minimumOutbid;
        }

        if (bidPrice > maximumBid)
        {
            if (config->TraceBuyer)
            {
                LOG_INFO("module", "AHBot [{}]: Bid was above bidMax for item={} AH={}", _id, auction->item_guid.ToString(), config->GetAHID());
            }
            bidPrice = maximumBid;
        }

        if (config->DebugOutBuyer)
        {
            LOG_INFO("module", "-------------------------------------------------");
            LOG_INFO("module", "AHBot [{}]: Bid Rate: {}", _id, bidRate);
            LOG_INFO("module", "AHBot [{}]: Bid Value: {}", _id, bidValue);
            LOG_INFO("module", "AHBot [{}]: Bid Price: {}", _id, bidPrice);
            LOG_INFO("module", "AHBot [{}]: Minimum Outbid: {}", _id, minimumOutbid);
            LOG_INFO("module", "-------------------------------------------------");
        }
           

        //
        // Check whether we do normal bid, or buyout
        //

        if ((bidPrice < auction->buyout) || (auction->buyout == 0))
        {
            //
            // Return money to last bidder.
            //
        
            if (auction->bidder)
            {
                if (auction->bidder != AHBplayer->GetGUID())
                {
                    //
                    // Mail to last bidder and return their money
                    //
        
                    auto trans = CharacterDatabase.BeginTransaction();        
                    sAuctionMgr->SendAuctionOutbiddedMail(auction, bidPrice, session->GetPlayer(), trans);
                    CharacterDatabase.CommitTransaction(trans);
                }
            }
        
            auction->bidder = AHBplayer->GetGUID();
            auction->bid = bidPrice;

            sAuctionMgr->GetAuctionHouseSearcher()->UpdateBid(auction);
        
            //
            // update/save the auction into database
            //
            CharacterDatabase.Execute("UPDATE auctionhouse SET buyguid = '{}', lastbid = '{}' WHERE id = '{}'", auction->bidder.GetCounter(), auction->bid, auction->Id);

            if (config->TraceBuyer)
            {
                LOG_INFO("module", "AHBot [{}]: New bid, itemid={}, ah={}, auctionId={} item={}, start={}, current={}, buyout={}", _id, prototype->ItemId, auction->GetHouseId(), auction->Id, auction->item_template, auction->startbid, currentPrice, auction->buyout);
            }            
        }
        else
        {
            //
            // Perform the buyout
            //

            auto trans = CharacterDatabase.BeginTransaction();

            if ((auction->bidder) && (AHBplayer->GetGUID() != auction->bidder))
            {
                //
                //  Mail to last bidder and return their money
                //

                sAuctionMgr->SendAuctionOutbiddedMail(auction, auction->buyout, session->GetPlayer(), trans);
            }

            auction->bidder = AHBplayer->GetGUID();
            auction->bid = auction->buyout;

            // 
            // Send mails to buyer & seller
            // 

            sAuctionMgr->SendAuctionSuccessfulMail(auction, trans);
            sAuctionMgr->SendAuctionWonMail(auction, trans);

            // 
            // Removes any trace of the item
            // 

            ScriptMgr::instance()->OnAuctionSuccessful(auctionHouseObject, auction);
            auction->DeleteFromDB(trans);
            sAuctionMgr->RemoveAItem(auction->item_guid);
            auctionHouseObject->RemoveAuction(auction);


            CharacterDatabase.CommitTransaction(trans);

            if (config->TraceBuyer)
            {
                LOG_INFO("module", "AHBot [{}]: Bought , itemid={}, ah={}, item={}, start={}, current={}, buyout={}", _id, prototype->ItemId, AuctionHouseId(auction->GetHouseId()), auction->item_template, auction->startbid, currentPrice, auction->buyout);
            }
        }
    }
}

// =============================================================================
// This routine performs the selling operations for the bot
// =============================================================================

void AuctionHouseBot::Sell(Player* AHBplayer, AHBConfig* config)
{
    // 
    // Check if disabled
    // 

    if (!config->AHBSeller)
    {
        return;
    }

    // 
    // Check the given limits
    // 

    uint32 minTotalItems = config->GetMinItems();
    uint32 maxTotalItems = config->GetMaxItems();

    if (maxTotalItems == 0)
    {
        return;
    }

    // 
    // Retrieve the auction house situation
    // 

    AuctionHouseEntry const* ahEntry = sAuctionMgr->GetAuctionHouseEntryFromFactionTemplate(config->GetAHFID());

    if (!ahEntry)
    {
        return;
    }

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(config->GetAHFID());

    if (!auctionHouse)
    {
        return;
    }

    // don't mess with the AH update let server do it.
    //auctionHouseObject->Update();

    // 
    // Check if we are clear to proceed
    // 

    bool aboveMin = false;
    bool aboveMax = false;
    uint32 nbOfAuctions = getNofAuctions(config, auctionHouse, AHBplayer->GetGUID());
    uint32 nbItemsToSellThisCycle = 0;

    if (nbOfAuctions >= minTotalItems)
    {
        aboveMin = true;

        if (config->DebugOutSeller)
        {
            LOG_TRACE("module", "AHBot [{}]: Auctions above minimum", _id);
        }
    }

    if (nbOfAuctions >= maxTotalItems)
    {
        aboveMax = true;

        if (config->DebugOutSeller)
        {
            LOG_TRACE("module", "AHBot [{}]: Auctions at or above maximum", _id);
        }

        return;
    }

    if ((maxTotalItems - nbOfAuctions) >= config->ItemsPerCycle)
    {
        nbItemsToSellThisCycle = config->ItemsPerCycle;
    }
    else
    {
        nbItemsToSellThisCycle = (maxTotalItems - nbOfAuctions);
    }

    // 
    // Retrieve the configuration for this run
    // 

    uint32 maxGreyTG   = config->GetMaximum(AHB_GREY_TG);
    uint32 maxWhiteTG  = config->GetMaximum(AHB_WHITE_TG);
    uint32 maxGreenTG  = config->GetMaximum(AHB_GREEN_TG);
    uint32 maxBlueTG   = config->GetMaximum(AHB_BLUE_TG);
    uint32 maxPurpleTG = config->GetMaximum(AHB_PURPLE_TG);
    uint32 maxOrangeTG = config->GetMaximum(AHB_ORANGE_TG);
    uint32 maxYellowTG = config->GetMaximum(AHB_YELLOW_TG);

    uint32 maxGreyI    = config->GetMaximum(AHB_GREY_I);
    uint32 maxWhiteI   = config->GetMaximum(AHB_WHITE_I);
    uint32 maxGreenI   = config->GetMaximum(AHB_GREEN_I);
    uint32 maxBlueI    = config->GetMaximum(AHB_BLUE_I);
    uint32 maxPurpleI  = config->GetMaximum(AHB_PURPLE_I);
    uint32 maxOrangeI  = config->GetMaximum(AHB_ORANGE_I);
    uint32 maxYellowI  = config->GetMaximum(AHB_YELLOW_I);

    uint32 currentGreyTG    = config->GetItemCounts(AHB_GREY_TG);
    uint32 currentWhiteTG   = config->GetItemCounts(AHB_WHITE_TG);
    uint32 currentGreenTG   = config->GetItemCounts(AHB_GREEN_TG);
    uint32 currentBlueTG    = config->GetItemCounts(AHB_BLUE_TG);
    uint32 currentPurpleTG  = config->GetItemCounts(AHB_PURPLE_TG);
    uint32 currentOrangeTG  = config->GetItemCounts(AHB_ORANGE_TG);
    uint32 currentYellowTG  = config->GetItemCounts(AHB_YELLOW_TG);

    uint32 currentGreyItems     = config->GetItemCounts(AHB_GREY_I);
    uint32 currentWhiteItems    = config->GetItemCounts(AHB_WHITE_I);
    uint32 currentGreenItems    = config->GetItemCounts(AHB_GREEN_I);
    uint32 currentBlueItems     = config->GetItemCounts(AHB_BLUE_I);
    uint32 currentPurpleItems   = config->GetItemCounts(AHB_PURPLE_I);
    uint32 currentOrangeItems   = config->GetItemCounts(AHB_ORANGE_I);
    uint32 currentYellowItems   = config->GetItemCounts(AHB_YELLOW_I);

    //
    // Loop variables
    //

    uint32 nbSold    = 0; // Tracing counter
    uint32 binEmpty  = 0; // Tracing counter
    uint32 noNeed    = 0; // Tracing counter
    uint32 tooMany   = 0; // Tracing counter
    uint32 loopBrk   = 0; // Tracing counter
    uint32 err       = 0; // Tracing counter

    for (uint32 cnt = 1; cnt <= nbItemsToSellThisCycle; cnt++)
    {
        uint32 itemTypeSelectedToSell = 0;
        uint32 itemID = 0;
        uint32 loopbreaker = 0;

        //
        // Select, in rarity order, a new random item
        //

        while (itemID == 0 && loopbreaker <= AUCTION_HOUSE_BOT_LOOP_BREAKER)
        {
            loopbreaker++;

            // Poor

            if ((config->GreyItemsBin.size() > 0) && (currentGreyItems < maxGreyI))
            {
                itemTypeSelectedToSell = AHB_GREY_I;
                itemID = getElement(config->GreyItemsBin, urand(0, config->GreyItemsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            if (itemID == 0 && (config->GreyTradeGoodsBin.size() > 0) && (currentGreyTG < maxGreyTG))
            {
                itemTypeSelectedToSell = AHB_GREY_TG;
                itemID = getElement(config->GreyTradeGoodsBin, urand(0, config->GreyTradeGoodsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            // Normal

            if (itemID == 0 && (config->WhiteItemsBin.size() > 0) && (currentWhiteItems < maxWhiteI))
            {
                itemTypeSelectedToSell = AHB_WHITE_I;
                itemID = getElement(config->WhiteItemsBin, urand(0, config->WhiteItemsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            if (itemID == 0 && (config->WhiteTradeGoodsBin.size() > 0) && (currentWhiteTG < maxWhiteTG))
            {
                itemTypeSelectedToSell = AHB_WHITE_TG;
                itemID = getElement(config->WhiteTradeGoodsBin, urand(0, config->WhiteTradeGoodsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            // Uncommon

            if (itemID == 0 && (config->GreenItemsBin.size() > 0) && (currentGreenItems < maxGreenI))
            {
                itemTypeSelectedToSell = AHB_GREEN_I;
                itemID = getElement(config->GreenItemsBin, urand(0, config->GreenItemsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            if (itemID == 0 && (config->GreenTradeGoodsBin.size() > 0) && (currentGreenTG < maxGreenTG))
            {
                itemTypeSelectedToSell = AHB_GREEN_TG;
                itemID = getElement(config->GreenTradeGoodsBin, urand(0, config->GreenTradeGoodsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            // Rare

            if (itemID == 0 && (config->BlueItemsBin.size() > 0) && (currentBlueItems < maxBlueI))
            {
                itemTypeSelectedToSell = AHB_BLUE_I;
                itemID = getElement(config->BlueItemsBin, urand(0, config->BlueItemsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            if (itemID == 0 && (config->BlueTradeGoodsBin.size() > 0) && (currentBlueTG < maxBlueTG))
            {
                itemTypeSelectedToSell = AHB_BLUE_TG;
                itemID = getElement(config->BlueTradeGoodsBin, urand(0, config->BlueTradeGoodsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            // Epic

            if (itemID == 0 && (config->PurpleItemsBin.size() > 0) && (currentPurpleItems < maxPurpleI))
            {
                itemTypeSelectedToSell = AHB_PURPLE_I;
                itemID = getElement(config->PurpleItemsBin, urand(0, config->PurpleItemsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            if (itemID == 0 && (config->PurpleTradeGoodsBin.size() > 0) && (currentPurpleTG < maxPurpleTG))
            {
                itemTypeSelectedToSell = AHB_PURPLE_TG;
                itemID = getElement(config->PurpleTradeGoodsBin, urand(0, config->PurpleTradeGoodsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            // Legendary

            if (itemID == 0 && (config->OrangeItemsBin.size() > 0) && (currentOrangeItems < maxOrangeI))
            {
                itemTypeSelectedToSell = AHB_ORANGE_I;
                itemID = getElement(config->OrangeItemsBin, urand(0, config->OrangeItemsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            if (itemID == 0 && (config->OrangeTradeGoodsBin.size() > 0) && (currentOrangeTG < maxOrangeTG))
            {
                itemTypeSelectedToSell = AHB_ORANGE_TG;
                itemID = getElement(config->OrangeTradeGoodsBin, urand(0, config->OrangeTradeGoodsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            // Artifact

            if (itemID == 0 && (config->YellowItemsBin.size() > 0) && (currentYellowItems < maxYellowI))
            {
                itemTypeSelectedToSell = AHB_YELLOW_I;
                itemID = getElement(config->YellowItemsBin, urand(0, config->YellowItemsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            if (itemID == 0 && (config->YellowTradeGoodsBin.size() > 0) && (currentYellowTG < maxYellowTG))
            {
                itemTypeSelectedToSell = AHB_YELLOW_TG;
                itemID = getElement(config->YellowTradeGoodsBin, urand(0, config->YellowTradeGoodsBin.size() - 1), _id, config->DuplicatesCount, auctionHouse);
            }

            if (itemID == 0)
            {
                binEmpty++;
            
                if (config->DebugOutSeller)
                {
                    LOG_ERROR("module", "AHBot [{}]: No item could be selected from the bins", _id);
                }
            
                break;
            }
        }

        if (itemID == 0 || loopbreaker > AUCTION_HOUSE_BOT_LOOP_BREAKER)
        {
            loopBrk++;
            continue;
        }

        // 
        // Retrieve information about the selected item
        // 

        ItemTemplate const* prototype = sObjectMgr->GetItemTemplate(itemID);

        if (prototype == NULL)
        {
            err++;

            if (config->DebugOutSeller)
            {
                LOG_ERROR("module", "AHBot [{}]: could not get prototype of item {}", _id, itemID);
            }

            continue;
        }

        Item* item = Item::CreateItem(itemID, 1, AHBplayer);

        if (item == NULL)
        {
            err++;

            if (config->DebugOutSeller)
            {
                LOG_ERROR("module", "AHBot [{}]: could not create item from prototype {}", _id, itemID);
            }

            continue;
        }

        // 
        // Start interacting with the item by adding a random property
        // 

        item->AddToUpdateQueueOf(AHBplayer);

        uint32 randomPropertyId = Item::GenerateItemRandomPropertyId(itemID);

        if (randomPropertyId != 0)
        {
            item->SetItemRandomProperties(randomPropertyId);
        }

        if (prototype->Quality > AHB_MAX_QUALITY)
        {
            err++;

            if (config->DebugOutSeller)
            {
                LOG_ERROR("module", "AHBot [{}]: Quality {} TOO HIGH for item {}", _id, prototype->Quality, itemID);
            }

            item->RemoveFromUpdateQueueOf(AHBplayer);
            continue;
        }

        // 
        // Determine the price
        // 

        uint64 buyoutPrice = 0;
        uint64 bidPrice = 0;
        uint32 stackCount = 1;

        if (config->SellAtMarketPrice)
        {
            buyoutPrice = config->GetItemPrice(itemID);
        }

        if (buyoutPrice == 0)
        {
            if (config->UseBuyPriceForSeller)
            {
                buyoutPrice = prototype->BuyPrice;
            }
            else
            {
                buyoutPrice = prototype->SellPrice;
            }
        }

        buyoutPrice = buyoutPrice * urand(config->GetMinPrice(prototype->Quality), config->GetMaxPrice(prototype->Quality));
        buyoutPrice = buyoutPrice / 100;

        bidPrice    = buyoutPrice * urand(config->GetMinBidPrice(prototype->Quality), config->GetMaxBidPrice(prototype->Quality));
        bidPrice    = bidPrice / 100;

        // 
        // Determine the stack size
        // 

        if (config->GetMaxStack(prototype->Quality) > 1 && item->GetMaxStackCount() > 1)
        {
            stackCount = minValue(getStackCount(config, item->GetMaxStackCount()), config->GetMaxStack(prototype->Quality));
        }
        else if (config->GetMaxStack(prototype->Quality) == 0 && item->GetMaxStackCount() > 1)
        {
            stackCount = getStackCount(config, item->GetMaxStackCount());
        }
        else
        {
            stackCount = 1;
        }

        item->SetCount(stackCount);

        // 
        // Determine the auction time
        // 

        uint32 elapsingTime = getElapsedTime(config->ElapsingTimeClass);

        // 
        // Determine the deposit
        // 

        uint32 deposit = sAuctionMgr->GetAuctionDeposit(ahEntry, elapsingTime, item, stackCount);

        // 
        // Perform the auction
        // 

        auto trans = CharacterDatabase.BeginTransaction();

        AuctionEntry* auctionEntry      = new AuctionEntry();
        auctionEntry->Id                = sObjectMgr->GenerateAuctionID();
        auctionEntry->houseId           = AuctionHouseId(config->GetAHID());
        auctionEntry->item_guid         = item->GetGUID();
        auctionEntry->item_template     = item->GetEntry();
        auctionEntry->itemCount         = item->GetCount();
        auctionEntry->owner             = AHBplayer->GetGUID();
        auctionEntry->startbid          = bidPrice * stackCount;
        auctionEntry->buyout            = buyoutPrice * stackCount;
        auctionEntry->bid               = 0;
        auctionEntry->deposit           = deposit;
        auctionEntry->expire_time       = (time_t)elapsingTime + time(NULL);
        auctionEntry->auctionHouseEntry = ahEntry;

        item->SaveToDB(trans);
        item->RemoveFromUpdateQueueOf(AHBplayer);
        sAuctionMgr->AddAItem(item);
        auctionHouse->AddAuction(auctionEntry);
        auctionEntry->SaveToDB(trans);

        CharacterDatabase.CommitTransaction(trans);

        // 
        // Increments the number of items presents in the auction
        // 

        // todo: reread config for actual values, maybe an array to not rely on local count that could potentially be mismatched from config.
        // config is updated from callback received after auctionHouseObject->AddAuction(auctionEntry);
        // or maybe reparse the server actual value each update cycle, would need profiling.
        switch (itemTypeSelectedToSell)
        {
        case AHB_GREY_I:
            ++currentGreyItems;
            break;

        case AHB_WHITE_I:
            ++currentWhiteItems;
            break;

        case AHB_GREEN_I:
            ++currentGreenItems;
            break;

        case AHB_BLUE_I:
            ++currentBlueItems;
            break;

        case AHB_PURPLE_I:
            ++currentPurpleItems;
            break;

        case AHB_ORANGE_I:
            ++currentOrangeItems;
            break;

        case AHB_YELLOW_I:
            ++currentYellowItems;
            break;

        case AHB_GREY_TG:
            ++currentGreyTG;
            break;

        case AHB_WHITE_TG:
            ++currentWhiteTG;
            break;

        case AHB_GREEN_TG:
            ++currentGreenTG;
            break;

        case AHB_BLUE_TG:
            ++currentBlueTG;
            break;

        case AHB_PURPLE_TG:
            ++currentPurpleTG;
            break;

        case AHB_ORANGE_TG:
            ++currentOrangeTG;
            break;

        case AHB_YELLOW_TG:
            ++currentYellowTG;
            break;

        default:
            break;
        }

        nbSold++;

        if (config->TraceSeller)
        {
            LOG_INFO("module", "AHBot [{}]: New stack ah={}, id={}, stack={}, bid={}, buyout={}", _id, config->GetAHID(), itemID, stackCount, auctionEntry->startbid, auctionEntry->buyout);
        }
    }

    if (config->TraceSeller)
    {
        LOG_INFO("module", "AHBot [{}]: auctionhouse {}, req={}, sold={}, aboveMin={}, aboveMax={}, loopBrk={}, noNeed={}, tooMany={}, binEmpty={}, err={}", _id, config->GetAHID(), nbItemsToSellThisCycle, nbSold, aboveMin, aboveMax, loopBrk, noNeed, tooMany, binEmpty, err);
    }
}

// =============================================================================
// Perform an update cycle
// =============================================================================

void AuctionHouseBot::Update()
{
    time_t _newrun = time(NULL);

    //
    // If no configuration is associated, then stop here
    //

    if (!_allianceConfig && !_hordeConfig && !_neutralConfig)
    {
        return;
    }

    //
    // Preprare for operation
    //

    std::string accountName = "AuctionHouseBot" + std::to_string(_account);

    WorldSession _session(_account, std::move(accountName), nullptr, SEC_PLAYER, sWorld->getIntConfig(CONFIG_EXPANSION), 0, LOCALE_enUS, 0, false, false, 0);

    Player _AHBplayer(&_session);
    _AHBplayer.Initialize(_id);

    ObjectAccessor::AddObject(&_AHBplayer);

    LOG_INFO("module", "AHBot [{}]: Begin Performing Update Cycle", _id);

    //
    // Perform update for the factions markets
    //

    if (!sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION))
    {
        //
        // Alliance
        //

        if (_allianceConfig)
        {
            if (_allianceConfig->TraceSeller)
            {
                LOG_INFO("module", "AHBot [{}]: Begin Sell for Alliance...", _id);
            }

            Sell(&_AHBplayer, _allianceConfig);

            if (((_newrun - _lastrun_a_sec) >= (_allianceConfig->GetBiddingInterval() * MINUTE)) && (_allianceConfig->GetBidsPerInterval() > 0))
            {
                if (_allianceConfig->TraceBuyer)
                {
                    LOG_INFO("module", "AHBot [{}]: Begin Buy for Alliance...", _id);
                }

                Buy(&_AHBplayer, _allianceConfig, &_session);
                _lastrun_a_sec = _newrun;
            }
        }

        //
        // Horde
        //

        if (_hordeConfig)
        {
            if (_hordeConfig->TraceSeller)
            {
                LOG_INFO("module", "AHBot [{}]: Begin Sell for Horde...", _id);
            }
            Sell(&_AHBplayer, _hordeConfig);

            if (((_newrun - _lastrun_h_sec) >= (_hordeConfig->GetBiddingInterval() * MINUTE)) && (_hordeConfig->GetBidsPerInterval() > 0))
            {
                if (_hordeConfig->TraceBuyer)
                {
                    LOG_INFO("module", "AHBot [{}]: Begin Buy for Horde...", _id);
                }
                Buy(&_AHBplayer, _hordeConfig, &_session);
                _lastrun_h_sec = _newrun;
            }
        }

    }

    //
    // Neutral
    //

    if (_neutralConfig)
    {
        if (_neutralConfig->TraceSeller)
        {
            LOG_INFO("module", "AHBot [{}]: Begin Sell for Neutral...", _id);
        }
        Sell(&_AHBplayer, _neutralConfig);

        if (((_newrun - _lastrun_n_sec) >= (_neutralConfig->GetBiddingInterval() * MINUTE)) && (_neutralConfig->GetBidsPerInterval() > 0))
        {
            if (_neutralConfig->TraceBuyer)
            {
                LOG_INFO("module", "AHBot [{}]: Begin Buy for Neutral...", _id);
            }
            Buy(&_AHBplayer, _neutralConfig, &_session);
            _lastrun_n_sec = _newrun;
        }
    }

    ObjectAccessor::RemoveObject(&_AHBplayer);
}

// =============================================================================
// Execute commands coming from the console
// =============================================================================

void AuctionHouseBot::Commands(AHBotCommand command, uint32 ahMapID, uint32 col, char* args)
{
    //
    // Retrieve the auction house configuration
    //

    AHBConfig *config = NULL;

    switch (ahMapID)
    {
    case 2:
        config = _allianceConfig;
        break;
    case 6:
        config = _hordeConfig;
        break;
    default:
        config = _neutralConfig;
        break;
    }

    //
    // Retrive the item quality
    //

    std::string color;

    switch (col)
    {
    case AHB_GREY:
        color = "grey";
        break;
    case AHB_WHITE:
        color = "white";
        break;
    case AHB_GREEN:
        color = "green";
        break;
    case AHB_BLUE:
        color = "blue";
        break;
    case AHB_PURPLE:
        color = "purple";
        break;
    case AHB_ORANGE:
        color = "orange";
        break;
    case AHB_YELLOW:
        color = "yellow";
        break;
    default:
        break;
    }

    //
    // Perform the command
    //

    switch (command)
    {
    case AHBotCommand::buyer:
    {
        char* param1 = strtok(args, " ");
        uint32 state = (uint32)strtoul(param1, NULL, 0);

        if (state == 0)
        {
            _allianceConfig->AHBBuyer = false;
            _hordeConfig->AHBBuyer    = false;
            _neutralConfig->AHBBuyer  = false;
        }
        else
        {
            _allianceConfig->AHBBuyer = true;
            _hordeConfig->AHBBuyer    = true;
            _neutralConfig->AHBBuyer  = true;
        }

        break;
    }
    case AHBotCommand::seller:
    {
        char* param1 = strtok(args, " ");
        uint32 state = (uint32)strtoul(param1, NULL, 0);

        if (state == 0)
        {
            _allianceConfig->AHBSeller = false;
            _hordeConfig->AHBSeller    = false;
            _neutralConfig->AHBSeller  = false;
        }
        else
        {
            _allianceConfig->AHBSeller = true;
            _hordeConfig->AHBSeller    = true;
            _neutralConfig->AHBSeller  = true;
        }

        break;
    }
    case AHBotCommand::useMarketPrice:
    {
        char* param1 = strtok(args, " ");
        uint32 state = (uint32)strtoul(param1, NULL, 0);

        if (state == 0)
        {
            _allianceConfig->SellAtMarketPrice = false;
            _hordeConfig->SellAtMarketPrice    = false;
            _neutralConfig->SellAtMarketPrice  = false;
        }
        else
        {
            _allianceConfig->SellAtMarketPrice = true;
            _hordeConfig->SellAtMarketPrice    = true;
            _neutralConfig->SellAtMarketPrice  = true;
        }

        break;
    }
    case AHBotCommand::ahexpire:
    {
        AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(config->GetAHFID());

        AuctionHouseObject::AuctionEntryMap::iterator itr;
        itr = auctionHouse->GetAuctionsBegin();

        //
        // Iterate through all the autions and if they belong to the bot, make them expired
        //

        while (itr != auctionHouse->GetAuctionsEnd())
        {
            if (itr->second->owner.GetCounter() == _id)
            {
                // Expired NOW.
                itr->second->expire_time = GameTime::GetGameTime().count();

                uint32 id                = itr->second->Id;
                uint32 expire_time       = itr->second->expire_time;

                CharacterDatabase.Execute("UPDATE auctionhouse SET time = '{}' WHERE id = '{}'", expire_time, id);
            }

            ++itr;
        }

        break;
    }
    case AHBotCommand::minitems:
    {
        char * param1   = strtok(args, " ");
        uint32 minItems = (uint32) strtoul(param1, NULL, 0);

        WorldDatabase.Execute("UPDATE mod_auctionhousebot SET minitems = '{}' WHERE auctionhouse = '{}'", minItems, ahMapID);

        config->SetMinItems(minItems);

        break;
    }
    case AHBotCommand::maxitems:
    {
        char * param1   = strtok(args, " ");
        uint32 maxItems = (uint32) strtoul(param1, NULL, 0);

        WorldDatabase.Execute("UPDATE mod_auctionhousebot SET maxitems = '{}' WHERE auctionhouse = '{}'", maxItems, ahMapID);

        config->SetMaxItems(maxItems);
        config->CalculatePercents();
        break;
    }
    case AHBotCommand::percentages:
    {
        char * param1   = strtok(args, " ");
        char * param2   = strtok(NULL, " ");
        char * param3   = strtok(NULL, " ");
        char * param4   = strtok(NULL, " ");
        char * param5   = strtok(NULL, " ");
        char * param6   = strtok(NULL, " ");
        char * param7   = strtok(NULL, " ");
        char * param8   = strtok(NULL, " ");
        char * param9   = strtok(NULL, " ");
        char * param10  = strtok(NULL, " ");
        char * param11  = strtok(NULL, " ");
        char * param12  = strtok(NULL, " ");
        char * param13  = strtok(NULL, " ");
        char * param14  = strtok(NULL, " ");

        uint32 greytg   = (uint32) strtoul(param1, NULL, 0);
        uint32 whitetg  = (uint32) strtoul(param2, NULL, 0);
        uint32 greentg  = (uint32) strtoul(param3, NULL, 0);
        uint32 bluetg   = (uint32) strtoul(param4, NULL, 0);
        uint32 purpletg = (uint32) strtoul(param5, NULL, 0);
        uint32 orangetg = (uint32) strtoul(param6, NULL, 0);
        uint32 yellowtg = (uint32) strtoul(param7, NULL, 0);
        uint32 greyi    = (uint32) strtoul(param8, NULL, 0);
        uint32 whitei   = (uint32) strtoul(param9, NULL, 0);
        uint32 greeni   = (uint32) strtoul(param10, NULL, 0);
        uint32 bluei    = (uint32) strtoul(param11, NULL, 0);
        uint32 purplei  = (uint32) strtoul(param12, NULL, 0);
        uint32 orangei  = (uint32) strtoul(param13, NULL, 0);
        uint32 yellowi  = (uint32) strtoul(param14, NULL, 0);

        //
        // Setup the percentage in the configuration first, so validity test can be performed
        //

        config->SetPercentages(greytg, whitetg, greentg, bluetg, purpletg, orangetg, yellowtg, greyi, whitei, greeni, bluei, purplei, orangei, yellowi);

        //
        // Save the results into the database (after the tests)
        //

        auto trans = WorldDatabase.BeginTransaction();

        trans->Append("UPDATE mod_auctionhousebot SET percentgreytradegoods   = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_GREY_TG)  , ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentwhitetradegoods  = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_WHITE_TG) , ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentgreentradegoods  = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_GREEN_TG) , ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentbluetradegoods   = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_BLUE_TG)  , ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentpurpletradegoods = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_PURPLE_TG), ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentorangetradegoods = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_ORANGE_TG), ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentyellowtradegoods = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_YELLOW_TG), ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentgreyitems        = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_GREY_I)   , ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentwhiteitems       = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_WHITE_I)  , ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentgreenitems       = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_GREEN_I)  , ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentblueitems        = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_BLUE_I)   , ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentpurpleitems      = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_PURPLE_I) , ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentorangeitems      = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_ORANGE_I) , ahMapID);
        trans->Append("UPDATE mod_auctionhousebot SET percentyellowitems      = '{}' WHERE auctionhouse = '{}'", config->GetPercentages(AHB_YELLOW_I) , ahMapID);

        WorldDatabase.CommitTransaction(trans);

        break;
    }
    case AHBotCommand::minprice:
    {
        char * param1   = strtok(args, " ");
        uint32 minPrice = (uint32) strtoul(param1, NULL, 0);

        WorldDatabase.Execute("UPDATE mod_auctionhousebot SET minprice{} = '{}' WHERE auctionhouse = '{}'", color, minPrice, ahMapID);

        config->SetMinPrice(col, minPrice);

        break;
    }
    case AHBotCommand::maxprice:
    {
        char * param1   = strtok(args, " ");
        uint32 maxPrice = (uint32) strtoul(param1, NULL, 0);

        WorldDatabase.Execute("UPDATE mod_auctionhousebot SET maxprice{} = '{}' WHERE auctionhouse = '{}'", color, maxPrice, ahMapID);

        config->SetMaxPrice(col, maxPrice);

        break;
    }
    case AHBotCommand::minbidprice:
    {
        char * param1      = strtok(args, " ");
        uint32 minBidPrice = (uint32) strtoul(param1, NULL, 0);

        WorldDatabase.Execute("UPDATE mod_auctionhousebot SET minbidprice{} = '{}' WHERE auctionhouse = '{}'", color, minBidPrice, ahMapID);

        config->SetMinBidPrice(col, minBidPrice);

        break;
    }
    case AHBotCommand::maxbidprice:
    {
        char * param1      = strtok(args, " ");
        uint32 maxBidPrice = (uint32) strtoul(param1, NULL, 0);

        WorldDatabase.Execute("UPDATE mod_auctionhousebot SET maxbidprice{} = '{}' WHERE auctionhouse = '{}'", color, maxBidPrice, ahMapID);

        config->SetMaxBidPrice(col, maxBidPrice);

        break;
    }
    case AHBotCommand::maxstack:
    {
        char * param1   = strtok(args, " ");
        uint32 maxStack = (uint32) strtoul(param1, NULL, 0);

        WorldDatabase.Execute("UPDATE mod_auctionhousebot SET maxstack{} = '{}' WHERE auctionhouse = '{}'", color, maxStack, ahMapID);

        config->SetMaxStack(col, maxStack);

        break;
    }
    case AHBotCommand::buyerprice:
    {
        char * param1     = strtok(args, " ");
        uint32 buyerPrice = (uint32) strtoul(param1, NULL, 0);

        WorldDatabase.Execute("UPDATE mod_auctionhousebot SET buyerprice{} = '{}' WHERE auctionhouse = '{}'", color, buyerPrice, ahMapID);

        config->SetBuyerPrice(col, buyerPrice);

        break;
    }
    case AHBotCommand::bidinterval:
    {
        char * param1      = strtok(args, " ");
        uint32 bidInterval = (uint32) strtoul(param1, NULL, 0);

        WorldDatabase.Execute("UPDATE mod_auctionhousebot SET buyerbiddinginterval = '{}' WHERE auctionhouse = '{}'", bidInterval, ahMapID);

        config->SetBiddingInterval(bidInterval);

        break;
    }
    case AHBotCommand::bidsperinterval:
    {
        char * param1          = strtok(args, " ");
        uint32 bidsPerInterval = (uint32) strtoul(param1, NULL, 0);

        WorldDatabase.Execute("UPDATE mod_auctionhousebot SET buyerbidsperinterval = '{}' WHERE auctionhouse = '{}'", bidsPerInterval, ahMapID);

        config->SetBidsPerInterval(bidsPerInterval);

        break;
    }
    default:
        break;
    }
}

// =============================================================================
// Initialization of the bot
// =============================================================================

void AuctionHouseBot::Initialize(AHBConfig* allianceConfig, AHBConfig* hordeConfig, AHBConfig* neutralConfig)
{
    // 
    // Save the pointer for the configurations
    // 

    _allianceConfig = allianceConfig;
    _hordeConfig    = hordeConfig;
    _neutralConfig  = neutralConfig;

    //
    // Done
    //

    LOG_INFO("module", "AHBot [{}]: initialization complete", uint32(_id));
}
