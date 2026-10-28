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
#include <algorithm>
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

    // relay the voice frame to all other voiced members, as scripts change it
    std::vector<VoiceRelayTarget> targets;
    bool announced = false;
    VoiceChatSessionKey sessionKey{};
    bool const relay = sVoiceChannelMgr.GetRelayTargets(packet, remoteEndpoint, targets, announced, world,
        sessionKey);

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

    std::span<uint8 const> const payload(packet.GetPayload(), packet.GetPayloadLength());
    sVoiceScriptMgr->OnRelayVoicePacket(world, header.channelId, header.userId, payload, targets);

    // payloads changed by scripts, each signed once
    std::vector<std::vector<uint8>> changed;
    for (VoiceRelayTarget const& target : targets)
    {
        if (target.Payload.empty())
        {
            SendTo(target.Endpoint, packet.GetData(), packet.GetDataLength());
            continue;
        }

        // the game client would cut the datagram short and drop it
        if (target.Payload.size() > VOICE_RELAY_MAX_PAYLOAD_SIZE)
        {
            LOG_ERROR("voice-chat", "A script gave user {} of channel {} a voice payload of {} bytes, more than "
                "the {} a game client takes, not sent", target.UserId, header.channelId, target.Payload.size(),
                VOICE_RELAY_MAX_PAYLOAD_SIZE);
            continue;
        }

        auto datagram = std::find_if(changed.begin(), changed.end(), [&target](std::vector<uint8> const& data)
        {
            return std::equal(data.begin() + sizeof(UdpSocketPacketHeader), data.end(), target.Payload.begin(),
                target.Payload.end());
        });

        if (datagram == changed.end())
        {
            datagram = changed.emplace(changed.end(), packet.GetData(),
                packet.GetData() + sizeof(UdpSocketPacketHeader));
            datagram->insert(datagram->end(), target.Payload.begin(), target.Payload.end());
            SignVoiceDatagram(sessionKey, datagram->data(), datagram->size());
        }

        SendTo(target.Endpoint, datagram->data(), datagram->size());
    }

    sVoiceScriptMgr->OnVoicePacket(world, header.channelId, header.userId, payload);
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
