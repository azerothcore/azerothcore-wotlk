/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef LOGGER_H
#define LOGGER_H

#include "Define.h"
#include "LogCommon.h"
#include <string>
#include <unordered_map>

class Appender;
struct LogMessage;

class Logger
{
public:
    Logger(std::string const& name, LogLevel level);

    void addAppender(uint8 type, Appender* appender);
    void delAppender(uint8 type);

    std::string const& getName() const;
    LogLevel getLogLevel() const;
    void setLogLevel(LogLevel level);
    void write(LogMessage* message) const;

private:
    std::string name;
    LogLevel level;
    std::unordered_map<uint8, Appender*> appenders;
};

#endif
