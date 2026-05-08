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

#include "MotdMgr.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "ScriptMgr.h"
#include "Timer.h"
#include "Tokenize.h"
#include "WorldPacket.h"
#include <iterator>

namespace
{
    // Stores translated worldpackets
    std::unordered_map<LocaleConstant, WorldPacket> MotdPackets;
    // Stores the localized motd to prevent database queries
    std::unordered_map<LocaleConstant, std::string> MotdMap;
}

MotdMgr* MotdMgr::instance()
{
    static MotdMgr instance;
    return &instance;
}

void MotdMgr::SetMotd(std::string motd, LocaleConstant locale)
{
    // scripts may change motd
    sScriptMgr->OnMotdChange(motd, locale);

    MotdMap[locale] = motd;
    MotdPackets[locale] = CreateWorldPacket(motd);
}

void MotdMgr::LoadMotd()
{
    uint32 oldMSTime = getMSTime();

    uint32 realmId = sConfigMgr->GetOption<int32>("RealmID", 0);
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_MOTD);
    stmt->SetData(0, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (result)
    {
        Field* fields = result->Fetch();
        std::string motd = fields[0].Get<std::string>();

        SetMotd(motd, LOCALE_enUS);

        LoadMotdLocale();
    }
    else
    {
        LOG_INFO("server.loading", ">> Loaded 0 motd definitions. DB table `motd` is empty for this realm!");
        LOG_INFO("server.loading", ">> Loaded 0 motd locale definitions. DB table `motd` needs an entry to be able to load DB table `motd_locale`!");
        LOG_INFO("server.loading", " ");
    }

    LOG_INFO("server.loading", ">> Loaded motd definitions in {} ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void MotdMgr::LoadMotdLocale()
{
    uint32 oldMSTime = getMSTime();
    uint32 count = 0;
    LOG_INFO("server.loading", "Loading Motd locale...");

    uint32 realmId = sConfigMgr->GetOption<int32>("RealmID", 0);
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_MOTD_LOCALE);
    stmt->SetData(0, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            // fields[0] is the locale string and fields[1] is the localized motd text
            std::string locale = fields[0].Get<std::string>();
            std::string localizedText = fields[1].Get<std::string>();

            if (!IsLocaleValid(locale))
            {
                LOG_ERROR("server.loading", "DB table `motd_localized` has invalid locale ({}), skipped.", locale);
                continue;
            }

            LocaleConstant localeId = GetLocaleByName(locale);
            if (localeId == LOCALE_enUS)
                continue;

            SetMotd(localizedText, localeId);
            ++count;
        } while (result->NextRow());
    }
    else
    {
        LOG_INFO("server.loading", ">> Loaded 0 motd locale definitions. DB table `motd_localized` is empty for this realm!");
        LOG_INFO("server.loading", " ");
    }

    LOG_INFO("server.loading", ">> Loaded {} motd locale definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
}

char const* MotdMgr::GetMotd(LocaleConstant locale)
{
    // Return localized motd if available, otherwise fallback to enUS
    auto it = MotdMap.find(locale);
    if (it != MotdMap.end())
        return it->second.c_str();

    return MotdMap[LOCALE_enUS].c_str();  // Fallback to enUS if locale is not found
}

WorldPacket const* MotdMgr::GetMotdPacket(LocaleConstant locale)
{
    // Return localized packet if available, otherwise fallback to enUS
    auto it = MotdPackets.find(locale);
    if (it != MotdPackets.end())
        return &it->second;

    return &MotdPackets[LOCALE_enUS];  // Fallback to enUS if locale is not found
}

WorldPacket MotdMgr::CreateWorldPacket(std::string motd)
{
    // Create a new WorldPacket for this locale
    WorldPacket data(SMSG_MOTD); // new in 2.0.1

    // Branding append removed

    // Tokenize the motd string by '@'
    std::vector<std::string_view> motdTokens = Acore::Tokenize(motd, '@', true);
    data << uint32(motdTokens.size()); // line count

    for (std::string_view token : motdTokens)
        data << token;

    return data;
}
