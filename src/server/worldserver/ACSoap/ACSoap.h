/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _ACSOAP_H
#define _ACSOAP_H

#include "Define.h"
#include <future>
#include <mutex>

void process_message(struct soap* soap_message);
void ACSoapThread(const std::string& host, uint16 port);

class SOAPCommand
{
public:
    SOAPCommand() :
        m_success(false) { }

    ~SOAPCommand() { }

    void appendToPrintBuffer(char const* msg)
    {
        m_printBuffer += msg;
    }

    void setCommandSuccess(bool val)
    {
        m_success = val;
        finishedPromise.set_value();
    }

    bool hasCommandSucceeded() const
    {
        return m_success;
    }

    static void print(void* callbackArg, char const* msg)
    {
        ((SOAPCommand*)callbackArg)->appendToPrintBuffer(msg);
    }

    static void commandFinished(void* callbackArg, bool success);

    bool m_success;
    std::string m_printBuffer;
    std::promise<void> finishedPromise;
};

#endif
