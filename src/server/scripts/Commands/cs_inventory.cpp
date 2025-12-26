/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Chat.h"
#include "CommandScript.h"
#include "Language.h"
#include "Player.h"
#include "WorldSession.h"

constexpr std::array<const char*, MAX_ITEM_SUBCLASS_CONTAINER> bagSpecsToString =
{
    "normal",
    "soul",
    "herb",
    "enchanting",
    "engineering",
    "gem",
    "mining",
    "leatherworking",
    "inscription"
};

constexpr std::array<uint32, MAX_ITEM_SUBCLASS_CONTAINER> bagSpecsColors =
{
    0xfff0de18,     // YELLOW - Normal
    0xffa335ee,     // PURPLE - Souls
    0xff1eff00,     // GREEN - Herb
    0xffe37166,     // PINK - Enchanting
    0xffa68b30,     // BROWN - Engineering
    0xff0070dd,     // BLUE - Gem
    0xffc1c8c9,     // GREY - Mining
    0xfff5a925,     // ORANGE - Leatherworking
    0xff54504f      // DARK GREY - Inscription
};

//constexpr std::array<const char*, MAX_ITEM_SUBCLASS_CONTAINER> bagSpecsColorToString =
//{
//    "normal",
//    "soul",
//    "herb",
//    "enchanting",
//    "engineering",
//    "gem",
//    "mining",
//    "leatherworking",
//    "inscription"
//};

using namespace Acore::ChatCommands;

class inventory_commandscript : public CommandScript
{
public:
    inventory_commandscript() : CommandScript("inventory_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable inventoryCommandTable =
        {
            { "count",      HandleInventoryCountCommand,   SEC_MODERATOR, Console::No }
        };

        static ChatCommandTable commandTable =
        {
            { "inventory",  inventoryCommandTable }
        };

        return commandTable;
    }

    static bool HandleInventoryCountCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
        {
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!player)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        Player* target = player->GetConnectedPlayer();
        if (!target)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        std::array<uint32, MAX_ITEM_SUBCLASS_CONTAINER> freeSlotsInBags = { };
        uint32 freeSlotsForBags = 0;
        bool haveFreeSlot = false;

        // Check backpack
        for (uint8 slot = INVENTORY_SLOT_ITEM_START; slot < INVENTORY_SLOT_ITEM_END; ++slot)
        {
            if (!target->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
            {
                haveFreeSlot = true;
                ++freeSlotsInBags[ITEM_SUBCLASS_CONTAINER];
            }
        }

        // Check bags
        for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        {
            if (Bag* bag = target->GetBagByPos(i))
            {
                if (ItemTemplate const* bagTemplate = bag->GetTemplate())
                {
                    if (bagTemplate->Class == ITEM_CLASS_CONTAINER || bagTemplate->Class == ITEM_CLASS_QUIVER)
                    {
                        haveFreeSlot = true;
                        freeSlotsInBags[bagTemplate->SubClass] += bag->GetFreeSlots();
                    }
                }
            }
            else
            {
                ++freeSlotsForBags;
            }
        }

        std::ostringstream str;

        if (haveFreeSlot)
        {
            str << "Player " << target->GetName() << " have ";
            bool initialize = true;

            for (uint8 i = ITEM_SUBCLASS_CONTAINER; i < MAX_ITEM_SUBCLASS_CONTAINER; ++i)
            {
                if (uint32 freeSlots = freeSlotsInBags[i])
                {
                    std::string bagSpecString = bagSpecsToString[i];
                    if (!initialize)
                    {
                        str << ", ";
                    }

                    str << "|c";
                    str << std::hex << bagSpecsColors[i] << std::dec;
                    str << freeSlots << " in " << bagSpecString << " bags|r";

                    initialize = false;
                }
            }
        }
        else
        {
            str << "Player " << target->GetName() << " does not have free slots in their bags";
        }

        if (freeSlotsForBags)
        {
            str << " and also has " << freeSlotsForBags << " free slots for bags";
        }

        str << ".";

        handler->SendSysMessage(str.str().c_str());

        return true;
    }
};

void AddSC_inventory_commandscript()
{
    new inventory_commandscript();
}
