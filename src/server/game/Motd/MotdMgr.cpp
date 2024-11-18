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
    // Dict to store all valid locales
    std::unordered_map<std::string, LocaleConstant> localeMap = {
        {"enUS", LOCALE_enUS},
        {"deDE", LOCALE_deDE},
        {"frFR", LOCALE_frFR},
        {"koKR", LOCALE_koKR},
        {"zhCN", LOCALE_zhCN},
        {"zhTW", LOCALE_zhTW},
        {"esES", LOCALE_esES},
        {"esMX", LOCALE_esMX},
        {"ruRU", LOCALE_ruRU}
    };
}

MotdMgr* MotdMgr::instance()
{
    static MotdMgr instance;
    return &instance;
}

void MotdMgr::SetMotd(std::string motd, std::string locale)
{
    // Convert string locale to locale constant
    LocaleConstant localeConstant = ConvertStringToLocaleConstant(locale);

    // scripts may change motd
    sScriptMgr->OnMotdChange(motd, localeConstant);

    MotdMap[localeConstant] = motd;
    MotdPackets[localeConstant] = CreateWorldPacket(motd);
}

void MotdMgr::CreateWorldPackages()
{
    for (auto const& [locale, motd] : MotdMap)
        // Store the constructed packet in MotdPackets with the locale as the key
        MotdPackets[locale] = CreateWorldPacket(motd);
}
void MotdMgr::LoadMotd()
{
    uint32 realmId = sConfigMgr->GetOption<int32>("RealmID", 0);

    // Load the main motd for the realm and assign it to enUS if available
    std::string motd = LoadDefaultMotd(realmId);

    // Check if motd was loaded; if not, set default only for enUS
    if (motd.empty())
        SetDefaultMotd(motd);  // Only sets enUS default if motd is empty
    else
        MotdMap[LOCALE_enUS] = motd;  // Assign the loaded motd to enUS

    // Load localized texts if available
    LoadLocalizedMotds(realmId);

    // Create all world packages after loading motd and localized texts
    CreateWorldPackages();
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

LocaleConstant MotdMgr::ConvertStringToLocaleConstant(const std::string& locale)
{
    auto it = localeMap.find(locale);
    return (it != localeMap.end()) ? it->second : LOCALE_enUS; // Default fallback
}

bool MotdMgr::IsValidLocale(const std::string& locale)
{
    // Check if the locale exists in the keys of localeMap
    return localeMap.find(locale) != localeMap.end();
}

std::string MotdMgr::LoadDefaultMotd(uint32 realmId)
{
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_MOTD);
    stmt->SetData(0, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (result)
    {
        Field* fields = result->Fetch();
        return fields[0].Get<std::string>();  // Return the main motd if found
    }

    return ""; // Return empty string if no motd found
}

void MotdMgr::SetDefaultMotd(std::string& motd)
{
    // Set a default motd text only for enUS if no motd is found
    motd = "@|cffF4A2DThi server runs on Azeroth Core|cff3CE7FFwww.azerothcore.org|r";
    MotdMap[LOCALE_enUS] = motd;

    // Log that no motd was found and a default is being used for enUS
    LOG_WARN("server.loading", ">> Loaded 0 motd definitions. DB table `motd` is empty for this realm!");
    LOG_INFO("server.loading", " ");
}

void MotdMgr::LoadLocalizedMotds(uint32 realmId) {
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_MOTD_LOCALE);
    stmt->SetData(0, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (result)
    {
        do {
            Field* fields = result->Fetch();

            // fields[0] is the locale string and fields[1] is the localized motd text
            std::string locale = fields[0].Get<std::string>();
            std::string localizedText = fields[1].Get<std::string>();

            // Convert locale string to LocaleConstant
            LocaleConstant localeId = ConvertStringToLocaleConstant(locale);

            // Insert the localeId and localizedText into MotdMap only for specific locales
            MotdMap[localeId] = localizedText;

        } while (result->NextRow()); // Move to the next row if available
    }
}

WorldPacket MotdMgr::CreateWorldPacket(const std::string& motd)
{
    // Create a new WorldPacket for this locale
    WorldPacket data(SMSG_MOTD); // new in 2.0.1

    // Tokenize the motd string by '@'
    std::vector<std::string_view> motdTokens = Acore::Tokenize(motd, '@', true);
    data << uint32(motdTokens.size()); // line count

    // Add each token to the packet
    for (std::string_view token : motdTokens)
        data << token;

    return data;
}
