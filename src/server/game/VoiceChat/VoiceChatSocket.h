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

#ifndef __VoiceChatSocket_H__
#define __VoiceChatSocket_H__

#include "TcpSocket.h"
#include "VoiceChatSharedDefines.h"
#include <atomic>
#include <boost/asio/ip/tcp.hpp>
#include <mutex>
#include <queue>

using boost::asio::ip::tcp;

// Connection of the worldserver to the voiceserver
class VoiceChatSocket : public TcpSocket<VoiceChatSocket>
{
public:
    explicit VoiceChatSocket(IoContextTcpSocket&& socket);

    void Start() override;
    bool Update() override;
    // thread safe, may be called from the world thread
    void SendPacket(VoiceChatServerPacket const& pkt);

    uint32 GetLastPacketReceiveTime() const { return _lastPacketReceiveTime.load(); }

protected:
    bool ReadHeaderHandler() override;
    ReadDataHandlerResult ReadDataHandler() override;

private:
    std::atomic<uint32> _lastPacketReceiveTime;

    // packets queued by the world thread, written on the network thread
    std::mutex _sendQueueLock;
    std::queue<MessageBuffer> _sendQueue;
};

#endif
