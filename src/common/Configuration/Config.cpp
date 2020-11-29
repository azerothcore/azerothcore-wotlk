/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Config.h"
#include "Errors.h"
#include "Log.h"
#include "Util.h"

#include <memory>
#include <mutex>
#include <fstream>
#include <unordered_map>
#include <string>
#include <algorithm>
#include <sstream>

namespace
{
    using config_container = std::unordered_map<std::string, std::string>;

    config_container _config;
    std::vector<std::string> _modulesConfigFiles;
    std::string _initConfigFile;
    std::mutex _configMutex;

    void tolower(std::string& in)
    {
        std::transform(in.begin(), in.end(), in.begin(),
            [](unsigned char c) { return std::tolower(c); });
    }

    // taken from https://stackoverflow.com/a/1798170
    std::string trim(const std::string& str,
                     const std::string& whitespace = " \t")
    {
        const auto strBegin = str.find_first_not_of(whitespace);
        if (strBegin == std::string::npos)
            return ""; // no content

        const auto strEnd = str.find_last_not_of(whitespace);
        const auto strRange = strEnd - strBegin + 1;

        return str.substr(strBegin, strRange);
    }

    std::string reduce(const std::string& str,
                       const std::string& fill = " ",
                       const std::string& whitespace = " \t")
    {
        // trim first
        auto result = trim(str, whitespace);

        // replace sub ranges
        auto beginSpace = result.find_first_of(whitespace);
        while (beginSpace != std::string::npos)
        {
            const auto endSpace = result.find_first_not_of(whitespace, beginSpace);
            const auto range = endSpace - beginSpace;

            result.replace(beginSpace, range, fill);

            const auto newStart = beginSpace + fill.length();
            beginSpace = result.find_first_of(whitespace, newStart);
        }

        return result;
    }

    bool LoadData(std::string const& file, config_container &result)
    {
        std::ifstream in(file);

        if (in.fail())
            return false;

        while (in.good())
        {
            std::string line;
            std::getline(in, line);

            if (!line.length())
                continue;

            line = reduce(line);

            if (line[0] == '#' || line[0] == '[')
                continue;

            auto const equal_pos = line.find('=');

            if (equal_pos == std::string::npos || equal_pos == line.length())
                return false;

            auto entry = reduce(line.substr(0, equal_pos - 1));
            tolower(entry);

            auto value = reduce(line.substr(equal_pos + 1));

            if (value[0] == '"' && value[value.length() - 1] == '"')
                value = value.substr(1, value.length() - 2);
            else if ((value[0] == '"') != (value[value.length() - 1] == '"'))
                return false;

            result[entry] = value;
        }

        return true;
    }
}

ConfigMgr* ConfigMgr::instance()
{
    static ConfigMgr instance;
    return &instance;
}

bool ConfigMgr::LoadInitial(std::string const& file)
{
    ASSERT(file.c_str());

    std::lock_guard<std::mutex> lock(_configMutex);
    _config.clear();
    return LoadData(file, _config);
}

bool ConfigMgr::LoadMore(std::string const& file)
{
    ASSERT(file.c_str());

    std::lock_guard<std::mutex> guard(_configMutex);
    return LoadData(file, _config);
}

bool ConfigMgr::Reload()
{
    if (!LoadAppConfigs())
        return false;

    LoadModulesConfigs();

    return true;
}



std::string ConfigMgr::GetStringDefault(std::string const& name, const std::string& def, bool logUnused /*= true*/)
{
    std::string name_lower = name;
    tolower(name_lower);

    std::lock_guard<std::mutex> lock(_configMutex);

    auto const i = _config.find(name_lower);

    if (i != _config.end())
        return i->second;

    if (logUnused)
        sLog->outError("-> Not found option '%s'. The default value is used (%s)", name.c_str(), def.c_str());

    return def;
}

bool ConfigMgr::GetBoolDefault(std::string const& name, bool def, bool logUnused /*= true*/)
{
    auto const val = GetStringDefault(name, def ? "Yes" : "No", logUnused);
    return StringToBool(val);
}

int ConfigMgr::GetIntDefault(std::string const& name, int def, bool logUnused /*= true*/)
{
    std::stringstream str;
    str << def;
    auto const val = GetStringDefault(name, str.str(), logUnused);
    return std::stoi(val);
}

float ConfigMgr::GetFloatDefault(std::string const& name, float def, bool logUnused /*= true*/)
{
    std::stringstream str;
    str << def;
    auto const val = GetStringDefault(name, str.str(), logUnused);
    return std::stof(val);
}

void ConfigMgr::SetConfigList(std::string const& fileName, std::string const& modulesConfigList /*= ""*/)
{
    _initConfigFile = fileName;

    if (modulesConfigList.empty())
        return;

    // Clean config list before load
    _modulesConfigFiles.clear();

    Tokenizer configFileList(modulesConfigList, ',');
    for (auto const& itr : configFileList)
        _modulesConfigFiles.push_back(itr);
}

bool ConfigMgr::LoadAppConfigs(std::string const& applicationName /*= "worldserver"*/)
{
    // #1 - Load init config file .conf.dist
    if (!sConfigMgr->LoadInitial(_initConfigFile + ".dist"))
    {
        printf("Load config error. Invalid or missing dist configuration file: %s", std::string(_initConfigFile + ".dist").c_str());
        printf("Verify that the file exists and has \'[%s]' written in the top of the file!", applicationName.c_str());
        return false;
    }

    // #2 - Load .conf file
    if (!sConfigMgr->LoadMore(_initConfigFile))
    {
        sLog->outString();
        sLog->outString("Load config error. Invalid or missing configuration file: %s", _initConfigFile.c_str());
        sLog->outString("Verify that the file exists and has \'[%s]' written in the top of the file!", applicationName.c_str());
        return false;
    }

    return true;
}

bool ConfigMgr::LoadModulesConfigs()
{
    // If not modules config - load failed
    if (_modulesConfigFiles.empty())
        return false;

    // Start loading module configs
    std::unordered_map<std::string /*module name*/, std::string /*config variant*/> moduleConfigFiles;

    moduleConfigFiles.clear();

    std::string configPath = _CONF_DIR;

    for (auto const& itr : _modulesConfigFiles)
    {
        bool IsExistDefaultConfig = true;
        bool IsExistDistConfig = true;

        std::string moduleName = itr;
        std::string configFile = std::string(itr) + std::string(".conf");
        std::string defaultConfig = configPath + "/" + configFile;

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
        defaultConfig = configFile;
#endif

        std::string ConfigFileDist = defaultConfig + std::string(".dist");

        // Load .conf.dist config
        if (!sConfigMgr->LoadMore(ConfigFileDist.c_str()))
        {
            sLog->outError("> Invalid or missing dist configuration file: %s", ConfigFileDist.c_str());
            IsExistDistConfig = false;
        }

        // Load .conf config
        if (!sConfigMgr->LoadMore(defaultConfig.c_str()))
            IsExistDefaultConfig = false;

        // #1 - Not exist .conf and exist .conf.dist
        if (!IsExistDefaultConfig && IsExistDistConfig)
            moduleConfigFiles.insert(std::make_pair(moduleName, ConfigFileDist));
        else if (!IsExistDefaultConfig && !IsExistDistConfig) // #2 - Not exist .conf and not exist .conf.dist
            moduleConfigFiles.insert(std::make_pair(moduleName, "default hardcoded settings"));
        else if (IsExistDefaultConfig && IsExistDistConfig)
            moduleConfigFiles.insert(std::make_pair(moduleName, defaultConfig));
    }

    // If module configs not exist - no load
    if (moduleConfigFiles.empty())
        return false;

    // Print modules configurations
    sLog->outString();
    sLog->outString("Using configuration for modules:");

    for (auto const& itr : moduleConfigFiles)
        sLog->outString("> Module (%s) using (%s)", itr.first.c_str(), itr.second.c_str());

    sLog->outString();

    return true;
}
