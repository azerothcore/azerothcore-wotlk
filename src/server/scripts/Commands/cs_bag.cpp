/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Chat.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"

constexpr std::array<std::string_view, MAX_ITEM_QUALITY> itemQualityToString =
{
    "poor",
    "normal",
    "uncommon",
    "rare",
    "epic",
    "legendary",
    "artifact",
    "all"
};

using namespace Acore::ChatCommands;

class bg_commandscript : public CommandScript
{
public:
    bg_commandscript() : CommandScript("bg_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable commandTable =
        {
            { "bags clear",  HandleBagsClearCommand, SEC_GAMEMASTER, Console::No },
        };

        return commandTable;
    }

    static bool HandleBagsClearCommand(ChatHandler* handler, std::string_view args)
    {
        if (args.empty())
        {
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();
        if (!player)
        {
            return false;
        }

        uint8 itemQuality = MAX_ITEM_QUALITY;
        for (uint8 i = ITEM_QUALITY_POOR; i < MAX_ITEM_QUALITY; ++i)
        {
            if (args == itemQualityToString[i])
            {
                itemQuality = i;
                break;
            }
        }

        if (itemQuality == MAX_ITEM_QUALITY)
        {
            return false;
        }

        std::array<uint32, MAX_ITEM_QUALITY> removedItems = { };

        // in inventory
        for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
        {
            if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            {
                if (ItemTemplate const* itemTemplate = item->GetTemplate())
                {
                    if (itemTemplate->Quality <= itemQuality)
                    {
                        player->DestroyItem(INVENTORY_SLOT_BAG_0, i, true);
                        ++removedItems[itemTemplate->Quality];
                    }
                }
            }
        }

        // in inventory bags
        for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        {
            if (Bag* bag = player->GetBagByPos(i))
            {
                for (uint32 j = 0; j < bag->GetBagSize(); j++)
                {
                    if (Item* item = bag->GetItemByPos(j))
                    {
                        if (ItemTemplate const* itemTemplate = item->GetTemplate())
                        {
                            if (itemTemplate->Quality <= itemQuality)
                            {
                                player->DestroyItem(i, j, true);
                                ++removedItems[itemTemplate->Quality];
                            }
                        }
                    }
                }
            }
        }

        std::ostringstream str;
        str << "Removed ";
        if (itemQuality == ITEM_QUALITY_HEIRLOOM)
        {
            str << "all";
        }
        else
        {
            bool initialize = true;
            for (uint8 i = ITEM_QUALITY_POOR; i < MAX_ITEM_QUALITY; ++i)
            {
                if (uint32 itemCount = removedItems[i])
                {
                    std::string_view itemQualityString = itemQualityToString[i];

                    if (!initialize)
                    {
                        str << ", ";
                    }

                    str << "|c";
                    str << std::hex << ItemQualityColors[i] << std::dec;
                    str << itemCount << " " << itemQualityString << "|r";

                    initialize = false;
                }
            }
        }

        str << " items from your bags.";

        handler->SendSysMessage(str.str().c_str());

        return true;
    };
};

void AddSC_bag_commandscript()
{
    new bg_commandscript();
}
