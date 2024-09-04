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