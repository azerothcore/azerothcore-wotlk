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

#include "ServerMailMgr.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "Log.h"
#include "Player.h"
#include "Timer.h"

ServerMailMgr::ServerMailMgr() {}
ServerMailMgr::~ServerMailMgr() {}

ServerMailMgr* ServerMailMgr::instance()
{
    static ServerMailMgr instance;
    return &instance;
}

void ServerMailMgr::LoadMailServerTemplates()
{
    uint32 oldMSTime = getMSTime();

    _serverMailStore.clear(); // for reload case

    //                                                    0     1           2              3         4         5          6       7
    QueryResult result = CharacterDatabase.Query("SELECT `id`, `reqLevel`, `reqPlayTime`, `moneyA`, `moneyH`, `subject`, `body`, `active` FROM `mail_server_template`");
    if (!result)
    {
        LOG_INFO("sql.sql", ">> Loaded 0 server mail rewards. DB table `mail_server_template` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    _serverMailStore.rehash(result->GetRowCount());

    do
    {
        Field* fields = result->Fetch();

        uint32 id = fields[0].Get<uint32>();

        ServerMail& servMail = _serverMailStore[id];

        servMail.id          = id;
        servMail.reqLevel    = fields[1].Get<uint8>();
        servMail.reqPlayTime = fields[2].Get<uint32>();
        servMail.moneyA      = fields[3].Get<uint32>();
        servMail.moneyH      = fields[4].Get<uint32>();
        servMail.subject     = fields[5].Get<std::string>();
        servMail.body        = fields[6].Get<std::string>();
        servMail.active      = fields[7].Get<uint8>();

        if (servMail.reqLevel > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template` has reqLevel {} but max level is {} for id {}, skipped.", servMail.reqLevel, sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL), servMail.id);
            return;
        }

        if (servMail.moneyA > MAX_MONEY_AMOUNT || servMail.moneyH > MAX_MONEY_AMOUNT)
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template` has moneyA {} or moneyH {} larger than MAX_MONEY_AMOUNT {} for id {}, skipped.", servMail.moneyA, servMail.moneyH, MAX_MONEY_AMOUNT, servMail.id);
            return;
        }
    } while (result->NextRow());

    LoadMailServerTemplatesItems();

    LOG_INFO("server.loading", ">> Loaded {} Mail Server Template in {} ms", _serverMailStore.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ServerMailMgr::LoadMailServerTemplatesItems()
{
    QueryResult result = CharacterDatabase.Query("SELECT `templateID`, `faction`, `item`, `itemCount` FROM `mail_server_template_items`");
    if (!result)
    {
        LOG_INFO("sql.sql", ">> Loaded 0 server mail items. DB table `mail_server_template_items` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 templateID = fields[0].Get<uint32>();
        std::string faction = fields[1].Get<std::string>();
        uint32 item = fields[2].Get<uint32>();
        uint32 itemCount = fields[3].Get<uint32>();

        if (_serverMailStore.find(templateID) == _serverMailStore.end())
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template_items` has an invalid templateID {}, skipped.", templateID);
            continue;
        }

        ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(item);
        if (!itemTemplate)
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template_items` has an invalid item {} for templateID {}, skipped.", item, templateID);
            continue;
        }

        if (!itemCount)
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template_items` has itemCount 0 for item {}, skipped.", item);
            continue;
        }

        uint32 stackable = itemTemplate->Stackable;
        if (itemCount > stackable)
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template_items` has itemCount {} exceeding item_template.Stackable {} for item {}, skipped.", itemCount, stackable, item);
            continue;
        }

        uint32 maxCount = itemTemplate->MaxCount;
        if (maxCount && itemCount > maxCount)
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template_items` has itemCount {} exceeding item_template.MaxCount {} for item {}, skipped", itemCount, maxCount, item);
            continue;
        }

        ServerMailItems mailItem;
        mailItem.item = item;
        mailItem.itemCount = itemCount;

        if (faction == "Alliance")
            _serverMailStore[templateID].itemsA.push_back(mailItem);
        else if (faction == "Horde")
            _serverMailStore[templateID].itemsH.push_back(mailItem);
        else
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template_items` has invalid faction value '{}' for id {}, skipped.", faction, templateID);
            continue;
        }

    } while (result->NextRow());
}

void ServerMailMgr::SendServerMail(Player* player, uint32 id, uint32 reqLevel, uint32 reqPlayTime, uint32 rewardMoneyA, uint32 rewardMoneyH, std::vector<ServerMailItems> const& items, std::string subject, std::string body, uint8 active) const
{
    if (!active)
        return;

    if (player->GetLevel() < reqLevel)
        return;

    if (player->GetTotalPlayedTime() < reqPlayTime)
        return;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    MailSender sender(MAIL_NORMAL, player->GetGUID().GetCounter(), MAIL_STATIONERY_GM);
    MailDraft draft(subject, body);

    draft.AddMoney(player->GetTeamId() == TEAM_ALLIANCE ? rewardMoneyA : rewardMoneyH);
    // Loop through all items and attach them to the mail
    for (auto const& mailItem : items)
    {
        if (!mailItem.item || !mailItem.itemCount)
            continue;

        if (Item* newItem = Item::CreateItem(mailItem.item, mailItem.itemCount))
        {
            newItem->SaveToDB(trans);
            draft.AddItem(newItem);
        }
    }

    draft.SendMailTo(trans, MailReceiver(player), sender);
    CharacterDatabase.CommitTransaction(trans);

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_MAIL_SERVER_CHARACTER);
    stmt->SetData(0, player->GetGUID().GetCounter());
    stmt->SetData(1, id);
    CharacterDatabase.Execute(stmt);

    LOG_DEBUG("entities.player", "ObjectMgr::SendServerMail() Sent mail id {} to {}", id, player->GetGUID().ToString());
}
