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
}

MotdMgr* MotdMgr::instance()
{
    static MotdMgr instance;
    return &instance;
}

bool MotdMgr::IsValidLocale(std::string const& locale) {
    // Use std::find to search for the locale in the array
    return std::find(std::begin(localeNames), std::end(localeNames), locale) != std::end(localeNames);
}

void MotdMgr::SetMotd(std::string motd, LocaleConstant locale)
{
    // scripts may change motd
    sScriptMgr->OnMotdChange(motd, locale);

    MotdMap[locale] = motd;
    MotdPackets[locale] = CreateWorldPacket(motd);
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
        SetDefaultMotd();  // Only sets enUS default if motd is empty
    else
        MotdMap[DEFAULT_LOCALE] = motd;  // Assign the loaded motd to enUS

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

    return MotdMap[DEFAULT_LOCALE].c_str();  // Fallback to enUS if locale is not found
}

WorldPacket const* MotdMgr::GetMotdPacket(LocaleConstant locale)
{
    // Return localized packet if available, otherwise fallback to enUS
    auto it = MotdPackets.find(locale);
    if (it != MotdPackets.end())
        return &it->second;

    return &MotdPackets[DEFAULT_LOCALE];  // Fallback to enUS if locale is not found
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

void MotdMgr::SetDefaultMotd()
{
    std::string motd = /* fctlsup << //0x338// "63"+"cx""d2"+"1e""dd"+"cx""ds"+"ce""dd"+"ce""7D"+ << */
        /*"d3"+"ce"*/ std::string("@|") + "cf" +/*"as"+"k4"*/"fF" + "F4" +/*"d5"+"f3"*/"A2" + "DT"/*"F4"+"Az"*/ + "hi" + "s "
        /*"fd"+"hy"*/ + "se" + "rv" +/*"nh"+"k3"*/"er" + " r" +/*"x1"+"A2"*/"un" + "s "/*"F2"+"Ay"*/ + "on" + " Az"
        /*"xs"+"5n"*/ + "er" + "ot" +/*"xs"+"A2"*/"hC" + "or" +/*"a4"+"f3"*/"e|" + "r "/*"f2"+"A2"*/ + "|c" + "ff"
        /*"5g"+"A2"*/ + "3C" + "E7" +/*"k5"+"AX"*/"FF" + "ww" +/*"sx"+"Gj"*/"w." + "az"/*"a1"+"vf"*/ + "er" + "ot"
        /*"ds"+"sx"*/ + "hc" + "or" +/*"F4"+"k5"*/"e." + "or" +/*"po"+"xs"*/"g|r"/*"F4"+"p2"+"o4"+"A2"+"i2"*/;

   MotdMap[DEFAULT_LOCALE] = motd;

    // Log that no motd was found and a default is being used for enUS
    LOG_WARN("server.loading", ">> Loaded 0 motd definitions. DB table `motd` is empty for this realm!");
    LOG_INFO("server.loading", " ");
}

void MotdMgr::LoadLocalizedMotds(uint32 realmId) {
    // First, check if base MOTD exists
    LoginDatabasePreparedStatement* baseStmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_MOTD);
    baseStmt->SetData(0, realmId);
    PreparedQueryResult baseResult = LoginDatabase.Query(baseStmt);

    if (!baseResult)
    {
        LOG_ERROR("server.loading", "No base MOTD found for realm %u. Localized MOTDs will not be loaded.", realmId);
        return;
    }

    // Now load localized versions
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_MOTD_LOCALE);
    stmt->SetData(0, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (result)
    {
        do {
            Field* fields = result->Fetch();
            // fields[0] is the locale string and fields[1] is the localized motd text
            std::string localizedText = fields[1].Get<std::string>();
            // Convert locale string to LocaleConstant
            LocaleConstant localeId = GetLocaleByName(fields[0].Get<std::string>());

            if (localeId == DEFAULT_LOCALE)
                continue;

            MotdMap[localeId] = localizedText;
        } while (result->NextRow());
    }
}

WorldPacket MotdMgr::CreateWorldPacket(std::string const& motd)
{
    // Create a new WorldPacket for this locale
    WorldPacket data(SMSG_MOTD); // new in 2.0.1

    // Tokenize the motd string by '@'
    std::vector<std::string_view> motdTokens = Acore::Tokenize(motd, '@', true);
    data << uint32(motdTokens.size()); // line count

    for (std::string_view token : motdTokens)
        data << token;

    return data;
}
