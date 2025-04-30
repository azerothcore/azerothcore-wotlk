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

#include "AutobroadcastMgr.h"
#include "Chat.h"
#include "Config.h"
#include "GridNotifiers.h"
#include "Player.h"

AutobroadcastMgr* AutobroadcastMgr::instance()
{
    static AutobroadcastMgr instance;
    return &instance;
}

void AutobroadcastMgr::LoadAutobroadcasts()
{
    uint32 oldMSTime = getMSTime();

    _autobroadcasts.clear();
    _autobroadcastsWeights.clear();

    uint32 realmId = sConfigMgr->GetOption<int32>("RealmID", 0);
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_AUTOBROADCAST);
    stmt->SetData(0, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("autobroadcast", ">> Loaded 0 autobroadcasts definitions. DB table `autobroadcast` is empty for this realm!");
        return;
    }

    _announceType = static_cast<AnnounceType>(sWorld->getIntConfig(CONFIG_AUTOBROADCAST_CENTER));

    if (_announceType < AnnounceType::World || _announceType > AnnounceType::Both)
    {
        LOG_ERROR("autobroadcast", "AutobroadcastMgr::LoadAutobroadcasts: Config option AutoBroadcast.Center set to not allowed value {}. Set to default value 0", (int8)_announceType);
        _announceType = AnnounceType::World;
    }

    do
    {
        Field* fields = result->Fetch();
        uint8 textId = fields[0].Get<uint8>();

        ObjectMgr::AddLocaleString(fields[2].Get<std::string>(), DEFAULT_LOCALE, _autobroadcasts[textId]);
        _autobroadcastsWeights[textId] = fields[1].Get<uint8>();

    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Autobroadcast Definitions in {} ms", _autobroadcasts.size(), GetMSTimeDiffToNow(oldMSTime));
}

void AutobroadcastMgr::LoadAutobroadcastsLocalized()
{
    uint32 oldMSTime = getMSTime();
    uint32 realmId = sConfigMgr->GetOption<int32>("RealmID", 0);

    if (_autobroadcasts.empty())
        return;

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_AUTOBROADCAST_LOCALIZED);
    stmt->SetData(0, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 localized autobroadcasts definitions. DB table `autobroadcast_localized` is empty for this realm!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint8 count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint8 textId = fields[0].Get<uint8>();
        LocaleConstant locale = GetLocaleByName(fields[1].Get<std::string>());

        if (locale == DEFAULT_LOCALE || ObjectMgr::GetLocaleString(_autobroadcasts[textId], DEFAULT_LOCALE).empty())
            continue;

        ObjectMgr::AddLocaleString(fields[2].Get<std::string>(), locale, _autobroadcasts[textId]);
        count++;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Localized Autobroadcast Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AutobroadcastMgr::SendAutobroadcasts()
{
    if (_autobroadcasts.empty())
        return;

    uint32 weight = 0;
    uint8 textId = 0;
    AutobroadcastsWeightMap selectionWeights;

    for (AutobroadcastsWeightMap::const_iterator it = _autobroadcastsWeights.begin(); it != _autobroadcastsWeights.end(); ++it)
    {
        if (it->second)
        {
            weight += it->second;
            selectionWeights[it->first] = it->second;
        }
    }

    if (weight)
    {
        uint32 selectedWeight = urand(0, weight - 1);
        weight = 0;
        for (AutobroadcastsWeightMap::const_iterator it = selectionWeights.begin(); it != selectionWeights.end(); ++it)
        {
            weight += it->second;
            if (selectedWeight < weight)
            {
                textId = it->first;
                break;
            }
        }
    }
    else
    {
        textId = urand(0, _autobroadcasts.size());
    }

    switch (_announceType)
    {
    case AnnounceType::World:
        SendWorldAnnouncement(textId);
        break;
    case AnnounceType::Notification:
        SendNotificationAnnouncement(textId);
        break;
    case AnnounceType::Both:
        SendWorldAnnouncement(textId);
        SendNotificationAnnouncement(textId);
    default:
        break;
    }

    LOG_DEBUG("autobroadcast", "AutobroadcastMgr::SendAutobroadcasts: '{}'", textId);
}

void AutobroadcastMgr::SendWorldAnnouncement(uint8 textId)
{
    // Send localized messages to all sessions
    ChatHandler(nullptr).DoForAllValidSessions([&](Player* player)
    {
        // Get player's locale
        LocaleConstant locale = player->GetSession()->GetSessionDbLocaleIndex();

        if (!_autobroadcasts.empty())
            return;

        std::string_view localizedMessage = ObjectMgr::GetLocaleString(_autobroadcasts[textId], locale);

        // Check if there is a localized message if not use default one.
        if (localizedMessage.empty())
            localizedMessage = ObjectMgr::GetLocaleString(_autobroadcasts[textId], DEFAULT_LOCALE);

        // Send the localized or fallback message
        ChatHandler(player->GetSession()).SendWorldTextOptional(localizedMessage, ANNOUNCER_FLAG_DISABLE_AUTOBROADCAST);
    });
}

void AutobroadcastMgr::SendNotificationAnnouncement(uint8 textId)
{
    ChatHandler(nullptr).DoForAllValidSessions([&](Player* player)
    {
        // Retrieve player's locale
        LocaleConstant locale = player->GetSession()->GetSessionDbLocaleIndex();

        if (!_autobroadcasts.count(textId))
            return;

        // Get localized message
        std::string_view localizedMessage = ObjectMgr::GetLocaleString(_autobroadcasts[textId], locale);

        // Check if there is a localized message if not use default one.
        if (localizedMessage.empty())
            localizedMessage = ObjectMgr::GetLocaleString(_autobroadcasts[textId], DEFAULT_LOCALE);

        // Prepare the WorldPacket
        WorldPacket data(SMSG_NOTIFICATION, (localizedMessage.size() + 1));
        data << localizedMessage;

        // Send packet to the player
        player->GetSession()->SendPacket(&data);
    });
}
