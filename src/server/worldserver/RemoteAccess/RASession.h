/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef __RASESSION_H__
#define __RASESSION_H__

#include "Common.h"
#include <boost/asio/ip/tcp.hpp>
#include <boost/asio/streambuf.hpp>
#include <future>
#include <memory>

using boost::asio::ip::tcp;

const size_t bufferSize = 4096;

class RASession : public std::enable_shared_from_this<RASession>
{
public:
    RASession(tcp::socket&& socket) :
        _socket(std::move(socket)), _commandExecuting(nullptr) { }

    void Start();

    const std::string GetRemoteIpAddress() const { return _socket.remote_endpoint().address().to_string(); }
    unsigned short GetRemotePort() const { return _socket.remote_endpoint().port(); }

private:
    int Send(const char* data);
    std::string ReadString();
    bool CheckAccessLevel(const std::string& user);
    bool CheckPassword(const std::string& user, const std::string& pass);
    bool ProcessCommand(std::string& command);

    static void CommandPrint(void* callbackArg, const char* text);
    static void CommandFinished(void* callbackArg, bool);

    tcp::socket _socket;
    boost::asio::streambuf _readBuffer;
    boost::asio::streambuf _writeBuffer;
    std::promise<void>* _commandExecuting;
};

#endif
