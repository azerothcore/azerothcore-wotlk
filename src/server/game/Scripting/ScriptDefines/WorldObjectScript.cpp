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

#include "WorldObjectScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnWorldObjectDestroy(WorldObject* object)
{
    ASSERT(object);

    ExecuteScript<WorldObjectScript>([&](WorldObjectScript* script)
    {
        script->OnWorldObjectDestroy(object);
    });
}

void ScriptMgr::OnWorldObjectCreate(WorldObject* object)
{
    ASSERT(object);

    ExecuteScript<WorldObjectScript>([&](WorldObjectScript* script)
    {
        script->OnWorldObjectCreate(object);
    });
}

void ScriptMgr::OnWorldObjectSetMap(WorldObject* object, Map* map)
{
    ASSERT(object);

    ExecuteScript<WorldObjectScript>([&](WorldObjectScript* script)
    {
        script->OnWorldObjectSetMap(object, map);
    });
}

void ScriptMgr::OnWorldObjectResetMap(WorldObject* object)
{
    ASSERT(object);

    ExecuteScript<WorldObjectScript>([&](WorldObjectScript* script)
    {
        script->OnWorldObjectResetMap(object);
    });
}

void ScriptMgr::OnWorldObjectUpdate(WorldObject* object, uint32 diff)
{
    ASSERT(object);

    ExecuteScript<WorldObjectScript>([&](WorldObjectScript* script)
    {
        script->OnWorldObjectUpdate(object, diff);
    });
}

WorldObjectScript::WorldObjectScript(const char* name) : ScriptObject(name)
{
    ScriptRegistry<WorldObjectScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<WorldObjectScript>;
