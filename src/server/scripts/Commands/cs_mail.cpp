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

#include "Bag.h"
#include "CharacterCache.h"
#include "Chat.h"
#include "CommandScript.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Language.h"
#include "Mail.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Timer.h"

using namespace Acore::ChatCommands;

class mail_commandscript : public CommandScript
{
public:
    mail_commandscript() : CommandScript("mail_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable mailCommandTable =
        {
            { "list",   HandleMailListCommand,   SEC_GAMEMASTER, Console::Yes },
            { "return", HandleMailReturnCommand,  SEC_GAMEMASTER, Console::Yes }
        };

        static ChatCommandTable commandTable =
        {
            { "mail", mailCommandTable }
        };

        return commandTable;
    }

    static char const* GetMailTypeString(uint8 messageType)
    {
        switch (messageType)
        {
            case MAIL_NORMAL:     return "Normal";
            case MAIL_AUCTION:    return "Auction";
            case MAIL_CREATURE:   return "Creature";
            case MAIL_GAMEOBJECT: return "GameObject";
            case MAIL_CALENDAR:   return "Calendar";
            default:              return "Unknown";
        }
    }

    static char const* GetMailStationeryString(uint8 stationery)
    {
        switch (stationery)
        {
            case MAIL_STATIONERY_TEST:    return "Test";
            case MAIL_STATIONERY_DEFAULT: return "Default";
            case MAIL_STATIONERY_GM:      return "GM";
            case MAIL_STATIONERY_AUCTION: return "Auction";
            case MAIL_STATIONERY_VAL:     return "Valentine";
            case MAIL_STATIONERY_CHR:     return "Christmas";
            case MAIL_STATIONERY_ORP:     return "Orphan";
            default:                      return "Unknown";
        }
    }

    static std::string GetItemListString(std::vector<MailItemInfo> const& items)
    {
        if (items.empty())
            return "none";

        std::string result;
        for (size_t i = 0; i < items.size(); ++i)
        {
            if (i > 0)
                result += ", ";

            result += Acore::StringFormat("{}(guid:{})", items[i].item_template, items[i].item_guid);
        }
        return result;
    }

    static bool HandleMailListCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        if (!target)
            target = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!target)
            return false;

        Player* player = target->GetConnectedPlayer();

        if (player)
        {
            PlayerMails const& mails = player->GetMails();

            if (mails.empty())
            {
                handler->PSendSysMessage(LANG_MAIL_LIST_EMPTY, handler->playerLink(target->GetName()));
                return true;
            }

            handler->PSendSysMessage(LANG_MAIL_LIST_HEADER, handler->playerLink(target->GetName()));

            for (Mail const* mail : mails)
            {
                std::string senderName;
                if (mail->messageType == MAIL_NORMAL)
                    sCharacterCache->GetCharacterNameByGuid(ObjectGuid(HighGuid::Player, mail->sender), senderName);

                std::string expireStr = Acore::Time::TimeToTimestampStr(Seconds(mail->expire_time));
                std::string deliverStr = Acore::Time::TimeToTimestampStr(Seconds(mail->deliver_time));

                handler->PSendSysMessage(LANG_MAIL_LIST_ENTRY,
                    mail->messageID, GetMailTypeString(mail->messageType), GetMailStationeryString(mail->stationery),
                    mail->mailTemplateId, mail->sender, senderName, mail->receiver,
                    expireStr, deliverStr, mail->money, mail->COD, mail->checked, GetItemListString(mail->items));
            }
        }
        else
        {
            ObjectGuid::LowType lowGuid = target->GetGUID().GetCounter();

            QueryResult result = CharacterDatabase.Query(
                "SELECT id, messageType, sender, receiver, subject, body, expire_time, deliver_time, money, cod, checked, stationery, mailTemplateId"
                " FROM mail WHERE receiver = {} AND deliver_time <= {} ORDER BY id DESC",
                lowGuid, GameTime::GetGameTime().count());

            if (!result)
            {
                handler->PSendSysMessage(LANG_MAIL_LIST_EMPTY, handler->playerLink(target->GetName()));
                return true;
            }

            handler->PSendSysMessage(LANG_MAIL_LIST_HEADER, handler->playerLink(target->GetName()));

            do
            {
                Field* fields = result->Fetch();
                uint32 messageID    = fields[0].Get<uint32>();
                uint8 messageType   = fields[1].Get<uint8>();
                uint32 sender       = fields[2].Get<uint32>();
                uint32 receiver     = fields[3].Get<uint32>();
                // fields[4] = subject (skipped)
                // fields[5] = body (skipped)
                uint32 expireTime   = fields[6].Get<uint32>();
                uint32 deliverTime  = fields[7].Get<uint32>();
                uint32 money        = fields[8].Get<uint32>();
                uint32 cod          = fields[9].Get<uint32>();
                uint32 checked      = fields[10].Get<uint32>();
                uint8 stationery    = fields[11].Get<uint8>();
                uint16 mailTemplate = fields[12].Get<uint16>();

                std::string senderName;
                if (messageType == MAIL_NORMAL)
                    sCharacterCache->GetCharacterNameByGuid(ObjectGuid(HighGuid::Player, sender), senderName);

                std::string expireStr = Acore::Time::TimeToTimestampStr(Seconds(expireTime));
                std::string deliverStr = Acore::Time::TimeToTimestampStr(Seconds(deliverTime));

                // For offline players we don't have item details loaded
                handler->PSendSysMessage(LANG_MAIL_LIST_ENTRY,
                    messageID, GetMailTypeString(messageType), GetMailStationeryString(stationery),
                    mailTemplate, sender, senderName, receiver,
                    expireStr, deliverStr, money, cod, checked, "N/A (offline)");
            } while (result->NextRow());
        }

        return true;
    }

    static bool HandleMailReturnCommand(ChatHandler* handler, PlayerIdentifier target, uint32 mailId)
    {
        // Query mail data from DB so this works for offline players
        QueryResult result = CharacterDatabase.Query(
            "SELECT messageType, sender, receiver, subject, body, money, mailTemplateId, checked, deliver_time"
            " FROM mail WHERE id = {}", mailId);

        if (!result)
        {
            handler->SendErrorMessage(LANG_MAIL_RETURN_NOT_FOUND, mailId);
            return true;
        }

        Field* fields       = result->Fetch();
        uint8 messageType   = fields[0].Get<uint8>();
        uint32 sender       = fields[1].Get<uint32>();
        uint32 receiver     = fields[2].Get<uint32>();
        std::string subject = fields[3].Get<std::string>();
        std::string body    = fields[4].Get<std::string>();
        uint32 money        = fields[5].Get<uint32>();
        uint16 mailTemplate = fields[6].Get<uint16>();
        uint32 checked      = fields[7].Get<uint32>();
        uint32 deliverTime  = fields[8].Get<uint32>();

        // Reject undelivered mail, same as the core handler
        if (deliverTime > GameTime::GetGameTime().count())
        {
            handler->SendErrorMessage(LANG_MAIL_RETURN_NOT_FOUND, mailId);
            return true;
        }

        // Verify the mail belongs to the target player
        if (receiver != target.GetGUID().GetCounter())
        {
            handler->SendErrorMessage(LANG_MAIL_RETURN_NOT_FOUND, mailId);
            return true;
        }

        if (messageType != MAIL_NORMAL)
        {
            handler->SendErrorMessage(LANG_MAIL_RETURN_NOT_NORMAL);
            return true;
        }

        if (!sender)
        {
            handler->SendErrorMessage(LANG_MAIL_RETURN_NO_SENDER);
            return true;
        }

        if (checked & MAIL_CHECK_MASK_RETURNED)
        {
            handler->SendErrorMessage(LANG_MAIL_RETURN_ALREADY_RETURNED);
            return true;
        }

        Player* player = target.GetConnectedPlayer();

        // Run the same script hook as the client return handler, failing early before any deletions
        if (player)
        {
            Mail* m = player->GetMail(mailId);
            if (m)
            {
                ObjectGuid senderGuid = ObjectGuid(HighGuid::Player, sender);

                if (m->HasItems())
                {
                    for (auto const& itemInfo : m->items)
                    {
                        Item* item = player->GetMItem(itemInfo.item_guid);
                        if (item && !sScriptMgr->OnPlayerCanSendMail(player, senderGuid, ObjectGuid::Empty, subject, body, money, 0, item))
                        {
                            handler->SendErrorMessage(LANG_MAIL_RETURN_HOOK_BLOCKED);
                            return true;
                        }
                    }
                }
                else if (!sScriptMgr->OnPlayerCanSendMail(player, senderGuid, ObjectGuid::Empty, subject, body, money, 0, nullptr))
                {
                    handler->SendErrorMessage(LANG_MAIL_RETURN_HOOK_BLOCKED);
                    return true;
                }
            }
        }

        // Same logic as WorldSession::HandleReturnToSender
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_BY_ID);
        stmt->SetData(0, mailId);
        trans->Append(stmt);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM_BY_ID);
        stmt->SetData(0, mailId);
        trans->Append(stmt);

        MailDraft draft(subject, body);
        if (mailTemplate)
            draft = MailDraft(mailTemplate, false);

        if (player)
        {
            // Online: same logic as WorldSession::HandleReturnToSender
            // Get pointer before RemoveMail (which removes from deque but does not delete the object)
            Mail* m = player->GetMail(mailId);

            player->RemoveMail(mailId);

            if (m && m->HasItems())
            {
                for (auto const& itemInfo : m->items)
                {
                    if (Item* item = player->GetMItem(itemInfo.item_guid))
                        draft.AddItem(item);

                    player->RemoveMItem(itemInfo.item_guid);
                }
            }

            delete m;
        }
        else
        {
            // Offline: load Item* objects from DB using same query shape as CHAR_SEL_MAILITEMS
            // (LEFT JOIN to handle dangling mail_items) and same logic as Player::_LoadMailedItem
            QueryResult itemResult = CharacterDatabase.Query(
                "SELECT creatorGuid, giftCreatorGuid, count, duration, charges, flags, enchantments,"
                " randomPropertyId, durability, playedTime, text, mi.item_guid, itemEntry, ii.owner_guid"
                " FROM mail_items mi LEFT JOIN item_instance ii ON mi.item_guid = ii.guid"
                " WHERE mi.mail_id = {}", mailId);

            if (itemResult)
            {
                do
                {
                    Field* itemFields = itemResult->Fetch();
                    uint32 itemGuid  = itemFields[11].Get<uint32>();
                    uint32 itemEntry = itemFields[12].Get<uint32>();

                    // Handle dangling mail_items (missing item_instance)
                    if (!itemEntry)
                    {
                        LOG_ERROR("misc", "cs_mail: Mail #{} has dangling mail_items row for item_guid {}. Cleaning up.", mailId, itemGuid);

                        CharacterDatabasePreparedStatement* delStmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INVALID_MAIL_ITEM);
                        delStmt->SetData(0, itemGuid);
                        trans->Append(delStmt);
                        continue;
                    }

                    ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemEntry);
                    if (!proto)
                    {
                        LOG_ERROR("misc", "cs_mail: Mail #{} has unknown item (entry: {}, guid: {}). Cleaning up.", mailId, itemEntry, itemGuid);

                        CharacterDatabasePreparedStatement* delStmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INVALID_MAIL_ITEM);
                        delStmt->SetData(0, itemGuid);
                        trans->Append(delStmt);
                        continue;
                    }

                    Item* item = NewItemOrBag(proto);
                    ObjectGuid ownerGuid = itemFields[13].Get<uint32>()
                        ? ObjectGuid::Create<HighGuid::Player>(itemFields[13].Get<uint32>())
                        : ObjectGuid::Empty;

                    if (!item->LoadFromDB(itemGuid, ownerGuid, itemFields, itemEntry))
                    {
                        LOG_ERROR("misc", "cs_mail: Item (GUID: {}) in mail #{} failed to load. Cleaning up.", itemGuid, mailId);

                        CharacterDatabasePreparedStatement* delStmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INVALID_MAIL_ITEM);
                        delStmt->SetData(0, itemGuid);
                        trans->Append(delStmt);

                        item->FSetState(ITEM_REMOVED);
                        CharacterDatabaseTransaction nullTrans = CharacterDatabaseTransaction(nullptr);
                        item->SaveToDB(nullTrans);
                        return true;
                    }

                    draft.AddItem(item);
                } while (itemResult->NextRow());
            }
        }

        uint32 accountId = sCharacterCache->GetCharacterAccountIdByGuid(ObjectGuid(HighGuid::Player, receiver));
        draft.AddMoney(money).SendReturnToSender(accountId, receiver, sender, trans);

        CharacterDatabase.CommitTransaction(trans);

        sCharacterCache->DecreaseCharacterMailCount(ObjectGuid(HighGuid::Player, receiver));

        handler->PSendSysMessage(LANG_MAIL_RETURN_SUCCESS, mailId, handler->playerLink(target.GetName()));
        return true;
    }
};

void AddSC_mail_commandscript()
{
    new mail_commandscript();
}
