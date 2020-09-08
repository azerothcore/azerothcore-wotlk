/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/// \addtogroup Trinityd
/// @{
/// \file

#ifndef _RASOCKET_H
#define _RASOCKET_H

#include "Common.h"

#include <ace/Synch_Traits.h>
#include <ace/Svc_Handler.h>
#include <ace/SOCK_Stream.h>
#include <ace/SOCK_Acceptor.h>
#include <atomic>

/// Remote Administration socket
class RASocket : public ACE_Svc_Handler<ACE_SOCK_STREAM, ACE_MT_SYNCH>
{
    public:
        RASocket();
        virtual ~RASocket() { }

        virtual int svc();
        virtual int open(void* = 0);
        virtual int handle_close(ACE_HANDLE = ACE_INVALID_HANDLE, ACE_Reactor_Mask = ACE_Event_Handler::ALL_EVENTS_MASK);

    private:
        int recv_line(std::string& outLine);
        int recv_line(ACE_Message_Block& buffer);
        int process_command(const std::string& command);
        int authenticate();
        int subnegotiate();     ///< Used by telnet protocol RFC 854 / 855
        int check_access_level(const std::string& user);
        int check_password(const std::string& user, const std::string& pass);
        int send(const std::string& line);

        static void zprint(void* callbackArg, const char* szText);
        static void commandFinished(void* callbackArg, bool success);

    private:
        uint8 _minLevel; ///< Minimum security level required to connect
        std::atomic_long _commandExecuting;
};

#endif

/// @}
