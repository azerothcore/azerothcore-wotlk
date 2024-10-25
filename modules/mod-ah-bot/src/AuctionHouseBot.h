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

#ifndef AUCTION_HOUSE_BOT_H
#define AUCTION_HOUSE_BOT_H

#include "Common.h"
#include "ObjectGuid.h"
#include "AuctionHouseMgr.h"

#include "AuctionHouseBotCommon.h"
#include "AuctionHouseBotConfig.h"

struct AuctionEntry;
class  Player;
class  WorldSession;

#define AUCTION_HOUSE_BOT_LOOP_BREAKER 32

class AuctionHouseBot
{
private:
    uint32     _account;
    uint32     _id;

    AHBConfig* _allianceConfig;
    AHBConfig* _hordeConfig;
    AHBConfig* _neutralConfig;

    time_t     _lastrun_a_sec;
    time_t     _lastrun_h_sec;
    time_t     _lastrun_n_sec;

    //
    // Main operations
    //

    void Sell(Player *AHBplayer, AHBConfig *config);
    void Buy (Player *AHBplayer, AHBConfig *config, WorldSession *session);

    //
    // Utilities
    //

    inline uint32 minValue(uint32 a, uint32 b) { return a <= b ? a : b; };

    uint32 getNofAuctions(AHBConfig* config, AuctionHouseObject* auctionHouse, ObjectGuid guid);
    uint32 getStackCount(AHBConfig* config, uint32 max);
    uint32 getElapsedTime(uint32 timeClass);
    uint32 getElement(std::set<uint32> set, int index, uint32 botId, uint32 maxDup, AuctionHouseObject* auctionHouse);

public:
    AuctionHouseBot(uint32 account, uint32 id);
    ~AuctionHouseBot();

    void Initialize(AHBConfig* allianceConfig, AHBConfig* hordeConfig, AHBConfig* neutralConfig);
    void Update();

    void Commands(AHBotCommand command, uint32 ahMapID, uint32 col, char* args);

    ObjectGuid::LowType GetAHBplayerGUID() { return _id; };
};

#endif // AUCTION_HOUSE_BOT_H
