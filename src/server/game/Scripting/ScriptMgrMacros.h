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

template<typename ScriptName, typename TCallBack>
inline bool GetReturnBoolScripts(bool ret, TCallBack&& callback)
{
    if (ScriptRegistry<ScriptName>::ScriptPointerList.empty())
        return ret;

    bool needReturn = !ret;

    for (auto const& [scriptID, script] : ScriptRegistry<ScriptName>::ScriptPointerList)
    {
        if (callback(script))
            return needReturn;
    }

    return ret;
}

template<class ScriptName, class T, typename TCallBack>
inline void GetReturnIndexScripts([[maybe_unused]] T* ret, TCallBack&& callback)
{
    if (ScriptRegistry<ScriptName>::ScriptPointerList.empty())
        return;

    for (auto const& [scriptID, script] : ScriptRegistry<ScriptName>::ScriptPointerList)
    {
        if (T* scriptAI = callback(script))
        {
            ret = scriptAI;
            break;
        }
    }
}

// Utility macros to refer to the script registry.
#define SCR_REG_MAP(T) ScriptRegistry<T>::ScriptMap
#define SCR_REG_ITR(T) ScriptRegistry<T>::ScriptMapIterator
#define SCR_REG_LST(T) ScriptRegistry<T>::ScriptPointerList

// Utility macros for looping over scripts.
#define FOR_SCRIPTS(T, C, E) \
    if (!SCR_REG_LST(T).empty()) \
        for (SCR_REG_ITR(T) C = SCR_REG_LST(T).begin(); \
            C != SCR_REG_LST(T).end(); ++C)

#define FOR_SCRIPTS_RET(T, C, E, R) \
    if (SCR_REG_LST(T).empty()) \
        return R; \
    for (SCR_REG_ITR(T) C = SCR_REG_LST(T).begin(); \
        C != SCR_REG_LST(T).end(); ++C)

#define FOREACH_SCRIPT(T) \
    FOR_SCRIPTS(T, itr, end) \
    itr->second

// Utility macros for finding specific scripts.
#define GET_SCRIPT(T, I, V) \
    T* V = ScriptRegistry<T>::GetScriptById(I); \
    if (!V) \
        return;

#define GET_SCRIPT_RET(T, I, V, R) \
    T* V = ScriptRegistry<T>::GetScriptById(I); \
    if (!V) \
        return R;

#endif // _SCRIPT_MGR_MACRO_H_
