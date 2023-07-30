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

#include "Config.h"
#include "Define.h"
#include "Log.h"
#include "StringConvert.h"
#include "StringFormat.h"
#include "Tokenize.h"
#include "Util.h"
#include "fmt/core.h"
#include <algorithm>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <mutex>
#include <numeric>
#include <regex>
#include <set>
#include <string>
#include <unordered_map>
#include <boost/algorithm/string/join.hpp>

namespace fs = std::filesystem;

namespace
{
    std::string _filename;
    std::vector<std::string> _additionalFiles;
    std::vector<std::string> _args;
    std::unordered_map<std::string /*name*/, std::string /*value*/> _configOptions;
    std::mutex _configLock;

    template<typename Format, typename... Args>
    inline void PrintError(std::string_view filename, Format&& fmt, Args&& ... args)
    {
        std::string message = Acore::StringFormatFmt(std::forward<Format>(fmt), std::forward<Args>(args)...);
        fmt::print("Error parsing config file {}: {}\n", filename, message);
    }

    void AddKey(std::string const& optionKey, std::string const& optionValue)
    {
        // Check if key is in the options already
        auto const& itr = _configOptions.find(optionKey);

        std::cout << optionKey << " = " << optionValue << "\n";

        // Clear option if it was defined at a later point in time
        if (itr != _configOptions.end())
        {
            _configOptions.erase(optionKey);
        }

        _configOptions.emplace(optionKey, optionValue);
    }

    bool ParseDirectory(std::string const& dir, bool isOptional, bool isReload, std::set<std::string> configFiles = {});
    bool ParseFile(std::string const& file, bool isOptional, bool isReload, std::set<std::string> configFiles = {})
    {
        fs::path filePath(file);
        if (!fs::exists(filePath))
        {
            throw ConfigException(Acore::StringFormatFmt("Config::ParseFile: '{}' does not exist", file));
        }

        if (!fs::is_regular_file(filePath))
        {
            throw ConfigException(Acore::StringFormatFmt("Config::ParseFile: '{}' is not a file", file));
        }

        // Exit early if the file is empty
        if (fs::is_empty(filePath))
        {
            return false;
        }

        std::ifstream in(file);

        // Values are taken until there's a # or end of line
        const std::regex parameter_regex("^\\s*([a-zA-Z0-9\\.]+)\\s*=\\s*([^#\\n]+)(?:#[^\\n]*)?$");
        // include will parse values from another file
        const std::regex include_regex("^\\s*include\\s+([^#\\n]+)(?:#[\\h\\S]*)?$");
        // includedir will include values from files in a directory
        const std::regex include_dir_regex("^\\s*includedir\\s+([^#\\n]+)(?:#[\\h\\S]*)?$");

        std::smatch match;

        // Keep track of configs in this specific file.
        // Duplicate values will be skipped
        std::set<std::string> fileConfigs;

        std::string absPath = fs::absolute(filePath).string();
        auto pathInsert = configFiles.insert(absPath);

        // Cyclic include check
        if (!pathInsert.second)
        {
            std::string lineage = boost::algorithm::join(configFiles, " => ");
            throw ConfigException(Acore::StringFormatFmt("Config::LoadFile: Cyclic include statements found\n  files: {}", lineage));
        }

        std::cout << "Parsing config file: " << absPath << "\n";
        if (in.fail())
        {
            if (isOptional)
            {
                // No display error if file optional
                return false;
            }

            throw ConfigException(Acore::StringFormatFmt("Config::LoadFile: Failed to open {}file '{}'", isOptional ? "optional " : "", file));
        }

        uint32 count = 0;
        uint32 lineNumber = 0;

        // return true if duplicate found for this file
        // does not find duplicates across include statements
        auto IsDuplicateOption = [&](std::string const& confOption)
        {
            auto const& itr = fileConfigs.find(confOption);
            if (itr != fileConfigs.end())
            {
                PrintError(file, "> Config::LoadFile: Duplicate key name '{}' in config file '{}'", confOption, file);
            }
            return itr != fileConfigs.end();
        };

        // Used for include statements
        // If path is absolute, return path
        // else, return path relative to filePath (the current file)
        auto GetRelative = [&](std::string const& path)
        {
            fs::path includePath(path);
            if (includePath.is_absolute())
            {
                return includePath.string();
            } else {
                return (filePath.parent_path() / path).string();
            }
        };

        while (in.good())
        {
            lineNumber++;
            std::string line;
            std::getline(in, line);

            // read line error
            if (!in.good() && !in.eof())
            {
                throw ConfigException(Acore::StringFormatFmt("> Config::LoadFile: Failure to read line number {} in file '{}'", lineNumber, file));
            }

            if (std::regex_match(line, match, parameter_regex))
            {
                if (match.size() == 3)
                {
                    std::string key = std::ssub_match(match[1]).str();
                    std::string value = std::ssub_match(match[2]).str();

                    key = Acore::String::Trim(key);
                    value = Acore::String::Trim(value);

                    // remove double quotes from config value
                    value.erase(std::remove(value.begin(), value.end(), '"'), value.end());

                    // add to fileConfigs and check if duplicate
                    auto checkDuplicate = fileConfigs.insert(key);
                    if (!checkDuplicate.second)
                    {
                        PrintError(file, "Found duplicate key '{}'. This will be skipped", key);
                        continue;
                    }
                    // add to final configs
                    AddKey(key, value);
                    // increment parameters changed
                    count++;
                }
            }

            if (std::regex_match(line, match, include_regex))
            {
                if (match.size() == 2)
                {
                    std::string includeFile = GetRelative(std::ssub_match(match[1]).str());
                    ParseFile(includeFile, isOptional, isReload, configFiles);
                }
            }
            if (std::regex_match(line, match, include_dir_regex))
            {
                if (match.size() == 2)
                {
                    std::string includeDir = GetRelative(std::ssub_match(match[1]).str());
                    ParseDirectory(includeDir, isOptional, isReload, configFiles);
                }
            }
        }

        return count > 0;
    }

    bool ParseDirectory(std::string const& dir, bool isOptional, bool isReload, std::set<std::string> configFiles)
    {
        std::vector<bool> results;
        if (!fs::is_directory(dir))
        {
            throw ConfigException(Acore::StringFormatFmt("Config::ParseDirectory: '{}' is not a directory", dir));
        }
        for (auto const& entry : fs::directory_iterator(dir))
        {
            // Only parse immediate children of the directory
            if (fs::is_regular_file(entry))
            {
                bool result = ParseFile(entry.path().string(), isOptional, isReload, configFiles);
                results.push_back(result);
            }
        }
        unsigned long returnVal = std::accumulate(results.begin(), results.end(), 0);

        // Return results of all ParseFile
        return returnVal == (results.size() - 1);
    }

    bool LoadFile(std::string const& file, bool isOptional, bool isReload)
    {
        try
        {
            if (fs::is_directory(file))
            {
                return ParseDirectory(file, isOptional, isReload);
            }
            return ParseFile(file, isOptional, isReload);
        }
        catch (const std::exception& e)
        {
            PrintError(file, "{}", e.what());
        }

        return false;
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

    return LoadModulesConfigs(true, false);
}

template<class T>
T ConfigMgr::GetValueDefault(std::string const& name, T const& def, bool showLogs /*= true*/) const
{
    auto const& itr = _configOptions.find(name);
    if (itr == _configOptions.end())
    {
        if (showLogs)
        {
            LOG_ERROR("server.loading", "> Config: Missing property {} in config file {}, add \"{} = {}\" to this file.",
                name, _filename, name, Acore::ToString(def));
        }

        return def;
    }

    auto value = Acore::StringTo<T>(itr->second);
    if (!value)
    {
        if (showLogs)
        {
            LOG_ERROR("server.loading", "> Config: Bad value defined for name '{}', going to use '{}' instead",
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
    if (itr == _configOptions.end())
    {
        if (showLogs)
        {
            LOG_ERROR("server.loading", "> Config: Missing property {} in config file {}, add \"{} = {}\" to this file.",
                name, _filename, name, def);
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
            LOG_ERROR("server.loading", "> Config: Bad value defined for name '{}', going to use '{}' instead",
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

void ConfigMgr::Configure(std::string const& initFileName, std::vector<std::string> args, std::string_view modulesConfigList /*= {}*/)
{
    _filename = initFileName;
    _args = std::move(args);

    // Add modules config if exist
    if (!modulesConfigList.empty())
    {
        for (auto const& itr : Acore::Tokenize(modulesConfigList, ',', false))
        {
            _additionalFiles.emplace_back(itr);
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
    if (_additionalFiles.empty())
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
    bool isExistDefaultConfig = true;
    bool isExistDistConfig = true;

    for (auto const& distFileName : _additionalFiles)
    {
        std::string defaultFileName = distFileName;

        if (!defaultFileName.empty())
        {
            defaultFileName.erase(defaultFileName.end() - 5, defaultFileName.end());
        }

        // Load .conf.dist config
        isExistDistConfig = LoadAdditionalFile(moduleConfigPath + distFileName, false, isReload);

        if (!isReload && !isExistDistConfig)
        {
            LOG_FATAL("server.loading", "> ConfigMgr::LoadModulesConfigs: Not found original config '{}'. Stop loading", distFileName);
            ABORT();
        }

        // Load .conf config
        isExistDefaultConfig = LoadAdditionalFile(moduleConfigPath + defaultFileName, true, isReload);

        if (isExistDefaultConfig && isExistDistConfig)
        {
            _moduleConfigFiles.emplace_back(defaultFileName);
        }
        else if (!isExistDefaultConfig && isExistDistConfig)
        {
            _moduleConfigFiles.emplace_back(distFileName);
        }
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

/// @deprecated DO NOT USE - use GetOption<std::string> instead.
std::string ConfigMgr::GetStringDefault(std::string const& name, const std::string& def, bool showLogs /*= true*/)
{
    return GetOption<std::string>(name, def, showLogs);
}

/// @deprecated DO NOT USE - use GetOption<bool> instead.
bool ConfigMgr::GetBoolDefault(std::string const& name, bool def, bool showLogs /*= true*/)
{
    return GetOption<bool>(name, def, showLogs);
}

/// @deprecated DO NOT USE - use GetOption<int32> instead.
int ConfigMgr::GetIntDefault(std::string const& name, int def, bool showLogs /*= true*/)
{
    return GetOption<int32>(name, def, showLogs);
}

/// @deprecated DO NOT USE - use GetOption<float> instead.
float ConfigMgr::GetFloatDefault(std::string const& name, float def, bool showLogs /*= true*/)
{
    return GetOption<float>(name, def, showLogs);
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
