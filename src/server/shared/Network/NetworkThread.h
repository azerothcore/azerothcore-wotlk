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

#ifndef NetworkThread_h__
#define NetworkThread_h__

#include "DeadlineTimer.h"
#include "Define.h"
#include "Errors.h"
#include "IoContext.h"
#include "Log.h"
#include "Socket.h"
#include "Timer.h"
#include <atomic>
#include <boost/asio/ip/tcp.hpp>
#include <chrono>
#include <memory>
#include <mutex>
#include <set>
#include <thread>

using boost::asio::ip::tcp;

template<class SocketType>
class NetworkThread
{
public:
    NetworkThread() :
        _ioContext(1), _acceptSocket(_ioContext), _updateTimer(_ioContext), _proxyHeaderReadingEnabled(false) { }

    virtual ~NetworkThread()
    {
        Stop();

        if (_thread)
        {
            Wait();
        }
    }

    void Stop()
    {
        _stopped = true;
        _ioContext.stop();
    }

    bool Start()
    {
        if (_thread)
            return false;

        _thread = std::make_unique<std::thread>([this]() { NetworkThread::Run(); });
        return true;
    }

    void Wait()
    {
        ASSERT(_thread);

        if (_thread->joinable())
        {
            _thread->join();
        }

        _thread.reset();
    }

    [[nodiscard]] int32 GetConnectionCount() const
    {
        return _connections;
    }

    virtual void AddSocket(std::shared_ptr<SocketType> sock)
    {
        std::lock_guard<std::mutex> lock(_newSocketsLock);

        ++_connections;
        _newSockets.emplace_back(sock);
        SocketAdded(sock);
    }

    tcp::socket* GetSocketForAccept() { return &_acceptSocket; }

    void EnableProxyProtocol() { _proxyHeaderReadingEnabled = true; }

protected:
    virtual void SocketAdded(std::shared_ptr<SocketType> /*sock*/) { }
    virtual void SocketRemoved(std::shared_ptr<SocketType> /*sock*/) { }

    void AddNewSockets()
    {
        std::lock_guard<std::mutex> lock(_newSocketsLock);

        if (_newSockets.empty())
            return;

        if (!_proxyHeaderReadingEnabled)
        {
            for (std::shared_ptr<SocketType> sock : _newSockets)
            {
                if (!sock->IsOpen())
                {
                    SocketRemoved(sock);
                    --_connections;
                    continue;
                }

                _sockets.emplace_back(sock);

                sock->Start();
            }

            _newSockets.clear();
        }
        else
        {
            HandleNewSocketsProxyReadingOnConnect();
        }
    }

    void HandleNewSocketsProxyReadingOnConnect()
    {
        size_t index = 0;
        std::vector<int> newSocketsToRemoveIndexes;
        for (auto sock_iter = _newSockets.begin(); sock_iter != _newSockets.end(); ++sock_iter, ++index)
        {
            std::shared_ptr<SocketType> sock = *sock_iter;

            if (!sock->IsOpen())
            {
                newSocketsToRemoveIndexes.emplace_back(index);
                SocketRemoved(sock);
                --_connections;
                continue;
            }

            const auto proxyHeaderReadingState = sock->GetProxyHeaderReadingState();
            if (proxyHeaderReadingState == PROXY_HEADER_READING_STATE_STARTED)
                continue;

            switch (proxyHeaderReadingState) {
                case PROXY_HEADER_READING_STATE_NOT_STARTED:
                    sock->AsyncReadProxyHeader();
                    break;

                case PROXY_HEADER_READING_STATE_FINISHED:
                    newSocketsToRemoveIndexes.emplace_back(index);
                    _sockets.emplace_back(sock);

                    sock->Start();

                    break;

                default:
                    newSocketsToRemoveIndexes.emplace_back(index);
                    SocketRemoved(sock);
                    --_connections;
                    break;
            }
        }

        for (auto it = newSocketsToRemoveIndexes.rbegin(); it != newSocketsToRemoveIndexes.rend(); ++it)
            _newSockets.erase(_newSockets.begin() + *it);
    }

    void Run()
    {
        LOG_DEBUG("misc", "Network Thread Starting");

        _updateTimer.expires_from_now(boost::posix_time::milliseconds(1));
        _updateTimer.async_wait([this](boost::system::error_code const&) { Update(); });
        _ioContext.run();

        LOG_DEBUG("misc", "Network Thread exits");
        _newSockets.clear();
        _sockets.clear();
    }

    void Update()
    {
        if (_stopped)
            return;

        _updateTimer.expires_from_now(boost::posix_time::milliseconds(1));
        _updateTimer.async_wait([this](boost::system::error_code const&) { Update(); });

        AddNewSockets();

        _sockets.erase(std::remove_if(_sockets.begin(), _sockets.end(), [this](std::shared_ptr<SocketType> sock)
        {
            if (!sock->Update())
            {
                if (sock->IsOpen())
                    sock->CloseSocket();

                this->SocketRemoved(sock);

                --this->_connections;
                return true;
            }

            return false;
        }), _sockets.end());
    }

private:
    using SocketContainer = std::vector<std::shared_ptr<SocketType>>;

    std::atomic<int32> _connections{};
    std::atomic<bool> _stopped{};

    std::unique_ptr<std::thread> _thread;

    SocketContainer _sockets;

    std::mutex _newSocketsLock;
    SocketContainer _newSockets;

    Acore::Asio::IoContext _ioContext;
    tcp::socket _acceptSocket;
    Acore::Asio::DeadlineTimer _updateTimer;

    bool _proxyHeaderReadingEnabled;
};

#endif // NetworkThread_h__
