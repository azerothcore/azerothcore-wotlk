/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "AutobroadcastMgr.h"
#include "Config.h"
#include "Chat.h"
#include "Language.h"
#include "Player.h"

AutobroadcastMgr* AutobroadcastMgr::instance()
{
    static AutobroadcastMgr instance;
    return &instance;
}

void AutobroadcastMgr::Load()
{
    const uint32 oldMSTime = getMSTime();

    m_Autobroadcasts.clear();
    m_AutobroadcastsWeights.clear();
    m_AutobroadcastTextLocale.clear();

    const uint32 realmId = sConfigMgr->GetOption<int32>("RealmID", 0);
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_AUTOBROADCAST);
    stmt->setInt32(0, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 autobroadcasts definitions. DB table `autobroadcast` is empty for this realm!");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        const uint8 id = fields[0].GetUInt8();

        m_AutobroadcastsWeights[id] = fields[1].GetUInt8();

        m_AutobroadcastTextLocale[LOCALE_enUS] = fields[2].GetString();
        m_AutobroadcastTextLocale[LOCALE_deDE] = fields[3].GetString();
        m_AutobroadcastTextLocale[LOCALE_frFR] = fields[4].GetString();
        m_AutobroadcastTextLocale[LOCALE_ruRU] = fields[5].GetString();
        m_AutobroadcastTextLocale[LOCALE_esES] = fields[6].GetString();
        m_AutobroadcastTextLocale[LOCALE_esMX] = fields[7].GetString();
        m_AutobroadcastTextLocale[LOCALE_koKR] = fields[8].GetString();
        m_AutobroadcastTextLocale[LOCALE_zhCN] = fields[9].GetString();
        m_AutobroadcastTextLocale[LOCALE_zhTW] = fields[10].GetString();

        m_Autobroadcasts[id] = { m_AutobroadcastTextLocale };

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded %u autobroadcast definitions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void AutobroadcastMgr::Send()
{
    if (m_Autobroadcasts.empty())
    {
        return;
    }

    uint32 weight = 0;
    AutobroadcastsWeightMap selectionWeights;

    AutobroadcastTextMap msg;

    for (const auto [id, weightId] : m_AutobroadcastsWeights)
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

        for (const auto [id, weightId] : selectionWeights)
        {
            weight += weightId;
            if (selectedWeight < weight)
            {
                msg = m_Autobroadcasts[id];
                break;
            }
        }
    }
    else
    {
        msg = m_Autobroadcasts[urand(0, m_Autobroadcasts.size())];
    }

    const AnnounceType announceType = static_cast<AnnounceType>(sWorld->getIntConfig(CONFIG_AUTOBROADCAST_CENTER));

    const auto sendNotification = [](const std::string_view message)
    {
        WorldPacket data(SMSG_NOTIFICATION, (message.size() + 1));
        data << message;
        sWorld->SendGlobalMessage(&data);
    };

    for (const auto& [localeId, message] : msg)
    {
        if (message.empty())
        {
            continue;
        }

        switch (announceType)
        {
        case AnnounceType::WORLD:
            sWorld->SendTextToSpecificLocale(localeId, LANG_AUTO_BROADCAST, message.c_str());
            break;
        case AnnounceType::NOTIFICATION:
            sendNotification(message.c_str());
            break;
        case AnnounceType::BOTH:
            sWorld->SendTextToSpecificLocale(localeId, LANG_AUTO_BROADCAST, message.c_str());
            sendNotification(message.c_str());
            break;
        }
    }

    for (const auto& [locale, message] : msg)
    {
        LOG_DEBUG("server.worldserver", "AutoBroadcast: localeId: '%u', Msg: '%s'", locale, message.c_str());
    }
}
