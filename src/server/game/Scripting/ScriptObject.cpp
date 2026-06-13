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

#include "ScriptObject.h"
#include "DBCStores.h"
#include "Log.h"

//ScriptObject::ScriptObject(char const* name) : _name(name)
//{
//    sScriptMgr->IncreaseScriptCount();
//}
//
//ScriptObject::~ScriptObject()
//{
//    sScriptMgr->DecreaseScriptCount();
//}

template<class TMap>
void MapScript<TMap>::checkMap()
{
    _mapEntry = sMapStore.LookupEntry(_mapId);

    if (!_mapEntry)
        LOG_ERROR("maps.script", "Invalid MapScript for {}; no such map ID.", _mapId);
}

template class AC_GAME_API MapScript<Map>;
template class AC_GAME_API MapScript<InstanceMap>;
template class AC_GAME_API MapScript<BattlegroundMap>;
