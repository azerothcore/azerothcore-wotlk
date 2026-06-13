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

#include "ServerMailMgr.h"
#include "AccountMgr.h"
#include "AchievementMgr.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QuestDef.h"
#include "RaceMgr.h"
#include "SharedDefines.h"
#include "Timer.h"

ServerMailMgr* ServerMailMgr::instance()
{
    static ServerMailMgr instance;
    return &instance;
}

void ServerMailMgr::LoadMailServerTemplates()
{
    uint32 oldMSTime = getMSTime();

    _serverMailStore.clear(); // for reload case

    //                                                    0     1         2         3          4       5
    QueryResult result = CharacterDatabase.Query("SELECT `id`, `moneyA`, `moneyH`, `subject`, `body`, `active` FROM `mail_server_template`");
    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 server mail rewards. DB table `mail_server_template` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    _serverMailStore.reserve(result->GetRowCount());

    do
    {
        Field* fields = result->Fetch();

        uint32 id = fields[0].Get<uint32>();

        ServerMail& servMail = _serverMailStore[id];
        servMail.id          = id;
        servMail.moneyA      = fields[1].Get<uint32>();
        servMail.moneyH      = fields[2].Get<uint32>();
        servMail.subject     = fields[3].Get<std::string>();
        servMail.body        = fields[4].Get<std::string>();
        servMail.active      = fields[5].Get<uint8>();

        // Skip non-activated entries
        if (!servMail.active)
            continue;

        if (servMail.moneyA > MAX_MONEY_AMOUNT || servMail.moneyH > MAX_MONEY_AMOUNT)
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template` has moneyA {} or moneyH {} larger than MAX_MONEY_AMOUNT {} for id {}, skipped.", servMail.moneyA, servMail.moneyH, MAX_MONEY_AMOUNT, servMail.id);
            continue;
        }
    } while (result->NextRow());

    LoadMailServerTemplatesItems();
    LoadMailServerTemplatesConditions();

    LOG_INFO("server.loading", ">> Loaded {} Mail Server definitions in {} ms", _serverMailStore.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ServerMailMgr::LoadMailServerTemplatesItems()
{
    //                                                    0             1          2       3
    QueryResult result = CharacterDatabase.Query("SELECT `templateID`, `faction`, `item`, `itemCount` FROM `mail_server_template_items`");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 server mail items. DB table `mail_server_template_items` is empty.");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 templateID        = fields[0].Get<uint32>();
        std::string_view faction = fields[1].Get<std::string_view>();
        uint32 item              = fields[2].Get<uint32>();
        uint32 itemCount         = fields[3].Get<uint32>();

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
        mailItem.item      = item;
        mailItem.itemCount = itemCount;

        if (faction == "Alliance")
            _serverMailStore[templateID].itemsA.push_back(mailItem);
        else if (faction == "Horde")
            _serverMailStore[templateID].itemsH.push_back(mailItem);
        else [[unlikely]]
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template_items` has invalid faction value '{}' for templateID {}, skipped.", faction, templateID);
            continue;
        }

    } while (result->NextRow());
}

void ServerMailMgr::LoadMailServerTemplatesConditions()
{
    //                                                    0             1                2                 3
    QueryResult result = CharacterDatabase.Query("SELECT `templateID`, `conditionType`, `conditionValue`, `conditionState` FROM `mail_server_template_conditions`");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 server mail conditions. DB table `mail_server_template_conditions` is empty.");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 templateID                 = fields[0].Get<uint32>();
        std::string_view conditionTypeStr = fields[1].Get<std::string_view>();
        uint32 conditionValue             = fields[2].Get<uint32>();
        uint32 conditionState             = fields[3].Get<uint32>();

        if (_serverMailStore.find(templateID) == _serverMailStore.end())
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has an invalid templateID {}, skipped.", templateID);
            continue;
        }

        // Get conditiontype from ServerMailConditionTypePairs
        ServerMailConditionType conditionType;
        conditionType = GetServerMailConditionType(conditionTypeStr);
        if (conditionType == ServerMailConditionType::Invalid) [[unlikely]]
        {
            LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has unknown conditionType '{}', skipped.", conditionTypeStr);
            continue;
        }

        if (conditionState && !ConditionTypeUsesConditionState(conditionType))
            LOG_WARN("sql.sql", "Table `mail_server_template_conditions` has conditionState value ({}) for conditionType ({}) which does not use conditionState.", conditionState, conditionTypeStr);

        switch (conditionType)
        {
        case ServerMailConditionType::Level:
            if (conditionValue > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            {
                LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has conditionType 'Level' with invalid conditionValue ({}), max level is ({}) for templateID {}, skipped.", conditionValue, sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL), templateID);
                continue;
            }
            break;
        case ServerMailConditionType::Quest:
        {
            Quest const* qInfo = sObjectMgr->GetQuestTemplate(conditionValue);
            if (!qInfo)
            {
                LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has conditionType 'Quest' with invalid quest in conditionValue ({}) for templateID {}, skipped.", conditionValue, templateID);
                continue;
            }
            if (conditionState < QUEST_STATUS_NONE || conditionState >= MAX_QUEST_STATUS ||
                /*2 and 4 not defined and should not be used*/ conditionState == 2 || conditionState == 4)
            {
                LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has conditionType 'Quest' with invalid conditionState ({}) for templateID {}, skipped.", conditionState, templateID);
                continue;
            }
            break;
        }
        case ServerMailConditionType::Achievement:
        {
            AchievementEntry const* achievement = sAchievementStore.LookupEntry(conditionValue);
            if (!achievement)
            {
                LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has conditionType 'Achievement' with invalid achievement in conditionValue ({}) for templateID {}, skipped.", conditionValue, templateID);
                continue;
            }
            break;
        }
        case ServerMailConditionType::Reputation:
        {
            FactionEntry const* faction = sFactionStore.LookupEntry(conditionValue);
            if (!faction)
            {
                LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has conditionType 'Reputation' with invalid faction in conditionValue ({}) for templateID {}, skipped.", conditionValue, templateID);
                continue;
            }
            if (conditionState < REP_HATED || conditionState > REP_EXALTED)
            {
                LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has conditionType 'Reputation' with invalid conditionState ({}) for templateID {}, skipped.", conditionState, templateID);
                continue;
            }
            break;
        }
        case ServerMailConditionType::Faction:
            if (conditionValue < TEAM_ALLIANCE || conditionValue > TEAM_HORDE)
            {
                LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has conditionType 'Faction' with invalid conditionValue ({}) for templateID {}, skipped.", conditionValue, templateID);
                continue;
            }
            break;
        case ServerMailConditionType::Race:
            if (conditionValue & ~sRaceMgr->GetPlayableRaceMask())
            {
                LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has conditionType 'Race' with invalid conditionValue ({}) for templateID {}, skipped.", conditionValue, templateID);
                continue;
            }
            break;
        case ServerMailConditionType::Class:
            if (conditionValue & ~CLASSMASK_ALL_PLAYABLE)
            {
                LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has conditionType 'Class' with invalid conditionValue ({}) for templateID {}, skipped.", conditionValue, templateID);
                continue;
            }
            break;
        case ServerMailConditionType::AccountFlags:
            if ((conditionValue & ~ACCOUNT_FLAGS_ALL) != 0)
            {
                LOG_ERROR("sql.sql", "Table `mail_server_template_conditions` has conditionType 'AccountFlags' with invalid conditionValue ({}) for templateID {}, skipped.", conditionValue, templateID);
                continue;
            }
            break;
        default:
            break;
        }

        ServerMailCondition condition;
        condition.type = conditionType;
        condition.value = conditionValue;
        condition.state = conditionState;
        _serverMailStore[templateID].conditions.push_back(condition);

    } while (result->NextRow());
}

void ServerMailMgr::SendServerMail(Player* player, uint32 id, uint32 money,
    std::vector<ServerMailItems> const& items,
    std::vector<ServerMailCondition> const& conditions,
    std::string const& subject, std::string const& body) const
{
    for (ServerMailCondition const& condition : conditions)
        if (!condition.CheckCondition(player))
            return;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    MailSender sender(MAIL_NORMAL, player->GetGUID().GetCounter(), MAIL_STATIONERY_GM);
    MailDraft draft(subject, body);

    draft.AddMoney(money);
    // Loop through all items and attach them to the mail
    for (auto const& mailItem : items)
        if (Item* newItem = Item::CreateItem(mailItem.item, mailItem.itemCount))
        {
            newItem->SaveToDB(trans);
            draft.AddItem(newItem);
        }

    draft.SendMailTo(trans, MailReceiver(player), sender);
    CharacterDatabase.CommitTransaction(trans);

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_MAIL_SERVER_CHARACTER);
    stmt->SetData(0, player->GetGUID().GetCounter());
    stmt->SetData(1, id);
    CharacterDatabase.Execute(stmt);
}

ServerMailConditionType ServerMailMgr::GetServerMailConditionType(std::string_view conditionTypeStr) const
{
    for (auto const& pair : ServerMailConditionTypePairs)
        if (pair.first == conditionTypeStr)
            return pair.second;

    return ServerMailConditionType::Invalid;
}

bool ServerMailMgr::ConditionTypeUsesConditionState(ServerMailConditionType type) const
{
    switch (type)
    {
    case ServerMailConditionType::Quest:
    case ServerMailConditionType::Reputation:
        return true;
    default:
        return false;
    }
}

bool ServerMailCondition::CheckCondition(Player* player) const
{
    switch (type)
    {
    case ServerMailConditionType::Level:
        return player->GetLevel() >= value;
    case ServerMailConditionType::PlayTime:
        return player->GetTotalPlayedTime() >= value;
    case ServerMailConditionType::Quest:
        return player->GetQuestStatus(value) == state;
    case ServerMailConditionType::Achievement:
        return player->HasAchieved(value);
    case ServerMailConditionType::Reputation:
        return player->GetReputationRank(value) >= state;
    case ServerMailConditionType::Faction:
        return player->GetTeamId() == value;
    case ServerMailConditionType::Race:
        return (player->getRaceMask() & value) != 0;
    case ServerMailConditionType::Class:
        return (player->getClassMask() & value) != 0;
    case ServerMailConditionType::AccountFlags:
        return player->GetSession()->HasAccountFlag(value);
    default:
        [[unlikely]] LOG_ERROR("server.mail", "Unknown server mail condition type '{}'", static_cast<uint32>(type));
        return false;
    }
}
