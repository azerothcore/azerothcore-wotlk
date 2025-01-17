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

#include "Mail.h"
#include "AuctionHouseMgr.h"
#include "BattlegroundMgr.h"
#include "CalendarMgr.h"
#include "CharacterCache.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Item.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"

MailSender::MailSender(Object* sender, MailStationery stationery) : m_stationery(stationery)
{
    switch (sender->GetTypeId())
    {
        case TYPEID_UNIT:
            m_messageType = MAIL_CREATURE;
            m_senderId = sender->GetEntry();
            break;
        case TYPEID_GAMEOBJECT:
            m_messageType = MAIL_GAMEOBJECT;
            m_senderId = sender->GetEntry();
            break;
        /*case TYPEID_ITEM:
            m_messageType = MAIL_ITEM;
            m_senderId = sender->GetEntry();
            break;*/
        case TYPEID_PLAYER:
            m_messageType = MAIL_NORMAL;
            m_senderId = sender->GetGUID().GetCounter();
            break;
        default:
            m_messageType = MAIL_NORMAL;
            m_senderId = 0;                                 // will show mail from not existed player
            LOG_ERROR("mail", "MailSender::MailSender - Mail have unexpected sender typeid ({})", sender->GetTypeId());
            break;
    }
}

MailSender::MailSender(CalendarEvent* sender)
    : m_messageType(MAIL_CALENDAR), m_senderId(sender->GetEventId()), m_stationery(MAIL_STATIONERY_DEFAULT) // what stationery we should use here?
{
}

MailSender::MailSender(AuctionEntry* sender)
    : m_messageType(MAIL_AUCTION), m_senderId(uint32(sender->GetHouseId())), m_stationery(MAIL_STATIONERY_AUCTION)
{
}

MailSender::MailSender(Player* sender)
{
    m_messageType = MAIL_NORMAL;
    m_stationery = sender->IsGameMaster() ? MAIL_STATIONERY_GM : MAIL_STATIONERY_DEFAULT;
    m_senderId = sender->GetGUID().GetCounter();
}

MailSender::MailSender(uint32 senderEntry)
{
    m_messageType = MAIL_CREATURE;
    m_senderId = senderEntry;
    m_stationery = MAIL_STATIONERY_DEFAULT;
}

MailReceiver::MailReceiver(Player* receiver) : m_receiver(receiver), m_receiver_lowguid(receiver->GetGUID().GetCounter())
{
}

MailReceiver::MailReceiver(Player* receiver, ObjectGuid::LowType receiver_lowguid) : m_receiver(receiver), m_receiver_lowguid(receiver_lowguid)
{
    ASSERT(!receiver || receiver->GetGUID().GetCounter() == receiver_lowguid);
}

MailDraft& MailDraft::AddItem(Item* item)
{
    m_items[item->GetGUID()] = item;
    return *this;
}

void MailDraft::prepareItems(Player* receiver, CharacterDatabaseTransaction trans)
{
    if (!m_mailTemplateId || !m_mailTemplateItemsNeed)
        return;

    m_mailTemplateItemsNeed = false;

    // The mail sent after turning in the quest The Wrath of Neptulon contains 100g
    // Only quest in the game up to BFA which sends raw gold through mail. So would just be overkill to introduce a new column in the database.
    if (m_mailTemplateId == 123)
    {
        m_money = 1000000;
    }

    Loot mailLoot;

    // can be empty
    mailLoot.FillLoot(m_mailTemplateId, LootTemplates_Mail, receiver, true, true);

    uint32 max_slot = mailLoot.GetMaxSlotInLootFor(receiver);
    for (uint32 i = 0; m_items.size() < MAX_MAIL_ITEMS && i < max_slot; ++i)
    {
        if (LootItem* lootitem = mailLoot.LootItemInSlot(i, receiver))
        {
            if (Item* item = Item::CreateItem(lootitem->itemid, lootitem->count, receiver))
            {
                item->SaveToDB(trans);                           // save for prevent lost at next mail load, if send fail then item will deleted
                AddItem(item);
            }
        }
    }
}

void MailDraft::deleteIncludedItems(CharacterDatabaseTransaction trans, bool inDB /*= false*/ )
{
    for (MailItemMap::iterator mailItemIter = m_items.begin(); mailItemIter != m_items.end(); ++mailItemIter)
    {
        Item* item = mailItemIter->second;

        if (inDB)
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
            stmt->SetData(0, item->GetGUID().GetCounter());
            trans->Append(stmt);
        }

        delete item;
    }

    m_items.clear();
}

void MailDraft::SendReturnToSender(uint32 /*sender_acc*/, ObjectGuid::LowType sender_guid, ObjectGuid::LowType receiver_guid, CharacterDatabaseTransaction trans)
{
    Player* receiver = ObjectAccessor::FindPlayerByLowGUID(receiver_guid);

    if (!receiver && !sCharacterCache->GetCharacterAccountIdByGuid(ObjectGuid(HighGuid::Player, receiver_guid)))
    {
        deleteIncludedItems(trans, true);
        return;
    }

    if (!m_items.empty())
    {
        // if item send to character at another account, then apply item delivery delay
        //needItemDelay = sender_acc != rc_account;

        // set owner to new receiver (to prevent delete item with sender char deleting)
        for (MailItemMap::iterator mailItemIter = m_items.begin(); mailItemIter != m_items.end(); ++mailItemIter)
        {
            Item* item = mailItemIter->second;
            item->SaveToDB(trans);                      // item not in inventory and can be save standalone
            // owner in data will set at mail receive and item extracting
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ITEM_OWNER);
            stmt->SetData(0, receiver_guid);
            stmt->SetData(1, item->GetGUID().GetCounter());
            trans->Append(stmt);
        }
    }

    // xinef: WowWiki: "Return mail arrives immediately."

    // will delete item or place to receiver mail list
    SendMailTo(trans, MailReceiver(receiver, receiver_guid), MailSender(MAIL_NORMAL, sender_guid), MAIL_CHECK_MASK_RETURNED, 0);
}

void MailDraft::SendMailTo(CharacterDatabaseTransaction trans, MailReceiver const& receiver, MailSender const& sender, MailCheckMask checked, uint32 deliver_delay, uint32 custom_expiration, bool deleteMailItemsFromDB, bool sendMail)
{
    sScriptMgr->OnBeforeMailDraftSendMailTo(this, receiver, sender, checked, deliver_delay, custom_expiration, deleteMailItemsFromDB, sendMail);

    if (deleteMailItemsFromDB) // can be changed in the hook
        deleteIncludedItems(trans, true);

    if (!sendMail) // can be changed in the hook
        return;

    Player* pReceiver = receiver.GetPlayer();               // can be nullptr

    if (pReceiver)
        prepareItems(pReceiver, trans);                            // generate mail template items

    uint32 mailId = sObjectMgr->GenerateMailID();

    time_t deliver_time = GameTime::GetGameTime().count() + deliver_delay;

    //expire time if COD 3 days, if no COD 30 days, if auction sale pending 1 hour
    uint32 expire_delay;

    // auction mail without any items and money
    if (sender.GetMailMessageType() == MAIL_AUCTION && m_items.empty() && !m_money)
        expire_delay = sWorld->getIntConfig(CONFIG_MAIL_DELIVERY_DELAY);
    // mail from battlemaster (rewardmarks) should last only one day
    else if (sender.GetMailMessageType() == MAIL_CREATURE && sBattlegroundMgr->GetBattleMasterBG(sender.GetSenderId()) != BATTLEGROUND_TYPE_NONE)
        expire_delay = DAY;
    // default case: expire time if COD 3 days, if no COD 30 days (or 90 days if sender is a game master)
    else if (m_COD)
        expire_delay = 3 * DAY;
    else if (custom_expiration > 0)
        expire_delay = custom_expiration * DAY;
    else
    {
        Player* pSender = ObjectAccessor::FindPlayerByLowGUID(sender.GetSenderId());
        expire_delay = pSender && pSender->GetSession()->GetSecurity() ? 90 * DAY : 30 * DAY;
    }

    time_t expire_time = deliver_time + expire_delay;

    // Add to DB
    uint8 index = 0;
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_MAIL);
    stmt->SetData(  index, mailId);
    stmt->SetData(++index, uint8(sender.GetMailMessageType()));
    stmt->SetData(++index, int8(sender.GetStationery()));
    stmt->SetData(++index, GetMailTemplateId());
    stmt->SetData(++index, sender.GetSenderId());
    stmt->SetData(++index, receiver.GetPlayerGUIDLow());
    stmt->SetData(++index, GetSubject());
    stmt->SetData(++index, GetBody());
    stmt->SetData(++index, !m_items.empty());
    stmt->SetData(++index, uint32(expire_time));
    stmt->SetData(++index, uint32(deliver_time));
    stmt->SetData(++index, m_money);
    stmt->SetData(++index, m_COD);
    stmt->SetData(++index, uint8(checked));
    trans->Append(stmt);

    for (MailItemMap::const_iterator mailItemIter = m_items.begin(); mailItemIter != m_items.end(); ++mailItemIter)
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_MAIL_ITEM);
        stmt->SetData(0, mailId);
        stmt->SetData(1, mailItemIter->second->GetGUID().GetCounter());
        stmt->SetData(2, receiver.GetPlayerGUIDLow());
        trans->Append(stmt);
    }

    sCharacterCache->IncreaseCharacterMailCount(ObjectGuid(HighGuid::Player, receiver.GetPlayerGUIDLow()));

    // For online receiver update in game mail status and data
    if (pReceiver)
    {
        pReceiver->AddNewMailDeliverTime(deliver_time);

        Mail* m = new Mail;
        m->messageID = mailId;
        m->mailTemplateId = GetMailTemplateId();
        m->subject = GetSubject();
        m->body = GetBody();
        m->money = GetMoney();
        m->COD = GetCOD();

        for (MailItemMap::const_iterator mailItemIter = m_items.begin(); mailItemIter != m_items.end(); ++mailItemIter)
        {
            Item* item = mailItemIter->second;
            m->AddItem(item->GetGUID().GetCounter(), item->GetEntry());
        }

        m->messageType = sender.GetMailMessageType();
        m->stationery = sender.GetStationery();
        m->sender = sender.GetSenderId();
        m->receiver = receiver.GetPlayerGUIDLow();
        m->expire_time = expire_time;
        m->deliver_time = deliver_time;
        m->checked = checked;
        m->state = MAIL_STATE_UNCHANGED;

        pReceiver->AddMail(m);                           // to insert new mail to beginning of maillist

        if (!m_items.empty())
        {
            for (MailItemMap::iterator mailItemIter = m_items.begin(); mailItemIter != m_items.end(); ++mailItemIter)
            {
                pReceiver->AddMItem(mailItemIter->second);
            }
        }
    }
    else if (!m_items.empty())
    {
        deleteIncludedItems(CharacterDatabaseTransaction(nullptr));
    }
}
