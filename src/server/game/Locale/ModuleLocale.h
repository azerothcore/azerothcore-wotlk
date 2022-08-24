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

struct ModuleString
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

    Optional<std::string> GetModuleString(std::string const& entry, uint8 _locale) const;

    // Get localized message
    template<typename... Args>
    inline std::string GetLocaleMessage(std::string const& entry, uint8 localeIndex, Args&&... args)
    {
        return Acore::StringFormat(*GetModuleString(entry, localeIndex), std::forward<Args>(args)...);
    }

    void SendPlayerMessageFmt(Player* player, std::function<std::string_view(uint8)> const& msg);
    void SendGlobalMessageFmt(bool gmOnly, std::function<std::string_view(uint8)> const& msg);

    // Send localized message to player
    template<typename... Args>
    void SendPlayerMessage(Player* player, std::string const& entry, Args&&... args)
    {
        SendPlayerMessageFmt(player, [&](uint8 index)
        {
            return GetLocaleMessage(entry, index, std::forward<Args>(args)...);
        });
    }

    // Send localized message to all player
    template<typename... Args>
    void SendGlobalMessage(bool gmOnly, std::string const& entry, Args&&... args)
    {
        SendGlobalMessageFmt(gmOnly, [&](uint8 index)
        {
            return GetLocaleMessage(entry, index, std::forward<Args>(args)...);
        });
    }

private:
    std::unordered_map<std::string, ModuleString> _modulesStringStore;

    // Send packets
    void SendPlayerPacket(Player* player, WorldPacket* data);
};

#define sModuleLocale ModuleLocale::instance()

#endif // _MODULES_LOCALE_H_
