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

#ifndef CONFIGVALUECACHE_H
#define CONFIGVALUECACHE_H

#include "Common.h"
#include "Config.h"
#include "Errors.h"
#include "Log.h"
#include <variant>

template<typename ConfigEnum>
class ConfigValueCache
{
    static_assert(std::is_enum_v<ConfigEnum>);

public:
    enum class Reloadable : bool
    {
        No = false,
        Yes = true
    };

    ConfigValueCache(ConfigEnum const configCount)
    {
        _configs.resize(static_cast<uint32>(configCount));
        _reloading = false;
    }

    void Initialize(bool reload)
    {
        _reloading = reload;
        BuildConfigCache();
        _reloading = false;
        VerifyAllConfigsLoaded();
    }

    template<class T>
    void SetConfigValue(ConfigEnum const config, std::string const& configName, T const& defaultValue, Reloadable reloadable = Reloadable::Yes, std::function<bool(T const& value)>&& checker = {}, std::string const& validationErrorText = "")
    {
        uint32 const configIndex = static_cast<uint32>(config);
        ASSERT(configIndex < _configs.size(), "Config index out of bounds");
        T const& configValue = sConfigMgr->GetOption<T>(configName, defaultValue);

        bool configValueChanged = false;
        if (_reloading)
        {
            if (std::get<T>(_configs[configIndex]) != configValue)
                configValueChanged = true;

            if (reloadable == Reloadable::No)
            {
                if (configValueChanged)
                    LOG_ERROR("server.loading", "Server Config (Name: {}) cannot be changed by reload. A server restart is required to update this config value.", configName);
                return;
            }
        }
        else
            ASSERT(_configs[configIndex].index() == 0, "Config overwriting an existing value");

        if (checker && !checker(configValue))
        {
            LOG_ERROR("server.loading", "Server Config (Name: {}) failed validation check '{}'. Default value '{}' will be used instead.", configName, validationErrorText, defaultValue);
            _configs[configIndex] = defaultValue;
        }
        else
            _configs[configIndex] = configValue;
    }

    template<class T>
    void OverwriteConfigValue(ConfigEnum const config, T const& value)
    {
        uint32 const configIndex = static_cast<uint32>(config);
        ASSERT(configIndex < _configs.size(), "Config index out of bounds");
        size_t const oldValueTypeIndex = _configs[configIndex].index();
        ASSERT(oldValueTypeIndex != 0, "Config value must already be set");
        _configs[configIndex] = value;
        ASSERT(oldValueTypeIndex == _configs[configIndex].index(), "Config value type changed");
    }

    template<class T>
    T GetConfigValue(ConfigEnum const config) const
    {
        uint32 const configIndex = static_cast<uint32>(config);
        ASSERT(configIndex < _configs.size(), "Config index out of bounds");
        ASSERT(_configs[configIndex].index() != 0, "Config value must already be set");

        T const* value = std::get_if<T>(&_configs[configIndex]);
        ASSERT(value, "Wrong config variant type");

        return *value;
    }

    // Custom handling for string configs to convert from std::string to std::string_view
    std::string_view GetConfigValue(ConfigEnum const config) const
    {
        uint32 const configIndex = static_cast<uint32>(config);
        ASSERT(configIndex < _configs.size(), "Config index out of bounds");
        ASSERT(_configs[configIndex].index() != 0, "Config value must already be set");

        std::string const* stringValue = std::get_if<std::string>(&_configs[configIndex]);
        ASSERT(stringValue, "Wrong config variant type");

        return std::string_view(*stringValue);
    }

protected:
    virtual void BuildConfigCache() = 0;

private:
    void VerifyAllConfigsLoaded()
    {
        uint32 configIndex = 0;
        for (auto const& variant : _configs)
        {
            if (variant.index() == 0)
            {
                LOG_ERROR("server.loading", "Server Config (Index: {}) is defined but not loaded, unable to continue.", configIndex);
                ASSERT(false);
            }

            ++configIndex;
        }
    }

    std::vector<std::variant<std::monostate, float, bool, uint32, std::string>> _configs;
    bool _reloading;
};

#endif
