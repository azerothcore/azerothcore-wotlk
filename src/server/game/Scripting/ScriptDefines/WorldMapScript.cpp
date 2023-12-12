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

#include "WorldMapScript.h"
#include "Log.h"
#include "ScriptMgr.h"

WorldMapScript::WorldMapScript(const char* name, uint32 mapId) :
    ScriptObject(name), MapScript<Map>(mapId)
{
    ScriptRegistry<WorldMapScript>::AddScript(this);
}

void WorldMapScript::checkValidity()
{
    checkMap();

    if (GetEntry() && !GetEntry()->IsWorldMap())
    {
        LOG_ERROR("maps.script", "WorldMapScript for map {} is invalid.", GetEntry()->MapID);
    }
}

template class AC_GAME_API ScriptRegistry<WorldMapScript>;
