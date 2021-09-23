/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef AuthSocketMgr_h__
#define AuthSocketMgr_h__

#include "SocketMgr.h"
#include "AuthSession.h"

class AuthSocketMgr : public SocketMgr<AuthSession>
{
    typedef SocketMgr<AuthSession> BaseSocketMgr;

public:
    static AuthSocketMgr& Instance()
    {
        static AuthSocketMgr instance;
        return instance;
    }

    bool StartNetwork(Acore::Asio::IoContext& ioContext, std::string const& bindIp, uint16 port, int threadCount = 1) override
    {
        if (!BaseSocketMgr::StartNetwork(ioContext, bindIp, port, threadCount))
            return false;

        _acceptor->AsyncAcceptWithCallback<&AuthSocketMgr::OnSocketAccept>();
        return true;
    }

protected:
    NetworkThread<AuthSession>* CreateThreads() const override
    {
        return new NetworkThread<AuthSession>[1];
    }

    static void OnSocketAccept(tcp::socket&& sock, uint32 threadIndex)
    {
        Instance().OnSocketOpen(std::forward<tcp::socket>(sock), threadIndex);
    }
};

#define sAuthSocketMgr AuthSocketMgr::Instance()

#endif // AuthSocketMgr_h__
