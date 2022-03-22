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

void ScriptMgr::OnGameEventStart(uint16 EventID)
{
    ExecuteScript<GameEventScript>([&](GameEventScript* script)
    {
        script->OnStart(EventID);
    });
}

void ScriptMgr::OnGameEventStop(uint16 EventID)
{
    ExecuteScript<GameEventScript>([&](GameEventScript* script)
    {
        script->OnStop(EventID);
    });
}

void ScriptMgr::OnGameEventCheck(uint16 EventID)
{
    ExecuteScript<GameEventScript>([&](GameEventScript* script)
    {
        script->OnEventCheck(EventID);
    });
}
