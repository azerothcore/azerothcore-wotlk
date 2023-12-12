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

#include "TransportScript.h"
#include "ScriptMgr.h"
#include "Transport.h"

void ScriptMgr::OnAddPassenger(Transport* transport, Player* player)
{
    ASSERT(transport);
    ASSERT(player);

    if (auto tempScript = ScriptRegistry<TransportScript>::GetScriptById(transport->GetScriptId()))
    {
        tempScript->OnAddPassenger(transport, player);
    }
}

void ScriptMgr::OnAddCreaturePassenger(Transport* transport, Creature* creature)
{
    ASSERT(transport);
    ASSERT(creature);

    if (auto tempScript = ScriptRegistry<TransportScript>::GetScriptById(transport->GetScriptId()))
    {
        tempScript->OnAddCreaturePassenger(transport, creature);
    }
}

void ScriptMgr::OnRemovePassenger(Transport* transport, Player* player)
{
    ASSERT(transport);
    ASSERT(player);

    if (auto tempScript = ScriptRegistry<TransportScript>::GetScriptById(transport->GetScriptId()))
    {
        tempScript->OnRemovePassenger(transport, player);
    }
}

void ScriptMgr::OnTransportUpdate(Transport* transport, uint32 diff)
{
    ASSERT(transport);

    if (auto tempScript = ScriptRegistry<TransportScript>::GetScriptById(transport->GetScriptId()))
    {
        tempScript->OnUpdate(transport, diff);
    }
}

void ScriptMgr::OnRelocate(Transport* transport, uint32 waypointId, uint32 mapId, float x, float y, float z)
{
    if (auto tempScript = ScriptRegistry<TransportScript>::GetScriptById(transport->GetScriptId()))
    {
        tempScript->OnRelocate(transport, waypointId, mapId, x, y, z);
    }
}

TransportScript::TransportScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<TransportScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<TransportScript>;
