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

/* ScriptData
Name: item_commandscript
%Complete: 0
Comment: All item related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Language.h"

using namespace Acore::ChatCommands;

class item_commandscript : public CommandScript
{
public:
    item_commandscript() : CommandScript("item_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable itemCommandTable =
        {
            { "restore", HandleItemRestoreCommand,   SEC_GAMEMASTER,    Console::Yes },
            { "move",    HandleItemMoveCommand,      SEC_GAMEMASTER,    Console::Yes },
        };
        static ChatCommandTable commandTable =
        {{"item", itemCommandTable}
        };
        return commandTable;
    }

    static bool HandleItemRestoreCommand(ChatHandler* handler, ItemTemplate const* item, PlayerIdentifier player)
    {
       if (!item)
        {
            handler->SendSysMessage(LANG_ITEM_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (Player* target = player.GetConnectedPlayer())
        {
            target->Say("thanks", LANG_UNIVERSAL);
        }

        return true;
    }

    // TODO - move item to other slot
    static bool HandleItemMoveCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char const* param1 = strtok((char*)args, " ");
        if (!param1)
            return false;

        char const* param2 = strtok(nullptr, " ");
        if (!param2)
            return false;

        uint8 srcSlot = uint8(atoi(param1));
        uint8 dstSlot = uint8(atoi(param2));

        if (srcSlot == dstSlot)
            return true;

        if (!handler->GetSession()->GetPlayer()->IsValidPos(INVENTORY_SLOT_BAG_0, srcSlot, true))
            return false;

        if (!handler->GetSession()->GetPlayer()->IsValidPos(INVENTORY_SLOT_BAG_0, dstSlot, false))
            return false;

        uint16 src = ((INVENTORY_SLOT_BAG_0 << 8) | srcSlot);
        uint16 dst = ((INVENTORY_SLOT_BAG_0 << 8) | dstSlot);

        handler->GetSession()->GetPlayer()->SwapItem(src, dst);

        return true;
    }

};

void AddSC_item_commandscript()
{
    new item_commandscript();
}
