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

#ifndef __ASYNCACCEPT_H_
#define __ASYNCACCEPT_H_

#include "IpAddress.h"
#include "Log.h"
#include "Socket.h"
#include "Systemd.h"
#include <atomic>
#include <boost/asio/ip/tcp.hpp>
#include <functional>

using boost::asio::ip::tcp;

constexpr auto ACORE_MAX_LISTEN_CONNECTIONS = boost::asio::socket_base::max_listen_connections;

class AsyncAcceptor
{
public:
    typedef void(*AcceptCallback)(IoContextTcpSocket&& newSocket, uint32 threadIndex);

    AsyncAcceptor(Acore::Asio::IoContext& ioContext, std::string const& bindIp, uint16 port, bool supportSocketActivation = false) :
        _acceptor(ioContext), _endpoint(Acore::Net::make_address(bindIp), port),
        _socket(ioContext), _closed(false), _socketFactory([this](){ return DefaultSocketFactory(); }),
        _supportSocketActivation(supportSocketActivation)
    {
        int const listen_fd = get_listen_fd();
        if (_supportSocketActivation && listen_fd > 0)
        {
            LOG_DEBUG("network", "Using socket from systemd socket activation");
            boost::system::error_code errorCode;
            _acceptor.assign(boost::asio::ip::tcp::v4(), listen_fd, errorCode);
            if (errorCode)
                LOG_WARN("network", "Failed to assign socket {}", errorCode.message());
        }
    }

    template<class T>
    void AsyncAccept();

    template<AcceptCallback acceptCallback>
    void AsyncAcceptWithCallback()
    {
        IoContextTcpSocket* socket;
        uint32 threadIndex;
        std::tie(socket, threadIndex) = _socketFactory();
        _acceptor.async_accept(*socket, [this, socket, threadIndex](boost::system::error_code error)
        {
            if (!error)
            {
                try
                {
                    socket->non_blocking(true);

                    acceptCallback(std::move(*socket), threadIndex);
                }
                catch (boost::system::system_error const& err)
                {
                    LOG_INFO("network", "Failed to initialize client's socket {}", err.what());
                }
            }

            if (!_closed)
                this->AsyncAcceptWithCallback<acceptCallback>();
        });
    }

    bool Bind()
    {
        boost::system::error_code errorCode;
        // with socket activation the acceptor is already open and bound
        if (!_acceptor.is_open())
        {
            _acceptor.open(_endpoint.protocol(), errorCode);
            if (errorCode)
            {
                LOG_INFO("network", "Failed to open acceptor {}", errorCode.message());
                return false;
            }

#if AC_PLATFORM != AC_PLATFORM_WINDOWS
            _acceptor.set_option(boost::asio::ip::tcp::acceptor::reuse_address(true), errorCode);
            if (errorCode)
            {
                LOG_INFO("network", "Failed to set reuse_address option on acceptor {}", errorCode.message());
                return false;
            }
#endif

            _acceptor.bind(_endpoint, errorCode);
            if (errorCode)
            {
                LOG_INFO("network", "Could not bind to {}:{} {}", _endpoint.address().to_string(), _endpoint.port(), errorCode.message());
                return false;
            }
        }

        _acceptor.listen(ACORE_MAX_LISTEN_CONNECTIONS, errorCode);
        if (errorCode)
        {
            LOG_INFO("network", "Failed to start listening on {}:{} {}", _endpoint.address().to_string(), _endpoint.port(), errorCode.message());
            return false;
        }

        return true;
    }

    void Close()
    {
        if (_closed.exchange(true))
            return;

        boost::system::error_code err;
        _acceptor.close(err);
    }

    void SetSocketFactory(std::function<std::pair<IoContextTcpSocket*, uint32>()> func) { _socketFactory = std::move(func); }

private:
    std::pair<IoContextTcpSocket*, uint32> DefaultSocketFactory() { return std::make_pair(&_socket, 0); }

    boost::asio::basic_socket_acceptor<boost::asio::ip::tcp, IoContextTcpSocket::executor_type> _acceptor;
    boost::asio::ip::tcp::endpoint _endpoint;
    IoContextTcpSocket _socket;
    std::atomic<bool> _closed;
    std::function<std::pair<IoContextTcpSocket*, uint32>()> _socketFactory;
    bool _supportSocketActivation;
};

template<class T>
void AsyncAcceptor::AsyncAccept()
{
    _acceptor.async_accept(_socket, [this](boost::system::error_code error)
    {
        if (!error)
        {
            try
            {
                // this-> is required here to fix an segmentation fault in gcc 4.7.2 - reason is lambdas in a templated class
                std::make_shared<T>(std::move(this->_socket))->Start();
            }
            catch (boost::system::system_error const& err)
            {
                LOG_INFO("network", "Failed to retrieve client's remote address {}", err.what());
            }
        }

        // lets slap some more this-> on this so we can fix this bug with gcc 4.7.2 throwing internals in yo face
        if (!_closed)
            this->AsyncAccept<T>();
    });
}

#endif /* __ASYNC ACCEPT_H_ */
