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

#include "VoiceChatMgr.h"
#include "VoiceChatSocket.h"
#include "Log.h"
#include "VoiceChatSharedDefines.h"

VoiceChatSocket::VoiceChatSocket(IoContextTcpSocket&& socket)
    : TcpSocket<VoiceChatSocket>(std::move(socket)), _lastPacketReceiveTime(getMSTime())
{
    _headerBuffer.Resize(sizeof(VoiceChatServerPktHeader));
}

void VoiceChatSocket::Start()
{
    // Initialize connection
    std::string ip_address = GetRemoteIpAddress().to_string();
    LOG_DEBUG("session", "Accepted connection from {}", ip_address);
    AsyncRead();
}

bool VoiceChatSocket::Update()
{
    // move packets queued by the world thread to the socket write queue
    {
        std::lock_guard<std::mutex> guard(_sendQueueLock);
        while (!_sendQueue.empty())
        {
            QueuePacket(std::move(_sendQueue.front()));
            _sendQueue.pop();
        }
    }

    if (!TcpSocket<VoiceChatSocket>::Update())
        return false;

    return true;
}

void VoiceChatSocket::SendPacket(VoiceChatServerPacket const& pkt)
{
    if (!IsOpen())
        return;

    VoiceChatServerPktHeader header;
    header.size = uint16(sizeof(header.cmd) + pkt.size());
    header.cmd = static_cast<uint8>(pkt.GetOpcode());

    EndianConvertReverse(header.size);
    EndianConvert(header.cmd);

    MessageBuffer buffer(header.headerSize() + pkt.size());
    buffer.Write(header.data(), header.headerSize());
    if (!pkt.empty())
        buffer.Write(pkt.contents(), pkt.size());

    std::lock_guard<std::mutex> guard(_sendQueueLock);
    _sendQueue.push(std::move(buffer));
}

bool VoiceChatSocket::ReadHeaderHandler()
{
    ASSERT(_headerBuffer.GetActiveSize() == sizeof(VoiceChatServerPktHeader));

    VoiceChatServerPktHeader* header = reinterpret_cast<VoiceChatServerPktHeader*>(_headerBuffer.GetReadPointer());
    EndianConvertReverse(header->size);
    EndianConvert(header->cmd);

    if (!header->IsValidSize() || !header->IsValidOpcode())
    {
        LOG_ERROR("voice-chat",
            "VoiceChatSocket::ReadHeaderHandler(): voiceserver {} sent malformed packet (size: {}, cmd: {})",
            GetRemoteIpAddress().to_string(), header->size, header->cmd);

        return false;
    }

    header->size -= sizeof(header->cmd);
    _packetBuffer.Resize(header->size);

    return true;
}

ReadDataHandlerResult VoiceChatSocket::ReadDataHandler()
{
    _lastPacketReceiveTime = getMSTime();

    VoiceChatServerPktHeader* header = reinterpret_cast<VoiceChatServerPktHeader*>(_headerBuffer.GetReadPointer());
    VoiceChatServerOpcodes opcode = static_cast<VoiceChatServerOpcodes>(header->cmd);

    LOG_TRACE("voice-chat", "Received opcode {} size {}", uint32(opcode), header->size);

    // SMSG_PONG needs no handling, only used to reset _lastPacketReceiveTime
    if (opcode == VoiceChatServerOpcodes::SMSG_PONG)
        return ReadDataHandlerResult::Ok;

    std::unique_ptr<VoiceChatServerPacket> packet =
        std::make_unique<VoiceChatServerPacket>(opcode, std::move(_packetBuffer));
    sVoiceChatMgr->QueueIncomingVoiceServerPacket(std::move(packet));

    return ReadDataHandlerResult::Ok;
}
