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

#include "ConditionScript.h"
#include "ScriptMgr.h"

bool ScriptMgr::OnConditionCheck(Condition* condition, ConditionSourceInfo& sourceInfo)
{
    ASSERT(condition);

    auto tempScript = ScriptRegistry<ConditionScript>::GetScriptById(condition->ScriptId);
    return tempScript ? tempScript->OnConditionCheck(condition, sourceInfo) : true;
}

ConditionScript::ConditionScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<ConditionScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<ConditionScript>;
