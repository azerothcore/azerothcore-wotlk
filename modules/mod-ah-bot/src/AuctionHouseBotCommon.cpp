/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#include "AuctionHouseBot.h"
#include "AuctionHouseBotCommon.h"
#include "AuctionHouseBotConfig.h"

// 
// Configuration used globally by all the bots instances
// 

AHBConfig* gAllianceConfig = new AHBConfig(2);
AHBConfig* gHordeConfig    = new AHBConfig(6);
AHBConfig* gNeutralConfig  = new AHBConfig(7);

// 
// Active bots
// 

std::set<uint32>           gBotsId;
std::set<AuctionHouseBot*> gBots;
