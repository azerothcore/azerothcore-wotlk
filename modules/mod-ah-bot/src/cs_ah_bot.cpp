/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
Name: ah_bot_commandscript
%Complete: 100
Comment: All ah_bot related commands
Category: commandscripts
EndScriptData */

#include "ScriptMgr.h"
#include "Chat.h"
#include "AuctionHouseBot.h"
#include "Config.h"

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

class ah_bot_commandscript : public CommandScript
{
private:
    static ItemQualities stringToItemQualities(const char* name, int length)
    {
        // 
        // Translates a string into ItemQualities enum
        // 

        if (strncmp(name, "grey", length) == 0)
        {
            return ITEM_QUALITY_POOR;
        }

        if (strncmp(name, "white", length) == 0)
        {
            return ITEM_QUALITY_NORMAL;
        }

        if (strncmp(name, "green", length) == 0)
        {
            return ITEM_QUALITY_UNCOMMON;
        }

        if (strncmp(name, "blue", length) == 0)
        {
            return ITEM_QUALITY_RARE;
        }

        if (strncmp(name, "purple", length) == 0)
        {
            return ITEM_QUALITY_EPIC;
        }

        if (strncmp(name, "orange", length) == 0)
        {
            return ITEM_QUALITY_LEGENDARY;
        }

        if (strncmp(name, "yellow", length) == 0)
        {
            return ITEM_QUALITY_ARTIFACT;
        }

        return static_cast<ItemQualities>(-1); // Invalid
    }

public:
    ah_bot_commandscript() : CommandScript("ah_bot_commandscript")
    {

    }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> commandTable =
        {
            { "ahbotoptions", HandleAHBotOptionsCommand, SEC_GAMEMASTER, Console::Yes }
        };

        return commandTable;
    }

    static bool HandleAHBotOptionsCommand(ChatHandler* handler, const char*args)
    {
        uint32 ahMapID = 0;
        char*  opt     = strtok((char*)args, " ");

        if (!opt)
        {
            handler->PSendSysMessage("Invalid syntax");
            handler->PSendSysMessage("Try ahbotoptions help to see a list of options.");

            return false;
        }

        //
        // Commands which does not requires an AH
        //

        int l = strlen(opt);

        if (strncmp(opt, "buyer", l) == 0)
        {
            char* param1 = strtok(NULL, " ");

            if (!param1)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions buyer $state (0 off 1 on)");
                return false;
            }

            for (AuctionHouseBot* bot: gBots)
            {
                bot->Commands(AHBotCommand::buyer, 0, 0, param1);
            }

            return true;
        }
        else if (strncmp(opt, "seller", l) == 0)
        {
            char* param1 = strtok(NULL, " ");

            if (!param1)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions seller $state (0 off 1 on)");
                return false;
            }

            for (AuctionHouseBot* bot: gBots)
            {
                bot->Commands(AHBotCommand::seller, 0, 0, param1);
            }

            return true;
        }
        else if (strncmp(opt, "usemarketprice", l) == 0)
        {
            char* param1 = strtok(NULL, " ");

            if (!param1)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions useMarketPrice $state (0 off 1 on)");
                return false;
            }

            for (AuctionHouseBot* bot : gBots)
            {
                bot->Commands(AHBotCommand::useMarketPrice, 0, 0, param1);
            }

            return true;
        }

        //
        // Retrieve the auction house type
        //

        char* ahMapIdStr = strtok(NULL, " ");

        if (ahMapIdStr)
        {
            ahMapID = uint32(strtoul(ahMapIdStr, NULL, 0));

            switch (ahMapID)
            {
                case 2:
                case 6:
                case 7:
                    break;
                default:
                    opt = NULL;
                    break;
            }
        }

        //
        // Syntax check
        //

        if (!opt)
        {
            handler->PSendSysMessage("Invalid syntax; the auction house id must be 2, 6 or 7");
            return false;
        }

        //
        // Commands that do requires an AH id to be performed
        //

        if (strncmp(opt, "help", l) == 0)
        {
            handler->PSendSysMessage("AHBot commands:");
            handler->PSendSysMessage("buyer - enable/disable buyer");
            handler->PSendSysMessage("seller - enable/disabler seller");
            handler->PSendSysMessage("usemarketprice - enable/disabler selling at market price");
            handler->PSendSysMessage("ahexpire - remove all bot auctions");
            handler->PSendSysMessage("minitems - set min auctions");
            handler->PSendSysMessage("maxitems - set max auctions");
            handler->PSendSysMessage("percentages - set selling percentages");
            handler->PSendSysMessage("minprice - set min price");
            handler->PSendSysMessage("maxprice - set max price");
            handler->PSendSysMessage("minbidprice - set min bid price for buyer");
            handler->PSendSysMessage("maxbidprice - set max bid price for buyer");
            handler->PSendSysMessage("maxstack - set max stack");
            handler->PSendSysMessage("buyerprice - set the buyer price policy");
            handler->PSendSysMessage("bidinterval - set the bid interval for buyer");
            handler->PSendSysMessage("bidsperinterval - set the bid amount for buyer");

            return true;
        }
        else if (strncmp(opt, "ahexpire", l) == 0)
        {
            if (!ahMapIdStr)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions ahexpire $ahMapID (2, 6 or 7)");
                return false;
            }

            for (AuctionHouseBot* bot: gBots)
            {
                bot->Commands(AHBotCommand::ahexpire, ahMapID, 0, NULL);
            }
        }
        else if (strncmp(opt, "minitems", l) == 0)
        {
            char* param1 = strtok(NULL, " ");

            if (!ahMapIdStr || !param1)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions minitems $ahMapID (2, 6 or 7) $minItems");
                return false;
            }

            for (AuctionHouseBot* bot : gBots)
            {
                bot->Commands(AHBotCommand::minitems, ahMapID, 0, param1);
            }
        }
        else if (strncmp(opt, "maxitems", l) == 0)
        {
            char* param1 = strtok(NULL, " ");

            if (!ahMapIdStr || !param1)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions maxitems $ahMapID (2, 6 or 7) $maxItems");
                return false;
            }

            for (AuctionHouseBot* bot: gBots)
            {
                bot->Commands(AHBotCommand::maxitems, ahMapID, 0, param1);
            }
        }
        else if (strncmp(opt, "percentages", l) == 0)
        {
            char* param1  = strtok(NULL, " ");
            char* param2  = strtok(NULL, " ");
            char* param3  = strtok(NULL, " ");
            char* param4  = strtok(NULL, " ");
            char* param5  = strtok(NULL, " ");
            char* param6  = strtok(NULL, " ");
            char* param7  = strtok(NULL, " ");
            char* param8  = strtok(NULL, " ");
            char* param9  = strtok(NULL, " ");
            char* param10 = strtok(NULL, " ");
            char* param11 = strtok(NULL, " ");
            char* param12 = strtok(NULL, " ");
            char* param13 = strtok(NULL, " ");
            char* param14 = strtok(NULL, " ");

            if (!ahMapIdStr || !param14)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions percentages $ahMapID (2, 6 or 7) $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14");
                handler->PSendSysMessage("1 GreyTradeGoods 2 WhiteTradeGoods 3 GreenTradeGoods 4 BlueTradeGoods 5 PurpleTradeGoods");
                handler->PSendSysMessage("6 OrangeTradeGoods 7 YellowTradeGoods 8 GreyItems 9 WhiteItems 10 GreenItems 11 BlueItems");
                handler->PSendSysMessage("12 PurpleItems 13 OrangeItems 14 YellowItems");

                return false;
            }

            uint32 greytg       = uint32(strtoul(param1 , NULL, 0));
            uint32 whitetg      = uint32(strtoul(param2 , NULL, 0));
            uint32 greentg      = uint32(strtoul(param3 , NULL, 0));
            uint32 bluetg       = uint32(strtoul(param4 , NULL, 0));
            uint32 purpletg     = uint32(strtoul(param5 , NULL, 0));
            uint32 orangetg     = uint32(strtoul(param6 , NULL, 0));
            uint32 yellowtg     = uint32(strtoul(param7 , NULL, 0));
            uint32 greyi        = uint32(strtoul(param8 , NULL, 0));
            uint32 whitei       = uint32(strtoul(param9 , NULL, 0));
            uint32 greeni       = uint32(strtoul(param10, NULL, 0));
            uint32 bluei        = uint32(strtoul(param11, NULL, 0));
            uint32 purplei      = uint32(strtoul(param12, NULL, 0));
            uint32 orangei      = uint32(strtoul(param13, NULL, 0));
            uint32 yellowi      = uint32(strtoul(param14, NULL, 0));

            uint32 totalPercent = greytg + whitetg + greentg + bluetg + purpletg + orangetg + yellowtg + greyi + whitei + greeni + bluei + purplei + orangei + yellowi;

            if (totalPercent == 0 || totalPercent != 100)
            {
                handler->PSendSysMessage("The total must add up to 100%%");

                return false;
            }

            char param[100] = { 0 };

            strcat(param, param1);
            strcat(param, " ");
            strcat(param, param2);
            strcat(param, " ");
            strcat(param, param3);
            strcat(param, " ");
            strcat(param, param4);
            strcat(param, " ");
            strcat(param, param5);
            strcat(param, " ");
            strcat(param, param6);
            strcat(param, " ");
            strcat(param, param7);
            strcat(param, " ");
            strcat(param, param8);
            strcat(param, " ");
            strcat(param, param9);
            strcat(param, " ");
            strcat(param, param10);
            strcat(param, " ");
            strcat(param, param11);
            strcat(param, " ");
            strcat(param, param12);
            strcat(param, " ");
            strcat(param, param13);
            strcat(param, " ");
            strcat(param, param14);

            for (AuctionHouseBot* bot: gBots)
            {
                bot->Commands(AHBotCommand::percentages, ahMapID, 0, param);
            }
        }
        else if (strncmp(opt, "minprice", l) == 0)
        {
            char* param1 = strtok(NULL, " ");
            char* param2 = strtok(NULL, " ");

            if (!ahMapIdStr || !param1 || !param2)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions minprice $ahMapID (2, 6 or 7) $color (grey, white, green, blue, purple, orange or yellow) $price");
                return false;
            }

            auto quality = stringToItemQualities(param1, l);

            if (quality != static_cast<ItemQualities>(-1))
            {
                for (AuctionHouseBot* bot: gBots)
                {
                    bot->Commands(AHBotCommand::minprice, ahMapID, quality, param2);
                }
            }
            else
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions minprice $ahMapID (2, 6 or 7) $color (grey, white, green, blue, purple, orange or yellow) $price");
                return false;
            }
        }
        else if (strncmp(opt, "maxprice", l) == 0)
        {
            char* param1 = strtok(NULL, " ");
            char* param2 = strtok(NULL, " ");

            if (!ahMapIdStr || !param1 || !param2)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions maxprice $ahMapID (2, 6 or 7) $color (grey, white, green, blue, purple, orange or yellow) $price");
                return false;
            }

            auto quality = stringToItemQualities(param1, l);

            if (quality != static_cast<ItemQualities>(-1))
            {
                for (AuctionHouseBot* bot: gBots)
                {
                    bot->Commands(AHBotCommand::maxprice, ahMapID, quality, param2);
                }
            }
            else
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions maxprice $ahMapID (2, 6 or 7) $color (grey, white, green, blue, purple, orange or yellow) $price");
                return false;
            }
        }
        else if (strncmp(opt, "minbidprice", l) == 0)
        {
            char* param1 = strtok(NULL, " ");
            char* param2 = strtok(NULL, " ");

            if (!ahMapIdStr || !param2 || !param2)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions minbidprice $ahMapID (2, 6 or 7) $color (grey, white, green, blue, purple, orange or yellow) $price");
                return false;
            }

            uint32 minBidPrice = uint32(strtoul(param2, NULL, 0));

            if (minBidPrice < 1 || minBidPrice > 100)
            {
                handler->PSendSysMessage("The min bid price multiplier must be between 1 and 100");
                return false;
            }

            auto quality = stringToItemQualities(param1, l);

            if (quality != static_cast<ItemQualities>(-1))
            {
                for (AuctionHouseBot* bot: gBots)
                {
                    bot->Commands(AHBotCommand::minbidprice, ahMapID, quality, param2);
                }
            }
            else
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions minbidprice $ahMapID (2, 6 or 7) $color (grey, white, green, blue, purple, orange or yellow) $price");
                return false;
            }
        }
        else if (strncmp(opt, "maxbidprice", l) == 0)
        {
            char* param1 = strtok(NULL, " ");
            char* param2 = strtok(NULL, " ");

            if (!ahMapIdStr || !param1 || !param2)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions maxbidprice $ahMapID (2, 6 or 7) $color (grey, white, green, blue, purple, orange or yellow) $price");
                return false;
            }

            uint32 maxBidPrice = uint32(strtoul(param2, NULL, 0));

            if (maxBidPrice < 1 || maxBidPrice > 100)
            {
                handler->PSendSysMessage("The max bid price multiplier must be between 1 and 100");
                return false;
            }

            auto quality = stringToItemQualities(param1, l);

            if (quality != static_cast<ItemQualities>(-1))
            {
                for (AuctionHouseBot* bot: gBots)
                {
                    bot->Commands(AHBotCommand::maxbidprice, ahMapID, quality, param2);
                }
            }
            else
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions max bidprice $ahMapID (2, 6 or 7) $color (grey, white, green, blue, purple, orange or yellow) $price");
                return false;
            }
        }
        else if (strncmp(opt, "maxstack",l) == 0)
        {
            char* param1 = strtok(NULL, " ");
            char* param2 = strtok(NULL, " ");

            if (!ahMapIdStr || !param1 || !param2)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions maxstack $ahMapID (2, 6 or 7) $color (grey, white, green, blue, purple, orange or yellow) $value");
                return false;
            }

            // uint32 maxStack = uint32(strtoul(param2, NULL, 0));
            // if (maxStack < 0)
            // {
            //     handler->PSendSysMessage("maxstack can't be a negative number.");
            //    return false;
            // }

            auto quality = stringToItemQualities(param1, l);

            if (quality != static_cast<ItemQualities>(-1))
            {
                for (AuctionHouseBot* bot: gBots)
                {
                    bot->Commands(AHBotCommand::maxstack, ahMapID, quality, param2);
                }
            }
            else
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions maxstack $ahMapID (2, 6 or 7) $color (grey, white, green, blue, purple, orange or yellow) $value");
                return false;
            }
        }
        else if (strncmp(opt, "buyerprice", l) == 0)
        {
            char* param1 = strtok(NULL, " ");
            char* param2 = strtok(NULL, " ");

            if (!ahMapIdStr || !param1 || !param2)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions buyerprice $ahMapID (2, 6 or 7) $color (grey, white, green, blue or purple) $price");
                return false;
            }

            auto quality = stringToItemQualities(param1, l);

            if (quality != static_cast<ItemQualities>(-1))
            {
                for (AuctionHouseBot* bot: gBots)
                {
                    bot->Commands(AHBotCommand::buyerprice, ahMapID, quality, param2);
                }
            }
            else
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions buyerprice $ahMapID (2, 6 or 7) $color (grey, white, green, blue or purple) $price");
                return false;
            }
        }
        else if (strncmp(opt, "bidinterval", l) == 0)
        {
            char* param1 = strtok(NULL, " ");

            if (!ahMapIdStr || !param1)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions bidinterval $ahMapID (2, 6 or 7) $interval(in minutes)");
                return false;
            }

            for (AuctionHouseBot* bot: gBots)
            {
                bot->Commands(AHBotCommand::bidinterval, ahMapID, 0, param1);
            }
        }
        else if (strncmp(opt, "bidsperinterval", l) == 0)
        {
            char* param1 = strtok(NULL, " ");

            if (!ahMapIdStr || !param1)
            {
                handler->PSendSysMessage("Syntax is: ahbotoptions bidsperinterval $ahMapID (2, 6 or 7) $bids");
                return false;
            }

            for (AuctionHouseBot* bot: gBots)
            {
                bot->Commands(AHBotCommand::bidsperinterval, ahMapID, 0, param1);
            }
        }
        else
        {
            handler->PSendSysMessage("Invalid syntax");
            handler->PSendSysMessage("Try ahbotoptions help to see a list of options.");
            return false;
        }

        handler->PSendSysMessage("Done");
        return true;
    }
};

void AddAHBotCommandScripts()
{
    new ah_bot_commandscript();
}
