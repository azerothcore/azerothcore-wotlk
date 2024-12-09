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

#include "ServerScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnNetworkStart()
{
    CALL_ENABLED_HOOKS(ServerScript, SERVERHOOK_ON_NETWORK_START, script->OnNetworkStart());
}

void ScriptMgr::OnNetworkStop()
{
    CALL_ENABLED_HOOKS(ServerScript, SERVERHOOK_ON_NETWORK_STOP, script->OnNetworkStop());
}

void ScriptMgr::OnSocketOpen(std::shared_ptr<WorldSocket> socket)
{
    ASSERT(socket);

    CALL_ENABLED_HOOKS(ServerScript, SERVERHOOK_ON_SOCKET_OPEN, script->OnSocketOpen(socket));
}

void ScriptMgr::OnSocketClose(std::shared_ptr<WorldSocket> socket)
{
    ASSERT(socket);

    CALL_ENABLED_HOOKS(ServerScript, SERVERHOOK_ON_SOCKET_CLOSE, script->OnSocketClose(socket));
}

void ScriptMgr::OnPacketReceived(WorldSession* session, WorldPacket const& packet)
{
    WorldPacket copy(packet);
    ExecuteScript<ServerScript>([&](ServerScript* script)
    {
        script->OnPacketReceived(session, copy);
    });
}

bool ScriptMgr::CanPacketSend(WorldSession* session, WorldPacket const& packet)
{
    ASSERT(session);

    if (ScriptRegistry<ServerScript>::ScriptPointerList.empty())
        return true;

    WorldPacket copy(packet);

    CALL_ENABLED_BOOLEAN_HOOKS(ServerScript, SERVERHOOK_CAN_PACKET_SEND, !script->CanPacketSend(session, copy));
}

bool ScriptMgr::CanPacketReceive(WorldSession* session, WorldPacket const& packet)
{
    if (ScriptRegistry<ServerScript>::ScriptPointerList.empty())
        return true;

    WorldPacket copy(packet);

    CALL_ENABLED_BOOLEAN_HOOKS(ServerScript, SERVERHOOK_CAN_PACKET_RECEIVE, !script->CanPacketReceive(session, copy));
}

ServerScript::ServerScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, SERVERHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < SERVERHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<ServerScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<ServerScript>;
