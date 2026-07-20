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

#include "ChannelMgr.h"
#include "InternalHandler.h"
#include "InternalSession.h"
#include "VoiceChatSharedDefines.h"

InternalSession::InternalSession(IoContextTcpSocket&& socket) : TcpSocket(std::move(socket))
{
    _headerBuffer.Resize(sizeof(VoiceChatServerPktHeader));
}

void InternalSession::Start()
{
    LOG_INFO("voice-chat", "Accepted worldserver connection from {}", GetRemoteIpAddress().to_string());

    AsyncRead();
}

void InternalSession::OnClose()
{
    LOG_INFO("voice-chat", "Worldserver connection from {} closed", GetRemoteIpAddress().to_string());

    // drop everything the disconnected worldserver owned
    sChannelMgr.RemoveChannelsFor(this);
}

bool InternalSession::Update()
{
    if (!InternalSocket::Update())
        return false;

    return true;
}

bool InternalSession::ReadHeaderHandler()
{
    ASSERT(_headerBuffer.GetActiveSize() == sizeof(VoiceChatServerPktHeader));

    VoiceChatServerPktHeader* header = reinterpret_cast<VoiceChatServerPktHeader*>(_headerBuffer.GetReadPointer());
    EndianConvertReverse(header->size);
    EndianConvert(header->cmd);

    if (!header->IsValidSize() || !header->IsValidOpcode())
    {
        LOG_ERROR("voice-chat", "InternalSession::ReadHeaderHandler(): worldserver {} sent malformed packet (size: {}, cmd: {})",
            GetRemoteIpAddress().to_string(), header->size, header->cmd);

        return false;
    }

    header->size -= sizeof(header->cmd);
    _packetBuffer.Resize(header->size);

    return true;
}

ReadDataHandlerResult InternalSession::ReadDataHandler()
{
    VoiceChatServerPktHeader* header = reinterpret_cast<VoiceChatServerPktHeader*>(_headerBuffer.GetReadPointer());
    VoiceChatServerOpcodes opcode = static_cast<VoiceChatServerOpcodes>(header->cmd);

    // Note: opcode value is already sanity checked in ReadHeaderHandler
    VoiceChatInternalOpcodeHandler<InternalSession> const* opHandle = internalVoiceChatOpcodeTable[opcode];
    if (!opHandle)
    {
        LOG_ERROR("voice-chat", "InternalSession::ReadDataHandler(): worldserver {} sent unhandled opcode {}",
            GetRemoteIpAddress().to_string(), header->cmd);
        return ReadDataHandlerResult::Error;
    }

    LOG_TRACE("voice-chat", "Received {} size {}", opHandle->_name, header->size);

    VoiceChatServerPacket packet(opcode, std::move(_packetBuffer));

    try
    {
        (this->*opHandle->_handler)(packet);
    }
    catch (ByteBufferException const&)
    {
        LOG_ERROR("voice-chat", "InternalSession::ReadDataHandler(): worldserver {} sent malformed {}",
            GetRemoteIpAddress().to_string(), opHandle->_name);
        return ReadDataHandlerResult::Error;
    }

    return ReadDataHandlerResult::Ok;
}

void InternalSession::SendPacket(VoiceChatServerPacket const& packet)
{
    if (!IsOpen())
        return;

    VoiceChatServerPktHeader pktHeader;
    pktHeader.size = uint16(sizeof(pktHeader.cmd) + packet.wpos());
    pktHeader.cmd = static_cast<uint8>(packet.GetOpcode());

    EndianConvertReverse(pktHeader.size);
    EndianConvert(pktHeader.cmd);

    MessageBuffer buffer(pktHeader.headerSize() + packet.size());
    buffer.Write(pktHeader.data(), pktHeader.headerSize());
    if (!packet.empty())
        buffer.Write(packet.contents(), packet.size());
    QueuePacket(std::move(buffer));

    LOG_TRACE("voice-chat", "Sending opcode {} size {}", uint32(packet.GetOpcode()), packet.size());
}

void InternalSession::HandlePing(VoiceChatServerPacket& /*packet*/)
{
    VoiceChatServerPacket data(VoiceChatServerOpcodes::SMSG_PONG, 0);
    SendPacket(data);
}

void InternalSession::HandleCreateVoiceSession(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 type;
    packet >> channelId;
    packet >> type;

    bool const created = type < static_cast<uint8>(VoiceChatChannelType::Max)
        && sChannelMgr.CreateChannel(this, channelId, static_cast<VoiceChatChannelType>(type));

    VoiceChatServerPacket data(VoiceChatServerOpcodes::SMSG_CREATE_VOICE_SESSION_RESPONSE, 3);
    data << channelId;
    data << static_cast<uint8>(created ? VoiceChatCreateSessionResult::Ok : VoiceChatCreateSessionResult::Failed);
    SendPacket(data);
}

void InternalSession::HandleDeleteVoiceSession(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    packet >> channelId;

    sChannelMgr.DeleteChannel(this, channelId);
}

void InternalSession::HandleAddMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    packet >> channelId;
    packet >> userId;

    sChannelMgr.AddMember(this, channelId, userId);
}

void InternalSession::HandleRemoveMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    packet >> channelId;
    packet >> userId;

    sChannelMgr.RemoveMember(this, channelId, userId);
}

void InternalSession::HandleVoiceMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    packet >> channelId;
    packet >> userId;

    sChannelMgr.VoiceMember(this, channelId, userId);
}

void InternalSession::HandleDevoiceMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    packet >> channelId;
    packet >> userId;

    sChannelMgr.DevoiceMember(this, channelId, userId);
}

void InternalSession::HandleMuteMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    packet >> channelId;
    packet >> userId;

    sChannelMgr.MuteMember(this, channelId, userId);
}

void InternalSession::HandleUnmuteMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    packet >> channelId;
    packet >> userId;

    sChannelMgr.UnmuteMember(this, channelId, userId);
}
