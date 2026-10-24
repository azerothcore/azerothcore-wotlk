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

#ifndef _INTERNAL_SESSION_H_
#define _INTERNAL_SESSION_H_

#include "ByteBuffer.h"
#include "LockedQueue.h"
#include "TcpSocket.h"
#include "VoiceChatSharedDefines.h"
#include "VoiceWorldLink.h"
#include <boost/asio/ip/tcp.hpp>
#include <memory>
#include <string>

using boost::asio::ip::tcp;

// A connection from a worldserver
class InternalSession : public TcpSocket<InternalSession>
{
    typedef TcpSocket<InternalSession> InternalSocket;

public:
    InternalSession(IoContextTcpSocket&& socket);

    void Start() override;
    void OnClose() override;
    bool Update() override;

    // identifies this connection, its voice channels are kept apart from those
    // of other worldservers sharing the voiceserver
    VoiceWorldLink GetWorldLink() { return VoiceWorldLink(weak_from_this(), _worldId); }

    // network thread only
    void SendPacket(VoiceChatServerPacket const& packet);
    // thread-safe, the message is sent from the network thread. Returns false if
    // it does not fit an internal packet.
    bool QueueModuleMessage(std::string const& tag, ByteBuffer const& data);

    void HandlePing(VoiceChatServerPacket& packet);
    void HandleCreateVoiceSession(VoiceChatServerPacket& packet);
    void HandleDeleteVoiceSession(VoiceChatServerPacket& packet);
    void HandleAddMember(VoiceChatServerPacket& packet);
    void HandleRemoveMember(VoiceChatServerPacket& packet);
    void HandleVoiceMember(VoiceChatServerPacket& packet);
    void HandleDevoiceMember(VoiceChatServerPacket& packet);
    void HandleMuteMember(VoiceChatServerPacket& packet);
    void HandleUnmuteMember(VoiceChatServerPacket& packet);
    void HandleModuleMessage(VoiceChatServerPacket& packet);

protected:
    bool ReadHeaderHandler() override;
    ReadDataHandlerResult ReadDataHandler() override;

private:
    uint32 const _worldId;
    // packets queued from other threads, sent by Update()
    LockedQueue<std::unique_ptr<VoiceChatServerPacket>> _queuedPackets;
    // network thread only
    uint32 _lastPacketReceiveTime;
};

#endif
