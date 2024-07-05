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
        LOG_INFO("autobroadcast", " ");
        return;
    }

    _announceType = static_cast<AnnounceType>(sWorld->getIntConfig(CONFIG_AUTOBROADCAST_CENTER));

    if (_announceType < AnnounceType::World || _announceType > AnnounceType::Both)
    {
        LOG_ERROR("autobroadcast", "AutobroadcastMgr::LoadAutobroadcasts: Config option AutoBroadcast.Center set to not allowed value {}. Set to default value 0", (int8)_announceType);
        _announceType = AnnounceType::World;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint8 id = fields[0].Get<uint8>();

        _autobroadcasts[id] = fields[2].Get<std::string>();
        _autobroadcastsWeights[id] = fields[1].Get<uint8>();

        ++count;
    } while (result->NextRow());

    LOG_INFO("autobroadcast", ">> Loaded {} Autobroadcast Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("autobroadcast", " ");
}

void AutobroadcastMgr::SendAutobroadcasts()
{
    if (_autobroadcasts.empty())
    {
        return;
    }

    uint32 weight = 0;
    AutobroadcastsWeightMap selectionWeights;

    std::string msg;

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
                msg = _autobroadcasts[it->first];
                break;
            }
        }
    }
    else
    {
        msg = _autobroadcasts[urand(0, _autobroadcasts.size())];
    }

    switch (_announceType)
    {
    case AnnounceType::World:
        SendWorldAnnouncement(msg);
        break;
    case AnnounceType::Notification:
        SendNotificationAnnouncement(msg);
        break;
    case AnnounceType::Both:
        SendWorldAnnouncement(msg);
        SendNotificationAnnouncement(msg);
    default:
        break;
    }

    LOG_DEBUG("autobroadcast", "AutobroadcastMgr::SendAutobroadcasts: '{}'", msg);
}

void AutobroadcastMgr::SendWorldAnnouncement(std::string msg)
{
    sWorld->SendWorldTextOptional(LANG_AUTO_BROADCAST, ANNOUNCER_FLAG_DISABLE_AUTOBROADCAST, msg.data());
}

void AutobroadcastMgr::SendNotificationAnnouncement(std::string msg)
{
    WorldPacket data(SMSG_NOTIFICATION, (msg.size() + 1));
    data << msg.data();
    sWorld->SendGlobalMessage(&data);
}
