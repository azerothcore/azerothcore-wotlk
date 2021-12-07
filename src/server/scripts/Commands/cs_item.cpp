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
        static ChatCommandTable HandleItemRestoreCommandTable =
        {
            { "list",      HandleItemRestoreListCommand,        SEC_GAMEMASTER,    Console::Yes },
            { "",          HandleItemRestoreCommand,            SEC_GAMEMASTER,    Console::Yes },
        };
        static ChatCommandTable itemCommandTable =
        {
            { "restore",   HandleItemRestoreCommandTable,       SEC_GAMEMASTER,    Console::No },
            { "move",      HandleItemMoveCommand,               SEC_GAMEMASTER,    Console::Yes },
        };
        static ChatCommandTable commandTable =
        {
            { "item",     itemCommandTable }
        };
        return commandTable;
    }

    static bool HandleItemRestoreCommand(ChatHandler* handler, ItemTemplate const* item, PlayerIdentifier player)
    {
        if (!HasItemDeletionConfig())
        {
            handler->SendSysMessage(LANG_COMMAND_DISABLED);
            handler->SetSentErrorMessage(true);
            return false;
        }

       if (!item)
        {
            handler->SendSysMessage(LANG_ITEM_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Remove from recovery table
        // TODO - Check if exist
        // CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_RECOVERY_ITEM);
        // stmt->setUInt32(0, player.GetGUID().GetCounter());
        // stmt->setUInt32(1, item->ItemId);
        // stmt->setUInt32(2, 1);
        // CharacterDatabase.Execute(stmt);

        // Add to character.
        // Check space and find places
        // int32 count = 1;
        // uint32 noSpaceForCount = 0;
        // ItemPosCountVec dest;

        //Player*         player = sCharacterCache->GetCharacterCacheByGuid(player.GetGUID());
        //InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, item->Id, count, &noSpaceForCount);
        //  if (msg != EQUIP_ERR_OK)
        //    count -= noSpaceForCount;

        // No slots available
       // if (count == 0 || dest.empty())
        //{
           // handler->PSendSysMessage(LANG_ITEM_CANNOT_CREATE, itemId, noSpaceForCount);
          //  handler->SetSentErrorMessage(true);
            //return false;
    //    }

        //Item* item = playerTarget->StoreNewItem(dest, itemId, true);

        return true;
    }

    static bool HandleItemRestoreListCommand(ChatHandler* handler, PlayerIdentifier player)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_RECOVERY_ITEM_LIST);
        stmt->setUInt32(0, player.GetGUID().GetCounter());

        CharacterDatabase.Execute(stmt);
        PreparedQueryResult disposedItems = CharacterDatabase.Query(stmt);

        if (disposedItems)
        {
                Field* fields           = disposedItems->Fetch();
                uint32 id               = fields[0].GetUInt32();
                uint32 itemId           = fields[3].GetUInt32();
                uint32 count            = fields[3].GetUInt32();
                handler->PSendSysMessage(LANG_ITEMLIST_SLOT, id, itemId, count);
        }
        else
        {
            handler->SendSysMessage(LANG_COMMAND_NOITEMFOUND);
            handler->SetSentErrorMessage(true);
            return false;
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

    static bool HasItemDeletionConfig()
    {
      return sWorld->getBoolConfig(CONFIG_ITEMDELETE_METHOD) || sWorld->getBoolConfig(CONFIG_ITEMDELETE_VENDOR);
    }
};

void AddSC_item_commandscript()
{
    new item_commandscript();
}
