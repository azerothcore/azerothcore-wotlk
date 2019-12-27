/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Config.h"
#include "Errors.h"
#include "Log.h"

#include <unordered_map>
#include <string>
#include <fstream>

ConfigMgr* ConfigMgr::instance()
{
    static ConfigMgr instance;
    return &instance;
}

bool ConfigMgr::SetSource(const std::string& file)
{
    m_filename = file;

    return Reload();
}

bool ConfigMgr::Reload()
{
    std::ifstream in(m_filename, std::ifstream::in);

    if (in.fail())
        return false;

    std::unordered_map<std::string, std::string> newEntries;
    std::lock_guard<std::mutex> lock(_configLock);

    do
    {
        std::string line;
        std::getline(in, line);

        acore::ltrim(line);

        if (!line.length())
            continue;

        if (line[0] == '#' || line[0] == '[')
            continue;

        auto const equals = line.find('=');
        if (equals == std::string::npos)
            return false;

        auto const entry = acore::trim_copy(acore::toLower(line.substr(0, equals)));
        auto const value = /*boost::algorithm::trim_copy_if*/(acore::trim_copy(line.substr(equals + 1)), /*boost::algorithm::is_any_of("\"")*/);

        newEntries[entry] = value;
    }
    while (in.good());

    m_entries = std::move(newEntries);

    return true;
}

bool ConfigMgr::IsSet(const std::string& name) const
{
    auto const nameLower = acore::toLower(name);
    return m_entries.find(nameLower) != m_entries.cend();
}

const std::string ConfigMgr::GetStringDefault(const std::string& name, const std::string& def) const
{
    auto const nameLower = acore::toLower(name);

    auto const entry = m_entries.find(nameLower);

    return entry == m_entries.cend() ? def : entry->second;
}

bool ConfigMgr::GetBoolDefault(const std::string& name, bool def) const
{
    auto const value = GetStringDefault(name, def ? "true" : "false");

    std::string valueLower;
    std::transform(value.cbegin(), value.cend(), std::back_inserter(valueLower), ::tolower);

    return valueLower == "true" || valueLower == "1" || valueLower == "yes";
}

int32 ConfigMgr::GetIntDefault(const std::string& name, int32 def) const
{
    auto const value = GetStringDefault(name, std::to_string(def));

    return std::stoi(value);
}

float ConfigMgr::GetFloatDefault(const std::string& name, float def) const
{
    auto const value = GetStringDefault(name, std::to_string(def));

    return std::stof(value);
}
