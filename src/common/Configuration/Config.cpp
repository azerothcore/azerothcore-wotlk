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

#include "Config.h"
#include "Log.h"
#include "StringConvert.h"
#include "StringFormat.h"
#include "Tokenize.h"
#include "Util.h"
#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <fstream>
#include <locale>
#include <mutex>
#include <unordered_map>
#include <unordered_set>

namespace
{
    std::string _filename;
    std::vector<std::string> _additonalFiles;
    std::vector<std::string> _args;
    std::unordered_map<std::string /*name*/, std::string /*value*/> _configOptions;
    std::unordered_map<std::string /*name*/, std::string /*value*/> _envVarCache;
    std::mutex _configLock;
    ConfigPolicy _policy;

    std::unordered_set<std::string> _criticalConfigOptions =
    {
        "RealmID",
        "LoginDatabaseInfo",
        "WorldDatabaseInfo",
        "CharacterDatabaseInfo",
    };

    // Check system configs like *server.conf*
    bool IsAppConfig(std::string_view fileName)
    {
        std::size_t foundAuth = fileName.find("authserver.conf");
        std::size_t foundWorld = fileName.find("worldserver.conf");
        std::size_t foundImport = fileName.find("dbimport.conf");

        return foundAuth != std::string_view::npos || foundWorld != std::string_view::npos || foundImport != std::string_view::npos;
    }

    // Check logging system configs like Appender.* and Logger.*
    bool IsLoggingSystemOptions(std::string_view optionName)
    {
        std::size_t foundAppender = optionName.find("Appender.");
        std::size_t foundLogger = optionName.find("Logger.");

        return foundAppender != std::string_view::npos || foundLogger != std::string_view::npos;
    }

    Optional<ConfigSeverity> ParseSeverity(std::string_view value)
    {
        if (value.empty())
            return std::nullopt;

        std::string lowered(value);
        std::transform(lowered.begin(), lowered.end(), lowered.begin(), [](unsigned char c) { return std::tolower(c); });

        if (lowered == "skip")
            return ConfigSeverity::Skip;

        if (lowered == "warn" || lowered == "warning")
            return ConfigSeverity::Warn;

        if (lowered == "error")
            return ConfigSeverity::Error;

        if (lowered == "fatal" || lowered == "abort" || lowered == "panic")
            return ConfigSeverity::Fatal;

        return std::nullopt;
    }

    template<typename Format, typename... Args>
    inline void PrintError(std::string_view filename, Format&& fmt, Args&& ... args)
    {
        std::string message = Acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...);

        if (IsAppConfig(filename))
        {
            fmt::print("{}\n", message);
        }
        else
        {
            LOG_ERROR("server.loading", message);
        }
    }

    template<typename Format, typename... Args>
    inline void LogWithSeverity(ConfigSeverity severity, std::string_view filename, Format&& fmt, Args&&... args)
    {
        std::string message = Acore::StringFormat(std::forward<Format>(fmt), std::forward<Args>(args)...);

        switch (severity)
        {
            case ConfigSeverity::Skip:
                return;
            case ConfigSeverity::Warn:
            {
                if (IsAppConfig(filename))
                    fmt::print("{}\n", message);

                LOG_WARN("server.loading", message);
                return;
            }
            case ConfigSeverity::Error:
            {
                if (IsAppConfig(filename))
                    fmt::print("{}\n", message);

                LOG_ERROR("server.loading", message);
                return;
            }
            case ConfigSeverity::Fatal:
            {
                if (IsAppConfig(filename))
                    fmt::print("{}\n", message);

                LOG_FATAL("server.loading", message);
                ABORT(message);
            }
        }
    }

    ConfigPolicy ApplyPolicyString(ConfigPolicy policy, std::string_view input)
    {
        if (input.empty())
            return policy;

        std::vector<std::pair<std::string, ConfigSeverity>> overrides;
        Optional<ConfigSeverity> defaultOverride;

        std::string tokenBuffer(input);
        for (std::string_view rawToken : Acore::Tokenize(tokenBuffer, ',', false))
        {
            std::string token = Acore::String::Trim(std::string(rawToken), std::locale());
            if (token.empty())
                continue;

            auto separator = token.find('=');
            if (separator == std::string::npos)
                continue;

            std::string key = Acore::String::Trim(token.substr(0, separator), std::locale());
            std::string value = Acore::String::Trim(token.substr(separator + 1), std::locale());

            if (key.empty() || value.empty())
                continue;

            auto severity = ParseSeverity(value);
            if (!severity)
                continue;

            std::transform(key.begin(), key.end(), key.begin(), [](unsigned char c) { return std::tolower(c); });

            if (key == "default")
            {
                defaultOverride = severity;
                continue;
            }

            overrides.emplace_back(std::move(key), *severity);
        }

        if (defaultOverride)
        {
            policy.defaultSeverity = *defaultOverride;
            policy.missingFileSeverity = *defaultOverride;
            policy.missingOptionSeverity = *defaultOverride;
            policy.criticalOptionSeverity = *defaultOverride;
            policy.unknownOptionSeverity = *defaultOverride;
            policy.valueErrorSeverity = *defaultOverride;
        }

        for (auto const& [key, severity] : overrides)
        {
            if (key == "missing_file" || key == "file")
                policy.missingFileSeverity = severity;
            else if (key == "missing_option" || key == "option")
                policy.missingOptionSeverity = severity;
            else if (key == "critical_option" || key == "critical")
                policy.criticalOptionSeverity = severity;
            else if (key == "unknown_option" || key == "unknown")
                policy.unknownOptionSeverity = severity;
            else if (key == "value_error" || key == "value")
                policy.valueErrorSeverity = severity;
        }

        return policy;
    }

    ConfigPolicy ApplyPolicyFromArgs(ConfigPolicy policy, std::vector<std::string> const& args)
    {
        for (std::size_t i = 0; i < args.size(); ++i)
        {
            std::string const& arg = args[i];
            std::string_view value;

            constexpr std::string_view shortOpt = "--config-policy";

            if (arg.rfind(shortOpt, 0) == 0)
            {
                if (arg.size() == shortOpt.size() && (i + 1) < args.size())
                {
                    value = args[i + 1];
                    ++i;
                }
                else if (arg.size() > shortOpt.size() && arg[shortOpt.size()] == '=')
                {
                    value = std::string_view(arg).substr(shortOpt.size() + 1);
                }

                if (!value.empty())
                    policy = ApplyPolicyString(policy, value);
            }
        }

        return policy;
    }

    void AddKey(std::string const& optionName, std::string const& optionKey, std::string_view fileName, bool isOptional, [[maybe_unused]] bool isReload)
    {
        auto const& itr = _configOptions.find(optionName);

        // Check old option
        if (isOptional && itr == _configOptions.end())
        {
            if (!IsLoggingSystemOptions(optionName) && !isReload)
            {
                LogWithSeverity(_policy.unknownOptionSeverity, fileName, "> Config::LoadFile: Found incorrect option '{}' in config file '{}'. Skip", optionName, fileName);

#ifdef CONFIG_ABORT_INCORRECT_OPTIONS
                ABORT("> Core can't start if found incorrect options");
#endif

                return;
            }
        }

        // Check exit option
        if (itr != _configOptions.end())
        {
            _configOptions.erase(optionName);
        }

        _configOptions.emplace(optionName, optionKey);
    }

    bool ParseFile(std::string const& file, bool isOptional, bool isReload)
    {
        std::ifstream in(file);

        if (in.fail())
        {
            ConfigSeverity severity = isOptional ? ConfigSeverity::Skip : _policy.missingFileSeverity;
            LogWithSeverity(severity, file, "> Config::LoadFile: Failed open {}file '{}'", isOptional ? "optional " : "", file);
            // Treat SKIP as a successful no-op so the app can proceed
            return severity == ConfigSeverity::Skip;
        }

        uint32 count = 0;
        uint32 lineNumber = 0;
        std::unordered_map<std::string /*name*/, std::string /*value*/> fileConfigs;

        auto IsDuplicateOption = [&](std::string const& confOption)
        {
            auto const& itr = fileConfigs.find(confOption);
            if (itr != fileConfigs.end())
            {
                PrintError(file, "> Config::LoadFile: Duplicate key name '{}' in config file '{}'", confOption, file);
                return true;
            }

            return false;
        };

        while (in.good())
        {
            lineNumber++;
            std::string line;
            std::getline(in, line);

            // read line error
            if (!in.good() && !in.eof())
                throw ConfigException(Acore::StringFormat("> Config::LoadFile: Failure to read line number {} in file '{}'", lineNumber, file));

            // remove whitespace in line
            line = Acore::String::Trim(line, in.getloc());

            if (line.empty())
                continue;

            // comments and headers
            if (line[0] == '#' || line[0] == '[')
                continue;

            auto const equal_pos = line.find('=');

            if (equal_pos == std::string::npos || equal_pos == line.length())
            {
                PrintError(file, "> Config::LoadFile: Failure to read line number {} in file '{}'. Skip this line", lineNumber, file);
                continue;
            }

            auto entry = Acore::String::Trim(line.substr(0, equal_pos), in.getloc());
            auto value = Acore::String::Trim(line.substr(equal_pos + 1, std::string::npos), in.getloc());

            value.erase(std::remove(value.begin(), value.end(), '"'), value.end());

            // Skip if 2+ same options in one config file
            if (IsDuplicateOption(entry))
                continue;

            // Add to temp container
            fileConfigs.emplace(entry, value);
            count++;
        }

        // No lines read
        if (!count)
        {
            ConfigSeverity severity = isOptional ? ConfigSeverity::Skip : _policy.missingFileSeverity;
            LogWithSeverity(severity, file, "> Config::LoadFile: Empty file '{}'", file);
            // Treat SKIP as a successful no-op
            return severity == ConfigSeverity::Skip;
        }

        // Add correct keys if file load without errors
        for (auto const& [entry, key] : fileConfigs)
        {
            AddKey(entry, key, file, isOptional, isReload);
        }

        return true;
    }

    bool LoadFile(std::string const& file, bool isOptional, bool isReload)
    {
        try
        {
            return ParseFile(file, isOptional, isReload);
        }
        catch (const std::exception& e)
        {
            PrintError(file, "> {}", e.what());
        }

        return false;
    }

    // Converts ini keys to the environment variable key (upper snake case).
    // Example of conversions:
    //   SomeConfig => SOME_CONFIG
    //   myNestedConfig.opt1 => MY_NESTED_CONFIG_OPT_1
    //   LogDB.Opt.ClearTime => LOG_DB_OPT_CLEAR_TIME
    std::string IniKeyToEnvVarKey(std::string const& key)
    {
        std::string result;

        const char* str = key.c_str();
        std::size_t n = key.length();

        char curr;
        bool isEnd;
        bool nextIsUpper;
        bool currIsNumeric;
        bool nextIsNumeric;

        for (std::size_t i = 0; i < n; ++i)
        {
            curr = str[i];
            if (curr == ' ' || curr == '.' || curr == '-')
            {
                result += '_';
                continue;
            }

            isEnd = i == n - 1;
            if (!isEnd)
            {
                nextIsUpper = isupper(str[i + 1]);

                // handle "aB" to "A_B"
                if (!isupper(curr) && nextIsUpper)
                {
                    result += static_cast<char>(std::toupper(curr));
                    result += '_';
                    continue;
                }

                currIsNumeric = isNumeric(curr);
                nextIsNumeric = isNumeric(str[i + 1]);

                // handle "a1" to "a_1"
                if (!currIsNumeric && nextIsNumeric)
                {
                    result += static_cast<char>(std::toupper(curr));
                    result += '_';
                    continue;
                }

                // handle "1a" to "1_a"
                if (currIsNumeric && !nextIsNumeric)
                {
                    result += static_cast<char>(std::toupper(curr));
                    result += '_';
                    continue;
                }
            }

            result += static_cast<char>(std::toupper(curr));
        }
        return result;
    }

    std::string GetEnvVarName(std::string const& configName)
    {
        return "AC_" + IniKeyToEnvVarKey(configName);
    }

    Optional<std::string> EnvVarForIniKey(std::string const& key)
    {
        std::string envKey = GetEnvVarName(key);
        char* val = std::getenv(envKey.c_str());
        if (!val)
            return std::nullopt;

        return std::string(val);
    }
}

bool ConfigMgr::LoadInitial(std::string const& file, bool isReload /*= false*/)
{
    std::lock_guard<std::mutex> lock(_configLock);
    _configOptions.clear();
    return LoadFile(file, false, isReload);
}

bool ConfigMgr::LoadAdditionalFile(std::string file, bool isOptional /*= false*/, bool isReload /*= false*/)
{
    std::lock_guard<std::mutex> lock(_configLock);
    return LoadFile(file, isOptional, isReload);
}

ConfigMgr* ConfigMgr::instance()
{
    static ConfigMgr instance;
    return &instance;
}

bool ConfigMgr::Reload()
{
    if (!LoadAppConfigs(true))
    {
        return false;
    }

    if (!LoadModulesConfigs(true, false))
    {
        return false;
    }

    OverrideWithEnvVariablesIfAny();

    return true;
}

// Check the _envVarCache if the env var is there
// if not, check the env for the value
Optional<std::string> GetEnvFromCache(std::string const& configName, std::string const& envVarName)
{
    auto foundInCache = _envVarCache.find(envVarName);
    Optional<std::string> foundInEnv;
    // If it's not in the cache
    if (foundInCache == _envVarCache.end())
    {
        // Check the env itself
        foundInEnv = EnvVarForIniKey(configName);
        if (foundInEnv)
        {
            // If it's found in the env, put it in the cache
            _envVarCache.emplace(envVarName, *foundInEnv);
        }
        // Return the result of checking env
        return foundInEnv;
    }

    return foundInCache->second;
}

std::vector<std::string> ConfigMgr::OverrideWithEnvVariablesIfAny()
{
    std::lock_guard<std::mutex> lock(_configLock);

    std::vector<std::string> overriddenKeys;

    for (auto& itr : _configOptions)
    {
        if (itr.first.empty())
            continue;

        Optional<std::string> envVar = EnvVarForIniKey(itr.first);
        if (!envVar)
            continue;

        itr.second = *envVar;

        overriddenKeys.push_back(itr.first);
    }

    return overriddenKeys;
}

template<class T>
T ConfigMgr::GetValueDefault(std::string const& name, T const& def, bool showLogs /*= true*/) const
{
    std::string strValue;

    auto const& itr = _configOptions.find(name);
    bool notFound = itr == _configOptions.end();
    auto envVarName = GetEnvVarName(name);
    Optional<std::string> envVar = GetEnvFromCache(name, envVarName);
    if (envVar)
    {
        // If showLogs and this key/value pair wasn't found in the currently saved config
        if (showLogs && (notFound || itr->second != envVar->c_str()))
        {
            LOG_INFO("server.loading", "> Config: Found config value '{}' from environment variable '{}'.", name, envVarName );
            AddKey(name, envVar->c_str(), "ENVIRONMENT", false, false);
        }

        strValue = *envVar;
    }
    else if (notFound)
    {
        if (showLogs)
        {
            bool isCritical = _criticalConfigOptions.find(name) != _criticalConfigOptions.end();
            ConfigSeverity severity = isCritical ? _policy.criticalOptionSeverity : _policy.missingOptionSeverity;

            if (isCritical)
            {
                LogWithSeverity(severity, _filename,
                    "> Config:\n\nFATAL ERROR: Missing property {} in config file {}, add \"{} = {}\" to this file or define '{}' as an environment variable\n\nYour server cannot start without this option!",
                    name, _filename, name, Acore::ToString(def), envVarName);
            }
            else
            {
                std::string configs = _filename;
                if (!_moduleConfigFiles.empty())
                    configs += " or module config";

                LogWithSeverity(severity, _filename,
                    "> Config: Missing property {} in config file {}, add \"{} = {}\" to this file or define '{}' as an environment variable.",
                    name, configs, name, def, envVarName);
            }
        }
        return def;
    }
    else
    {
        strValue = itr->second;
    }

    auto value = Acore::StringTo<T>(strValue);
    if (!value)
    {
        if (showLogs)
        {
            LogWithSeverity(_policy.valueErrorSeverity, _filename,
                "> Config: Bad value defined for name '{}', going to use '{}' instead",
                name, Acore::ToString(def));
        }

        return def;
    }

    return *value;
}

template<>
std::string ConfigMgr::GetValueDefault<std::string>(std::string const& name, std::string const& def, bool showLogs /*= true*/) const
{
    auto const& itr = _configOptions.find(name);
    bool notFound = itr == _configOptions.end();
    auto envVarName = GetEnvVarName(name);
    Optional<std::string> envVar = GetEnvFromCache(name, envVarName);
    if (envVar)
    {
        // If showLogs and this key/value pair wasn't found in the currently saved config
        if (showLogs && (notFound || itr->second != envVar->c_str()))
        {
            LOG_INFO("server.loading", "> Config: Found config value '{}' from environment variable '{}'.", name, envVarName);
            AddKey(name, *envVar, "ENVIRONMENT", false, false);
        }

        return *envVar;
    }
    else if (notFound)
    {
        if (showLogs)
        {
            bool isCritical = _criticalConfigOptions.find(name) != _criticalConfigOptions.end();
            ConfigSeverity severity = isCritical ? _policy.criticalOptionSeverity : _policy.missingOptionSeverity;

            if (isCritical)
            {
                LogWithSeverity(severity, _filename,
                    "> Config:\n\nFATAL ERROR: Missing property {} in config file {}, add \"{} = {}\" to this file or define '{}' as an environment variable.\n\nYour server cannot start without this option!",
                    name, _filename, name, def, envVarName);
            }
            else
            {
                std::string configs = _filename;
                if (!_moduleConfigFiles.empty())
                    configs += " or module config";

                LogWithSeverity(severity, _filename,
                    "> Config: Missing property {} in config file {}, add \"{} = {}\" to this file or define '{}' as an environment variable.",
                    name, configs, name, def, envVarName);
            }
        }

        return def;
    }

    return itr->second;
}

template<class T>
T ConfigMgr::GetOption(std::string const& name, T const& def, bool showLogs /*= true*/) const
{
    return GetValueDefault<T>(name, def, showLogs);
}

template<>
bool ConfigMgr::GetOption<bool>(std::string const& name, bool const& def, bool showLogs /*= true*/) const
{
    std::string val = GetValueDefault(name, std::string(def ? "1" : "0"), showLogs);

    auto boolVal = Acore::StringTo<bool>(val);
    if (!boolVal)
    {
        if (showLogs)
        {
            LogWithSeverity(_policy.valueErrorSeverity, _filename,
                "> Config: Bad value defined for name '{}', going to use '{}' instead",
                name, def ? "true" : "false");
        }

        return def;
    }

    return *boolVal;
}

std::vector<std::string> ConfigMgr::GetKeysByString(std::string const& name)
{
    std::lock_guard<std::mutex> lock(_configLock);

    std::vector<std::string> keys;

    for (auto const& [optionName, key] : _configOptions)
    {
        if (!optionName.compare(0, name.length(), name))
        {
            keys.emplace_back(optionName);
        }
    }

    return keys;
}

std::string const ConfigMgr::GetFilename()
{
    std::lock_guard<std::mutex> lock(_configLock);
    return _filename;
}

std::vector<std::string> const& ConfigMgr::GetArguments() const
{
    return _args;
}

std::string const ConfigMgr::GetConfigPath()
{
    std::lock_guard<std::mutex> lock(_configLock);

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    return "configs/";
#else
    return std::string(_CONF_DIR) + "/";
#endif
}

void ConfigMgr::Configure(std::string const& initFileName, std::vector<std::string> args, std::string_view modulesConfigList /*= {}*/, ConfigPolicy policy /*= {}*/)
{
    _filename = initFileName;
    _args = std::move(args);
    _policy = policy;

    if (char const* env = std::getenv("AC_CONFIG_POLICY"))
        _policy = ApplyPolicyString(_policy, env);

    _policy = ApplyPolicyFromArgs(_policy, _args);

    _additonalFiles.clear();
    _moduleConfigFiles.clear();

    // Add modules config if exist
    if (!modulesConfigList.empty())
    {
        for (auto const& itr : Acore::Tokenize(modulesConfigList, ',', false))
        {
            if (!itr.empty())
                _additonalFiles.emplace_back(itr);
        }
    }
}

bool ConfigMgr::LoadAppConfigs(bool isReload /*= false*/)
{
    // #1 - Load init config file .conf
    if (!LoadInitial(_filename, isReload))
    {
        return false;
    }

    return true;
}

bool ConfigMgr::LoadModulesConfigs(bool isReload /*= false*/, bool isNeedPrintInfo /*= true*/)
{
    if (_additonalFiles.empty())
    {
        // Send successful load if no found files
        return true;
    }

    if (isNeedPrintInfo)
    {
        LOG_INFO("server.loading", " ");
        LOG_INFO("server.loading", "Loading Modules Configuration...");
    }

    // Start loading module configs
    std::string const& moduleConfigPath = GetConfigPath() + "modules/";

    for (auto const& fileName : _additonalFiles)
    {
        bool isExistConfig = LoadAdditionalFile(moduleConfigPath + fileName, false, isReload);

        if (isExistConfig)
            _moduleConfigFiles.emplace_back(fileName);
    }

    if (isNeedPrintInfo)
    {
        if (!_moduleConfigFiles.empty())
        {
            // Print modules configurations
            LOG_INFO("server.loading", " ");
            LOG_INFO("server.loading", "Using modules configuration:");

            for (auto const& itr : _moduleConfigFiles)
            {
                LOG_INFO("server.loading", "> {}", itr);
            }
        }
        else
        {
            LOG_INFO("server.loading", "> Not found modules config files");
        }
    }

    if (isNeedPrintInfo)
    {
        LOG_INFO("server.loading", " ");
    }

    return true;
}

#define TEMPLATE_CONFIG_OPTION(__typename) \
    template __typename ConfigMgr::GetOption<__typename>(std::string const& name, __typename const& def, bool showLogs /*= true*/) const;

TEMPLATE_CONFIG_OPTION(std::string)
TEMPLATE_CONFIG_OPTION(uint8)
TEMPLATE_CONFIG_OPTION(int8)
TEMPLATE_CONFIG_OPTION(uint16)
TEMPLATE_CONFIG_OPTION(int16)
TEMPLATE_CONFIG_OPTION(uint32)
TEMPLATE_CONFIG_OPTION(int32)
TEMPLATE_CONFIG_OPTION(uint64)
TEMPLATE_CONFIG_OPTION(int64)
TEMPLATE_CONFIG_OPTION(float)

#undef TEMPLATE_CONFIG_OPTION
