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

// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com

#include "ScriptMgr.h"
#include "ScriptObject.h"
#include "ScriptRegistry.h"
#include "SpellScript.h"

template<typename T, typename F, typename O>
void CreateSpellOrAuraScripts(uint32 spellId, std::vector<T*>& scriptVector, F&& extractor, O* objectInvoker)
{
    SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spellId);
    for (auto itr = bounds.first; itr != bounds.second; ++itr)
    {
        // When the script is disabled continue with the next one
        if (!itr->second.second)
            continue;

        SpellScriptLoader* tmpscript = sScriptMgr->GetSpellScriptLoader(itr->second.first);
        if (!tmpscript)
            continue;

        T* script = (*tmpscript.*extractor)();
        if (!script)
            continue;

        script->_Init(tmpscript->GetName(), spellId);
        if (!script->_Load(objectInvoker))
        {
            delete script;
            continue;
        }

        scriptVector.emplace_back(script);
    }
}

void ScriptMgr::CreateSpellScripts(uint32 spellId, std::vector<SpellScript*>& scriptVector, Spell* invoker) const
{
    CreateSpellOrAuraScripts(spellId, scriptVector, &SpellScriptLoader::GetSpellScript, invoker);
}

void ScriptMgr::CreateAuraScripts(uint32 spellId, std::vector<AuraScript*>& scriptVector, Aura* invoker) const
{
    CreateSpellOrAuraScripts(spellId, scriptVector, &SpellScriptLoader::GetAuraScript, invoker);
}

SpellScriptLoader* ScriptMgr::GetSpellScriptLoader(uint32 scriptId)
{
    return ScriptRegistry<SpellScriptLoader>::Instance()->GetScriptById(scriptId);
}
