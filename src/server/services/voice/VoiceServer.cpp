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

#include "VoiceServer.h"
#include "ChannelMgr.h"
#include "InternalHandler.h"
#include "Log.h"
#include "VoiceScriptMgr.h"
#include <boost/asio/ip/address.hpp>
#include <vector>

void VoiceClientSocket::ProcessPacket(UdpSocketPacket const& packet, udp::endpoint const& remoteEndpoint)
{
    UdpSocketPacketHeader const& header = packet.GetHeader();
    // the worldserver of the sender's channel
    VoiceWorldLink world;

    // a header-only datagram announces the endpoint the client will be
    // sending voice data from
    if (packet.GetDataLength() == sizeof(UdpSocketPacketHeader))
    {
        if (sVoiceChannelMgr.HandleClientHandshake(packet, remoteEndpoint, world))
        {
            LOG_DEBUG("voice-chat", "Client {}:{} announced itself for channel {} of worldserver #{} member {}",
                remoteEndpoint.address().to_string(), remoteEndpoint.port(), header.channelId, world.GetId(),
                header.userId);

            sVoiceScriptMgr->OnClientHandshake(world, header.channelId, header.userId, remoteEndpoint);
        }
        else
        {
            LOG_DEBUG("voice-chat",
                "Client {}:{} sent handshake for channel {} member {}, no such member with its address and key",
                remoteEndpoint.address().to_string(), remoteEndpoint.port(), header.channelId, header.userId);
        }

        return;
    }

    // relay the voice frame unchanged to all other voiced members
    std::vector<udp::endpoint> targets;
    bool announced = false;
    bool const relay = sVoiceChannelMgr.GetRelayTargets(packet, remoteEndpoint, targets, announced, world);

    if (announced)
    {
        LOG_DEBUG("voice-chat",
            "Client {}:{} announced itself for channel {} of worldserver #{} member {} by sending voice",
            remoteEndpoint.address().to_string(), remoteEndpoint.port(), header.channelId, world.GetId(),
            header.userId);

        sVoiceScriptMgr->OnClientHandshake(world, header.channelId, header.userId, remoteEndpoint);
    }

    if (!relay)
        return;

    for (udp::endpoint const& target : targets)
        SendTo(target, packet.GetData(), packet.GetDataLength());

    sVoiceScriptMgr->OnVoicePacket(world, header.channelId, header.userId,
        std::span<uint8 const>(packet.GetPayload(), packet.GetPayloadLength()));
}

VoiceServer::VoiceServer()
{
    internalVoiceChatOpcodeTable.Init();
}

bool VoiceServer::Start(Acore::Asio::IoContext& ioContext, std::string const& bindIp, uint16 const port)
{
    try
    {
        boost::asio::ip::address address = boost::asio::ip::make_address(bindIp);
        _socket = std::make_unique<VoiceClientSocket>(udp::socket(ioContext, udp::endpoint(address, port)));
        _socket->Start();
    }
    catch (boost::system::system_error const& err)
    {
        LOG_ERROR("voice-chat", "Failed to open UDP voice socket on {}:{}: {}", bindIp, port, err.what());
        return false;
    }

    LOG_INFO("voice-chat", "Listening for voice data on {}:{} (UDP)", bindIp, port);
    return true;
}

void VoiceServer::Stop()
{
    // the socket is bound to main()'s io context, which is destroyed before this
    // singleton; it must not live on until static destruction
    if (_socket)
    {
        _socket->Close();
        _socket.reset();
    }
}
