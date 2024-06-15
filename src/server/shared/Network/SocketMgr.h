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

#ifndef SocketMgr_h__
#define SocketMgr_h__

#include "AsyncAcceptor.h"
#include "Errors.h"
#include "NetworkThread.h"
#include <boost/asio/ip/tcp.hpp>
#include <memory>

using boost::asio::ip::tcp;

template<class SocketType>
class SocketMgr
{
public:
    virtual ~SocketMgr()
    {
        ASSERT(!_threads && !_acceptor && !_threadCount, "StopNetwork must be called prior to SocketMgr destruction");
    }

    virtual bool StartNetwork(Acore::Asio::IoContext& ioContext, std::string const& bindIp, uint16 port, int threadCount)
    {
        ASSERT(threadCount > 0);

        std::unique_ptr<AsyncAcceptor> acceptor;
        try
        {
            acceptor = std::make_unique<AsyncAcceptor>(ioContext, bindIp, port);
        }
        catch (boost::system::system_error const& err)
        {
            LOG_ERROR("network", "Exception caught in SocketMgr.StartNetwork ({}:{}): {}", bindIp, port, err.what());
            return false;
        }

        if (!acceptor->Bind())
        {
            LOG_ERROR("network", "StartNetwork failed to bind socket acceptor");
            return false;
        }

        _acceptor = std::move(acceptor);
        _threadCount = threadCount;
        _threads = std::unique_ptr<NetworkThread<SocketType>[]>(CreateThreads());

        ASSERT(_threads);

        for (int32 i = 0; i < _threadCount; ++i)
            _threads[i].Start();

        _acceptor->SetSocketFactory([this]() { return GetSocketForAccept(); });
        return true;
    }

    virtual void StopNetwork()
    {
        _acceptor->Close();

        for (int32 i = 0; i < _threadCount; ++i)
            _threads[i].Stop();

        Wait();

        _acceptor.reset();
        _threads.reset();
        _threadCount = 0;
    }

    void Wait()
    {
        for (int32 i = 0; i < _threadCount; ++i)
            _threads[i].Wait();
    }

    virtual void OnSocketOpen(tcp::socket&& sock, uint32 threadIndex)
    {
        try
        {
            std::shared_ptr<SocketType> newSocket = std::make_shared<SocketType>(std::move(sock));
            _threads[threadIndex].AddSocket(newSocket);
        }
        catch (boost::system::system_error const& err)
        {
            LOG_WARN("network", "Failed to retrieve client's remote address {}", err.what());
        }
    }

    [[nodiscard]] int32 GetNetworkThreadCount() const { return _threadCount; }

    [[nodiscard]] uint32 SelectThreadWithMinConnections() const
    {
        uint32 min = 0;

        for (int32 i = 1; i < _threadCount; ++i)
            if (_threads[i].GetConnectionCount() < _threads[min].GetConnectionCount())
                min = i;

        return min;
    }

    std::pair<tcp::socket*, uint32> GetSocketForAccept()
    {
        uint32 threadIndex = SelectThreadWithMinConnections();
        return { _threads[threadIndex].GetSocketForAccept(), threadIndex };
    }

protected:
    SocketMgr() = default;

    virtual NetworkThread<SocketType>* CreateThreads() const = 0;

    std::unique_ptr<AsyncAcceptor> _acceptor;
    std::unique_ptr<NetworkThread<SocketType>[]> _threads;
    int32 _threadCount{};
};

#endif // SocketMgr_h__
