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

    CALL_ENABLED_HOOKS(WorldObjectScript, WORLDOBJECTHOOK_ON_WORLD_OBJECT_DESTROY, script->OnWorldObjectDestroy(object));
}

void ScriptMgr::OnWorldObjectCreate(WorldObject* object)
{
    ASSERT(object);

    CALL_ENABLED_HOOKS(WorldObjectScript, WORLDOBJECTHOOK_ON_WORLD_OBJECT_CREATE, script->OnWorldObjectCreate(object));
}

void ScriptMgr::OnWorldObjectSetMap(WorldObject* object, Map* map)
{
    ASSERT(object);

    CALL_ENABLED_HOOKS(WorldObjectScript, WORLDOBJECTHOOK_ON_WORLD_OBJECT_SET_MAP, script->OnWorldObjectSetMap(object, map));
}

void ScriptMgr::OnWorldObjectResetMap(WorldObject* object)
{
    ASSERT(object);

    CALL_ENABLED_HOOKS(WorldObjectScript, WORLDOBJECTHOOK_ON_WORLD_OBJECT_RESET_MAP, script->OnWorldObjectResetMap(object));
}

void ScriptMgr::OnWorldObjectUpdate(WorldObject* object, uint32 diff)
{
    ASSERT(object);

    CALL_ENABLED_HOOKS(WorldObjectScript, WORLDOBJECTHOOK_ON_WORLD_OBJECT_UPDATE, script->OnWorldObjectUpdate(object, diff));
}

WorldObjectScript::WorldObjectScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, WORLDOBJECTHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < WORLDOBJECTHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<WorldObjectScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<WorldObjectScript>;
