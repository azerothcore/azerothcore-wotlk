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

#ifndef __UDPSOCKET_H__
#define __UDPSOCKET_H__

#include "Define.h"
#include "Errors.h"
#include "Log.h"
#include <boost/asio/ip/udp.hpp>
#include <cstring>

using boost::asio::ip::udp;

#pragma pack(push, 1)
struct UdpSocketPacketHeader
{
    uint32 signature;
    uint8 userId;
    uint16 channelId;
};
#pragma pack(pop)

#define UDP_SOCKET_PACKET_MAX_SIZE 1024

class UdpSocketPacket
{
public:
    UdpSocketPacket(uint8 const* data, std::size_t length)
    {
        ASSERT(length >= sizeof(UdpSocketPacketHeader) && length <= UDP_SOCKET_PACKET_MAX_SIZE);
        std::memcpy(m_data, data, length);
        m_length = static_cast<uint16>(length);
        m_header = reinterpret_cast<UdpSocketPacketHeader*>(m_data);
    }

    UdpSocketPacketHeader const& GetHeader() const { return *m_header; }
    UdpSocketPacketHeader& GetHeader() { return *m_header; }
    // full datagram, including the header
    uint8 const* GetData() const { return m_data; }
    uint16 GetDataLength() const { return m_length; }
    // payload following the header
    uint8 const* GetPayload() const { return m_data + sizeof(UdpSocketPacketHeader); }
    uint16 GetPayloadLength() const { return m_length - sizeof(UdpSocketPacketHeader); }

private:
    UdpSocketPacketHeader* m_header;
    uint16 m_length;
    uint8 m_data[UDP_SOCKET_PACKET_MAX_SIZE] = { };
};

#define UDP_SOCKET_BUFFER_SIZE 2048

class UdpSocket
{
public:
    explicit UdpSocket(udp::socket&& socket) : _socket(std::move(socket))
    {
        // SendTo runs on the thread that receives, it must never wait for the
        // network. Datagrams the system can not take right away are dropped
        boost::system::error_code errorCode;
        _socket.non_blocking(true, errorCode);
        if (errorCode)
            LOG_ERROR("network", "UdpSocket: could not make the socket non-blocking: {} ({})",
                errorCode.value(), errorCode.message());
    }

    virtual ~UdpSocket() = default;

    // starts receiving datagrams. Called once the object is fully constructed: the
    // receive handler calls ProcessPacket, which derived classes override
    void Start() { StartReceive(); }

    void SendTo(udp::endpoint const& target, uint8 const* data, std::size_t length)
    {
        boost::system::error_code errorCode;
        _socket.send_to(boost::asio::buffer(data, length), target, 0, errorCode);

        if (errorCode)
            LOG_DEBUG("network", "UdpSocket::SendTo failed sending {} bytes: {} ({})", length, errorCode.value(),
                errorCode.message());
    }

    void Close()
    {
        boost::system::error_code errorCode;
        _socket.close(errorCode);
    }

protected:
    virtual void ProcessPacket(UdpSocketPacket const& packet, udp::endpoint const& remoteEndpoint)
    {
        LOG_TRACE("network",
            "Received data on UDP socket from {}:{}. Payload size {}. Signature {}. UserID {} ChannelID {}",
            remoteEndpoint.address().to_string(), remoteEndpoint.port(), packet.GetPayloadLength(),
            packet.GetHeader().signature, packet.GetHeader().userId, packet.GetHeader().channelId);
    }

private:
    void StartReceive()
    {
        _socket.async_receive_from(boost::asio::buffer(_buffer, UDP_SOCKET_BUFFER_SIZE), _senderEndpoint,
            [this](boost::system::error_code const errorCode, std::size_t const dataReceived)
            {
                if (errorCode == boost::asio::error::operation_aborted)
                    return;

                // silently drop datagrams that cannot possibly be valid packets
                if (!errorCode && dataReceived >= sizeof(UdpSocketPacketHeader) &&
                    dataReceived <= UDP_SOCKET_PACKET_MAX_SIZE)
                {
                    UdpSocketPacket const packet(_buffer, dataReceived);
                    ProcessPacket(packet, _senderEndpoint);
                }

                StartReceive();
            });
    }

    udp::socket _socket;
    uint8 _buffer[UDP_SOCKET_BUFFER_SIZE] = { };
    udp::endpoint _senderEndpoint;
};

#endif // __UDPSOCKET_H__
