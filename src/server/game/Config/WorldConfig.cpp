/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>
 */

#include "DatabaseEnv.h"
#include "WorldConfig.h"
#include "Log.h"
#include "Timer.h"
#include "Util.h"

WorldConfig* WorldConfig::instance()
{
    static WorldConfig instance;
    return &instance;
}

void WorldConfig::CleanAll()
{
    _boolOptions.clear();
    _intOptions.clear();
    _floatOptions.clear();
    _stringOptions.clear();
}

void WorldConfig::AddBoolOption(std::string const& configName, bool value /*= false*/)
{
    auto const& itr = _boolOptions.find(configName);
    if (itr != _boolOptions.end())
    {
        sLog->outError("> Bool option (%s) is exist!", configName.c_str());
        return;
    }

    _boolOptions.insert(std::make_pair(configName, value));
}

void WorldConfig::AddIntOption(std::string const& configName, int32 value /*= 0*/)
{
    auto const& itr = _intOptions.find(configName);
    if (itr != _intOptions.end())
    {
        sLog->outError("> Int option (%s) is exist!", configName.c_str());
        return;
    }

    _intOptions.insert(std::make_pair(configName, value));
}

void WorldConfig::AddFloatOption(std::string const& configName, float value /*= 1.0f*/)
{
    auto const& itr = _floatOptions.find(configName);
    if (itr != _floatOptions.end())
    {
        sLog->outError("> Float option (%s) is exist!", configName.c_str());
        return;
    }

    _floatOptions.insert(std::make_pair(configName, value));
}

void WorldConfig::AddStringOption(std::string const& configName, std::string const& value /*= ""*/)
{
    auto const& itr = _stringOptions.find(configName);
    if (itr != _stringOptions.end())
    {
        sLog->outError("> Int option (%s) is exist!", configName.c_str());
        return;
    }

    _stringOptions.insert(std::make_pair(configName, value));
}

void WorldConfig::AddOption(std::string const& configName, WorldConfigType type, std::string const& value, std::string const& value)
{
    switch (type)
    {
    case WorldConfigType::GAME_CONFIG_TYPE_BOOL:
        AddBoolOption(configName, value.empty() ? StringToBool(value) : StringToBool(value));
        break;
    case WorldConfigType::GAME_CONFIG_TYPE_INT:
        AddIntOption(configName, value.empty() ? std::stoi(value) : std::stoi(value));
        break;
    case WorldConfigType::GAME_CONFIG_TYPE_FLOAT:
        AddFloatOption(configName, value.empty() ? std::stof(value) : std::stof(value));
        break;
    case WorldConfigType::GAME_CONFIG_TYPE_STRING:
        AddStringOption(configName, value.empty() ? value : value);
        break;
    default:
        ABORT();
        break;
    }
}

void WorldConfig::Load()
{
    CleanAll();

    uint32 oldMSTime = getMSTime();

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAME_CONFIG);
    PreparedQueryResult result = WorldDatabase.Query(stmt);
    if (!result)
    {
        sLog->outError(">> Loaded 0 game config options. DB table `game_config` is empty.");
        return;
    }

    uint32 count = 0;

    auto GetTypeString = [](std::string optionType) -> WorldConfigType
    {
        if (optionType == "bool")
            return WorldConfigType::GAME_CONFIG_TYPE_BOOL;
        else if (optionType == "int")
            return WorldConfigType::GAME_CONFIG_TYPE_INT;
        else if (optionType == "float")
            return WorldConfigType::GAME_CONFIG_TYPE_FLOAT;
        else if (optionType == "string")
            return WorldConfigType::GAME_CONFIG_TYPE_STRING;
        else
            return WorldConfigType::GAME_CONFIG_TYPE_UNKNOWN;
    };

    do
    {
        Field* fields = result->Fetch();

        std::string const& configName = fields[1].GetString();
        std::string const& optionType = fields[2].GetString();
        std::string const& value      = fields[3].GetString();

        auto _type = GetTypeString(optionType);

        if (_type == WorldConfigType::GAME_CONFIG_TYPE_UNKNOWN)
        {
            sLog->outError("> Don't support type (%s) for option (%s)", optionType.c_str(), configName.c_str());
            continue;
        }

        AddOption(configName, _type, value);

        count++;

    } while (result->NextRow());

    sLog->outString(">> Loaded %u game config option in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}

bool WorldConfig::GetBoolConfig(std::string const& configName)
{
    auto const& itr = _boolOptions.find(configName);
    if (itr == _boolOptions.end())
    {
        sLog->outError("> Bool option (%s) not found!", configName.c_str());
        return false;
    }

    return _boolOptions[configName];
}

int32 WorldConfig::GetIntConfig(std::string const& configName)
{
    auto const& itr = _intOptions.find(configName);
    if (itr == _intOptions.end())
    {
        sLog->outError("> Int option (%s) not found!", configName.c_str());
        return 0;
    }

    return _intOptions[configName];
}

float WorldConfig::GetFloatConfig(std::string const& configName)
{
    auto const& itr = _floatOptions.find(configName);
    if (itr == _floatOptions.end())
    {
        sLog->outError("> Float option (%s) not found!", configName.c_str());
        return 1.0f;
    }

    return _floatOptions[configName];
}

std::string WorldConfig::GetStringConfig(std::string const& configName)
{
    auto const& itr = _stringOptions.find(configName);
    if (itr == _stringOptions.end())
    {
        sLog->outError("> String option (%s) not found!", configName.c_str());
        return "";
    }

    return _stringOptions[configName];
}
