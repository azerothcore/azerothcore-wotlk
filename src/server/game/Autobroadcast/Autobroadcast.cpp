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

#include "Autobroadcast.h"
#include "Chat.h"
#include "ChatTextBuilder.h"
#include "GameLocale.h"
#include "Language.h"
#include "Player.h"
#include "Realm.h"
#include "Tokenize.h"
#include "World.h"
//#include "GameConfig.h"

AutobroadcastMgr* AutobroadcastMgr::instance()
{
    static AutobroadcastMgr instance;
    return &instance;
}

void AutobroadcastMgr::Load()
{
    const uint32 oldMSTime = getMSTime();

    _autobroadcasts.clear();
    _autobroadcastsWeights.clear();

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_AUTOBROADCAST);
    stmt->SetData(0, realm.Id.Realm);

    PreparedQueryResult result = LoginDatabase.Query(stmt);
    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 autobroadcasts definitions. DB table `autobroadcast` is empty for this realm!");
        return;
    }

    do
    {
        Field* fields = result->Fetch();
        uint8 id = fields[0].Get<uint8>();

        _autobroadcasts[id] = fields[2].Get<std::string>();
        _autobroadcastsWeights[id] = fields[1].Get<uint8>();
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} autobroadcast definitions in {} ms", _autobroadcasts.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AutobroadcastMgr::Send()
{
    if (_autobroadcasts.empty())
    {
        return;
    }

    uint32 weight = 0;
    uint32 textID = 0;
    AutoBroadCastWeightsStore selectionWeights;

    for (const auto& [id, weightId] : _autobroadcastsWeights)
    {
        if (weightId)
        {
            weight += weightId;
            selectionWeights[id] = weightId;
        }
    }

    if (weight)
    {
        uint32 selectedWeight = urand(0, weight - 1);
        weight = 0;

        for (const auto& [id, weightId] : selectionWeights)
        {
            weight += weightId;
            if (selectedWeight < weight)
            {
                textID = id;
                break;
            }
        }
    }
    else
        textID = urand(0, _autobroadcasts.size());

    if (!textID)
    {
        LOG_ERROR("autobroadcast", "> AutobroadcastMgr::Send: Empty message id");
        return;
    }

    std::string message{ _autobroadcasts.at(textID) };

    auto SendNotification = [_msg = message, textID]()
    {
        for (auto const& [accountID, session] : sWorld->GetAllSessions())
        {
            Player* player = session->GetPlayer();
            if (!player || !player->IsInWorld())
            {
                return;
            }

            std::string localeMsg{ _msg };

            if (auto autoBroadCastLocale = sGameLocale->GetAutoBroadCastLocale(textID))
            {
                GameLocale::GetLocaleString(autoBroadCastLocale->Text, player->GetSession()->GetSessionDbLocaleIndex(), localeMsg);
            }

            for (std::string_view line : Acore::Tokenize(localeMsg, '\n', true))
            {
                WorldPacket data(SMSG_NOTIFICATION, line.size() + 1);
                data << line;
                player->SendDirectMessage(&data);
            }
        }
    };

    auto SendWorldText = [_msg = message, textID]()
    {
        for (auto const& [accountID, session] : sWorld->GetAllSessions())
        {
            Player* player = session->GetPlayer();
            if (!player || !player->IsInWorld())
            {
                return;
            }

            std::string localeMsg{ _msg };

            if (auto const& autoBroadCastLocale = sGameLocale->GetAutoBroadCastLocale(textID))
            {
                GameLocale::GetLocaleString(autoBroadCastLocale->Text, player->GetSession()->GetSessionDbLocaleIndex(), localeMsg);
            }

            std::string fmtMessage = Acore::StringFormatFmt(sGameLocale->GetAcoreString(LANG_AUTO_BROADCAST, player->GetSession()->GetSessionDbLocaleIndex()), localeMsg);

            for (std::string_view line : Acore::Tokenize(fmtMessage, '\n', true))
            {
                WorldPacket data;
                ChatHandler::BuildChatPacket(data, CHAT_MSG_SYSTEM, LANG_UNIVERSAL, nullptr, nullptr, line);
                player->SendDirectMessage(&data);
            }
        }
    };

    const AnnounceType announceType = static_cast<AnnounceType>(sWorld->getIntConfig(CONFIG_AUTOBROADCAST_CENTER));

    // Send before localize
    LOG_INFO("server.worldserver", "AutoBroadcast: '{}'", message);

    switch (announceType)
    {
    case AnnounceType::WORLD:
        SendWorldText();
        break;
    case AnnounceType::NOTIFICATION:
        SendNotification();
        break;
    case AnnounceType::BOTH:
        SendNotification();
        SendWorldText();
        break;
    }
}
