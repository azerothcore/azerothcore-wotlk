/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
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

#include "ModuleLocale.h"
#include "AccountMgr.h"
#include "Chat.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "LocaleCommon.h"
#include "Log.h"
#include "Optional.h"
#include "Player.h"
#include "Tokenize.h"
#include "World.h"

ModuleLocale* ModuleLocale::instance()
{
    static ModuleLocale instance;
    return &instance;
}

void ModuleLocale::Init()
{
    LOG_INFO("server.loading", " ");
    LOG_INFO("server.loading", ">> Loading modules strings");
    LoadModuleString();
}

Optional<std::string> ModuleLocale::GetModuleString(std::string const& entry, uint8 _locale) const
{
    if (entry.empty())
    {
        LOG_ERROR("locale.module", "> ModulesLocales: Entry is empty!");
        return std::nullopt;
    }

    auto const& itr = _modulesStringStore.find(entry);
    if (itr == _modulesStringStore.end())
    {
        LOG_FATAL("locale.module", "> ModulesLocales: Not found strings for entry ({})", entry);
        ABORT();
        return {};
    }

    return itr->second.GetText(_locale);
}

void ModuleLocale::LoadModuleString()
{
    uint32 oldMSTime = getMSTime();

    _modulesStringStore.clear();

    QueryResult result = WorldDatabase.Query("SELECT `Entry`, `Locale`, `Text` FROM `string_module`");
    if (!result)
    {
        LOG_INFO("server.loading", "> DB table `string_module` is empty");
        LOG_INFO("server.loading", " ");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        auto& data = _modulesStringStore[fields[0].Get<std::string>()];

        Acore::Locale::AddLocaleString(fields[2].Get<std::string_view>(), GetLocaleByName(fields[1].Get<std::string>()), data.Content);

    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} module strings in {} ms", _modulesStringStore.size(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ModuleLocale::SendPlayerMessageFmt(Player* player, std::function<std::string_view(uint8)> const& msg)
{
    if (!msg)
        return;

    for (std::string_view line : Acore::Tokenize(msg(player->GetSession()->GetSessionDbLocaleIndex()), '\n', true))
    {
        WorldPacket data;
        ChatHandler::BuildChatPacket(data, CHAT_MSG_SYSTEM, LANG_UNIVERSAL, nullptr, nullptr, line);
        SendPlayerPacket(player, &data);
    }
}

void ModuleLocale::SendGlobalMessageFmt(bool gmOnly, std::function<std::string_view(uint8)> const& msg)
{
    if (!msg)
        return;

    for (auto const& [accountID, session] : sWorld->GetAllSessions())
    {
        Player* player = session->GetPlayer();
        if (!player || !player->IsInWorld())
            return;

        if (AccountMgr::IsPlayerAccount(player->GetSession()->GetSecurity()) && gmOnly)
            continue;

        for (std::string_view line : Acore::Tokenize(msg(player->GetSession()->GetSessionDbLocaleIndex()), '\n', true))
        {
            WorldPacket data;
            ChatHandler::BuildChatPacket(data, CHAT_MSG_SYSTEM, LANG_UNIVERSAL, nullptr, nullptr, line);
            SendPlayerPacket(player, &data);
        }
    }
}

void ModuleLocale::SendPlayerPacket(Player* player, WorldPacket* data)
{
    player->SendDirectMessage(data);
}
