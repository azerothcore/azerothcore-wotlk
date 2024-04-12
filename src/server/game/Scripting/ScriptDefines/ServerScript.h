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

#ifndef SCRIPT_OBJECT_SERVER_SCRIPT_H_
#define SCRIPT_OBJECT_SERVER_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

enum ServerHook
{
    SERVERHOOK_ON_NETWORK_START,
    SERVERHOOK_ON_NETWORK_STOP,
    SERVERHOOK_ON_SOCKET_OPEN,
    SERVERHOOK_ON_SOCKET_CLOSE,
    SERVERHOOK_CAN_PACKET_SEND,
    SERVERHOOK_CAN_PACKET_RECEIVE,
    SERVERHOOK_END
};

class ServerScript : public ScriptObject
{
protected:
    ServerScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    // Called when reactive socket I/O is started (WorldSocketMgr).
    virtual void OnNetworkStart() { }

    // Called when reactive I/O is stopped.
    virtual void OnNetworkStop() { }

    // Called when a remote socket establishes a connection to the server. Do not store the socket object.
    virtual void OnSocketOpen(std::shared_ptr<WorldSocket> /*socket*/) { }

    // Called when a socket is closed. Do not store the socket object, and do not rely on the connection
    // being open; it is not.
    virtual void OnSocketClose(std::shared_ptr<WorldSocket> /*socket*/) { }

    /**
     * @brief This hook called when a packet is sent to a client. The packet object is a copy of the original packet, so reading and modifying it is safe.
     *
     * @param session Contains information about the WorldSession
     * @param packet Contains information about the WorldPacket
     * @return True if you want to continue sending the packet, false if you want to disallow sending the packet
     */
    [[nodiscard]] virtual bool CanPacketSend(WorldSession* /*session*/, WorldPacket& /*packet*/) { return true; }

    /**
     * @brief Called when a (valid) packet is received by a client. The packet object is a copy of the original packet, so
     * reading and modifying it is safe. Make sure to check WorldSession pointer before usage, it might be null in case of auth packets
     *
     * @param session Contains information about the WorldSession
     * @param packet Contains information about the WorldPacket
     * @return True if you want to continue receive the packet, false if you want to disallow receive the packet
     */
    [[nodiscard]] virtual bool CanPacketReceive(WorldSession* /*session*/, WorldPacket& /*packet*/) { return true; }
};

#endif
