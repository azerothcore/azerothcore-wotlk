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

#include "RASession.h"
#include "AccountMgr.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Duration.h"
#include "Log.h"
#include "MotdMgr.h"
#include "QueryResult.h"
#include "SRP6.h"
#include "Util.h"
#include "World.h"
#include <boost/asio/buffer.hpp>
#include <boost/asio/read_until.hpp>
#include <thread>

using boost::asio::ip::tcp;

void RASession::Start()
{
    // wait 1 second for active connections to send negotiation request
    for (int counter = 0; counter < 10 && _socket.available() == 0; counter++)
        std::this_thread::sleep_for(100ms);

    // Check if there are bytes available, if they are, then the client is requesting the negotiation
    if (_socket.available() > 0)
    {
        // Handle subnegotiation
        char buf[1024] = { };
        _socket.read_some(boost::asio::buffer(buf));

        // Send the end-of-negotiation packet
        uint8 const reply[2] = { 0xFF, 0xF0 };
        _socket.write_some(boost::asio::buffer(reply));
    }

    Send("Authentication Required\r\n");
    Send("Username: ");

    std::string username = ReadString();

    if (username.empty())
        return;

    LOG_INFO("commands.ra", "Accepting RA connection from user {} (IP: {})", username, GetRemoteIpAddress());

    Send("Password: ");

    std::string password = ReadString();
    if (password.empty())
        return;

    if (!CheckAccessLevel(username) || !CheckPassword(username, password))
    {
        Send("Authentication failed\r\n");
        _socket.close();
        return;
    }

    LOG_INFO("commands.ra", "User {} (IP: {}) authenticated correctly to RA", username, GetRemoteIpAddress());

    // Authentication successful, send the motd
    Send(std::string(std::string(sMotdMgr->GetMotd(DEFAULT_LOCALE)) + "\r\n").c_str());

    // Read commands
    for (;;)
    {
        Send("AC>");
        std::string command = ReadString();

        if (ProcessCommand(command))
            break;
    }

    _socket.close();
}

int RASession::Send(std::string_view data)
{
    std::ostream os(&_writeBuffer);
    os << data;
    std::size_t written = _socket.send(_writeBuffer.data());
    _writeBuffer.consume(written);
    return written;
}

std::string RASession::ReadString()
{
    boost::system::error_code error;
    std::size_t read = boost::asio::read_until(_socket, _readBuffer, "\r\n", error);
    if (!read)
    {
        _socket.close();
        return "";
    }

    std::string line;
    std::istream is(&_readBuffer);
    std::getline(is, line);

    if (*line.rbegin() == '\r')
        line.erase(line.length() - 1);

    return line;
}

bool RASession::CheckAccessLevel(const std::string& user)
{
    std::string safeUser = user;

    Utf8ToUpperOnlyLatin(safeUser);

    auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_ACCESS);
    stmt->SetData(0, safeUser);

    PreparedQueryResult result = LoginDatabase.Query(stmt);
    if (!result)
    {
        LOG_INFO("commands.ra", "User {} does not exist in database", user);
        return false;
    }

    Field* fields = result->Fetch();

    if (fields[1].Get<uint8>() < sConfigMgr->GetOption<int32>("Ra.MinLevel", 3))
    {
        LOG_INFO("commands.ra", "User {} has no privilege to login", user);
        return false;
    }
    else if (fields[2].Get<int32>() != -1)
    {
        LOG_INFO("commands.ra", "User {} has to be assigned on all realms (with RealmID = '-1')", user);
        return false;
    }

    return true;
}

bool RASession::CheckPassword(const std::string& user, const std::string& pass)
{
    std::string safe_user = user;
    std::transform(safe_user.begin(), safe_user.end(), safe_user.begin(), ::toupper);
    Utf8ToUpperOnlyLatin(safe_user);

    std::string safe_pass = pass;
    Utf8ToUpperOnlyLatin(safe_pass);
    std::transform(safe_pass.begin(), safe_pass.end(), safe_pass.begin(), ::toupper);

    auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_CHECK_PASSWORD_BY_NAME);

    stmt->SetData(0, safe_user);

    if (PreparedQueryResult result = LoginDatabase.Query(stmt))
    {
        Acore::Crypto::SRP6::Salt salt = (*result)[0].Get<Binary, Acore::Crypto::SRP6::SALT_LENGTH>();
        Acore::Crypto::SRP6::Verifier verifier = (*result)[1].Get<Binary, Acore::Crypto::SRP6::VERIFIER_LENGTH>();

        if (Acore::Crypto::SRP6::CheckLogin(safe_user, safe_pass, salt, verifier))
            return true;
    }

    LOG_INFO("commands.ra", "Wrong password for user: {}", user);
    return false;
}

bool RASession::ProcessCommand(std::string& command)
{
    if (command.length() == 0)
        return true;

    LOG_INFO("commands.ra", "Received command: {}", command);

    // handle quit, exit and logout commands to terminate connection
    if (command == "quit" || command == "exit" || command == "logout")
    {
        Send("Bye\r\n");
        return true;
    }

    // Obtain a new promise per command
    delete _commandExecuting;
    _commandExecuting = new std::promise<void>();

    CliCommandHolder* cmd = new CliCommandHolder(this, command.c_str(), &RASession::CommandPrint, &RASession::CommandFinished);
    sWorld->QueueCliCommand(cmd);

    // Wait for the command to finish
    _commandExecuting->get_future().wait();

    return false;
}

void RASession::CommandPrint(void* callbackArg, std::string_view text)
{
    if (text.empty())
    {
        return;
    }

    RASession* session = static_cast<RASession*>(callbackArg);
    session->Send(text);
}

void RASession::CommandFinished(void* callbackArg, bool /*success*/)
{
    RASession* session = static_cast<RASession*>(callbackArg);
    session->_commandExecuting->set_value();
}
