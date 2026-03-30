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
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Player.h"

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
            { "restore",   HandleItemRestoreCommandTable },
            { "move",      HandleItemMoveCommand,               SEC_GAMEMASTER,    Console::Yes },
            { "refund",    HandleItemRefundCommand,             SEC_ADMINISTRATOR, Console::Yes },
        };
        static ChatCommandTable commandTable =
        {
            { "item",      itemCommandTable }
        };
        return commandTable;
    }

    static bool HandleItemRestoreCommand(ChatHandler* handler, uint32 restoreId, PlayerIdentifier player)
    {
        if (!restoreId)
        {
            return false;
        }

        if (!HasItemDeletionConfig())
        {
            handler->SendErrorMessage(LANG_COMMAND_DISABLED);
            return false;
        }

        // Check existence of item in recovery table
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_RECOVERY_ITEM);
        stmt->SetData(0, restoreId);
        PreparedQueryResult fields = CharacterDatabase.Query(stmt);

        if (!fields || !(*fields)[1].Get<uint32>() || (*fields)[3].Get<uint32>() != player.GetGUID().GetCounter())
        {
            handler->SendErrorMessage(LANG_ITEM_RESTORE_MISSING);
            return false;
        }

        // Mail item to player
        uint32 itemEntry = (*fields)[1].Get<uint32>();
        uint32 itemCount = (*fields)[2].Get<uint32>();

        if (Player* onlinePlayer = player.GetConnectedPlayer())
        {
            onlinePlayer->SendItemRetrievalMail({ { itemEntry, itemCount } });
        }

        else
        {
            MailSender sender(MAIL_CREATURE, 34337 /* The Postmaster */);
            MailDraft draft("Recovered Item", "We recovered a lost item in the twisting nether and noted that it was yours.$B$BPlease find said object enclosed.");

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

            // Save to prevent loss at next mail load. Item deletes on fail
            if (Item* item = Item::CreateItem(itemEntry, itemCount, 0))
            {
                item->SaveToDB(trans);
                draft.AddItem(item);
            }

            draft.SendMailTo(trans, MailReceiver(player.GetGUID().GetCounter()), sender);
            CharacterDatabase.CommitTransaction(trans);
        }

        // Remove from recovery table
        CharacterDatabasePreparedStatement* delStmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_RECOVERY_ITEM_BY_RECOVERY_ID);
        delStmt->SetData(0, (*fields)[0].Get<uint32>());
        CharacterDatabase.Execute(delStmt);

        std::string nameLink = handler->playerLink(player.GetName());
        handler->PSendSysMessage(LANG_MAIL_SENT, nameLink);
        return true;
    }

    static bool HandleItemRestoreListCommand(ChatHandler* handler, PlayerIdentifier player)
    {
        if (!HasItemDeletionConfig())
        {
            handler->SendErrorMessage(LANG_COMMAND_DISABLED);
            return false;
        }

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_RECOVERY_ITEM_LIST);
        stmt->SetData(0, player.GetGUID().GetCounter());
        PreparedQueryResult disposedItems = CharacterDatabase.Query(stmt);

        if (!disposedItems)
        {
            handler->SendErrorMessage(LANG_ITEM_RESTORE_LIST_EMPTY);
            return false;
        }

        do
        {
            Field* fields    = disposedItems->Fetch();
            uint32 id        = fields[0].Get<uint32>();
            uint32 itemId    = fields[1].Get<uint32>();
            uint32 count     = fields[2].Get<uint32>();

            std::string itemName = "";
            if (ItemTemplate const* item = sObjectMgr->GetItemTemplate(itemId))
            {
                itemName = item->Name1;
            }

            handler->PSendSysMessage(LANG_ITEM_RESTORE_LIST, id, itemName, itemId, count);
        } while (disposedItems->NextRow());

        return true;
    }

    /// @todo - move item to other slot
    static bool HandleItemMoveCommand(ChatHandler* handler, uint8 srcSlot, uint8 dstSlot)
    {
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

    static bool HandleItemRefundCommand(ChatHandler* handler, PlayerIdentifier player, uint32 itemId, uint32 extendedCost)
    {
        ItemExtendedCostEntry const* iece = sItemExtendedCostStore.LookupEntry(extendedCost);
        if (!iece)
        {
            handler->SendErrorMessage(LANG_CMD_ITEM_REFUND_BAD_EXTENDED_COST);
            return false;
        }

        ItemTemplate const* item = sObjectMgr->GetItemTemplate(itemId);

        if (!item)
        {
            handler->SendErrorMessage(LANG_COMMAND_ITEMIDINVALID, itemId);
            return false;
        }

        if (Player* target = player.GetConnectedPlayer())
        {
            if (!target->HasItemCount(itemId, 1, true))
            {
                handler->SendErrorMessage(LANG_CMD_ITEM_REFUND_NOT_FOUND, itemId);
                return false;
            }

            if (iece->reqhonorpoints)
            {
                uint32 honor = target->GetHonorPoints() + iece->reqhonorpoints;
                if (honor > sWorld->getIntConfig(CONFIG_MAX_HONOR_POINTS))
                {
                    handler->SendErrorMessage(LANG_CMD_ITEM_REFUND_MAX_HONOR, item->Name1, item->ItemId, sWorld->getIntConfig(CONFIG_MAX_HONOR_POINTS), target->GetHonorPoints(), iece->reqhonorpoints);
                    ChatHandler(target->GetSession()).PSendSysMessage(LANG_CMD_ITEM_REFUND_HONOR_FAILED, item->Name1);
                    return false;
                }

                target->SetHonorPoints(honor);
                ChatHandler(target->GetSession()).PSendSysMessage(LANG_CMD_ITEM_REFUNDED_HONOR, item->Name1, item->ItemId, iece->reqhonorpoints);
                handler->PSendSysMessage(LANG_CMD_ITEM_REFUNDED_HONOR, item->Name1, item->ItemId, iece->reqhonorpoints);
            }

            if (iece->reqarenapoints)
            {
                uint32 arenapoints = target->GetArenaPoints() + iece->reqarenapoints;
                if (arenapoints > sWorld->getIntConfig(CONFIG_MAX_ARENA_POINTS))
                {
                    handler->SendErrorMessage(LANG_CMD_ITEM_REFUND_MAX_AP, item->Name1, item->ItemId, sWorld->getIntConfig(CONFIG_MAX_ARENA_POINTS), target->GetArenaPoints(), iece->reqarenapoints);
                    ChatHandler(target->GetSession()).PSendSysMessage(LANG_CMD_ITEM_REFUND_AP_FAILED, item->Name1);
                    return false;
                }

                target->SetArenaPoints(arenapoints);
                ChatHandler(target->GetSession()).PSendSysMessage(LANG_CMD_ITEM_REFUNDED_AP, item->Name1, item->ItemId, iece->reqarenapoints);
                handler->PSendSysMessage(LANG_CMD_ITEM_REFUNDED_AP, item->Name1, item->ItemId, iece->reqarenapoints);
            }

            uint8 count = 0;
            for (uint32 const& reqItem : iece->reqitem)
            {
                if (reqItem)
                {
                    target->AddItem(reqItem, iece->reqitemcount[count]);
                }

                ++count;
            }

            target->DestroyItemCount(itemId, 1, true);
        }
        else
        {
            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            CharacterDatabasePreparedStatement* stmt;

            ObjectGuid::LowType guid = player.GetGUID().GetCounter();

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_INVENTORY_ITEM_BY_ENTRY_AND_OWNER);
            stmt->SetData(0, itemId);
            stmt->SetData(1, guid);

            PreparedQueryResult result = CharacterDatabase.Query(stmt);

            if (result)
            {
                if (iece->reqhonorpoints)
                {
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_HONORPOINTS);
                    stmt->SetData(0, guid);

                    PreparedQueryResult queryResult = CharacterDatabase.Query(stmt);

                    if (queryResult)
                    {
                        Field* fields = queryResult->Fetch();
                        if ((fields[0].Get<uint32>() + iece->reqhonorpoints) > sWorld->getIntConfig(CONFIG_MAX_HONOR_POINTS))
                        {
                            handler->SendErrorMessage(LANG_CMD_ITEM_REFUND_MAX_HONOR, item->Name1, item->ItemId, sWorld->getIntConfig(CONFIG_MAX_HONOR_POINTS), fields[0].Get<uint32>(), iece->reqhonorpoints);
                            return false;
                        }
                    }

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_HONOR_POINTS_ACCUMULATIVE);
                    stmt->SetData(0, iece->reqhonorpoints);
                    stmt->SetData(1, guid);
                    trans->Append(stmt);
                    handler->PSendSysMessage(LANG_CMD_ITEM_REFUNDED_HONOR, item->Name1, item->ItemId, iece->reqhonorpoints);
                }

                if (iece->reqarenapoints)
                {
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ARENAPOINTS);
                    stmt->SetData(0, guid);

                    PreparedQueryResult queryResult = CharacterDatabase.Query(stmt);

                    if (queryResult)
                    {
                        Field* fields = queryResult->Fetch();
                        if ((fields[0].Get<uint32>() + iece->reqhonorpoints) > sWorld->getIntConfig(CONFIG_MAX_ARENA_POINTS))
                        {
                            handler->SendErrorMessage(LANG_CMD_ITEM_REFUND_MAX_AP, item->Name1, item->ItemId, sWorld->getIntConfig(CONFIG_MAX_ARENA_POINTS), fields[0].Get<uint32>(), iece->reqarenapoints);
                            return false;
                        }
                    }

                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_ARENA_POINTS_ACCUMULATIVE);
                    stmt->SetData(0, iece->reqarenapoints);
                    stmt->SetData(1, guid);
                    trans->Append(stmt);
                    handler->PSendSysMessage(LANG_CMD_ITEM_REFUNDED_AP, item->Name1, item->ItemId, iece->reqarenapoints);
                }

                MailSender sender(MAIL_NORMAL, guid, MAIL_STATIONERY_GM);
                // fill mail
                std::string msg = "Your item " + item->Name1 + " has been removed and the used currency restored. This mail contains any items used as currency.";
                MailDraft   draft("Item Refund", msg);

                uint8 count      = 0;
                bool  foundItems = false;
                for (uint32 const& reqItem : iece->reqitem)
                {
                    if (reqItem)
                    {
                        // Skip invalid items.
                        if (!sObjectMgr->GetItemTemplate(reqItem))
                        {
                            continue;
                        }

                        if (Item* item = Item::CreateItem(reqItem, iece->reqitemcount[count]))
                        {
                            item->SaveToDB(trans);
                            draft.AddItem(item);
                            foundItems = true;
                        }
                    }

                    ++count;
                }

                if (foundItems)
                {
                    draft.SendMailTo(trans, MailReceiver(nullptr, guid), sender);
                }

                Field* fields = result->Fetch();

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY_BY_ITEM);
                stmt->SetData(0, fields[0].Get<uint32>());
                trans->Append(stmt);

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
                stmt->SetData(0, fields[0].Get<uint32>());
                trans->Append(stmt);

                CharacterDatabase.CommitTransaction(trans);
            }
            else
            {
                handler->SendErrorMessage(LANG_CMD_ITEM_REFUND_NOT_FOUND, itemId);
                return false;
            }
        }

        return true;
    }
};

void AddSC_item_commandscript()
{
    new item_commandscript();
}
