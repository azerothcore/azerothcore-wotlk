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

#ifndef _INTERNAL_SESSION_H_
#define _INTERNAL_SESSION_H_

#include "ByteBuffer.h"
#include "TcpSocket.h"
#include <boost/asio/ip/tcp.hpp>

class VoiceChatServerPacket;

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

    void SendPacket(VoiceChatServerPacket const& packet);

    void HandlePing(VoiceChatServerPacket& packet);
    void HandleCreateVoiceSession(VoiceChatServerPacket& packet);
    void HandleDeleteVoiceSession(VoiceChatServerPacket& packet);
    void HandleAddMember(VoiceChatServerPacket& packet);
    void HandleRemoveMember(VoiceChatServerPacket& packet);
    void HandleVoiceMember(VoiceChatServerPacket& packet);
    void HandleDevoiceMember(VoiceChatServerPacket& packet);
    void HandleMuteMember(VoiceChatServerPacket& packet);
    void HandleUnmuteMember(VoiceChatServerPacket& packet);

protected:
    bool ReadHeaderHandler();
    ReadDataHandlerResult ReadDataHandler();
};

#endif
