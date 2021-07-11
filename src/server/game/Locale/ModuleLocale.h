/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _MODULES_LOCALE_H_
#define _MODULES_LOCALE_H_

#include "Common.h"
#include "Optional.h"
#include "StringFormat.h"
#include <functional>
#include <unordered_map>
#include <vector>

class Player;
class WorldPacket;

struct AC_GAME_API ModuleString
{
    ModuleString()
    {
        Content.resize(DEFAULT_LOCALE + 1);
    }

    std::vector<std::string> Content;

    Optional<std::string> GetText(uint8 locale = 0) const
    {
        if (Content.size() > size_t(locale) && !Content[locale].empty())
            return Content[locale];

        if (!Content[0].empty())
            return Content[0];

        return std::nullopt;
    }
};

class AC_GAME_API ModuleLocale
{
private:
    ModuleLocale() = default;
    ~ModuleLocale() = default;

    ModuleLocale(ModuleLocale const&) = delete;
    ModuleLocale(ModuleLocale&&) = delete;
    ModuleLocale& operator= (ModuleLocale const&) = delete;
    ModuleLocale& operator= (ModuleLocale&&) = delete;

public:
    static ModuleLocale* instance();

    void Init();
    void LoadModuleString();
    void CheckStrings(std::string const& moduleName, uint32 maxString);

    Optional<std::string> GetModuleString(std::string const& moduleName, uint32 id, uint8 _locale) const;
    uint32 GetStringsCount(std::string const& moduleName);

    // Get localized message
    template<typename... Args>
    inline std::string GetLocaleMessage(std::string const& moduleName, uint32 id, uint8 localeIndex, Args&&... args)
    {
        return Acore::StringFormatFmt(*GetModuleString(moduleName, id, localeIndex), std::forward<Args>(args)...);
    }

    void SendPlayerMessage(Player* player, std::function<std::string_view()> const& msg);
    void SendGlobalMessage(bool gmOnly, std::function<std::string_view()> const& msg);

private:
    using ModuleStringContainer = std::unordered_map<uint32, ModuleString>;
    using AllModulesStringContainer = std::unordered_map<std::string, ModuleStringContainer>;

    AllModulesStringContainer _modulesStringStore;

    void AddModuleString(std::string const& moduleName, ModuleStringContainer& data);

    // Send packets
    void SendPlayerPacket(Player* player, WorldPacket* data);
};

#define sModuleLocale ModuleLocale::instance()

#endif // _MODULES_LOCALE_H_
