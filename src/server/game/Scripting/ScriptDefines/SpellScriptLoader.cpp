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

#include "SpellScriptLoader.h"
#include "ScriptMgr.h"
#include "SpellScript.h"

void ScriptMgr::CreateSpellScripts(uint32 spellId, std::list<SpellScript*>& scriptVector)
{
    SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spellId);

    for (SpellScriptsContainer::iterator itr = bounds.first; itr != bounds.second; ++itr)
    {
        SpellScriptLoader* tempScript = ScriptRegistry<SpellScriptLoader>::GetScriptById(itr->second);
        if (!tempScript)
            continue;

        SpellScript* script = tempScript->GetSpellScript();

        if (!script)
            continue;

        script->_Init(&tempScript->GetName(), spellId);

        scriptVector.push_back(script);
    }
}

void ScriptMgr::CreateAuraScripts(uint32 spellId, std::list<AuraScript*>& scriptVector)
{
    SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spellId);

    for (SpellScriptsContainer::iterator itr = bounds.first; itr != bounds.second; ++itr)
    {
        SpellScriptLoader* tempScript = ScriptRegistry<SpellScriptLoader>::GetScriptById(itr->second);
        if (!tempScript)
            continue;

        AuraScript* script = tempScript->GetAuraScript();

        if (!script)
            continue;

        script->_Init(&tempScript->GetName(), spellId);

        scriptVector.push_back(script);
    }
}

void ScriptMgr::CreateSpellScriptLoaders(uint32 spellId, std::vector<std::pair<SpellScriptLoader*, SpellScriptsContainer::iterator>>& scriptVector)
{
    SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spellId);
    scriptVector.reserve(std::distance(bounds.first, bounds.second));

    for (SpellScriptsContainer::iterator itr = bounds.first; itr != bounds.second; ++itr)
    {
        SpellScriptLoader* tempScript = ScriptRegistry<SpellScriptLoader>::GetScriptById(itr->second);
        if (!tempScript)
            continue;

        scriptVector.emplace_back(tempScript, itr);
    }
}

SpellScriptLoader::SpellScriptLoader(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<SpellScriptLoader>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<SpellScriptLoader>;
