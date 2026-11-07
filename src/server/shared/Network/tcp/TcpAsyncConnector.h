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

#ifndef __TCPASYNCCONNECTOR_H_
#define __TCPASYNCCONNECTOR_H_

#include "IoContext.h"
#include "Log.h"
#include "Resolver.h"
#include "TcpSocket.h"
#include <atomic>
#include <boost/asio.hpp>
#include <memory>
#include <string>

using boost::asio::ip::tcp;

/*
 * Establishes outgoing TCP connections, optionally retrying until successful.
 *
 * ConnectOnce/ConnectRepeat/Stop are thread safe. All asio objects are only
 * ever touched from the io context thread; the public entry points post their
 * work there. The On* callbacks are invoked on the io context thread.
 *
 * The host (an IPv4 address, or a hostname resolved to IPv4 like the realm
 * addresses) is looked up again before every attempt, with a blocking lookup
 * on the io context thread. A host that does not resolve fails that attempt
 * like a refused connection.
 *
 * Every connection request gets a number, and Stop moves it on too. Handlers
 * still pending for an earlier request (a lookup, a connect, a timer) see that
 * they are out of date and do nothing, so a stopped request never touches the
 * timers, socket or failure count of the one that follows it.
 */
class TcpAsyncConnector : public std::enable_shared_from_this<TcpAsyncConnector>
{
public:
    TcpAsyncConnector(Acore::Asio::IoContext& context) : _ioContext(&context), _socket(nullptr), _resolver(context),
        _port(0), _connectTimer(context), _reconnectTimer(context), _needsReconnect(false), _active(false),
        _request(0) { }

    // pending handlers keep this object alive. Its timers and socket are bound to
    // the io context, so the owner must drop its reference before that io context
    // is destroyed; the last reference then goes away with the pending handlers
    virtual ~TcpAsyncConnector() = default;

    // Connect once to host:port with timeout
    bool ConnectOnce(std::string host, uint16 port, std::chrono::seconds timeout = std::chrono::seconds(10))
    {
        if (_active.exchange(true))
            return false; // connection attempt already in progress

        _needsReconnect = false;
        Start(++_request, std::move(host), port, timeout, std::chrono::seconds(0));
        return true;
    }

    // Connect to host:port with timeout, retrying until successful
    bool ConnectRepeat(std::string host, uint16 port,
        std::chrono::seconds timeout = std::chrono::seconds(10),
        std::chrono::seconds reconnectTime = std::chrono::seconds(30))
    {
        if (_active.exchange(true))
            return false; // connection attempt already in progress

        _needsReconnect = true;
        Start(++_request, std::move(host), port, timeout, reconnectTime);
        return true;
    }

    // Stop attempting any connections
    void Stop()
    {
        _needsReconnect = false;
        _active = false;
        ++_request;

        Acore::Asio::post(*_ioContext, [self = shared_from_this()]() { self->HandleStop(); });
    }

    bool IsAttemptingConnection() const { return _active.load(); }

private:
    virtual void OnConnectionSuccess(std::unique_ptr<IoContextTcpSocket> /*socket*/) { }
    virtual void OnConnectionFail() { }
    virtual void OnConnectionTimeout() { }

    // the settings are handed to the io context thread with the request: a request
    // stopped just before may still be using them there (e.g. in a slow lookup)
    void Start(uint32 request, std::string host, uint16 port, std::chrono::seconds timeout,
        std::chrono::seconds reconnectTime)
    {
        Acore::Asio::post(*_ioContext,
            [self = shared_from_this(), request, host = std::move(host), port, timeout, reconnectTime]()
            {
                if (!self->IsCurrent(request))
                    return;

                self->_host = host;
                self->_port = port;
                self->_timeout = timeout;
                self->_reconnectTime = reconnectTime;
                self->TryConnect(request);
            });
    }

    // false for a request that was stopped, or replaced by a newer one
    bool IsCurrent(uint32 request) const { return request == _request.load(); }

    // everything below runs on the io context thread

    void HandleStop()
    {
        _connectTimer.cancel();
        _reconnectTimer.cancel();

        if (_socket)
        {
            boost::system::error_code errorCode;
            _socket->close(errorCode);
            _socket = nullptr;
        }
    }

    // callers make sure request is current
    void TryConnect(uint32 request)
    {
        // looked up again for every attempt: a host may come up, or move, later
        Optional<tcp::endpoint> resolved = _resolver.Resolve(tcp::v4(), _host, "");

        // stopped (and maybe started again) during the lookup
        if (!IsCurrent(request))
            return;

        if (!resolved)
        {
            LOG_ERROR("network", "TcpAsyncConnector could not resolve host '{}'", _host);
            AttemptFailed(request);
            return;
        }

        _endpoint = tcp::endpoint(resolved->address(), _port);

        try
        {
            // clean up the previous attempt
            if (_socket)
            {
                boost::system::error_code errorCode;
                _socket->close(errorCode);
            }

            // start the timeout timer
            _connectTimer.expires_after(_timeout);
            _connectTimer.async_wait([self = shared_from_this(), request](boost::system::error_code const& ec)
            {
                self->ConnectionTimeout(ec, request);
            });

            // start the async connect
            _socket = std::make_unique<IoContextTcpSocket>(*_ioContext);
            _socket->async_connect(_endpoint, [self = shared_from_this(), request](boost::system::error_code const& ec)
            {
                self->SocketConnected(ec, request);
            });
        }
        catch (boost::system::system_error const& err)
        {
            LOG_ERROR("network", "TcpAsyncConnector::TryConnect to {}:{} ({}) failed: {}",
                _host, _port, _endpoint.address().to_string(), err.what());

            AttemptFailed(request);
        }
    }

    void SocketConnected(boost::system::error_code const& ec, uint32 request)
    {
        // stopped while the connect was in flight: HandleStop closes the socket, and
        // the timer and socket may already belong to the request that followed
        if (!IsCurrent(request))
            return;

        _connectTimer.cancel();

        if (!ec && _socket && _socket->is_open())
        {
            // hand the socket over first: the owner may start a new attempt as
            // soon as IsAttemptingConnection() returns false
            OnConnectionSuccess(std::move(_socket));
            _socket = nullptr;
            _active = false;
        }
        else
            AttemptFailed(request);
    }

    void ConnectionTimeout(boost::system::error_code const& ec, uint32 request)
    {
        // canceled - the connect completed or the connector was stopped
        if (ec)
            return;

        if (!IsCurrent(request))
            return;

        OnConnectionTimeout();

        // close the in-flight socket; the connect handler then fires with an
        // error and takes the regular failure path (including reconnect)
        if (_socket)
        {
            boost::system::error_code errorCode;
            _socket->close(errorCode);
        }
    }

    void AttemptFailed(uint32 request)
    {
        OnConnectionFail();

        if (_needsReconnect.load())
            StartReconnectTimer(request);
        else
            _active = false; // a single attempt is over
    }

    void StartReconnectTimer(uint32 request)
    {
        _reconnectTimer.expires_after(_reconnectTime);
        _reconnectTimer.async_wait([self = shared_from_this(), request](boost::system::error_code const& ec)
        {
            if (ec)
                return;

            if (!self->IsCurrent(request) || !self->_needsReconnect.load())
                return;

            self->TryConnect(request);
        });
    }

    Acore::Asio::IoContext* _ioContext;
    std::unique_ptr<IoContextTcpSocket> _socket;
    Acore::Asio::Resolver _resolver;

    std::string _host;
    uint16 _port;
    tcp::endpoint _endpoint;
    std::chrono::seconds _timeout;
    std::chrono::seconds _reconnectTime;

    boost::asio::steady_timer _connectTimer;
    boost::asio::steady_timer _reconnectTimer;

    std::atomic<bool> _needsReconnect;
    std::atomic<bool> _active;
    // number of the latest ConnectOnce/ConnectRepeat/Stop
    std::atomic<uint32> _request;
};

#endif
