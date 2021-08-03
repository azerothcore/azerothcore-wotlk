/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef LOGOPERATION_H
#define LOGOPERATION_H

#include "Define.h"
#include <memory>

class Logger;
struct LogMessage;

class LogOperation
{
public:
    LogOperation(Logger const* _logger, std::unique_ptr<LogMessage>&& _msg);

    ~LogOperation();

    int call();

protected:
    Logger const* logger;
    std::unique_ptr<LogMessage> msg;
};

#endif
