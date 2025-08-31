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

#include "VoiceChatSocket.h"
#include "Log.h"
#include "VoiceChatDefines.h"
#include "VoiceChatMgr.h"
#include <iomanip>

struct VoiceChatServerPktHeader {
    uint16 cmd;
    uint16 size;

    char const* data() const { return reinterpret_cast<const char *>(this); }

    std::size_t headerSize() const { return sizeof(VoiceChatServerPktHeader); }
};

VoiceChatSocket::VoiceChatSocket(tcp::socket &&socket)
    : Socket<VoiceChatSocket>(std::move(socket)) {}

void VoiceChatSocket::Start()
{
    // Initialize connection
    std::string ip_address = GetRemoteIpAddress().to_string();
    LOG_DEBUG("session", "Accepted connection from {}", ip_address);
    AsyncRead();
}

bool VoiceChatSocket::Update()
{
    if (!Socket<VoiceChatSocket>::Update())
        return false;

    return true;
}

void VoiceChatSocket::SendPacket(VoiceChatServerPacket pct)
{
    if (!IsOpen())
        return;

    VoiceChatServerPktHeader header;
    header.cmd = pct.GetOpcode();
    header.size = static_cast<uint8>(pct.size());

    MessageBuffer buffer(header.headerSize() + pct.size());

    buffer.Write(header.data(), header.headerSize());

    if (pct.size() > 0)
        buffer.Write(pct.contents(), pct.size());

    if (sLog->ShouldLog("session", LogLevel::LOG_LEVEL_DEBUG))
    {
        LOG_DEBUG("session", "Sending voice socket packet: opcode={}, size={}", header.cmd, header.size);

        std::stringstream ss;
        const uint8* data = (const uint8*)buffer.GetReadPointer();
        for (size_t i = 0; i < buffer.GetActiveSize(); ++i)
            ss << std::hex << std::setw(2) << std::setfill('0') << (int)data[i] << " ";
        LOG_DEBUG("session", "Voice socket packet data: {}", ss.str());
    }

    QueuePacket(std::move(buffer));
}

bool VoiceChatSocket::HandlePing()
{
    // Always handle ping packet
    return true;
}

bool VoiceChatSocket::ProcessIncomingData()
{
    try
    {
        LOG_DEBUG("session", "VoiceChatSocket::ProcessIncomingData() Read Pong packet sent from server"); // Log info for pong packets

        if (!IsOpen())
            return false;

        // Read header
        if (GetReadBuffer().GetActiveSize() < sizeof(VoiceChatServerPktHeader))
        {
            LOG_ERROR("session", "Not enough data for header ({} < {})", GetReadBuffer().GetActiveSize(), sizeof(VoiceChatServerPktHeader));
            return false;
        }

        VoiceChatServerPktHeader header;
        std::memcpy(&header, GetReadBuffer().GetReadPointer(), sizeof(header));
        GetReadBuffer().ReadCompleted(sizeof(header));

        LOG_DEBUG("session", "Processing voice socket packet: cmd={}, size={}", header.cmd, header.size);

        if (header.size < 2 || header.size > 0x2800)
        {
            LOG_ERROR("session", "VoiceChatServerSocket::ProcessIncomingData: client sent malformed packet size = {} , cmd = {}", header.size, header.cmd);
            CloseSocket();
            return false;
        }

        // Read payload
        if (GetReadBuffer().GetActiveSize() < header.size)
            return false;

        std::vector<uint8> payload(header.size);
        std::memcpy(payload.data(), GetReadBuffer().GetReadPointer(), header.size);
        GetReadBuffer().ReadCompleted(header.size);

        // Pass to VoiceChatMgr
        auto packet = std::make_unique<VoiceChatServerPacket>(
            (VoiceChatServerOpcodes)header.cmd, header.size);
        packet->append(payload.data(), payload.size());
        sVoiceChatMgr.QueuePacket(std::move(packet));

        return true;
    }
    catch (const std::exception& e)
    {
        LOG_ERROR("voice-chat", "Exception in ProcessIncomingData: {}", e.what());
        CloseSocket();
        return false;
    }
}

void VoiceChatSocket::ReadHandler()
{
    LOG_DEBUG("session", "ReadHandler called with {} bytes available", GetReadBuffer().GetActiveSize());

    MessageBuffer &packet = GetReadBuffer();
    while (packet.GetActiveSize() > 0) // Loop while there's data in the buffer
    {
        if (!ProcessIncomingData()) // Process data until buffer is exhausted
            break;                  // Break if processing fails
    }

    AsyncRead(); // Queue the next async read
}
