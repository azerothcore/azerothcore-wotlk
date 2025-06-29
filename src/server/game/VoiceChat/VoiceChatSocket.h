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

#ifndef __VoiceChatSocket_H__
#define __VoiceChatSocket_H__

#include "Socket.h"
#include "VoiceChatDefines.h"
#include <boost/asio/ip/tcp.hpp>

using boost::asio::ip::tcp;

class VoiceChatSocket : public Socket<VoiceChatSocket> {

public:
  explicit VoiceChatSocket(tcp::socket &&socket);

  void Start() override;
  bool Update() override;
  // void SendPacket(ByteBuffer &packet);
  void SendPacket(VoiceChatServerPacket pct);

protected:
  void ReadHandler() override;

private:
  bool HandlePing();
  bool ProcessIncomingData();
  bool IsValidAndOpen() const;
  // bool HandleChannelCreated();
  // Add other handlers as needed
};

#endif
