/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "LogMessage.h"
#include "StringFormat.h"
#include "Util.h"

LogMessage::LogMessage(LogLevel _level, std::string const& _type, std::string&& _text)
    : level(_level), type(_type), text(std::forward<std::string>(_text)), mtime(time(nullptr))
{
}

LogMessage::LogMessage(LogLevel _level, std::string const& _type, std::string&& _text, std::string&& _param1)
    : level(_level), type(_type), text(std::forward<std::string>(_text)), param1(std::forward<std::string>(_param1)), mtime(time(nullptr))
{
}

std::string LogMessage::getTimeStr(time_t time)
{
    tm aTm;
    localtime_r(&time, &aTm);
    return acore::StringFormat("%04d-%02d-%02d_%02d:%02d:%02d", aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec);
}

std::string LogMessage::getTimeStr() const
{
    return getTimeStr(mtime);
}
