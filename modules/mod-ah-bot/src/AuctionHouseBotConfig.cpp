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

#include "AuctionHouseMgr.h"
#include "Common.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "ItemTemplate.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "QueryResult.h"
#include "WorldSession.h"

#include "AuctionHouseBotCommon.h"
#include "AuctionHouseBotConfig.h"

using namespace std;

AHBConfig::AHBConfig()
{
    Reset();
}

AHBConfig::AHBConfig(uint32 ahid)
{
    Reset();

    AHID = ahid;

    switch (ahid)
    {
    case 2:
        AHFID = 55;  // Alliance
        break;

    case 6:
        AHFID = 29;  // Horde
        break;

    case 7:
        AHFID = 120; // Neutral
        break;

    default:
        AHFID = 120; // Neutral
        break;
    }
}

AHBConfig::AHBConfig(uint32 ahid, AHBConfig* conf)
{
    Reset();

    // 
    // Ids
    // 

    AHID = ahid;

    switch (ahid)
    {
    case 2:
        AHFID = 55;  // Alliance
        break;

    case 6:
        AHFID = 29;  // Horde
        break;

    case 7:
        AHFID = 120; // Neutral
        break;

    default:
        AHFID = 120; // Neutral
        break;
    }

    //
    // Copy the private values
    //

    minItems                       = conf->minItems;
    maxItems                       = conf->maxItems;
    percentGreyTradeGoods          = conf->percentGreyTradeGoods;
    percentWhiteTradeGoods         = conf->percentWhiteTradeGoods;
    percentGreenTradeGoods         = conf->percentGreenTradeGoods;
    percentBlueTradeGoods          = conf->percentBlueTradeGoods;
    percentPurpleTradeGoods        = conf->percentPurpleTradeGoods;
    percentOrangeTradeGoods        = conf->percentOrangeTradeGoods;
    percentYellowTradeGoods        = conf->percentYellowTradeGoods;
    percentGreyItems               = conf->percentGreyItems;
    percentWhiteItems              = conf->percentWhiteItems;
    percentGreenItems              = conf->percentGreenItems;
    percentBlueItems               = conf->percentBlueItems;
    percentPurpleItems             = conf->percentPurpleItems;
    percentOrangeItems             = conf->percentOrangeItems;
    percentYellowItems             = conf->percentYellowItems;
    minPriceGrey                   = conf->minPriceGrey;
    maxPriceGrey                   = conf->maxPriceGrey;
    minBidPriceGrey                = conf->minBidPriceGrey;
    maxBidPriceGrey                = conf->maxBidPriceGrey;
    maxStackGrey                   = conf->maxStackGrey;
    maxPriceWhite                  = conf->maxPriceWhite;
    minBidPriceWhite               = conf->minBidPriceWhite;
    maxBidPriceWhite               = conf->maxBidPriceWhite;
    maxStackWhite                  = conf->maxStackWhite;
    minPriceGreen                  = conf->minPriceGreen;
    maxPriceGreen                  = conf->maxPriceGreen;
    minBidPriceGreen               = conf->minBidPriceGreen;
    maxBidPriceGreen               = conf->maxBidPriceGreen;
    maxStackGreen                  = conf->maxStackGreen;
    minPriceBlue                   = conf->minPriceBlue;
    maxPriceBlue                   = conf->maxPriceBlue;
    minBidPriceBlue                = conf->minBidPriceBlue;
    maxBidPriceBlue                = conf->maxBidPriceBlue;
    maxStackBlue                   = conf->maxStackBlue;
    minPricePurple                 = conf->minPricePurple;
    maxPricePurple                 = conf->maxPricePurple;
    minBidPricePurple              = conf->minBidPricePurple;
    maxBidPricePurple              = conf->maxBidPricePurple;
    maxStackPurple                 = conf->maxStackPurple;
    minPriceOrange                 = conf->minPriceOrange;
    maxPriceOrange                 = conf->maxPriceOrange;
    minBidPriceOrange              = conf->minBidPriceOrange;
    maxBidPriceOrange              = conf->maxBidPriceOrange;
    maxStackOrange                 = conf->maxStackOrange;
    minPriceYellow                 = conf->minPriceYellow;
    maxPriceYellow                 = conf->maxPriceYellow;
    minBidPriceYellow              = conf->minBidPriceYellow;
    maxBidPriceYellow              = conf->maxBidPriceYellow;
    maxStackYellow                 = conf->maxStackYellow;
    buyerPriceGrey                 = conf->buyerPriceGrey;
    buyerPriceWhite                = conf->buyerPriceWhite;
    buyerPriceGreen                = conf->buyerPriceGreen;
    buyerPriceBlue                 = conf->buyerPriceBlue;
    buyerPricePurple               = conf->buyerPricePurple;
    buyerPriceOrange               = conf->buyerPriceOrange;
    buyerPriceYellow               = conf->buyerPriceYellow;
    buyerBiddingInterval           = conf->buyerBiddingInterval;
    buyerBidsPerInterval           = conf->buyerBidsPerInterval;

    // This part is acquired thorugh initialization
    //
    // greytgp                        = conf->greytgp;
    // whitetgp                       = conf->whitetgp;
    // greentgp                       = conf->greentgp;
    // bluetgp                        = conf->bluetgp;
    // purpletgp                      = conf->purpletgp;
    // orangetgp                      = conf->orangetgp;
    // yellowtgp                      = conf->yellowtgp;
    // greyip                         = conf->greyip;
    // whiteip                        = conf->whiteip;
    // greenip                        = conf->greenip;
    // blueip                         = conf->blueip;
    // purpleip                       = conf->purpleip;
    // orangeip                       = conf->orangeip;
    // yellowip                       = conf->yellowip;
    // greyTGoods                     = conf->greyTGoods;
    // whiteTGoods                    = conf->whiteTGoods;
    // greenTGoods                    = conf->greenTGoods;
    // blueTGoods                     = conf->blueTGoods;
    // purpleTGoods                   = conf->purpleTGoods;
    // orangeTGoods                   = conf->orangeTGoods;
    // yellowTGoods                   = conf->yellowTGoods;
    // greyItems                      = conf->greyItems;
    // whiteItems                     = conf->whiteItems;
    // greenItems                     = conf->greenItems;
    // blueItems                      = conf->blueItems;
    // purpleItems                    = conf->purpleItems;
    // orangeItems                    = conf->orangeItems;
    // yellowItems                    = conf->yellowItems;

    //
    // Copy the public properties
    //

    DebugOut                       = conf->DebugOut;
    DebugOutConfig                 = conf->DebugOutConfig;
    DebugOutFilters                = conf->DebugOutFilters;
    DebugOutBuyer                  = conf->DebugOutBuyer;
    DebugOutSeller                 = conf->DebugOutSeller;
    TraceSeller                    = conf->TraceSeller;
    TraceBuyer                     = conf->TraceBuyer;
    AHBSeller                      = conf->AHBSeller;
    AHBBuyer                       = conf->AHBBuyer;
    UseBuyPriceForBuyer            = conf->UseBuyPriceForBuyer;
    UseBuyPriceForSeller           = conf->UseBuyPriceForSeller;
    ConsiderOnlyBotAuctions        = conf->ConsiderOnlyBotAuctions;
    ItemsPerCycle                  = conf->ItemsPerCycle;
    Vendor_Items                   = conf->Vendor_Items;
    Loot_Items                     = conf->Loot_Items;
    Other_Items                    = conf->Other_Items;
    Vendor_TGs                     = conf->Vendor_TGs;
    Loot_TGs                       = conf->Loot_TGs;
    Other_TGs                      = conf->Other_TGs;
    Profession_Items               = conf->Profession_Items;
    No_Bind                        = conf->No_Bind;
    Bind_When_Picked_Up            = conf->Bind_When_Picked_Up;
    Bind_When_Equipped             = conf->Bind_When_Equipped;
    Bind_When_Use                  = conf->Bind_When_Use;
    Bind_Quest_Item                = conf->Bind_Quest_Item;
    DuplicatesCount                = conf->DuplicatesCount;
    ElapsingTimeClass              = conf->ElapsingTimeClass;
    DivisibleStacks                = conf->DivisibleStacks;
    DisablePermEnchant             = conf->DisablePermEnchant;
    DisableConjured                = conf->DisableConjured;
    DisableGems                    = conf->DisableGems;
    DisableMoney                   = conf->DisableMoney;
    DisableMoneyLoot               = conf->DisableMoneyLoot;
    DisableLootable                = conf->DisableLootable;
    DisableKeys                    = conf->DisableKeys;
    DisableDuration                = conf->DisableDuration;
    DisableBOP_Or_Quest_NoReqLevel = conf->DisableBOP_Or_Quest_NoReqLevel;
    DisableWarriorItems            = conf->DisableWarriorItems;
    DisablePaladinItems            = conf->DisablePaladinItems;
    DisableHunterItems             = conf->DisableHunterItems;
    DisableRogueItems              = conf->DisableRogueItems;
    DisablePriestItems             = conf->DisablePriestItems;
    DisableDKItems                 = conf->DisableDKItems;
    DisableShamanItems             = conf->DisableShamanItems;
    DisableMageItems               = conf->DisableMageItems;
    DisableWarlockItems            = conf->DisableWarlockItems;
    DisableUnusedClassItems        = conf->DisableUnusedClassItems;
    DisableDruidItems              = conf->DisableDruidItems;
    DisableItemsBelowLevel         = conf->DisableItemsBelowLevel;
    DisableItemsAboveLevel         = conf->DisableItemsAboveLevel;
    DisableTGsBelowLevel           = conf->DisableTGsBelowLevel;
    DisableTGsAboveLevel           = conf->DisableTGsAboveLevel;
    DisableItemsBelowGUID          = conf->DisableItemsBelowGUID;
    DisableItemsAboveGUID          = conf->DisableItemsAboveGUID;
    DisableTGsBelowGUID            = conf->DisableTGsBelowGUID;
    DisableTGsAboveGUID            = conf->DisableTGsAboveGUID;
    DisableItemsBelowReqLevel      = conf->DisableItemsBelowReqLevel;
    DisableItemsAboveReqLevel      = conf->DisableItemsAboveReqLevel;
    DisableTGsBelowReqLevel        = conf->DisableTGsBelowReqLevel;
    DisableTGsAboveReqLevel        = conf->DisableTGsAboveReqLevel;
    DisableItemsBelowReqSkillRank  = conf->DisableItemsBelowReqSkillRank;
    DisableItemsAboveReqSkillRank  = conf->DisableItemsAboveReqSkillRank;
    DisableTGsBelowReqSkillRank    = conf->DisableTGsBelowReqSkillRank;
    DisableTGsAboveReqSkillRank    = conf->DisableTGsAboveReqSkillRank;

    //
    // Copy the sets
    //

    NpcItems.clear();
    for (uint32 id: conf->NpcItems)
    {
        NpcItems.insert(id);
    }

    LootItems.clear();
    for (uint32 id: conf->LootItems)
    {
        LootItems.insert(id);
    }

    DisableItemStore.clear();
    for (uint32 id: conf->DisableItemStore)
    {
        DisableItemStore.insert(id);
    }

    SellerWhiteList.clear();
    for (uint32 id: conf->SellerWhiteList)
    {
        SellerWhiteList.insert(id);
    }

    GreyTradeGoodsBin.clear();
    for (uint32 id: conf->GreyTradeGoodsBin)
    {
        GreyTradeGoodsBin.insert(id);
    }

    WhiteTradeGoodsBin.clear();
    for (uint32 id: conf->WhiteTradeGoodsBin)
    {
        WhiteTradeGoodsBin.insert(id);
    }

    GreenTradeGoodsBin.clear();
    for (uint32 id: conf->GreenTradeGoodsBin)
    {
        GreenTradeGoodsBin.insert(id);
    }

    BlueTradeGoodsBin.clear();
    for (uint32 id: conf->BlueTradeGoodsBin)
    {
        BlueTradeGoodsBin.insert(id);
    }

    PurpleTradeGoodsBin.clear();
    for (uint32 id: conf->PurpleTradeGoodsBin)
    {
        PurpleTradeGoodsBin.insert(id);
    }

    OrangeTradeGoodsBin.clear();
    for (uint32 id: conf->OrangeTradeGoodsBin)
    {
        OrangeTradeGoodsBin.insert(id);
    }

    YellowTradeGoodsBin.clear();
    for (uint32 id: conf->YellowTradeGoodsBin)
    {
        YellowTradeGoodsBin.insert(id);
    }


    //
    // Bins for items
    //

    GreyItemsBin.clear();
    for (uint32 id: conf->GreyItemsBin)
    {
        GreyItemsBin.insert(id);
    }

    WhiteItemsBin.clear();
    for (uint32 id: conf->WhiteItemsBin)
    {
        WhiteItemsBin.insert(id);
    }

    GreenItemsBin.clear();
    for (uint32 id: conf->GreenItemsBin)
    {
        GreenItemsBin.insert(id);
    }

    BlueItemsBin.clear();
    for (uint32 id: conf->BlueItemsBin)
    {
        BlueItemsBin.insert(id);
    }

    PurpleItemsBin.clear();
    for (uint32 id: conf->PurpleItemsBin)
    {
        PurpleItemsBin.insert(id);
    }

    OrangeItemsBin.clear();
    for (uint32 id: conf->OrangeItemsBin)
    {
        OrangeItemsBin.insert(id);
    }

    YellowItemsBin.clear();
    for (uint32 id: conf->YellowItemsBin)
    {
        YellowItemsBin.insert(id);
    }
}

AHBConfig::~AHBConfig()
{
}

void AHBConfig::Reset()
{
    //
    // Private variables
    //

    AHID                           = 0;
    AHFID                          = 0;

    minItems                       = 0;
    maxItems                       = 0;

    percentGreyTradeGoods          = 0;
    percentWhiteTradeGoods         = 0;
    percentGreenTradeGoods         = 0;
    percentBlueTradeGoods          = 0;
    percentPurpleTradeGoods        = 0;
    percentOrangeTradeGoods        = 0;
    percentYellowTradeGoods        = 0;

    percentGreyItems               = 0;
    percentWhiteItems              = 0;
    percentGreenItems              = 0;
    percentBlueItems               = 0;
    percentPurpleItems             = 0;
    percentOrangeItems             = 0;
    percentYellowItems             = 0;

    minPriceGrey                   = 0;
    maxPriceGrey                   = 0;
    minBidPriceGrey                = 0;
    maxBidPriceGrey                = 0;
    maxStackGrey                   = 0;

    minPriceWhite                  = 0;
    maxPriceWhite                  = 0;
    minBidPriceWhite               = 0;
    maxBidPriceWhite               = 0;
    maxStackWhite                  = 0;

    minPriceGreen                  = 0;
    maxPriceGreen                  = 0;
    minBidPriceGreen               = 0;
    maxBidPriceGreen               = 0;
    maxStackGreen                  = 0;

    minPriceBlue                   = 0;
    maxPriceBlue                   = 0;
    minBidPriceBlue                = 0;
    maxBidPriceBlue                = 0;
    maxStackBlue                   = 0;

    minPricePurple                 = 0;
    maxPricePurple                 = 0;
    minBidPricePurple              = 0;
    maxBidPricePurple              = 0;
    maxStackPurple                 = 0;

    minPriceOrange                 = 0;
    maxPriceOrange                 = 0;
    minBidPriceOrange              = 0;
    maxBidPriceOrange              = 0;
    maxStackOrange                 = 0;

    minPriceYellow                 = 0;
    maxPriceYellow                 = 0;
    minBidPriceYellow              = 0;
    maxBidPriceYellow              = 0;
    maxStackYellow                 = 0;

    buyerPriceGrey                 = 0;
    buyerPriceWhite                = 0;
    buyerPriceGreen                = 0;
    buyerPriceBlue                 = 0;
    buyerPricePurple               = 0;
    buyerPriceOrange               = 0;
    buyerPriceYellow               = 0;

    buyerBiddingInterval           = 0;
    buyerBidsPerInterval           = 0;

    greytgp                        = 0;
    whitetgp                       = 0;
    greentgp                       = 0;
    bluetgp                        = 0;
    purpletgp                      = 0;
    orangetgp                      = 0;
    yellowtgp                      = 0;

    greyip                         = 0;
    whiteip                        = 0;
    greenip                        = 0;
    blueip                         = 0;
    purpleip                       = 0;
    orangeip                       = 0;
    yellowip                       = 0;

    greyTGoods                     = 0;
    whiteTGoods                    = 0;
    greenTGoods                    = 0;
    blueTGoods                     = 0;
    purpleTGoods                   = 0;
    orangeTGoods                   = 0;
    yellowTGoods                   = 0;

    greyItems                      = 0;
    whiteItems                     = 0;
    greenItems                     = 0;
    blueItems                      = 0;
    purpleItems                    = 0;
    orangeItems                    = 0;
    yellowItems                    = 0;

    //
    // Public properties
    //

    DebugOut                       = false;
    DebugOutConfig                 = false;
    DebugOutFilters                = false;
    DebugOutBuyer                  = false;
    DebugOutSeller                 = false;

    TraceSeller                    = false;
    TraceBuyer                     = false;

    AHBSeller                      = false;
    AHBBuyer                       = false;

    UseBuyPriceForBuyer            = false;
    UseBuyPriceForSeller           = false;
    SellAtMarketPrice              = false;
    ConsiderOnlyBotAuctions        = false;
    ItemsPerCycle                  = 200;

    Vendor_Items                   = false;
    Loot_Items                     = true;
    Other_Items                    = false;
    Vendor_TGs                     = false;
    Loot_TGs                       = true;
    Other_TGs                      = false;
    Profession_Items               = false;

    No_Bind                        = true;
    Bind_When_Picked_Up            = true;
    Bind_When_Equipped             = false;
    Bind_When_Use                  = false;
    Bind_Quest_Item                = false;
    DuplicatesCount                = 0;
    ElapsingTimeClass              = 1;
    DivisibleStacks                = false;

    DisablePermEnchant             = false;
    DisableConjured                = false;
    DisableGems                    = false;
    DisableMoney                   = false;
    DisableMoneyLoot               = false;
    DisableLootable                = false;
    DisableKeys                    = false;
    DisableDuration                = false;
    DisableBOP_Or_Quest_NoReqLevel = false;

    DisableWarriorItems            = false;
    DisablePaladinItems            = false;
    DisableHunterItems             = false;
    DisableRogueItems              = false;
    DisablePriestItems             = false;
    DisableDKItems                 = false;
    DisableShamanItems             = false;
    DisableMageItems               = false;
    DisableWarlockItems            = false;
    DisableUnusedClassItems        = false;
    DisableDruidItems              = false;

    DisableItemsBelowLevel         = false;
    DisableItemsAboveLevel         = false;
    DisableTGsBelowLevel           = false;
    DisableTGsAboveLevel           = false;
    DisableItemsBelowGUID          = false;
    DisableItemsAboveGUID          = false;
    DisableTGsBelowGUID            = false;
    DisableTGsAboveGUID            = false;
    DisableItemsBelowReqLevel      = false;
    DisableItemsAboveReqLevel      = false;
    DisableTGsBelowReqLevel        = false;
    DisableTGsAboveReqLevel        = false;
    DisableItemsBelowReqSkillRank  = false;
    DisableItemsAboveReqSkillRank  = false;
    DisableTGsBelowReqSkillRank    = false;
    DisableTGsAboveReqSkillRank    = false;

    //
    // Sets
    //

    NpcItems.clear();
    LootItems.clear();

    DisableItemStore.clear();
    SellerWhiteList.clear();

    GreyTradeGoodsBin.clear();
    WhiteTradeGoodsBin.clear();
    GreenTradeGoodsBin.clear();
    BlueTradeGoodsBin.clear();
    PurpleTradeGoodsBin.clear();
    OrangeTradeGoodsBin.clear();
    YellowTradeGoodsBin.clear();

    GreyItemsBin.clear();
    WhiteItemsBin.clear();
    GreenItemsBin.clear();
    BlueItemsBin.clear();
    PurpleItemsBin.clear();
    OrangeItemsBin.clear();
    YellowItemsBin.clear();

    itemsCount.clear();
    itemsSum.clear();
    itemsPrice.clear();
}

uint32 AHBConfig::GetAHID()
{
    return AHID;
}

uint32 AHBConfig::GetAHFID()
{
    return AHFID;
}

void AHBConfig::SetMinItems(uint32 value)
{
    minItems = value;
}

uint32 AHBConfig::GetMinItems()
{
    if ((minItems == 0) && (maxItems))
    {
        return maxItems;
    }
    else if ((maxItems) && (minItems > maxItems))
    {
        return maxItems;
    }
    else
    {
        return minItems;
    }
}

void AHBConfig::SetMaxItems(uint32 value)
{
    maxItems = value;
    // CalculatePercents() needs to be called, but only if
    // SetPercentages() has been called at least once already.
}

uint32 AHBConfig::GetMaxItems()
{
    return maxItems;
}

void AHBConfig::SetPercentages(
    uint32 greytg,
    uint32 whitetg,
    uint32 greentg,
    uint32 bluetg,
    uint32 purpletg,
    uint32 orangetg,
    uint32 yellowtg,
    uint32 greyi,
    uint32 whitei,
    uint32 greeni,
    uint32 bluei,
    uint32 purplei,
    uint32 orangei,
    uint32 yellowi)
{
    uint32 totalPercent =
        greytg +
        whitetg +
        greentg +
        bluetg +
        purpletg +
        orangetg +
        yellowtg +
        greyi +
        whitei +
        greeni +
        bluei +
        purplei +
        orangei +
        yellowi;

    if (totalPercent == 0)
    {
        maxItems = 0;
    }
    else if (totalPercent != 100)
    {
        greytg   = 0;
        whitetg  = 27;
        greentg  = 12;
        bluetg   = 10;
        purpletg = 1;
        orangetg = 0;
        yellowtg = 0;

        greyi    = 0;
        whitei   = 10;
        greeni   = 30;
        bluei    = 8;
        purplei  = 2;
        orangei  = 0;
        yellowi  = 0;
    }

    percentGreyTradeGoods   = greytg;
    percentWhiteTradeGoods  = whitetg;
    percentGreenTradeGoods  = greentg;
    percentBlueTradeGoods   = bluetg;
    percentPurpleTradeGoods = purpletg;
    percentOrangeTradeGoods = orangetg;
    percentYellowTradeGoods = yellowtg;
    percentGreyItems        = greyi;
    percentWhiteItems       = whitei;
    percentGreenItems       = greeni;
    percentBlueItems        = bluei;
    percentPurpleItems      = purplei;
    percentOrangeItems      = orangei;
    percentYellowItems      = yellowi;

    CalculatePercents();
}

uint32 AHBConfig::GetPercentages(uint32 color)
{
    switch (color)
    {
    case AHB_GREY_TG:
        return percentGreyTradeGoods;
        break;

    case AHB_WHITE_TG:
        return percentWhiteTradeGoods;
        break;

    case AHB_GREEN_TG:
        return percentGreenTradeGoods;
        break;

    case AHB_BLUE_TG:
        return percentBlueTradeGoods;
        break;

    case AHB_PURPLE_TG:
        return percentPurpleTradeGoods;
        break;

    case AHB_ORANGE_TG:
        return percentOrangeTradeGoods;
        break;

    case AHB_YELLOW_TG:
        return percentYellowTradeGoods;
        break;

    case AHB_GREY_I:
        return percentGreyItems;
        break;

    case AHB_WHITE_I:
        return percentWhiteItems;
        break;

    case AHB_GREEN_I:
        return percentGreenItems;
        break;

    case AHB_BLUE_I:
        return percentBlueItems;
        break;

    case AHB_PURPLE_I:
        return percentPurpleItems;
        break;

    case AHB_ORANGE_I:
        return percentOrangeItems;
        break;

    case AHB_YELLOW_I:
        return percentYellowItems;
        break;

    default:
        return 0;
        break;
    }
}

void AHBConfig::SetMinPrice(uint32 color, uint32 value)
{
    switch (color)
    {
    case AHB_GREY:
        minPriceGrey = value;
        break;

    case AHB_WHITE:
        minPriceWhite = value;
        break;

    case AHB_GREEN:
        minPriceGreen = value;
        break;

    case AHB_BLUE:
        minPriceBlue = value;
        break;

    case AHB_PURPLE:
        minPricePurple = value;
        break;

    case AHB_ORANGE:
        minPriceOrange = value;
        break;

    case AHB_YELLOW:
        minPriceYellow = value;
        break;

    default:
        break;
    }
}

uint32 AHBConfig::GetMinPrice(uint32 color)
{
    switch (color)
    {
    case AHB_GREY:
    {
        if (minPriceGrey == 0)
        {
            return 100;
        }
        else if (minPriceGrey > maxPriceGrey)
        {
            return maxPriceGrey;
        }
        else
        {
            return minPriceGrey;
        }

        break;
    }

    case AHB_WHITE:
    {
        if (minPriceWhite == 0)
        {
            return 150;
        }
        else if (minPriceWhite > maxPriceWhite)
        {
            return maxPriceWhite;
        }
        else
        {
            return minPriceWhite;
        }

        break;
    }

    case AHB_GREEN:
    {
        if (minPriceGreen == 0)
        {
            return 200;
        }
        else if (minPriceGreen > maxPriceGreen)
        {
            return maxPriceGreen;
        }
        else
        {
            return minPriceGreen;
        }

        break;
    }

    case AHB_BLUE:
    {
        if (minPriceBlue == 0)
        {
            return 250;
        }
        else if (minPriceBlue > maxPriceBlue)
        {
            return maxPriceBlue;
        }
        else
        {
            return minPriceBlue;
        }

        break;
    }

    case AHB_PURPLE:
    {
        if (minPricePurple == 0)
        {
            return 300;
        }
        else if (minPricePurple > maxPricePurple)
        {
            return maxPricePurple;
        }
        else
        {
            return minPricePurple;
        }

        break;
    }

    case AHB_ORANGE:
    {
        if (minPriceOrange == 0)
        {
            return 400;
        }
        else if (minPriceOrange > maxPriceOrange)
        {
            return maxPriceOrange;
        }
        else
        {
            return minPriceOrange;
        }

        break;
    }

    case AHB_YELLOW:
    {
        if (minPriceYellow == 0)
        {
            return 500;
        }
        else if (minPriceYellow > maxPriceYellow)
        {
            return maxPriceYellow;
        }
        else
        {
            return minPriceYellow;
        }

        break;
    }

    default:
        return 0;
    }
}

void AHBConfig::SetMaxPrice(uint32 color, uint32 value)
{
    switch (color)
    {
    case AHB_GREY:
        maxPriceGrey = value;
        break;

    case AHB_WHITE:
        maxPriceWhite = value;
        break;

    case AHB_GREEN:
        maxPriceGreen = value;
        break;

    case AHB_BLUE:
        maxPriceBlue = value;
        break;

    case AHB_PURPLE:
        maxPricePurple = value;
        break;

    case AHB_ORANGE:
        maxPriceOrange = value;
        break;

    case AHB_YELLOW:
        maxPriceYellow = value;
        break;

    default:
        break;
    }
}

uint32 AHBConfig::GetMaxPrice(uint32 color)
{
    switch (color)
    {
    case AHB_GREY:
    {
        if (maxPriceGrey == 0)
        {
            return 150;
        }
        else
        {
            return maxPriceGrey;
        }

        break;
    }

    case AHB_WHITE:
    {
        if (maxPriceWhite == 0)
        {
            return 250;
        }
        else
        {
            return maxPriceWhite;
        }

        break;
    }

    case AHB_GREEN:
    {
        if (maxPriceGreen == 0)
        {
            return 300;
        }
        else
        {
            return maxPriceGreen;
        }

        break;
    }

    case AHB_BLUE:
    {
        if (maxPriceBlue == 0)
        {
            return 350;
        }
        else
        {
            return maxPriceBlue;
        }

        break;
    }

    case AHB_PURPLE:
    {
        if (maxPricePurple == 0)
        {
            return 450;
        }
        else
        {
            return maxPricePurple;
        }

        break;
    }

    case AHB_ORANGE:
    {
        if (maxPriceOrange == 0)
        {
            return 550;
        }
        else
        {
            return maxPriceOrange;
        }

        break;
    }

    case AHB_YELLOW:
    {
        if (maxPriceYellow == 0)
        {
            return 650;
        }
        else
        {
            return maxPriceYellow;
        }

        break;
    }

    default:
        return 0;

    }
}

void AHBConfig::SetMinBidPrice(uint32 color, uint32 value)
{
    switch (color)
    {
    case AHB_GREY:
        minBidPriceGrey = value;
        break;

    case AHB_WHITE:
        minBidPriceWhite = value;
        break;

    case AHB_GREEN:
        minBidPriceGreen = value;
        break;

    case AHB_BLUE:
        minBidPriceBlue = value;
        break;

    case AHB_PURPLE:
        minBidPricePurple = value;
        break;

    case AHB_ORANGE:
        minBidPriceOrange = value;
        break;

    case AHB_YELLOW:
        minBidPriceYellow = value;
        break;

    default:
        break;
    }
}

uint32 AHBConfig::GetMinBidPrice(uint32 color)
{
    switch (color)
    {
    case AHB_GREY:
    {
        if (minBidPriceGrey > 100)
        {
            return 100;
        }
        else
        {
            return minBidPriceGrey;
        }

        break;
    }

    case AHB_WHITE:
    {
        if (minBidPriceWhite > 100)
        {
            return 100;
        }
        else
        {
            return minBidPriceWhite;
        }

        break;
    }

    case AHB_GREEN:
    {
        if (minBidPriceGreen > 100)
        {
            return 100;
        }
        else
        {
            return minBidPriceGreen;
        }

        break;
    }

    case AHB_BLUE:
    {
        if (minBidPriceBlue > 100)
        {
            return 100;
        }
        else
        {
            return minBidPriceBlue;
        }

        break;
    }

    case AHB_PURPLE:
    {
        if (minBidPricePurple > 100)
        {
            return 100;
        }
        else
        {
            return minBidPricePurple;
        }

        break;
    }

    case AHB_ORANGE:
    {
        if (minBidPriceOrange > 100)
        {
            return 100;
        }
        else
        {
            return minBidPriceOrange;
        }

        break;
    }

    case AHB_YELLOW:
    {
        if (minBidPriceYellow > 100)
        {
            return 100;
        }
        else
        {
            return minBidPriceYellow;
        }

        break;
    }

    default:
        return 0;
    }
}

void AHBConfig::SetMaxBidPrice(uint32 color, uint32 value)
{
    switch (color)
    {
    case AHB_GREY:
        maxBidPriceGrey = value;
        break;

    case AHB_WHITE:
        maxBidPriceWhite = value;
        break;

    case AHB_GREEN:
        maxBidPriceGreen = value;
        break;

    case AHB_BLUE:
        maxBidPriceBlue = value;
        break;

    case AHB_PURPLE:
        maxBidPricePurple = value;
        break;

    case AHB_ORANGE:
        maxBidPriceOrange = value;
        break;

    case AHB_YELLOW:
        maxBidPriceYellow = value;
        break;

    default:
        break;
    }

}
uint32 AHBConfig::GetMaxBidPrice(uint32 color)
{
    switch (color)
    {
    case AHB_GREY:
    {
        if (maxBidPriceGrey > 100)
        {
            return 100;
        }
        else
        {
            return maxBidPriceGrey;
        }

        break;
    }

    case AHB_WHITE:
    {
        if (maxBidPriceWhite > 100)
        {
            return 100;
        }
        else
        {
            return maxBidPriceWhite;
        }

        break;
    }

    case AHB_GREEN:
    {
        if (maxBidPriceGreen > 100)
        {
            return 100;
        }
        else
        {
            return maxBidPriceGreen;
        }

        break;
    }

    case AHB_BLUE:
    {
        if (maxBidPriceBlue > 100)
        {
            return 100;
        }
        else
        {
            return maxBidPriceBlue;
        }

        break;
    }

    case AHB_PURPLE:
    {
        if (maxBidPricePurple > 100)
        {
            return 100;
        }
        else
        {
            return maxBidPricePurple;
        }

        break;
    }

    case AHB_ORANGE:
    {
        if (maxBidPriceOrange > 100)
        {
            return 100;
        }
        else
        {
            return maxBidPriceOrange;
        }

        break;
    }

    case AHB_YELLOW:
    {
        if (maxBidPriceYellow > 100)
        {
            return 100;
        }
        else
        {
            return maxBidPriceYellow;
        }

        break;
    }

    default:
        return 0;
    }
}

void AHBConfig::SetMaxStack(uint32 color, uint32 value)
{
    switch (color)
    {
    case AHB_GREY:
        maxStackGrey = value;
        break;

    case AHB_WHITE:
        maxStackWhite = value;
        break;

    case AHB_GREEN:
        maxStackGreen = value;
        break;

    case AHB_BLUE:
        maxStackBlue = value;
        break;

    case AHB_PURPLE:
        maxStackPurple = value;
        break;

    case AHB_ORANGE:
        maxStackOrange = value;
        break;

    case AHB_YELLOW:
        maxStackYellow = value;
        break;

    default:
        break;
    }
}

uint32 AHBConfig::GetMaxStack(uint32 color)
{
    switch (color)
    {
    case AHB_GREY:
    {
        return maxStackGrey;
        break;
    }

    case AHB_WHITE:
    {
        return maxStackWhite;
        break;
    }

    case AHB_GREEN:
    {
        return maxStackGreen;
        break;
    }

    case AHB_BLUE:
    {
        return maxStackBlue;
        break;
    }

    case AHB_PURPLE:
    {
        return maxStackPurple;
        break;
    }

    case AHB_ORANGE:
    {
        return maxStackOrange;
        break;
    }

    case AHB_YELLOW:
    {
        return maxStackYellow;
        break;
    }

    default:
        return 0;
    }
}

void AHBConfig::SetBuyerPrice(uint32 color, uint32 value)
{
    switch (color)
    {
    case AHB_GREY:
        buyerPriceGrey = value;
        break;

    case AHB_WHITE:
        buyerPriceWhite = value;
        break;

    case AHB_GREEN:
        buyerPriceGreen = value;
        break;

    case AHB_BLUE:
        buyerPriceBlue = value;
        break;

    case AHB_PURPLE:
        buyerPricePurple = value;
        break;

    case AHB_ORANGE:
        buyerPriceOrange = value;
        break;

    case AHB_YELLOW:
        buyerPriceYellow = value;
        break;

    default:
        break;
    }
}

uint32 AHBConfig::GetBuyerPrice(uint32 color)
{
    switch (color)
    {
    case AHB_GREY:
        return buyerPriceGrey;
        break;

    case AHB_WHITE:
        return buyerPriceWhite;
        break;

    case AHB_GREEN:
        return buyerPriceGreen;
        break;

    case AHB_BLUE:
        return buyerPriceBlue;
        break;

    case AHB_PURPLE:
        return buyerPricePurple;
        break;

    case AHB_ORANGE:
        return buyerPriceOrange;
        break;

    case AHB_YELLOW:
        return buyerPriceYellow;
        break;

    default:
        return 0;
        break;
    }
}

void AHBConfig::SetBiddingInterval(uint32 value)
{
    buyerBiddingInterval = value;
}

uint32 AHBConfig::GetBiddingInterval()
{
    return buyerBiddingInterval;
}

void AHBConfig::CalculatePercents()
{
    //
    // Use the percent values to setup the maximum amount of items per category
    // to be sold in the market
    //

    greytgp   = (uint32)(((double)percentGreyTradeGoods / 100.0) * maxItems);
    whitetgp  = (uint32)(((double)percentWhiteTradeGoods / 100.0) * maxItems);
    greentgp  = (uint32)(((double)percentGreenTradeGoods / 100.0) * maxItems);
    bluetgp   = (uint32)(((double)percentBlueTradeGoods / 100.0) * maxItems);
    purpletgp = (uint32)(((double)percentPurpleTradeGoods / 100.0) * maxItems);
    orangetgp = (uint32)(((double)percentOrangeTradeGoods / 100.0) * maxItems);
    yellowtgp = (uint32)(((double)percentYellowTradeGoods / 100.0) * maxItems);

    greyip    = (uint32)(((double)percentGreyItems / 100.0) * maxItems);
    whiteip   = (uint32)(((double)percentWhiteItems / 100.0) * maxItems);
    greenip   = (uint32)(((double)percentGreenItems / 100.0) * maxItems);
    blueip    = (uint32)(((double)percentBlueItems / 100.0) * maxItems);
    purpleip  = (uint32)(((double)percentPurpleItems / 100.0) * maxItems);
    orangeip  = (uint32)(((double)percentOrangeItems / 100.0) * maxItems);
    yellowip  = (uint32)(((double)percentYellowItems / 100.0) * maxItems);

    uint32 total =
        greytgp +
        whitetgp +
        greentgp +
        bluetgp +
        purpletgp +
        orangetgp +
        yellowtgp +
        greyip +
        whiteip +
        greenip +
        blueip +
        purpleip +
        orangeip +
        yellowip;

    int32 diff = (maxItems - total);

    if (diff < 0)
    {
        if ((whiteip - diff) > 0)
        {
            whiteip -= diff;
        }
        else if ((greenip - diff) > 0)
        {
            greenip -= diff;
        }
    }
}

uint32 AHBConfig::GetMaximum(uint32 ahbotItemType)
{
    switch (ahbotItemType)
    {
    case AHB_GREY_TG:
        return greytgp;

    case AHB_WHITE_TG:
        return whitetgp;

    case AHB_GREEN_TG:
        return greentgp;

    case AHB_BLUE_TG:
        return bluetgp;

    case AHB_PURPLE_TG:
        return purpletgp;

    case AHB_ORANGE_TG:
        return orangetgp;

    case AHB_YELLOW_TG:
        return yellowtgp;

    case AHB_GREY_I:
        return greyip;

    case AHB_WHITE_I:
        return whiteip;

    case AHB_GREEN_I:
        return greenip;

    case AHB_BLUE_I:
        return blueip;

    case AHB_PURPLE_I:
        return purpleip;

    case AHB_ORANGE_I:
        return orangeip;

    case AHB_YELLOW_I:
        return yellowip;

    default:
    {
        LOG_ERROR("module", "AHBot AHBConfig::GetMaximum() invalid param");
        return 0;
    }
    }
}

void AHBConfig::DecItemCounts(uint32 Class, uint32 Quality)
{
    switch (Class)
    {
    case ITEM_CLASS_TRADE_GOODS:
        DecItemCounts(Quality);
        break;

    default:
        DecItemCounts(Quality + AHB_ITEM_TYPE_OFFSET);
        break;
    }
}

void AHBConfig::DecItemCounts(uint32 ahbotItemType)
{
    switch (ahbotItemType)
    {
    case AHB_GREY_TG:
        if (greyTGoods > 0)
        {
            --greyTGoods;
        }
        break;

    case AHB_WHITE_TG:
        if (whiteTGoods > 0)
        {
            --whiteTGoods;
        }
        break;

    case AHB_GREEN_TG:        
        if (greenTGoods > 0)
        {
            --greenTGoods;
        }
        break;

    case AHB_BLUE_TG:
        if (blueTGoods > 0)
        {
            --blueTGoods;
        }
        break;

    case AHB_PURPLE_TG:
        if (purpleTGoods > 0)
        {
            --purpleTGoods;
        }
        break;

    case AHB_ORANGE_TG:
        if (orangeTGoods > 0)
        {
            --orangeTGoods;        
        }
        break;

    case AHB_YELLOW_TG:
        if (yellowTGoods > 0)
        {
            --yellowTGoods;
        }
        break;

    case AHB_GREY_I:
        if (greyItems > 0)
        {
            --greyItems;
        }
        break;

    case AHB_WHITE_I:
        if (whiteItems > 0)
        {
            --whiteItems;
        }
        break;

    case AHB_GREEN_I:
        if (greenItems > 0)
        {
            --greenItems;
        }
        break;

    case AHB_BLUE_I:
        if (blueItems > 0)
        {
            --blueItems;
        }
        break;

    case AHB_PURPLE_I:
        if (purpleItems > 0)
        {
            --purpleItems;
        }
        break;

    case AHB_ORANGE_I:
        if (orangeItems > 0)
        {
            --orangeItems;
        }
        break;

    case AHB_YELLOW_I:
        if (yellowItems > 0)
        {
            --yellowItems;
        }
        break;

    default:
        break;
    }
}

void AHBConfig::IncItemCounts(uint32 Class, uint32 Quality)
{
    switch (Class)
    {
    case ITEM_CLASS_TRADE_GOODS:
        IncItemCounts(Quality);
        break;

    default:
        IncItemCounts(Quality + 7);
        break;
    }
}

void AHBConfig::IncItemCounts(uint32 ahbotItemType)
{
    switch (ahbotItemType)
    {
    case AHB_GREY_TG:
        ++greyTGoods;
        break;

    case AHB_WHITE_TG:
        ++whiteTGoods;
        break;

    case AHB_GREEN_TG:
        ++greenTGoods;
        break;

    case AHB_BLUE_TG:
        ++blueTGoods;
        break;

    case AHB_PURPLE_TG:
        ++purpleTGoods;
        break;

    case AHB_ORANGE_TG:
        ++orangeTGoods;
        break;

    case AHB_YELLOW_TG:
        ++yellowTGoods;
        break;

    case AHB_GREY_I:
        ++greyItems;
        break;

    case AHB_WHITE_I:
        ++whiteItems;
        break;

    case AHB_GREEN_I:
        ++greenItems;
        break;

    case AHB_BLUE_I:
        ++blueItems;
        break;

    case AHB_PURPLE_I:
        ++purpleItems;
        break;

    case AHB_ORANGE_I:
        ++orangeItems;
        break;

    case AHB_YELLOW_I:
        ++yellowItems;
        break;

    default:
        break;
    }
}

void AHBConfig::ResetItemCounts()
{
    greyTGoods   = 0;
    whiteTGoods  = 0;
    greenTGoods  = 0;
    blueTGoods   = 0;
    purpleTGoods = 0;
    orangeTGoods = 0;
    yellowTGoods = 0;

    greyItems    = 0;
    whiteItems   = 0;
    greenItems   = 0;
    blueItems    = 0;
    purpleItems  = 0;
    orangeItems  = 0;
    yellowItems  = 0;
}

uint32 AHBConfig::TotalItemCounts()
{
    return(
        greyTGoods +
        whiteTGoods +
        greenTGoods +
        blueTGoods +
        purpleTGoods +
        orangeTGoods +
        yellowTGoods +

        greyItems +
        whiteItems +
        greenItems +
        blueItems +
        purpleItems +
        orangeItems +
        yellowItems);
}

uint32 AHBConfig::GetItemCounts(uint32 color)
{
    switch (color)
    {
    case AHB_GREY_TG:
        return greyTGoods;
        break;

    case AHB_WHITE_TG:
        return whiteTGoods;
        break;

    case AHB_GREEN_TG:
        return greenTGoods;
        break;

    case AHB_BLUE_TG:
        return blueTGoods;
        break;

    case AHB_PURPLE_TG:
        return purpleTGoods;
        break;

    case AHB_ORANGE_TG:
        return orangeTGoods;
        break;

    case AHB_YELLOW_TG:
        return yellowTGoods;
        break;

    case AHB_GREY_I:
        return greyItems;
        break;

    case AHB_WHITE_I:
        return whiteItems;
        break;

    case AHB_GREEN_I:
        return greenItems;
        break;

    case AHB_BLUE_I:
        return blueItems;
        break;

    case AHB_PURPLE_I:
        return purpleItems;
        break;

    case AHB_ORANGE_I:
        return orangeItems;
        break;

    case AHB_YELLOW_I:
        return yellowItems;
        break;

    default:
        return 0;
        break;
    }
}

void AHBConfig::SetBidsPerInterval(uint32 value)
{
    buyerBidsPerInterval = value;
}

uint32 AHBConfig::GetBidsPerInterval()
{
    return buyerBidsPerInterval;
}

void AHBConfig::UpdateItemStats(uint32 id, uint32 stackSize, uint64 buyout)
{
    if (!stackSize)
    {
        return;
    }

    // 
    // Collects information about the item bought
    //

    uint32 perUnit = buyout / stackSize;

    if (itemsCount.count(id) == 0)
    {
        itemsCount[id] = 1;
        itemsSum[id]   = perUnit;
        itemsPrice[id] = perUnit;
    }
    else
    {
        itemsCount[id]++;

        //
        // Reset the statistics to force adapt to the market price.
        // Adds a little of randomness by adding/removing a range of 9 to the threshold.
        //

        if (itemsCount[id] > MarketResetThreshold + (urand(1, 19) - 10))
        {
            itemsCount[id] = 1;
            itemsSum[id]   = perUnit;
            itemsPrice[id] = perUnit;
        }
        else
        {
            //
            // Here is decided the price for single unit:
            // right now is a plain, boring average of the ~100 previous auctions.
            //

            itemsSum[id]   = (itemsSum[id] + perUnit);
            itemsPrice[id] = itemsSum[id] / itemsCount[id];
        }
    }

    if (DebugOutConfig)
    {
        LOG_INFO("module", "Updating market price item={}, price={}", id, itemsPrice[id]);
    }
}

uint64 AHBConfig::GetItemPrice(uint32 id)
{
    if (itemsCount.count(id) != 0)
    {
        return itemsPrice[id];
    }

    return 0;
}

void AHBConfig::Initialize(std::set<uint32> botsIds)
{
    InitializeFromFile();
    InitializeFromSql(botsIds);
    InitializeBins();
}

void AHBConfig::InitializeFromFile()
{
    //
    // Load from, the configuration file
    //

    DebugOut                       = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DEBUG"        , false);
    DebugOutConfig                 = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DEBUG_CONFIG" , false);
    DebugOutFilters                = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DEBUG_FILTERS", false);
    DebugOutBuyer                  = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DEBUG_BUYER"  , false);
    DebugOutSeller                 = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DEBUG_SELLER" , false);

    TraceSeller                    = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.TRACE_SELLER" , false);
    TraceBuyer                     = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.TRACE_BUYER"  , false);

    AHBSeller                      = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.EnableSeller"           , false);
    AHBBuyer                       = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.EnableBuyer"            , false);
    UseBuyPriceForSeller           = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.UseBuyPriceForSeller"   , false);
    UseBuyPriceForBuyer            = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.UseBuyPriceForBuyer"    , false);
    SellAtMarketPrice              = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.UseMarketPriceForSeller", false);
    MarketResetThreshold           = sConfigMgr->GetOption<uint32>("AuctionHouseBot.MarketResetThreshold"   , 25);
    DuplicatesCount                = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DuplicatesCount"        , 0);
    DivisibleStacks                = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DivisibleStacks"        , false);
    ElapsingTimeClass              = sConfigMgr->GetOption<uint32>("AuctionHouseBot.ElapsingTimeClass"      , 1);
    ConsiderOnlyBotAuctions        = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.ConsiderOnlyBotAuctions", false);
    ItemsPerCycle                  = sConfigMgr->GetOption<uint32>("AuctionHouseBot.ItemsPerCycle"          , 200);

    //
    // Flags: item types
    //

    Vendor_Items                   = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.VendorItems"      , false);
    Loot_Items                     = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.LootItems"        , true);
    Other_Items                    = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.OtherItems"       , false);
    Vendor_TGs                     = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.VendorTradeGoods" , false);
    Loot_TGs                       = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.LootTradeGoods"   , true);
    Other_TGs                      = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.OtherTradeGoods"  , false);
    Profession_Items               = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.ProfessionItems"  , false);

    //
    // Flags: items binding
    //

    No_Bind                        = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.No_Bind"             , true);
    Bind_When_Picked_Up            = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.Bind_When_Picked_Up" , false);
    Bind_When_Equipped             = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.Bind_When_Equipped"  , true);
    Bind_When_Use                  = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.Bind_When_Use"       , true);
    Bind_Quest_Item                = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.Bind_Quest_Item"     , false);

    //
    // Flags: misc
    //

    DisableConjured                = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableConjured"               , false);
    DisableGems                    = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableGems"                   , false);
    DisableMoney                   = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableMoney"                  , false);
    DisableMoneyLoot               = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableMoneyLoot"              , false);
    DisableLootable                = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableLootable"               , false);
    DisableKeys                    = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableKeys"                   , false);
    DisableDuration                = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableDuration"               , false);
    DisableBOP_Or_Quest_NoReqLevel = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableBOP_Or_Quest_NoReqLevel", false);

    //
    // Flags: items per class
    //

    DisableWarriorItems            = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableWarriorItems"    , false);
    DisablePaladinItems            = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisablePaladinItems"    , false);
    DisableHunterItems             = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableHunterItems"     , false);
    DisableRogueItems              = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableRogueItems"      , false);
    DisablePriestItems             = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisablePriestItems"     , false);
    DisableDKItems                 = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableDKItems"         , false);
    DisableShamanItems             = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableShamanItems"     , false);
    DisableMageItems               = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableMageItems"       , false);
    DisableWarlockItems            = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableWarlockItems"    , false);
    DisableUnusedClassItems        = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableUnusedClassItems", false);
    DisableDruidItems              = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DisableDruidItems"      , false);

    //
    // Items level and skills
    //

    DisableItemsBelowLevel         = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableItemsBelowLevel"       , 0);
    DisableItemsAboveLevel         = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableItemsAboveLevel"       , 0);
    DisableItemsBelowGUID          = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableItemsBelowGUID"        , 0);
    DisableItemsAboveGUID          = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableItemsAboveGUID"        , 0);
    DisableItemsBelowReqLevel      = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableItemsBelowReqLevel"    , 0);
    DisableItemsAboveReqLevel      = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableItemsAboveReqLevel"    , 0);
    DisableItemsBelowReqSkillRank  = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableItemsBelowReqSkillRank", 0);
    DisableItemsAboveReqSkillRank  = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableItemsAboveReqSkillRank", 0);

    //
    // Trade goods level and skills
    //

    DisableTGsBelowLevel           = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableTGsBelowLevel"       , 0);
    DisableTGsAboveLevel           = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableTGsAboveLevel"       , 0);
    DisableTGsBelowGUID            = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableTGsBelowGUID"        , 0);
    DisableTGsAboveGUID            = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableTGsAboveGUID"        , 0);
    DisableTGsBelowReqLevel        = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableTGsBelowReqLevel"    , 0);
    DisableTGsAboveReqLevel        = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableTGsAboveReqLevel"    , 0);
    DisableTGsBelowReqSkillRank    = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableTGsBelowReqSkillRank", 0);
    DisableTGsAboveReqSkillRank    = sConfigMgr->GetOption<uint32>("AuctionHouseBot.DisableTGsAboveReqSkillRank", 0);

    //
    // Whitelists
    //

    SellerWhiteList                = getCommaSeparatedIntegers(sConfigMgr->GetOption<std::string>("AuctionHouseBot.SellerWhiteList", ""));
}

void AHBConfig::InitializeFromSql(std::set<uint32> botsIds)
{
    //
    // Load min and max items
    //

    SetMinItems(WorldDatabase.Query("SELECT minitems FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxItems(WorldDatabase.Query("SELECT maxitems FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());

    //
    // Load percentages
    //

    uint32 greytg   = WorldDatabase.Query("SELECT percentgreytradegoods   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 whitetg  = WorldDatabase.Query("SELECT percentwhitetradegoods  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 greentg  = WorldDatabase.Query("SELECT percentgreentradegoods  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 bluetg   = WorldDatabase.Query("SELECT percentbluetradegoods   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 purpletg = WorldDatabase.Query("SELECT percentpurpletradegoods FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 orangetg = WorldDatabase.Query("SELECT percentorangetradegoods FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 yellowtg = WorldDatabase.Query("SELECT percentyellowtradegoods FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();

    uint32 greyi    = WorldDatabase.Query("SELECT percentgreyitems        FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 whitei   = WorldDatabase.Query("SELECT percentwhiteitems       FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 greeni   = WorldDatabase.Query("SELECT percentgreenitems       FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 bluei    = WorldDatabase.Query("SELECT percentblueitems        FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 purplei  = WorldDatabase.Query("SELECT percentpurpleitems      FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 orangei  = WorldDatabase.Query("SELECT percentorangeitems      FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();
    uint32 yellowi  = WorldDatabase.Query("SELECT percentyellowitems      FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>();

    SetPercentages(greytg, whitetg, greentg, bluetg, purpletg, orangetg, yellowtg, greyi, whitei, greeni, bluei, purplei, orangei, yellowi);

    // 
    // Load min and max prices
    // 

    SetMinPrice(AHB_GREY  , WorldDatabase.Query("SELECT minpricegrey   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxPrice(AHB_GREY  , WorldDatabase.Query("SELECT maxpricegrey   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinPrice(AHB_WHITE , WorldDatabase.Query("SELECT minpricewhite  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxPrice(AHB_WHITE , WorldDatabase.Query("SELECT maxpricewhite  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinPrice(AHB_GREEN , WorldDatabase.Query("SELECT minpricegreen  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxPrice(AHB_GREEN , WorldDatabase.Query("SELECT maxpricegreen  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinPrice(AHB_BLUE  , WorldDatabase.Query("SELECT minpriceblue   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxPrice(AHB_BLUE  , WorldDatabase.Query("SELECT maxpriceblue   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinPrice(AHB_PURPLE, WorldDatabase.Query("SELECT minpricepurple FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxPrice(AHB_PURPLE, WorldDatabase.Query("SELECT maxpricepurple FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinPrice(AHB_ORANGE, WorldDatabase.Query("SELECT minpriceorange FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxPrice(AHB_ORANGE, WorldDatabase.Query("SELECT maxpriceorange FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinPrice(AHB_YELLOW, WorldDatabase.Query("SELECT minpriceyellow FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxPrice(AHB_YELLOW, WorldDatabase.Query("SELECT maxpriceyellow FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());

    // 
    // Load min and max bid prices
    // 

    SetMinBidPrice(AHB_GREY  , WorldDatabase.Query("SELECT minbidpricegrey   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxBidPrice(AHB_GREY  , WorldDatabase.Query("SELECT maxbidpricegrey   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinBidPrice(AHB_WHITE , WorldDatabase.Query("SELECT minbidpricewhite  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxBidPrice(AHB_WHITE , WorldDatabase.Query("SELECT maxbidpricewhite  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinBidPrice(AHB_GREEN , WorldDatabase.Query("SELECT minbidpricegreen  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxBidPrice(AHB_GREEN , WorldDatabase.Query("SELECT maxbidpricegreen  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinBidPrice(AHB_BLUE  , WorldDatabase.Query("SELECT minbidpriceblue   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxBidPrice(AHB_BLUE  , WorldDatabase.Query("SELECT maxbidpriceblue   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinBidPrice(AHB_PURPLE, WorldDatabase.Query("SELECT minbidpricepurple FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxBidPrice(AHB_PURPLE, WorldDatabase.Query("SELECT maxbidpricepurple FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinBidPrice(AHB_ORANGE, WorldDatabase.Query("SELECT minbidpriceorange FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxBidPrice(AHB_ORANGE, WorldDatabase.Query("SELECT maxbidpriceorange FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMinBidPrice(AHB_YELLOW, WorldDatabase.Query("SELECT minbidpriceyellow FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxBidPrice(AHB_YELLOW, WorldDatabase.Query("SELECT maxbidpriceyellow FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());

    // 
    // Load max stacks
    // 

    SetMaxStack(AHB_GREY  , WorldDatabase.Query("SELECT maxstackgrey   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxStack(AHB_WHITE , WorldDatabase.Query("SELECT maxstackwhite  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxStack(AHB_GREEN , WorldDatabase.Query("SELECT maxstackgreen  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxStack(AHB_BLUE  , WorldDatabase.Query("SELECT maxstackblue   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxStack(AHB_PURPLE, WorldDatabase.Query("SELECT maxstackpurple FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxStack(AHB_ORANGE, WorldDatabase.Query("SELECT maxstackorange FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetMaxStack(AHB_YELLOW, WorldDatabase.Query("SELECT maxstackyellow FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());

    if (DebugOutConfig)
    {
        LOG_INFO("module", "Settings for Auctionhouse {}", GetAHID());

        LOG_INFO("module", "minItems                = {}", GetMinItems());
        LOG_INFO("module", "maxItems                = {}", GetMaxItems());

        LOG_INFO("module", "percentGreyTradeGoods   = {}", GetPercentages(AHB_GREY_TG));
        LOG_INFO("module", "percentWhiteTradeGoods  = {}", GetPercentages(AHB_WHITE_TG));
        LOG_INFO("module", "percentGreenTradeGoods  = {}", GetPercentages(AHB_GREEN_TG));
        LOG_INFO("module", "percentBlueTradeGoods   = {}", GetPercentages(AHB_BLUE_TG));
        LOG_INFO("module", "percentPurpleTradeGoods = {}", GetPercentages(AHB_PURPLE_TG));
        LOG_INFO("module", "percentOrangeTradeGoods = {}", GetPercentages(AHB_ORANGE_TG));
        LOG_INFO("module", "percentYellowTradeGoods = {}", GetPercentages(AHB_YELLOW_TG));
        LOG_INFO("module", "percentGreyItems        = {}", GetPercentages(AHB_GREY_I));
        LOG_INFO("module", "percentWhiteItems       = {}", GetPercentages(AHB_WHITE_I));
        LOG_INFO("module", "percentGreenItems       = {}", GetPercentages(AHB_GREEN_I));
        LOG_INFO("module", "percentBlueItems        = {}", GetPercentages(AHB_BLUE_I));
        LOG_INFO("module", "percentPurpleItems      = {}", GetPercentages(AHB_PURPLE_I));
        LOG_INFO("module", "percentOrangeItems      = {}", GetPercentages(AHB_ORANGE_I));
        LOG_INFO("module", "percentYellowItems      = {}", GetPercentages(AHB_YELLOW_I));

        LOG_INFO("module", "minPriceGrey            = {}", GetMinPrice(AHB_GREY));
        LOG_INFO("module", "maxPriceGrey            = {}", GetMaxPrice(AHB_GREY));
        LOG_INFO("module", "minPriceWhite           = {}", GetMinPrice(AHB_WHITE));
        LOG_INFO("module", "maxPriceWhite           = {}", GetMaxPrice(AHB_WHITE));
        LOG_INFO("module", "minPriceGreen           = {}", GetMinPrice(AHB_GREEN));
        LOG_INFO("module", "maxPriceGreen           = {}", GetMaxPrice(AHB_GREEN));
        LOG_INFO("module", "minPriceBlue            = {}", GetMinPrice(AHB_BLUE));
        LOG_INFO("module", "maxPriceBlue            = {}", GetMaxPrice(AHB_BLUE));
        LOG_INFO("module", "minPricePurple          = {}", GetMinPrice(AHB_PURPLE));
        LOG_INFO("module", "maxPricePurple          = {}", GetMaxPrice(AHB_PURPLE));
        LOG_INFO("module", "minPriceOrange          = {}", GetMinPrice(AHB_ORANGE));
        LOG_INFO("module", "maxPriceOrange          = {}", GetMaxPrice(AHB_ORANGE));
        LOG_INFO("module", "minPriceYellow          = {}", GetMinPrice(AHB_YELLOW));
        LOG_INFO("module", "maxPriceYellow          = {}", GetMaxPrice(AHB_YELLOW));

        LOG_INFO("module", "minBidPriceGrey         = {}", GetMinBidPrice(AHB_GREY));
        LOG_INFO("module", "maxBidPriceGrey         = {}", GetMaxBidPrice(AHB_GREY));
        LOG_INFO("module", "minBidPriceWhite        = {}", GetMinBidPrice(AHB_WHITE));
        LOG_INFO("module", "maxBidPriceWhite        = {}", GetMaxBidPrice(AHB_WHITE));
        LOG_INFO("module", "minBidPriceGreen        = {}", GetMinBidPrice(AHB_GREEN));
        LOG_INFO("module", "maxBidPriceGreen        = {}", GetMaxBidPrice(AHB_GREEN));
        LOG_INFO("module", "minBidPriceBlue         = {}", GetMinBidPrice(AHB_BLUE));
        LOG_INFO("module", "maxBidPriceBlue         = {}", GetMinBidPrice(AHB_BLUE));
        LOG_INFO("module", "minBidPricePurple       = {}", GetMinBidPrice(AHB_PURPLE));
        LOG_INFO("module", "maxBidPricePurple       = {}", GetMaxBidPrice(AHB_PURPLE));
        LOG_INFO("module", "minBidPriceOrange       = {}", GetMinBidPrice(AHB_ORANGE));
        LOG_INFO("module", "maxBidPriceOrange       = {}", GetMaxBidPrice(AHB_ORANGE));
        LOG_INFO("module", "minBidPriceYellow       = {}", GetMinBidPrice(AHB_YELLOW));
        LOG_INFO("module", "maxBidPriceYellow       = {}", GetMaxBidPrice(AHB_YELLOW));

        LOG_INFO("module", "maxStackGrey            = {}", GetMaxStack(AHB_GREY));
        LOG_INFO("module", "maxStackWhite           = {}", GetMaxStack(AHB_WHITE));
        LOG_INFO("module", "maxStackGreen           = {}", GetMaxStack(AHB_GREEN));
        LOG_INFO("module", "maxStackBlue            = {}", GetMaxStack(AHB_BLUE));
        LOG_INFO("module", "maxStackPurple          = {}", GetMaxStack(AHB_PURPLE));
        LOG_INFO("module", "maxStackOrange          = {}", GetMaxStack(AHB_ORANGE));
        LOG_INFO("module", "maxStackYellow          = {}", GetMaxStack(AHB_YELLOW));
    }

    //
    // Reset the situation of the auction house
    //

    ResetItemCounts();

    //
    // Update the situation of the auction house
    //

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(GetAHFID());
    uint32 numberOfAuctions = auctionHouse->Getcount();

    if (numberOfAuctions > 0)
    {
        for (AuctionHouseObject::AuctionEntryMap::const_iterator itr = auctionHouse->GetAuctionsBegin(); itr != auctionHouse->GetAuctionsEnd(); ++itr)
        {
            AuctionEntry* Aentry = itr->second;
            Item*         item   = sAuctionMgr->GetAItem(Aentry->item_guid);

            //
            // If it has to only consider the bots auctions, skip the ones belonging to the players
            //

            if (ConsiderOnlyBotAuctions)
            {
                if (botsIds.find(Aentry->owner.GetCounter()) == botsIds.end())
                {
                    continue;
                }
            }

            if (item)
            {
                ItemTemplate const* prototype = item->GetTemplate();

                if (prototype)
                {
                    switch (prototype->Quality)
                    {
                    case AHB_GREY:
                        if (prototype->Class == ITEM_CLASS_TRADE_GOODS)
                        {
                            IncItemCounts(AHB_GREY_TG);
                        }
                        else
                        {
                            IncItemCounts(AHB_GREY_I);
                        }
                        break;

                    case AHB_WHITE:
                        if (prototype->Class == ITEM_CLASS_TRADE_GOODS)
                        {
                            IncItemCounts(AHB_WHITE_TG);
                        }
                        else
                        {
                            IncItemCounts(AHB_WHITE_I);
                        }

                        break;

                    case AHB_GREEN:
                        if (prototype->Class == ITEM_CLASS_TRADE_GOODS)
                        {
                            IncItemCounts(AHB_GREEN_TG);
                        }
                        else
                        {
                            IncItemCounts(AHB_GREEN_I);
                        }

                        break;

                    case AHB_BLUE:
                        if (prototype->Class == ITEM_CLASS_TRADE_GOODS)
                        {
                            IncItemCounts(AHB_BLUE_TG);
                        }
                        else
                        {
                            IncItemCounts(AHB_BLUE_I);
                        }

                        break;

                    case AHB_PURPLE:
                        if (prototype->Class == ITEM_CLASS_TRADE_GOODS)
                        {
                            IncItemCounts(AHB_PURPLE_TG);
                        }
                        else
                        {
                            IncItemCounts(AHB_PURPLE_I);
                        }

                        break;

                    case AHB_ORANGE:
                        if (prototype->Class == ITEM_CLASS_TRADE_GOODS)
                        {
                            IncItemCounts(AHB_ORANGE_TG);
                        }
                        else
                        {
                            IncItemCounts(AHB_ORANGE_I);
                        }

                        break;

                    case AHB_YELLOW:
                        if (prototype->Class == ITEM_CLASS_TRADE_GOODS)
                        {
                            IncItemCounts(AHB_YELLOW_TG);
                        }
                        else
                        {
                            IncItemCounts(AHB_YELLOW_I);
                        }

                        break;
                    }
                }
            }
        }
    }

    if (DebugOutConfig)
    {
        LOG_INFO("module", "Current situation for the auctionhouse {}", GetAHID());
        LOG_INFO("module", "    Grey   Trade Goods {}", GetItemCounts(AHB_GREY_TG));
        LOG_INFO("module", "    White  Trade Goods {}", GetItemCounts(AHB_WHITE_TG));
        LOG_INFO("module", "    Green  Trade Goods {}", GetItemCounts(AHB_GREEN_TG));
        LOG_INFO("module", "    Blue   Trade Goods {}", GetItemCounts(AHB_BLUE_TG));
        LOG_INFO("module", "    Purple Trade Goods {}", GetItemCounts(AHB_PURPLE_TG));
        LOG_INFO("module", "    Orange Trade Goods {}", GetItemCounts(AHB_ORANGE_TG));
        LOG_INFO("module", "    Yellow Trade Goods {}", GetItemCounts(AHB_YELLOW_TG));
        LOG_INFO("module", "    Grey   Items       {}", GetItemCounts(AHB_GREY_I));
        LOG_INFO("module", "    White  Items       {}", GetItemCounts(AHB_WHITE_I));
        LOG_INFO("module", "    Green  Items       {}", GetItemCounts(AHB_GREEN_I));
        LOG_INFO("module", "    Blue   Items       {}", GetItemCounts(AHB_BLUE_I));
        LOG_INFO("module", "    Purple Items       {}", GetItemCounts(AHB_PURPLE_I));
        LOG_INFO("module", "    Orange Items       {}", GetItemCounts(AHB_ORANGE_I));
        LOG_INFO("module", "    Yellow Items       {}", GetItemCounts(AHB_YELLOW_I));
    }

    //
    // Auctions buyer
    //

    SetBuyerPrice(AHB_GREY  , WorldDatabase.Query("SELECT buyerpricegrey   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetBuyerPrice(AHB_WHITE , WorldDatabase.Query("SELECT buyerpricewhite  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetBuyerPrice(AHB_GREEN , WorldDatabase.Query("SELECT buyerpricegreen  FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetBuyerPrice(AHB_BLUE  , WorldDatabase.Query("SELECT buyerpriceblue   FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetBuyerPrice(AHB_PURPLE, WorldDatabase.Query("SELECT buyerpricepurple FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetBuyerPrice(AHB_ORANGE, WorldDatabase.Query("SELECT buyerpriceorange FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());
    SetBuyerPrice(AHB_YELLOW, WorldDatabase.Query("SELECT buyerpriceyellow FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());

    //
    // Load bidding interval
    //

    SetBiddingInterval(WorldDatabase.Query("SELECT buyerbiddinginterval FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());

    //
    // Load bids per interval
    //

    SetBidsPerInterval(WorldDatabase.Query("SELECT buyerbidsperinterval FROM mod_auctionhousebot WHERE auctionhouse = {}", GetAHID())->Fetch()->Get<uint32>());

    if (DebugOutConfig)
    {
        LOG_INFO("module", "Current Settings for Auctionhouse {} buyer", GetAHID());
        LOG_INFO("module", "buyerPriceGrey          = {}", GetBuyerPrice(AHB_GREY));
        LOG_INFO("module", "buyerPriceWhite         = {}", GetBuyerPrice(AHB_WHITE));
        LOG_INFO("module", "buyerPriceGreen         = {}", GetBuyerPrice(AHB_GREEN));
        LOG_INFO("module", "buyerPriceBlue          = {}", GetBuyerPrice(AHB_BLUE));
        LOG_INFO("module", "buyerPricePurple        = {}", GetBuyerPrice(AHB_PURPLE));
        LOG_INFO("module", "buyerPriceOrange        = {}", GetBuyerPrice(AHB_ORANGE));
        LOG_INFO("module", "buyerPriceYellow        = {}", GetBuyerPrice(AHB_YELLOW));
        LOG_INFO("module", "buyerBiddingInterval    = {}", GetBiddingInterval());
        LOG_INFO("module", "buyerBidsPerInterval    = {}", GetBidsPerInterval());
    }

    //
    // Reload the list of disabled items
    //

    DisableItemStore.clear();

    QueryResult result = WorldDatabase.Query("SELECT item FROM mod_auctionhousebot_disabled_items");

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            DisableItemStore.insert(fields[0].Get<uint32>());
        } while (result->NextRow());
    }

    if (DebugOutConfig)
    {
        LOG_INFO("module", "Loaded {} items from the disabled item store", uint32(DisableItemStore.size()));
    }

    // 
    // Reload the list of npc items
    // 

    NpcItems.clear();

    QueryResult npcResults = WorldDatabase.Query("SELECT distinct item FROM npc_vendor");

    if (npcResults)
    {
        do
        {
            Field* fields = npcResults->Fetch();
            NpcItems.insert(fields[0].Get<int32>());

        } while (npcResults->NextRow());
    }
    else
    {
        if (DebugOutConfig)
        {
            LOG_ERROR("module", "AuctionHouseBot: failed to retrieve npc items");
        }
    }

    if (DebugOutConfig)
    {
        LOG_INFO("module", "Loaded {} items from NPCs", uint32(NpcItems.size()));
    }

    // 
    // Reload the list from the lootable items
    // 

    LootItems.clear();

    QueryResult itemsResults = WorldDatabase.Query(
        "SELECT item FROM creature_loot_template      UNION "
        "SELECT item FROM reference_loot_template     UNION "
        "SELECT item FROM disenchant_loot_template    UNION "
        "SELECT item FROM fishing_loot_template       UNION "
        "SELECT item FROM gameobject_loot_template    UNION "
        "SELECT item FROM item_loot_template          UNION "
        "SELECT item FROM milling_loot_template       UNION "
        "SELECT item FROM pickpocketing_loot_template UNION "
        "SELECT item FROM prospecting_loot_template   UNION "
        "SELECT item FROM skinning_loot_template");

    if (itemsResults)
    {
        do
        {
            Field* fields = itemsResults->Fetch();
            LootItems.insert(fields[0].Get<uint32>());

        } while (itemsResults->NextRow());
    }
    else
    {
        if (DebugOutConfig)
        {
            LOG_ERROR("module", "AuctionHouseBot: failed to retrieve loot items");
        }
    }

    //
    // Include profession items
    //

    if (Profession_Items)
    {
        itemsResults = WorldDatabase.Query(
            "SELECT item FROM auctionhousebot_professionItems");

        if (itemsResults)
        {
            do
            {
                Field* fields = itemsResults->Fetch();
                uint32 item   = fields[0].Get<uint32>();
                
                if(LootItems.find(item) == LootItems.end())
                {
                    LootItems.insert(fields[0].Get<uint32>());
                }
            } while (itemsResults->NextRow());
        }
    }

    if (DebugOutConfig)
    {
        LOG_INFO("module", "Loaded {} items from lootable items", uint32(LootItems.size()));
    }
}

void AHBConfig::InitializeBins()
{
    //
    // Exclude items depending on the configuration; whatever passes all the tests is put in the lists.
    //

    ItemTemplateContainer const* its = sObjectMgr->GetItemTemplateStore();

    for (ItemTemplateContainer::const_iterator itr = its->begin(); itr != its->end(); ++itr)
    {

        //
        // Exclude items with the blocked binding type
        //

        if (itr->second.Bonding == NO_BIND && !No_Bind)
        {
            continue;
        }

        if (itr->second.Bonding == BIND_WHEN_PICKED_UP && !Bind_When_Picked_Up)
        {
            continue;
        }

        if (itr->second.Bonding == BIND_WHEN_EQUIPPED && !Bind_When_Equipped)
        {
            continue;
        }

        if (itr->second.Bonding == BIND_WHEN_USE && !Bind_When_Use)
        {
            continue;
        }

        if (itr->second.Bonding == BIND_QUEST_ITEM && !Bind_Quest_Item)
        {
            continue;
        }

        //
        // Exclude items with no possible price
        //

        if (UseBuyPriceForSeller)
        {
            if (itr->second.BuyPrice == 0)
            {
                continue;
            }
        }
        else
        {
            if (itr->second.SellPrice == 0)
            {
                continue;
            }
        }

        //
        // Exclude items with no costs associated, in any case
        //

        if ((itr->second.BuyPrice == 0) && (itr->second.SellPrice == 0))
        {
            continue;
        }

        //
        // Exlude items superior to the limit quality
        //

        if (itr->second.Quality > 6)
        {
            continue;
        }

        //
        // Exclude trade goods items
        //

        if (itr->second.Class == ITEM_CLASS_TRADE_GOODS)
        {
            bool isNpc   = false;
            bool isLoot  = false;
            bool exclude = false;

            if (NpcItems.find(itr->second.ItemId) != NpcItems.end())
            {
                isNpc = true;

                if (!Vendor_TGs)
                {
                    exclude = true;
                }
            }

            if (!exclude)
            {
                if (LootItems.find(itr->second.ItemId) != LootItems.end())
                {
                    isLoot = true;

                    if (!Loot_TGs)
                    {
                        exclude = true;
                    }
                }
            }

            if (exclude)
            {
                continue;
            }

            if (!Other_TGs)
            {
                if (!isNpc && !isLoot)
                {
                    continue;
                }
            }
        }

        //
        // Exclude loot items
        //

        if (itr->second.Class != ITEM_CLASS_TRADE_GOODS)
        {
            bool isNpc   = false;
            bool isLoot  = false;
            bool exclude = false;

            if (NpcItems.find(itr->second.ItemId) != NpcItems.end())
            {
                isNpc = true;

                if (!Vendor_Items)
                {
                    exclude = true;
                }
            }

            if (!exclude)
            {
                if (LootItems.find(itr->second.ItemId) != LootItems.end())
                {
                    isLoot = true;

                    if (!Loot_Items)
                    {
                        exclude = true;
                    }
                }
            }

            if (exclude)
            {
                continue;
            }

            if (!Other_Items)
            {
                if (!isNpc && !isLoot)
                {
                    continue;
                }
            }
        }

        //
        // Verify if the item is disabled or not in the whitelist
        //

        if (SellerWhiteList.size() == 0)
        {
            if (DisableItemStore.find(itr->second.ItemId) != DisableItemStore.end())
            {
                if (DebugOutFilters)
                {
                    LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (PTR/Beta/Unused Item)", itr->second.ItemId);
                }

                continue;
            }
        }
        else
        {
            if (SellerWhiteList.find(itr->second.ItemId) == SellerWhiteList.end())
            {
                if (DebugOutFilters)
                {
                    LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (not in the whitelist)", itr->second.ItemId);
                }

                continue;
            }
        }

        //
        // Disable permanent enchants items
        //

        if ((DisablePermEnchant) && (itr->second.Class == ITEM_CLASS_PERMANENT))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Permanent Enchant Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable conjured items
        //

        if ((DisableConjured) && (itr->second.IsConjuredConsumable()))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Conjured Consumable)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable gems
        //

        if ((DisableGems) && (itr->second.Class == ITEM_CLASS_GEM))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Gem)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable money
        //

        if ((DisableMoney) && (itr->second.Class == ITEM_CLASS_MONEY))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Money)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable moneyloot
        //

        if ((DisableMoneyLoot) && (itr->second.MinMoneyLoot > 0))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (MoneyLoot)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable lootable items
        //

        if ((DisableLootable) && (itr->second.Flags & 4))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Lootable Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable Keys
        //

        if ((DisableKeys) && (itr->second.Class == ITEM_CLASS_KEY))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Quest Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items with duration
        //

        if ((DisableDuration) && (itr->second.Duration > 0))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Has a Duration)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items which are BOP or Quest Items and have a required level lower than the item level
        //

        if ((DisableBOP_Or_Quest_NoReqLevel) && ((itr->second.Bonding == BIND_WHEN_PICKED_UP || itr->second.Bonding == BIND_QUEST_ITEM) && (itr->second.RequiredLevel < itr->second.ItemLevel)))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (BOP or BQI and Required Level is less than Item Level)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items specifically for Warrior
        //

        if ((DisableWarriorItems) && (itr->second.AllowableClass == AHB_CLASS_WARRIOR))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Warrior Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items specifically for Paladin
        //

        if ((DisablePaladinItems) && (itr->second.AllowableClass == AHB_CLASS_PALADIN))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Paladin Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items specifically for Hunter
        //

        if ((DisableHunterItems) && (itr->second.AllowableClass == AHB_CLASS_HUNTER))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Hunter Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items specifically for Rogue
        //

        if ((DisableRogueItems) && (itr->second.AllowableClass == AHB_CLASS_ROGUE))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Rogue Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items specifically for Priest
        //

        if ((DisablePriestItems) && (itr->second.AllowableClass == AHB_CLASS_PRIEST))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Priest Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items specifically for DK
        //

        if ((DisableDKItems) && (itr->second.AllowableClass == AHB_CLASS_DK))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (DK Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items specifically for Shaman
        //

        if ((DisableShamanItems) && (itr->second.AllowableClass == AHB_CLASS_SHAMAN))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Shaman Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items specifically for Mage
        //

        if ((DisableMageItems) && (itr->second.AllowableClass == AHB_CLASS_MAGE))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Mage Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items specifically for Warlock
        //

        if ((DisableWarlockItems) && (itr->second.AllowableClass == AHB_CLASS_WARLOCK))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Warlock Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items specifically for Unused Class
        //

        if ((DisableUnusedClassItems) && (itr->second.AllowableClass == AHB_CLASS_UNUSED))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Unused Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable items specifically for Druid
        //

        if ((DisableDruidItems) && (itr->second.AllowableClass == AHB_CLASS_DRUID))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Druid Item)", itr->second.ItemId);
            }

            continue;
        }

        //
        // Disable Items below level X
        //

        if ((DisableItemsBelowLevel) && (itr->second.Class != ITEM_CLASS_TRADE_GOODS) && (itr->second.ItemLevel < DisableItemsBelowLevel))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Item Level = {})", itr->second.ItemId, itr->second.ItemLevel);
            }

            continue;
        }

        //
        // Disable Items above level X
        //

        if ((DisableItemsAboveLevel) && (itr->second.Class != ITEM_CLASS_TRADE_GOODS) && (itr->second.ItemLevel > DisableItemsAboveLevel))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Item Level = {})", itr->second.ItemId, itr->second.ItemLevel);
            }

            continue;
        }

        //
        // Disable Trade Goods below level X
        //

        if ((DisableTGsBelowLevel) && (itr->second.Class == ITEM_CLASS_TRADE_GOODS) && (itr->second.ItemLevel < DisableTGsBelowLevel))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Trade Good {} disabled (Trade Good Level = {})", itr->second.ItemId, itr->second.ItemLevel);
            }

            continue;
        }

        //
        // Disable Trade Goods above level X
        //

        if ((DisableTGsAboveLevel) && (itr->second.Class == ITEM_CLASS_TRADE_GOODS) && (itr->second.ItemLevel > DisableTGsAboveLevel))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Trade Good {} disabled (Trade Good Level = {})", itr->second.ItemId, itr->second.ItemLevel);
            }

            continue;
        }

        //
        // Disable Items below GUID X
        //

        if ((DisableItemsBelowGUID) && (itr->second.Class != ITEM_CLASS_TRADE_GOODS) && (itr->second.ItemId < DisableItemsBelowGUID))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Item Level = {})", itr->second.ItemId, itr->second.ItemLevel);
            }

            continue;
        }

        //
        // Disable Items above GUID X
        //

        if ((DisableItemsAboveGUID) && (itr->second.Class != ITEM_CLASS_TRADE_GOODS) && (itr->second.ItemId > DisableItemsAboveGUID))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Item Level = {})", itr->second.ItemId, itr->second.ItemLevel);
            }

            continue;
        }

        //
        // Disable Trade Goods below GUID X
        //

        if ((DisableTGsBelowGUID) && (itr->second.Class == ITEM_CLASS_TRADE_GOODS) && (itr->second.ItemId < DisableTGsBelowGUID))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Trade Good Level = {})", itr->second.ItemId, itr->second.ItemLevel);
            }

            continue;
        }

        //
        // Disable Trade Goods above GUID X
        //

        if ((DisableTGsAboveGUID) && (itr->second.Class == ITEM_CLASS_TRADE_GOODS) && (itr->second.ItemId > DisableTGsAboveGUID))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (Trade Good Level = {})", itr->second.ItemId, itr->second.ItemLevel);
            }

            continue;
        }

        //
        // Disable Items for level lower than X
        //

        if ((DisableItemsBelowReqLevel) && (itr->second.Class != ITEM_CLASS_TRADE_GOODS) && (itr->second.RequiredLevel < DisableItemsBelowReqLevel))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (RequiredLevel = {})", itr->second.ItemId, itr->second.RequiredLevel);
            }

            continue;
        }

        //
        // Disable Items for level higher than X
        //

        if ((DisableItemsAboveReqLevel) && (itr->second.Class != ITEM_CLASS_TRADE_GOODS) && (itr->second.RequiredLevel > DisableItemsAboveReqLevel))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (RequiredLevel = {})", itr->second.ItemId, itr->second.RequiredLevel);
            }

            continue;
        }

        //
        // Disable Trade Goods for level lower than X
        //

        if ((DisableTGsBelowReqLevel) && (itr->second.Class == ITEM_CLASS_TRADE_GOODS) && (itr->second.RequiredLevel < DisableTGsBelowReqLevel))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Trade Good {} disabled (RequiredLevel = {})", itr->second.ItemId, itr->second.RequiredLevel);
            }

            continue;
        }

        //
        // Disable Trade Goods for level higher than X
        //

        if ((DisableTGsAboveReqLevel) && (itr->second.Class == ITEM_CLASS_TRADE_GOODS) && (itr->second.RequiredLevel > DisableTGsAboveReqLevel))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Trade Good {} disabled (RequiredLevel = {})", itr->second.ItemId, itr->second.RequiredLevel);
            }

            continue;
        }

        //
        // Disable Items that require skill lower than X
        //

        if ((DisableItemsBelowReqSkillRank) && (itr->second.Class != ITEM_CLASS_TRADE_GOODS) && (itr->second.RequiredSkillRank < DisableItemsBelowReqSkillRank))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (RequiredSkillRank = {})", itr->second.ItemId, itr->second.RequiredSkillRank);
            }

            continue;
        }

        //
        // Disable Items that require skill higher than X
        //

        if ((DisableItemsAboveReqSkillRank) && (itr->second.Class != ITEM_CLASS_TRADE_GOODS) && (itr->second.RequiredSkillRank > DisableItemsAboveReqSkillRank))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (RequiredSkillRank = {})", itr->second.ItemId, itr->second.RequiredSkillRank);
            }

            continue;
        }

        //
        // Disable Trade Goods that require skill lower than X
        //

        if ((DisableTGsBelowReqSkillRank) && (itr->second.Class == ITEM_CLASS_TRADE_GOODS) && (itr->second.RequiredSkillRank < DisableTGsBelowReqSkillRank))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (RequiredSkillRank = {})", itr->second.ItemId, itr->second.RequiredSkillRank);
            }

            continue;
        }

        //
        // Disable Trade Goods that require skill higher than X
        //

        if ((DisableTGsAboveReqSkillRank) && (itr->second.Class == ITEM_CLASS_TRADE_GOODS) && (itr->second.RequiredSkillRank > DisableTGsAboveReqSkillRank))
        {
            if (DebugOutFilters)
            {
                LOG_ERROR("module", "AuctionHouseBot: Item {} disabled (RequiredSkillRank = {})", itr->second.ItemId, itr->second.RequiredSkillRank);
            }

            continue;
        }

        //
        // Now that the items passed all the tests, organize it by quality
        //

        if (itr->second.Class == ITEM_CLASS_TRADE_GOODS)
        {
            switch (itr->second.Quality)
            {
            case AHB_GREY:
                GreyTradeGoodsBin.insert(itr->second.ItemId);
                break;

            case AHB_WHITE:
                WhiteTradeGoodsBin.insert(itr->second.ItemId);
                break;

            case AHB_GREEN:
                GreenTradeGoodsBin.insert(itr->second.ItemId);
                break;

            case AHB_BLUE:
                BlueTradeGoodsBin.insert(itr->second.ItemId);
                break;

            case AHB_PURPLE:
                PurpleTradeGoodsBin.insert(itr->second.ItemId);
                break;

            case AHB_ORANGE:
                OrangeTradeGoodsBin.insert(itr->second.ItemId);
                break;

            case AHB_YELLOW:
                YellowTradeGoodsBin.insert(itr->second.ItemId);
                break;
            }
        }
        else
        {
            switch (itr->second.Quality)
            {
            case AHB_GREY:
                GreyItemsBin.insert(itr->second.ItemId);
                break;

            case AHB_WHITE:
                WhiteItemsBin.insert(itr->second.ItemId);
                break;

            case AHB_GREEN:
                GreenItemsBin.insert(itr->second.ItemId);
                break;

            case AHB_BLUE:
                BlueItemsBin.insert(itr->second.ItemId);
                break;

            case AHB_PURPLE:
                PurpleItemsBin.insert(itr->second.ItemId);
                break;

            case AHB_ORANGE:
                OrangeItemsBin.insert(itr->second.ItemId);
                break;

            case AHB_YELLOW:
                YellowItemsBin.insert(itr->second.ItemId);
                break;
            }
        }
    }

    // 
    // Perform reporting and the last check: if no items are disabled or in the whitelist clear the bin making the selling useless
    // 

    LOG_INFO("module", "AHBot: Configuration for ah {}", AHID);

    if (SellerWhiteList.size() == 0)
    {
        if (DisableItemStore.size() == 0)
        {
            LOG_ERROR("module", "AHBot: No items are disabled or in the whitelist! Selling will be disabled!");

            GreyTradeGoodsBin.clear();
            WhiteTradeGoodsBin.clear();
            GreenTradeGoodsBin.clear();
            BlueTradeGoodsBin.clear();
            PurpleTradeGoodsBin.clear();
            OrangeTradeGoodsBin.clear();
            YellowTradeGoodsBin.clear();
            GreyItemsBin.clear();
            WhiteItemsBin.clear();
            GreenItemsBin.clear();
            BlueItemsBin.clear();
            PurpleItemsBin.clear();
            OrangeItemsBin.clear();
            YellowItemsBin.clear();

            AHBSeller = false;

            return;
        }

        LOG_INFO("module", "AHBot: {} disabled items", uint32(DisableItemStore.size()));
    }
    else
    {
        LOG_INFO("module", "AHBot: Using a whitelist of {} items", uint32(SellerWhiteList.size()));
    }

    LOG_INFO("module", "AHBot: loaded {} grey   trade goods", uint32(GreyTradeGoodsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} white  trade goods", uint32(WhiteTradeGoodsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} green  trade goods", uint32(GreenTradeGoodsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} blue   trade goods", uint32(BlueTradeGoodsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} purple trade goods", uint32(PurpleTradeGoodsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} orange trade goods", uint32(OrangeTradeGoodsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} yellow trade goods", uint32(YellowTradeGoodsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} grey   items"      , uint32(GreyItemsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} white  items"      , uint32(WhiteItemsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} green  items"      , uint32(GreenItemsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} blue   items"      , uint32(BlueItemsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} purple items"      , uint32(PurpleItemsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} orange items"      , uint32(OrangeItemsBin.size()));
    LOG_INFO("module", "AHBot: loaded {} yellow items"      , uint32(YellowItemsBin.size()));
}

std::set<uint32> AHBConfig::getCommaSeparatedIntegers(std::string text)
{
    std::string       value;
    std::stringstream stream;
    std::set<uint32>  ret;

    stream.str(text);

    //
    // Continue to precess comma separated values
    //

    while (std::getline(stream, value, ','))
    {
        ret.insert(atoi(value.c_str()));
    }

    return ret;
}
