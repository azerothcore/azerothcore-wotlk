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
#include "TcpSocket.h"
#include <atomic>
#include <boost/asio.hpp>
#include <memory>

using boost::asio::ip::tcp;

/*
 * Establishes outgoing TCP connections, optionally retrying until successful.
 *
 * ConnectOnce/ConnectRepeat/Stop are thread safe. All asio objects are only
 * ever touched from the io context thread; the public entry points post their
 * work there. The On* callbacks are invoked on the io context thread.
 */
class TcpAsyncConnector : public std::enable_shared_from_this<TcpAsyncConnector>
{
public:
    TcpAsyncConnector(Acore::Asio::IoContext& context) : _ioContext(&context), _socket(nullptr),
        _connectTimer(context), _reconnectTimer(context), _needsReconnect(false), _active(false) { }

    // pending handlers keep this object alive. Its timers and socket are bound to
    // the io context, so the owner must drop its reference before that io context
    // is destroyed; the last reference then goes away with the pending handlers
    virtual ~TcpAsyncConnector() = default;

    // Connect once to an endpoint with timeout
    bool ConnectOnce(tcp::endpoint const& endpoint, std::chrono::seconds timeout = std::chrono::seconds(10))
    {
        if (_active.exchange(true))
            return false; // connection attempt already in progress

        _endpoint = endpoint;
        _timeout = timeout;
        _needsReconnect = false;

        Acore::Asio::post(*_ioContext, [self = shared_from_this()]() { self->TryConnect(); });
        return true;
    }

    // Connect to an endpoint with timeout, retrying until successful
    bool ConnectRepeat(tcp::endpoint const& endpoint,
        std::chrono::seconds timeout = std::chrono::seconds(10),
        std::chrono::seconds reconnectTime = std::chrono::seconds(30))
    {
        if (_active.exchange(true))
            return false; // connection attempt already in progress

        _endpoint = endpoint;
        _timeout = timeout;
        _reconnectTime = reconnectTime;
        _needsReconnect = true;

        Acore::Asio::post(*_ioContext, [self = shared_from_this()]() { self->TryConnect(); });
        return true;
    }

    // Stop attempting any connections
    void Stop()
    {
        _needsReconnect = false;
        _active = false;

        Acore::Asio::post(*_ioContext, [self = shared_from_this()]() { self->HandleStop(); });
    }

    bool IsAttemptingConnection() const { return _active.load(); }

private:
    virtual void OnConnectionSuccess(std::unique_ptr<IoContextTcpSocket> /*socket*/) { }
    virtual void OnConnectionFail() { }
    virtual void OnConnectionTimeout() { }

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

    void TryConnect()
    {
        if (!_active.load())
            return;

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
            _connectTimer.async_wait([self = shared_from_this()](boost::system::error_code const& ec)
            {
                self->ConnectionTimeout(ec);
            });

            // start the async connect
            _socket = std::make_unique<IoContextTcpSocket>(*_ioContext);
            _socket->async_connect(_endpoint, [self = shared_from_this()](boost::system::error_code const& ec)
            {
                self->SocketConnected(ec);
            });
        }
        catch (boost::system::system_error const& err)
        {
            LOG_ERROR("network", "TcpAsyncConnector::TryConnect to {}:{} failed: {}",
                _endpoint.address().to_string(), _endpoint.port(), err.what());

            OnConnectionFail();

            if (_active.load() && _needsReconnect.load())
                StartReconnectTimer();
            else
                _active = false; // a single attempt is over
        }
    }

    void SocketConnected(boost::system::error_code const& ec)
    {
        _connectTimer.cancel();

        // stopped while the connect was in flight
        if (!_active.load())
        {
            if (_socket)
            {
                boost::system::error_code errorCode;
                _socket->close(errorCode);
                _socket = nullptr;
            }
            return;
        }

        if (!ec && _socket && _socket->is_open())
        {
            // hand the socket over first: the owner may start a new attempt as
            // soon as IsAttemptingConnection() returns false
            OnConnectionSuccess(std::move(_socket));
            _socket = nullptr;
            _active = false;
        }
        else
        {
            OnConnectionFail();

            if (_needsReconnect.load())
                StartReconnectTimer();
            else
                _active = false; // a single attempt is over
        }
    }

    void ConnectionTimeout(boost::system::error_code const& ec)
    {
        // canceled - the connect completed or the connector was stopped
        if (ec)
            return;

        if (!_active.load())
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

    void StartReconnectTimer()
    {
        _reconnectTimer.expires_after(_reconnectTime);
        _reconnectTimer.async_wait([self = shared_from_this()](boost::system::error_code const& ec)
        {
            if (ec)
                return;

            if (!self->_active.load() || !self->_needsReconnect.load())
                return;

            self->TryConnect();
        });
    }

    Acore::Asio::IoContext* _ioContext;
    std::unique_ptr<IoContextTcpSocket> _socket;

    tcp::endpoint _endpoint;
    std::chrono::seconds _timeout;
    std::chrono::seconds _reconnectTime;

    boost::asio::steady_timer _connectTimer;
    boost::asio::steady_timer _reconnectTimer;

    std::atomic<bool> _needsReconnect;
    std::atomic<bool> _active;
};

#endif
