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

#include "ChannelMgr.h"
#include "Common.h"
#include "InternalHandler.h"
#include "InternalSession.h"
#include "Timer.h"
#include "VoiceChatSharedDefines.h"
#include "VoiceScriptMgr.h"
#include <atomic>

namespace
{
    // starts at 1, VoiceWorldLink ids of 0 belong to no connection
    std::atomic<uint32> NextWorldId{ 1 };
}

InternalSession::InternalSession(IoContextTcpSocket&& socket) : TcpSocket(std::move(socket)),
    _worldId(NextWorldId++), _lastPacketReceiveTime(getMSTime())
{
    _headerBuffer.Resize(sizeof(VoiceChatServerPktHeader));
}

void InternalSession::Start()
{
    LOG_INFO("voice-chat", "Accepted worldserver #{} connection from {}", _worldId,
        GetRemoteIpAddress().to_string());

    AsyncRead();
}

void InternalSession::OnClose()
{
    LOG_INFO("voice-chat", "Worldserver #{} connection from {} closed", _worldId, GetRemoteIpAddress().to_string());

    // drop everything the disconnected worldserver owned
    sVoiceChannelMgr.RemoveChannelsFor(GetWorldLink());
}

bool InternalSession::Update()
{
    std::unique_ptr<VoiceChatServerPacket> queued;
    while (_queuedPackets.next(queued))
        SendPacket(*queued);

    // the worldserver pings regularly, so a silent connection is dead (e.g. after
    // a network split). It would keep its channels and their ids otherwise, and the
    // reconnected worldserver could not create them again
    if (IsOpen() && GetMSTimeDiffToNow(_lastPacketReceiveTime) > VOICECHAT_INTERNAL_TIMEOUT)
    {
        LOG_ERROR("voice-chat", "Worldserver {} sent nothing in {} seconds, dropping connection",
            GetRemoteIpAddress().to_string(), VOICECHAT_INTERNAL_TIMEOUT / IN_MILLISECONDS);
        CloseSocket();
    }

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
        LOG_ERROR("voice-chat",
            "InternalSession::ReadHeaderHandler(): worldserver {} sent malformed packet (size: {}, cmd: {})",
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

    _lastPacketReceiveTime = getMSTime();

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

bool InternalSession::QueueModuleMessage(std::string const& tag, ByteBuffer const& data)
{
    std::unique_ptr<VoiceChatServerPacket> packet = std::make_unique<VoiceChatServerPacket>();
    if (!BuildVoiceChatModuleMessage(*packet, VoiceChatServerOpcodes::SMSG_MODULE_MESSAGE, tag, data))
    {
        LOG_ERROR("voice-chat", "Module message '{}' of {} bytes does not fit an internal packet", tag, data.wpos());
        return false;
    }

    _queuedPackets.emplace_back(std::move(packet));
    return true;
}

bool VoiceWorldLink::SendModuleMessage(std::string const& tag, ByteBuffer const& data) const
{
    std::shared_ptr<InternalSession> session = _session.lock();
    if (!session || !session->IsOpen())
        return false;

    return session->QueueModuleMessage(tag, data);
}

bool VoiceWorldLink::IsConnected() const
{
    std::shared_ptr<InternalSession> session = _session.lock();
    return session && session->IsOpen();
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
    VoiceChatSessionKey sessionKey;
    packet >> channelId;
    packet >> type;
    packet.read(sessionKey);

    bool const created = type < static_cast<uint8>(VoiceChatChannelType::Max)
        && sVoiceChannelMgr.CreateChannel(GetWorldLink(), channelId, static_cast<VoiceChatChannelType>(type),
            sessionKey);

    VoiceChatServerPacket data(VoiceChatServerOpcodes::SMSG_CREATE_VOICE_SESSION_RESPONSE, 3);
    data << channelId;
    data << static_cast<uint8>(created ? VoiceChatCreateSessionResult::Ok : VoiceChatCreateSessionResult::Failed);
    SendPacket(data);
}

void InternalSession::HandleDeleteVoiceSession(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    packet >> channelId;

    sVoiceChannelMgr.DeleteChannel(GetWorldLink(), channelId);
}

void InternalSession::HandleAddMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    std::string clientAddressString;
    VoiceChannelMember member;
    packet >> channelId;
    packet >> userId;
    packet >> clientAddressString;
    packet >> member.CharacterGuid;
    packet >> member.CharacterName;
    packet >> member.AccountId;

    boost::system::error_code error;
    member.ClientAddress = boost::asio::ip::make_address(clientAddressString, error);
    if (error)
    {
        LOG_ERROR("voice-chat", "Invalid client address '{}' for channel {} member {} ({}), member not added",
            clientAddressString, channelId, userId, member.CharacterName);
        return;
    }

    sVoiceChannelMgr.AddMember(GetWorldLink(), channelId, userId, member);
}

void InternalSession::HandleRemoveMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    packet >> channelId;
    packet >> userId;

    sVoiceChannelMgr.RemoveMember(GetWorldLink(), channelId, userId);
}

void InternalSession::HandleVoiceMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    packet >> channelId;
    packet >> userId;

    sVoiceChannelMgr.VoiceMember(GetWorldLink(), channelId, userId);
}

void InternalSession::HandleDevoiceMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    packet >> channelId;
    packet >> userId;

    sVoiceChannelMgr.DevoiceMember(GetWorldLink(), channelId, userId);
}

void InternalSession::HandleMuteMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    packet >> channelId;
    packet >> userId;

    sVoiceChannelMgr.MuteMember(GetWorldLink(), channelId, userId);
}

void InternalSession::HandleUnmuteMember(VoiceChatServerPacket& packet)
{
    uint16 channelId;
    uint8 userId;
    packet >> channelId;
    packet >> userId;

    sVoiceChannelMgr.UnmuteMember(GetWorldLink(), channelId, userId);
}

void InternalSession::HandleModuleMessage(VoiceChatServerPacket& packet)
{
    std::string tag;
    ByteBuffer data;
    ReadVoiceChatModuleMessage(packet, tag, data);

    sVoiceScriptMgr->OnWorldMessage(GetWorldLink(), tag, data);
}
