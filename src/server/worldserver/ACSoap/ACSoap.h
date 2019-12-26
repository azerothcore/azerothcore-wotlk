/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _ACSOAP_H
#define _ACSOAP_H

#include "Define.h"
#include "AccountMgr.h"

#include <ace/Semaphore.h>
#include <ace/Task.h>
#include <Threading.h>

class ACSoapRunnable : public acore::Runnable
{
    public:
        ACSoapRunnable() : _port(0) { }

        void run();

        void SetListenArguments(const std::string& host, uint16 port)
        {
            _host = host;
            _port = port;
        }

    private:
        void process_message(ACE_Message_Block* mb);

        std::string _host;
        uint16 _port;
};

class SOAPCommand
{
    public:
        SOAPCommand(): pendingCommands(0, USYNC_THREAD, "pendingCommands"), m_success(false) {}

        ~SOAPCommand() { }

        void appendToPrintBuffer(const char* msg)
        {
            m_printBuffer += msg;
        }

        ACE_Semaphore pendingCommands;

        void setCommandSuccess(bool val)
        {
            m_success = val;
        }

        bool hasCommandSucceeded() const
        {
            return m_success;
        }

        static void print(void* callbackArg, const char* msg)
        {
            ((SOAPCommand*)callbackArg)->appendToPrintBuffer(msg);
        }

        static void commandFinished(void* callbackArg, bool success);

        bool m_success;
        std::string m_printBuffer;
};

#endif
