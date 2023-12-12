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

#include "WeatherScript.h"
#include "ElunaScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnWeatherChange(Weather* weather, WeatherState state, float grade)
{
    ASSERT(weather);

    ExecuteScript<ElunaScript>([&](ElunaScript* script)
    {
        script->OnWeatherChange(weather, state, grade);
    });

    if (auto tempScript = ScriptRegistry<WeatherScript>::GetScriptById(weather->GetScriptId()))
    {
        tempScript->OnChange(weather, state, grade);
    }
}

void ScriptMgr::OnWeatherUpdate(Weather* weather, uint32 diff)
{
    ASSERT(weather);

    if (auto tempScript = ScriptRegistry<WeatherScript>::GetScriptById(weather->GetScriptId()))
    {
        tempScript->OnUpdate(weather, diff);
    }
}

WeatherScript::WeatherScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<WeatherScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<WeatherScript>;
