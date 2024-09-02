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
#include "CommandScript.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "Mail.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "Player.h"
#include "Tokenize.h"

using namespace Acore::ChatCommands;

class send_commandscript : public CommandScript
{
public:
    send_commandscript() : CommandScript("send_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable sendCommandTable =
        {
            { "items",   HandleSendItemsCommand,   SEC_GAMEMASTER,    Console::Yes },
            { "mail",    HandleSendMailCommand,    SEC_GAMEMASTER,    Console::Yes },
            { "message", HandleSendMessageCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "money",   HandleSendMoneyCommand,   SEC_GAMEMASTER,    Console::Yes }
        };

        static ChatCommandTable commandTable =
        {
            { "send", sendCommandTable }
        };

        return commandTable;
    }

    static bool HandleSendItemsCommand(ChatHandler* handler, Optional<PlayerIdentifier> target, QuotedString subject, QuotedString text, Tail items)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target)
        {
            return false;
        }

        // extract items
        std::vector<std::pair<uint32, uint32>> itemList;

        for (auto const& itemString : Acore::Tokenize(items, ' ', true))
        {
            auto itemTokens = Acore::Tokenize(itemString, ':', false);

            uint32 itemCount;
            switch (itemTokens.size())
            {
                case 1:
                    itemCount = 1; // Default to sending 1 item
                    break;
                case 2:
                    itemCount = *Acore::StringTo<uint32>(itemTokens.at(1));
                    break;
                default:
                    handler->SendSysMessage(Acore::StringFormatFmt("> Incorrect item list format for '{}'", itemString));
                    continue;
            }

            uint32 itemID = *Acore::StringTo<uint32>(itemTokens.at(0));

            ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemID);
            if (!itemTemplate)
            {
                handler->SendErrorMessage(LANG_COMMAND_ITEMIDINVALID, itemID);
                return false;
            }

            if (!itemCount || (itemTemplate->MaxCount > 0 && itemCount > uint32(itemTemplate->MaxCount)))
            {
                handler->SendErrorMessage(LANG_COMMAND_INVALID_ITEM_COUNT, itemCount, itemID);
                return false;
            }

            while (itemCount > itemTemplate->GetMaxStackSize())
            {
                itemList.emplace_back(itemID, itemTemplate->GetMaxStackSize());
                itemCount -= itemTemplate->GetMaxStackSize();
            }

            itemList.emplace_back(itemID, itemCount);

            if (itemList.size() > MAX_MAIL_ITEMS)
            {
                handler->SendErrorMessage(LANG_COMMAND_MAIL_ITEMS_LIMIT, MAX_MAIL_ITEMS);
                return false;
            }
        }

        // If the message is sent from console, set it as sent by the target itself, like the other Customer Support mails.
        ObjectGuid::LowType senderGuid = handler->GetSession() ? handler->GetSession()->GetPlayer()->GetGUID().GetCounter() : target->GetGUID().GetCounter();

        // fill mail
        MailDraft draft(subject, text);
        MailSender sender(MAIL_NORMAL, senderGuid, MAIL_STATIONERY_GM);
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        for (auto const& [itemID, itemCount] : itemList)
        {
            if (Item* item = Item::CreateItem(itemID, itemCount, handler->GetSession() ? handler->GetSession()->GetPlayer() : 0))
            {
                item->SaveToDB(trans); // save for prevent lost at next mail load, if send fail then item will deleted
                draft.AddItem(item);
            }
        }

        draft.SendMailTo(trans, MailReceiver(target->GetConnectedPlayer(), target->GetGUID().GetCounter()), sender);
        CharacterDatabase.CommitTransaction(trans);

        handler->PSendSysMessage(LANG_MAIL_SENT, handler->playerLink(target->GetName()));
        return true;
    }

    static bool HandleSendMailCommand(ChatHandler* handler, Optional<PlayerIdentifier> target, QuotedString subject, QuotedString text)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target)
        {
            return false;
        }

        ObjectGuid::LowType senderGuid = handler->GetSession() ? handler->GetSession()->GetPlayer()->GetGUID().GetCounter() : target->GetGUID().GetCounter();

        // If the message is sent from console, set it as sent by the target itself, like the other Customer Support mails.
        MailSender sender(MAIL_NORMAL, senderGuid, MAIL_STATIONERY_GM);
        MailDraft draft(subject, text);
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        draft.SendMailTo(trans, MailReceiver(target->GetConnectedPlayer(), target->GetGUID().GetCounter()), sender);
        CharacterDatabase.CommitTransaction(trans);

        handler->PSendSysMessage(LANG_MAIL_SENT, handler->playerLink(target->GetName()));
        return true;
    }

    static bool HandleSendMessageCommand(ChatHandler* handler, Optional<PlayerIdentifier> target, Tail message)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target || !target->IsConnected())
        {
            return false;
        }

        Player* player = target->GetConnectedPlayer();
        std::string msg = std::string{ message };

        /// - Send the message
        // Use SendAreaTriggerMessage for fastest delivery.
        player->GetSession()->SendAreaTriggerMessage("%s", msg.c_str());
        player->GetSession()->SendAreaTriggerMessage("|cffff0000[Message from administrator]:|r");

        // Confirmation message
        handler->PSendSysMessage(LANG_SENDMESSAGE, handler->playerLink(target->GetName()), msg);

        return true;
    }

    static bool HandleSendMoneyCommand(ChatHandler* handler, Optional<PlayerIdentifier> target, QuotedString subject, QuotedString text, uint32 money)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target)
        {
            return false;
        }

        // from console show not existed sender
        MailSender sender(MAIL_NORMAL, handler->GetSession() ? handler->GetSession()->GetPlayer()->GetGUID().GetCounter() : 0, MAIL_STATIONERY_GM);

        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        MailDraft(subject, text)
        .AddMoney(money)
        .SendMailTo(trans, MailReceiver(target->GetConnectedPlayer(), target->GetGUID().GetCounter()), sender);

        CharacterDatabase.CommitTransaction(trans);

        handler->PSendSysMessage(LANG_MAIL_SENT, handler->playerLink(target->GetName()));
        return true;
    }
};

void AddSC_send_commandscript()
{
    new send_commandscript();
}
