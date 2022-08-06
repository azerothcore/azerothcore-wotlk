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

// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com

#include "Errors.h"
#include "IoContext.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"
#include "ScriptObject.h"
#include "WorldPacket.h"

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
    ASSERT(session);

    if (ScriptRegistry<ServerScript>::Instance()->GetScripts().empty())
        return true;

    WorldPacket copy(packet);

    auto ret = IsValidBoolScript<ServerScript>([&](ServerScript* script)
    {
        return !script->CanPacketReceive(session, copy);
    });

    return ReturnValidBool(ret);
}

bool ScriptMgr::CanPacketSend(WorldSession* session, WorldPacket const& packet)
{
    ASSERT(session);

    if (ScriptRegistry<ServerScript>::Instance()->GetScripts().empty())
        return true;

    WorldPacket copy(packet);

    auto ret = IsValidBoolScript<ServerScript>([&](ServerScript* script)
    {
        return !script->CanPacketSend(session, copy);
    });

    return ReturnValidBool(ret);
}
