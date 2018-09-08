/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Config.h"
#include "Errors.h"
#include "Log.h"

// Defined here as it must not be exposed to end-users.
bool ConfigMgr::GetValueHelper(const char* name, ACE_TString &result)
{
    GuardType guard(_configLock);

    if (_config.get() == 0)
        return false;

    ACE_TString section_name;
    ACE_Configuration_Section_Key section_key;
    const ACE_Configuration_Section_Key &root_key = _config->root_section();

    int i = 0;
    while (_config->enumerate_sections(root_key, i, section_name) == 0)
    {
        _config->open_section(root_key, section_name.c_str(), 0, section_key);
        if (_config->get_string_value(section_key, name, result) == 0)
            return true;
        ++i;
    }

    return false;
}

bool ConfigMgr::LoadInitial(char const* file)
{
    ASSERT(file);

    GuardType guard(_configLock);

    _config.reset(new ACE_Configuration_Heap());
    if (_config->open() == 0)
        if (LoadData(file))
            return true;

    _config.reset();
    return false;
}

bool ConfigMgr::LoadMore(char const* file)
{
    ASSERT(file);
    ASSERT(_config);

    GuardType guard(_configLock);

    return LoadData(file);
}

bool ConfigMgr::Reload()
{
    for(std::vector<std::string>::iterator it = _confFiles.begin(); it != _confFiles.end(); ++it) {
        if (it==_confFiles.begin()) {
            if (!LoadInitial((*it).c_str()))
                return false;
        } else {
            LoadMore((*it).c_str());
        }
    }

    return true;
}

bool ConfigMgr::LoadData(char const* file)
{
    if(std::find(_confFiles.begin(), _confFiles.end(), file) == _confFiles.end()) {
        _confFiles.push_back(file);
    }

    ACE_Ini_ImpExp config_importer(*_config.get());
    if (config_importer.import_config(file) == 0)
        return true;

    return false;
}

std::string ConfigMgr::GetStringDefault(const char* name, const std::string &def, bool logUnused /*= true*/)
{
    ACE_TString val;

    if (GetValueHelper(name, val))
        return val.c_str();
    else
    {
        if (logUnused)
            sLog->outError("-> Not found option '%s'. The default value is used (%s)", name, def.c_str());
        return def;
    }
}

bool ConfigMgr::GetBoolDefault(const char* name, bool def, bool logUnused /*= true*/)
{
    ACE_TString val;

    if (!GetValueHelper(name, val))
    {
        if (logUnused)
            def ? sLog->outError("-> Not found option '%s'. The default value is used (Yes)", name) : sLog->outError("-> Not found option '%s'. The default value is used (No)", name);
        return def;
    }

    return (val == "true" || val == "TRUE" || val == "yes" || val == "YES" ||
        val == "1");
}

int ConfigMgr::GetIntDefault(const char* name, int def, bool logUnused /*= true*/)
{
    ACE_TString val;

    if (GetValueHelper(name, val))
        return atoi(val.c_str());
    else
    {
        if (logUnused)
            sLog->outError("-> Not found option '%s'. The default value is used (%i)", name, def);
        return def;
    }
}

float ConfigMgr::GetFloatDefault(const char* name, float def, bool logUnused /*= true*/)
{
    ACE_TString val;

    if (GetValueHelper(name, val))
        return (float)atof(val.c_str());
    else
    {
        if (logUnused)
            sLog->outError("-> Not found option '%s'. The default value is used (%f)", name, def);
        return def;
    }
}

std::list<std::string> ConfigMgr::GetKeysByString(std::string const& name)
{
    GuardType guard(_configLock);

    std::list<std::string> keys;
    if (_config.get() == 0)
        return keys;

    ACE_TString section_name;
    ACE_Configuration_Section_Key section_key;
    const ACE_Configuration_Section_Key &root_key = _config->root_section();

    int i = 0;
    while (_config->enumerate_sections(root_key, i++, section_name) == 0)
    {
        _config->open_section(root_key, section_name.c_str(), 0, section_key);

        ACE_TString key_name;
        ACE_Configuration::VALUETYPE type;
        int j = 0;
        while (_config->enumerate_values(section_key, j++, key_name, type) == 0)
        {
            std::string temp = key_name.c_str();

            if (!temp.find(name))
                keys.push_back(temp);
        }
    }

    return keys;
}
