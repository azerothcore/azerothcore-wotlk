/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
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

#ifndef _SCRIPT_MGR_MACRO_H_
#define _SCRIPT_MGR_MACRO_H_

#include "Optional.h"
#include "ScriptRegistry.h"

template<typename ScriptName>
inline Optional<bool> IsValidBoolScript(std::function<bool(ScriptName*)> executeHook)
{
    if (ScriptRegistry<ScriptName>::Instance()->GetScripts().empty())
        return {};

    for (auto const& [scriptID, script] : ScriptRegistry<ScriptName>::Instance()->GetScripts())
        if (executeHook(script.get()))
            return true;

    return false;
}

template<typename ScriptName, class AI>
inline AI* GetReturnAIScript(std::function<AI*(ScriptName*)> executeHook)
{
    if (ScriptRegistry<ScriptName>::Instance()->GetScripts().empty())
        return nullptr;

    for (auto const& [scriptID, script] : ScriptRegistry<ScriptName>::Instance()->GetScripts())
        if (AI* scriptAI = executeHook(script.get()))
            return scriptAI;

    return nullptr;
}

template<typename ScriptName>
inline void ExecuteScript(std::function<void(ScriptName*)> executeHook)
{
    if (ScriptRegistry<ScriptName>::Instance()->GetScripts().empty())
        return;

    for (auto const& [scriptID, script] : ScriptRegistry<ScriptName>::Instance()->GetScripts())
        executeHook(script.get());
}

inline bool ReturnValidBool(Optional<bool> ret, bool need = false)
{
    return ret && *ret ? need : !need;
}

#endif // _SCRIPT_MGR_MACRO_H_
