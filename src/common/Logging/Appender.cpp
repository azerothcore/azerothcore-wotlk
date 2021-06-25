/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "Appender.h"
#include "LogMessage.h"
#include "StringFormat.h"
#include <sstream>

Appender::Appender(uint8 _id, std::string const& _name, LogLevel _level /* = LOG_LEVEL_DISABLED */, AppenderFlags _flags /* = APPENDER_FLAGS_NONE */):
    id(_id), name(_name), level(_level), flags(_flags) { }

Appender::~Appender() { }

uint8 Appender::getId() const
{
    return id;
}

std::string const& Appender::getName() const
{
    return name;
}

LogLevel Appender::getLogLevel() const
{
    return level;
}

AppenderFlags Appender::getFlags() const
{
    return flags;
}

void Appender::setLogLevel(LogLevel _level)
{
    level = _level;
}

void Appender::write(LogMessage* message)
{
    if (!level || level < message->level)
    {
        return;
    }

    std::ostringstream ss;

    if (flags & APPENDER_FLAGS_PREFIX_TIMESTAMP)
    {
        ss << message->getTimeStr() << ' ';
    }

    if (flags & APPENDER_FLAGS_PREFIX_LOGLEVEL)
    {
        ss << Acore::StringFormat("%-5s ", Appender::getLogLevelString(message->level));
    }

    if (flags & APPENDER_FLAGS_PREFIX_LOGFILTERTYPE)
    {
        ss << '[' << message->type << "] ";
    }

    message->prefix = ss.str();
    _write(message);
}

char const* Appender::getLogLevelString(LogLevel level)
{
    switch (level)
    {
        case LOG_LEVEL_FATAL:
            return "FATAL";
        case LOG_LEVEL_ERROR:
            return "ERROR";
        case LOG_LEVEL_WARN:
            return "WARN";
        case LOG_LEVEL_INFO:
            return "INFO";
        case LOG_LEVEL_DEBUG:
            return "DEBUG";
        case LOG_LEVEL_TRACE:
            return "TRACE";
        default:
            return "DISABLED";
    }
}
