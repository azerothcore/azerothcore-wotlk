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

#ifndef _SCRIPT_MGR_MACRO_H_
#define _SCRIPT_MGR_MACRO_H_

#include "ScriptMgr.h"

template<typename ScriptName>
inline Optional<bool> IsValidBoolScript(std::function<bool(ScriptName*)> executeHook)
{
    if (ScriptRegistry<ScriptName>::ScriptPointerList.empty())
        return {};

    for (auto const& [scriptID, script] : ScriptRegistry<ScriptName>::ScriptPointerList)
    {
        if (executeHook(script))
            return true;
    }

    return false;
}

template<typename ScriptName, class T>
inline T* GetReturnAIScript(std::function<T*(ScriptName*)> executeHook)
{
    if (ScriptRegistry<ScriptName>::ScriptPointerList.empty())
        return nullptr;

    for (auto const& [scriptID, script] : ScriptRegistry<ScriptName>::ScriptPointerList)
    {
        if (T* scriptAI = executeHook(script))
        {
            return scriptAI;
        }
    }

    return nullptr;
}

template<typename ScriptName>
inline void ExecuteScript(std::function<void(ScriptName*)> executeHook)
{
    if (ScriptRegistry<ScriptName>::ScriptPointerList.empty())
        return;

    for (auto const& [scriptID, script] : ScriptRegistry<ScriptName>::ScriptPointerList)
    {
        executeHook(script);
    }
}

inline bool ReturnValidBool(Optional<bool> ret, bool need = false)
{
    return ret && *ret ? need : !need;
}

#define CALL_ENABLED_HOOKS(scriptType, hookType, action) \
    if (!ScriptRegistry<scriptType>::EnabledHooks[hookType].empty()) \
        for (auto const& script : ScriptRegistry<scriptType>::EnabledHooks[hookType]) { action; }

#define CALL_ENABLED_BOOLEAN_HOOKS(scriptType, hookType, action) \
    if (ScriptRegistry<scriptType>::EnabledHooks[hookType].empty()) \
        return true; \
    for (auto const& script : ScriptRegistry<scriptType>::EnabledHooks[hookType]) { if (action) return false; } \
    return true;

#endif // _SCRIPT_MGR_MACRO_H_
