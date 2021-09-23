/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "BuiltInConfig.h"
#include "Config.h"
#include "GitRevision.h"

template<typename Fn>
static std::string GetStringWithDefaultValueFromFunction(
    std::string const& key, Fn getter)
{
    std::string const value = sConfigMgr->GetOption<std::string>(key, "");
    return value.empty() ? getter() : value;
}

std::string BuiltInConfig::GetCMakeCommand()
{
    return GetStringWithDefaultValueFromFunction(
        "CMakeCommand", GitRevision::GetCMakeCommand);
}

std::string BuiltInConfig::GetBuildDirectory()
{
    return GetStringWithDefaultValueFromFunction(
        "BuildDirectory", GitRevision::GetBuildDirectory);
}

std::string BuiltInConfig::GetSourceDirectory()
{
    return GetStringWithDefaultValueFromFunction(
        "SourceDirectory", GitRevision::GetSourceDirectory);
}

std::string BuiltInConfig::GetMySQLExecutable()
{
    return GetStringWithDefaultValueFromFunction(
        "MySQLExecutable", GitRevision::GetMySQLExecutable);
}
