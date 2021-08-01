/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef __SOCKET_H__
#define __SOCKET_H__

#include "MessageBuffer.h"
#include "Log.h"
#include <atomic>
#include <queue>
#include <memory>
#include <functional>
#include <type_traits>
#include <boost/asio/ip/tcp.hpp>

using boost::asio::ip::tcp;

#define READ_BLOCK_SIZE 4096
#ifdef BOOST_ASIO_HAS_IOCP
#define AC_SOCKET_USE_IOCP
#endif

template<class T>
class Socket : public std::enable_shared_from_this<T>
{
public:
    explicit Socket(tcp::socket&& socket) : _socket(std::move(socket)), _remoteAddress(_socket.remote_endpoint().address()),
        _remotePort(_socket.remote_endpoint().port()), _readBuffer(), _closed(false), _closing(false), _isWritingAsync(false)
    {
        _readBuffer.Resize(READ_BLOCK_SIZE);
    }

    virtual ~Socket()
    {
        _closed = true;
        boost::system::error_code error;
        _socket.close(error);
    }

    virtual void Start() = 0;

    virtual bool Update()
    {
        if (_closed)
        {
            return false;
        }

#ifndef AC_SOCKET_USE_IOCP
        if (_isWritingAsync || (_writeQueue.empty() && !_closing))
        {
            return true;
        }

        for (; HandleQueue();)
            ;
#endif

        return true;
    }

    boost::asio::ip::address GetRemoteIpAddress() const
    {
        return _remoteAddress;
    }

    uint16 GetRemotePort() const
    {
        return _remotePort;
    }

    void AsyncRead()
    {
        if (!IsOpen())
        {
            return;
        }

        _readBuffer.Normalize();
        _readBuffer.EnsureFreeSpace();

        _socket.async_read_some(boost::asio::buffer(_readBuffer.GetWritePointer(), _readBuffer.GetRemainingSpace()),
            std::bind(&Socket<T>::ReadHandlerInternal, this->shared_from_this(), std::placeholders::_1, std::placeholders::_2));
    }

    void AsyncReadWithCallback(void (T::*callback)(boost::system::error_code, std::size_t))
    {
        if (!IsOpen())
        {
            return;
        }

        _readBuffer.Normalize();
        _readBuffer.EnsureFreeSpace();

        _socket.async_read_some(boost::asio::buffer(_readBuffer.GetWritePointer(), _readBuffer.GetRemainingSpace()),
            std::bind(callback, this->shared_from_this(), std::placeholders::_1, std::placeholders::_2));
    }

    void QueuePacket(MessageBuffer&& buffer)
    {
        _writeQueue.push(std::move(buffer));

#ifdef AC_SOCKET_USE_IOCP
        AsyncProcessQueue();
#endif
    }

    bool IsOpen() const { return !_closed && !_closing; }

    void CloseSocket()
    {
        if (_closed.exchange(true))
            return;

        boost::system::error_code shutdownError;
        _socket.shutdown(boost::asio::socket_base::shutdown_send, shutdownError);

        if (shutdownError)
            LOG_DEBUG("network", "Socket::CloseSocket: %s errored when shutting down socket: %i (%s)", GetRemoteIpAddress().to_string().c_str(),
                shutdownError.value(), shutdownError.message().c_str());

        OnClose();
    }

    /// Marks the socket for closing after write buffer becomes empty
    void DelayedCloseSocket() { _closing = true; }

    MessageBuffer& GetReadBuffer() { return _readBuffer; }

protected:
    virtual void OnClose() { }
    virtual void ReadHandler() = 0;

    bool AsyncProcessQueue()
    {
        if (_isWritingAsync)
            return false;

        _isWritingAsync = true;

#ifdef AC_SOCKET_USE_IOCP
        MessageBuffer& buffer = _writeQueue.front();
        _socket.async_write_some(boost::asio::buffer(buffer.GetReadPointer(), buffer.GetActiveSize()), std::bind(&Socket<T>::WriteHandler,
            this->shared_from_this(), std::placeholders::_1, std::placeholders::_2));
#else
        _socket.async_write_some(boost::asio::null_buffers(), std::bind(&Socket<T>::WriteHandlerWrapper,
            this->shared_from_this(), std::placeholders::_1, std::placeholders::_2));
#endif
        return false;
    }

    void SetNoDelay(bool enable)
    {
        boost::system::error_code err;
        _socket.set_option(tcp::no_delay(enable), err);

        if (err)
            LOG_DEBUG("network", "Socket::SetNoDelay: failed to set_option(boost::asio::ip::tcp::no_delay) for %s - %d (%s)",
                GetRemoteIpAddress().to_string().c_str(), err.value(), err.message().c_str());
    }

private:
    void ReadHandlerInternal(boost::system::error_code error, size_t transferredBytes)
    {
        if (error)
        {
            CloseSocket();
            return;
        }

        _readBuffer.WriteCompleted(transferredBytes);
        ReadHandler();
    }

#ifdef AC_SOCKET_USE_IOCP
    void WriteHandler(boost::system::error_code error, std::size_t transferedBytes)
    {
        if (!error)
        {
            _isWritingAsync = false;
            _writeQueue.front().ReadCompleted(transferedBytes);

            if (!_writeQueue.front().GetActiveSize())
                _writeQueue.pop();

            if (!_writeQueue.empty())
                AsyncProcessQueue();
            else if (_closing)
                CloseSocket();
        }
        else
            CloseSocket();
    }

#else

    void WriteHandlerWrapper(boost::system::error_code /*error*/, std::size_t /*transferedBytes*/)
    {
        _isWritingAsync = false;
        HandleQueue();
    }

    bool HandleQueue()
    {
        if (_writeQueue.empty())
            return false;

        MessageBuffer& queuedMessage = _writeQueue.front();

        std::size_t bytesToSend = queuedMessage.GetActiveSize();

        boost::system::error_code error;
        std::size_t bytesSent = _socket.write_some(boost::asio::buffer(queuedMessage.GetReadPointer(), bytesToSend), error);

        if (error)
        {
            if (error == boost::asio::error::would_block || error == boost::asio::error::try_again)
            {
                return AsyncProcessQueue();
            }

            _writeQueue.pop();

            if (_closing && _writeQueue.empty())
            {
                CloseSocket();
            }

            return false;
        }
        else if (bytesSent == 0)
        {
            _writeQueue.pop();

            if (_closing && _writeQueue.empty())
            {
                CloseSocket();
            }

            return false;
        }
        else if (bytesSent < bytesToSend) // now n > 0
        {
            queuedMessage.ReadCompleted(bytesSent);
            return AsyncProcessQueue();
        }

        _writeQueue.pop();

        if (_closing && _writeQueue.empty())
        {
            CloseSocket();
        }

        return !_writeQueue.empty();
    }
#endif

    tcp::socket _socket;

    boost::asio::ip::address _remoteAddress;
    uint16 _remotePort;

    MessageBuffer _readBuffer;
    std::queue<MessageBuffer> _writeQueue;

    std::atomic<bool> _closed;
    std::atomic<bool> _closing;

    bool _isWritingAsync;
};

#endif // __SOCKET_H__
