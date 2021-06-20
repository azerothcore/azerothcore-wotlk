/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __REALMACCEPTOR_H__
#define __REALMACCEPTOR_H__

#include <ace/Acceptor.h>
#include <ace/SOCK_Acceptor.h>

#include "RealmSocket.h"
#include "AuthSocket.h"

class RealmAcceptor : public ACE_Acceptor<RealmSocket, ACE_SOCK_Acceptor>
{
public:
    RealmAcceptor(void) { }
    virtual ~RealmAcceptor(void)
    {
        if (reactor())
            reactor()->cancel_timer(this, 1);
    }

protected:
    virtual int make_svc_handler(RealmSocket* &sh)
    {
        if (sh == 0)
            ACE_NEW_RETURN(sh, RealmSocket, -1);

        sh->reactor(reactor());
        sh->set_session(new AuthSocket(*sh));
        return 0;
    }

    virtual int handle_timeout(const ACE_Time_Value& /*current_time*/, const void* /*act = 0*/)
    {
        sLog->outBasic("Resuming acceptor");
        reactor()->cancel_timer(this, 1);
        return reactor()->register_handler(this, ACE_Event_Handler::ACCEPT_MASK);
    }

    virtual int handle_accept_error(void)
    {
#if defined(ENFILE) && defined(EMFILE)
        if (errno == ENFILE || errno == EMFILE)
        {
            sLog->outError("Out of file descriptors, suspending incoming connections for 10 seconds");
            reactor()->remove_handler(this, ACE_Event_Handler::ACCEPT_MASK | ACE_Event_Handler::DONT_CALL);
            reactor()->schedule_timer(this, NULL, ACE_Time_Value(10));
        }
#endif
        return 0;
    }
};

#endif
