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

#ifndef _WOWCONNECTION_H_
#define _WOWCONNECTION_H_

#include "AuthCrypt.h"
#include "Common.h"
#include "MPSCQueue.h"
#include "ServerPktHeader.h"
#include "Socket.h"
#include "Util.h"
#include "WDataStore.h"
#include "User.h"
#include <boost/asio/ip/tcp.hpp>

using boost::asio::ip::tcp;

typedef void(*MSGHANDLER) (User*        user,
                           NETMESSAGE   msgId,
                           uint32_t     eventTime,
                           WDataStore*  msg);

class EncryptableAndCompressiblePacket : public WDataStore
{
public:
    EncryptableAndCompressiblePacket(WDataStore const& packet, bool encrypt) : WDataStore(packet), _encrypt(encrypt)
    {
        SocketQueueLink.store(nullptr, std::memory_order_relaxed);
    }

    bool NeedsEncryption() const { return _encrypt; }

    bool NeedsCompression() const { return GetOpcode() == SMSG_UPDATE_OBJECT && size() > 100; }

    void CompressIfNeeded();

    std::atomic<EncryptableAndCompressiblePacket*> SocketQueueLink;

private:
    bool _encrypt;
};

namespace WorldPackets
{
    class ServerPacket;
}

#pragma pack(push, 1)
struct ClientPktHeader
{
    uint16 size;
    uint32 cmd;

    bool IsValidSize() const { return size >= 4 && size < 10240; }
    bool IsValidOpcode() const { return cmd < NUM_OPCODE_HANDLERS; }
};
#pragma pack(pop)

struct AuthSession;

class AC_GAME_API WowConnection : public Socket<WowConnection>
{
    typedef Socket<WowConnection> BaseSocket;

public:
    WowConnection(tcp::socket&& socket);
    ~WowConnection();

    WowConnection(WowConnection const& right) = delete;
    WowConnection& operator=(WowConnection const& right) = delete;

    void Start() override;
    bool Update() override;

    void SendPacket(WDataStore const& packet);

    void SetSendBufferSize(std::size_t sendBufferSize) { _sendBufferSize = sendBufferSize; }

    static int SetMessageHandler(NETMESSAGE msgId, MSGHANDLER handler);
    static int ClearMessageHandler(NETMESSAGE msgId);

    static std::map<NETMESSAGE, MSGHANDLER> m_handlers;

protected:
    void OnClose() override;
    void ReadHandler() override;
    bool ReadHeaderHandler();

    enum class ReadDataHandlerResult
    {
        Ok = 0,
        Error = 1,
        WaitingForQuery = 2
    };

    ReadDataHandlerResult ReadDataHandler();

private:
    void CheckIpCallback(PreparedQueryResult result);

    /// writes network.opcode log
    /// accessing User is not threadsafe, only do it when holding _worldSessionLock
    void LogOpcodeText(OpcodeClient opcode, std::unique_lock<std::mutex> const& guard) const;

    /// sends and logs network.opcode without accessing User
    void SendPacketAndLogOpcode(WDataStore const& packet);
    void HandleSendAuthSession();
    void HandleAuthSession(WDataStore& recvPacket);
    void HandleAuthSessionCallback(std::shared_ptr<AuthSession> authSession, PreparedQueryResult result);
    void LoadSessionPermissionsCallback(PreparedQueryResult result);
    void SendAuthResponseError(uint8 code);

    bool HandlePing(WDataStore& recvPacket);

    std::array<uint8, 4> _authSeed;
    AuthCrypt _authCrypt;

    TimePoint _LastPingTime;
    uint32 _OverSpeedPings;

    std::mutex _worldSessionLock;
    User* _worldSession;
    bool _authed;

    MessageBuffer _headerBuffer;
    MessageBuffer _packetBuffer;
    MPSCQueue<EncryptableAndCompressiblePacket, &EncryptableAndCompressiblePacket::SocketQueueLink> _bufferQueue;
    std::size_t _sendBufferSize;

    QueryCallbackProcessor _queryProcessor;
    std::string _ipCountry;
};

#endif
