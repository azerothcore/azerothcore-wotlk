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

#include "AllItemScript.h"
#include "ItemScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"
#include "ScriptedGossip.h"

bool ScriptMgr::OnQuestAccept(Player* player, Item* item, Quest const* quest)
{
    ASSERT(player);
    ASSERT(item);
    ASSERT(quest);

    auto ret = IsValidBoolScript<AllItemScript>([&](AllItemScript* script)
    {
        return !script->CanItemQuestAccept(player, item, quest);
    });

    if (ret && *ret)
    {
        return false;
    }

    auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId());
    ClearGossipMenuFor(player);
    return tempScript ? tempScript->OnQuestAccept(player, item, quest) : false;
}

bool ScriptMgr::OnItemUse(Player* player, Item* item, SpellCastTargets const& targets)
{
    ASSERT(player);
    ASSERT(item);

    auto ret = IsValidBoolScript<AllItemScript>([&](AllItemScript* script)
    {
        return script->CanItemUse(player, item, targets);
    });

    if (ret && *ret)
    {
        return true;
    }

    auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId());
    return tempScript ? tempScript->OnUse(player, item, targets) : false;
}

bool ScriptMgr::OnItemExpire(Player* player, ItemTemplate const* proto)
{
    ASSERT(player);
    ASSERT(proto);

    auto ret = IsValidBoolScript<AllItemScript>([&](AllItemScript* script)
    {
        return !script->CanItemExpire(player, proto);
    });

    if (ret && *ret)
    {
        return false;
    }

    auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(proto->ScriptId);
    return tempScript ? tempScript->OnExpire(player, proto) : false;
}

bool ScriptMgr::OnItemRemove(Player* player, Item* item)
{
    ASSERT(player);
    ASSERT(item);

    auto ret = IsValidBoolScript<AllItemScript>([&](AllItemScript* script)
    {
        return !script->CanItemRemove(player, item);
    });

    if (ret && *ret)
    {
        return false;
    }

    auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId());
    return tempScript ? tempScript->OnRemove(player, item) : false;
}

bool ScriptMgr::OnCastItemCombatSpell(Player* player, Unit* victim, SpellInfo const* spellInfo, Item* item)
{
    ASSERT(player);
    ASSERT(victim);
    ASSERT(spellInfo);
    ASSERT(item);

    auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId());
    return tempScript ? tempScript->OnCastItemCombatSpell(player, victim, spellInfo, item) : true;
}

void ScriptMgr::OnGossipSelect(Player* player, Item* item, uint32 sender, uint32 action)
{
    ASSERT(player);
    ASSERT(item);

    ExecuteScript<AllItemScript>([&](AllItemScript* script)
    {
        script->OnItemGossipSelect(player, item, sender, action);
    });

    if (auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId()))
    {
        tempScript->OnGossipSelect(player, item, sender, action);
    }
}

void ScriptMgr::OnGossipSelectCode(Player* player, Item* item, uint32 sender, uint32 action, const char* code)
{
    ASSERT(player);
    ASSERT(item);

    ExecuteScript<AllItemScript>([&](AllItemScript* script)
    {
        script->OnItemGossipSelectCode(player, item, sender, action, code);
    });

    if (auto tempScript = ScriptRegistry<ItemScript>::GetScriptById(item->GetScriptId()))
    {
        tempScript->OnGossipSelectCode(player, item, sender, action, code);
    }
}

AllItemScript::AllItemScript(const char* name) :
    ScriptObject(name)
{
    ScriptRegistry<AllItemScript>::AddScript(this);
}

ItemScript::ItemScript(const char* name) :
    ScriptObject(name)
{
    ScriptRegistry<ItemScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<AllItemScript>;
template class AC_GAME_API ScriptRegistry<ItemScript>;
