/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#include "Config.h"
#include "Log.h"

#include "AuctionHouseBot.h"
#include "AuctionHouseBotCommon.h"
#include "AuctionHouseBotWorldScript.h"

// =============================================================================
// Initialization of the bot during the world startup
// =============================================================================

AHBot_WorldScript::AHBot_WorldScript() : WorldScript("AHBot_WorldScript", {
    WORLDHOOK_ON_BEFORE_CONFIG_LOAD,
    WORLDHOOK_ON_STARTUP
})
{

}

void AHBot_WorldScript::OnBeforeConfigLoad(bool reload)
{
    //
    // Retrieve how many bots shall be operating on the auction market
    //

    bool   debug   = sConfigMgr->GetOption<bool>  ("AuctionHouseBot.DEBUG"  , false);
    uint32 account = sConfigMgr->GetOption<uint32>("AuctionHouseBot.Account", 0);
    uint32 player  = sConfigMgr->GetOption<uint32>("AuctionHouseBot.GUID"   , 0);

    //
    // All the bots bound to the provided account will be used for auctioning, if GUID is zero.
    // Otherwise only the specified character is used.
    //

    if (account == 0 && player == 0)
    {
        LOG_ERROR("server.loading", "AHBot: Account id and player id missing from configuration; is that the right file?");
        return;
    }
    else
    {
        QueryResult result = CharacterDatabase.Query("SELECT guid FROM characters WHERE account = {}", account);

        if (result)
        {
            gBotsId.clear();

            do
            {
                Field* fields = result->Fetch();
                uint32 botId  = fields[0].Get<uint32>();

                if (player == 0)
                {
                    if (debug)
                    {
                        LOG_INFO("server.loading", "AHBot: New bot to start, account={} character={}", account, botId);
                    }

                    gBotsId.insert(botId);
                }
                else
                {
                    if (player == botId)
                    {
                        if (debug)
                        {
                            LOG_INFO("server.loading", "AHBot: Starting only one bot, account={} character={}", account, botId);
                        }

                        gBotsId.insert(botId);
                        break;
                    }
                }

            } while (result->NextRow());
        }
        else
        {
            LOG_ERROR("server.loading", "AHBot: Could not query the database for characters of account {}", account);
            return;
        }
    }

    if (gBotsId.size() == 0)
    {
        LOG_ERROR("server.loading", "AHBot: no characters registered for account {}", account);
        return;
    }

    // 
    // Start the bots only if the operation is a reload, otherwise let the OnStartup do the job
    // 

    if (reload)
    {
        if (debug)
        {
            LOG_INFO("module", "AHBot: Reloading the bots");
        }

        //
        // Clear the bots array; this way they wont be used anymore during the initialization stage.
        //

        DeleteBots();

        //
        // Reload the configuration for the auction houses
        //

        gAllianceConfig->Initialize(gBotsId);
        gHordeConfig->Initialize   (gBotsId);
        gNeutralConfig->Initialize (gBotsId);

        //
        // Start again the bots
        //

        PopulateBots();
    }
}

void AHBot_WorldScript::OnStartup()
{
    LOG_INFO("server.loading", "Initialize AuctionHouseBot...");

    //
    // Initialize the configuration (done only once at startup)
    //

    gAllianceConfig->Initialize(gBotsId);
    gHordeConfig->Initialize   (gBotsId);
    gNeutralConfig->Initialize (gBotsId);

    //
    // Starts the bots
    //

    PopulateBots();
}

void AHBot_WorldScript::DeleteBots()
{
    // 
    // Save the old bots references.
    // 

    std::set<AuctionHouseBot*> oldBots;

    for (AuctionHouseBot* bot: gBots)
    {
        oldBots.insert(bot);
    }

    //
    // Clear the bot list
    //

    gBots.clear();

    // 
    // Free the resources used up by the old bots
    // 

    for (AuctionHouseBot* bot: oldBots)
    {
        delete bot;
    }
}


void AHBot_WorldScript::PopulateBots()
{
    uint32 account = sConfigMgr->GetOption<uint32>("AuctionHouseBot.Account", 0);

    // 
    // Insert the bot in the list used for auction house iterations
    // 

    gBots.clear();

    for (uint32 id: gBotsId)
    {
        AuctionHouseBot* bot = new AuctionHouseBot(account, id);
        bot->Initialize(gAllianceConfig, gHordeConfig, gNeutralConfig);

        gBots.insert(bot);
    }
}
