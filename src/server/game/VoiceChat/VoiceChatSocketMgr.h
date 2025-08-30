/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef VoiceChatSocketMgr_h__
#define VoiceChatSocketMgr_h__

// #include "VoiceChatSocket.h"
#include "Config.h"
#include "SocketMgr.h"
#include "VoiceChatSocket.h"

class VoiceChatSocketMgr : public SocketMgr<VoiceChatSocket>
{
    typedef SocketMgr<VoiceChatSocket> BaseSocketMgr;

public:
    static VoiceChatSocketMgr& Instance()
    {
        static VoiceChatSocketMgr instance;
        return instance;
    }

    bool StartNetwork(Acore::Asio::IoContext& ioContext, std::string const& bindIp, uint16 port, int threadCount = 1) override
    {
        if (!BaseSocketMgr::StartNetwork(ioContext, bindIp, port, threadCount))
            return false;

        _acceptor->AsyncAcceptWithCallback<&VoiceChatSocketMgr::OnSocketAccept>();
        return true;
    }

protected:
    NetworkThread<VoiceChatSocket>* CreateThreads() const override
    {
        NetworkThread<VoiceChatSocket>* threads = new NetworkThread<VoiceChatSocket>[1];
        return threads;
    }

    static void OnSocketAccept(tcp::socket&& sock, uint32 threadIndex)
    {
        Instance().OnSocketOpen(std::forward<tcp::socket>(sock), threadIndex);
    }
};

#define sVoiceChatSocketMgr VoiceChatSocketMgr::Instance()

#endif
