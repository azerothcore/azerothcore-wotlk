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

#ifndef AUCTION_HOUSE_BOT_CONFIG_H
#define AUCTION_HOUSE_BOT_CONFIG_H

#include <map>
#include <set>
#include <string>

#include "ObjectMgr.h"

class AHBConfig
{
private:
    uint32 AHID;                     // Id
    uint32 AHFID;                    // Faction id

    uint32 minItems;
    uint32 maxItems;

    uint32 percentGreyTradeGoods;
    uint32 percentWhiteTradeGoods;
    uint32 percentGreenTradeGoods;
    uint32 percentBlueTradeGoods;
    uint32 percentPurpleTradeGoods;
    uint32 percentOrangeTradeGoods;
    uint32 percentYellowTradeGoods;

    uint32 percentGreyItems;
    uint32 percentWhiteItems;
    uint32 percentGreenItems;
    uint32 percentBlueItems;
    uint32 percentPurpleItems;
    uint32 percentOrangeItems;
    uint32 percentYellowItems;

    uint32 minPriceGrey;
    uint32 maxPriceGrey;
    uint32 minBidPriceGrey;
    uint32 maxBidPriceGrey;
    uint32 maxStackGrey;

    uint32 minPriceWhite;
    uint32 maxPriceWhite;
    uint32 minBidPriceWhite;
    uint32 maxBidPriceWhite;
    uint32 maxStackWhite;

    uint32 minPriceGreen;
    uint32 maxPriceGreen;
    uint32 minBidPriceGreen;
    uint32 maxBidPriceGreen;
    uint32 maxStackGreen;

    uint32 minPriceBlue;
    uint32 maxPriceBlue;
    uint32 minBidPriceBlue;
    uint32 maxBidPriceBlue;
    uint32 maxStackBlue;

    uint32 minPricePurple;
    uint32 maxPricePurple;
    uint32 minBidPricePurple;
    uint32 maxBidPricePurple;
    uint32 maxStackPurple;

    uint32 minPriceOrange;
    uint32 maxPriceOrange;
    uint32 minBidPriceOrange;
    uint32 maxBidPriceOrange;
    uint32 maxStackOrange;

    uint32 minPriceYellow;
    uint32 maxPriceYellow;
    uint32 minBidPriceYellow;
    uint32 maxBidPriceYellow;
    uint32 maxStackYellow;

    uint32 buyerPriceGrey;
    uint32 buyerPriceWhite;
    uint32 buyerPriceGreen;
    uint32 buyerPriceBlue;
    uint32 buyerPricePurple;
    uint32 buyerPriceOrange;
    uint32 buyerPriceYellow;
    uint32 buyerBiddingInterval;
    uint32 buyerBidsPerInterval;

    //
    // Amount of items to be sold in absolute values
    //

    uint32 greytgp;
    uint32 whitetgp;
    uint32 greentgp;
    uint32 bluetgp;
    uint32 purpletgp;
    uint32 orangetgp;
    uint32 yellowtgp;

    uint32 greyip;
    uint32 whiteip;
    uint32 greenip;
    uint32 blueip;
    uint32 purpleip;
    uint32 orangeip;
    uint32 yellowip;

    //
    // Situation of the auction house
    //

    uint32 greyTGoods;
    uint32 whiteTGoods;
    uint32 greenTGoods;
    uint32 blueTGoods;
    uint32 purpleTGoods;
    uint32 orangeTGoods;
    uint32 yellowTGoods;

    uint32 greyItems;
    uint32 whiteItems;
    uint32 greenItems;
    uint32 blueItems;
    uint32 purpleItems;
    uint32 orangeItems;
    uint32 yellowItems;

    // 
    // Per-item statistics
    //

    std::map<uint32, uint32> itemsCount;
    std::map<uint32, uint64> itemsSum;
    std::map<uint32, uint64> itemsPrice;

    void   InitializeFromFile();
    void   InitializeFromSql(std::set<uint32> botsIds);

    std::set<uint32> getCommaSeparatedIntegers(std::string text);

    void DecItemCounts(uint32 ahbotItemType);
    void IncItemCounts(uint32 ahbotItemType);

public:
    //
    // Debugging
    //

    bool   DebugOut;
    bool   DebugOutConfig;
    bool   DebugOutFilters;
    bool   DebugOutBuyer;
    bool   DebugOutSeller;

    //
    // Tracing
    //

    bool   TraceSeller;
    bool   TraceBuyer;

    //
    // Setup
    //

    bool   AHBSeller;
    bool   AHBBuyer;
    bool   UseBuyPriceForBuyer;
    bool   UseBuyPriceForSeller;
    bool   SellAtMarketPrice;
    uint32 MarketResetThreshold;
    bool   ConsiderOnlyBotAuctions;
    uint32 ItemsPerCycle;

    //
    // Filters
    //

    bool   Vendor_Items;
    bool   Loot_Items;
    bool   Other_Items;
    bool   Vendor_TGs;
    bool   Loot_TGs;
    bool   Other_TGs;
    bool   Profession_Items;

    bool   No_Bind;
    bool   Bind_When_Picked_Up;
    bool   Bind_When_Equipped;
    bool   Bind_When_Use;
    bool   Bind_Quest_Item;

    uint32 DuplicatesCount;
    uint32 ElapsingTimeClass;

    bool   DivisibleStacks;
    bool   DisablePermEnchant;
    bool   DisableConjured;
    bool   DisableGems;
    bool   DisableMoney;
    bool   DisableMoneyLoot;
    bool   DisableLootable;
    bool   DisableKeys;
    bool   DisableDuration;
    bool   DisableBOP_Or_Quest_NoReqLevel;

    bool   DisableWarriorItems;
    bool   DisablePaladinItems;
    bool   DisableHunterItems;
    bool   DisableRogueItems;
    bool   DisablePriestItems;
    bool   DisableDKItems;
    bool   DisableShamanItems;
    bool   DisableMageItems;
    bool   DisableWarlockItems;
    bool   DisableUnusedClassItems;
    bool   DisableDruidItems;

    uint32 DisableItemsBelowLevel;
    uint32 DisableItemsAboveLevel;

    uint32 DisableTGsBelowLevel;
    uint32 DisableTGsAboveLevel;

    uint32 DisableItemsBelowGUID;
    uint32 DisableItemsAboveGUID;

    uint32 DisableTGsBelowGUID;
    uint32 DisableTGsAboveGUID;

    uint32 DisableItemsBelowReqLevel;
    uint32 DisableItemsAboveReqLevel;

    uint32 DisableTGsBelowReqLevel;
    uint32 DisableTGsAboveReqLevel;

    uint32 DisableItemsBelowReqSkillRank;
    uint32 DisableItemsAboveReqSkillRank;

    uint32 DisableTGsBelowReqSkillRank;
    uint32 DisableTGsAboveReqSkillRank;

    //
    // Items validity for selling purposes
    //

    std::set<uint32> NpcItems;
    std::set<uint32> LootItems;
    std::set<uint32> DisableItemStore;
    std::set<uint32> SellerWhiteList;

    //
    // Bins for trade goods.
    //

    std::set<uint32> GreyTradeGoodsBin;
    std::set<uint32> WhiteTradeGoodsBin;
    std::set<uint32> GreenTradeGoodsBin;
    std::set<uint32> BlueTradeGoodsBin;
    std::set<uint32> PurpleTradeGoodsBin;
    std::set<uint32> OrangeTradeGoodsBin;
    std::set<uint32> YellowTradeGoodsBin;

    //
    // Bins for items
    //

    std::set<uint32> GreyItemsBin;
    std::set<uint32> WhiteItemsBin;
    std::set<uint32> GreenItemsBin;
    std::set<uint32> BlueItemsBin;
    std::set<uint32> PurpleItemsBin;
    std::set<uint32> OrangeItemsBin;
    std::set<uint32> YellowItemsBin;

    //
    // Constructors/destructors
    //

    AHBConfig(uint32 ahid, AHBConfig* conf);
    AHBConfig(uint32 ahid);
    AHBConfig();
    ~AHBConfig();

    //
    // Ruotines
    //

    void   Initialize(std::set<uint32> botsIds);
    void   InitializeBins();
    void   Reset();

    uint32 GetAHID();
    uint32 GetAHFID();

    void   SetMinItems       (uint32 value);
    uint32 GetMinItems       ();

    void   SetMaxItems       (uint32 value);
    uint32 GetMaxItems       ();

    void   SetPercentages    (uint32 greytg, uint32 whitetg, uint32 greentg, uint32 bluetg, uint32 purpletg, uint32 orangetg, uint32 yellowtg,
                              uint32 greyi , uint32 whitei , uint32 greeni , uint32 bluei , uint32 purplei , uint32 orangei , uint32 yellowi);
    uint32 GetPercentages    (uint32 color);

    void   SetMinPrice       (uint32 color, uint32 value);
    uint32 GetMinPrice       (uint32 color);

    void   SetMaxPrice       (uint32 color, uint32 value);
    uint32 GetMaxPrice       (uint32 color);

    void   SetMinBidPrice    (uint32 color, uint32 value);
    uint32 GetMinBidPrice    (uint32 color);

    void   SetMaxBidPrice    (uint32 color, uint32 value);
    uint32 GetMaxBidPrice    (uint32 color);

    void   SetMaxStack       (uint32 color, uint32 value);
    uint32 GetMaxStack       (uint32 color);

    void   SetBuyerPrice     (uint32 color, uint32 value);
    uint32 GetBuyerPrice     (uint32 color);

    void   SetBiddingInterval(uint32 value);
    uint32 GetBiddingInterval();

    void   SetBidsPerInterval(uint32 value);
    uint32 GetBidsPerInterval();

    void   CalculatePercents ();
    // max number of items of type in AH based on maxItems
    uint32 GetMaximum        (uint32 ahbotItemType);
    
    void   DecItemCounts     (uint32 Class, uint32 Quality);

    void   IncItemCounts     (uint32 Class, uint32 Quality);


    void   ResetItemCounts   ();
    uint32 TotalItemCounts   ();

    uint32 GetItemCounts     (uint32 color);

    void   UpdateItemStats   (uint32 id, uint32 stackSize, uint64 buyout);
    uint64 GetItemPrice      (uint32 id);
};

//
// Globally defined configurations
//

extern AHBConfig* gAllianceConfig;
extern AHBConfig* gHordeConfig;
extern AHBConfig* gNeutralConfig;

#endif // AUCTION_HOUSE_BOT_CONFIG_H
