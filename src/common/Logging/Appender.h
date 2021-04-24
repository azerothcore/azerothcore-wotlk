/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef APPENDER_H
#define APPENDER_H

#include "Define.h"
#include "LogCommon.h"
#include <stdexcept>
#include <string>
#include <vector>

struct LogMessage;

class Appender
{
public:
    Appender(uint8 _id, std::string const& name, LogLevel level = LOG_LEVEL_DISABLED, AppenderFlags flags = APPENDER_FLAGS_NONE);
    virtual ~Appender();

    uint8 getId() const;
    std::string const& getName() const;
    virtual AppenderType getType() const = 0;
    LogLevel getLogLevel() const;
    AppenderFlags getFlags() const;

    void setLogLevel(LogLevel);
    void write(LogMessage* message);
    static char const* getLogLevelString(LogLevel level);
    virtual void setRealmId(uint32 /*realmId*/) { }

private:
    virtual void _write(LogMessage const* /*message*/) = 0;

    uint8 id;
    std::string name;
    LogLevel level;
    AppenderFlags flags;
};

class InvalidAppenderArgsException : public std::length_error
{
public:
    explicit InvalidAppenderArgsException(std::string const& message) : std::length_error(message) { }
};

#endif
