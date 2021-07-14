/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
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
    LOG_INFO("server.loading", "");
    LOG_INFO("server.loading", ">> Loading modules strings");
    LoadModuleString();
}

void ModuleLocale::CheckStrings(std::string const& moduleName, uint32 maxString)
{
    uint32 stringCount = GetStringsCount(moduleName);
    maxString--;

    if (stringCount != maxString)
        FMT_LOG_FATAL("locale.module", "> Strings locale ({}) != ({}) for module ({})", stringCount, maxString, moduleName);
}

void ModuleLocale::AddModuleString(std::string const& moduleName, ModuleStringContainer& data)
{
    if (data.empty())
    {
        FMT_LOG_ERROR("locale.module", "ModuleStringContainer& data for module ({}) is empty!", moduleName);
        return;
    }

    auto const& itr = _modulesStringStore.find(moduleName);
    if (itr != _modulesStringStore.end())
    {
        FMT_LOG_ERROR("locale.module", "ModuleStringContainer& existing data for module ({}). Skip", moduleName);
        return;
    }

    _modulesStringStore.emplace(moduleName, data);

    FMT_LOG_DEBUG("locale.module", "> ModulesLocales: added {} strings for ({}) module", static_cast<uint32>(data.size()), moduleName);
}

Optional<std::string> ModuleLocale::GetModuleString(std::string const& moduleName, uint32 id, uint8 _locale) const
{
    if (moduleName.empty())
    {
        LOG_ERROR("locale.module", "> ModulesLocales: moduleName is empty!");
        return std::nullopt;
    }

    auto const& itr = _modulesStringStore.find(moduleName);
    if (itr == _modulesStringStore.end())
    {
        FMT_LOG_FATAL("locale.module", "> ModulesLocales: Not found strings for module ({})", moduleName);
        return std::nullopt;
    }

    auto const& itr2 = itr->second.find(id);
    if (itr2 == itr->second.end())
    {
        FMT_LOG_FATAL("locale.module", "> ModulesLocales: Not found string ({}) for module ({})", id, moduleName);
        return std::nullopt;
    }

    return itr2->second.GetText(_locale);
}

uint32 ModuleLocale::GetStringsCount(std::string const& moduleName)
{
    if (moduleName.empty())
    {
        LOG_ERROR("locale.module", "> ModulesLocales: _moduleName is empty!");
        return 0;
    }

    auto const& itr = _modulesStringStore.find(moduleName);
    if (itr == _modulesStringStore.end())
    {
        FMT_LOG_FATAL("locale.module", "> ModulesLocales: Not found strings for module ({})", moduleName);
        return 0;
    }

    return static_cast<uint32>(itr->second.size());
}

void ModuleLocale::LoadModuleString()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT DISTINCT `ModuleName` FROM `string_module`");
    if (!result)
    {
        LOG_WARN("server.loading", "> DB table `string_module` is empty");
        return;
    }

    ModuleStringContainer _tempStore;
    std::vector<std::string> _localesModuleList;
    uint32 countAll = 0;

    // Add module list
    do
    {
        _localesModuleList.push_back(result->Fetch()->GetString());

    } while (result->NextRow());

    for (auto const& itr : _localesModuleList)
    {
        std::string const& moduleName = itr;

        result = WorldDatabase.PQuery("SELECT `ID`, `Locale`, `Text` FROM `string_module` WHERE `ModuleName` = '{}'", moduleName);
        if (!result)
        {
            FMT_LOG_ERROR("sql.sql", "> Strings for module {} is bad!", moduleName);
            return;
        }

        _tempStore.clear();

        do
        {
            Field* fields = result->Fetch();

            Acore::Game::Locale::AddLocaleString(fields[2].GetString(), GetLocaleByName(fields[1].GetString()), _tempStore[fields[0].GetUInt32()].Content);
            countAll++;

        } while (result->NextRow());

        AddModuleString(moduleName, _tempStore);
    }

    FMT_LOG_INFO("server.loading", ">> Loaded {} module strings for {} modules in {} ms", countAll, static_cast<uint32>(_modulesStringStore.size()), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ModuleLocale::SendPlayerMessage(Player* player, std::function<std::string_view()> const& msg)
{
    if (msg().empty())
        return;

    for (std::string_view line : Acore::Tokenize(msg(), '\n', true))
    {
        WorldPacket data;
        ChatHandler::BuildChatPacket(data, CHAT_MSG_SYSTEM, LANG_UNIVERSAL, nullptr, nullptr, line);
        SendPlayerPacket(player, &data);
    }
}

void ModuleLocale::SendGlobalMessage(bool gmOnly, std::function<std::string_view()> const& msg)
{
    if (msg().empty())
        return;

    for (auto const& [accountID, session] : sWorld->GetAllSessions())
    {
        Player* player = session->GetPlayer();
        if (!player || !player->IsInWorld())
            return;

        if (AccountMgr::IsPlayerAccount(player->GetSession()->GetSecurity()) && gmOnly)
            continue;

        for (std::string_view line : Acore::Tokenize(msg(), '\n', true))
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
