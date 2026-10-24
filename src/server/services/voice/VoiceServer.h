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

#ifndef VoiceServer_h_
#define VoiceServer_h_

#include "Define.h"
#include "IoContext.h"
#include "UdpSocket.h"
#include <boost/asio/ip/udp.hpp>
#include <memory>
#include <string>

using boost::asio::ip::udp;

// Receives voice datagrams from game clients and relays them to the other
// voiced members of the sender's voice channel.
class VoiceClientSocket : public UdpSocket
{
public:
    explicit VoiceClientSocket(udp::socket&& socket) : UdpSocket(std::move(socket)) { }

protected:
    void ProcessPacket(UdpSocketPacket const& packet, udp::endpoint const& remoteEndpoint) override;
};

class VoiceServer
{
public:
    static VoiceServer& Instance()
    {
        static VoiceServer instance;
        return instance;
    }

    VoiceServer();

    bool Start(Acore::Asio::IoContext& ioContext, std::string const& bindIp, uint16 const port);
    void Stop();

private:
    std::unique_ptr<VoiceClientSocket> _socket;
};

#define sVoiceServer VoiceServer::Instance()

#endif
