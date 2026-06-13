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

#include "InstanceMapScript.h"
#include "ScriptMgr.h"

InstanceScript* ScriptMgr::CreateInstanceScript(InstanceMap* map)
{
    ASSERT(map);

    auto tempScript = ScriptRegistry<InstanceMapScript>::GetScriptById(map->GetScriptId());
    return tempScript ? tempScript->GetInstanceScript(map) : nullptr;
}

InstanceMapScript::InstanceMapScript(const char* name, uint32 mapId) :
    ScriptObject(name), MapScript<InstanceMap>(mapId)
{
    ScriptRegistry<InstanceMapScript>::AddScript(this);
}

void InstanceMapScript::checkValidity()
{
    checkMap();

    if (GetEntry() && !GetEntry()->IsDungeon())
    {
        LOG_ERROR("maps.script", "InstanceMapScript for map {} is invalid.", GetEntry()->MapID);
    }
}

template class AC_GAME_API ScriptRegistry<InstanceMapScript>;
