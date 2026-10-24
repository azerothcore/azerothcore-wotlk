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

#ifndef VoiceChatSocketMgr_h__
#define VoiceChatSocketMgr_h__

#include "Config.h"
#include "SocketMgr.h"

class VoiceChatSocket;

class VoiceChatSocketMgr : public SocketMgr<VoiceChatSocket>
{
    typedef SocketMgr<VoiceChatSocket> BaseSocketMgr;

public:
    static VoiceChatSocketMgr& Instance()
    {
        static VoiceChatSocketMgr instance;
        return instance;
    }

    VoiceChatSocketMgr() : BaseSocketMgr(), _socketSystemSendBufferSize(-1), _tcpNoDelay(true)
    {
    }

    void Init()
    {
        if (_threads)
            return;

        _tcpNoDelay = sConfigMgr->GetOption<bool>("Network.TcpNodelay", true);
        // -1 means use default
        _socketSystemSendBufferSize = sConfigMgr->GetOption<int32>("Network.OutKBuff", -1);

        _threadCount = 1;
        _threads = std::unique_ptr<NetworkThread<VoiceChatSocket>[]>(CreateThreads());

        ASSERT(_threads);

        for (int32 i = 0; i < _threadCount; ++i)
            _threads[i].Start();
    }

    bool IsInitialized() const { return _threads != nullptr; }

    // io context of the voice network thread - sockets and the connector must
    // live on it so all their asio handlers run on that single thread
    Acore::Asio::IoContext& GetNetworkThreadIoContext()
    {
        ASSERT(_threads);
        return _threads[0].GetIoContext();
    }

    // there is no acceptor to close, so the base StopNetwork can not be used
    void Stop()
    {
        if (!_threads)
            return;

        for (int32 i = 0; i < _threadCount; ++i)
            _threads[i].Stop();

        Wait();

        _threads.reset();
        _threadCount = 0;
    }

    std::shared_ptr<VoiceChatSocket> OnSocketOpen(IoContextTcpSocket&& sock)
    {
        // set some options here
        if (_socketSystemSendBufferSize >= 0)
        {
            boost::system::error_code err;
            sock.set_option(boost::asio::socket_base::send_buffer_size(_socketSystemSendBufferSize), err);

            if (err && err != boost::system::errc::not_supported)
            {
                LOG_ERROR("network",
                    "VoiceChatSocketMgr::OnSocketOpen sock.set_option(boost::asio::socket_base::send_buffer_size) "
                    "err = {}",
                    err.message());
                return nullptr;
            }
        }

        // Set TCP_NODELAY.
        if (_tcpNoDelay)
        {
            boost::system::error_code err;
            sock.set_option(boost::asio::ip::tcp::no_delay(true), err);

            if (err)
            {
                LOG_ERROR("network",
                    "VoiceChatSocketMgr::OnSocketOpen sock.set_option(boost::asio::ip::tcp::no_delay) err = {}",
                    err.message());
                return nullptr;
            }
        }

        return BaseSocketMgr::OnSocketOpen(std::move(sock), 0);
    }

protected:
    NetworkThread<VoiceChatSocket>* CreateThreads() const override
    {
        NetworkThread<VoiceChatSocket>* threads = new NetworkThread<VoiceChatSocket>[1];
        return threads;
    }

private:
    int32 _socketSystemSendBufferSize;
    bool _tcpNoDelay;
};

#define sVoiceChatSocketMgr VoiceChatSocketMgr::Instance()

#endif
