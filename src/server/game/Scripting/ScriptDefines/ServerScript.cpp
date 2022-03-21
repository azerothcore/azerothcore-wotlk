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

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnNetworkStart()
{
    ExecuteScript<ServerScript>([&](ServerScript* script)
    {
        script->OnNetworkStart();
    });
}

void ScriptMgr::OnNetworkStop()
{
    ExecuteScript<ServerScript>([&](ServerScript* script)
    {
        script->OnNetworkStop();
    });
}

void ScriptMgr::OnSocketOpen(std::shared_ptr<WorldSocket> socket)
{
    ASSERT(socket);

    ExecuteScript<ServerScript>([&](ServerScript* script)
    {
        script->OnSocketOpen(socket);
    });
}

void ScriptMgr::OnSocketClose(std::shared_ptr<WorldSocket> socket)
{
    ASSERT(socket);

    ExecuteScript<ServerScript>([&](ServerScript* script)
    {
        script->OnSocketClose(socket);
    });
}

bool ScriptMgr::CanPacketReceive(WorldSession* session, WorldPacket const& packet)
{
    if (ScriptRegistry<ServerScript>::ScriptPointerList.empty())
        return true;

    WorldPacket copy(packet);

    auto ret = IsValidBoolScript<ServerScript>([&](ServerScript* script)
    {
        return !script->CanPacketReceive(session, copy);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanPacketSend(WorldSession* session, WorldPacket const& packet)
{
    ASSERT(session);

    if (ScriptRegistry<ServerScript>::ScriptPointerList.empty())
        return true;

    WorldPacket copy(packet);

    auto ret = IsValidBoolScript<ServerScript>([&](ServerScript* script)
    {
        return !script->CanPacketSend(session, copy);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}
