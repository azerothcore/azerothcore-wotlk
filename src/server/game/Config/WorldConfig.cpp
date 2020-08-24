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

void WorldConfig::AddBoolOption(std::string const& optionName, bool value /*= false*/)
{
    auto const& itr = _boolOptions.find(optionName);
    if (itr != _boolOptions.end())
    {
        sLog->Error("> Bool option (%s) is exist!", optionName.c_str());
        return;
    }

    _boolOptions.insert(std::make_pair(optionName, value));
}

void WorldConfig::AddIntOption(std::string const& optionName, int32 value /*= 0*/)
{
    auto const& itr = _intOptions.find(optionName);
    if (itr != _intOptions.end())
    {
        sLog->Error("> Int option (%s) is exist!", optionName.c_str());
        return;
    }

    _intOptions.insert(std::make_pair(optionName, value));
}

void WorldConfig::AddFloatOption(std::string const& optionName, float value /*= 1.0f*/)
{
    auto const& itr = _floatOptions.find(optionName);
    if (itr != _floatOptions.end())
    {
        sLog->Error("> Float option (%s) is exist!", optionName.c_str());
        return;
    }

    _floatOptions.insert(std::make_pair(optionName, value));
}

void WorldConfig::AddStringOption(std::string const& optionName, std::string const& value /*= ""*/)
{
    auto const& itr = _stringOptions.find(optionName);
    if (itr != _stringOptions.end())
    {
        sLog->Error("> Int option (%s) is exist!", optionName.c_str());
        return;
    }

    _stringOptions.insert(std::make_pair(optionName, value));
}

void WorldConfig::AddOption(std::string const& optionName, WorldConfigType type, std::string const& value, std::string const& defaultValue)
{
    switch (type)
    {
    case WorldConfigType::GAME_CONFIG_TYPE_BOOL:
        AddBoolOption(optionName, value.empty() ? StringToBool(defaultValue) : StringToBool(value));
        break;
    case WorldConfigType::GAME_CONFIG_TYPE_INT:
        AddIntOption(optionName, value.empty() ? std::stoi(defaultValue) : std::stoi(value));
        break;
    case WorldConfigType::GAME_CONFIG_TYPE_FLOAT:
        AddFloatOption(optionName, value.empty() ? std::stof(defaultValue) : std::stof(value));
        break;
    case WorldConfigType::GAME_CONFIG_TYPE_STRING:
        AddStringOption(optionName, value.empty() ? defaultValue : value);
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
        TC_LOG_WARN(">> Loaded 0 game config options. DB table `game_config` is empty.");
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

        std::string const& optionName = fields[0].GetString();
        std::string const& optionType = fields[1].GetString();
        std::string const& defaultValue = fields[2].GetString();
        std::string const& customValue = fields[3].GetString();

        auto _type = GetTypeString(optionType);

        if (_type == WorldConfigType::GAME_CONFIG_TYPE_UNKNOWN)
        {
            sLog->Error("> Don't support type (%s) for option (%s)", optionType.c_str(), optionName.c_str());
            continue;
        }

        AddOption(optionName, _type, customValue, defaultValue);

        count++;

    } while (result->NextRow());

    TC_LOG_INFO(">> Loaded %u game config option in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}

bool WorldConfig::GetBoolConfig(std::string const& optionName)
{
    auto const& itr = _boolOptions.find(optionName);
    if (itr == _boolOptions.end())
    {
        sLog->Error("> Bool option (%s) not found!", optionName.c_str());
        return false;
    }

    return _boolOptions[optionName];
}

int32 WorldConfig::GetIntConfig(std::string const& optionName)
{
    auto const& itr = _intOptions.find(optionName);
    if (itr == _intOptions.end())
    {
        sLog->Error("> Int option (%s) not found!", optionName.c_str());
        return 0;
    }

    return _intOptions[optionName];
}

float WorldConfig::GetFloatConfig(std::string const& optionName)
{
    auto const& itr = _floatOptions.find(optionName);
    if (itr == _floatOptions.end())
    {
        sLog->Error("> Float option (%s) not found!", optionName.c_str());
        return 1.0f;
    }

    return _floatOptions[optionName];
}

std::string WorldConfig::GetStringConfig(std::string const& optionName)
{
    auto const& itr = _stringOptions.find(optionName);
    if (itr == _stringOptions.end())
    {
        sLog->Error("> String option (%s) not found!", optionName.c_str());
        return "";
    }

    return _stringOptions[optionName];
}
