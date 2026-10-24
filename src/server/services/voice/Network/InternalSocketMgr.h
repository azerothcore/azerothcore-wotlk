/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef InternalSocketMgr_h_
#define InternalSocketMgr_h_

#include "InternalSession.h"
#include "SocketMgr.h"

class InternalSocketMgr : public SocketMgr<InternalSession>
{
    typedef SocketMgr<InternalSession> BaseSocketMgr;

public:
    static InternalSocketMgr& Instance()
    {
        static InternalSocketMgr instance;
        return instance;
    }

    bool StartNetwork(Acore::Asio::IoContext& ioContext, std::string const& bindIp, uint16 port,
        int threadCount = 1) override
    {
        if (!BaseSocketMgr::StartNetwork(ioContext, bindIp, port, threadCount))
            return false;

        _acceptor->AsyncAcceptWithCallback<&InternalSocketMgr::OnSocketAccept>();
        return true;
    }

protected:
    NetworkThread<InternalSession>* CreateThreads() const override
    {
        NetworkThread<InternalSession>* threads = new NetworkThread<InternalSession>[1];
        return threads;
    }

    static void OnSocketAccept(IoContextTcpSocket&& sock, uint32 threadIndex)
    {
        Instance().OnSocketOpen(std::move(sock), threadIndex);
    }
};

#define sInternalSocketMgr InternalSocketMgr::Instance()

#endif
