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

#include "AccountMgr.h"
#include "Chat.h"
#include "CharacterCache.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Item.h"
#include "Language.h"
#include "Log.h"
#include "Mail.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "WorldPacket.h"
#include "WorldSession.h"

#define MAX_INBOX_CLIENT_CAPACITY 50

bool WorldSession::CanOpenMailBox(ObjectGuid guid)
{
    if (guid == _player->GetGUID())
    {
        if (_player->GetSession()->GetSecurity() < SEC_MODERATOR)
        {
            LOG_ERROR("network.opcode", "{} attempt open mailbox in cheating way.", _player->GetName());
            return false;
        }
    }
    else if (guid.IsGameObject())
    {
        if (!_player->GetGameObjectIfCanInteractWith(guid, GAMEOBJECT_TYPE_MAILBOX))
            return false;
    }
    else if (guid.IsAnyTypeCreature())
    {
        if (!_player->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_MAILBOX))
            return false;
    }
    else
        return false;

    return true;
}

void WorldSession::HandleSendMail(WorldPacket& recvData)
{
    ObjectGuid mailbox;
    uint64 unk3;
    std::string receiver, subject, body;
    uint32 unk1, unk2, money, COD;
    uint8 unk4;

    recvData >> mailbox;
    recvData >> receiver;

    recvData >> subject;

    // prevent client crash
    if (subject.find("| |") != std::string::npos || body.find("| |") != std::string::npos)
    {
        return;
    }

    recvData >> body;

    recvData >> unk1;                                      // stationery?
    recvData >> unk2;                                      // 0x00000000

    uint8 items_count;
    recvData >> items_count;                               // attached items count

    if (items_count > MAX_MAIL_ITEMS)                       // client limit
    {
        GetPlayer()->SendMailResult(0, MAIL_SEND, MAIL_ERR_TOO_MANY_ATTACHMENTS);
        recvData.rfinish();                   // set to end to avoid warnings spam
        return;
    }

    ObjectGuid itemGUIDs[MAX_MAIL_ITEMS];

    for (uint8 i = 0; i < items_count; ++i)
    {
        recvData.read_skip<uint8>();                       // item slot in mail, not used
        recvData >> itemGUIDs[i];
    }

    recvData >> money >> COD;                              // money and cod
    recvData >> unk3;                                      // const 0
    recvData >> unk4;                                      // const 0

    // packet read complete, now do check

    if (!CanOpenMailBox(mailbox))
        return;

    if (receiver.empty())
        return;

    Player* player = _player;

    if (player->GetLevel() < sWorld->getIntConfig(CONFIG_MAIL_LEVEL_REQ))
    {
        ChatHandler(this).SendNotification(LANG_MAIL_SENDER_REQ, sWorld->getIntConfig(CONFIG_MAIL_LEVEL_REQ));
        return;
    }

    ObjectGuid receiverGuid;
    if (normalizePlayerName(receiver))
    {
        receiverGuid = sCharacterCache->GetCharacterGuidByName(receiver);
    }

    if (!receiverGuid)
    {
        LOG_DEBUG("network.opcode", "Player {} is sending mail to {} (GUID: not existed!) with subject {} and body {} includes {} items, {} copper and {} COD copper with unk1 = {}, unk2 = {}",
            player->GetGUID().ToString(), receiver, subject, body, items_count, money, COD, unk1, unk2);
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_RECIPIENT_NOT_FOUND);
        return;
    }

    LOG_DEBUG("network.opcode", "Player {} is sending mail to {} ({}) with subject {} and body {} includes {} items, {} copper and {} COD copper with unk1 = {}, unk2 = {}",
        player->GetGUID().ToString(), receiver, receiverGuid.ToString(), subject, body, items_count, money, COD, unk1, unk2);

    if (player->GetGUID() == receiverGuid)
    {
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_CANNOT_SEND_TO_SELF);
        return;
    }

    if (money && COD) // cannot send money in a COD mail
    {
        LOG_ERROR("network.opcode", "{} attempt to dupe money!!!.", receiver);
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_INTERNAL_ERROR);
        return;
    }

    uint32 cost = items_count ? 30 * items_count : 30; // price hardcoded in client

    uint32 reqmoney = cost + money;

    // Check for overflow
    if (reqmoney < money)
    {
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_NOT_ENOUGH_MONEY);
        return;
    }

    if (!player->HasEnoughMoney(reqmoney))
    {
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_NOT_ENOUGH_MONEY);
        return;
    }

    Player* receive = ObjectAccessor::FindConnectedPlayer(receiverGuid);

    uint32 rc_teamId = TEAM_NEUTRAL;
    uint16 mails_count = 0;                                  //do not allow to send to one player more than 100 mails

    if (receive)
    {
        rc_teamId = receive->GetTeamId();
        mails_count = receive->GetMailSize();
    }
    else
    {
        // xinef: get data from global storage
        if (CharacterCacheEntry const* playerData = sCharacterCache->GetCharacterCacheByGuid(receiverGuid))
        {
            rc_teamId = Player::TeamIdForRace(playerData->Race);
            mails_count = playerData->MailCount;
        }
    }
    //do not allow to have more than 100 mails in mailbox.. mails count is in opcode uint8!!! - so max can be 255..
    if (mails_count > 100)
    {
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_RECIPIENT_CAP_REACHED);
        return;
    }
    // test the receiver's Faction... or all items are account bound
    // Xinef: check for boa items, not used currently
    /*bool accountBound = items_count && !money && !COD ? true : false;
    for (uint8 i = 0; i < items_count; ++i)
    {
        Item* item = player->GetItemByGuid(itemGUIDs[i]);
        if (item)
        {
            ItemTemplate const* itemProto = item->GetTemplate();
            if (!itemProto || !itemProto->HasFlag(ITEM_FLAG_IS_BOUND_TO_ACCOUNT))
            {
                accountBound = false;
                break;
            }
        }
    }*/

    uint32 rc_account = receive ? receive->GetSession()->GetAccountId() : sCharacterCache->GetCharacterAccountIdByGuid(receiverGuid);

    if (/*!accountBound*/ GetAccountId() != rc_account && !sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_MAIL) && player->GetTeamId() != rc_teamId && AccountMgr::IsPlayerAccount(GetSecurity()))
    {
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_NOT_YOUR_TEAM);
        return;
    }

    Item* items[MAX_MAIL_ITEMS];

    for (uint8 i = 0; i < items_count; ++i)
    {
        if (!itemGUIDs[i])
        {
            player->SendMailResult(0, MAIL_SEND, MAIL_ERR_MAIL_ATTACHMENT_INVALID);
            return;
        }

        Item* item = player->GetItemByGuid(itemGUIDs[i]);

        // prevent sending bag with items (cheat: can be placed in bag after adding equipped empty bag to mail)
        if (!item)
        {
            player->SendMailResult(0, MAIL_SEND, MAIL_ERR_MAIL_ATTACHMENT_INVALID);
            return;
        }

        // handle empty bag before CanBeTraded, since that func already has that check
        if (item->IsNotEmptyBag())
        {
            player->SendMailResult(0, MAIL_SEND, MAIL_ERR_EQUIP_ERROR, EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS);
            return;
        }

        if (!item->CanBeTraded(true))
        {
            player->SendMailResult(0, MAIL_SEND, MAIL_ERR_EQUIP_ERROR, EQUIP_ERR_MAIL_BOUND_ITEM);
            return;
        }

        if (item->IsBoundAccountWide() && item->IsSoulBound() && GetAccountId() != rc_account)
        {
            player->SendMailResult(0, MAIL_SEND, MAIL_ERR_EQUIP_ERROR, EQUIP_ERR_ARTEFACTS_ONLY_FOR_OWN_CHARACTERS);
            return;
        }

        if (item->GetTemplate()->HasFlag(ITEM_FLAG_CONJURED) || item->GetUInt32Value(ITEM_FIELD_DURATION))
        {
            player->SendMailResult(0, MAIL_SEND, MAIL_ERR_EQUIP_ERROR, EQUIP_ERR_MAIL_BOUND_ITEM);
            return;
        }

        if (COD && item->IsWrapped())
        {
            player->SendMailResult(0, MAIL_SEND, MAIL_ERR_CANT_SEND_WRAPPED_COD);
            return;
        }

        if (!sScriptMgr->OnPlayerCanSendMail(player, receiverGuid, mailbox, subject, body, money, COD, item))
        {
            player->SendMailResult(0, MAIL_SEND, MAIL_ERR_INTERNAL_ERROR);
            return;
        }

        items[i] = item;
    }

    if (!items_count && !sScriptMgr->OnPlayerCanSendMail(player, receiverGuid, mailbox, subject, body, money, COD, nullptr))
    {
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_INTERNAL_ERROR);
        return;
    }

    player->SendMailResult(0, MAIL_SEND, MAIL_OK);

    player->ModifyMoney(-int32(reqmoney));
    player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_MAIL, cost);

    bool needItemDelay = false;

    MailDraft draft(subject, body);

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    if (items_count > 0 || money > 0)
    {
        if (items_count > 0)
        {
            for (uint8 i = 0; i < items_count; ++i)
            {
                Item* item = items[i];

                item->SetNotRefundable(GetPlayer()); // makes the item no longer refundable
                player->MoveItemFromInventory(items[i]->GetBagSlot(), item->GetSlot(), true);

                item->DeleteFromInventoryDB(trans);     // deletes item from character's inventory
                if (item->GetState() == ITEM_UNCHANGED)
                    item->FSetState(ITEM_CHANGED);      // pussywizard: so the item will be saved and owner will be updated in database
                item->SetOwnerGUID(receiverGuid);
                item->SaveToDB(trans);                  // recursive and not have transaction guard into self, item not in inventory and can be save standalone

                draft.AddItem(item);
            }

            // if item send to character at another account, then apply item delivery delay
            needItemDelay = GetAccountId() != rc_account;
        }

        if (money >= 10 * GOLD)
        {
            CleanStringForMysqlQuery(subject);
            CharacterDatabase.Execute("INSERT INTO log_money VALUES({}, {}, \"{}\", \"{}\", {}, \"{}\", {}, \"{}\", NOW(), {})",
                GetAccountId(), player->GetGUID().GetCounter(), player->GetName(), player->GetSession()->GetRemoteAddress(), rc_account, receiver, money, subject, 5);
        }
    }

    // If theres is an item, there is a one hour delivery delay if sent to another account's character.
    uint32 deliver_delay = needItemDelay ? sWorld->getIntConfig(CONFIG_MAIL_DELIVERY_DELAY) : 0;

    // don't ask for COD if there are no items
    if (items_count == 0)
        COD = 0;

    // will delete item or place to receiver mail list
    draft
    .AddMoney(money)
    .AddCOD(COD)
    .SendMailTo(trans, MailReceiver(receive, receiverGuid.GetCounter()), MailSender(player), body.empty() ? MAIL_CHECK_MASK_COPIED : MAIL_CHECK_MASK_HAS_BODY, deliver_delay);

    player->SaveInventoryAndGoldToDB(trans);
    CharacterDatabase.CommitTransaction(trans);
}

//called when mail is read
void WorldSession::HandleMailMarkAsRead(WorldPacket& recvData)
{
    ObjectGuid mailbox;
    uint32 mailId;
    recvData >> mailbox;
    recvData >> mailId;

    if (!CanOpenMailBox(mailbox))
        return;

    Player* player = _player;
    Mail* m = player->GetMail(mailId);
    if (m && m->state != MAIL_STATE_DELETED)
    {
        if (player->unReadMails)
            --player->unReadMails;
        m->checked = m->checked | MAIL_CHECK_MASK_READ;
        player->m_mailsUpdated = true;
        m->state = MAIL_STATE_CHANGED;
    }
}

//called when client deletes mail
void WorldSession::HandleMailDelete(WorldPacket& recvData)
{
    ObjectGuid mailbox;
    uint32 mailId;
    recvData >> mailbox;
    recvData >> mailId;
    recvData.read_skip<uint32>();                          // mailTemplateId

    if (!CanOpenMailBox(mailbox))
        return;

    Mail* m = _player->GetMail(mailId);
    Player* player = _player;
    player->m_mailsUpdated = true;
    if (m)
    {
        // delete shouldn't show up for COD mails
        if (m->COD)
        {
            player->SendMailResult(mailId, MAIL_DELETED, MAIL_ERR_INTERNAL_ERROR);
            return;
        }

        m->state = MAIL_STATE_DELETED;

        sCharacterCache->DecreaseCharacterMailCount(player->GetGUID());
    }
    player->SendMailResult(mailId, MAIL_DELETED, MAIL_OK);
}

void WorldSession::HandleMailReturnToSender(WorldPacket& recvData)
{
    ObjectGuid mailbox;
    uint32 mailId;
    recvData >> mailbox;
    recvData >> mailId;
    recvData.read_skip<uint64>();                          // original sender GUID for return to, not used

    if (!CanOpenMailBox(mailbox))
        return;

    Player* player = _player;
    Mail* m = player->GetMail(mailId);
    if (!m || m->state == MAIL_STATE_DELETED || m->deliver_time > GameTime::GetGameTime().count())
    {
        player->SendMailResult(mailId, MAIL_RETURNED_TO_SENDER, MAIL_ERR_INTERNAL_ERROR);
        return;
    }

    if (m->HasItems())
    {
        for (MailItemInfoVec::iterator itr = m->items.begin(); itr != m->items.end(); ++itr)
        {
            Item* item = player->GetMItem(itr->item_guid);
            if (item && !sScriptMgr->OnPlayerCanSendMail(player, ObjectGuid(HighGuid::Player, m->sender), mailbox, m->subject, m->body, m->money, m->COD, item))
            {
                player->SendMailResult(mailId, MAIL_RETURNED_TO_SENDER, MAIL_ERR_INTERNAL_ERROR);
                return;
            }
        }
    }
    else if (!sScriptMgr->OnPlayerCanSendMail(player, ObjectGuid(HighGuid::Player, m->sender), mailbox, m->subject, m->body, m->money, m->COD, nullptr))
    {
        player->SendMailResult(mailId, MAIL_RETURNED_TO_SENDER, MAIL_ERR_INTERNAL_ERROR);
        return;
    }

    //we can return mail now
    //so firstly delete the old one
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_BY_ID);
    stmt->SetData(0, mailId);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM_BY_ID);
    stmt->SetData(0, mailId);
    trans->Append(stmt);

    player->RemoveMail(mailId);

    // only return mail if the player exists (and delete if not existing)
    if (m->messageType == MAIL_NORMAL && m->sender)
    {
        MailDraft draft(m->subject, m->body);
        if (m->mailTemplateId)
            draft = MailDraft(m->mailTemplateId, false);     // items already included

        if (m->HasItems())
        {
            for (MailItemInfoVec::iterator itr2 = m->items.begin(); itr2 != m->items.end(); ++itr2)
            {
                Item* item = player->GetMItem(itr2->item_guid);
                if (item)
                    draft.AddItem(item);

                player->RemoveMItem(itr2->item_guid);
            }
        }
        draft.AddMoney(m->money).SendReturnToSender(GetAccountId(), m->receiver, m->sender, trans);
    }

    CharacterDatabase.CommitTransaction(trans);

    delete m;                                               //we can deallocate old mail
    player->SendMailResult(mailId, MAIL_RETURNED_TO_SENDER, MAIL_OK);

    sCharacterCache->DecreaseCharacterMailCount(player->GetGUID());
}

//called when player takes item attached in mail
void WorldSession::HandleMailTakeItem(WorldPacket& recvData)
{
    ObjectGuid mailbox;
    uint32 mailId;
    uint32 itemLowGuid;
    recvData >> mailbox;
    recvData >> mailId;
    recvData >> itemLowGuid;    // item guid low

    if (!CanOpenMailBox(mailbox))
        return;

    Player* player = _player;

    Mail* m = player->GetMail(mailId);
    if (!m || m->state == MAIL_STATE_DELETED || m->deliver_time > GameTime::GetGameTime().count())
    {
        player->SendMailResult(mailId, MAIL_ITEM_TAKEN, MAIL_ERR_INTERNAL_ERROR);
        return;
    }

    // verify that the mail has the item to avoid cheaters taking COD items without paying
    bool foundItem = false;
    for (std::vector<MailItemInfo>::const_iterator itr = m->items.begin(); itr != m->items.end(); ++itr)
        if (itr->item_guid == itemLowGuid)
        {
            foundItem = true;
            break;
        }
    if (!foundItem)
    {
        player->SendMailResult(mailId, MAIL_ITEM_TAKEN, MAIL_ERR_INTERNAL_ERROR);
        return;
    }

    // prevent cheating with skip client money check
    if (!player->HasEnoughMoney(m->COD))
    {
        player->SendMailResult(mailId, MAIL_ITEM_TAKEN, MAIL_ERR_NOT_ENOUGH_MONEY);
        return;
    }

    Item* it = player->GetMItem(itemLowGuid);

    ItemPosCountVec dest;
    uint8 msg = _player->CanStoreItem(NULL_BAG, NULL_SLOT, dest, it, false);
    if (msg == EQUIP_ERR_OK)
    {
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        m->RemoveItem(itemLowGuid);
        m->removedItems.push_back(itemLowGuid);

        if (m->COD > 0) // if there is COD, take COD money from player and send them to sender by mail
        {
            uint32 sender_accId = 0;
            Player* sender = ObjectAccessor::FindPlayerByLowGUID(m->sender);
            if (sender)
            {
                sender_accId = sender->GetSession()->GetAccountId();
            }
            else
            {
                sender_accId = sCharacterCache->GetCharacterAccountIdByGuid(ObjectGuid(HighGuid::Player, m->sender));
            }

            // check player existence
            if (sender || sender_accId)
            {
                MailDraft(m->subject, "")
                .AddMoney(m->COD)
                .SendMailTo(trans, MailReceiver(sender, m->sender), MailSender(MAIL_NORMAL, m->receiver), MAIL_CHECK_MASK_COD_PAYMENT);

                if (m->COD >= 10 * GOLD)
                {
                    std::string senderName;
                    if (!sCharacterCache->GetCharacterNameByGuid(ObjectGuid(HighGuid::Player, m->sender), senderName))
                    {
                        senderName = sObjectMgr->GetAcoreStringForDBCLocale(LANG_UNKNOWN);
                    }
                    std::string subj = m->subject;
                    CleanStringForMysqlQuery(subj);
                    CharacterDatabase.Execute("INSERT INTO log_money VALUES({}, {}, \"{}\", \"{}\", {}, \"{}\", {}, \"{}\", NOW(), {})",
                        GetAccountId(), player->GetGUID().GetCounter(), player->GetName(), player->GetSession()->GetRemoteAddress(), sender_accId, senderName, m->COD, subj, 1);
                }
            }

            player->ModifyMoney(-int32(m->COD));
        }

        m->COD = 0;
        m->state = MAIL_STATE_CHANGED;
        player->m_mailsUpdated = true;
        player->RemoveMItem(it->GetGUID().GetCounter());

        uint32 count = it->GetCount();                      // save counts before store and possible merge with deleting
        it->SetState(ITEM_UNCHANGED);                       // need to set this state, otherwise item cannot be removed later, if neccessary
        player->MoveItemToInventory(dest, it, true);

        player->SaveInventoryAndGoldToDB(trans);
        player->_SaveMail(trans);
        CharacterDatabase.CommitTransaction(trans);

        player->SendMailResult(mailId, MAIL_ITEM_TAKEN, MAIL_OK, 0, itemLowGuid, count);
    }
    else
        player->SendMailResult(mailId, MAIL_ITEM_TAKEN, MAIL_ERR_EQUIP_ERROR, msg);
}

void WorldSession::HandleMailTakeMoney(WorldPacket& recvData)
{
    ObjectGuid mailbox;
    uint32 mailId;
    recvData >> mailbox;
    recvData >> mailId;

    if (!CanOpenMailBox(mailbox))
        return;

    Player* player = _player;

    Mail* m = player->GetMail(mailId);
    if (!m || m->state == MAIL_STATE_DELETED || m->deliver_time > GameTime::GetGameTime().count())
    {
        player->SendMailResult(mailId, MAIL_MONEY_TAKEN, MAIL_ERR_INTERNAL_ERROR);
        return;
    }

    if (!player->ModifyMoney(m->money, false))
    {
        player->SendMailResult(mailId, MAIL_MONEY_TAKEN, MAIL_ERR_EQUIP_ERROR, EQUIP_ERR_TOO_MUCH_GOLD);
        return;
    }

    m->money = 0;
    m->state = MAIL_STATE_CHANGED;
    player->m_mailsUpdated = true;

    player->SendMailResult(mailId, MAIL_MONEY_TAKEN, MAIL_OK);

    // save money and mail to prevent cheating
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    player->SaveGoldToDB(trans);
    player->_SaveMail(trans);
    CharacterDatabase.CommitTransaction(trans);
}

//called when player lists his received mails
void WorldSession::HandleGetMailList(WorldPacket& recvData)
{
    ObjectGuid mailbox;
    recvData >> mailbox;

    if (!CanOpenMailBox(mailbox))
        return;

    Player* player = _player;

    uint8 mailsCount = 0;
    uint32 realCount = 0;

    WorldPacket data(SMSG_MAIL_LIST_RESULT, (200));         // guess size
    data << uint32(0);                                      // real mail's count
    data << uint8(0);                                       // mail's count
    time_t cur_time = GameTime::GetGameTime().count();

    for (Mail const* mail : player->GetMails())
    {
        // prevent client storage overflow
        if (mailsCount >= MAX_INBOX_CLIENT_CAPACITY)
        {
            ++realCount;
            continue;
        }

        // skip deleted or not delivered (deliver delay not expired) mails
        if (mail->state == MAIL_STATE_DELETED || cur_time < mail->deliver_time || cur_time > mail->expire_time)
        {
            continue;
        }

        uint8 item_count = uint8(mail->items.size());            // max count is MAX_MAIL_ITEMS (12)

        std::size_t next_mail_size = 2 + 4 + 1 + (mail->messageType == MAIL_NORMAL ? 8 : 4) + 4 * 8 + (mail->subject.size() + 1) + (mail->body.size() + 1) + 1 + item_count * (1 + 4 + 4 + MAX_INSPECTED_ENCHANTMENT_SLOT * 3 * 4 + 4 + 4 + 4 + 4 + 4 + 4 + 1);

        if (data.wpos() + next_mail_size > MAX_NETCLIENT_PACKET_SIZE)
        {
            ++realCount;
            continue;
        }

        data << uint16(next_mail_size);                 // Message size
        data << uint32(mail->messageID);                // Message ID
        data << uint8(mail->messageType);               // Message Type

        switch (mail->messageType)
        {
            case MAIL_NORMAL:                               // sender guid
                data << ObjectGuid::Create<HighGuid::Player>(mail->sender);
                break;
            case MAIL_CREATURE:
            case MAIL_GAMEOBJECT:
            case MAIL_AUCTION:
            case MAIL_CALENDAR:
                data << uint32(mail->sender);            // creature/gameobject entry, auction id, calendar event id?
                break;
        }

        // prevent client crash
        std::string subject = mail->subject;
        std::string body = mail->body;

        if (subject.find("| |") != std::string::npos)
        {
            subject = "";
        }
        if (body.find("| |") != std::string::npos)
        {
            body = "";
        }

        data << uint32(mail->COD);                                      // COD
        data << uint32(0);                                              // probably changed in 3.3.3
        data << uint32(mail->stationery);                               // stationery (Stationery.dbc)
        data << uint32(mail->money);                                    // Gold
        data << uint32(mail->checked);                                  // flags
        data << float(float(mail->expire_time - GameTime::GetGameTime().count()) / DAY);  // Time
        data << uint32(mail->mailTemplateId);                           // mail template (MailTemplate.dbc)
        data << subject;                                                // Subject string - once 00, when mail type = 3, max 256
        data << body;                                                   // message? max 8000
        data << uint8(item_count);                                      // client limit is 0x10

        for (uint8 i = 0; i < item_count; ++i)
        {
            Item* item = player->GetMItem(mail->items[i].item_guid);
            // item index (0-6?)
            data << uint8(i);
            // item guid low?
            data << uint32((item ? item->GetGUID().GetCounter() : 0));
            // entry
            data << uint32((item ? item->GetEntry() : 0));
            for (uint8 j = 0; j < MAX_INSPECTED_ENCHANTMENT_SLOT; ++j)
            {
                data << uint32(item ? item->GetEnchantmentId(EnchantmentSlot(j)) : 0);
                data << uint32(item ? item->GetEnchantmentDuration(EnchantmentSlot(j)) : 0);
                data << uint32(item ? item->GetEnchantmentCharges(EnchantmentSlot(j)) : 0);
            }
            // can be negative
            data << int32((item ? item->GetItemRandomPropertyId() : 0));
            // unk
            data << uint32((item ? item->GetItemSuffixFactor() : 0));
            // stack count
            data << uint32((item ? item->GetCount() : 0));
            // charges
            data << uint32((item ? item->GetSpellCharges() : 0));
            // durability
            data << uint32((item ? item->GetUInt32Value(ITEM_FIELD_MAXDURABILITY) : 0));
            // durability
            data << uint32((item ? item->GetUInt32Value(ITEM_FIELD_DURABILITY) : 0));
            // unknown wotlk
            data << uint8(0);
        }

        ++realCount;
        ++mailsCount;
    }

    data.put<uint32>(0, realCount);     //  this will display warning about undelivered mail to player if realCount > mailsCount
    data.put<uint8>(4, mailsCount);     // set real send mails to client
    SendPacket(&data);

    // recalculate m_nextMailDelivereTime and unReadMails
    _player->UpdateNextMailTimeAndUnreads();
}

//used when player copies mail body to his inventory
void WorldSession::HandleMailCreateTextItem(WorldPacket& recvData)
{
    ObjectGuid mailbox;
    uint32 mailId;

    recvData >> mailbox;
    recvData >> mailId;

    if (!CanOpenMailBox(mailbox))
        return;

    Player* player = _player;

    Mail* m = player->GetMail(mailId);
    if (!m || (m->body.empty() && !m->mailTemplateId) || m->state == MAIL_STATE_DELETED || m->deliver_time > GameTime::GetGameTime().count() || (m->checked & MAIL_CHECK_MASK_COPIED))
    {
        player->SendMailResult(mailId, MAIL_MADE_PERMANENT, MAIL_ERR_INTERNAL_ERROR);
        return;
    }

    Item* bodyItem = new Item;                              // This is not bag and then can be used new Item.
    if (!bodyItem->Create(sObjectMgr->GetGenerator<HighGuid::Item>().Generate(), MAIL_BODY_ITEM_TEMPLATE, player))
    {
        delete bodyItem;
        return;
    }

    // in mail template case we need create new item text
    if (m->mailTemplateId)
    {
        MailTemplateEntry const* mailTemplateEntry = sMailTemplateStore.LookupEntry(m->mailTemplateId);
        if (!mailTemplateEntry)
        {
            player->SendMailResult(mailId, MAIL_MADE_PERMANENT, MAIL_ERR_INTERNAL_ERROR);
            delete bodyItem;
            return;
        }

        bodyItem->SetText(mailTemplateEntry->content[GetSessionDbcLocale()]);
    }
    else
        bodyItem->SetText(m->body);

    bodyItem->SetUInt32Value(ITEM_FIELD_CREATOR, m->sender);
    bodyItem->SetFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_MAIL_TEXT_MASK);

    LOG_DEBUG("network.opcode", "HandleMailCreateTextItem mailid={}", mailId);

    ItemPosCountVec dest;
    uint8 msg = _player->CanStoreItem(NULL_BAG, NULL_SLOT, dest, bodyItem, false);
    if (msg == EQUIP_ERR_OK)
    {
        m->checked = m->checked | MAIL_CHECK_MASK_COPIED;
        m->state = MAIL_STATE_CHANGED;
        player->m_mailsUpdated = true;

        player->StoreItem(dest, bodyItem, true);
        player->SendMailResult(mailId, MAIL_MADE_PERMANENT, MAIL_OK);
    }
    else
    {
        player->SendMailResult(mailId, MAIL_MADE_PERMANENT, MAIL_ERR_EQUIP_ERROR, msg);
        delete bodyItem;
    }
}

//TODO Fix me! ... this void has probably bad condition, but good data are sent
void WorldSession::HandleQueryNextMailTime(WorldPacket& /*recvData*/)
{
    WorldPacket data(MSG_QUERY_NEXT_MAIL_TIME, 8);

    if (_player->unReadMails > 0)
    {
        data << float(0);                                  // float
        data << uint32(0);                                 // count

        uint32 count = 0;
        time_t now = GameTime::GetGameTime().count();
        std::set<uint32> sentSenders;
        for (Mail const* mail : _player->GetMails())
        {
            // must be not checked yet
            if (mail->checked & MAIL_CHECK_MASK_READ)
                continue;

            // and already delivered or expired
            if (now < mail->deliver_time || now > mail->expire_time)
                continue;

            // only send each mail sender once
            if (sentSenders.count(mail->sender))
                continue;

            data << (mail->messageType == MAIL_NORMAL ? ObjectGuid::Create<HighGuid::Player>(mail->sender) : ObjectGuid::Empty);  // player guid
            data << uint32(mail->messageType != MAIL_NORMAL ? mail->sender : 0);  // non-player entries
            data << uint32(mail->messageType);
            data << uint32(mail->stationery);
            data << float(mail->deliver_time - now);

            sentSenders.insert(mail->sender);
            ++count;
            if (count == 2)                                  // do not display more than 2 mails
                break;
        }

        data.put<uint32>(4, count);
    }
    else
    {
        data << float(-DAY);
        data << uint32(0);
    }

    SendPacket(&data);
}
