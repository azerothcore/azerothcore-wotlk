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

#ifndef AUCTION_HOUSE_BOT_COMMON_H
#define AUCTION_HOUSE_BOT_COMMON_H

#include <set>

#include "Common.h"

class AuctionHouseBot;

//
// Item quality
//

#define AHB_GREY              ITEM_QUALITY_POOR
#define AHB_WHITE             ITEM_QUALITY_NORMAL
#define AHB_GREEN             ITEM_QUALITY_UNCOMMON
#define AHB_BLUE              ITEM_QUALITY_RARE
#define AHB_PURPLE            ITEM_QUALITY_EPIC
#define AHB_ORANGE            ITEM_QUALITY_LEGENDARY
#define AHB_YELLOW            ITEM_QUALITY_ARTIFACT
#define AHB_MAX_QUALITY       ITEM_QUALITY_ARTIFACT

#define AHB_CLASS_WARRIOR     1
#define AHB_CLASS_PALADIN     2
#define AHB_CLASS_HUNTER      4
#define AHB_CLASS_ROGUE       8
#define AHB_CLASS_PRIEST     16
#define AHB_CLASS_DK         32
#define AHB_CLASS_SHAMAN     64
#define AHB_CLASS_MAGE      128
#define AHB_CLASS_WARLOCK   256
#define AHB_CLASS_UNUSED    512
#define AHB_CLASS_DRUID    1024

// 
// Items classification
// 

#define AHB_GREY_TG           0
#define AHB_WHITE_TG          1
#define AHB_GREEN_TG          2
#define AHB_BLUE_TG           3
#define AHB_PURPLE_TG         4
#define AHB_ORANGE_TG         5
#define AHB_YELLOW_TG         6

#define AHB_GREY_I            7
#define AHB_WHITE_I           8
#define AHB_GREEN_I           9
#define AHB_BLUE_I           10
#define AHB_PURPLE_I         11
#define AHB_ORANGE_I         12
#define AHB_YELLOW_I         13

//
// Chat GM commands
//

enum class AHBotCommand : uint32
{
    buyer,
    seller,
    useMarketPrice,

    ahexpire,
    minitems,
    maxitems,
    percentages,
    minprice,
    maxprice,
    minbidprice,
    maxbidprice,
    maxstack,
    buyerprice,
    bidinterval,
    bidsperinterval
};

//
// Globals
//

extern std::set<uint32>           gBotsId; // Active bots players ids
extern std::set<AuctionHouseBot*> gBots;   // Active bots

#endif // AUCTION_HOUSE_BOT_COMMON_H
