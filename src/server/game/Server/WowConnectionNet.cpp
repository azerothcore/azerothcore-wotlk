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

#include "WowConnectionNet.h"
#include "Config.h"
#include "NetworkThread.h"
#include "ScriptMgr.h"
#include "WowConnection.h"
#include <boost/system/error_code.hpp>

class WorldSocketThread : public NetworkThread<WowConnection>
{
public:
    void SocketAdded(std::shared_ptr<WowConnection> sock) override
    {
        sock->SetSendBufferSize(sWorldSocketMgr.GetApplicationSendBufferSize());
        sScriptMgr->OnSocketOpen(sock);
    }

    void SocketRemoved(std::shared_ptr<WowConnection> sock) override
    {
        sScriptMgr->OnSocketClose(sock);
    }
};

WowConnectionNet::WowConnectionNet() :
    BaseSocketMgr(), _socketSystemSendBufferSize(-1), _socketApplicationSendBufferSize(65536), _tcpNoDelay(true)
{
}

WowConnectionNet& WowConnectionNet::Instance()
{
    static WowConnectionNet instance;
    return instance;
}

bool WowConnectionNet::StartWorldNetwork(Acore::Asio::IoContext& ioContext, std::string const& bindIp, uint16 port, int threadCount)
{
    _tcpNoDelay = sConfigMgr->GetOption<bool>("Network.TcpNodelay", true);

    int const max_connections = ACORE_MAX_LISTEN_CONNECTIONS;
    LOG_DEBUG("network", "Max allowed socket connections {}", max_connections);

    // -1 means use default
    _socketSystemSendBufferSize = sConfigMgr->GetOption<int32>("Network.OutKBuff", -1);
    _socketApplicationSendBufferSize = sConfigMgr->GetOption<int32>("Network.OutUBuff", 65536);

    if (_socketApplicationSendBufferSize <= 0)
    {
        LOG_ERROR("network", "Network.OutUBuff is wrong in your config file");
        return false;
    }

    if (!BaseSocketMgr::StartNetwork(ioContext, bindIp, port, threadCount))
        return false;

    _acceptor->AsyncAcceptWithCallback<&WowConnectionNet::OnSocketAccept>();

    sScriptMgr->OnNetworkStart();
    return true;
}

void WowConnectionNet::StopNetwork()
{
    BaseSocketMgr::StopNetwork();

    sScriptMgr->OnNetworkStop();
}

void WowConnectionNet::OnSocketOpen(tcp::socket&& sock, uint32 threadIndex)
{
    // set some options here
    if (_socketSystemSendBufferSize >= 0)
    {
        boost::system::error_code err;
        sock.set_option(boost::asio::socket_base::send_buffer_size(_socketSystemSendBufferSize), err);

        if (err && err != boost::system::errc::not_supported)
        {
            LOG_ERROR("network", "WowConnectionNet::OnSocketOpen sock.set_option(boost::asio::socket_base::send_buffer_size) err = {}", err.message());
            return;
        }
    }

    // Set TCP_NODELAY.
    if (_tcpNoDelay)
    {
        boost::system::error_code err;
        sock.set_option(boost::asio::ip::tcp::no_delay(true), err);

        if (err)
        {
            LOG_ERROR("network", "WowConnectionNet::OnSocketOpen sock.set_option(boost::asio::ip::tcp::no_delay) err = {}", err.message());
            return;
        }
    }

    BaseSocketMgr::OnSocketOpen(std::forward<tcp::socket>(sock), threadIndex);
}

NetworkThread<WowConnection>* WowConnectionNet::CreateThreads() const
{

    NetworkThread<WowConnection>* threads = new WorldSocketThread[GetNetworkThreadCount()];

    bool proxyProtocolEnabled = sConfigMgr->GetOption<bool>("Network.EnableProxyProtocol", false, true);
    if (proxyProtocolEnabled)
        for (int i = 0; i < GetNetworkThreadCount(); i++)
            threads[i].EnableProxyProtocol();

    return threads;
}
