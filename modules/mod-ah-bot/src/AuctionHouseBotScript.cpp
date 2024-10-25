/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#include "AuctionHouseBot.h"
#include "AuctionHouseBotAuctionHouseScript.h"
#include "AuctionHouseBotMailScript.h"
#include "AuctionHouseBotWorldScript.h"

// =============================================================================
// This provides the effective startup of the module by istanciating the scripts
// =============================================================================

void AddAHBotScripts()
{
    new AHBot_WorldScript();
    new AHBot_AuctionHouseScript();
    new AHBot_MailScript();
}
